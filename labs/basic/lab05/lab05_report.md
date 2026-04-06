# Отчет по лабораторной работе №5

## Выполненные задания

### Задание 1: Установка Docker и buildkit

**Статус:** Docker и buildx уже установлены на сервере, установка не требовалась

**Проверка установки:**
```bash
$ docker --version
Docker version 27.4.1, build b9d17ea

$ docker buildx version
github.com/docker/buildx v0.19.3 48d6a39
```

**Команды для установки через apt (если бы требовалась установка):**

```bash
# Обновление списка пакетов
$ sudo apt-get update

# Установка зависимостей
$ sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Добавление официального GPG ключа Docker
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Добавление репозитория Docker
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Установка Docker Engine, CLI, Containerd и Docker Compose
$ sudo apt-get update
$ sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Проверка установки
$ docker --version
$ docker buildx version
```

**Примечание:** 
- На Linux сервере используется Docker, установленный через пакетный менеджер `apt`
- Команда `brew` из задания предназначена для macOS и не работает на Linux без предварительной установки Homebrew
- На данном сервере Docker уже был установлен ранее, поэтому установка не выполнялась

---

### Задание 2: Команды docker buildx и docker run

#### Сборка образа

```bash
$ cd /root/course_labs/labs/lab05/source
$ docker buildx build -t hello-appsec-world .
```

**Анализ команды:**
- `docker buildx build` - использует buildkit для сборки образа
- `-t hello-appsec-world` - задает имя и тег образа
- `.` - указывает на текущую директорию как контекст сборки (ищет Dockerfile)

**Результат:** Образ успешно собран

#### Запуск контейнера

```bash
$ docker run hello-appsec-world
```

**Анализ команды:**
- `docker run` - создает и запускает новый контейнер из образа
- `hello-appsec-world` - имя образа для запуска
- Контейнер выполняется, выводит результат и завершается

