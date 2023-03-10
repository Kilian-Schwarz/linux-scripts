#!/bin/bash

# Install Fail2ban
apt-get update
apt-get install -y fail2ban

# Create a new configuration file for SSH
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[ssh]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port = ssh" >> /etc/fail2ban/jail.local
echo "filter = sshd" >> /etc/fail2ban/jail.local
echo "logpath = /var/log/auth.log" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local
echo "findtime = 300" >> /etc/fail2ban/jail.local
echo "bantime = 300" >> /etc/fail2ban/jail.local

# Restart Fail2ban
service fail2ban restart
