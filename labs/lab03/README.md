<div align="center">
<h1><a id="intro">Лабораторная работа №3</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a> 
<a href="https://symbl.cc/en/unicode-table"><img src="https://img.shields.io/static/v1?logo=unicode&logoColor=fff&label=&message=Unicode&color=36393f&style=flat" alt="Unicode"></a> 
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<a href="https://img.shields.io/badge/Risk_Analyze-2448a2"><img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/AppSec-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/Contributor-Анисимов_М._А.-8b9aff" alt="Contributor Badge"></a></div>

***

## Задание

- ✅ 1. Опишите используемые методы по их назначению, как они функционируют и какие результаты могут дать для оценки. Используйте сноску из материалов выше по флагам команд.

`Nmap (Network Mapper)` - инструмент для исследования сети и аудита безопасности.

**Основные методы сканирования:**

`nmap localhost` - базовое TCP-сканирование (SYN scan) портов

`-sC` - выполнение скриптов из категории default для обнаружения служб

`-O` - определение операционной системы по стеку TCP/IP

`-p` - сканирование конкретных портов (80 - HTTP, 443 - HTTPS, 22 - SSH)

`-sV` - определение версий служб на открытых портах

`-sP` - ping-сканирование для обнаружения активных хостов

`--open` - показывать только открытые порты

`--script=vuln` - выполнение скриптов для поиска уязвимостей

- ✅ 2. Выведите на терминале и проанализируйте следующие команды консоли

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

- `nmap localhost` Сканирует наиболее распространенные порты на локальной машине
- `nmap -sC localhost` Выполняет базовые скрипты обнаружения служб

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap localhost  
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:46 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000012s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE
5000/tcp filtered upnp

Nmap done: 1 IP address (1 host up) scanned in 1.35 seconds
                                                                                                                 
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -sC localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:47 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000070s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE
5000/tcp filtered upnp

Nmap done: 1 IP address (1 host up) scanned in 1.46 seconds```

- `nmap -p localhost` Скинирование конкретного порта (нужно указывать порт)
- `nmap -O localhost` Определение ОС

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -p localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:48 EST
Found no matches for the service mask 'localhost' and your specified protocols
QUITTING!
                                                                                                                 
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -O localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:48 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000097s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE
5000/tcp filtered upnp
Too many fingerprints match this host to give specific OS details
Network Distance: 0 hops

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 2.90 seconds```

- `nmap -p 80 localhost` Проверка HTTP порта
- `nmap -p 443 localhost` Проверка HTTPS порта  
- `nmap -p 8443 localhost` Проверка альтернативного HTTPS

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -p 80 localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:49 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000051s latency).
Other addresses for localhost (not scanned): ::1

PORT   STATE  SERVICE
80/tcp closed http

Nmap done: 1 IP address (1 host up) scanned in 0.10 seconds
                                                                                                                 
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -p 443 localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:49 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000037s latency).
Other addresses for localhost (not scanned): ::1

PORT    STATE  SERVICE
443/tcp closed https

Nmap done: 1 IP address (1 host up) scanned in 0.07 seconds
                                                                                                                 
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -p 8443 localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:49 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000046s latency).
Other addresses for localhost (not scanned): ::1

PORT     STATE  SERVICE
8443/tcp closed https-alt

