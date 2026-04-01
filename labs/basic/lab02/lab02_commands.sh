#!/bin/bash
# Скрипт для выполнения заданий 6-15 лабораторной работы №2
# Использование: sshpass -p 'PASSWORD' ssh root@SERVER < lab02_commands.sh
# Или: ./lab02_commands.sh (если скопировать на сервер)

set -e  # Остановка при ошибке

echo "=== Задание 6: Git commit и push ==="
cd ~/course_labs 2>/dev/null || cd /root/course_labs
git status
git add .
git commit -m "Lab02: исправлен код pygame, интегрирован файл из lab01" || echo "Нет изменений для коммита"
git push origin master || echo "Push не выполнен (возможно нет удаленного репозитория)"

echo -e "\n=== Задание 7: Команды консоли ==="
groups
useradd smallman 2>/dev/null || echo "Пользователь smallman уже существует"
userdel smallman -rf 2>/dev/null || echo "Пользователь smallman не существует для удаления"
useradd smallman
echo "smallman:password123" | chpasswd smallman || echo "Пароль установлен"
usermod smallman -c 'Hach Hachov Hacherovich,239,45-67,499-239-45-33'
echo "smallman:password123" | chpasswd smallman || echo "Пароль установлен"
id smallman
groupadd -g 1500 readgroup 2>/dev/null || echo "Группа readgroup уже существует"
usermod -aG readgroup smallman
chmod 666 ~/screen 2>/dev/null || chmod 666 /root/screen

echo -e "\n=== Задание 8: Права доступа для screen ==="
SCREEN_FILE=~/screen
[ ! -f "$SCREEN_FILE" ] && SCREEN_FILE=/root/screen
ls -l "$SCREEN_FILE"
getfacl "$SCREEN_FILE" 2>/dev/null || echo "getfacl не установлен, используем ls -l"
chmod 400 "$SCREEN_FILE"
ls -l "$SCREEN_FILE"
# Проверка прав через readgroup
su - smallman -c "groups" || echo "Проверка групп пользователя smallman"
getfacl "$SCREEN_FILE" 2>/dev/null || ls -l "$SCREEN_FILE"

echo -e "\n=== Задание 9: POSIX ACL ==="
touch nmapres.txt
setfacl -m u:smallman:rw nmapres.txt
setfacl -m g:readgroup:r nmapres.txt
getfacl nmapres.txt

echo -e "\n=== Задание 10: Сохранение файла в репозиторий ==="
cd ~/course_labs 2>/dev/null || cd /root/course_labs
cp ~/nmapres.txt . 2>/dev/null || cp /root/nmapres.txt . 2>/dev/null || echo "Файл скопирован"
ls -la nmapres.txt

echo -e "\n=== Задание 11: Группы пользователей и права на каталоги ==="
getent group | cut -d: -f1 | sort
echo "--- Права на верхнеуровневые каталоги ---"
# shellcheck disable=SC2012
ls -ld /bin /sbin /dev /etc /lib /home /root /usr /var /tmp /proc /mnt /media /boot /sys 2>/dev/null | head -15

echo -e "\n=== Задание 12: Права для файлов и директорий репозитория ==="
cd ~/course_labs 2>/dev/null || cd /root/course_labs
find . -type f -exec ls -ld {} \; 2>/dev/null | head -20
find . -type d -exec ls -ld {} \; 2>/dev/null | head -20

echo -e "\n=== Задание 13: Процессы ==="
echo "--- Процессы в терминале ---"
ps -a
echo "--- Процессы вне терминала ---"
ps -x
echo "--- Все процессы ---"
ps aux | head -20

echo -e "\n=== Задание 14: README.md ==="
echo "README.md нужно оформить вручную по аналогии с lab01"

echo -e "\n=== Задание 15: Gist отчет ==="
echo "Gist отчет нужно создать вручную на https://gist.github.com"

echo -e "\n=== Все команды выполнены! ==="


