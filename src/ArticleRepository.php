<?php

require_once __DIR__ . '/FullTextQuery.php';

class ArticleRepository
{
    use FullTextQuery;

    private $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function searchOne(string $query): ?array
    {
        $boolean = $this->booleanQuery($query);

        if ($boolean !== '') {
            $sql = "SELECT id, title, content,
                           MATCH(title, content) AGAINST (:nat IN NATURAL LANGUAGE MODE) AS relevance
                    FROM articles
                    WHERE MATCH(title, content) AGAINST (:bool IN BOOLEAN MODE)
                    ORDER BY relevance DESC, id ASC
                    LIMIT 1";
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute([':nat' => $query, ':bool' => $boolean]);
            $row = $stmt->fetch();
            if ($row) {
                return $row;
            }
        }

        $sql = "SELECT id, title, content
                FROM articles
                WHERE title LIKE :q1 OR content LIKE :q2
                ORDER BY id ASC
                LIMIT 1";
        $like = '%' . $query . '%';
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([':q1' => $like, ':q2' => $like]);
        $row = $stmt->fetch();

        return $row ?: null;
    }
}
