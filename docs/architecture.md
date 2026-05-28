# Centralized Logging Architecture

## Objective
El objetivo principal de esta arquitectura es centralizar los logs del sistema desde un nodo cliente hacia un servidor de logs dedicado y seguro utilizando `rsyslog`. Esta implementación garantiza la retención de telemetría, resistencia a la manipulación de datos y un endurecimiento (hardening) básico de la infraestructura.

## Network & Topology Plan
* **Log Server (Receptor):** Dirección IP de tu servidor central (ej. 192.168.1.X)
* **Client Node (Emisor):** Dirección IP de la máquina que envía los logs (ej. 192.168.1.Y)
* **Protocol & Port:** UDP / TCP a través del puerto `514`

## Data Flow

1. **Generación:** El nodo cliente genera eventos del sistema (como intentos de inicio de sesión por SSH o uso de comandos sudo).
2. **Transporte:** El demonio local de `rsyslog` en el cliente reenvía los logs de forma segura a través de la red hacia el servidor.
3. **Almacenamiento:** El servidor central de `rsyslog` recibe los datos y los almacena en rutas dinámicas separadas por la IP o el nombre de cada cliente.
4. **Mantenimiento:** La herramienta `logrotate` comprime y gestiona la retención de los archivos para proteger el espacio en disco del servidor.
