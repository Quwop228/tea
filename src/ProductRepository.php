<?php

require_once __DIR__ . '/FullTextQuery.php';

class ProductRepository
{
    use FullTextQuery;

    private $pdo;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    public function search(string $query, int $limit = 3): array
    {
        $limit = max(1, $limit);
        $boolean = $this->booleanQuery($query);

        if ($boolean !== '') {
            $sql = "SELECT id, name, emoji, description, price, currency, url, image,
                           MATCH(name, description) AGAINST (:nat IN NATURAL LANGUAGE MODE) AS relevance
                    FROM products
                    WHERE MATCH(name, description) AGAINST (:bool IN BOOLEAN MODE)
                    ORDER BY relevance DESC, id ASC
                    LIMIT {$limit}";
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute([':nat' => $query, ':bool' => $boolean]);
            $rows = $stmt->fetchAll();
            if ($rows) {
                return $rows;
            }
        }

        return $this->likeFallback($query, $limit);
    }

    private function likeFallback(string $query, int $limit): array
    {

        $sql = "SELECT id, name, emoji, description, price, currency, url, image
                FROM products
                WHERE name LIKE :q1 OR description LIKE :q2
                ORDER BY id ASC
                LIMIT {$limit}";
        $like = '%' . $query . '%';
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([':q1' => $like, ':q2' => $like]);
        return $stmt->fetchAll();
    }
}
