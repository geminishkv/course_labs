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

Для сдачи данной работы также будет требоваться ответить на дополнительыне вопросы по описанным темам.

***

## Структура репозитория лабораторной работы

```bash
lab03
├── exmp_targets.txt
└── README.md
```

***

## Материал

**Nmap Network Mapper** `open-source` утилита для исследования и анализа сетей, в которой основная цель выявление активных устройств, открытых портов, сервисов, версий ПО, ОС и других характеристик, которые способствуют определнию вектора атаки и влияния, а также перехвата управления инфраструктурой или отслеживания. Фактически она рассматривается как виртуальная сетевая карта

- **Методы:**
    - TCP - connect, 
    - TCP SYN - stealth-сканирование, 
    - UDP 
    - FIN 
    - ACK 
    - Xmas tree 
    - NULL-сканирование
    -  ICMP ping
    -  FTP-proxy 
    -  idle scan - невидимое сканирование
    -  и т.д.
- **Возможности:**
    - Определение ОС удалённых хостов с помощью отпечатков TCP/IP-стеков - OS fingerprinting
    - Определение версий сервисов на открытых портах
    - Сканирование сетей с динамическим управлением временем отправки пакетов
    - Выявление пакетных фильтров, межсетевых экранов,маршрутизации и IP-фрагментации
    - Nmap Scripting Engine позволяет автоматизировать поиск уязвимостей SQL Injection и т.д.
    - Может избегать обнаружения, используя ложные хосты и изменение поведения сканера, и т.д.
    - Может сканировать диапазон IP-адресов и множества целей
    - Помогает определить, что открытый порт указывает на то, что служба запущена и ожидает соединений

- **Команды**

```bash
$ nmap -iL targets.txt # множествнные цели сканирований
     -sL # List Scan 
     -sn # Ping Scan 
     -Pn # all hosts online
     -PS/PA/PU/PY[portlist] # TCP SYN/ACK, UDP or SCTP
     -PE/PP/PM # ICMP echo, timestamp, netmask request
     -PO[protocol list] # IP Protocol Ping
     -n/-R # Не для DNS resolution
     --dns-servers <serv1[,serv2],...> # custom DNS
     --system-dns # Используйте OS
     --traceroute 
```

-  **Типы сканирований и опции nmap**

<table>
  <thead>
    <tr>
      <th>Scan type</th>
      <th>nmap option</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>TCP (connect)</td><td>-sT</td></tr>
    <tr><td>TCP SYN</td><td>-sS</td></tr>
    <tr><td>TCP NULL</td><td>-sN</td></tr>
    <tr><td>TCP FIN</td><td>-sF</td></tr>
    <tr><td>TCP XMAS</td><td>-sX</td></tr>
    <tr><td>TCP idle (zombie)</td><td>-sI</td></tr>
    <tr><td>UDP</td><td>-sU</td></tr>
    <tr><td>OS</td><td>-A</td></tr>
  </tbody>
</table>

- **Порты**

<table>
  <thead>
    <tr>
      <th>Port</th>
      <th>Service</th>
      <th>Protocol</th>
    </tr>
  </thead>
  <tbody>
    <tr><td>20/21</td><td>FTP (File Transfer)</td><td>TCP</td></tr>
    <tr><td>22</td><td>SSH (Secure Shell)</td><td>TCP</td></tr>
    <tr><td>23</td><td>Telnet</td><td>TCP</td></tr>
    <tr><td>25</td><td>SMTP (Simple Mail Transfer)</td><td>TCP</td></tr>
    <tr><td>53</td><td>DNS (Domain Name System)</td><td>TCP/UDP</td></tr>
    <tr><td>67/68</td><td>DHCP (Dynamic Host Configuration Protocol)</td><td>UDP</td></tr>
    <tr><td>69</td><td>TFTP (Trivial File Transfer Protocol)</td><td>UDP</td></tr>
    <tr><td>80</td><td>HTTP (Hypertext Transfer Protocol)</td><td>TCP</td></tr>
    <tr><td>110</td><td>POP3 (Post Office Protocol version 3)</td><td>TCP</td></tr>
    <tr><td>443</td><td>HTTPS (HTTP Secure)</td><td>TCP</td></tr>
    <tr><td>3306</td><td>MySQL Database</td><td>TCP</td></tr>
  </tbody>
</table>

***

### Пример результата

