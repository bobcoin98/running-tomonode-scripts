#!/bin/bash

# Setup Nginx

sudo apt update -y
sudo apt install nginx -y

sudo systemctl status nginx