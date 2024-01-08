#!/bin/bash

# Installiere Abhängigkeiten
sudo apt-get update
sudo apt-get install -y build-essential libpcap-dev libpcre3-dev libdumbnet-dev bison flex zlib1g-dev liblzma-dev openssl libssl-dev cmake libhwloc-dev pkg-config luajit libluajit-5.1-dev libpcap-dev libdumbnet-dev libunwind-dev liblzma-dev zlib1g-dev libssl-dev libnghttp2-dev

# Kloniere das Snort Repository
git clone https://github.com/snort3/snort3.git

# Gehe in das Snort Verzeichnis
cd snort3

# Erstelle ein Build-Verzeichnis
mkdir build
cd build

# Konfiguriere und baue Snort
../configure_cmake.sh --prefix=/usr/local --enable-tcmalloc

# Kompiliere und installiere Snort
make
sudo make install

# Aktualisiere die Bibliothekspfade
sudo ldconfig

# Erstelle Snort Verzeichnisse
sudo mkdir /etc/snort
sudo mkdir /etc/snort/rules
sudo mkdir /var/log/snort
sudo touch /etc/snort/rules/local.rules

# Automatische Erkennung der Netzwerkschnittstelle
NET_INTERFACE=$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")

# Snort Testlauf
snort -c /etc/snort/snort.conf -i $NET_INTERFACE
