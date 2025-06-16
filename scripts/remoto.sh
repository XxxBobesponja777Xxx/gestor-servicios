#!/usr/bin/env bash
source "/home/william/gestor-servicios/config.txt"

report="$LOG_DIR/report_$(date '+%F_%H%M').txt"
> "$report"

while read -r host; do
  echo "=== $host ===" >> "$report"
  scp "$REMOTE_SCRIPT" "$host:/tmp/" >> "$report" 2>&1
  ssh "$host" "bash /tmp/$(basename $REMOTE_SCRIPT)" >> "$report" 2>&1
done < "$REMOTE_HOSTS_FILE"

curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendDocument" \
  -F chat_id="${CHAT_ID}" -F document=@"$report"
