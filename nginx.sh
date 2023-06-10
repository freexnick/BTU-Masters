#! /bin/bash
sudo apt update -y
sudo apt-get install nginx -y 
sudo systemctl start nginx 
sudo systemctl enable nginx