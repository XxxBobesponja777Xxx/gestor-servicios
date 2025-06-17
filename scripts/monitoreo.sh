#!/usr/bin/env bash
source "/home/william/gestor-servicios/config.txt"
log_file="$LOG_DIR/monitoreo.log"

cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5); printf "%.0f", usage}')
disk=$(df / | awk 'END{print +$5}')

message=""
(( cpu > CPU_THRESHOLD )) && message+="⚠️CPU: ${cpu}%"
(( disk >= DISK_THRESHOLD )) && message+=" Disco: ${disk}%"

if [[ -n "$message" ]]; then
  echo "$(date '+%F %T') - $message" >> "$log_file"
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    -d text="$message"
fi
