using System.Text;

namespace MiniTemplateEngine.Parsing;

/// <summary>Рекурсивный парсер шаблона в AST</summary>
internal sealed class Parser
{
    private readonly string _src;
    private int _pos;

    private Parser(string src)
    {
        _src = src;
        _pos = 0;
    }

    /// <summary>Точка входа</summary>
    public static List<Node> Parse(string src)
    {
        return new Parser(src).ParseBlock(null);
    }
    
    private List<Node> ParseBlock(string? stopToken)
    {
        var nodes = new List<Node>();
        while (!Eof())
        {
            if (Peek("$else") && stopToken == "$endif") break;
            if (Peek("$endif") && (stopToken == "$endif" || stopToken == null)) break;
            if (Peek("$endfor") && (stopToken == "$endfor" || stopToken == null)) break;

            if (Peek("${"))
                nodes.Add(ParseVar());
            else if (Peek("$if("))
                nodes.Add(ParseIf());
            else if (Peek("$foreach("))
                nodes.Add(ParseFor());
            else
                nodes.Add(ParseText(stopToken));
        }
        return nodes;
    }
    

    private VarNode ParseVar()
    {
        if (Peek("${"))
        {
            Expect("${");
            var expr = ReadUntil('}').Trim();
            Expect("}");
            return new VarNode(expr);
        }
        
        Expect("$(");
        var expr2 = ReadUntil(')').Trim();
        Expect(")");
        return new VarNode(expr2);
    }

    private IfNode ParseIf()
    {
        Expect("$if(");
        var cond = ReadUntil(')').Trim();
        Expect(")");

        var thenPart = ParseBlock("$endif");
        List<Node>? elsePart = null;
        
        if (Peek("$else"))
        {
            Expect("$else");
            elsePart = ParseBlock("$endif");
        }

        Expect("$endif");
        return new IfNode(cond, thenPart, elsePart);
    }

    private ForEachNode ParseFor()
    {
        
        Expect("$foreach(");
        var inside = ReadUntil(')');
        Expect(")");
  
        var sig = inside.Trim();
        if (sig.StartsWith("var ", StringComparison.Ordinal))
            sig = sig.Substring(4);

        var parts = sig.Split(new[] { " in " }, StringSplitOptions.RemoveEmptyEntries);
        if (parts.Length != 2) throw new Exception("Malformed foreach header. Use: $foreach(var item in object.Items)");
        
        var item = parts[0].Trim();
        var srcExpr = parts[1].Trim();

        var body = ParseBlock("$endfor");
        Expect("$endfor");
        return new ForEachNode(item, srcExpr, body);
    }
    
    
    private TextNode ParseText(string? stopToken)
    {
        var sb = new StringBuilder();
        while (!Eof())
        {
            if (Peek("${") || Peek("$if(") || Peek("$foreach(")) break;
            
            if (stopToken != null && Peek(stopToken)) break;
            
            if (stopToken == "$endif" && Peek("$else")) break;

            sb.Append(_src[_pos]);
            _pos++;
        }

        return new TextNode(sb.ToString());
    }

    private bool Eof() =>_pos >= _src.Length;

    private bool Peek(string s)
    {
        if (_pos + s.Length > _src.Length) return false;
        return !s.Where((t, i) => _src[_pos + i] != t).Any();
    }

    private void Expect(string s)
    {
        if (!Peek(s)) throw new Exception($"Expected '{s}' at {_pos}");
        _pos += s.Length;
    }

    private string ReadUntil(char end)
    {
        var start = _pos;
        while (!Eof() && _src[_pos] != end) _pos++;
        return _src.Substring(start, _pos - start);
    }
}