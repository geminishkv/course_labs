<div align="center">
<h1><a id="intro">Лабораторная работа №5</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a>
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white" alt="Docker">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Салют :wave:,<br>
Данная лабораторная работа посвящена изучению Docker и как с ним работать. Эта лабораторная работа послужит подпоркой для старта в выявлении и определении уязвимостей на уровне сканирования контейнеров при сборке приложений. 

Для сдачи данной работы также будет требоваться ответить на дополнительные вопросы по описанным темам.

***

## Структура репозитория лабораторной работы

```bash
lab05
├── client
│   ├── client.py
│   ├── Dockerfile
│   └── requirements.txt
├── docker-compose.yml
├── README.md
├── server
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
└── source
    ├── Dockerfile
    ├── hello.py
    ├── image.tar
    └── requirements.txt
```

***

## Материал

### Контейнеризация

Сборка приложения включает создание контейнерного образа, в котором упаковано приложение с конфигурациями, чтобы приложение функционировало. `Docker` основан на использовании общих функций ядра `ОС Linux` (`cgroups`, `namespace`) для изоляции и управления ресурсами.

> **Образ** — это статический, неизменяемый шаблон, на базе которого создаются контейнера с ОС, приложением, зависимостями, библиотекакм и конфигурационными файлами. Нужен для создания воспроизводимой, неизменяемой среды выполнения приложений в контейнерах.

Для сборки образов используется `Dockerfile`, где прописаны версии зависимостей и инструкции, минимизирующие разрешения и атаки. Это инструкции, где описывается, как собрать образ. Впоследствии собирается контейнер.

> **Контейнер** — это изолированная среда выполнения приложения с необходимыми зависимостями, кодом, системными утилитами, библиотеками и настройками. Использует не собственную гостевую ОС, а ядро хостовой ОС и имеет своё собственное файловое пространство, процессы и сеть.

После сборки образа формируется контейнер, которые являются изолированными средами выполнения для достижения цели переносимости, воспроизведения.

> **Контейнеризация** — это технология, позволяющая упаковать приложение вместе со всеми его зависимостями, библиотеками, настройками и средой выполнения в единый изолированный виртуальный контейнер. 

### Namespaces

Необходимы для организации изолированных рабочих пространств — контейнеров. Когда мы запускаем контейнер, `Docker` создает набор пространств имен для данного контейнера, что создает изолированный уровень в своем пространстве имен и не имеет доступа к внешней системе.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">pid</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Изоляция процессов — контейнер видит только свои процессы</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">net</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Управление сетевыми интерфейсами — собственный сетевой стек</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">ipc</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Изоляция IPC (InterProcess Communication) ресурсов</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">mnt</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Управление точками монтирования — собственная файловая система</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">uts</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Изоляция hostname и domain — контейнер имеет собственное имя хоста</span></div>
</div>

### Cgroups

Контрольные группы для изоляции ресурсов — предоставляют приложению только те ресурсы, которые указываем. Позволяют разделять ресурсы железа и устанавливать пределы, ограничения.

```bash
$ docker container run -d \
        -e NGINX_HOST xxx.xxx \
        -p 8080:80 \
        -v "$PWD/html" usr/share/nginx/html \
        --memory=50m \
        --cpus="2.5" \
        nginx
```

### Основные проблемы

- образ может содержать устаревшие или уязвимые версии библиотек CVE (Common Vulnerabilities and Exposures)
- поддельные и злонамеренные образы
- отсутствие подписей и проверки целостности
- ошибка конфигурации и избыток прав — образы с избыточными правами доступа, запуском от root или с небезопасными настройками
- присутствие секретов и конфиденциальных данных в образах
- отсутствие регулярного обновления из-за неподдерживаемых образов

### Контекст безопасности

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Не запускать от root</span><div class="lab-card-tags"><span class="lab-tag">USER</span><span class="lab-tag">Dockerfile</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Явно прописывать учётную запись с минимальными правами. Root внутри контейнера = root на хосте при побеге.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Без --privileged</span><div class="lab-card-tags"><span class="lab-tag">capabilities</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Отключает все средства изоляции, даёт доступ к ФС и устройствам хоста. Явно прописывать только нужные capabilities.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Профили безопасности</span><div class="lab-card-tags"><span class="lab-tag">AppArmor</span><span class="lab-tag">seccomp</span><span class="lab-tag">SELinux</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Не отключать профили Linux security. Ограничивают syscalls, сеть, обращения к ФС хоста.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Не использовать host network</span><div class="lab-card-tags"><span class="lab-tag">bridge</span><span class="lab-tag">none</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">В режиме host контейнер делит сеть с хостом, включая доступ к Docker API. Использовать bridge или none.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Не монтировать docker.sock</span><div class="lab-card-tags"><span class="lab-tag">docker.socket</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Доступ к сокету = полный контроль над Docker daemon. Не подключать без крайней необходимости.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Секреты вне образа</span><div class="lab-card-tags"><span class="lab-tag">secrets</span><span class="lab-tag">env</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Не хранить секреты в Dockerfile/ENV. Использовать Docker secrets или внешние менеджеры.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Лимиты ресурсов</span><div class="lab-card-tags"><span class="lab-tag">--memory</span><span class="lab-tag">--cpus</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Ограничивать CPU/RAM на уровне контейнера. Без лимитов один контейнер может забрать все ресурсы хоста.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Минимальные образы</span><div class="lab-card-tags"><span class="lab-tag">alpine</span><span class="lab-tag">slim</span><span class="lab-tag">distroless</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Официальные образы с минимальным набором инструментов. Сканировать на CVE (Trivy, Docker Scout).</span></div>
</div>