Nmap done: 1 IP address (1 host up) scanned in 0.09 seconds```

- `nmap -p "*" localhost` Сканирование всех портов (1-65535)
- `nmap -sV -p 22,8080 localhost` Проверка версий служб на портах 22 и 8080

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -p "*" localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:49 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000030s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 8375 closed tcp ports (reset)
PORT     STATE    SERVICE
2377/tcp open     swarm
5000/tcp filtered upnp

Nmap done: 1 IP address (1 host up) scanned in 1.37 seconds
                                                                                                                 
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -sV -p 22,8080 localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:50 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000047s latency).
Other addresses for localhost (not scanned): ::1

PORT     STATE  SERVICE    VERSION
22/tcp   closed ssh
8080/tcp closed http-proxy

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.20 seconds
                                                                                                                 
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap -sP 192.168.1.0/24 
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:50 EST
Nmap scan report for 192.168.1.1
Host is up (0.0013s latency).
MAC Address: 50:FF:20:EC:4D:C7 (Keenetic Limited)
Nmap scan report for 192.168.1.39
Host is up (0.014s latency).
MAC Address: AC:BA:C0:57:7E:AE (Intertech Services AG)
Nmap scan report for 192.168.1.56
Host is up (0.021s latency).
MAC Address: B0:4A:39:A5:9D:E7 (Beijing Roborock Technology)
Nmap scan report for 192.168.1.63
Host is up (0.0010s latency).
MAC Address: E4:60:17:9B:E4:B6 (Intel Corporate)
Nmap scan report for 192.168.1.137
Host is up (0.095s latency).
MAC Address: 22:8A:8E:85:07:90 (Unknown)
Nmap scan report for 192.168.1.107
Host is up.
Nmap done: 256 IP addresses (6 hosts up) scanned in 3.26 seconds
                                                                                                                 
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap --open 192.168.1.1       
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:50 EST
Nmap scan report for 192.168.1.1
Host is up (0.0022s latency).
Not shown: 992 closed tcp ports (reset)
PORT     STATE SERVICE
23/tcp   open  telnet
53/tcp   open  domain
80/tcp   open  http
139/tcp  open  netbios-ssn
443/tcp  open  https
445/tcp  open  microsoft-ds
1900/tcp open  upnp
3517/tcp open  802-11-iapp
MAC Address: 50:FF:20:EC:4D:C7 (Keenetic Limited)

Nmap done: 1 IP address (1 host up) scanned in 0.59 seconds
```


