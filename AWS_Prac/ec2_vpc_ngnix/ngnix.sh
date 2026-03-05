#!/bin/bash
set -eux

# Install Nginx for Ubuntu/Debian or Amazon Linux/RHEL based images.
if command -v apt-get >/dev/null 2>&1; then
  apt-get update -y
  apt-get install -y nginx
elif command -v dnf >/dev/null 2>&1; then
  dnf install -y nginx
elif command -v yum >/dev/null 2>&1; then
  yum install -y nginx
else
  echo "No supported package manager found. Skipping Nginx install."
  exit 1
fi

# Start Nginx and keep it enabled after reboot.
systemctl enable nginx
systemctl start nginx

# Replace default page with a clear lab message.
if [ -d /var/www/html ]; then
  echo "<html><h1>Hello from Terraform Nginx Lab</h1></html>" > /var/www/html/index.html
elif [ -d /usr/share/nginx/html ]; then
  echo "<html><h1>Hello from Terraform Nginx Lab</h1></html>" > /usr/share/nginx/html/index.html
fi
