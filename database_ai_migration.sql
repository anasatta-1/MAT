USE mat_db;
ALTER TABLE audio_logs ADD COLUMN transcript LONGTEXT AFTER duration_sec;
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
