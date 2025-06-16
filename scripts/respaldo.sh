#!/usr/bin/env bash
source "/home/william/gestor-servicios/config.txt"
log_file="$LOG_DIR/respaldo.log"
timestamp=$(date '+%F_%H%M')

backup_file="$BACKUP_DIR/backup_$timestamp.tar.gz"

mkdir -p "$BACKUP_DIR"
tar -czf "$backup_file" -C /home/william/gestor-servicios .

if [[ -f "$backup_file" ]]; then
  echo "$(date '+%F %T') - Respaldo OK: $backup_file" >> "$log_file"
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    -d text=" Respaldo: _${backup_file}_"
else
  echo "$(date '+%F %T') - ERROR respaldo" >> "$log_file"
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    -d text=" Falló respaldo."
fi
