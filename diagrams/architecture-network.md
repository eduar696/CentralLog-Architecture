# Diagrama de Arquitectura de Centralización de Logs

```mermaid
graph TD
    %% Nodos Principales
    subgraph Cliente_Remoto [Nodo: soc-client]
        A[Aplicaciones / OS Logs] -->|Genera Eventos| B(Servicio Rsyslog Cliente)
        B -->|Filtro: *.*| C{Regla de Envío}
        C -->|Protocolo TCP/UDP / Puerto 514| D[Módulo de Salida @@192.168.0.179]
    end

    subgraph Servidor_Central [Nodo: soc-lab]
        E[Puerto 514 Abierto] -->|Recibe Tráfico Remoto| F(Servicio Rsyslog Servidor)
        F -->|Plantilla Dinámica: %HOSTNAME%| G[Clasificación Automática]
        G -->|Escribe en Disco| H[(/var/log/remote/soc-client/)]
        
        %% Logrotate
        I(Cron Diario: Logrotate) -->|Monitorea /var/log/remote/*/*.log| J{¿Se cumple regla daily?}
        J -->|Sí| K[Comprime a .log.1 / .gz]
        K -->|Aplica Permisos| L[Seguridad: 0640 syslog:syslog]
    end

    %% Conexión de Red
    D ---->|Flujo de Telemetría Seguro| E

    %% Estilos Visuales
    style Cliente_Remoto fill:#f9fafd,stroke:#333,stroke-width:2px
    style Servidor_Central fill:#f5fbf7,stroke:#333,stroke-width:2px
    style D fill:#d1e7dd,stroke:#0f5132,stroke-width:1px
    style E fill:#d1e7dd,stroke:#0f5132,stroke-width:1px
    style H fill:#fff3cd,stroke:#664d03,stroke-width:1px
    style K fill:#f8d7da,stroke:#842029,stroke-width:1px
