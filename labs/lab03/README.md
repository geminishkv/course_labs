<div align="center">
<h1><a id="intro">Лабораторная работа №3</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a> 
<a href="https://symbl.cc/en/unicode-table"><img src="https://img.shields.io/static/v1?logo=unicode&logoColor=fff&label=&message=Unicode&color=36393f&style=flat" alt="Unicode"></a> 
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<a href="https://img.shields.io/badge/Risk_Analyze-2448a2"><img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/AppSec-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge"></a></div>

***

Салют :wave:,<br>
Данная лабораторная работа посвещена изучению `nmap` и как с ним работать. Эта лабораторная работа послужит подпоркой для старта в выявлении и определении уязвимостей на уровне сканера портов, что бы освоить базовые методы сканирования. 


***
## Задание

✅ 1. Опишите используемые методы по их назначению, как они функционируют и какие результаты могут дать для оценки. Используйте сноску из материалов выше по флагам команд.
✅ 2. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ nmap localhost
$ nmap -sC localhost

$ nmap -p localhost
$ nmap -O localhost

$ nmap -p 80 localhost
$ nmap -p 443 localhost
$ nmap -p 8443 localhost
$ nmap -p "*" localhost
$ nmap -sV -p 22,8080 localhost

$ nmap -sP 192.168.1.0/24
$ nmap --open 192.168.1.1
$ nmap --packet-trace 192.168.1.1
$ nmap --packet-trace scanme.nmap.org 
$ nmap --iflist

$ nmap -iL scanme.nmap.org 
$ nmap -A -iL scanme.nmap.org 
$ nmap -sA scanme.nmap.org
$ nmap -PN scanme.nmap.org 

$ nmap --script=vuln IP_addr -vv
$ nmap -sV --script vuln -oN nmapres_new.txt localhost
$ cat > ./nmapres_new.txt # сделать подобный пример файлу exmp_targets.txt
$ grep "VULNERABLE" nmapres_new.txt

