# CentralLog-Architecture 🚀
### Arquitectura de Centralización de Logs, Telemetría y Hardening en Linux

Este proyecto despliega una infraestructura robusta de ingeniería de sistemas para la centralización y auditoría de logs del sistema. Permite recolectar trazas de eventos procedentes de clientes remotos en un servidor centralizado utilizando **Rsyslog**, aplicando además políticas estrictas de retención de datos con **Logrotate** y controles defensivos con firewall UFW.

---

## 📊 Arquitectura de la Red (Topología del Laboratorio)

GitHub renderizará automáticamente este flujo interactivo gracias al motor de Mermaid integrado:

```mermaid
graph TD
    subgraph Red_Local [Segmento LAN: 192.168.0.0/24]
        A[Host Cliente Remoto <br> IP del Segmento Local] -- Telemetría Segura <br> UDP / Port 514 --> B[soc-lab <br> Servidor Central: 192.168.0.179]
    end

    subgraph Procesamiento_y_Hardening [Servidor de Logs]
        B --> C[Filtro Rsyslog <br> /var/log/remote/]
        C --> D[Logrotate <br> Retención e Integridad]
        E[UFW Firewall <br> Reglas de Acceso Controlado] -.-> B
    end

    style B fill:#1f2937,stroke:#3b82f6,stroke-width:2px,color:#fff
    style A fill:#111827,stroke:#10b981,stroke-width:2px,color:#fff
    style D fill:#111827,stroke:#f59e0b,stroke-width:2px,color:#fff
