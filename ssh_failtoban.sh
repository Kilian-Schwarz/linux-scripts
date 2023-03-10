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
echo "action = %(action_mwl)s" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local
echo "[ssh-iptables]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "filter = sshd" >> /etc/fail2ban/jail.local
echo "action = iptables[name=SSH, port=ssh, protocol=tcp]" >> /etc/fail2ban/jail.local
echo "logpath = /var/log/auth.log" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local
echo "findtime = 300" >> /etc/fail2ban/jail.local
echo "bantime = 300" >> /etc/fail2ban/jail.local
echo "banaction = %(banaction_allports)s" >> /etc/fail2ban/jail.local
echo "mta = mail" >> /etc/fail2ban/jail.local
echo "protocol = smtp" >> /etc/fail2ban/jail.local
echo "sendername = Fail2ban" >> /etc/fail2ban/jail.local
echo "destemail = Kilian@webschwarz.de" >> /etc/fail2ban/jail.local
echo "action = %(action_mwl)s" >> /etc/fail2ban/jail.local
echo "mta-whois[name=%(__name__)s, dest=%(destemail)s, protocol=%(protocol)s]" >> /etc/fail2ban/jail.local
echo "       enabled = true" >> /etc/fail2ban/jail.local
echo "       port    = smtp,587" >> /etc/fail2ban/jail.local
echo "       filter  = %(banaction)s[name=%(__name__)s]" >> /etc/fail2ban/jail.local
echo "       logpath = /var/log/fail2ban.log" >> /etc/fail2ban/jail.local
echo "       maxretry = 1" >> /etc/fail2ban/jail.local
echo "       action  = %(action_mwl)s" >> /etc/fail2ban/jail.local
echo "" >> /etc/fail2ban/jail.local

# Set up email notification
sed -i "s/destemail = root@localhost/destemail = Kilian@webschwarz.de/g" /etc/fail2ban/jail.local
echo "sendername = Fail2ban" >> /etc/fail2ban/jail.local
echo "mta = mail" >> /etc/fail2ban/jail.local
echo "mta-whois[name=%(name)s, dest=%(destemail)s, protocol=%(protocol)s]" >> /etc/fail2ban/jail.local
echo " enabled = true" >> /etc/fail2ban/jail.local
echo " port = 587" >> /etc/fail2ban/jail.local
echo " protocol = smtps" >> /etc/fail2ban/jail.local
echo " action = %(action_mwl)s" >> /etc/fail2ban/jail.local
echo " sender = donotreply@mysvc.de" >> /etc/fail2ban/jail.local
echo " password = h#z5_]6_5!)S,5*6ikHuTxX8{P^_2hd5Rt8Ee:XzoI" >> /etc/fail2ban/jail.local

#Restart Fail2ban
service fail2ban restart
