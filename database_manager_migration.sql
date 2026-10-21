USE mat_db;
ALTER TABLE users MODIFY role ENUM('admin','manager','member') DEFAULT 'member';
ALTER TABLE tickets ADD COLUMN priority ENUM('urgent','important','normal') DEFAULT 'normal' AFTER expected_submit_date;
ALTER TABLE tickets ADD COLUMN assigned_to INT DEFAULT NULL AFTER priority;
ALTER TABLE tickets ADD CONSTRAINT fk_tickets_assignee FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL;
INSERT INTO users (company_id, user_code, full_name, email, password_hash, role)
SELECT c.id, 'mmanager', 'Michael Manager', 'michael.manager@acme.test', '$2y$10$6HKt/XmumGNdEYQhGwX3xuo9ZVNIBnGTo075IfE8UhYRRLYrGS2da', 'manager'
FROM companies c WHERE c.company_code='ACME01' AND NOT EXISTS (SELECT 1 FROM users u WHERE u.company_id=c.id AND u.user_code='mmanager');
