#!/bin/bash
chmod +x scripts/*
# Funktion zum Ausführen eines Skripts
run_script() {
  # Führe das ausgewählte Skript mit sudo bash aus
  sudo bash "$1"
  # Speichere den Exit-Code des Skripts
  exit_code=$?
  # Wenn das Skript fehlerhaft beendet wurde, gib eine Fehlermeldung aus und kehre zur Skriptauswahl zurück
  if [ $exit_code -ne 0 ]; then
    echo "Das vorherige Skript hat einen Fehler verursacht (Exit-Code $exit_code). Bitte wählen Sie erneut aus."
  fi
}

# Liste alle Skripte im aktuellen Verzeichnis auf, numeriere sie und gib sie aus
script_count=0
for script_file in ./scripts/*; do
  if [ -f "$script_file" ] && [ -x "$script_file" ]; then
    script_count=$((script_count+1))
    echo "$script_count. $(basename "$script_file")"
  fi
done

# Eingabeaufforderung für den Benutzer
echo "Bitte wählen Sie ein Skript aus (0 zum Beenden): "

# Warte auf eine Benutzereingabe
while true; do
  read choice
  # Wenn der Benutzer 0 auswählt, beende das Skript
  if [ "$choice" -eq 0 ]; then
    exit 0
  fi
  # Wenn der Benutzer eine gültige Auswahl trifft, führe das Skript aus
  if [ "$choice" -gt 0 ] && [ "$choice" -le "$script_count" ]; then
    selected_script=$(ls -1 ./scripts | sed -n "$choice"p)
    run_script "./scripts/$selected_script"
  fi
  # Wenn der Benutzer eine ungültige Auswahl trifft, gib eine Fehlermeldung aus und fordere ihn erneut auf, auszuwählen
  echo "Ungültige Auswahl. Bitte wählen Sie erneut aus (0 zum Beenden): "
done