- `nmap --packet-trace 192.168.1.1` Трассировка отправляемых пакетов

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap --packet-trace 192.168.1.1
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:50 EST
SENT (0.0530s) ARP who-has 192.168.1.1 tell 192.168.1.107
RCVD (0.0544s) ARP reply 192.168.1.1 is-at 50:FF:20:EC:4D:C7
NSOCK INFO [0.1020s] nsock_iod_new2(): nsock_iod_new (IOD #1)
NSOCK INFO [0.1020s] nsock_connect_udp(): UDP connection requested to fe80::52ff:20ff:feec:4dc7:53 (IOD #1) EID 8
NSOCK INFO [0.1020s] nsock_read(): Read request from IOD #1 [fe80::52ff:20ff:feec:4dc7:53] (timeout: -1ms) EID 18
NSOCK INFO [0.1020s] nsock_iod_new2(): nsock_iod_new (IOD #2)
NSOCK INFO [0.1020s] nsock_connect_udp(): UDP connection requested to 192.168.1.1:53 (IOD #2) EID 24
NSOCK INFO [0.1020s] nsock_read(): Read request from IOD #2 [192.168.1.1:53] (timeout: -1ms) EID 34
NSOCK INFO [0.1020s] nsock_write(): Write request for 42 bytes to IOD #1 EID 43 [fe80::52ff:20ff:feec:4dc7:53]
NSOCK INFO [0.1020s] nsock_trace_handler_callback(): Callback: CONNECT SUCCESS for EID 8 [fe80::52ff:20ff:feec:4dc7:53]
NSOCK INFO [0.1020s] nsock_trace_handler_callback(): Callback: WRITE SUCCESS for EID 43 [fe80::52ff:20ff:feec:4dc7:53]
NSOCK INFO [0.1020s] nsock_trace_handler_callback(): Callback: CONNECT SUCCESS for EID 24 [192.168.1.1:53]
NSOCK INFO [0.1030s] nsock_trace_handler_callback(): Callback: READ SUCCESS for EID 18 [fe80::52ff:20ff:feec:4dc7:53] (42 bytes): 79...........1.1.168.192.in-addr.arpa.....
NSOCK INFO [0.1030s] nsock_read(): Read request from IOD #1 [fe80::52ff:20ff:feec:4dc7:53] (timeout: -1ms) EID 50
NSOCK INFO [0.1030s] nsock_iod_delete(): nsock_iod_delete (IOD #1)
NSOCK INFO [0.1030s] nevent_delete(): nevent_delete on event #50 (type READ)
NSOCK INFO [0.1030s] nsock_iod_delete(): nsock_iod_delete (IOD #2)
NSOCK INFO [0.1030s] nevent_delete(): nevent_delete on event #34 (type READ)
SENT (0.1254s) TCP 192.168.1.107:35866 > 192.168.1.1:1025 S ttl=55 id=54063 iplen=44  seq=383347002 win=1024 <mss 1460>

...
CVD (0.2228s) TCP 192.168.1.1:15004 > 192.168.1.107:35866 RA ttl=64 id=0 iplen=40  seq=0 win=0 
RCVD (0.2228s) TCP 192.168.1.1:7025 > 192.168.1.107:35866 RA ttl=64 id=0 iplen=40  seq=0 win=0 
Nmap scan report for 192.168.1.1
Host is up (0.0024s latency).
Not shown: 992 closed tcp ports (reset)
PORT     STATE SERVICE
23/tcp   open  telnet
53/tcp   open  domain
80/tcp   open  http
139/tcp  open  netbios-ssn
443/tcp  open  https
445/tcp  open  microsoft-ds
1900/tcp open  upnp
3517/tcp open  802-11-iapp
MAC Address: 50:FF:20:EC:4D:C7 (Keenetic Limited)

Nmap done: 1 IP address (1 host up) scanned in 0.27 seconds```

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap --packet-trace scanme.nmap.org
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:53 EST
SENT (0.4624s) ICMP [192.168.1.107 > 45.33.32.156 Echo request (type=8/code=0) id=9775 seq=0] IP [ttl=47 id=37420 iplen=28 ]
SENT (0.4626s) TCP 192.168.1.107:44095 > 45.33.32.156:443 S ttl=54 id=20575 iplen=44  seq=2747561361 win=1024 <mss 1460>
SENT (0.4627s) TCP 192.168.1.107:44095 > 45.33.32.156:80 A ttl=37 id=44797 iplen=40  seq=0 win=1024 
SENT (0.4629s) ICMP [192.168.1.107 > 45.33.32.156 Timestamp request (type=13/code=0) id=18912 seq=0 orig=0 recv=0 trans=0] IP [ttl=50 id=51054 iplen=40 ]
RCVD (0.6440s) TCP 45.33.32.156:443 > 192.168.1.107:44095 RA ttl=43 id=0 iplen=40  seq=0 win=0 
NSOCK INFO [0.7460s] nsock_iod_new2(): nsock_iod_new (IOD #1)
NSOCK INFO [0.7460s] nsock_connect_udp(): UDP connection requested to fe80::52ff:20ff:feec:4dc7:53 (IOD #1) EID 8
NSOCK INFO [0.7460s] nsock_read(): Read request from IOD #1 [fe80::52ff:20ff:feec:4dc7:53] (timeout: -1ms) EID 18
NSOCK INFO [0.7460s] nsock_iod_new2(): nsock_iod_new (IOD #2)
NSOCK INFO [0.7460s] nsock_connect_udp(): UDP connection requested to 192.168.1.1:53 (IOD #2) EID 24
NSOCK INFO [0.7460s] nsock_read(): Read request from IOD #2 [192.168.1.1:53] (timeout: -1ms) EID 34
NSOCK INFO [0.7460s] nsock_write(): Write request for 43 bytes to IOD #1 EID 43 [fe80::52ff:20ff:feec:4dc7:53]
NSOCK INFO [0.7460s] nsock_trace_handler_callback(): Callback: CONNECT SUCCESS for EID 8 [fe80::52ff:20ff:feec:4dc7:53]
NSOCK INFO [0.7460s] nsock_trace_handler_callback(): Callback: WRITE SUCCESS for EID 43 [fe80::52ff:20ff:feec:4dc7:53]
NSOCK INFO [0.7460s] nsock_trace_handler_callback(): Callback: CONNECT SUCCESS for EID 24 [192.168.1.1:53]
NSOCK INFO [0.7540s] nsock_trace_handler_callback(): Callback: READ SUCCESS for EID 18 [fe80::52ff:20ff:feec:4dc7:53] (72 bytes): $............156.32.33.45.in-addr.arpa..................scanme.nmap.org.
NSOCK INFO [0.7540s] nsock_read(): Read request from IOD #1 [fe80::52ff:20ff:feec:4dc7:53] (timeout: -1ms) EID 50
NSOCK INFO [0.7540s] nsock_iod_delete(): nsock_iod_delete (IOD #1)
NSOCK INFO [0.7540s] nevent_delete(): nevent_delete on event #50 (type RE

...

CVD (3.3686s) TCP 45.33.32.156:1051 > 192.168.1.107:44351 RA ttl=41 id=0 iplen=40  seq=0 win=0 
RCVD (3.3686s) TCP 45.33.32.156:88 > 192.168.1.107:44351 RA ttl=43 id=0 iplen=40  seq=0 win=0 
RCVD (3.3691s) TCP 45.33.32.156:7025 > 192.168.1.107:44351 RA ttl=43 id=0 iplen=40  seq=0 win=0 
RCVD (3.3691s) TCP 45.33.32.156:9485 > 192.168.1.107:44351 RA ttl=43 id=0 iplen=40  seq=0 win=0 
RCVD (3.3705s) TCP 45.33.32.156:1042 > 192.168.1.107:44351 RA ttl=43 id=0 iplen=40  seq=0 win=0 
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.19s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
Not shown: 996 closed tcp ports (reset)
PORT      STATE SERVICE
22/tcp    open  ssh
80/tcp    open  http
9929/tcp  open  nping-echo
31337/tcp open  Elite

Nmap done: 1 IP address (1 host up) scanned in 3.41 seconds```

- `nmap --iflist` Вывод списка сетевых интерфейсов и информации о маршрутах системы

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs]
└─$ nmap --iflist
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:54 EST
************************INTERFACES************************
DEV             (SHORT)           IP/MASK                                    TYPE     UP MTU   MAC
lo              (lo)              127.0.0.1/8                                loopback up 65536
lo              (lo)              ::1/128                                    loopback up 65536
eth0            (eth0)            192.168.1.107/24                           ethernet up 1500  08:00:27:F5:7D:62
eth0            (eth0)            2a02:2168:a576:d800:1fb3:e9fe:ba1b:8bbb/64 ethernet up 1500  08:00:27:F5:7D:62
eth0            (eth0)            fd79:cf8d:3311:0:f30:1f0d:b734:61cd/64     ethernet up 1500  08:00:27:F5:7D:62
eth0            (eth0)            fe80::dab1:a3b5:d317:7e74/64               ethernet up 1500  08:00:27:F5:7D:62
docker_gwbridge (docker_gwbridge) 172.18.0.1/16                              ethernet up 1500  02:42:9D:0F:3D:A6
docker_gwbridge (docker_gwbridge) fe80::42:9dff:fe0f:3da6/64                 ethernet up 1500  02:42:9D:0F:3D:A6
br-8a185c329dd6 (br-8a185c329dd6) 172.21.0.1/16                              ethernet up 1500  02:42:ED:51:77:14
br-8a185c329dd6 (br-8a185c329dd6) fe80::42:edff:fe51:7714/64                 ethernet up 1500  02:42:ED:51:77:14
br-8cf8ec664aa0 (br-8cf8ec664aa0) 172.19.0.1/16                              ethernet up 1500  02:42:00:F8:4B:A4
docker0         (docker0)         172.17.0.1/16                              ethernet up 1500  02:42:C9:A4:04:B6
veth61c4aa0     (veth61c4aa0)     (none)/0                                   ethernet up 1500  4E:37:7D:5D:8F:20
veth61c4aa0     (veth61c4aa0)     fe80::4c37:7dff:fe5d:8f20/64               ethernet up 1500  4E:37:7D:5D:8F:20
vethe6cb588     (vethe6cb588)     (none)/0                                   ethernet up 1500  AA:9F:31:C7:52:09
vethe6cb588     (vethe6cb588)     fe80::a89f:31ff:fec7:5209/64               ethernet up 1500  AA:9F:31:C7:52:09
vethdb8d717     (vethdb8d717)     (none)/0                                   ethernet up 1500  F2:93:02:0D:C2:17
vethdb8d717     (vethdb8d717)     fe80::f093:2ff:fe0d:c217/64                ethernet up 1500  F2:93:02:0D:C2:17

**************************ROUTES**************************
DST/MASK                                    DEV             METRIC GATEWAY
192.168.1.0/24                              eth0            100
172.17.0.0/16                               docker0         0
172.18.0.0/16                               docker_gwbridge 0
172.19.0.0/16                               br-8cf8ec664aa0 0
172.21.0.0/16                               br-8a185c329dd6 0
0.0.0.0/0                                   eth0            100    192.168.1.1
::1/128                                     lo              0
2a02:2168:a576:d800:1fb3:e9fe:ba1b:8bbb/128 eth0            0
fd79:cf8d:3311:0:f30:1f0d:b734:61cd/128     eth0            0
fe80::42:9dff:fe0f:3da6/128                 docker_gwbridge 0
fe80::42:edff:fe51:7714/128                 br-8a185c329dd6 0
fe80::4c37:7dff:fe5d:8f20/128               veth61c4aa0     0
fe80::a89f:31ff:fec7:5209/128               vethe6cb588     0
fe80::dab1:a3b5:d317:7e74/128               eth0            0
fe80::f093:2ff:fe0d:c217/128                vethdb8d717     0
2001:2:7847:1251:feee:ed78:4712:5180/128    eth0            100    fe80::52ff:20ff:feec:4dc7
2a02:2168:a576:d800::/64                    eth0            100
fd79:cf8d:3311::/64                         eth0            100
fe80::/64                                   veth61c4aa0     256
fe80::/64                                   br-8a185c329dd6 256
fe80::/64                                   vethe6cb588     256
fe80::/64                                   docker_gwbridge 256
fe80::/64                                   vethdb8d717     256
fe80::/64                                   eth0            1024
ff00::/8                                    eth0            256
ff00::/8                                    veth61c4aa0     256
ff00::/8                                    br-8a185c329dd6 256
ff00::/8                                    vethe6cb588     256
ff00::/8                                    docker_gwbridge 256
ff00::/8                                    vethdb8d717     256
::/0                                        eth0            100    fe80::52ff:20ff:feec:4dc7
```

- `nmap -iL exmp_targets.txt` Сканирование из файла

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -iL exmp_targets.txt
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:55 EST
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.18s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
Not shown: 996 closed tcp ports (reset)
PORT      STATE SERVICE
22/tcp    open  ssh
80/tcp    open  http
9929/tcp  open  nping-echo
31337/tcp open  Elite

Nmap scan report for 192.168.1.1
Host is up (0.0028s latency).
Not shown: 992 closed tcp ports (reset)
PORT     STATE SERVICE
23/tcp   open  telnet
53/tcp   open  domain
80/tcp   open  http
139/tcp  open  netbios-ssn
443/tcp  open  https
445/tcp  open  microsoft-ds
1900/tcp open  upnp
3517/tcp open  802-11-iapp
MAC Address: 50:FF:20:EC:4D:C7 (Keenetic Limited)

Nmap scan report for 192.168.1.39
Host is up (0.0050s latency).
All 1000 scanned ports on 192.168.1.39 are in ignored states.
Not shown: 1000 closed tcp ports (reset)
MAC Address: AC:BA:C0:57:7E:AE (Intertech Services AG)

Nmap scan report for 192.168.1.50
Host is up (0.0084s latency).
Not shown: 998 closed tcp ports (reset)
PORT      STATE SERVICE
49152/tcp open  unknown
62078/tcp open  iphone-sync
MAC Address: E2:F2:64:60:9F:71 (Unknown)

Nmap scan report for 192.168.1.56
Host is up (0.0053s latency).
All 1000 scanned ports on 192.168.1.56 are in ignored states.
Not shown: 1000 closed tcp ports (reset)
MAC Address: B0:4A:39:A5:9D:E7 (Beijing Roborock Technology)

Nmap scan report for 192.168.1.63
Host is up (0.00024s latency).
Not shown: 996 closed tcp ports (reset)
PORT     STATE    SERVICE
135/tcp  filtered msrpc
139/tcp  filtered netbios-ssn
445/tcp  filtered microsoft-ds
5357/tcp filtered wsdapi
MAC Address: E4:60:17:9B:E4:B6 (Intel Corporate)

Nmap scan report for 192.168.1.137
Host is up (0.0059s latency).
Not shown: 998 closed tcp ports (reset)
PORT      STATE SERVICE
49152/tcp open  unknown
62078/tcp open  iphone-sync
MAC Address: 22:8A:8E:85:07:90 (Unknown)

Nmap scan report for 192.168.1.107
Host is up (0.0000030s latency).
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE
5000/tcp filtered upnp

Nmap scan report for 192.168.1.1
Host is up (0.0042s latency).
Not shown: 992 closed tcp ports (reset)
PORT     STATE SERVICE
23/tcp   open  telnet
53/tcp   open  domain
80/tcp   open  http
139/tcp  open  netbios-ssn
443/tcp  open  https
445/tcp  open  microsoft-ds
1900/tcp open  upnp
3517/tcp open  802-11-iapp
MAC Address: 50:FF:20:EC:4D:C7 (Keenetic Limited)

Nmap scan report for 192.168.1.39
Host is up (0.0056s latency).
All 1000 scanned ports on 192.168.1.39 are in ignored states.
Not shown: 1000 closed tcp ports (reset)
MAC Address: AC:BA:C0:57:7E:AE (Intertech Services AG)

Nmap scan report for 192.168.1.50
Host is up (0.0078s latency).
Not shown: 998 closed tcp ports (reset)
PORT      STATE SERVICE
49152/tcp open  unknown
62078/tcp open  iphone-sync
MAC Address: E2:F2:64:60:9F:71 (Unknown)

Nmap scan report for 192.168.1.56
Host is up (0.0055s latency).
All 1000 scanned ports on 192.168.1.56 are in ignored states.
Not shown: 1000 closed tcp ports (reset)
MAC Address: B0:4A:39:A5:9D:E7 (Beijing Roborock Technology)

Nmap scan report for 192.168.1.63
Host is up (0.00013s latency).
Not shown: 996 closed tcp ports (reset)
PORT     STATE    SERVICE
135/tcp  filtered msrpc
139/tcp  filtered netbios-ssn
445/tcp  filtered microsoft-ds
5357/tcp filtered wsdapi
MAC Address: E4:60:17:9B:E4:B6 (Intel Corporate)

Nmap scan report for 192.168.1.137
Host is up (0.0088s latency).
Not shown: 998 closed tcp ports (reset)
PORT      STATE SERVICE
49152/tcp open  unknown
62078/tcp open  iphone-sync
MAC Address: 22:8A:8E:85:07:90 (Unknown)

Nmap scan report for 192.168.1.107
Host is up (0.0000050s latency).
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE
5000/tcp filtered upnp

Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000030s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE
5000/tcp filtered upnp

Nmap done: 515 IP addresses (16 hosts up) scanned in 24.48 seconds```

- `nmap -A -iL exmp_targets.txt` Агрессивное сканирование из файла

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -A -iL exmp_targets.txt
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 16:56 EST
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.056s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
Not shown: 996 closed tcp ports (reset)
PORT      STATE SERVICE    VERSION
22/tcp    open  ssh        OpenSSH 6.6.1p1 Ubuntu 2ubuntu2.13 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   1024 ac:00:a0:1a:82:ff:cc:55:99:dc:67:2b:34:97:6b:75 (DSA)
|   2048 20:3d:2d:44:62:2a:b0:5a:9d:b5:b3:05:14:c2:a6:b2 (RSA)
|   256 96:02:bb:5e:57:54:1c:4e:45:2f:56:4c:4a:24:b2:57 (ECDSA)
|_  256 33:fa:91:0f:e0:e1:7b:1f:6d:05:a2:b0:f1:54:41:56 (ED25519)
80/tcp    open  http       Apache httpd 2.4.7 ((Ubuntu))
|_http-server-header: Apache/2.4.7 (Ubuntu)
|_http-title: Go ahead and ScanMe!
|_http-favicon: Nmap Project
9929/tcp  open  nping-echo Nping echo
31337/tcp open  tcpwrapped
Aggressive OS guesses: Linux 5.0 - 5.14 (93%), MikroTik RouterOS 7.2 - 7.5 (Linux 5.6.3) (93%), Linux 4.15 - 5.19 (92%), OpenWrt 21.02 (Linux 5.4) (90%), Linux 4.19 - 5.15 (90%), Linux 2.6.32 - 3.13 (90%), Linux 5.1 - 5.15 (90%), Linux 6.0 (90%), OpenWrt 22.03 (Linux 5.10) (89%), Linux 4.19 (89%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 7 hops
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using port 80/tcp)
HOP RTT     ADDRESS
1   1.20 ms 192.168.1.1
2   2.49 ms 10.68.0.2
3   2.22 ms 192.168.126.216
4   ... 6
7   5.11 ms scanme.nmap.org (45.33.32.156)

...


TRACEROUTE
HOP RTT     ADDRESS
1   0.53 ms 192.168.1.63

Nmap scan report for 192.168.1.137
Host is up (0.0053s latency).
Not shown: 998 closed tcp ports (reset)
PORT      STATE SERVICE      VERSION
49152/tcp open  tcpwrapped
62078/tcp open  iphone-sync?
MAC Address: 22:8A:8E:85:07:90 (Unknown)
Device type: phone
Running: Apple iOS 15.X
OS CPE: cpe:/o:apple:iphone_os:15
OS details: Apple iOS 15.0 - 15.6 (Darwin 21.1.0 - 21.6.0)
Network Distance: 1 hop

TRACEROUTE
HOP RTT     ADDRESS
1   5.30 ms 192.168.1.137

Nmap scan report for 192.168.1.107
Host is up (0.000063s latency).
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE VERSION
5000/tcp filtered upnp
Too many fingerprints match this host to give specific OS details
Network Distance: 0 hops```

- `nmap -sA scanme.nmap.org` ACK scan для определения правил firewall
- `nmap -PN scanme.nmap.org` Сканирование без предварительного ping

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -sA scanme.nmap.org
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:03 EST
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.0035s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
All 1000 scanned ports on scanme.nmap.org (45.33.32.156) are in ignored states.
Not shown: 1000 unfiltered tcp ports (reset)

Nmap done: 1 IP address (1 host up) scanned in 0.88 seconds
                                                                                                                  
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -PN scanme.nmap.org
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:03 EST
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.19s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f
Not shown: 996 closed tcp ports (reset)
PORT      STATE SERVICE
22/tcp    open  ssh
80/tcp    open  http
9929/tcp  open  nping-echo
31337/tcp open  Elite

Nmap done: 1 IP address (1 host up) scanned in 3.00 seconds```

- `nmap --script=vuln IP_addr -vv` Подробный поиск уязвимостей

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap --script=vuln IP_addr -vv
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:04 EST
NSE: Loaded 105 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 2) scan.
Initiating NSE at 17:04
NSE Timing: About 83.33% done; ETC: 17:05 (0:00:06 remaining)
Completed NSE at 17:05, 34.45s elapsed
NSE: Starting runlevel 2 (of 2) scan.
Initiating NSE at 17:05
Completed NSE at 17:05, 0.00s elapsed
Pre-scan script results:
| broadcast-avahi-dos: 
|   Discovered hosts:
|     224.0.0.251
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|_  Hosts are all up (not vulnerable).
Failed to resolve "IP_addr".
NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 2) scan.
Initiating NSE at 17:05
Completed NSE at 17:05, 0.00s elapsed
NSE: Starting runlevel 2 (of 2) scan.
Initiating NSE at 17:05
Completed NSE at 17:05, 0.00s elapsed
Read data files from: /usr/share/nmap
WARNING: No targets were specified, so 0 hosts scanned.
Nmap done: 0 IP addresses (0 hosts up) scanned in 35.06 seconds
           Raw packets sent: 0 (0B) | Rcvd: 0 (0B)```

- `nmap -sV --script vuln -oN nmapres_new.txt localhost` Сохранение в файл

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -sV --script vuln -oN nmapres_new.txt localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:06 EST
Pre-scan script results:
| broadcast-avahi-dos: 
|   Discovered hosts:
|     224.0.0.251
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|_  Hosts are all up (not vulnerable).
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000030s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE VERSION
5000/tcp filtered upnp

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 35.89 seconds

┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -sV -p 8080 --script vuln -oN ~/work/course_labs/nmapres_new.txt -oX ~/work/course_labs/nmapres_new.xml localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:09 EST
Pre-scan script results:
| broadcast-avahi-dos: 
|   Discovered hosts:
|     224.0.0.251
|   After NULL UDP avahi packet DoS (CVE-2011-1002).
|_  Hosts are all up (not vulnerable).
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000060s latency).
Other addresses for localhost (not scanned): ::1

PORT     STATE  SERVICE    VERSION
8080/tcp closed http-proxy

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 34.66 seconds
                                                                                                                  
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ xsltproc ~/work/course_labs/nmapres_new.xml -o ~/work/course_labs/nmapres_new.html```
<img width="941" height="450" alt="image" src="https://gist.github.com/user-attachments/assets/f7210b2f-5fa6-4eec-9b1c-0f1e4978019a" />

- ✅ 3. Используйте команду `tree` и выведите все вложенные файлы по директориям.

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ tree ~/work/course_labs 
/home/kali/work/course_labs
├── assets
│   └── logotype
│       ├── logo2.jpg
│       └── logo.jpg
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── docs
│   ├── about.md
│   ├── APPENDIX.md
│   ├── appsec_tt.md
│   ├── artifacts
│   │   ├── assets
│   │   │   ├── favicon.ico
...```

- ✅ 4.Найдите IP сетевой карты `Ethernet`, которая соответствует вашей виртуальной машине используя `ifconfig` и выполните команду


```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ ifconfig
br-8a185c329dd6: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.21.0.1  netmask 255.255.0.0  broadcast 172.21.255.255
        inet6 fe80::42:edff:fe51:7714  prefixlen 64  scopeid 0x20<link>
        ether 02:42:ed:51:77:14  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

br-8cf8ec664aa0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.19.0.1  netmask 255.255.0.0  broadcast 172.19.255.255
        ether 02:42:00:f8:4b:a4  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:c9:a4:04:b6  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 5 overruns 0  carrier 0  collisions 0

docker_gwbridge: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.18.0.1  netmask 255.255.0.0  broadcast 172.18.255.255
        inet6 fe80::42:9dff:fe0f:3da6  prefixlen 64  scopeid 0x20<link>
        ether 02:42:9d:0f:3d:a6  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.107  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 2a02:2168:a576:d800:1fb3:e9fe:ba1b:8bbb  prefixlen 64  scopeid 0x0<global>
        inet6 fd79:cf8d:3311:0:f30:1f0d:b734:61cd  prefixlen 64  scopeid 0x0<global>
        inet6 fe80::dab1:a3b5:d317:7e74  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:f5:7d:62  txqueuelen 1000  (Ethernet)
        RX packets 300180  bytes 318116626 (303.3 MiB)
        RX errors 0  dropped 312  overruns 0  frame 0
        TX packets 143322  bytes 17866887 (17.0 MiB)
        TX errors 0  dropped 7 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 33420  bytes 2351013 (2.2 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 33420  bytes 2351013 (2.2 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

veth61c4aa0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::4c37:7dff:fe5d:8f20  prefixlen 64  scopeid 0x20<link>
        ether 4e:37:7d:5d:8f:20  txqueuelen 0  (Ethernet)
        RX packets 2902  bytes 171686 (167.6 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2936  bytes 176191 (172.0 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vethdb8d717: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::f093:2ff:fe0d:c217  prefixlen 64  scopeid 0x20<link>
        ether f2:93:02:0d:c2:17  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 28  bytes 3190 (3.1 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vethe6cb588: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::a89f:31ff:fec7:5209  prefixlen 64  scopeid 0x20<link>
        ether aa:9f:31:c7:52:09  txqueuelen 0  (Ethernet)
        RX packets 31  bytes 1590 (1.5 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 83  bytes 7039 (6.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

                                                                                                                  
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -sP 192.168.1.107  
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:17 EST
Nmap scan report for 192.168.1.107
Host is up.
Nmap done: 1 IP address (1 host up) scanned in 0.51 seconds```

- ✅ 5. Определите ОС, данные ssh, telnet  с помощью `nmap` и выведите о них информацию.

```bash
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -O localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:18 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000037s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 999 closed tcp ports (reset)
PORT     STATE    SERVICE
5000/tcp filtered upnp
Too many fingerprints match this host to give specific OS details
Network Distance: 0 hops

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 2.79 seconds
                                                                                                                  
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -sV -p 22,23 localhost
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:18 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000040s latency).
Other addresses for localhost (not scanned): ::1

PORT   STATE  SERVICE VERSION
22/tcp closed ssh
23/tcp closed telnet

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 0.18 seconds
                                                                                                                  
┌──(.venv)─(kali㉿kali)-[~/work/course_labs/labs/lab03]
└─$ nmap -A -p 22 localhost 
Starting Nmap 7.95 ( https://nmap.org ) at 2026-01-13 17:18 EST
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000049s latency).
Other addresses for localhost (not scanned): ::1

PORT   STATE  SERVICE VERSION
22/tcp closed ssh
Too many fingerprints match this host to give specific OS details
Network Distance: 0 hops

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1.74 seconds```

- ✅ 6. Результаты из `nmapres_new.txt` надо перенести в `nmapres.txt` и оставить оба файла рядом в локальном репозитории. Желательно использовать `cp` в консоли через редактор.
- ✅ 7. Оформить `README.md` по аналогии и использовать `shield`, etc.
- ✅ 8. Составить `gist` отчет и отправить ссылку личным сообщением

***

Copyright (c) 2025 Ilya Stratienko
