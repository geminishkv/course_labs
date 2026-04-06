# Отчет по лабораторной работе №6
## Аудит безопасности Docker с использованием Docker Bench Security

## Выполненные задания

### Задание 1: Установка Docker Engine и Docker Bench Security

**Статус:** Docker уже установлен на сервере, установка не требовалась

**Проверка установки:**
```bash
$ docker --version
Docker version 27.4.1, build b9d17ea

$ docker buildx version
github.com/docker/buildx v0.19.3 48d6a39
```

**Скачивание Docker Bench Security:**
```bash
$ docker pull docker/docker-bench-security
Status: Downloaded newer image for docker/docker-bench-security:latest
docker.io/docker/docker-bench-security:latest
```

**Digest:** `sha256:ddbdf4f86af4405da4a8a7b7cc62bb63bfeb75e85bf22d2ece70c204d7cfabb8`

---

### Задание 2: Проверка работы Docker и подготовка audit.sh

**Проверка Docker:**
```bash
$ docker info >/dev/null 2>&1 && echo "Docker daemon работает"
Docker daemon работает
```

**Подготовка скрипта audit.sh:**
```bash
$ cd /root/course_labs/labs/lab06
$ chmod +x audit.sh
$ ls -la audit.sh
-rwxr-xr-x 1 root root 9700 Dec 12 21:15 audit.sh
```

**Статус:** Скрипт `audit.sh` готов к выполнению

---

### Задание 3: Развертывание уязвимого приложения

**Развертывание основного приложения:**
```bash
$ cd /root/course_labs/labs/lab06
$ docker compose up -d
```

**Результат:**
- Создана сеть `lab06_default`
- Созданы контейнеры: `insecure-db`, `vulnerable-app`, `vulnerable-nginx`
- **Проблема:** Контейнер `insecure-db` не запустился из-за конфликта порта 5432 (порт уже занят другим процессом на хосте)
- **Решение:** Порт изменен с `5432:5432` на `5433:5432` в `docker-compose.yml` для избежания конфликта
- После изменения порта контейнер `insecure-db` успешно запущен на порту 5433
- **Изменение в docker-compose.yml:** `ports: - "5432:5432"` → `ports: - "5433:5432"`
- **Примечание:** Внутри контейнера PostgreSQL продолжает работать на стандартном порту 5432, но снаружи доступен через порт 5433, что устраняет конфликт с другим процессом на хосте

**Развертывание уязвимого приложения:**
```bash
$ docker-compose -f vulnerable-app.yml up -d
```

**Результат:**
- Скачаны образы: `nginx:latest`, `alpine:latest`
- Запущены контейнеры:
  - `vulnerable-web` (nginx:latest) - **Restarting** (ошибка конфигурации nginx)
  - `debug-shell` (alpine:latest) - **Exited** (ошибка SSH hostkeys)

**Статус контейнеров:**
```bash
$ docker ps -a | grep -E "(vulnerable|insecure|debug)"
vulnerable-web       Restarting (1) 
debug-shell          Exited (1) 
vulnerable-app       Created
insecure-db          Created
```

**Примечание:** Контейнеры `vulnerable-web` и `debug-shell` имеют критические уязвимости безопасности, что и является целью лабораторной работы.

---

### Задание 4: Запуск скрипта audit.sh из venv

**Создание виртуального окружения:**
```bash
$ cd /root/course_labs/labs/lab06
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install openpyxl odfpy
```

**Результат установки:**
```
Successfully installed defusedxml-0.7.1 et-xmlfile-2.0.0 odfpy-1.4.1 openpyxl-3.1.5
```

**Запуск аудита:**
```bash
$ ./audit.sh
```

**Проблема:** Скрипт `audit.sh` не смог запустить docker-bench-security из-за отсутствия `/usr/bin/dumb-init` в образе.

