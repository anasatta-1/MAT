USE mat_db;
INSERT INTO users (company_id, user_code, full_name, email, password_hash, role)
SELECT c.id, 'adnan', 'Adnan', NULL, '$2y$10$mZMbPz1W5ijfN0tvMUg58.Zgd6me8qE5uXZjCn1OgIo2b6M28o7UK', 'manager'
FROM companies c WHERE c.company_code='ACME01' AND NOT EXISTS (SELECT 1 FROM users u WHERE u.company_id=c.id AND u.user_code='adnan');
INSERT INTO users (company_id, user_code, full_name, email, password_hash, role)
SELECT c.id, 'anas', 'Anas', NULL, '$2y$10$PcpxnF/TgFd4mduh0s1Tt.4ABd2Y.rwTOouKufq1ReBqlYW.4agI.', 'member'
FROM companies c WHERE c.company_code='ACME01' AND NOT EXISTS (SELECT 1 FROM users u WHERE u.company_id=c.id AND u.user_code='anas');
INSERT INTO users (company_id, user_code, full_name, email, password_hash, role)
SELECT c.id, 'extra1', 'Extra 1', NULL, '$2y$10$yeNk9oXePxGGKDRGt2.a9.IJc55uWw33liJj/es5qjJNXz31uhqJS', 'member'
FROM companies c WHERE c.company_code='ACME01' AND NOT EXISTS (SELECT 1 FROM users u WHERE u.company_id=c.id AND u.user_code='extra1');
INSERT INTO users (company_id, user_code, full_name, email, password_hash, role)
SELECT c.id, 'extra2', 'Extra 2', NULL, '$2y$10$pw/KR8AOukX.GPqqh4lvOeIozjAzGDLrp3I9AwuLTz7OL38sFQPBq', 'member'
FROM companies c WHERE c.company_code='ACME01' AND NOT EXISTS (SELECT 1 FROM users u WHERE u.company_id=c.id AND u.user_code='extra2');
