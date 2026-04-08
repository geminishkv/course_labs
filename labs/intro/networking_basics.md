<div align="center">
<h1><a id="intro">Введение в сети и TCP/IP</a><br></h1>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/TCP%2FIP-214478?style=flat" alt="TCP/IP">
<img src="https://img.shields.io/badge/DNS-333333?style=flat" alt="DNS">
<img src="https://img.shields.io/badge/HTTP-005AF0?style=flat" alt="HTTP">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Краткое введение в сетевые технологии перед лабораторной с Nmap (Lab 03). Здесь — только то, что нужно для понимания сканирования и сетевой безопасности.

> Если вы уже знакомы с моделью OSI, TCP/IP и основными протоколами — переходите сразу к Lab 03.

***

## Модель OSI и TCP/IP

Две модели описывают, как данные передаются по сети:

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">7. Application</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/IP: Application</span>
    </div>
    <span class="lab-tag">HTTP</span><span class="lab-tag">HTTPS</span><span class="lab-tag">DNS</span><span class="lab-tag">SSH</span><span class="lab-tag">FTP</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Интерфейс для приложений пользователя</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">6. Presentation</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/IP: Application</span>
    </div>
    <span class="lab-tag">TLS/SSL</span><span class="lab-tag">MIME</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Кодирование, шифрование, сжатие данных</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">5. Session</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/IP: Application</span>
    </div>
    <span class="lab-tag">RPC</span><span class="lab-tag">NetBIOS</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Управление сессиями между узлами</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">4. Transport</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/IP: Transport</span>
    </div>
    <span class="lab-tag">TCP</span><span class="lab-tag">UDP</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Доставка данных между процессами</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">3. Network</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/IP: Internet</span>
    </div>
    <span class="lab-tag">IP</span><span class="lab-tag">ICMP</span><span class="lab-tag">ARP</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Маршрутизация между сетями</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">2. Data Link</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/IP: Network Access</span>
    </div>
    <span class="lab-tag">Ethernet</span><span class="lab-tag">Wi-Fi</span><span class="lab-tag">MAC</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Передача в локальной сети</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">1. Physical</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/IP: Network Access</span>
    </div>
    <span class="lab-tag">Кабели</span><span class="lab-tag">Радио</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Физический сигнал — провода, оптика, радиоволны</p>
  </div>

</div>

Для AppSec критически важны уровни **3-7** — именно там работают инструменты сканирования и атаки.

***

## IP-адреса

IP-адрес — уникальный идентификатор устройства в сети.

### IPv4

Формат: `192.168.1.100` — четыре октета, каждый от 0 до 255.

```bash
# Узнать свой IP
$ ip addr show          # Linux
$ ifconfig              # macOS / старые Linux
$ hostname -I           # только IP, без лишнего
```

### Приватные диапазоны (RFC 1918)

Не маршрутизируются в интернете:

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">10.0.0.0/8</div>
    <div class="lab-card-tags"><span class="lab-tag">255.0.0.0</span><span class="lab-tag">Крупные сети</span></div>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">172.16.0.0/12</div>
    <div class="lab-card-tags"><span class="lab-tag">255.240.0.0</span><span class="lab-tag">Средние сети</span></div>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">192.168.0.0/16</div>
    <div class="lab-card-tags"><span class="lab-tag">255.255.0.0</span><span class="lab-tag">Домашние / лаб. сети</span></div>
  </div>

</div>

Специальные адреса:

- `127.0.0.1` — loopback (сам на себя)
- `0.0.0.0` — все интерфейсы (при прослушивании)
- `255.255.255.255` — широковещательный

### Маска подсети и CIDR

Маска определяет, какая часть адреса — сеть, какая — хост:

```text
IP:    192.168.1.100
Маска: 255.255.255.0   (/24)
Сеть:  192.168.1.0
Хост:  .100
```

CIDR-нотация: `/24` = первые 24 бита — адрес сети, оставшиеся 8 — хосты (254 доступных).

```bash
# Проверить маску и сеть
$ ip route show
```

***

## Порты

Порт — числовой идентификатор (0-65535), определяющий конкретный сервис на хосте.

### Диапазоны портов

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">0 — 1023</div>
    <div class="lab-card-tags"><span class="lab-tag">Well-known</span></div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Стандартные сервисы, требуют root</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">1024 — 49151</div>
    <div class="lab-card-tags"><span class="lab-tag">Registered</span></div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Зарегистрированные приложения</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">49152 — 65535</div>
    <div class="lab-card-tags"><span class="lab-tag">Dynamic</span></div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Временные (ephemeral) порты</p>
  </div>

</div>

### Ключевые порты для AppSec

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">22</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · SSH</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Удалённый доступ к серверу</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">80</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · HTTP</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Веб без шифрования</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">443</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · HTTPS</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Веб с TLS-шифрованием</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">53</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP/UDP · DNS</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Резолвинг доменных имён</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">3306</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · MySQL</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">База данных — частая цель атак</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">5432</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · PostgreSQL</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">База данных PostgreSQL</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">8080</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · HTTP Proxy</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Альтернативный веб / прокси</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">8443</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">TCP · HTTPS Alt</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Альтернативный HTTPS</p>
  </div>

