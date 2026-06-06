<?php

declare(strict_types=1);

header('Content-Type: application/json; charset=utf-8');

require __DIR__ . '/../../src/Database.php';
require __DIR__ . '/../../src/FullTextQuery.php';
require __DIR__ . '/../../src/ProductRepository.php';
require __DIR__ . '/../../src/ArticleRepository.php';
require __DIR__ . '/../../src/ChatService.php';

function send_json(array $payload, int $status = 200): void
{
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    send_json(['type' => 'text', 'content' => 'Метод не поддерживается.'], 405);
}

$query = '';
if (isset($_POST['query'])) {
    $query = (string) $_POST['query'];
} else {
    $raw = file_get_contents('php://input');
    if ($raw !== false && $raw !== '') {
        $decoded = json_decode($raw, true);
        if (is_array($decoded) && isset($decoded['query'])) {
            $query = (string) $decoded['query'];
        }
    }
}

$query = trim($query);

$query = mb_substr($query, 0, 500);

if ($query === '') {
    send_json(['type' => 'text', 'content' => 'Пожалуйста, введите запрос.']);
}

try {
    $pdo = Database::connection();
    $service = new ChatService(
        new ProductRepository($pdo),
        new ArticleRepository($pdo)
    );
    $response = $service->respond($query);
} catch (Throwable $e) {
    send_json(['type' => 'text', 'content' => 'Произошла ошибка на сервере. Попробуйте позже.'], 500);
}

send_json($response);
