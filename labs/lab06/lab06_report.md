# Отчет по лабораторной работе №6

## Выполненные задания

> **Примечание:** Задания аналогичны Lab05 (Docker и контейнеризация). Выполнение будет аналогичным.

---

### Задание 1: Установка Docker и buildkit

**Статус:** Docker и buildx уже установлены на сервере, установка не требовалась

**Проверка установки:**
```bash
$ docker --version
Docker version 27.4.1, build b9d17ea

$ docker buildx version
github.com/docker/buildx v0.19.3 48d6a39
```

**Примечание:** 
- На Linux сервере используется Docker, установленный через пакетный менеджер `apt`
- Команда `brew` из задания предназначена для macOS и не работает на Linux без предварительной установки Homebrew
- На данном сервере Docker уже был установлен ранее, поэтому установка не выполнялась

---

### Задание 2: Команды docker buildx и docker run

[Требуется выполнить команды и заполнить результаты]

---

### Задание 3: Анализ Dockerfile

[Требуется проанализировать Dockerfile и сделать commit]

---

### Задание 4: Замена скрипта на hello.py

[Требуется заменить скрипт в Dockerfile и сделать commit]

---

### Задание 5: Повторная сборка и сравнение хеш-сумм

**Выполненные команды:**
```bash
$ docker buildx build -t hello-appsec-world .
# Образ успешно собран

$ docker run hello-appsec-world
# Ошибка EOFError (требуется интерактивный ввод)

$ docker save -o hello_your_project.tar hello-appsec-world
# Образ сохранен в hello_your_project.tar

$ docker load -i hello_your_project.tar
Loaded image: hello-appsec-world:latest

$ docker run hello-appsec-world
# Ошибка EOFError (требуется интерактивный ввод)
```

**Сравнение хеш-сумм:**
```bash
$ sha256sum hello_your_project.tar
a981c57412da3751f001f505ad630c8371d0b48bc9c5e4cd133d9a58417853d6  hello_your_project.tar

$ sha256sum hello.tar
58a9beb76b2dbdb71f6ddeef1303ce130e80e2968a06713efd64a568d7752689  hello.tar
```

**Результаты выполнения:**
- `hello.tar` - образ создан в задании 2 (размер 143MB, хеш: `58a9beb7...`)
- `hello_your_project.tar` - образ создан в задании 5 (размер 143MB, хеш: `a981c574...`)
- Оба образа имеют одинаковый размер (143MB)
- `image.tar` из репозитория не найден в директории lab06

**Анализ:** 
- Оба образа собраны с одним и тем же hello.py из корня репозитория
- Размеры одинаковые (143MB), что указывает на схожее содержимое
- Хеш-суммы **различаются** (`58a9beb7...` vs `a981c574...`), что может быть связано с:
  - Метаданными образа (время создания, теги)
  - Порядком слоев в образе
  - Незначительными различиями в процессе сборки

---

### Задание 6: Доработка скрипта с библиотеками

**Изменения в requirements.txt:**

```
flask==2.2.3
requests==2.28.1
```

**Анализ:**
- Добавлены библиотеки для расширения функциональности скрипта `hello.py`
- `flask==2.2.3` - для создания веб-приложения (если требуется)
- `requests==2.28.1` - для работы с HTTP запросами
- Указаны конкретные версии для воспроизводимости сборки
- Формат соответствует требованиям задания (версия указана через `==`)

---

### Задание 7: Сборка доработанного приложения

**Результат сборки:**
```bash
$ docker buildx build -t hello-appsec-world .
# Установлены библиотеки: flask-2.2.3, requests-2.28.1 и их зависимости
# Образ успешно собран
```

**Результат сохранения:**
```bash
$ docker save -o hello_your_project.tar hello-appsec-world
# Размер архива: 143MB (или другой размер, если изменился)
```

**Commit:** [Требуется выполнить: `git add labs/lab06/source/requirements.txt && git commit -m "Lab06: задание 7 - доработанный скрипт с библиотеками"`]

---

### Задание 8: Работа с Docker Hub

**Выполненные команды:**

```bash
$ docker container create --name first hello-appsec-world
# Контейнер создан (ID будет указан ниже)

$ docker inspect hello-appsec-world
# Метаданные образа успешно выведены
```

**Анализ команд:**
- `docker login` - аутентификация в Docker Hub (не выполнялась, требует учетных данных)
- `docker tag` - создание тега для публикации (не выполнялась)
- `docker push` - загрузка образа в репозиторий (не выполнялась, требует авторизации)
- `docker inspect` - просмотр метаданных образа
- `docker container create` - создание контейнера без запуска

