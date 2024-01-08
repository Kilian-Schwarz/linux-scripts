#!/bin/bash

# Installation von AIDE
sudo apt-get update && sudo apt-get install -y aide

# Initialisierung der AIDE-Datenbank
sudo aideinit

# Aktualisierung der AIDE-Datenbank
sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

# Erstellen der AIDE-Konfigurationsdatei
echo '/bin R
/sbin R
/lib R
/usr R
/etc R' | sudo tee /etc/aide/aide.conf

# Einrichten des täglichen AIDE-Überprüfungs-Cron-Jobs
echo '0 1 * * * /usr/bin/aide.wrapper --config=/etc/aide/aide.conf --check' | sudo tee /etc/cron.d/aide
