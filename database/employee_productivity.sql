CREATE DATABASE hiltondb;

USE hiltondb;

CREATE TABLE employee_productivity(
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  emp_id VARCHAR(20) NOT NULL,
  emp_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  productivity_hours VARCHAR(20) NOT NULL
);
