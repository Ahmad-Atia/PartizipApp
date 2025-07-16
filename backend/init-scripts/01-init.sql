-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS partizip_db;

-- Use the database
USE partizip_db;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS feedback;
DROP TABLE IF EXISTS participant;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS user_participation;
DROP TABLE IF EXISTS user_interests;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    user_id CHAR(36) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    avatar VARCHAR(255),
    password_hashed VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(500),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create user_interests table
CREATE TABLE user_interests (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    interest VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_interests_user_id (user_id)
);

-- Create user_participation table
CREATE TABLE user_participation (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id CHAR(36) NOT NULL,
    participation VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_participation_user_id (user_id)
);

-- Create events table
CREATE TABLE events (
    id BINARY(16) PRIMARY KEY,
    creatorID BINARY(16) NOT NULL,
    date DATETIME NOT NULL,
    description TEXT,
    isPublic BOOLEAN NOT NULL,
    location VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    status ENUM('PLANNED', 'ONGOING', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PLANNED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create participant table
CREATE TABLE participant (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    event_id BINARY(16) NOT NULL,
    user_id CHAR(36) NOT NULL,
    role VARCHAR(100),
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

-- Create feedback table
CREATE TABLE feedback (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    event_id BINARY(16) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE
);

-- Insert sample users
INSERT INTO users (user_id, name, lastname, avatar, password_hashed, email, address, date_of_birth, created_at, updated_at) VALUES
('550e8400-e29b-41d4-a716-446655440000', 'John', 'Doe', NULL, 'hashedpassword123', 'john.doe@example.com', '123 Main St, City', '1985-03-15', NOW(), NOW()),
('550e8400-e29b-41d4-a716-446655440001', 'Jane', 'Smith', NULL, 'hashedpassword456', 'jane.smith@example.com', '456 Oak Ave, Town', '1990-07-22', NOW(), NOW()),
('550e8400-e29b-41d4-a716-446655440002', 'SWT', 'APP', NULL, 'swtpassword123456', 'swt.app@example.com', '456 Oak Ave, Town', '1990-07-23', NOW(), NOW());

-- Insert sample events (mit UUID_TO_BIN() für BINARY(16) IDs)
INSERT INTO events (
    id, creatorID, date, description, isPublic, location, name, status
) VALUES
(UUID_TO_BIN(UUID()), UUID_TO_BIN('550e8400-e29b-41d4-a716-446655440000'), '2025-10-29 09:00:00', 'Notfalltraining für Eltern', TRUE, 'Hospitalstraße 19, 44649 Herne', 'Erste Hilfe bei Kindern', 'PLANNED'),
(UUID_TO_BIN(UUID()), UUID_TO_BIN('550e8400-e29b-41d4-a716-446655440001'), '2025-10-01 10:00:00', 'Frühstückstreffen für Familien mit Kleinkindern', TRUE, 'Hauptstraße 241, 44649 Herne', 'Familienfrühstück im Familienbüro', 'PLANNED'),
(UUID_TO_BIN(UUID()), UUID_TO_BIN('550e8400-e29b-41d4-a716-446655440001'), '2025-08-15 14:00:00', 'Resilienzförderung für geflüchtete Frauen', TRUE, 'Schulstraße 16, 44623 Herne', 'EmpowerHER - Psychische Gesundheit für Frauen', 'ONGOING');

-- Sample participant entries (optional)
INSERT INTO participant (event_id, user_id, role)
SELECT id, '550e8400-e29b-41d4-a716-446655440000', 'Teilnehmer' FROM events LIMIT 1;

INSERT INTO participant (event_id, user_id, role)
SELECT id, '550e8400-e29b-41d4-a716-446655440001', 'Teilnehmer' FROM events ORDER BY id DESC LIMIT 1;

-- Sample feedback entries (optional)
INSERT INTO feedback (event_id, user_id, rating, comment)
SELECT id, '550e8400-e29b-41d4-a716-446655440000', 5, 'Sehr hilfreicher Kurs!' FROM events LIMIT 1;

INSERT INTO feedback (event_id, user_id, rating, comment)
SELECT id, '550e8400-e29b-41d4-a716-446655440001', 4, 'Gute Inhalte, aber Raum war zu klein.' FROM events ORDER BY id DESC LIMIT 1;