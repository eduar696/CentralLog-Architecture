#!/bin/bash
# ========================================================
# CONFIGURACIÓN DE REGLAS DE FIREWALL (UFW Rules)
# Proyecto: CentralLog-Architecture
# ========================================================

echo "[+] Configurando reglas de red seguras para el SOC Lab..."

# 1. Habilitar el puerto 514 (UDP) para la subred local
# Permite la recepción rápida de logs desde cualquier equipo en tu red 192.168.0.X
sudo ufw allow from 192.168.0.0/24 to any port 514 proto udp comment 'SOC Lab: Rsyslog UDP Inbound'

# 2. Habilitar el puerto 514 (TCP) para la subred local
# Permite la conexión segura y confiable de logs orientada a conexión
sudo ufw allow from 192.168.0.0/24 to any port 514 proto tcp comment 'SOC Lab: Rsyslog TCP Inbound'

# 3. Recargar el firewall para aplicar los cambios en caliente
echo "[*] Recargando UFW para aplicar las políticas..."
sudo ufw reload

# 4. Mostrar el estado actual para verificar que se aplicaron
sudo ufw status verbose

echo "[+] Configuración del Firewall completada con éxito."
