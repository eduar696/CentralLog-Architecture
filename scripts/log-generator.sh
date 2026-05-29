#!/bin/bash
# ========================================================
# SIMULADOR DE EVENTOS Y TELEMETRÍA (Log Generator)
# Proyecto: CentralLog-Architecture
# ========================================================

echo "[+] Iniciando simulación de eventos en soc-lab..."

# 1. Simulación de Ataque de Fuerza Bruta (SSH Failures)
echo "[*] Generando eventos de autenticación fallida (Auth)..."
for i in {1..3}; do
    logger -p auth.warning -t sshd "Failed password for invalid user admin$i from 192.168.1.50 port 49152 ssh2"
    sleep 0.5
done

# 2. Simulación de Elevación de Privilegios (Sudo Alerts)
echo "[*] Generando auditoría de comandos de administración (Sudo)..."
logger -p authpriv.notice -t sudo "raude : TTY=pts/0 ; PWD=/home/raude ; USER=root ; COMMAND=/usr/bin/apt update"

# 3. Simulación de Evento Crítico del Sistema (Kernel Alert)
echo "[*] Generando alerta crítica simulada del núcleo (Kernel)..."
logger -p kern.crit -t kernel "Out of memory: Kill process 9999 (mysqld) score 850 or sacrifice child"

echo "[+] Simulación completada con éxito. Trazas enviadas al pipeline."