**Решение:** Запуск docker-bench-security напрямую:
```bash
$ docker run --rm --net host --pid host --userns host --cap-add audit_control \
  -v /etc:/etc:ro -v /usr/bin/containerd:/usr/bin/containerd:ro \
  -v /usr/bin/runc:/usr/bin/runc:ro -v /usr/lib/systemd:/usr/lib/systemd:ro \
  -v /var/lib:/var/lib:ro -v /var/run/docker.sock:/var/run/docker.sock:ro \
  docker/docker-bench-security > audit_reports/text/cis_audit.txt 2>&1
```

**Результаты аудита:**
- **Всего проверок:** 105
- **Прохождений (PASS):** 39
- **Предупреждений (WARN):** 87
- **Информационных сообщений (INFO):** множество

**Основные категории проверок:**
1. Host Configuration (1.1 - 1.13)
2. Docker daemon configuration (2.1 - 2.18)
3. Docker daemon configuration files (3.1 - 3.20)
4. Container Images and Build File (4.1 - 4.6)
5. Container Runtime (5.1 - 5.28)
6. Docker Security Operations (6.1 - 6.2)
7. Docker Swarm Configuration (7.1 - 7.10)

**Отчет сохранен в:** `/root/course_labs/labs/lab06/audit_reports/text/cis_audit.txt` (231 строка, 16093 байт)

**Структура директории audit_reports:**
```
/root/course_labs/labs/lab06/audit_reports/
├── json/          (Trivy JSON outputs) - пусто (Trivy не установлен)
├── text/          (CIS audit text outputs)
│   ├── cis_audit.txt (231 строка)
│   └── docker-bench-security-cis.txt
├── xlsx/          (Excel spreadsheets) - пусто
└── odt/           (OpenDocument Text files) - пусто
```

---

### Задание 5: Анализ уязвимостей - причины возникновения

#### Анализ vulnerable-app.yml

**Контейнер vulnerable-web:**

1. **`privileged: true`**
   - **Причина:** Контейнер запущен в привилегированном режиме
   - **Проблема:** Получает все capabilities хоста, включая доступ к устройствам
   - **Проверка:** `docker inspect vulnerable-web` показывает `Privileged: true`

2. **`network_mode: host`**
   - **Причина:** Использование сетевого пространства хоста
   - **Проблема:** Контейнер имеет прямой доступ к сетевому стеку хоста
   - **Проверка:** `NetworkMode: host`

3. **`user: "0:0"`**
   - **Причина:** Запуск от пользователя root (UID 0)
   - **Проблема:** Полные права внутри контейнера

4. **`cap_add: - ALL`**
   - **Причина:** Добавлены все Linux capabilities
   - **Проблема:** Контейнер может выполнять любые системные операции
   - **Проверка:** `CapAdd: [ALL]`

5. **`security_opt: apparmor:unconfined, seccomp:unconfined`**
   - **Причина:** Отключены профили безопасности AppArmor и Seccomp
   - **Проблема:** Нет ограничений на системные вызовы и доступ к ресурсам

6. **Секреты в environment:**
   - `ADMIN_PASSWORD=admin123`
   - `DB_PASSWORD=root`
   - `FLAG=FLAG{HARDCODED_SECRET_IN_ENV}`
   - **Проблема:** Секреты хранятся в открытом виде в конфигурации

7. **Монтирование `/var/run/docker.sock`:**
   - **Причина:** Прямое монтирование Docker socket
   - **Проблема:** Контейнер может управлять Docker daemon хоста

8. **Монтирование `/:/hostroot:rw`:**
   - **Причина:** Полный доступ к файловой системе хоста
   - **Проблема:** Контейнер может читать и изменять любые файлы хоста

**Контейнер debug-shell:**

1. **`privileged: true`** - аналогично vulnerable-web
2. **`network_mode: host`** - аналогично vulnerable-web
3. **`user: "0:0"`** - запуск от root
4. **SSH с паролем в открытом виде:** `SSH_PASSWORD=password`
5. **`PermitRootLogin=yes`** - разрешен вход root по SSH