</div>

```bash
# Посмотреть открытые порты на своей машине
$ ss -tlnp               # TCP, listening, numeric, process
$ ss -ulnp               # UDP

# Проверить конкретный порт
$ ss -tlnp | grep :22
```

> Полный справочник портов — в разделе [Порты и протоколы](https://course.geminishkv.tech/materials/ports/).

***

## TCP vs UDP

### TCP (Transmission Control Protocol)

Надёжная доставка с установлением соединения.

```text
Клиент              Сервер
  │── SYN ──────────→│       1. Клиент инициирует
  │←── SYN-ACK ─────│       2. Сервер подтверждает
  │── ACK ──────────→│       3. Соединение установлено
  │                   │
  │←─ Данные ────────→│      4. Обмен данными
  │                   │
  │── FIN ──────────→│       5. Завершение
  │←── ACK ─────────│
```

TCP гарантирует: порядок пакетов, доставку, контроль ошибок. Используется: HTTP, SSH, FTP, SMTP.

### UDP (User Datagram Protocol)

Быстрая передача без гарантий доставки. Нет handshake, нет подтверждений.

Используется: DNS (обычно), видеостриминг, VoIP, игры.

**Для Nmap:** понимание TCP handshake критически важно — SYN-сканирование (`-sS`) отправляет только SYN и анализирует ответ, не завершая handshake.

***

## DNS

DNS (Domain Name System) — преобразует доменные имена в IP-адреса.

```bash
# Прямой запрос
$ nslookup example.com
$ dig example.com

# Обратный запрос (IP → домен)
$ dig -x 93.184.216.34

# Конкретный тип записи
$ dig example.com MX     # почтовые серверы
$ dig example.com NS     # DNS-серверы
$ dig example.com TXT    # текстовые записи (SPF, DKIM)
```

### Типы DNS-записей

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">A</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">IPv4-адрес</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">example.com → 93.184.216.34</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">AAAA</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">IPv6-адрес</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">example.com → 2606:2800:...</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CNAME</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Псевдоним</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">www.example.com → example.com</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">MX</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Почтовый сервер</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">mail.example.com</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">NS</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">DNS-сервер</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">ns1.example.com</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">TXT</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Текстовая запись</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">SPF, DKIM, верификация домена</p>
  </div>

</div>

***

## HTTP/HTTPS

### Структура HTTP-запроса

```text
GET /api/users HTTP/1.1        ← метод, путь, версия
Host: example.com              ← обязательный заголовок
User-Agent: curl/8.0           ← клиент
Accept: application/json       ← ожидаемый формат
Authorization: Bearer <token>  ← аутентификация
```

### Основные методы

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">GET</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Safe · Idempotent</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Получить данные</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">POST</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Unsafe</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Создать ресурс</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">PUT</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Unsafe · Idempotent</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Заменить ресурс целиком</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DELETE</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Unsafe · Idempotent</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Удалить ресурс</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">PATCH</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Unsafe</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Частично обновить ресурс</p>
  </div>

</div>

### Коды ответов

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">1xx</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Информационные</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">100 Continue</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">2xx</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Успех</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">200 OK · 201 Created</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">3xx</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Перенаправление</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">301 Moved · 302 Found</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">4xx</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Ошибка клиента</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">400 Bad Request · 401 Unauthorized · 403 Forbidden · 404 Not Found</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">5xx</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Ошибка сервера</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">500 Internal Server Error · 502 Bad Gateway</p>
  </div>

</div>

```bash
# Отправить запрос и увидеть заголовки
$ curl -v https://example.com

# Только заголовки ответа
$ curl -I https://example.com

# POST-запрос с данными
$ curl -X POST -H "Content-Type: application/json" \
    -d '{"key": "value"}' https://example.com/api
```

> Подробнее о заголовках безопасности — в [CheatSheet HTTP Security Headers](https://course.geminishkv.tech/materials/cheatsheet/CHEATSHEET_HTTP_HEADERS/).

***

## Практические команды для диагностики

```bash
# Проверить доступность хоста
$ ping -c 4 example.com

# Трассировка маршрута
$ traceroute example.com        # Linux/macOS
$ mtr example.com               # интерактивная версия

# Показать таблицу маршрутизации
$ ip route show                 # Linux
$ netstat -rn                   # macOS

# ARP-таблица (MAC ↔ IP)
$ arp -a

# Посмотреть сетевые интерфейсы
$ ip link show
```

***

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://www.cloudflare.com/learning/network-layer/what-is-the-network-layer/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Cloudflare — Network Layer</div><div class="lab-card-tags"><span class="lab-tag">cloudflare.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://www.iana.org/assignments/service-names-port-numbers/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">IANA — Port Numbers Registry</div><div class="lab-card-tags"><span class="lab-tag">iana.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview" target="_blank"><div class="lab-card-body"><div class="lab-card-title">MDN — HTTP Overview</div><div class="lab-card-tags"><span class="lab-tag">developer.mozilla.org</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
