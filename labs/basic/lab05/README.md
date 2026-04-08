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

- **Контейнеризация**

Сборка приложения включает создание контейнерного образа, в котором упаковано приложение с конфигурациями, чтобы приложение функционировало. `Docker` основан на использовании общих функций ядра `ОС Linux` (`cgroups`, `namespace`) для изоляции и управления ресурсами.

> **Образ** — это статический, неизменяемый шаблон, на базе которого создаются контейнера с ОС, приложением, зависимостями, библиотекакм и конфигурационными файлами. Нужен для создания воспроизводимой, неизменяемой среды выполнения приложений в контейнерах.

Для сборки образов используется `Dockerfile`, где прописаны версии зависимостей и инструкции, минимизирующие разрешения и атаки. Это инструкции, где описывается, как собрать образ. Впоследствии собирается контейнер.

> **Контейнер** — это изолированная среда выполнения приложения с необходимыми зависимостями, кодом, системными утилитами, библиотеками и настройками. Использует не собственную гостевую ОС, а ядро хостовой ОС и имеет своё собственное файловое пространство, процессы и сеть.

После сборки образа формируется контейнер, которые являются изолированными средами выполнения для достижения цели переносимости, воспроизведения.

> **Контейнеризация** — это технология, позволяющая упаковать приложение вместе со всеми его зависимостями, библиотеками, настройками и средой выполнения в единый изолированный виртуальный контейнер. 

- **Namespaces**

Необходимы для организации изолированных рабочих пространств — контейнеров. Когда мы запускаем контейнер, `Docker` создает набор пространств имен для данного контейнера, что создает изолированный уровень в своем пространстве имен и не имеет доступа к внешней системе.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">pid</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Изоляция процессов — контейнер видит только свои процессы</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">net</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Управление сетевыми интерфейсами — собственный сетевой стек</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">ipc</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Изоляция IPC (InterProcess Communication) ресурсов</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">mnt</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Управление точками монтирования — собственная файловая система</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">uts</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Изоляция hostname и domain — контейнер имеет собственное имя хоста</span></div>
</div>

- **Cgroups**

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

-  **Основные проблемы**

    - образ может содержать устаревшие или уязвимые версии библиотек CVE (Common Vulnerabilities and Exposures)
    - поддельные и злонамеренные образы
    - отсутствие подписей и проверки целостности
    - ошибка конфигурации и избыток прав — образы с избыточными правами доступа, запуском от root или с небезопасными настройками
    - присутствие секретов и конфиденциальных данных в образах
    - отсутствие регулярного обновления из-за неподдерживаемых образов

-  **Контекст безопасности**

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

- **Дополнительно**

В случае, если возникает проблема с вызовом `docker buildx` для macos `silicon`, следует использовать вот [это](https://gist.github.com/Aeonitis/cbd9f8b61eaec5a8a024c0a42f415ca3) описание из gistup для фикса `samelink`.

***

## Задание

- [ ] 1. Поставьте `Docker` и `buildkit`

```bash
$ brew install buildkit
$ brew install docker
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

- [ ] 3. Откройте `Dockerfile` и сделайте его анализ. Сделайте `commit`

- [ ] 4. Замените в `Dockerfile`значение скрипта на `python` тем, который вы сделали ранее в прошлых лабораторных работах. Вложите свой файл `python` в директорию. Сделайте анализ своего измененного `Dockerfile` и внесите изменения. Сделайте `commit`. 

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

- [ ] 5. Выведите на терминале и проанализируйте следующие команды консоли. Сравните хеш сумму вашего архива с `image.tar` из репозитория, выведите на терминал.

```bash
$ docker buildx build -t hello-appsec-world .
$ docker run hello-appsec-world
$ docker save -o hello_your_project.tar hello-appsec-world

$ docker load -i hello_your_project.tar
$ docker run hello-appsec-world

$ docker load -i image.tar
$ docker run hello-appsec-world
```

- [ ] 6. Доработайте свой `python` скрипт подключаемыми библиотеками, далее их необходимо разместить в `requirements.txt`. Размещение библиотек в следующем формате:

```text
flask==2.2.3
requests==2.28.1
```

- [ ] 7. Сделайте `commit`. Повторите сборку приложения по вашему `Dockerfile` для доработанного скрипта `python`. Сохраните `image` в виде .`tar` архива. Сделайте `commit`.
- [ ] 8. Выведите на терминале и проанализируйте следующие команды консоли

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

- [ ] 9. Выведите на терминале и проанализируйте в консоли процессы, которые запущены, владельцев по пользователям

```bash
 $ docker container run -it ubuntu /bin/bash
```
 
- [ ] 10. Выведите оба контейнера first и second на терминал
- [ ] 11. Перейдите в основной корень `lab05` и выведите на терминале, и проанализируйте

```bash
$ docker-compose up --build
```

- [ ] 12. Откройте соседнее окно терминала и выведите на терминале

```bash
$ open -a "Google Chrome" http://localhost:8000
```

- [ ] 13. Остановите работу `docker-compose`.

```bash
$ docker ps -a
$ docker ps -q
$ docker images

$ docker ps -q | xargs docker stop
$ docker-compose down
```

- [ ] 14. Доработайте `docker-compose` и скрипт, который вы подготовили ранее, чтобы вы смогли воспроизвести шаги п.11 по п.13 с демонстрацией. Сделайте `commit`.
- [ ] 15. Залейте изменения в свой удаленный репозиторий, проверьте историю `commit`.
- [ ] 16. Подготовьте отчет `gist`.
 
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