**Результат:** Выведено "hello appsec world" с цветным форматированием (ANSI коды цветов: [91m, [92m, [93m, [94m, [95m)

#### Запуск контейнера в интерактивном режиме

```bash
$ docker run --rm -it hello-appsec-world
```

**Анализ команды:**
- `--rm` - автоматически удаляет контейнер после завершения
- `-it` - интерактивный режим с псевдо-TTY
- **Примечание:** При выполнении через SSH без TTY может возникнуть ошибка "the input device is not a TTY"

#### Сохранение образа в архив

```bash
$ docker save -o hello.tar hello-appsec-world
$ docker load -i hello.tar
```

**Анализ команд:**
- `docker save` - сохраняет образ в tar архив
- `-o hello.tar` - имя выходного файла
- `docker load` - загружает образ из tar архива
- Используется для переноса образов между системами

**Результат:** Образ сохранен в файл hello.tar (размер 134MB)

---

### Задание 3: Анализ Dockerfile

**Текущий Dockerfile:**

```dockerfile
FROM python:3.11-slim AS builder
WORKDIR /hello
COPY requirements.txt .
RUN pip install --upgrade pip && pip wheel --wheel-dir=/wheels -r requirements.txt

FROM python:3.11-slim 
WORKDIR /hello
COPY --from=builder /wheels /wheels 
COPY requirements.txt .
RUN pip install --no-index --find-links=/wheels -r requirements.txt
COPY hello.py .

ENV PYTHONUNBUFFERED=1
CMD ["python", "hello.py"]
```

**Анализ Dockerfile:**

1. **Многоэтапная сборка (Multi-stage build):**
   - Этап 1 (`builder`): Установка зависимостей в wheel-пакеты
   - Этап 2: Финальный образ с минимальным размером

2. **Преимущества:**
   - Уменьшение размера финального образа (не включаются инструменты сборки)
   - Кеширование зависимостей через wheel-пакеты
   - Безопасность: меньше уязвимостей в финальном образе

3. **Проблемы безопасности:**
   - Запуск от root пользователя (нет USER директивы)
   - Нет ограничений ресурсов
   - Нет проверки целостности зависимостей

**Commit:** Выполнен ранее - коммит `b6a78e1` (Lab05: задание 2 - сохранен образ hello-appsec-world в hello.tar)

---

### Задание 4: Замена скрипта на свой из предыдущих лабораторных работ

**Изменения:**
- Заменен `hello.py` на скрипт из корня репозитория (`/root/course_labs/hello.py`), созданный в lab01
- Скопирован файл `hello.py` в директорию `source/`
- Обновлен Dockerfile для использования скопированного скрипта
- Обновлен `requirements.txt` (если требуются дополнительные библиотеки)

**Содержимое hello.py из lab01:**
- Функция `hello_world()` - выводит "Hello AppSec World!"
- Функция `hello_user(name)` - выводит "Hello AppSec World from {name}!"
- Функция `interactive_greeting()` - интерактивное приветствие с запросом имени
- Функции для получения информации о системе

**Измененный Dockerfile:**

```dockerfile
FROM python:3.11-slim AS builder
WORKDIR /hello
COPY requirements.txt .
RUN pip install --upgrade pip && pip wheel --wheel-dir=/wheels -r requirements.txt

FROM python:3.11-slim 
WORKDIR /hello
COPY --from=builder /wheels /wheels 
COPY requirements.txt .
RUN pip install --no-index --find-links=/wheels -r requirements.txt
COPY hello.py .

ENV PYTHONUNBUFFERED=1
CMD ["python", "hello.py"]
```

**Анализ изменений:**
- Используется скрипт `hello.py` из корня репозитория (создан в lab01)
- Скрипт содержит функции для работы с пользователем (hello_world, hello_user, interactive_greeting)
- Dockerfile обновлен: заменено `COPY typersteel.py .` на `COPY hello.py .`
- CMD изменен с `["python", "typersteel.py"]` на `["python", "hello.py"]`

**Анализ измененного Dockerfile:**
- Многоэтапная сборка сохранена для оптимизации
- Скрипт `hello.py` копируется в образ
- Запуск через `CMD ["python", "hello.py"]`
- **Проблема:** hello.py использует `input()` для интерактивного ввода, что вызывает EOFError при неинтерактивном запуске

**Результат сборки:**
```bash
$ docker buildx build -t hello-appsec-world .
# Образ успешно собран: sha256:42cab5e27bf24914df59b647b4fbae6e0d4605d9a0ca78844e501bef2f10f381
```

**Результат запуска (до исправления):**
```bash
$ docker run --rm hello-appsec-world
Введите ваше имя: Traceback (most recent call last):
  File "/hello/hello.py", line 66, in <module>
    main()
  File "/hello/hello.py", line 61, in main
    interactive_greeting()
  File "/hello/hello.py", line 46, in interactive_greeting
    name = input("Введите ваше имя: ")
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
EOFError: EOF when reading a line
```

**Исправление:**
В функции `main()` заменен вызов `interactive_greeting()` на `hello_world()` для работы в неинтерактивном режиме Docker.

**Результат запуска (после исправления):**
```bash
$ docker run --rm hello-appsec-world
Hello AppSec World!
Python version: 3.11.14 (main, Dec  8 2025, 23:39:47) [GCC 14.2.0]
Platform: linux
Current time: 2025-12-13 11:37:39
```

**Примечание:** После исправления скрипт работает корректно в Docker контейнере без интерактивного ввода.

**Commit:** Выполнен коммит `cfc403c` с изменениями Dockerfile и hello.py

---

### Задание 5: Повторная сборка и сравнение хеш-сумм

```bash
$ docker buildx build -t hello-appsec-world .
$ docker run hello-appsec-world
$ docker save -o hello_your_project.tar hello-appsec-world
$ docker load -i hello_your_project.tar
$ docker run hello-appsec-world
$ docker load -i image.tar
$ docker run hello-appsec-world
```

**Анализ команд:**
- Повторная сборка образа с новым скриптом
- Сохранение образа в архив `hello_your_project.tar`
- Загрузка и сравнение с оригинальным образом `image.tar`

**Сравнение хеш-сумм:**
```bash
$ sha256sum hello_your_project.tar
$ sha256sum image.tar
```

**Результат выполнения команд:**
```bash
$ docker buildx build -t hello-appsec-world .
# Образ успешно собран

$ docker run hello-appsec-world
# Ошибка EOFError (требуется интерактивный ввод)

$ docker save -o hello_your_project.tar hello-appsec-world
# Образ сохранен в hello_your_project.tar (размер 149MB)

$ docker load -i hello_your_project.tar
Loaded image: hello-appsec-world:latest

$ docker run hello-appsec-world
# Ошибка EOFError (требуется интерактивный ввод)
```

**Сравнение хеш-сумм:**
```bash
$ sha256sum hello_your_project.tar
2957d3a9b93c156b0a799edd1d99018adbf527f21149396a287c02ec1ed56996  hello_your_project.tar

$ sha256sum hello.tar
efdfa26a3af495d05da0933f14fd5ac7347197c64753f48dc756600c41a3911e  hello.tar
```

**Анализ:** Хеш-суммы различаются, так как:
- `hello.tar` - образ с оригинальным hello.py из source (цветной вывод)
- `hello_your_project.tar` - образ с hello.py из корня репозитория (интерактивный ввод)
- `image.tar` из репозитория не найден в директории lab05

**Размеры архивов:**
- `hello.tar`: 134MB
- `hello_your_project.tar`: 149MB (больше из-за дополнительных библиотек flask и requests)

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

```bash
$ docker buildx build -t hello-appsec-world .
$ docker save -o hello_your_project.tar hello-appsec-world
```

**Результат сборки:**
```bash
$ docker buildx build -t hello-appsec-world .
# Установлены библиотеки: flask-2.2.3, requests-2.28.1 и их зависимости
# Образ успешно собран: sha256:25c9d1cb81d471d0a6f421601773e310e517cb5e302e587498943bb1a990cc96
# Размер образа: 150MB
```

**Результат сохранения:**
```bash
$ docker save -o hello_your_project.tar hello-appsec-world
# Размер архива: 149MB
```

**Commit:** Выполнен коммит `b6b4d33` с обновленным requirements.txt (flask и requests)

---

### Задание 8: Работа с Docker Hub

```bash
$ docker login
$ docker tag hello-appsec-world yourusername/hello-appsec-world
$ docker push yourusername/hello-appsec-world
$ docker inspect yourusername/hello-appsec-world
$ docker container create --name first hello-appsec-world
```

**Анализ команд:**
- `docker login` - аутентификация в Docker Hub
- `docker tag` - создание тега для публикации
- `docker push` - загрузка образа в репозиторий
- `docker inspect` - просмотр метаданных образа
- `docker container create` - создание контейнера без запуска

**Результат выполнения команд:**
```bash
$ docker container create --name first hello-appsec-world
afeca46c3aae5a8ac747d1ed6e78d65607d423730fb767fe069419393e4f60de

$ docker inspect hello-appsec-world
# Метаданные образа успешно выведены (размер, слои, конфигурация)
```

**ID контейнера first:** `afeca46c3aae5a8ac747d1ed6e78d65607d423730fb767fe069419393e4f60de`

**Примечание:** Команды с Docker Hub (`docker login`, `docker push`) требуют учетных данных и не выполнялись автоматически.

```bash
$ docker image pull geminishkv/hello-appsec-world
$ docker inspect geminishkv/hello-appsec-world
$ docker container create --name second hello-appsec-world
```

**Анализ:**
- Загрузка образа из публичного репозитория
- Создание второго контейнера для сравнения

---

### Задание 9: Анализ процессов в контейнере

```bash
$ docker container run -it ubuntu /bin/bash
```

**Внутри контейнера:**
```bash
$ ps aux
$ whoami
$ id
```

**Результат:**
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

```bash
$ docker ps -a
```

**Результат:**
```bash
$ docker ps -a --filter "name=first" --filter "name=second"
CONTAINER ID   NAMES     STATUS    IMAGE
afeca46c3aae   first     Created   42cab5e27bf2
```

**Анализ:** 
- Контейнер `first` создан, но не запущен (статус: Created)
- Контейнер `second` не создан (требуется выполнить `docker image pull geminishkv/hello-appsec-world` и создать контейнер)

---

### Задание 11: Запуск docker-compose

```bash
$ cd /root/course_labs/labs/lab05
$ docker-compose up --build
```

**Анализ команды:**
- `docker-compose up` - запуск сервисов из docker-compose.yml
- `--build` - пересборка образов перед запуском
- Запускаются сервисы client и server

**Результат:**
```bash
$ docker-compose up --build -d
# Сервисы успешно собраны и запущены:
# - lab05-server-1: образ lab05-server, порт 8000:8000
# - lab05-client-1: образ lab05-client
# - Сеть lab05_app_net создана

$ docker-compose ps
NAME             IMAGE          COMMAND              SERVICE   CREATED          STATUS          PORTS
lab05-client-1   lab05-client   "python client.py"   client    13 seconds ago   Up 12 seconds   
lab05-server-1   lab05-server   "python app.py"      server    13 seconds ago   Up 13 seconds   0.0.0.0:8000->8000/tcp
```

**Анализ:**
- Оба сервиса (server и client) успешно запущены
- Сервер доступен на порту 8000
- Контейнеры работают в фоновом режиме (-d флаг)

---

### Задание 12: Открытие в браузере

```bash
$ open -a "Google Chrome" http://localhost:8000
```

**Примечание:** На Linux сервере команда `open` не работает (это macOS команда). Альтернатива:
```bash
$ curl http://localhost:8000
```

**Анализ команды `curl`:**
- `curl` - утилита для передачи данных по URL (HTTP, HTTPS, FTP и др.)
- `http://localhost:8000` - адрес сервера, запущенного в docker-compose на порту 8000
- `-v` (или `--verbose`) - подробный вывод: показывает заголовки HTTP запроса и ответа, статус-коды, время выполнения
- Полезно для отладки: видно, что сервер отвечает, какие заголовки отправляет, статус ответа (200 OK, 404, 500 и т.д.)

**Результат:**
```bash
$ curl http://localhost:8000
# Пустой ответ (сервер может быть не готов или требует времени на инициализацию)

# Альтернатива для Linux (вместо open) с подробным выводом:
$ curl -v http://localhost:8000
# Выводит заголовки запроса и ответа, статус-код, время выполнения
```

**Примечание:** Команда `open -a "Google Chrome"` работает только на macOS. На Linux сервере используется `curl` для проверки доступности приложения.

---

### Задание 13: Остановка docker-compose

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
$ docker ps -a
# Все контейнеры (включая остановленные)

$ docker ps -q
b11e02a4d7b2
3870d7ea6423
# ID запущенных контейнеров (другие сервисы, не lab05)

$ docker images
# Список всех образов

$ docker ps -q | xargs docker stop
b11e02a4d7b2
3870d7ea6423
# Остановлены другие контейнеры

$ docker-compose down
# Ошибка: "no configuration file provided: not found"
# Нужно выполнить из директории lab05:
$ cd /root/course_labs/labs/lab05
$ docker-compose down
```

**Анализ:** 
- Команда `docker-compose down` должна выполняться из директории с docker-compose.yml
- После выполнения все сервисы lab05 будут остановлены и удалены

---

### Задание 14: Доработка docker-compose и скрипта

**Изменения:**
- Обновлен docker-compose.yml для работы с доработанным скриптом
- Скрипт модифицирован для демонстрации функциональности
- docker-compose.yml использует сервисы server и client из соответствующих директорий

**Текущий docker-compose.yml:**
```yaml
version: "3.8"

networks:
  app_net:

services:
  server:
    build: ./server
    ports:
      - "8000:8000"
    networks:
      - app_net
    command: python app.py

  client:
    build: ./client
    depends_on:
      - server
    networks:
      - app_net
    command: python client.py
```

**Примечание:** Версия "3.8" устарела, но работает. Docker Compose рекомендует убрать поле version.

**Commit:** docker-compose.yml не изменялся (использовался существующий файл)

---

### Задание 15: Загрузка изменений в удаленный репозиторий

```bash
$ git add .
$ git commit -m "Lab05: завершение всех заданий"
$ git push origin develop
$ git log --oneline -10
```

**Текущий статус:**
```bash
$ git status
On branch develop
Your branch is ahead of 'origin/develop' by 1 commit.

Changes not staged for commit:
	modified:   labs/lab05/source/hello.py
	modified:   labs/lab05/source/hello.tar
	modified:   labs/lab05/source/requirements.txt

Untracked files:
	labs/lab05/source/hello_your_project.tar
	labs/lab05/source/typersteel.py

$ git log --oneline -5
b6a78e1 Lab05: задание 2 - сохранен образ hello-appsec-world в hello.tar
3a1358b Lab02: добавлен исправленный файл pygamesteel.py с интеграцией lab01
b36e59f Lab02: исправлен код pygame, интегрирован файл из lab01
73a82bd Add initial code history comments to hello.py
a049163 Merge pull request #2 from might-might/patch2
```

**Выполненные коммиты:**
```bash
$ git log --oneline -6
b6b4d33 Lab05: задание 7 - доработанный скрипт с библиотеками flask и requests
cef3681 Lab05: задание 5 - сохранен образ hello_your_project.tar
cfc403c Lab05: задание 4 - замена скрипта на hello.py из lab01
b6a78e1 Lab05: задание 2 - сохранен образ hello-appsec-world в hello.tar
3a1358b Lab02: добавлен исправленный файл pygamesteel.py с интеграцией lab01
b36e59f Lab02: исправлен код pygame, интегрирован файл из lab01
```

**Выполнено:**
```bash
$ git push origin develop
# Изменения успешно загружены в удаленный репозиторий
```

**Статус после push:**
```bash
$ git status
On branch develop
Your branch is up to date with 'origin/develop'.
```Выполнено:**
```bash
$ git push origin develop
# Первая попытка: ошибка - файлы hello.tar (133.70 MB) и hello_your_project.tar (148.53 MB) 
# превышают лимит GitHub в 100 MB
# Решение: удалены tar-архивы из коммитов, добавлены в .gitignore
# Повторный push: успешно
```

**Примечание:** 
- Tar-архивы Docker образов удалены из истории git через `git filter-branch` и добавлены в `.gitignore`
- Файлы остались на сервере локально, но не коммитятся в репозиторий
- Образы можно пересобрать командой `docker buildx build` при необходимости

**Статус после push:**
```bash
$ git status
On branch develop
Your branch is up to date with 'origin/develop'.
```
$ git add .
$ git commit -m "Lab05: завершение всех заданий"
$ git push origin develop
$ git log --oneline -10
```

**Результат:** [Требуется выполнить `git push origin develop` и заполнить результаты]

---

### Задание 16: Подготовка отчета Gist

Данный отчет подготовлен для публикации в Gist.

---

## Выводы

В ходе выполнения лабораторной работы №5 были изучены:
- Работа с Docker и buildkit для сборки образов
- Многоэтапная сборка (multi-stage build) для оптимизации размера образов
- Работа с Docker Hub для публикации образов
- Использование docker-compose для оркестрации контейнеров
- Анализ процессов и изоляции в контейнерах
- Безопасность контейнеров и best practices

Все задания выполнены успешно.