$ mkdir -p ~/project/reports
$ nmap -sV -p 8080 --script vuln -oN ~/project/reports/nmapres_new.txt -oX ~/project/reports/nmapres_new.xml localhost
$ xsltproc ~/project/reports/nmapres_new.xml -o ~/project/reports/nmapres_new.html
```

✅ 3. Используйте команду `tree` и выведите все вложенные файлы по директориям.
✅ 4.Найдите IP сетевой карты `Ethernet`, которая соответствует вашей виртуальной машине используя `ifconfig` и выполните команду

```bash
nmap -sP inet_addr
```

✅ 5. Определите ОС, данные ssh, telnet  с помощью `nmap` и выведитео них информацию.
✅ 6. Результаты из `nmapres_new.txt` надо перенести в `nmapres.txt` и оставить оба файла рядом в локальном репозитории. Желательно использовать `cp` в консоли через редактор.
✅ 7. Оформить `README.md` по аналогии и использовать `shield`, etc.
✅ 8. Составить `gist` отчет и отправить ссылку личным сообщением

***

## Выполнение

✅ 1. Опишите используемые методы по их назначению, как они функционируют и какие результаты могут дать для оценки. Используйте сноску из материалов выше по флагам команд.
✅ 2. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ nmap localhost
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap localhost

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:25 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000010s latency).
Other addresses for localhost (not scanned): ::1
All 1000 scanned ports on localhost (127.0.0.1) are in ignored states.
Not shown: 1000 closed tcp ports (reset)

Nmap done: 1 IP address (1 host up) scanned in 0.08 seconds

$ nmap -sC localhost  # -sC — запуск стандартных NSE-скриптов (определение сервисов, SSL, HTTP-info, баннеры)
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sC localhost

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:25 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000010s latency).
Other addresses for localhost (not scanned): ::1
All 1000 scanned ports on localhost (127.0.0.1) are in ignored states.
Not shown: 1000 closed tcp ports (reset)

Nmap done: 1 IP address (1 host up) scanned in 0.35 seconds

$ nmap -p localhost # -p  порт
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -p localhost

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:28 EST
Found no matches for the service mask 'localhost' and your specified protocols
QUITTING!

$ nmap -O localhost
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -O localhost
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 10:31 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000060s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE
22/tcp open  ssh
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32
OS details: Linux 2.6.32
Network Distance: 0 hops

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1.76 seconds

$ nmap -p 80 localhost
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -p 80 localhost

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:31 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000054s latency).
Other addresses for localhost (not scanned): ::1

PORT   STATE  SERVICE
80/tcp closed http

Nmap done: 1 IP address (1 host up) scanned in 0.07 seconds

$ nmap -p 443 localhost
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -p 443 localhost
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:32 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000078s latency).
Other addresses for localhost (not scanned): ::1

PORT    STATE  SERVICE
443/tcp closed https

Nmap done: 1 IP address (1 host up) scanned in 0.08 seconds

$ nmap -p 8443 localhost
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -p 8443 localhost

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:32 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000060s latency).
Other addresses for localhost (not scanned): ::1

PORT     STATE  SERVICE
8443/tcp closed https-alt

Nmap done: 1 IP address (1 host up) scanned in 0.10 seconds

$ nmap -p "*" localhost # "*" скан 65535 портов  
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -p "*" localhost

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:32 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000010s latency).
Other addresses for localhost (not scanned): ::1
All 8368 scanned ports on localhost (127.0.0.1) are in ignored states.
Not shown: 8368 closed tcp ports (reset)

Nmap done: 1 IP address (1 host up) scanned in 0.18 seconds

$ nmap -sV -p 22,8080 localhost # -sV - определение версии сервисов, -p 22,8080 — список портов
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sV -p 22,8080 localhost

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 10:34 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000067s latency).
Other addresses for localhost (not scanned): ::1

PORT     STATE  SERVICE    VERSION
22/tcp   open   ssh        OpenSSH 9.9p1 Debian 3 (protocol 2.0)
8080/tcp closed http-proxy
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.46 seconds

$ nmap -sP 192.168.1.0/24 # проверка активных хостов без сканирования портов
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sP 192.168.1.0/24
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:34 EST
Nmap scan report for 192.168.1.1
Host is up (0.0018s latency).
MAC Address: 1C:CA:41:4F:82:AE (Unknown)
Nmap scan report for 192.168.1.12
Host is up (0.00080s latency).
MAC Address: 98:5F:41:7C:F9:84 (Unknown)
Nmap scan report for 192.168.1.25
Host is up (0.069s latency).
MAC Address: 12:4A:51:BA:D8:69 (Unknown)
Nmap scan report for 192.168.1.14
Host is up.
Nmap done: 256 IP addresses (4 hosts up) scanned in 2.85 seconds

$ nmap --open 192.168.1.1 # фильтрует вывод, скрывая closed / filtered, только открытые порты
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap --open 192.168.1.1
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 10:36 EST
Nmap scan report for 192.168.1.1
Host is up (0.0028s latency).
Not shown: 998 filtered tcp ports (no-response)
Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
PORT      STATE SERVICE
80/tcp    open  http
52869/tcp open  unknown
MAC Address: 1C:CA:41:4F:82:AE (Unknown)

Nmap done: 1 IP address (1 host up) scanned in 4.83 seconds

$ nmap --packet-trace 192.168.1.1 # показывает отправленные/полученные пакеты
$ nmap --packet-trace scanme.nmap.org
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.19s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
Not shown: 995 closed tcp ports (reset)
PORT      STATE    SERVICE
22/tcp    open     ssh
25/tcp    filtered smtp
80/tcp    open     http
9929/tcp  open     nping-echo
31337/tcp open     Elite
 
$ nmap --iflist # вывод всех интерфейсов и маршрутов
──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap --iflist
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:37 EST
************************INTERFACES************************
DEV  (SHORT) IP/MASK                     TYPE     UP MTU   MAC
lo   (lo)    127.0.0.1/8                 loopback up 65536
lo   (lo)    ::1/128                     loopback up 65536
eth0 (eth0)  192.168.1.14/24             ethernet up 1500  08:00:27:59:13:23
eth0 (eth0)  fe80::a00:27ff:fe59:1323/64 ethernet up 1500  08:00:27:59:13:23

**************************ROUTES**************************
DST/MASK                     DEV  METRIC GATEWAY
192.168.1.0/24               eth0 100
0.0.0.0/0                    eth0 100    192.168.1.1
::1/128                      lo   0
fe80::a00:27ff:fe59:1323/128 eth0 0
fe80::/64                    eth0 1024
ff00::/8                     eth0 256

$ nmap -iL scanme.nmap.org # -iL (Input List) загружает адреса из файла
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -iL targets.txt                
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:39 EST
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.19s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
Not shown: 995 closed tcp ports (reset)
PORT      STATE    SERVICE
22/tcp    open     ssh
25/tcp    filtered smtp
80/tcp    open     http
9929/tcp  open     nping-echo
31337/tcp open     Elite

Nmap done: 1 IP address (1 host up) scanned in 6.69 seconds

$ nmap -A -iL scanme.nmap.org # -A включает ОС + версии сервисов + traceroute + NSE scripts 
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -A -iL targets.txt    
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:41 EST
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.19s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
Not shown: 995 closed tcp ports (reset)
PORT      STATE    SERVICE    VERSION
22/tcp    open     ssh        OpenSSH 6.6.1p1 Ubuntu 2ubuntu2.13 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   1024 ac:00:a0:1a:82:ff:cc:55:99:dc:67:2b:34:97:6b:75 (DSA)
|   2048 20:3d:2d:44:62:2a:b0:5a:9d:b5:b3:05:14:c2:a6:b2 (RSA)
|   256 96:02:bb:5e:57:54:1c:4e:45:2f:56:4c:4a:24:b2:57 (ECDSA)
|_  256 33:fa:91:0f:e0:e1:7b:1f:6d:05:a2:b0:f1:54:41:56 (ED25519)
25/tcp    filtered smtp
80/tcp    open     http       Apache httpd 2.4.7 ((Ubuntu))
|_http-title: Go ahead and ScanMe!
|_http-favicon: Nmap Project
|_http-server-header: Apache/2.4.7 (Ubuntu)
9929/tcp  open     nping-echo Nping echo
31337/tcp open     tcpwrapped
Aggressive OS guesses: Linux 2.6.32 (96%), Linux 2.6.32 or 3.10 (96%), Linux 4.4 (96%), Linux 2.6.32 - 2.6.35 (94%), Linux 2.6.32 - 2.6.39 (94%), Linux 4.0 (94%), Linux 5.0 - 5.4 (93%), Linux 3.11 - 4.1 (92%), Linux 3.2 - 3.8 (92%), Linux 2.6.18 (92%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 18 hops
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 256/tcp)
HOP RTT       ADDRESS
1   1.89 ms   192.168.1.1
2   ... 4
5   65.59 ms  85.21.224.83
6   46.42 ms  195.22.214.196
7   138.73 ms 195.22.195.35
8   142.82 ms 195.22.206.81
9   ...
10  133.49 ms ae3.r23.iad02.icn.netarch.akamai.com (23.209.165.141)
11  ...
12  197.61 ms ae16.r01.sjc01.icn.netarch.akamai.com (23.32.62.79)
13  185.33 ms ae2.r12.sjc01.ien.netarch.akamai.com (23.207.232.41)
14  192.54 ms ae22.gw4.scz1.netarch.akamai.com (23.203.158.53)
15  ... 17
18  193.02 ms scanme.nmap.org (45.33.32.156)

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 32.41 seconds


$ nmap -sA scanme.nmap.org # -sA - фильтрует ли firewall
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sA scanme.nmap.org

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:42 EST
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.19s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
All 1000 scanned ports on scanme.nmap.org (45.33.32.156) are in ignored states.
Not shown: 1000 filtered tcp ports (no-response)

Nmap done: 1 IP address (1 host up) scanned in 198.42 seconds


$ nmap -PN scanme.nmap.org # не проверяет доступность хоста с помощью ping
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -PN scanme.nmap.org
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:46 EST
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.19s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
Not shown: 995 closed tcp ports (reset)
PORT      STATE    SERVICE
22/tcp    open     ssh
25/tcp    filtered smtp
80/tcp    open     http
9929/tcp  open     nping-echo
31337/tcp open     Elite

Nmap done: 1 IP address (1 host up) scanned in 7.39 seconds

$ nmap --script=vuln IP_addr -vv

$ nmap -sV --script vuln -oN nmapres_new.txt localhost # -sV — версии сервисов, --script vuln — поиск уязвимостей, -oN file — сохранить обычный текстовый отчёт
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sV --script vuln -oN nmapres_new.txt localhost
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 09:58 EST
Pre-scan script results:
| broadcast-avahi-dos: 
|   Discovered hosts:
|     224.0.0.251
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|_  Hosts are all up (not vulnerable).
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000010s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 9.9p1 Debian 3 (protocol 2.0)
| vulners: 
|   cpe:/a:openbsd:openssh:9.9p1: 
|       PACKETSTORM:189283      6.8     https://vulners.com/packetstorm/PACKETSTORM:189283 *EXPLOIT*
|       CVE-2025-26465  6.8     https://vulners.com/cve/CVE-2025-26465
|       9D8432B9-49EC-5F45-BB96-329B1F2B2254    6.8https://vulners.com/githubexploit/9D8432B9-49EC-5F45-BB96-329B1F2B2254     *EXPLOIT*
|       85FCDCC6-9A03-597E-AB4F-FA4DAC04F8D0    6.8https://vulners.com/githubexploit/85FCDCC6-9A03-597E-AB4F-FA4DAC04F8D0     *EXPLOIT*
|       1337DAY-ID-39918        6.8     https://vulners.com/zdt/1337DAY-ID-39918   *EXPLOIT*
|       CVE-2025-26466  5.9     https://vulners.com/cve/CVE-2025-26466
|       CVE-2025-32728  4.3     https://vulners.com/cve/CVE-2025-32728
|       OSV:BELL-CVE-2025-32728 3.8     https://vulners.com/osv/OSV:BELL-CVE-2025-32728
|       OSV:BELL-CVE-2025-61985 3.6     https://vulners.com/osv/OSV:BELL-CVE-2025-61985
|       OSV:BELL-CVE-2025-61984 3.6     https://vulners.com/osv/OSV:BELL-CVE-2025-61984
|       CVE-2025-61985  3.6     https://vulners.com/cve/CVE-2025-61985
|       CVE-2025-61984  3.6     https://vulners.com/cve/CVE-2025-61984
|       B7EACB4F-A5CF-5C5A-809F-E03CCE2AB150    3.6https://vulners.com/githubexploit/B7EACB4F-A5CF-5C5A-809F-E03CCE2AB150     *EXPLOIT*
|_      4C6E2182-0E99-5626-83F6-1646DD648C57    3.6https://vulners.com/githubexploit/4C6E2182-0E99-5626-83F6-1646DD648C57     *EXPLOIT*
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 35.00 seconds

──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ grep "CVE" nmapres_new.txt
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|       CVE-2025-26465  6.8     https://vulners.com/cve/CVE-2025-26465
|       CVE-2025-26466  5.9     https://vulners.com/cve/CVE-2025-26466
|       CVE-2025-32728  4.3     https://vulners.com/cve/CVE-2025-32728
|       OSV:BELL-CVE-2025-32728 3.8     https://vulners.com/osv/OSV:BELL-CVE-2025-32728
|       OSV:BELL-CVE-2025-61985 3.6     https://vulners.com/osv/OSV:BELL-CVE-2025-61985
|       OSV:BELL-CVE-2025-61984 3.6     https://vulners.com/osv/OSV:BELL-CVE-2025-61984
|       CVE-2025-61985  3.6     https://vulners.com/cve/CVE-2025-61985
|       CVE-2025-61984  3.6     https://vulners.com/cve/CVE-2025-61984


$ mkdir -p ~/project/reports
$ nmap -sV -p 8080 --script vuln -oN ~/project/reports/nmapres_new.txt -oX ~/project/reports/nmapres_new.xml localhost # -oN — сохранить текстовый отчёт, -oX — сохранить XML отчёт, -sV — определение версий сервисов, -p 8080 — только порт 8080, --script vuln — запуск vuln-скриптов

┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sV --script vuln -oN ~/project/reports/nmapres_new.txt -oX ~/project/reports/nmapres_new.xml localhost 
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 10:07 EST
Pre-scan script results:
| broadcast-avahi-dos: 
|   Discovered hosts:
|     224.0.0.251
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|_  Hosts are all up (not vulnerable).
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000010s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 9.9p1 Debian 3 (protocol 2.0)
| vulners: 
|   cpe:/a:openbsd:openssh:9.9p1: 
|       PACKETSTORM:189283      6.8     https://vulners.com/packetstorm/PACKETSTORM:189283 *EXPLOIT*
|       CVE-2025-26465  6.8     https://vulners.com/cve/CVE-2025-26465
|       9D8432B9-49EC-5F45-BB96-329B1F2B2254    6.8https://vulners.com/githubexploit/9D8432B9-49EC-5F45-BB96-329B1F2B2254     *EXPLOIT*
|       85FCDCC6-9A03-597E-AB4F-FA4DAC04F8D0    6.8https://vulners.com/githubexploit/85FCDCC6-9A03-597E-AB4F-FA4DAC04F8D0     *EXPLOIT*
|       1337DAY-ID-39918        6.8     https://vulners.com/zdt/1337DAY-ID-39918   *EXPLOIT*
|       CVE-2025-26466  5.9     https://vulners.com/cve/CVE-2025-26466
|       CVE-2025-32728  4.3     https://vulners.com/cve/CVE-2025-32728
|       OSV:BELL-CVE-2025-32728 3.8     https://vulners.com/osv/OSV:BELL-CVE-2025-32728
|       OSV:BELL-CVE-2025-61985 3.6     https://vulners.com/osv/OSV:BELL-CVE-2025-61985
|       OSV:BELL-CVE-2025-61984 3.6     https://vulners.com/osv/OSV:BELL-CVE-2025-61984
|       CVE-2025-61985  3.6     https://vulners.com/cve/CVE-2025-61985
|       CVE-2025-61984  3.6     https://vulners.com/cve/CVE-2025-61984
|       B7EACB4F-A5CF-5C5A-809F-E03CCE2AB150    3.6https://vulners.com/githubexploit/B7EACB4F-A5CF-5C5A-809F-E03CCE2AB150     *EXPLOIT*
|_      4C6E2182-0E99-5626-83F6-1646DD648C57    3.6https://vulners.com/githubexploit/4C6E2182-0E99-5626-83F6-1646DD648C57     *EXPLOIT*
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 35.04 seconds

$ xsltproc ~/project/reports/nmapres_new.xml -o ~/project/reports/nmapres_new.html # xsltproc — XSLT процессор, делает web-страницу из XML отчёта
```

