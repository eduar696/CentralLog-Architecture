# Arquitectura del Sistema: CentralLog-Architecture

Este documento describe la estructura técnica y el flujo de datos implementado para la centralización y gestión de logs en un entorno controlado de laboratorio.

## 1. Topología de Red y Simulación de Entorno
Para la validación inicial del pipeline de recolección, se implementa un modelo de simulación de nodo único (*Single-Node Loopback Simulation*). El sistema operativo actúa simultáneamente como emisor (cliente) y receptor (servidor centralizador) a través de la interfaz de red local.

* **Hostname Centralizador:** `soc-lab`
* **Direccionamiento de Red:** `192.168.X.X` (Segmento de red privada local /24)
* **Protocolos de Transporte:** Capa de transporte TCP y UDP activa, escuchando en el puerto estándar de syslog (`514`).

## 2. Flujo de Datos Técnico (Pipeline de Logs)

```text
[ Generación de Eventos ]  --> Eventos de Kernel, Sudo, Autenticación (Auth.log)
          │
          ▼
[ Rsyslog (Cliente) ]      --> Captura el evento local y lo encapsula para red
          │
          │ (Transmisión local vía Socket de Red - Puerto 514)
          ▼
[ Filtro de Red (UFW) ]   --> Inspección de reglas (Permitir tráfico TCP/UDP 514)
          │
          ▼
[ Rsyslog (Servidor) ]     --> Procesa los flujos entrantes mediante módulos (imudp/imtcp)
          │
          │ (Aplicación de plantilla dinámica de enrutamiento)
          ▼
[ Depósito de Logs ]       --> Almacenamiento estructurado en: /var/log/remote/%HOSTNAME%/
          │
          ▼
[ Gestión de Ciclo ]       --> Logrotate (Políticas de rotación diaria, retención y compresión)