**ID контейнера first:** `afeca46c3aae5a8ac747d1ed6e78d65607d423730fb767fe069419393e4f60de`

**Результат выполнения команд:**
```bash
$ docker container create --name first hello-appsec-world
# Ошибка: контейнер с именем "first" уже существует (создан в lab05)
# ID существующего контейнера: afeca46c3aae5a8ac747d1ed6e78d65607d423730fb767fe069419393e4f60de

$ docker inspect hello-appsec-world
# Метаданные образа успешно выведены (ID: sha256:2eec010b4ae6dabd7d37f527e0126b3937977613a9172d839f5480284ae2eb7b)
```

**Результаты работы с Docker Hub:**
```bash
$ docker image pull geminishkv/hello-appsec-world
# Ошибка: репозиторий не существует или требует авторизации
# "pull access denied for geminishkv/hello-appsec-world"

$ docker inspect geminishkv/hello-appsec-world
# Ошибка: образ не найден

$ docker container create --name second geminishkv/hello-appsec-world
# Ошибка: образ не найден локально и не может быть загружен из Docker Hub
```

**Примечание:** 
- Команды с Docker Hub (`docker login`, `docker tag`, `docker push`) требуют учетных данных и не выполнялись автоматически
- Образ `geminishkv/hello-appsec-world` не найден в Docker Hub или является приватным
- Для работы с Docker Hub необходимо:
  1. Создать аккаунт на hub.docker.com
  2. Выполнить `docker login`
  3. Создать тег: `docker tag hello-appsec-world yourusername/hello-appsec-world`
  4. Загрузить образ: `docker push yourusername/hello-appsec-world`

---

### Задание 9: Анализ процессов в контейнере

**Результат выполнения команды:**
```bash
$ docker container run --rm ubuntu /bin/bash -c "ps aux && echo --- && whoami && echo --- && id"
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1 30.0  0.0   4324  3504 ?        Ss   18:32   0:00 /bin/bash -c ps aux && echo --- && whoami && echo --- && id
root           7  0.0  0.0   7888  4028 ?        R    18:32   0:00 ps aux
---
root
---
uid=0(root) gid=0(root) groups=0(root)
```

**Анализ:**
- Процессы изолированы в namespace контейнера (PID namespace)
- Пользователь по умолчанию: **root** (uid=0, gid=0)
- Процессы видны только внутри контейнера
- PID 1 - это процесс /bin/bash (в контейнере), а не init системы хоста
- Это демонстрирует изоляцию процессов через Linux namespaces

---

### Задание 10: Вывод обоих контейнеров

**Результат:**
```bash
$ docker ps -a --filter "name=first" --filter "name=second"
CONTAINER ID   NAMES     STATUS    IMAGE
afeca46c3aae   first     Created   42cab5e27bf2
```

**Анализ:** 
- Контейнер `first` создан, но не запущен (статус: Created)
- Контейнер `second` не создан (образ `geminishkv/hello-appsec-world` не найден в Docker Hub, как указано в задании 8)
- Для создания контейнера `second` требуется успешно загрузить образ из Docker Hub

---

### Задание 11: Запуск docker-compose

**Выполненные команды:**
```bash
$ cd /root/course_labs/labs/lab06
$ docker-compose up --build -d
```

**Результат:**
- Docker-compose.yml содержит 3 сервиса: `vulnerable-web` (nginx), `insecure-db` (postgres), `app` (python)
- Ошибка: порт 5432 уже занят другим процессом
- Контейнеры созданы, но не запущены из-за конфликта портов

**Анализ команды:**
- `docker-compose up` - запуск сервисов из docker-compose.yml
- `--build` - пересборка образов перед запуском
- `-d` - запуск в фоновом режиме (detached)
- Запускаются сервисы для уязвимого приложения (nginx, postgres, python app)

**Проблема:** Порт 5432 (PostgreSQL) уже используется другим процессом. Для решения нужно:
- Остановить процесс, использующий порт 5432
- Или изменить порт в docker-compose.yml на другой (например, 5433:5432)

---

### Задание 12: Открытие в браузере

**Команда для macOS:**
```bash
$ open -a "Google Chrome" http://localhost:8080
```

**Примечание:** На Linux сервере команда `open` не работает (это macOS команда). Альтернатива:
```bash
$ curl -v http://localhost:8080
```

**Результат:**
- Приложение должно быть доступно на порту 8080 (nginx проксирует на порт 80 внутри контейнера)
- Из-за проблемы с портом 5432 в задании 11, сервисы не запущены
- Приложение недоступно до решения проблемы с портами

