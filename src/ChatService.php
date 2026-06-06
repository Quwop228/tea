<?php

class ChatService
{

    private $products;

    private $articles;

    public function __construct(ProductRepository $products, ArticleRepository $articles)
    {
        $this->products = $products;
        $this->articles = $articles;
    }

    public function respond(string $query): array
    {
        $query = trim($query);

        if ($this->wordCount($query) <= 2) {
            $items = $this->products->search($query, 3);
            if ($items) {
                return ['type' => 'products', 'products' => $this->formatProducts($items)];
            }

            $article = $this->articles->searchOne($query);
            if ($article) {
                return ['type' => 'text', 'content' => $article['content']];
            }
            return $this->notFound();
        }

        $article = $this->articles->searchOne($query);
        if ($article) {
            return ['type' => 'text', 'content' => $article['content']];
        }

        $items = $this->products->search($query, 3);
        if ($items) {
            return ['type' => 'products', 'products' => $this->formatProducts($items)];
        }

        return $this->notFound();
    }

    private function wordCount(string $query): int
    {
        if ($query === '') {
            return 0;
        }
        $words = preg_split('/\s+/u', $query, -1, PREG_SPLIT_NO_EMPTY) ?: [];
        return count($words);
    }

    private function formatProducts(array $rows): array
    {
        $result = [];
        $number = 1;
        foreach ($rows as $row) {
            $result[] = [
                'number'      => $number++,
                'id'          => (string) $row['id'],
                'name'        => $row['name'],
                'emoji'       => $row['emoji'],
                'description' => $row['description'],
                'price'       => $this->formatPrice($row['price'], $row['currency']),
                'url'         => $row['url'],
                'image'       => $row['image'],
            ];
        }
        return $result;
    }

    private function formatPrice($price, string $currency): string
    {

        return number_format((float) $price, 0, '.', ' ') . ' ' . $currency;
    }

    private function notFound(): array
    {
        return [
            'type'    => 'text',
            'content' => 'К сожалению, я ничего не нашёл по вашему запросу. Попробуйте переформулировать его или выберите одну из подсказок. 🍵',
        ];
    }
}
