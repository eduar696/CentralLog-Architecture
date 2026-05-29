# Arquitectura del Sistema: CentralLog-Architecture

Este documento describe la estructura técnica y el flujo de datos para la centralización de logs en el entorno de laboratorio.

## 1. Plan de Topología y Red (Single-Node Loopback Sim)
Para la validación del pipeline, se utiliza un modelo de autoinyección. La máquina actúa como emisor y receptor a través de su interfaz de red real.

* **Host Centralizador (Servidor/Cliente):** `soc-lab` (`192.168.0.179`)
* **Protocolos de Red:** UDP y TCP activos en el puerto estándar `514`.

## 2. Flujo de Datos Técnico

```text
[ Generación de Eventos ] (Usuario raude / sudo / kernel)
         │
         ▼
[ Agente Local: Rsyslog Cliente ]
         │
         │ (Transmisión vía Red local - IP 192.168.0.179:514)
         ▼
[ Cortafuegos: UFW Rules ] (Validación de puerto 514 abierto)
         │
         ▼
[ Motor Central: Rsyslog Server ]
         │
         ▼
[ Almacenamiento Clasificado ] (/var/log/remote/soc-lab/)
         │
         ▼
[ Ciclo de Vida ] (Logrotate: Rotación diaria y compresión .gz)