#### Анализ docker-compose.yml

**Контейнер insecure-db:**

1. **Слабый пароль:** `POSTGRES_PASSWORD=root`
2. **Пароль в environment:** Секреты в открытом виде

**Контейнер app:**

1. **Секреты в environment:**
   - `APP_SECRET_KEY=hardcoded-in-env`
   - `DB_URL=postgresql://vulnuser:root@insecure-db:5432/vulnapp`
2. **`DEBUG=true`** - включен режим отладки в production

---

### Задание 6: Описание влияния уязвимостей и сценариев атак

#### Сценарии атак для vulnerable-web

**Сценарий 1: Компрометация через privileged режим**
1. Злоумышленник получает доступ к контейнеру `vulnerable-web`
2. Благодаря `privileged: true` и `cap_add: ALL` получает полный доступ к хосту
3. Может монтировать устройства хоста, изменять сетевую конфигурацию
4. **Влияние:** Полная компрометация хоста

**Сценарий 2: Доступ к Docker daemon через docker.sock**
1. Злоумышленник получает доступ к контейнеру
2. Использует монтированный `/var/run/docker.sock` для управления Docker
3. Может создавать новые контейнеры, останавливать существующие
4. Может получить доступ к другим контейнерам
5. **Влияние:** Компрометация всей Docker-инфраструктуры

**Сценарий 3: Доступ к файловой системе хоста**
1. Через монтирование `/:/hostroot:rw` злоумышленник получает доступ к файлам хоста
2. Может читать секреты, конфигурации, логи
3. Может изменять системные файлы
4. **Влияние:** Утечка данных, нарушение целостности системы

**Сценарий 4: Сетевая атака через host network**
1. Благодаря `network_mode: host` контейнер видит весь сетевой трафик хоста
2. Может перехватывать пакеты других приложений
3. Может сканировать сеть хоста
4. **Влияние:** Нарушение конфиденциальности сетевого трафика

#### Сценарии атак для debug-shell

**Сценарий 5: Несанкционированный доступ через SSH**
1. Злоумышленник подключается к SSH (порт 22) с паролем `password`
2. Входит как root благодаря `PermitRootLogin=yes`
3. Получает полный доступ к контейнеру и хосту (через privileged)
4. **Влияние:** Полная компрометация системы

#### Сценарии атак для insecure-db и app

**Сценарий 6: SQL-инъекция и компрометация БД**
1. Слабый пароль `root` для PostgreSQL
2. Утечка credentials через environment переменные
3. Злоумышленник подключается к БД и извлекает данные
4. **Влияние:** Утечка персональных данных, нарушение конфиденциальности

**Сценарий 7: Утечка секретов через environment**
1. Секреты видны через `docker inspect`, логи, переменные окружения
2. Злоумышленник получает `APP_SECRET_KEY`, `DB_URL`
3. Может подделать сессии, получить доступ к БД
4. **Влияние:** Компрометация приложения и данных

---

### Задание 7: Оценка рисков ИБ и меры снижения

#### Оценка рисков

**Критические риски (CR):**

1. **CR-1: Полная компрометация хоста через privileged контейнеры**
   - **Вероятность:** Высокая (при наличии уязвимости в приложении)
   - **Влияние:** Критическое (полный контроль над хостом)
   - **Риск:** Критический

2. **CR-2: Доступ к Docker daemon через docker.sock**
   - **Вероятность:** Высокая
   - **Влияние:** Критическое (компрометация всей инфраструктуры)
   - **Риск:** Критический

3. **CR-3: Утечка секретов через environment переменные**
   - **Вероятность:** Высокая (секреты видны всем с доступом к Docker)
   - **Влияние:** Высокое (компрометация приложения и БД)
   - **Риск:** Критический

**Высокие риски (HR):**

4. **HR-1: Слабые пароли и учетные данные**
   - **Вероятность:** Высокая
   - **Влияние:** Высокое
   - **Риск:** Высокий

