<?php
declare(strict_types=1);

$host = getenv('MAT_DB_HOST') ?: '127.0.0.1';
$db = getenv('MAT_DB_NAME') ?: 'mat_db';
$user = getenv('MAT_DB_USER') ?: 'root';
$pass = getenv('MAT_DB_PASS') ?: '';

try {
    $pdo = new PDO("mysql:host={$host};dbname={$db};charset=utf8mb4", $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    exit('Database connection unavailable. Check MAT_DB_* configuration.');
}
