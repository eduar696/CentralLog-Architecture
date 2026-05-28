# Centralized Logging Architecture - SOC Lab

## 1. Objetivo del Proyecto
El objetivo principal de esta arquitectura es centralizar y estructurar la telemetría y los logs del sistema utilizando `rsyslog`. El proyecto está diseñado para demostrar capacidades de gestión de logs, resistencia a la manipulación de datos, análisis forense básico y endurecimiento (hardening) de infraestructura en entornos Linux.

## 2. Plan de Topología y Red (Fase 1)
Para optimizar el uso de recursos en esta primera fase del laboratorio, se implementó un modelo de **autoinyección de telemetría (Single-Node Loopback Sim)**. La misma máquina física actúa como emisor y receptor a través de la interfaz de red real, validando la lógica del pipeline antes de escalar a nodos externos.

* **Servidor Central (Receptor):** `soc-lab` (`192.168.0.179`)
* **Nodo Cliente (Emisor):** `soc-lab` (`192.168.0.179`)
* **Protocolos y Puertos Activos:** UDP y TCP sobre el puerto estándar `514` (En estado `LISTEN` en todas las interfaces).

## 3. Flujo de Datos Dinámico
1. **Generación:** El sistema operativo o los usuarios del nodo (ej. el usuario `raude`) generan eventos del sistema (autenticación, comandos `sudo`, eventos de `kernel` o servicios de `systemd`).
2. **Transporte:** El demonio local de `rsyslog` captura los eventos locales y los redirige a través de la red local apuntando a la IP `192.168.0.179:514`.
3. **Procesamiento y Clasificación:** El servidor central intercepta el tráfico y, mediante una regla dinámica (`$template RemoteLogs`), segmenta los logs de forma aislada basándose en el nombre de la máquina origen y el servicio emisor.
4. **Almacenamiento Localizado:** Los archivos finales se escriben en rutas dedicadas con permisos restrictivos:
   * `/var/log/remote/soc-lab/raude.log` (Logs de usuario)
   * `/var/log/remote/soc-lab/sudo.log` (Auditoría de privilegios)
   * `/var/log/remote/soc-lab/kernel.log` (Eventos del núcleo)

## 4. Hardening y Mantenimiento de Disco
Para mitigar ataques de Denegación de Servicio (DoS) por llenado de disco, se integró una política estricta de rotación de logs mediante `logrotate`:
* **Frecuencia:** Diaria (`daily`).
* **Retención:** 7 días de historial (`rotate 7`).
* **Optimización:** Compresión automática en formato `.gz` (`compress`) con retraso de un ciclo (`delaycompress`) para mantener accesibles los logs más recientes de forma inmediata.
