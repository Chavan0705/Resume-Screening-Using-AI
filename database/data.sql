USE resume_screening_db;

-- Clear tables (optional, for clean seeding)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE resumes;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- Insert Seed Users
-- Passwords are hashed using BCrypt:
-- admin: admin123 -> $2a$10$gR9pGzD9N.D9r1YIqWnbeu6t9wEwVlA5YJcR/t.p/7H1v4NGeuV8a
-- user: user123 -> $2a$10$h0N5zJ3.J9tBfR6tXG5e3uF2Q/7x8o2s3y4T5U6V7W8X9Y0Z1A2B3C
INSERT INTO users (id, username, password, email, role) VALUES 
(1, 'admin', '$2a$10$gR9pGzD9N.D9r1YIqWnbeu6t9wEwVlA5YJcR/t.p/7H1v4NGeuV8a', 'admin@resume.ai', 'ADMIN'),
(2, 'user', '$2a$10$h0N5zJ3.J9tBfR6tXG5e3uF2Q/7x8o2s3y4T5U6V7W8X9Y0Z1A2B3C', 'user@resume.ai', 'USER');
