CREATE DATABASE hiltondb;

USE hiltondb;

CREATE TABLE employee_productivity(
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  emp_id VARCHAR(20),
  emp_name VARCHAR(100),
  email VARCHAR(100),
  productivity_hours VARCHAR(20)
);
