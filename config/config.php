<?php

$pass = getenv('DB_PASS');

return [
    'db' => [
        'host'    => getenv('DB_HOST') ?: '127.0.0.1',
        'port'    => getenv('DB_PORT') ?: '3306',
        'name'    => getenv('DB_NAME') ?: 'art_of_tea',
        'user'    => getenv('DB_USER') ?: 'root',
        'pass'    => $pass !== false ? $pass : '',
        'charset' => 'utf8mb4',
    ],
];
