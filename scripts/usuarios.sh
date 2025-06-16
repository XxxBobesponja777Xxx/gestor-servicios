#!/usr/bin/env bash
source "/home/william/gestor-servicios/config.txt"
log_file="$LOG_DIR/usuarios.log"

send_telegram(){
  curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    -d text="$1" >/dev/null
}

crear_usuario(){
  read -p "Nombre de usuario: " user
  sudo useradd -m "$user"
  echo "$(date '+%F %T') - Creado usuario $user" >> "$log_file"
  send_telegram "👤 Usuario *$user* creado."
}

eliminar_usuario(){
  read -p "Usuario a eliminar: " user
  sudo userdel -r "$user"
  echo "$(date '+%F %T') - Eliminado usuario $user" >> "$log_file"
  send_telegram " Usuario *$user* eliminado."
}

modificar_usuario(){
  read -p "Usuario a modificar: " user
  read -p "Nuevo nombre: " newuser
  sudo usermod -l "$newuser" "$user"
  echo "$(date '+%F %T') - Renombrado $user a $newuser" >> "$log_file"
  send_telegram "✏️$user* renombrado a *$newuser*."
}

while true; do
  clear
  echo "1) Crear usuario"
  echo "2) Eliminar usuario"
  echo "3) Modificar usuario"
  echo "4) Salir"
  read -p "Opción [1-4]: " opt
  case $opt in
    1) crear_usuario ;;
    2) eliminar_usuario ;;
    3) modificar_usuario ;;
    4) exit ;;
    *) echo "Inválido." ; sleep 1 ;;
  esac
done
