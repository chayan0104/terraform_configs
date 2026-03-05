#!/bin/bash
apt update -y
apt install nginx -y
systemctl enable nginx
systemctl start ngin
echo "<html><h1>Hello from Terraform Nginx Server</h1></html>" > /var/www/html/index.html