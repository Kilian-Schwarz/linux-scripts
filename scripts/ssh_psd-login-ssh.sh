#!/bin/bash

# Fragt den Benutzer, ob er sicher ist, dass er die Passwortauthentifizierung deaktivieren möchte
read -p "Sind Sie sicher, dass Sie die Passwortauthentifizierung deaktivieren möchten? (y/n) " answer

# Wenn der Benutzer "y" antwortet, deaktiviere die Passwortauthentifizierung für SSH
if [ "$answer" == "y" ]; then
  # Sichern Sie zunächst die Originaldatei sshd_config
  cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
  
  # Deaktivieren Sie die Passwortauthentifizierung, indem Sie die entsprechende Zeile in der Konfigurationsdatei auskommentieren
  sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
  
  # Starten Sie den SSH-Dienst neu, damit die Änderungen wirksam werden
  service ssh restart
  
  echo "Die Passwortauthentifizierung wurde erfolgreich deaktiviert."
else
  echo "Die Passwortauthentifizierung wird nicht deaktiviert."
fi