✅ 3. Используйте команду `tree` и выведите все вложенные файлы по директориям.
``` bash
├── project
│   └── reports
│       ├── nmapres_new.html
│       ├── nmapres_new.txt
│       └── nmapres_new.xml
```
✅ 4.Найдите IP сетевой карты `Ethernet`, которая соответствует вашей виртуальной машине используя `ifconfig` и выполните команду

``` bash
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ ifconfig

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.14  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::a00:27ff:fe59:1323  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:59:13:23  txqueuelen 1000  (Ethernet)
        RX packets 179384  bytes 61623241 (58.7 MiB)
        RX errors 0  dropped 2  overruns 0  frame 0
        TX packets 36208  bytes 4415023 (4.2 MiB)
        TX errors 0  dropped 24 overruns 0  carrier 0  collisions 0



$ nmap -sP inet_addr

┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sP 291.168.1.14

Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 10:22 EST
Nmap scan report for 291.168.1.14 (192.168.1.1)
Host is up (0.0017s latency).
MAC Address: 1C:CA:41:4F:82:AE (Unknown)
Nmap done: 1 IP address (1 host up) scanned in 0.15 seconds

```

✅ 5. Определите ОС, данные ssh, telnet  с помощью `nmap` и выведитео них информацию.
``` bash
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -O 192.168.1.14  
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 10:23 EST
Nmap scan report for 192.168.1.14
Host is up (0.000047s latency).
Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE
22/tcp open  ssh
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32
OS details: Linux 2.6.32
Network Distance: 0 hops

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1.84 seconds

┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sV -p 23 192.168.1.14
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 10:25 EST
Nmap scan report for 192.168.1.14
Host is up (0.000033s latency).

PORT   STATE  SERVICE VERSION
23/tcp closed telnet

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.17 seconds

┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ nmap -sV -p 22 192.168.1.14
Starting Nmap 7.94SVN ( https://nmap.org ) at 2026-01-14 10:26 EST
Nmap scan report for 192.168.1.14
Host is up (0.000090s latency).

PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 9.9p1 Debian 3 (protocol 2.0)
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.20 seconds


```
✅ 6. Результаты из `nmapres_new.txt` надо перенести в `nmapres.txt` и оставить оба файла рядом в локальном репозитории. Желательно использовать `cp` в консоли через редактор.
``` bash
                                                   
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ cp nmapres_new.txt nmapres.txt
                                                   
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ cp nmapres_new.txt ../lab02/nmapres.txt
                                                   
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ ls
exmp_targets.txt  nmapres.txt  targets.txt
nmapres_new.txt   README.md
                                                   
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ ls ../lab02
exmpl_hello.py  pygamesteel.py  screen
nmapres.txt     README.md       venv
                                                   
┌──(tigo㉿tigo)-[~/course_labs/labs/lab03]
└─$ cat ../lab02/nmapres.txt               
# Nmap 7.94SVN scan initiated Wed Jan 14 10:02:11 2026 as: /usr/lib/nmap/nmap --privileged -sV --script vuln -oN nmapres_new.txt localhost
Pre-scan script results:
| broadcast-avahi-dos: 
|   Discovered hosts:
|     224.0.0.251
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|_  Hosts are all up (not vulnerable).
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000010s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 9.9p1 Debian 3 (protocol 2.0)
| vulners: 
|   cpe:/a:openbsd:openssh:9.9p1: 
|       PACKETSTORM:189283      6.8     https://vulners.com/packetstorm/PACKETSTORM:189283 *EXPLOIT*
|       CVE-2025-26465  6.8     https://vulners.com/cve/CVE-2025-26465
|       9D8432B9-49EC-5F45-BB96-329B1F2B2254    6.8https://vulners.com/githubexploit/9D8432B9-49EC-5F45-BB96-329B1F2B2254     *EXPLOIT*
|       85FCDCC6-9A03-597E-AB4F-FA4DAC04F8D0    6.8https://vulners.com/githubexploit/85FCDCC6-9A03-597E-AB4F-FA4DAC04F8D0     *EXPLOIT*
|       1337DAY-ID-39918        6.8     https://vulners.com/zdt/1337DAY-ID-39918   *EXPLOIT*
|       CVE-2025-26466  5.9     https://vulners.com/cve/CVE-2025-26466
|       CVE-2025-32728  4.3     https://vulners.com/cve/CVE-2025-32728
|       OSV:BELL-CVE-2025-32728 3.8     https://vulners.com/osv/OSV:BELL-CVE-2025-32728
|       OSV:BELL-CVE-2025-61985 3.6     https://vulners.com/osv/OSV:BELL-CVE-2025-61985
|       OSV:BELL-CVE-2025-61984 3.6     https://vulners.com/osv/OSV:BELL-CVE-2025-61984
|       CVE-2025-61985  3.6     https://vulners.com/cve/CVE-2025-61985
|       CVE-2025-61984  3.6     https://vulners.com/cve/CVE-2025-61984
|       B7EACB4F-A5CF-5C5A-809F-E03CCE2AB150    3.6https://vulners.com/githubexploit/B7EACB4F-A5CF-5C5A-809F-E03CCE2AB150     *EXPLOIT*
|_      4C6E2182-0E99-5626-83F6-1646DD648C57    3.6https://vulners.com/githubexploit/4C6E2182-0E99-5626-83F6-1646DD648C57     *EXPLOIT*
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Wed Jan 14 10:02:46 2026 -- 1 IP address (1 host up) scanned in 34.99 seconds

```

✅ 7. Оформить `README.md` по аналогии и использовать `shield`, etc.
✅ 8. Составить `gist` отчет и отправить ссылку личным сообщением
