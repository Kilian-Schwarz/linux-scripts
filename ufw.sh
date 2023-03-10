#!/bin/bash

# Setzen der ufw Firewall zurück
sudo ufw --force reset

# Standardverhalten: Eingehende Verbindungen blockieren, ausgehende Verbindungen erlauben
sudo ufw default deny incoming
sudo ufw default allow outgoing

# SSH-Verbindung von einem bestimmten Server erlauben
read -p "Soll SSH nur von einem bestimmten Server erlaubt sein? [j/n]: " ssh_server
if [[ $ssh_server == [jJ] ]]; then
    read -p "Geben Sie die IP-Adresse oder den Hostnamen des Servers an: " ssh_host
    sudo ufw allow from $ssh_host to any port 22 proto tcp comment "SSH von $ssh_host erlaubt"
else
    sudo ufw allow ssh comment "SSH erlaubt"
fi

# Weitere Ports hinzufügen
while true; do
    read -p "Möchten Sie weitere Ports hinzufügen? [j/n]: " add_port
    if [[ $add_port == [nN] ]]; then
        break
    fi

    # Portnummer abfragen
    read -p "Geben Sie die Portnummer an: " port_number

    # Optionale Angabe eines bestimmten Servers
    read -p "Soll der Zugriff auf Port $port_number nur von einem bestimmten Server erlaubt sein? [j/n]: " port_server
    if [[ $port_server == [jJ] ]]; then
        read -p "Geben Sie die IP-Adresse oder den Hostnamen des Servers an: " server_name
        sudo ufw allow from $server_name to any port $port_number proto tcp comment "Zugriff auf Port $port_number von $server_name erlaubt"
    else
        sudo ufw allow $port_number comment "Zugriff auf Port $port_number erlaubt"
    fi
done

# Firewall aktivieren
sudo ufw enable
