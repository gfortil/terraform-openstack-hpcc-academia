#!/bin/bash

apt update
apt install apache2
ufw app list
ufw allow 'Apache'
ufw status
systemctl status apache2