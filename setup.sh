#! /bin/bash
sudo apt update
sudo apt install -y \
openjdk-17-jdk \
maven \
mysql-server \
curl

sudo systemctl start mysql
sudo mysql <<EOF

ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'root';

FLUSH PRIVILEGES;

EOF

sudo mysql -u root -proot < database/employee_productivity.sql
mysql -u root -proot -e "SHOW DATABASES;"

echo "Setup Completed"
