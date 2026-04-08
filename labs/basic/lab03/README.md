<div align="center">
<h1><a id="intro">Лабораторная работа №3</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a>
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black" alt="Linux">
<img src="https://img.shields.io/badge/Nmap-214478?style=flat" alt="Nmap">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Салют :wave:,<br>
Данная лабораторная работа посвящена изучению `nmap` и как с ним работать. Эта лабораторная работа послужит подпоркой для старта в выявлении и определении уязвимостей на уровне сканера портов, что бы освоить базовые методы сканирования.

Nmap — первый этап разведки в AppSec: определение attack surface (какие сервисы доступны извне), выявление устаревших версий ПО с известными CVE и обнаружение мисконфигураций (открытые порты, незащищённые сервисы). Результаты nmap — входные данные для анализа рисков (Lab 04) и последующего DAST-тестирования (Lab 08).

Для сдачи данной работы также будет требоваться ответить на дополнительные вопросы по описанным темам.

***

## Структура репозитория лабораторной работы

```bash
lab03
├── exmp_targets.txt
├── nmapres.txt
├── nmapres_new.txt
└── README.md
```

***

## Материал

**Nmap Network Mapper** `open-source` утилита для исследования и анализа сетей, в которой основная цель выявление активных устройств, открытых портов, сервисов, версий ПО, ОС и других характеристик, которые способствуют определению вектора атаки и влияния, а также перехвата управления инфраструктурой или отслеживания. Фактически она рассматривается как виртуальная сетевая карта

### Методы

- TCP - connect
- TCP SYN - stealth-сканирование
- UDP
- FIN
- ACK
- Xmas tree
- NULL-сканирование
- ICMP ping
- FTP-proxy
- idle scan - невидимое сканирование

### Возможности

- Определение ОС удалённых хостов с помощью отпечатков TCP/IP-стеков - OS fingerprinting
- Определение версий сервисов на открытых портах
- Сканирование сетей с динамическим управлением временем отправки пакетов
- Выявление пакетных фильтров, межсетевых экранов, маршрутизации и IP-фрагментации
- Nmap Scripting Engine позволяет автоматизировать поиск уязвимостей SQL Injection и т.д.
- Может избегать обнаружения, используя ложные хосты и изменение поведения сканера
- Может сканировать диапазон IP-адресов и множества целей
- Помогает определить, что открытый порт указывает на то, что служба запущена и ожидает соединений

### Команды

```bash
$ nmap -iL targets.txt # множественные цели сканирований
     -sL # List Scan
     -sn # Ping Scan (обнаружение хостов без сканирования портов)
     -Pn # all hosts online
     -PS/PA/PU/PY[portlist] # TCP SYN/ACK, UDP or SCTP
     -PE/PP/PM # ICMP echo, timestamp, netmask request
     -PO[protocol list] # IP Protocol Ping
     -n/-R # Не для DNS resolution
     --dns-servers <serv1[,serv2],...> # custom DNS
     --system-dns # Используйте OS
     --traceroute
```

### Типы сканирований

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">TCP Connect</span><div class="lab-card-tags"><span class="lab-tag">-sT</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Полное TCP-соединение (3-way handshake). Надёжный, но заметный — логируется на стороне сервера. Работает без root.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">TCP SYN (stealth)</span><div class="lab-card-tags"><span class="lab-tag">-sS</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Отправляет SYN, получает SYN/ACK, но не завершает handshake (RST). Быстрый, менее заметный. Требует root.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">TCP NULL</span><div class="lab-card-tags"><span class="lab-tag">-sN</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Пакет без флагов. Открытый порт не отвечает, закрытый — RST. Обходит простые файрволы, не работает на Windows.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">TCP FIN</span><div class="lab-card-tags"><span class="lab-tag">-sF</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Только флаг FIN. Аналогично NULL — закрытый порт ответит RST, открытый промолчит. Обход stateless файрволов.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">TCP XMAS</span><div class="lab-card-tags"><span class="lab-tag">-sX</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Флаги FIN+PSH+URG одновременно (как «ёлочная гирлянда»). Та же логика: закрытый → RST, открытый → тишина.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">TCP Idle (zombie)</span><div class="lab-card-tags"><span class="lab-tag">-sI</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Невидимое сканирование через «зомби»-хост. Ваш IP не виден жертве — трафик идёт от третьей машины.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">UDP</span><div class="lab-card-tags"><span class="lab-tag">-sU</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Сканирование UDP-портов. Медленное (нет handshake), но находит DNS (53), SNMP (161), DHCP (67) — часто забытые сервисы.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">OS Detection + Scripts</span><div class="lab-card-tags"><span class="lab-tag">-A</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Агрессивный режим: OS fingerprint, версии сервисов, traceroute и NSE-скрипты. Полная картина, но шумный.</span></div>
</div>

