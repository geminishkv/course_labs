---
hide:
  - toc
title: "CheatSheet: Docker команды | Курс AppSec"
description: "Docker шпаргалка: команды для образов, контейнеров, сетей, томов и Docker Compose — справочник для DevOps и AppSec курса."
keywords: "Docker, cheatsheet, шпаргалка, контейнер, образ, Docker Compose, DevOps, AppSec, тома, сети, Dockerfile, volumes"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Docker</h1>
    <p class="hero-sub">Команды, флаги и примеры использования</p>
  </div>
</div>

***

## Образы

```bash
docker images                                 # Список всех образов
docker image ls                               # Список образов (алиас)
docker pull <image>:<tag>                     # Скачать образ
docker build -t <name>:<tag> .                # Собрать образ из Dockerfile
docker build --no-cache -t <name>:<tag> .     # Собрать без кэша
docker rmi <image>                            # Удалить образ
docker image prune                            # Удалить неиспользуемые образы
docker image prune -a                         # Удалить все неиспользуемые образы
docker tag <image> <new-name>:<tag>           # Переименовать/пометить образ
docker push <image>:<tag>                     # Отправить образ в registry
docker save -o <file>.tar <image>             # Экспортировать образ в файл
docker load -i <file>.tar                     # Импортировать образ из файла
docker history <image>                        # История слоёв образа
docker inspect <image>                        # Подробная информация об образе
```

## Контейнеры

```bash
docker ps                                     # Список запущенных контейнеров
docker ps -a                                  # Все контейнеры (включая остановленные)
docker run <image>                            # Запустить контейнер
docker run -d <image>                         # Запустить в фоновом режиме
docker run -it <image> bash                   # Интерактивный запуск с shell
docker run --name <name> <image>              # Запустить с именем
docker run -p 8080:80 <image>                 # Проброс порта host:container
docker run -v /host/path:/container/path <image>  # Монтирование тома
docker run --rm <image>                       # Удалить контейнер после остановки
docker run --env-file .env <image>            # Передать переменные из файла
docker start <container>                      # Запустить остановленный контейнер
docker stop <container>                       # Остановить контейнер (SIGTERM)
docker kill <container>                       # Принудительно остановить (SIGKILL)
docker restart <container>                    # Перезапустить контейнер
docker rm <container>                         # Удалить контейнер
docker rm -f <container>                      # Принудительно удалить (включая запущенный)
docker container prune                        # Удалить все остановленные контейнеры
```

## Выполнение команд и логи

```bash
docker exec -it <container> bash              # Открыть shell в запущенном контейнере
docker exec -it <container> sh                # Открыть sh (для Alpine-образов)
docker exec <container> <command>             # Выполнить команду в контейнере
docker logs <container>                       # Показать логи контейнера
docker logs -f <container>                    # Следить за логами в реальном времени
docker logs --tail 100 <container>            # Последние 100 строк логов
docker inspect <container>                    # Подробная информация о контейнере
docker stats                                  # Мониторинг ресурсов контейнеров
docker top <container>                        # Процессы внутри контейнера
docker cp <container>:/path /host/path        # Скопировать файл из контейнера
docker cp /host/path <container>:/path        # Скопировать файл в контейнер
```

## Docker Compose

```bash
docker compose build                          # Собрать образы
docker compose build --no-cache               # Собрать без кэша
docker compose build <service>                # Собрать отдельный сервис

docker compose up                             # Запустить все сервисы
docker compose up -d                          # Запустить в фоне
docker compose up --build                     # Пересобрать и запустить
docker compose up --force-recreate            # Пересоздать контейнеры
docker compose up --build --force-recreate    # Полный пересбор и пересоздание

docker compose stop                           # Остановить сервисы (без удаления)
docker compose down                           # Остановить и удалить контейнеры и сети
docker compose down --volumes                 # Также удалить тома
docker compose down --rmi all                 # Также удалить образы
docker compose rm                             # Удалить остановленные контейнеры

docker compose ps                             # Состояние сервисов
docker compose logs                           # Логи всех сервисов
docker compose logs -f                        # Следить за логами
docker compose logs -f <service>              # Логи конкретного сервиса
docker compose exec <service> sh              # Shell внутри сервиса
docker compose config                         # Проверить конфигурацию compose-файла
docker compose restart <service>              # Перезапустить сервис
```

## Сети и тома

```bash
docker network ls                             # Список сетей
docker network create <name>                  # Создать сеть
docker network inspect <name>                 # Информация о сети
docker network rm <name>                      # Удалить сеть
docker network prune                          # Удалить неиспользуемые сети

docker volume ls                              # Список томов
docker volume create <name>                   # Создать том
docker volume inspect <name>                  # Информация о томе
docker volume rm <name>                       # Удалить том
docker volume prune                           # Удалить неиспользуемые тома
```

## Очистка

```bash
docker system prune                           # Удалить неиспользуемые ресурсы
docker system prune -a                        # Удалить всё неиспользуемое (включая образы)
docker system prune -a --volumes              # Также удалить тома
docker system df                              # Показать использование дискового пространства
```

***
