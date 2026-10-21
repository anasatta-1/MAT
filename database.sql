CREATE DATABASE IF NOT EXISTS mat_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mat_db;

CREATE TABLE companies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company_code VARCHAR(50) NOT NULL UNIQUE,
  name VARCHAR(150) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company_id INT NOT NULL,
  user_code VARCHAR(50) NOT NULL,
  full_name VARCHAR(150) NOT NULL,
  email VARCHAR(150),
  password_hash VARCHAR(255) NOT NULL,
  role ENUM('admin','manager','member') DEFAULT 'member',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_company_user (company_id, user_code),
  FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE projects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company_id INT NOT NULL,
  name VARCHAR(200) NOT NULL,
  description TEXT,
  goals TEXT,
  bottlenecks TEXT,
  status ENUM('Active','On Hold','Completed') DEFAULT 'Active',
  created_by INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE tickets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  expected_outcome TEXT,
  expected_submit_date DATE,
  priority ENUM('urgent','important','normal') DEFAULT 'normal',
  assigned_to INT DEFAULT NULL,
  status ENUM('Open','In Progress','Closed') DEFAULT 'Open',
  created_by INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  closed_at TIMESTAMP NULL,
  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE subtasks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ticket_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  is_closed TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  closed_at TIMESTAMP NULL,
  FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE audio_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  company_id INT NOT NULL,
  project_id INT,
  user_id INT,
  filename VARCHAR(255) NOT NULL,
  label VARCHAR(200),
  duration_sec INT,
  transcript LONGTEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE SET NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE ai_task_suggestions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  audio_id INT NOT NULL,
  company_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  priority ENUM('urgent','important','normal') DEFAULT 'normal',
  expected_submit_date DATE DEFAULT NULL,
  assigned_to INT DEFAULT NULL,
  status ENUM('pending','accepted','dismissed') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (audio_id) REFERENCES audio_logs(id) ON DELETE CASCADE,
  FOREIGN KEY (company_id) REFERENCES companies(id) ON DELETE CASCADE,
  FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

INSERT INTO companies (company_code, name) VALUES ('ACME01', 'Acme Corporation');
INSERT INTO users (company_id, user_code, full_name, email, password_hash, role)
VALUES (1, 'jdoe', 'Jane Doe', 'jane.doe@acme.test', '$2y$10$1tTYPR1MN1oV5iTfQaTxWu7P0qKsSXM2t.gG2IKXCLMBHkX6flo/q', 'admin');
INSERT INTO users (company_id, user_code, full_name, email, password_hash, role)
VALUES (1, 'mmanager', 'Michael Manager', 'michael.manager@acme.test', '$2y$10$6HKt/XmumGNdEYQhGwX3xuo9ZVNIBnGTo075IfE8UhYRRLYrGS2da', 'manager');
INSERT INTO projects (company_id, name, description, goals, bottlenecks, status, created_by)
VALUES (1, 'Q3 Product Launch', 'End-to-end launch of the new analytics dashboard.', 'Ship the dashboard to 100 beta customers by end of Q3.', 'Design hand-off is delayed; analytics API rate limits must be negotiated.', 'Active', 1);