### Основные порты

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">20/21</span><span style="font-size:0.75rem; color:#555;">FTP (File Transfer Protocol)</span><div class="lab-card-tags"><span class="lab-tag">TCP</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Передача файлов. Данные и пароли в открытом виде — уязвим к перехвату. Заменяется на SFTP/SCP.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">22</span><span style="font-size:0.75rem; color:#555;">SSH (Secure Shell)</span><div class="lab-card-tags"><span class="lab-tag">TCP</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Защищённый удалённый доступ. Шифрованный канал. Основная цель brute-force атак — проверяйте версию и конфиг.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">23</span><span style="font-size:0.75rem; color:#555;">Telnet</span><div class="lab-card-tags"><span class="lab-tag">TCP</span><span class="lab-tag" style="border-color:rgba(213,26,26,0.3); color:#D51A1A; background:rgba(213,26,26,0.07);">небезопасный</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Всё в открытом тексте — пароли, команды. Открытый порт 23 — критическая находка. Должен быть закрыт.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">25</span><span style="font-size:0.75rem; color:#555;">SMTP (Mail Transfer)</span><div class="lab-card-tags"><span class="lab-tag">TCP</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Отправка почты. Open relay на порту 25 — спам-рассылки от вашего имени. Проверяйте аутентификацию.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">53</span><span style="font-size:0.75rem; color:#555;">DNS (Domain Name System)</span><div class="lab-card-tags"><span class="lab-tag">TCP/UDP</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Разрешение имён. DNS zone transfer (AXFR) раскрывает всю инфраструктуру. DNS amplification — DDoS вектор.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">80</span><span style="font-size:0.75rem; color:#555;">HTTP</span><div class="lab-card-tags"><span class="lab-tag">TCP</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Веб без шифрования. Основная поверхность атаки: XSS, SQLi, SSRF. Вход в DAST-тестирование (Lab 08).</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">443</span><span style="font-size:0.75rem; color:#555;">HTTPS</span><div class="lab-card-tags"><span class="lab-tag">TCP</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Веб с TLS. Проверяйте: версию TLS (≥1.2), срок сертификата, слабые шифры. `nmap --script ssl-enum-ciphers`.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">3306</span><span style="font-size:0.75rem; color:#555;">MySQL Database</span><div class="lab-card-tags"><span class="lab-tag">TCP</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">СУБД доступна извне — критическая мисконфигурация. Должна быть только на 127.0.0.1 или в приватной сети.</span></div>
</div>

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
```

***

## Задание

- [ ] 1. Опишите используемые методы по их назначению, как они функционируют и какие результаты могут дать для оценки. Используйте сноску из материалов выше по флагам команд.
- [ ] 2. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ nmap localhost
$ nmap -sC localhost

$ nmap -p- localhost
$ nmap -O localhost

$ nmap -p 80 localhost
$ nmap -p 443 localhost
$ nmap -p 8443 localhost
$ nmap -p "*" localhost
$ nmap -sV -p 22,8080 localhost

$ nmap -sn 192.168.1.0/24
$ nmap --open 192.168.1.1
$ nmap --packet-trace 192.168.1.1
$ nmap --packet-trace scanme.nmap.org
$ nmap --iflist

$ nmap -iL exmp_targets.txt
$ nmap -A -iL exmp_targets.txt
$ nmap -sA scanme.nmap.org
$ nmap -Pn scanme.nmap.org
```

- [ ] 3. Запустите NSE-скрипты для поиска уязвимостей и сохраните результат

```bash
$ nmap --script=vuln localhost -vv
$ nmap -sV --script vuln -oN nmapres_new.txt localhost
$ grep "VULNERABLE" nmapres_new.txt
```

