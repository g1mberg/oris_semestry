using System.Text.Json;
using MyORM;
using static HttpServer.Framework.Utils.DateNaming;

namespace HttpServer.Models;

public class TourCard : RepoTable
{
    [PrimaryKey]
    public int Id { get; set; }

    [Column("name")]
    public string? Name { get; set; }
    
    [Column("description")]
    public string? Description { get; set; }

    [Column("datestart")]
    public DateTime DateStart { get; set; }

    [Column("dateend")]
    public DateTime DateEnd { get; set; }

    [Column("origin")]
    public string? From { get; set; }

    [Column("status")]
    public string? Status { get; set; }

    [Column("regular_cost")]
    public decimal Cost { get; set; }
    
    [Column("commercial_cost")]
    public decimal CommercialCost { get; set; }
    
    [Column("people")]
    public int People { get; set; }

    [Column("img")]
    public string? Img { get; set; }

    [Column("tags")]
    public string? Tags { get; set; }
    
    [Column("destination")]
    public string? Destination { get; set; }

    public decimal ForOneRegular => Cost * People;
    public decimal ForOneCommercial => CommercialCost * People;

    public List<string>? searilezedTags => Tags != null ? JsonSerializer.Deserialize<List<string>>(Tags) : [];

    private string PortDate => DateStart.DayOfYear.Equals(DateEnd.DayOfYear)
        ? "Dia " + GetPortDate(DateStart)
        : "De " + GetPortDate(DateStart) + " a " + GetPortDate(DateEnd); 

    public string Html => $"<li class=\"card\">" +
                          $"<a href=\"/turismo/tour?id={Id}\" class=\"no-underline\">" +
                          $"<img src=\"{Img}\" alt=\"Imagem 1\">" +
                          $"<div class=\"card-content\">" +
                          $"<h3>{Name}</h3>" +
                          $"<p>{PortDate} de {DateStart.Year}\n<br>Saída de <strong>{From}</strong></p>" +
                          $"<p>A partir de {People}x <strong>R$ {Cost}/pessoa</strong></p>" +
                          $"</div>" +
                          $"</a>" +
                          $"</li>";
    
    public static void ReadJson(string json, TourCard tour)
    {
        using var doc = JsonDocument.Parse(json);
        var root = doc.RootElement.GetProperty("changes");
        if(root.TryGetProperty("tour-title", out var name)) 
            tour.Name = name.GetString();
        if(root.TryGetProperty("tour-desc", out var desc)) 
            tour.Description = desc.GetString();
        if(root.TryGetProperty("price-2", out var rCost)) 
            tour.Cost = decimal.Parse(rCost.GetString()!);
        if (root.TryGetProperty("price-1", out var cCost))
            tour.CommercialCost = decimal.Parse(cCost.GetString()!);
    }
}