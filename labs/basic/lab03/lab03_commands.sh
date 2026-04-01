#!/bin/bash
# Скрипт для выполнения заданий лабораторной работы №3
# Использование: ./lab03_commands.sh

set -e

echo "=== Задание 2: Команды nmap ==="

echo "--- nmap localhost ---"
nmap localhost

echo -e "\n--- nmap -sC localhost ---"
nmap -sC localhost

echo -e "\n--- nmap -p localhost (ошибка - нет порта указано) ---"
nmap -p localhost 2>&1 || echo "Ошибка: не указан порт"

echo -e "\n--- nmap -O localhost ---"
nmap -O localhost

echo -e "\n--- nmap -p 80 localhost ---"
nmap -p 80 localhost

echo -e "\n--- nmap -p 443 localhost ---"
nmap -p 443 localhost

echo -e "\n--- nmap -p 8443 localhost ---"
nmap -p 8443 localhost

echo -e "\n--- nmap -p \"*\" localhost ---"
nmap -p "*" localhost 2>&1 || echo "Ошибка синтаксиса"

echo -e "\n--- nmap -sV -p 22,8080 localhost ---"
nmap -sV -p 22,8080 localhost

echo -e "\n--- nmap -sP 192.168.1.0/24 (может занять время) ---"
# nmap -sP 192.168.1.0/24 || echo "Сеть недоступна или требует времени"

echo -e "\n--- nmap --open 192.168.1.1 ---"
nmap --open 192.168.1.1 2>&1 | head -20 || echo "Хост недоступен"

echo -e "\n--- nmap --packet-trace 192.168.1.1 ---"
nmap --packet-trace 192.168.1.1 2>&1 | head -30 || echo "Хост недоступен"

echo -e "\n--- nmap --packet-trace scanme.nmap.org ---"
nmap --packet-trace scanme.nmap.org 2>&1 | head -30

echo -e "\n--- nmap --iflist ---"
nmap --iflist

echo -e "\n--- nmap -iL scanme.nmap.org (ошибка - это не файл) ---"
nmap -iL scanme.nmap.org 2>&1 || echo "Ошибка: scanme.nmap.org не является файлом"

echo -e "\n--- nmap -A scanme.nmap.org ---"
nmap -A scanme.nmap.org 2>&1 | head -50

echo -e "\n--- nmap -sA scanme.nmap.org ---"
nmap -sA scanme.nmap.org 2>&1 | head -30

echo -e "\n--- nmap -PN scanme.nmap.org ---"
nmap -PN scanme.nmap.org 2>&1 | head -30

echo -e "\n--- nmap --script=vuln IP_addr -vv (требует IP) ---"
echo "Команда требует указания IP адреса"

echo -e "\n--- nmap -sV --script vuln -oN nmapres_new.txt localhost ---"
nmap -sV --script vuln -oN nmapres_new.txt localhost

echo -e "\n--- grep VULNERABLE nmapres_new.txt ---"
grep "VULNERABLE" nmapres_new.txt || echo "Уязвимости не найдены"

echo -e "\n=== Задание 3: tree ==="
mkdir -p ~/project/reports
tree ~/project 2>/dev/null || find ~/project -type f -exec ls -lh {} \;

echo -e "\n=== Задание 4: Поиск IP адреса Ethernet ==="
ETH_IP=$(ip addr show | grep -A 3 "eth\|ens\|enp" | grep "inet " | head -1 | awk '{print $2}' | cut -d/ -f1)
echo "IP адрес Ethernet: $ETH_IP"
if [ -n "$ETH_IP" ]; then
    echo "--- nmap -sP $ETH_IP ---"
    nmap -sP $ETH_IP 2>&1 | head -20
else
    echo "Ethernet интерфейс не найден или IP не назначен"
fi

echo -e "\n=== Задание 5: Определение ОС, SSH, telnet ==="
nmap -O -sV -p 22,23 localhost

echo -e "\n=== Задание 6: Перенос результатов ==="
cd /root
if [ -f "nmapres_new.txt" ]; then
    cd /root/course_labs
    cp /root/nmapres_new.txt nmapres.txt
    ls -la nmapres*.txt
else
    echo "Файл nmapres_new.txt не найден в /root, ищем..."
    find /root -name "nmapres_new.txt" -exec cp {} /root/course_labs/nmapres.txt \;
    ls -la /root/course_labs/nmapres*.txt
fi

echo -e "\n=== Все команды выполнены! ==="


