using MyORM;

namespace HttpServer.Models;

public class Session : RepoTable
{
    [PrimaryKey]
    public int Id { get; set; }
    
    [Column("userid")]
    public int UserId { get; set; }
    
    [Column("expiresAt")]
    public DateTime ExpiresAt { get; set; }
}