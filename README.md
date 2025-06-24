estor de Servicios

Scripts Bash para automatizar tareas en servidores Debian:

Reinicio de servicios (ssh, apache2, mysql)

Monitoreo de CPU y disco

Copias de seguridad

Ejecución remota y gestión de usuarios

Alertas en Telegram

Estructura

gestor-servicios/
├── config.txt      # Variables de entorno
├── hosts.txt       # Hosts para tareas remotas
├── scripts/
│   ├── servicios.sh
│   ├── monitoreo.sh
│   ├── respaldo.sh
│   ├── remoto.sh
│   └── usuarios.sh
└── logs/           # Registros de ejecución

Configuración

Edita config.txt:

TELEGRAM_TOKEN="<token>"
CHAT_ID=<chat_id>
LOG_DIR="./logs"
BACKUP_DIR="./backups"
REMOTE_HOSTS_FILE="./hosts.txt"

Uso

bash scripts/servicios.sh   # Reinicia servicios
bash scripts/monitoreo.sh   # Alerta si supera umbrales
bash scripts/respaldo.sh    # Genera backupash scripts/remoto.sh     # Ejecuta tarea remota
bash scripts/usuarios.sh    # Gestiona usuarios

Cron (ejemplo)

*/5 * * * * bash /ruta/gestor-servicios/scripts/servicios.sh
0 2 * * * bash /ruta/gestor-servicios/scripts/respaldo.sh

