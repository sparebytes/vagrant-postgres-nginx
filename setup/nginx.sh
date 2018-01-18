#!/bin/sh -e

echo "<nginx.sh>"

# Install Nginx
echo "Installing Nginx"
apt-get install nginx -y > /dev/null

# Delete Previous Nginx Configuration Files
echo "Deleting Previous Nginx Configuration Files"
rm -rf /etc/nginx/sites-available/* > /dev/null
rm -rf /etc/nginx/sites-enabled/* > /dev/null

# Copy configuration files over
echo "Copying New Nginx Configuration Files"
cp /setup/config/nginx/* /etc/nginx/sites-available/ > /dev/null
ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/ > /dev/null

# Restart Nginx
echo "Restarting Nginx"
service nginx restart > /dev/null

echo "</nginx.sh>"