- [ ] 4. Экспортируйте результаты в XML и конвертируйте в HTML-отчёт

```bash
$ mkdir -p ~/project/reports
$ nmap -sV -p 22,80,443,8080 --script vuln -oN ~/project/reports/nmapres_new.txt -oX ~/project/reports/nmapres_new.xml localhost
$ xsltproc ~/project/reports/nmapres_new.xml -o ~/project/reports/nmapres_new.html
```

> Откройте HTML-отчёт в браузере и опишите найденные уязвимости: порт, сервис, CVE (если есть), уровень критичности.

- [ ] 5. Используйте команду `tree` и выведите все вложенные файлы по директориям.
- [ ] 6. Найдите IP сетевой карты `Ethernet`, которая соответствует вашей виртуальной машине используя `ifconfig` (или `ip addr`) и выполните команду

```bash
$ nmap -sn inet_addr
```

- [ ] 7. Определите ОС, данные ssh, telnet с помощью `nmap` и выведите о них информацию.
- [ ] 8. Результаты из `nmapres_new.txt` перенесите в `nmapres.txt` и оставьте оба файла в локальном репозитории

```bash
$ cp nmapres_new.txt nmapres.txt
```

- [ ] 9. Защитите результаты сканирования — файл `nmapres.txt` содержит информацию об уязвимостях и не должен быть доступен другим пользователям. Используйте навыки из Lab 02:

```bash
# Установите права: только владелец может читать и писать
$ chmod 600 nmapres.txt
$ ls -la nmapres.txt

# Проверьте от другого пользователя (smallman из Lab 02)
$ su - smallman
$ cat /path/to/nmapres.txt    # ожидается: Permission denied
$ exit

# Добавьте ACL: только группа readgroup может читать (не писать)
$ setfacl -m g:readgroup:r nmapres.txt
$ getfacl nmapres.txt

# Убедитесь: пользователь вне readgroup не может прочитать файл
$ su - smallman
$ cat /path/to/nmapres.txt    # если smallman в readgroup — OK, иначе — denied
$ exit
```

> Опишите в отчёте: почему результаты nmap-сканирования — это конфиденциальная информация. Что может сделать злоумышленник, получив ваш `nmapres.txt`?

- [ ] 10. Добавьте `nmapres.txt` и `nmapres_new.txt` в `.gitignore` — результаты сканирования не должны попадать в публичный репозиторий

```bash
$ echo "nmapres*.txt" >> .gitignore
$ git add .gitignore
$ git commit -S -m "chore: ignore nmap scan results"
```

- [ ] 11. Оформить `README.md` по аналогии и использовать `shield`, etc.
- [ ] 12. Составить `gist` отчет и отправить ссылку личным сообщением

***

## Смотри также

- [Лаб. №2 — Linux](https://course.geminishkv.tech/labs/basic/lab02/) — права доступа и ACL, используемые для защиты результатов
- [Лаб. №4 — Risk Analysis](https://course.geminishkv.tech/labs/basic/lab04/) — анализ рисков по результатам nmap
- [Лаб. №8 — DAST](https://course.geminishkv.tech/labs/basic/lab08/) — динамическое тестирование найденных сервисов
- [CheatSheet: Docker](https://course.geminishkv.tech/materials/cheatsheet/CHEATSHEET_DOCKER/) — контейнеры для изоляции тестовых стендов

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/troubleshooting/).

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://nmap.org/book/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Nmap Official Documentation</div><div class="lab-card-tags"><span class="lab-tag">nmap.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://nmap.org/book/man.html" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Nmap Reference Guide</div><div class="lab-card-tags"><span class="lab-tag">nmap.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://nmap.org/nsedoc/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Nmap Script (NSE) Reference</div><div class="lab-card-tags"><span class="lab-tag">nmap.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/nmap/nmap" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Nmap GitHub</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml" target="_blank"><div class="lab-card-body"><div class="lab-card-title">IANA Port Numbers</div><div class="lab-card-tags"><span class="lab-tag">iana.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://owasp.org/www-project-web-security-testing-guide/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">OWASP Testing Guide</div><div class="lab-card-tags"><span class="lab-tag">owasp.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gist.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Gist</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