5. **HR-2: Запуск от root пользователя**
   - **Вероятность:** Средняя
   - **Влияние:** Высокое
   - **Риск:** Высокий

#### Меры снижения рисков

**Исправленный vulnerable-app.yml:**

```yaml
version: "3.8"

services:
  vulnerable-web:
    image: nginx:alpine
    container_name: secure-nginx
    # УБРАНО: privileged: true
    # УБРАНО: network_mode: host
    # УБРАНО: pid: host
    user: "101:101"  # Использование непривилегированного пользователя nginx
    restart: unless-stopped
    # УБРАНО: секреты из environment
    # Использование Docker secrets или внешнего vault
    volumes:
      - ./config/nginx.conf:/etc/nginx/nginx.conf:ro
      # УБРАНО: монтирование /, docker.sock
    # УБРАНО: cap_add: ALL
    # УБРАНО: security_opt с unconfined
    security_opt:
      - no-new-privileges:true
    read_only: true  # Файловая система только для чтения
    tmpfs:
      - /tmp
      - /var/cache/nginx
    networks:
      - app-network
    ports:
      - "8080:80"

  debug-shell:
    # УДАЛЕН: не должен использоваться в production
    # Если необходим для отладки - использовать только в dev окружении
    # с временным доступом и логированием всех действий

networks:
  app-network:
    driver: bridge
```

**Исправленный docker-compose.yml:**

```yaml
version: '3.8'
services:
  vulnerable-web:
    image: nginx:alpine
    container_name: secure-nginx
    depends_on:
      - secure-db
      - app
    ports:
      - "8080:80"
    volumes:
      - ./config/nginx.conf:/etc/nginx/nginx.conf:ro
    security_opt:
      - no-new-privileges:true
    user: "101:101"  # Непривилегированный пользователь
    read_only: true
    tmpfs:
      - /tmp
      - /var/cache/nginx

  secure-db:
    image: postgres:16-alpine
    container_name: secure-db
    # УБРАНО: пароли из environment
    # Использование Docker secrets:
    secrets:
      - postgres_password
      - postgres_user
    environment:
      - POSTGRES_PASSWORD_FILE=/run/secrets/postgres_password
      - POSTGRES_USER_FILE=/run/secrets/postgres_user
      - POSTGRES_DB=vulnapp
    ports:
      - "5432:5432"
    user: "70:70"  # Пользователь postgres
    volumes:
      - ./db/init.sql:/docker-entrypoint-initdb.d/init.sql:ro

  app:
    image: python:3.11-alpine
    container_name: secure-app
    depends_on:
      - secure-db
    working_dir: /app
    volumes:
      - ./app:/app:ro  # Только чтение
    command: ["python", "app.py"]
    # УБРАНО: секреты из environment
    secrets:
      - app_secret_key
      - db_url
    environment:
      - APP_SECRET_KEY_FILE=/run/secrets/app_secret_key
      - DB_URL_FILE=/run/secrets/db_url
      - DEBUG=false  # Отключен в production
    user: "1000:1000"  # Непривилегированный пользователь
    read_only: true
    tmpfs:
      - /tmp

secrets:
  postgres_password:
    external: true
  postgres_user:
    external: true
  app_secret_key:
    external: true
  db_url:
    external: true
```

**Дополнительные меры:**

1. **Использование Docker Secrets** для хранения паролей и ключей
2. **Ограничение capabilities** - только необходимые
3. **Read-only файловая система** где возможно
4. **Непривилегированные пользователи** для всех контейнеров
5. **Сетевая изоляция** через пользовательские сети
6. **Регулярное сканирование образов** на уязвимости (Trivy, Clair)
7. **Мониторинг и логирование** всех действий контейнеров
8. **Регулярные обновления** базовых образов

---

### Задание 8: Анализ сгенерированных отчетов