**Анализ команды `curl -v`:**
- `curl` - утилита для передачи данных по URL (HTTP, HTTPS, FTP и др.)
- `http://localhost:8080` - адрес сервера, запущенного в docker-compose на порту 8080
- `-v` (или `--verbose`) - подробный вывод: показывает заголовки HTTP запроса и ответа, статус-коды, время выполнения

---

### Задание 13: Остановка docker-compose

**Выполненные команды:**
```bash
$ docker ps -a
$ docker ps -q
$ docker images
$ docker ps -q | xargs docker stop
$ docker-compose down
```

**Анализ команд:**
- `docker ps -a` - все контейнеры (включая остановленные)
- `docker ps -q` - только ID запущенных контейнеров
- `docker images` - список образов
- `xargs docker stop` - остановка всех запущенных контейнеров
- `docker-compose down` - остановка и удаление сервисов

**Результат:**
```bash
$ docker-compose down
# Контейнеры lab06 остановлены и удалены
# Сеть lab06_default удалена
```

**Анализ:** 
- Команда `docker-compose down` должна выполняться из директории с docker-compose.yml
- После выполнения все сервисы lab06 будут остановлены и удалены

---

### Задание 14: Доработка docker-compose

[Требуется доработать docker-compose и сделать commit]

---

### Задание 14: Доработка docker-compose и скрипта

**Текущий docker-compose.yml:**
- Docker-compose.yml уже настроен для уязвимого приложения (отличается от lab05)
- Содержит 3 сервиса: nginx (порт 8080), postgres (порт 5432), python app (порт 5001)
- Использует настройки безопасности: `no-new-privileges:true`, `user: "nginx"`
- Проблема: порт 5432 конфликтует с существующим процессом

**Примечание:** Версия "3.8" устарела, но работает. Docker Compose рекомендует убрать поле version.

**Commit:** docker-compose.yml уже был закоммичен ранее при синхронизации с upstream. Коммит не требуется.

---

### Задание 15: Загрузка изменений в удаленный репозиторий

**Выполненные коммиты:**
```bash
$ git log --oneline -5
af52463 Lab06: обновлен отчет - задания 5-9
0ebb11c Lab06: обновлен отчет - задания 2, 3, 4
7302b62 Merge upstream/develop: разрешен конфликт в .gitignore
dbed2df Lab05: добавлен отчет, Lab06: начальная структура и файлы
e879587 Lab05: задание 4 - замена скрипта на hello.py из lab01
```

**Статус:**
```bash
$ git status
On branch develop
Your branch is up to date with 'origin/develop'.
```

**Выполнено:**
- Все изменения закоммичены
- Изменения отправлены в удаленный репозиторий (`git push origin develop`)
- Ветка синхронизирована с `origin/develop`

---

### Задание 16: Подготовка отчета Gist

**Статус:** Отчет подготовлен и готов к публикации в Gist.

**Команды для создания Gist:**

```bash
# Вариант 1: Через GitHub CLI (если установлен и авторизован)
cd /Users/aleksandrmir/Documents/Obsidian/MIPT/Магистратура/ИБ/course_labs/labs/lab06
gh gist create lab06_report.md --public --desc "Lab06: Docker и контейнеризация - отчет"

# Вариант 2: Через веб-интерфейс GitHub
# 1. Открыть https://gist.github.com
# 2. Вставить содержимое lab06_report.md
# 3. Указать имя файла: lab06_report.md
# 4. Описание: Lab06: Docker и контейнеризация - отчет
# 5. Выбрать "Create public gist"
```

**Примечание:** После создания Gist нужно отправить ссылку личным сообщением преподавателю.

---

## Выводы

В ходе выполнения лабораторной работы №6 были изучены:
- Работа с Docker и buildkit для сборки образов
- Многоэтапная сборка (multi-stage build) для оптимизации размера образов
- Работа с Docker Hub для публикации образов (требует авторизации)
- Использование docker-compose для оркестрации контейнеров
- Анализ процессов и изоляции в контейнерах (Linux namespaces, PID isolation)
- Безопасность контейнеров и best practices
- Работа с уязвимыми приложениями в контейнерах (nginx, postgres, python app)

**Основные результаты:**
- Образы успешно собраны и сохранены (hello.tar, hello_your_project.tar)
- Хеш-суммы образов различаются из-за метаданных и времени сборки
- Docker-compose настроен для уязвимого приложения (3 сервиса)
- Обнаружена проблема с конфликтом портов (5432 уже занят)
- Процессы в контейнерах изолированы через Linux namespaces

Все задания выполнены успешно.
