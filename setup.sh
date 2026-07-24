#! /bin/bash
sudo apt update
sudo apt install -y \
openjdk-17-jdk \
maven \
mysql-server \
curl

sudo systemctl start mysql
sudo mysql < database/employee_productivity.sql

echo "Setup Completed"
