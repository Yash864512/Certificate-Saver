-- Create database and tables (if not exists)
CREATE DATABASE IF NOT EXISTS user_auth;
USE user_auth;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    rollno VARCHAR(50),
    teacher_id VARCHAR(50),
    password VARCHAR(255) NOT NULL, -- Storing plain text passwords
    is_admin BOOLEAN DEFAULT FALSE,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- OTP table
CREATE TABLE IF NOT EXISTS otp_verifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    otp VARCHAR(6) NOT NULL,
    purpose ENUM('registration', 'password_reset') NOT NULL,
    expires_at DATETIME NOT NULL
);

-- Certificates table
CREATE TABLE IF NOT EXISTS certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rollno VARCHAR(50) NOT NULL,
    certificate_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create user and grant privileges
CREATE USER IF NOT EXISTS 'yaswanth'@'localhost' IDENTIFIED BY '@Mallela15960';
GRANT ALL PRIVILEGES ON user_auth.* TO 'yaswanth'@'localhost';
FLUSH PRIVILEGES;

-- Insert admin user (plain text password)
INSERT INTO users (email, rollno, password, is_admin, is_verified) 
VALUES ('yashwanthkumarmallela.com', '12315067', '@LPUDEV', TRUE, TRUE);

select * from users

DELETE FROM users WHERE rollno = '12315067';

-- Insert sample student
INSERT INTO users (email, rollno, password, is_verified) 
VALUES ('student@example.com', '23X41A4251', 'student123', TRUE);