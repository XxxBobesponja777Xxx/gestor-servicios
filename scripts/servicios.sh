#!/usr/bin/env bash
source "/home/william/gestor-servicios/config.txt"
log_file="$LOG_DIR/servicios.log"
services=(ssh apache2 mysql)  

for svc in "${services[@]}"; do
  if ! systemctl is-active --quiet "$svc"; then
    echo "$(date '+%F %T') - $svc inactivo" >> "$log_file"
    systemctl start "$svc"
    status=$?
    [[ $status -eq 0 ]] && text=" $svc reiniciado." || text=" No arrancó $svc."
    curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
      -d chat_id="${CHAT_ID}" -d text="$text"
  fi
done
