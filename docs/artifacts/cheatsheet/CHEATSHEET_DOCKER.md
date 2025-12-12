---
hide:
  - toc
---

<div align="center">
<h1><a id="intro">CheatSheet</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a> 
<a href="https://symbl.cc/en/unicode-table"><img src="https://img.shields.io/static/v1?logo=unicode&logoColor=fff&label=&message=Unicode&color=36393f&style=flat" alt="Unicode"></a> 
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<a href="https://img.shields.io/badge/Risk_Analyze-2448a2"><img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/AppSec-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge"></a></div>

***

- Docker

```bash
$ docker image ls all # все образы
$ docker container ls # все запущенные контейнеры
$ docker container ls -all # все контейнеры
$ docker run -d --privileged --name docker go:1.16 # привилегированный режим

$ docker compose build	 
$ docker compose build --no-cache # Создает образы без использования кэша
$ docker compose build <service> # Создает только определенную службу

$ docker compose up	
$ docker compose up -d	 # Запускает контейнеры в отсоединенном режиме в фоновом режиме
$ docker compose start	 # Запускает уже созданные контейнеры (не перестраивает и не создает заново)
$ docker compose up --build	# Создает изображения, а затем запускает контейнеры
$ docker compose up --force-recreate # Воссоздает контейнеры, даже если ничего не изменилось
$ docker compose up --build --force-recreate # Полностью перестраивает и воссоздает контейнеры

$ docker compose stop	
$ docker compose down	# Останавливает и удаляет контейнеры, сети и тома по умолчанию
$ docker compose down --volumes	 # Удаляет контейнеры, сети и именованные/анонимные тома
$ docker compose down --rmi all	 # Также удаляет все построенные изображения
$ docker compose rm	 # Удаляет остановленные контейнеры служб (после остановки)
$ docker compose kill # Принудительно останавливает запуск контейнеров

$ docker compose ps	# Списки запущенных служб и их состояние
$ docker compose logs # Отображение журналов для всех служб
$ docker compose logs -f	
$ docker compose exec <service> sh # Открывает оболочку внутри работающего контейнера
$ docker compose config

docker exec -it <container_name_or_id> <command> # выполнение команды
            -i  # интерактивный режим (позволяет передать ввод)
            -t  # выделяет псевдотерминал (tty) для взаимодействия.
            <container_name_or_id>  # имя или ID контейнера.
```

![Logo](../assets/logotypemd.jpg)