### Дополнительно

В случае, если возникает проблема с вызовом `docker buildx` для macos `silicon`, следует использовать вот [это](https://gist.github.com/Aeonitis/cbd9f8b61eaec5a8a024c0a42f415ca3) описание из gistup для фикса `samelink`.

***

## Задание

- [ ] 1. Поставьте `Docker` и `buildkit`

```bash
# Ubuntu / Debian
$ sudo apt update && sudo apt install -y docker.io docker-compose
$ sudo systemctl enable --now docker
$ sudo usermod -aG docker $USER && newgrp docker

# Fedora
$ sudo dnf install -y docker docker-compose
$ sudo systemctl enable --now docker
$ sudo usermod -aG docker $USER

# macOS
$ brew install docker buildkit

# Проверка
$ docker --version
$ docker run hello-world
```

- [ ] 2. Перейдите в `source` и выведите на терминале, далее проанализируйте следующие команды консоли

```bash
$ docker buildx build -t hello-appsec-world .
$ docker run hello-appsec-world
$ docker run --rm -it hello-appsec-world

$ docker save -o hello.tar hello-appsec-world
$ docker load -i hello.tar
$ docker load -i image.tar
```

- [ ] 3. Откройте `Dockerfile` и проведите аудит безопасности по чеклисту:

    - [ ] Какой базовый образ используется? Он официальный? Есть ли пиннинг версии (тег, не `latest`)?
    - [ ] Используется ли multi-stage build? Зачем?
    - [ ] Есть ли инструкция `USER`? От какого пользователя запускается приложение?
    - [ ] Используется `COPY . .` или копируются только нужные файлы?
    - [ ] Есть ли `.dockerignore`? Что он исключает?
    - [ ] Есть ли секреты или пароли в `ENV`, `ARG` или `COPY`?
    - [ ] Пиннингованы ли версии зависимостей в `requirements.txt`?

    Зафиксируйте результат аудита в отчёте. Сделайте `commit`.

- [ ] 4. Создайте файл `.dockerignore` в директории `source/` со следующим содержимым:

```text
.git
.gitignore
__pycache__
*.pyc
venv
.env
*.tar
*.md
```

Соберите образ **до** и **после** добавления `.dockerignore`, сравните размеры:

```bash
$ docker images | grep hello-appsec-world
```

Опишите в отчёте: какие файлы попадали в образ без `.dockerignore` и почему это опасно.

- [ ] 5. Замените в `Dockerfile` скрипт на свой `python`-файл из прошлых лабораторных работ. Вложите свой файл в директорию `source/`. Проанализируйте и доработайте `Dockerfile` под ваш скрипт. Сделайте `commit`.

> Пример анализа по текущему `Dockerfile` в репозитории

```dockerfile
# Этап 1: сборка зависимостей
FROM python:3.11-slim AS builder
WORKDIR /hello
# Копируем файл с зависимостями
COPY requirements.txt . 
# Устанавливаем зависимости в отдельную директорию wheelhouse для кеширования
RUN pip install --upgrade pip && pip wheel --wheel-dir=/wheels -r requirements.txt

# Этап 2: запускаемый образ
FROM python:3.11-slim
WORKDIR /hello
# Копируем файл с зависимостями
COPY --from=builder /wheels /wheels # Копируем собранные wheel-пакеты
COPY requirements.txt . 
# Устанавливаем зависимости из wheel-пакетов
RUN pip install --no-index --find-links=/wheels -r requirements.txt
# Копируем исходный код приложения
COPY hello.py .

# Переменные окружения для улучшенной работы Python
ENV PYTHONUNBUFFERED=1
# Запускаем приложение
CMD ["python", "hello.py"] 
```

- [ ] 6. Выведите на терминале и проанализируйте следующие команды консоли. Сравните хеш сумму вашего архива с `image.tar` из репозитория, выведите на терминал.

```bash
$ docker buildx build -t hello-appsec-world .
$ docker run hello-appsec-world
$ docker save -o hello_your_project.tar hello-appsec-world

$ docker load -i hello_your_project.tar
$ docker run hello-appsec-world

$ docker load -i image.tar
$ docker run hello-appsec-world
```

- [ ] 7. Доработайте свой `python` скрипт подключаемыми библиотеками, далее их необходимо разместить в `requirements.txt`. Размещение библиотек в следующем формате:

```text
flask==2.2.3
requests==2.28.1
```

- [ ] 8. Сделайте `commit`. Повторите сборку приложения по вашему `Dockerfile` для доработанного скрипта `python`. Сохраните `image` в виде .`tar` архива. Сделайте `commit`.
- [ ] 9. Проанализируйте слои и размер образа. Сравните single-stage и multi-stage build:

```bash
# Посмотреть слои образа
$ docker history hello-appsec-world

# Размер образа
$ docker images hello-appsec-world
```

Опишите в отчёте: сколько слоёв, какой размер, какие слои самые тяжёлые. Если Dockerfile не использует multi-stage — переделайте на multi-stage и сравните размер до/после.

- [ ] 10. Проверьте, от какого пользователя работает контейнер:

```bash
$ docker run --rm hello-appsec-world whoami
$ docker run --rm hello-appsec-world id
```

Если выводит `root` — добавьте в Dockerfile инструкцию `USER` с непривилегированным пользователем. Пересоберите и проверьте повторно. Сделайте `commit`.

- [ ] 11. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ docker login
$ docker tag hello-appsec-world yourusername/hello-appsec-world
$ docker push yourusername/hello-appsec-world
$ docker inspect yourusername/hello-appsec-world
$ docker container create --name first hello-appsec-world # выпишите id контейнера

$ docker image pull geminishkv/hello-appsec-world
$ docker inspect geminishkvdev/hello-appsec-world
$ docker container create --name second hello-appsec-world

```

- [ ] 12. Запустите контейнер Ubuntu и изучите изоляцию изнутри (связь с namespaces из материала):

```bash
$ docker container run -it --rm ubuntu /bin/bash

# Внутри контейнера:
$ whoami                    # от какого пользователя?
$ id                        # uid, gid
$ ps aux                    # какие процессы видны? (только свои — pid namespace)
$ cat /etc/os-release       # какая ОС внутри?
$ hostname                  # имя хоста (uts namespace)
$ ls /proc/1/ns/            # namespace-файлы процесса PID 1
$ exit
```

Опишите в отчёте: что показывает каждая команда и как это связано с namespaces (pid, uts, mnt).

- [ ] 13. Проверьте ресурсные лимиты контейнера — запустите с ограничением памяти:

```bash
# Запустить с лимитом 64 MB RAM
$ docker run -d --name stress-test --memory=64m --cpus=0.5 ubuntu sleep 300

# Проверить лимиты
$ docker stats stress-test --no-stream

# Почистить
$ docker rm -f stress-test
```

Опишите в отчёте: что произойдёт, если приложение попробует выделить больше памяти, чем лимит? Зачем ограничивать ресурсы?

- [ ] 14. Выведите оба контейнера first и second на терминал
- [ ] 15. Создайте Docker-сеть и проверьте связность между контейнерами:

```bash
$ docker network create lab05-net
$ docker network ls

# Запустите два контейнера в одной сети
$ docker run -d --name net-a --network lab05-net nginx
$ docker run -it --rm --network lab05-net ubuntu bash -c "apt update && apt install -y iputils-ping && ping -c 3 net-a"

# Почистить
$ docker rm -f net-a
$ docker network rm lab05-net
```

Опишите в отчёте: как контейнеры находят друг друга по имени? Какой DNS использует Docker?

- [ ] 16. Перейдите в основной корень `lab05` и запустите docker compose:

```bash
$ docker compose up --build
```

- [ ] 17. Откройте соседнее окно терминала и проверьте работу приложения

```bash
$ curl -i http://localhost:8000
# или откройте в браузере: http://localhost:8000
```

- [ ] 18. Остановите docker compose и почистите ресурсы

```bash
$ docker ps -a
$ docker ps -q
$ docker images

$ docker ps -q | xargs docker stop
$ docker compose down
```

- [ ] 19. Доработайте `docker-compose.yml` и скрипт из предыдущих шагов, чтобы воспроизвести шаги п.15–п.17 с демонстрацией. Сделайте `commit`.
- [ ] 20. Залейте изменения в свой удалённый репозиторий, проверьте историю `commit`.
- [ ] 21. Подготовьте отчет `gist`.
 
***

## Смотри также

- [Основы Docker](https://course.geminishkv.tech/labs/intro/docker_basics/) — введение в контейнеризацию перед этой лабой
- [Лаб. №6 — CIS Benchmark](https://course.geminishkv.tech/labs/basic/lab06/) — аудит безопасности Docker
- [CheatSheet: Docker](https://course.geminishkv.tech/materials/cheatsheet/CHEATSHEET_DOCKER/) — шпаргалка по командам
- [CheatSheet: Dockerfile Security](https://course.geminishkv.tech/materials/cheatsheet/CHEATSHEET_DOCKERFILE_SECURITY/) — безопасная сборка образов
- [CheatSheet: .dockerignore](https://course.geminishkv.tech/materials/cheatsheet/CHEATSHEET_DOCKERIGNORE/) — исключения при сборке

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/troubleshooting/).

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://docs.docker.com/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.docker.com/engine/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker Engine overview</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.docker.com/reference/dockerfile/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Dockerfile reference</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.docker.com/compose/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker Compose documentation</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://hub.docker.com/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker Hub</div><div class="lab-card-tags"><span class="lab-tag">hub.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.docker.com/engine/security/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker security overview</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gist.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Gist</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