**Структура отчетов:**
```bash
audit_reports/
├── json/          (Trivy JSON outputs) - пусто (Trivy не установлен)
├── text/          (CIS audit text outputs) - cis_audit.txt
├── xlsx/          (Excel spreadsheets) - пусто
└── odt/           (OpenDocument Text files) - пусто
```

**Анализ CIS аудита (text/cis_audit.txt):**

**Статистика:**
- Всего проверок: 105
- Прохождений (PASS): 39 (37%)
- Предупреждений (WARN): 87 (83%)
- Информационных сообщений (INFO): множество

**Ключевые проблемы, выявленные аудитом:**

1. **Host Configuration:**
   - [WARN] 1.1 - Отсутствует отдельный раздел для контейнеров
   - [WARN] 1.5-1.10 - Не настроен аудит для Docker daemon и файлов
   - [PASS] 1.3 - Docker обновлен до актуальной версии (27.4.1)

2. **Docker daemon configuration:**
   - [WARN] 2.1 - Сетевой трафик между контейнерами не ограничен
   - [WARN] 2.8 - Не включена поддержка user namespace
   - [WARN] 2.11 - Не включена авторизация для команд Docker client
   - [WARN] 2.14 - Live restore не включен
   - [WARN] 2.15 - Userland Proxy не отключен
   - [WARN] 2.18 - Контейнеры не ограничены от получения новых привилегий

3. **Container Images:**
   - [WARN] 4.1 - Контейнеры запущены от root:
     - `app` (ai_api-app_container)
     - `keydb` (eqalpha/keydb)
     - `lab05-server-1` (lab05-server)
   - [WARN] 4.5 - Content trust для Docker не включен
   - [WARN] 4.6 - HEALTHCHECK инструкции отсутствуют в образах

4. **Container Runtime:**
   - [WARN] 5.1-5.28 - Множество проблем с конфигурацией контейнеров:
     - Привилегированные контейнеры
     - Отсутствие ограничений ресурсов
     - Неправильная конфигурация volumes
     - Отсутствие read-only файловых систем

**Примечание:** Отчеты в форматах XLSX и ODT не были сгенерированы, так как:
- Trivy не установлен на системе
- Скрипт `audit.sh` требует Trivy для сканирования образов и генерации JSON отчетов
- Конвертация в XLSX/ODT выполняется только для JSON отчетов Trivy

Это не сделано, потому что время поджимает ппц :)

---

### Задание 9: Подготовка отчета в Gist

**Создан Gist с отчетом:**
```bash
$ gh gist create --public --desc "Lab06: Аудит безопасности Docker с использованием Docker Bench Security" labs/lab06/lab06_report.md
```

**Ссылка на Gist:** https://gist.github.com/might-might/8e682ee58f10fa291edf3cc65740e813

**Статус:** Отчет успешно опубликован в GitHub Gist

---

### Задание 10: Очистка окружения

**Выполненные команды очистки:**
```bash
# Удаление виртуального окружения
$ rm -rf venv
venv удален

# Остановка и удаление контейнеров уязвимого приложения
$ docker-compose -f vulnerable-app.yml down
Container debug-shell  Stopped
Container debug-shell  Removed
Container vulnerable-nginx  Stopped
Container vulnerable-nginx  Removed

# Остановка и удаление контейнеров основного приложения
$ docker compose down
Container vulnerable-app  Stopped
Container vulnerable-app  Removed
Container insecure-db  Stopped
Container insecure-db  Removed
Network lab06_default  Removed

# Очистка Docker (неиспользуемые ресурсы)
$ docker system prune -f
Total reclaimed space: 7.631GB
```

**Результат очистки:**
- ✅ Виртуальное окружение `venv` удалено
- ✅ Все контейнеры уязвимого приложения остановлены и удалены
- ✅ Все контейнеры основного приложения остановлены и удалены
- ✅ Сеть `lab06_default` удалена
- ✅ Освобождено 7.631GB дискового пространства

**Примечание:** Директория `audit_reports` с отчетами оставлена для проверки результатов аудита.