```bash
nmap scan report for 10.1.1.10
Host is up, received echo-reply ttl 62 (0.024s latency).
Scanned at 2023-03-06 13:31:28 CET for 573s
Not shown: 993 closed tcp ports (reset)
PORT     STATE SERVICE     REASON         VERSION
22/tcp   open  ssh         syn-ack ttl 62 OpenSSH 8.9p1 Ubuntu 3ubuntu0.1 (Ubuntu Linux; protocol 2.0)
53/tcp   open  domain      syn-ack ttl 62 dnsmasq 2.86
80/tcp   open  http        syn-ack ttl 62 Apache httpd 2.4.52 ((Ubuntu))
139/tcp  open  netbios-ssn syn-ack ttl 62 Samba smbd 4.6.2
445/tcp  open  netbios-ssn syn-ack ttl 62 Samba smbd 4.6.2
631/tcp  open  ipp         syn-ack ttl 62 CUPS 2.4
3306/tcp open  mysql       syn-ack ttl 62 MySQL (unauthorized)
Aggressive OS guesses: HP P2000 G3 NAS device (90%), Linux 2.6.32 - 3.13 (88%), Linux 2.6.32 (88%), Linux 2.6.32 - 3.1 (88%), Ubiquiti AirMax NanoStation WAP (Linux 2.6.32) (88%), Linux 3.7 (88%), Linux 5.1 (88%), Linux 5.4 (88%), Netgear RAIDiator 4.2.21 (Linux 2.6.37) (88%), Ubiquiti Pico Station WAP (AirOS 5.2.6) (88%)
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.93%E=4%D=3/6%OT=22%CT=1%CU=33670%PV=Y%DS=3%DC=I%G=Y%TM=6405DF5D
OS:%P=x86_64-pc-linux-gnu)SEQ(SP=F8%GCD=1%ISR=104%TI=Z%CI=Z%II=I%TS=A)OPS(O
OS:1=M564ST11NW7%O2=M564ST11NW7%O3=M564NNT11NW7%O4=M564ST11NW7%O5=M564ST11N
OS:W7%O6=M564ST11)WIN(W1=FB28%W2=FB28%W3=FB28%W4=FB28%W5=FB28%W6=FB28)ECN(R
OS:=Y%DF=Y%T=40%W=FD5C%O=M564NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS%
OS:RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R=Y
OS:%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R
OS:%O=%RD=0%Q=)T7(R=N)U1(R=Y%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RU
OS:CK=11AA%RUD=G)IE(R=Y%DFI=N%T=40%CD=S)
```

***

## Задание

- [ ] 1. Опишите используемые методы по их назначению, как они функционируют и какие результаты могут дать для оценки. Используйте сноску из материалов выше по флагам команд.
- [ ] 2. Выведите на терминале и проанализируйте следующие команды консоли

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

- [ ] 3. Используйте команду `tree` и выведите все вложенные файлы по директориям.
- [ ] 4.Найдите IP сетевой карты `Ethernet`, которая соответствует вашей виртуальной машине используя `ifconfig` и выполните команду

```bash
$ nmap -sP inet_addr
```

- [ ] 5. Определите ОС, данные ssh, telnet  с помощью `nmap` и выведитео них информацию.
- [ ] 6. Результаты из `nmapres_new.txt` надо перенести в `nmapres.txt` и оставить оба файла рядом в локальном репозитории. Желательно использовать `cp` в консоли через редактор.
- [ ] 7. Оформить `README.md` по аналогии и использовать `shield`, etc.
- [ ] 8. Составить `gist` отчет и отправить ссылку личным сообщением

***

## Links

- [Markdown](https://stackedit.io)
- [GitHub CLI](https://cli.github.com)
- [Gist](https://gist.github.com)
- [IANA](https://www.iana.org)
- [IANA Port Numbers](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml)
- [Nmap GitHub](https://github.com/nmap/nmap)
- [Официальная документация nmap](https://nmap.org/book/)
- [Nmap Reference Guide](https://nmap.org/book/man.html)
- [Nmap Script (NSE) Reference](https://nmap.org/nsedoc/)
- [Nmap Tutorial (Hackers-Arise)](https://nmap.org/docs.html)
- [OWASP Testing Guide – Network Scanning](https://owasp.org/www-project-web-security-testing-guide/)

Copyright (c) 2025 Elijah S Shmakov

![Logo](../../assets/logotype/logo.jpg)