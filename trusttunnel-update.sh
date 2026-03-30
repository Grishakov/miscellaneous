#!/bin/bash

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # Сброс цвета

# Проверка прав root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Ошибка: Запустите скрипт через sudo${NC}"
  exit 1
fi

# Функция для вывода статуса
check_status() {
    local status=$(systemctl is-active trusttunnel.service 2>/dev/null)
    case "$status" in
        active)   echo -e "Статус: ${GREEN}active${NC}" ;;
        inactive) echo -e "Статус: ${RED}inactive${NC}" ;;
        *)        echo -e "Статус: ${YELLOW}${status:-не установлен}${NC}" ;;
    esac
}

echo "--- Обновление trusttunnel.service ---"

# 1. Остановка
echo "Останавливаю trusttunnel.service..."
systemctl stop trusttunnel.service 2>/dev/null
check_status

# 2. Установка
echo "Запуск скрипта установки..."
if curl -fsSL https://raw.githubusercontent.com/TrustTunnel/TrustTunnel/refs/heads/master/scripts/install.sh | sh -s -; then
    echo -e "${GREEN}Установка завершена успешно.${NC}"
else
    echo -e "${RED}Ошибка при скачивании или установке!${NC}"
    exit 1
fi

# 3. Запуск и финальная проверка
echo "Запускаю trusttunnel.service..."
systemctl daemon-reload # Обновляем конфиги после установки
systemctl start trusttunnel.service

check_status
root@s228426:~# cat tt-update.sh
#!/bin/bash

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # Сброс цвета

# Проверка прав root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Ошибка: Запустите скрипт через sudo${NC}"
  exit 1
fi

# Функция для вывода статуса
check_status() {
    local status=$(systemctl is-active trusttunnel.service 2>/dev/null)
    case "$status" in
        active)   echo -e "Статус: ${GREEN}active${NC}" ;;
        inactive) echo -e "Статус: ${RED}inactive${NC}" ;;
        *)        echo -e "Статус: ${YELLOW}${status:-не установлен}${NC}" ;;
    esac
}

echo "--- Обновление trusttunnel.service ---"

# 1. Остановка
echo "Останавливаю trusttunnel.service..."
systemctl stop trusttunnel.service 2>/dev/null
check_status

# 2. Установка
echo "Запуск скрипта установки..."
if curl -fsSL https://raw.githubusercontent.com/TrustTunnel/TrustTunnel/refs/heads/master/scripts/install.sh | sh -s -; then
    echo -e "${GREEN}Установка завершена успешно.${NC}"
else
    echo -e "${RED}Ошибка при скачивании или установке!${NC}"
    exit 1
fi

# 3. Запуск и финальная проверка
echo "Запускаю trusttunnel.service..."
systemctl daemon-reload # Обновляем конфиги после установки
systemctl start trusttunnel.service

check_status
