<?php
declare(strict_types=1);
if (session_status() !== PHP_SESSION_ACTIVE) session_start();
require_once __DIR__ . '/../db.php';

function require_auth(): void {
    if (empty($_SESSION['user'])) { header('Location: login.php'); exit; }
}
function current_user(): array { return $_SESSION['user'] ?? []; }
function is_manager(): bool { return in_array(current_user()['role'] ?? '', ['manager', 'admin'], true); }
function require_manager(): void { require_auth(); if (!is_manager()) { http_response_code(403); exit('Manager access required.'); } }
function e(?string $value): string { return htmlspecialchars((string)$value, ENT_QUOTES, 'UTF-8'); }
function csrf_token(): string { if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32)); return $_SESSION['csrf']; }
function verify_csrf(): void { if (!hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'] ?? '')) { http_response_code(419); exit('Invalid request token.'); } }
function flash(string $type, string $message): void { $_SESSION['flash'] = [$type, $message]; }
function pull_flash(): ?array { $f = $_SESSION['flash'] ?? null; unset($_SESSION['flash']); return $f; }
