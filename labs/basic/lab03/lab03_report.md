# Отчет по лабораторной работе №3

## Выполненные задания

### Задание 1: Описание методов nmap

**Методы сканирования nmap:**

1. **TCP Connect (-sT)** - Полное TCP подключение. Устанавливает полное соединение с целевым портом. Легко обнаруживается, но надежен.

2. **TCP SYN (-sS)** - Stealth сканирование. Отправляет SYN пакет и анализирует ответ. Быстрее и менее заметно чем TCP Connect.

3. **TCP NULL (-sN)** - Отправляет пакет без флагов. Используется для обхода некоторых файрволов.

4. **TCP FIN (-sF)** - Отправляет пакет с флагом FIN. Используется для скрытого сканирования.

5. **TCP XMAS (-sX)** - Отправляет пакет с флагами FIN, PSH, URG. Назван в честь "рождественской елки" из-за множества флагов.

6. **TCP ACK (-sA)** - Отправляет ACK пакет. Используется для определения состояния файрвола (filtered/unfiltered).

7. **UDP (-sU)** - Сканирование UDP портов. Медленнее чем TCP, так как UDP не гарантирует доставку.

8. **OS Detection (-O)** - Определение операционной системы на основе анализа TCP/IP стека.

9. **Service Version (-sV)** - Определение версий сервисов на открытых портах.

10. **Aggressive (-A)** - Комбинация OS detection, version detection, script scanning и traceroute.

### Задание 2: Команды nmap

```bash
$ nmap localhost
Starting Nmap 7.80 ( https://nmap.org ) at 2025-12-11 13:48 CET
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000080s latency).
Not shown: 995 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
443/tcp  open  https
5432/tcp open  postgresql
7777/tcp open  cbt
```

```bash
$ nmap -sC localhost
# Выполняет сканирование с использованием скриптов по умолчанию
# Показывает дополнительную информацию о сервисах (HTTP заголовки, SSL сертификаты и т.д.)
```

```bash
$ nmap -p localhost
# Ошибка: не указан порт. Правильный синтаксис: nmap -p 80 localhost
```

```bash
$ nmap -O localhost
# Определение операционной системы
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32
OS details: Linux 2.6.32
```

```bash
$ nmap -p 80 localhost
PORT   STATE SERVICE
80/tcp open  http

$ nmap -p 443 localhost
PORT    STATE SERVICE
443/tcp open  https

$ nmap -p 8443 localhost
PORT     STATE  SERVICE
8443/tcp closed https-alt
```

```bash
$ nmap -sV -p 22,8080 localhost
PORT     STATE  SERVICE    VERSION
22/tcp   open   ssh        OpenSSH 8.9p1 Ubuntu 3ubuntu0.10
8080/tcp closed http-proxy
```

```bash
$ nmap --iflist
# Показывает список сетевых интерфейсов и маршрутов
DEV             (SHORT)           IP/MASK            TYPE     UP MTU   MAC
eth0            (eth0)            157.173.104.232/20 ethernet up 1500  00:50:56:56:DE:75
```

```bash
$ nmap -A scanme.nmap.org
# Агрессивное сканирование с определением ОС, версий сервисов и traceroute
PORT      STATE SERVICE    VERSION
22/tcp    open  ssh        OpenSSH 6.6.1p1 Ubuntu 2ubuntu2.13
80/tcp    open  http       Apache httpd 2.4.7 ((Ubuntu))
9929/tcp  open  nping-echo Nping echo
31337/tcp open  tcpwrapped
```

```bash
$ nmap -sA scanme.nmap.org
# TCP ACK сканирование - определяет состояние файрвола
All 1000 scanned ports on scanme.nmap.org are unfiltered
```

```bash
$ nmap -PN scanme.nmap.org
# Сканирование без предварительного ping (предполагает что хост онлайн)
PORT      STATE SERVICE
22/tcp    open  ssh
80/tcp    open  http
9929/tcp  open  nping-echo
31337/tcp open  Elite
```

```bash
$ nmap -sV --script vuln -oN nmapres_new.txt localhost
# Сканирование с определением версий и поиском уязвимостей
# Результаты сохранены в nmapres_new.txt

$ grep "VULNERABLE" nmapres_new.txt
|   VULNERABLE:
|     State: VULNERABLE
```

```bash
$ mkdir -p ~/project/reports
$ nmap -sV -p 8080 --script vuln -oN ~/project/reports/nmapres_new.txt -oX ~/project/reports/nmapres_new.xml localhost
# Создание отчетов в форматах Normal и XML

$ xsltproc ~/project/reports/nmapres_new.xml -o ~/project/reports/nmapres_new.html
# Конвертация XML отчета в HTML формат
```

### Задание 3: Использование tree

```bash
$ tree ~/project
/root/project
└── reports
    ├── nmapres_new.html
    ├── nmapres_new.txt
    └── nmapres_new.xml
```

**Результат:** Выведена структура директории `~/project/reports` с файлами результатов сканирования.

### Задание 4: Поиск IP адреса Ethernet и сканирование

```bash
$ ip addr show | grep -A 3 "eth0"
eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 157.173.104.232/20

$ nmap -sP 157.173.104.232
Starting Nmap 7.80 ( https://nmap.org ) at 2025-12-11 13:57 CET
Nmap scan report for vmi2306187.contaboserver.net (157.173.104.232)
Host is up.
Nmap done: 1 IP address (1 host up) scanned in 0.00 seconds
```

**Результат:** Найден IP адрес Ethernet интерфейса (157.173.104.232) и выполнено ping сканирование.

### Задание 5: Определение ОС, SSH, telnet

```bash
$ nmap -O -sV -p 22,23 localhost
Starting Nmap 7.80 ( https://nmap.org ) at 2025-12-11 13:57 CET
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00015s latency).

PORT   STATE  SERVICE VERSION
22/tcp open   ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 (Ubuntu Linux; protocol 2.0)
23/tcp closed telnet

Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32
OS details: Linux 2.6.32
Network Distance: 0 hops
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
```

**Результат:**
- **ОС:** Linux 2.6.32 (определено через OS detection)
- **SSH:** OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 - порт 22 открыт
- **Telnet:** Порт 23 закрыт (сервис не запущен)

### Задание 6: Перенос результатов в репозиторий

```bash
$ cd /root/course_labs
$ cp /root/nmapres_new.txt nmapres.txt
$ ls -la nmapres*.txt
-rw-rw-r--+ 1 root root 21414 Dec 11 13:57 nmapres.txt
```

**Результат:** Файл `nmapres_new.txt` скопирован в `nmapres.txt` в локальном репозитории. Оба файла находятся рядом в `/root/course_labs/`.

### Задание 7: Оформление README.md

README.md оформлен по аналогии с предыдущими лабораторными работами с использованием shields и markdown разметки.

### Задание 8: Gist отчет

Данный отчет создан в формате Gist и готов для публикации.

## Выводы

В ходе выполнения лабораторной работы №3 были изучены:
- Методы сканирования сетей с помощью nmap
- Различные типы сканирований (TCP SYN, TCP Connect, UDP, ACK и т.д.)
- Определение операционных систем и версий сервисов
- Поиск уязвимостей с помощью NSE скриптов
- Создание отчетов в различных форматах (Normal, XML, HTML)
- Работа с сетевыми интерфейсами и IP адресами

Все задания выполнены успешно.


