<div align="center">
<h1><a id="intro">Лабораторная работа №5</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a> 
<a href="https://symbl.cc/en/unicode-table"><img src="https://img.shields.io/static/v1?logo=unicode&logoColor=fff&label=&message=Unicode&color=36393f&style=flat" alt="Unicode"></a> 
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<a href="https://img.shields.io/badge/Risk_Analyze-2448a2"><img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/AppSec-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/Contributor-Балашов.Д.В.-8b9aff" alt="Contributor Badge"></a></div>

***

Данная лабораторная работа посвещена изучению Docker и как с ним работать. Эта лабораторная работа послужит подпоркой для старта в выявлении и определении уязвимостей на уровне сканирования контейнеров при сборке приложений. 

***

## Задание

- [ ] 1. Поставьте `Docker` и `buildkit`

```bash
$ brew install buildkit
$ brew install docker
```

- [ ] 2. Перейдите в `source` и выведите на терминале, далее проанализируйте следующие команды консоли

```bash
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─#  docker buildx build -t hellow-appsec-world .
[+] Building 29.7s (13/13) FINISHED                                    docker:default
 => [internal] load build definition from Dockerfile                             0.1s
 => => transferring dockerfile: 443B                                             0.0s 
 => [internal] load metadata for docker.io/library/python:3.11-slim              7.0s 
 => [internal] load .dockerignore                                                0.0s
 => => transferring context: 2B                                                  0.0s 
 => [internal] load build context                                                0.1s 
 => => transferring context: 494B          
 
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker run hellow-appsec-world
hello appsec world

┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker run --rm -it hellow-appsec-world
hello appsec world

$ docker save -o hello.tar hello-appsec-world
$ docker load -i hello.tar
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker load -i image.tar
f1b30ab99183: Loading layer  30.14MB/30.14MB
c24001014542: Loading layer  1.274MB/1.274MB
7a4b2171e46d: Loading layer  14.31MB/14.31MB
591779db3273: Loading layer     250B/250B
efd49302dd30: Loading layer      95B/95B
8fe7432c3de3: Loading layer      96B/96B
e687a26fd0a6: Loading layer     141B/141B
71299f61dc2b: Loading layer  4.065MB/4.065MB
5b8b2e16a223: Loading layer     344B/344B
Loaded image: hello-appsec-world:latest

```
- [ ] 3. Откройте `Dockerfile` и сделайте его анализ. Сделайте `commit`
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

┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# git add Dockerfile
warning: in the working copy of 'labs/lab05/source/Dockerfile', CRLF will be replaced by LF the next time Git touches it
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# git commit -m "lab5: analyse original Dockerfile"
[develop 7db8bfa] lab5: analyse original Dockerfile
 1 file changed, 14 insertions(+), 5 deletions(-)
```

- [ ] 4. Замените в `Dockerfile`значение скрипта на `python` тем, который вы сделали ранее в прошлых лабораторных работах. Вложите свой файл `python` в директорию. Сделайте анализ своего измененного `Dockerfile` и внесите изменения. Сделайте `commit`. 

```py
import base64
import typer


def main(
    name: str = typer.Argument(...),
    lastname: str = typer.Option("", "--lastname", "-l"),
) -> None:
    greeting = base64.b64decode(b"SGVsbG8gYXBwc2Vjd29ybGQ=").decode()
    tail = f"@{name}" + (f" {lastname}" if lastname else "")
    typer.echo(f"{greeting} from {tail}")


if __name__ == "__main__":
    typer.run(main)
# test comment
```
```
└─# git add hello.py                                 
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# git commit -m "lab5: use custom hello.py & multi-stage build"
[develop 06eaa22] lab5: use custom hello.py & multi-stage build
 1 file changed, 11 insertions(+), 12 deletions(-)

```

- [ ] 5. Выведите на терминале и проанализируйте следующие команды консоли. Сравните хеш сумму вашего архива с `image.tar` из репозитория, выведите на терминал.

```bash
──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker buildx build -t hellow-appsec-world .
[+] Building 21.2s (13/13) FINISHED                                    docker:default
 => [internal] load build definition from Dockerfile                             0.0s
 => => transferring dockerfile: 599B                                             0.0s 
 => [internal] load metadata for docker.io/library/python:3.11-slim              0.6s 
 => [internal] load .dockerignore                                                0.0s
 => => transferring context: 2B                                                  0.0s 
 => [internal] load build context                                                0.0s 
 => => transferring context: 89B                                                 0.0s 
 => [builder 1/4] FROM docker.io/library/python:3.11-slim@sha256:158caf0e080e2c  0.0s 
 => CACHED [builder 2/4] WORKDIR /hello                                          0.0s 
 => [builder 3/4] COPY requirements.txt .                                        0.1s 
 => [builder 4/4] RUN pip install --upgrade pip && pip wheel --wheel-dir=/whee  11.9s 
 => [stage-1 3/6] COPY --from=builder /wheels /wheels                            0.1s 
 => [stage-1 4/6] COPY requirements.txt .                                        0.2s 
 => [stage-1 5/6] RUN pip install --no-index --find-links=/wheels -r requiremen  6.8s 
 => [stage-1 6/6] COPY hello.py .                                                0.2s 
 => exporting to image                                                           0.6s 
 => => exporting layers                                                          0.5s 
 => => writing image sha256:afb8b0b473de9b1f67b6a85142dc96e9a074d880894da14da61  0.0s 
 => => naming to docker.io/library/hellow-appsec-world                           0.0s 
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker run hellow-appsec-world
Hello appsecworld from @None
                                    
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker save -o hello_your_project.tar hellow-appsec-world

┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker load -i hello_your_project.tar 
Loaded image: hellow-appsec-world:latest
                                                                                                                                                                                
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker run hellow-appsec-world       
Hello appsecworld from @None

#Тут образ собран под арм, поэтому будет ошибка
$ docker load -i image.tar
$ docker run hello-appsec-world
```

- [ ] 6. Доработайте свой `python` скрипт подключаемыми библиотеками, далее их необходимо разместить в `requirements.txt`. Размещение библиотек в следующем формате:

```
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# cat > requirements.txt <<'EOF'
flask==2.2.3
requests==2.28.1
typer==0.12.5
EOF
```

```py
import base64
from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def index():
    name   = request.args.get("name",   default="user", type=str)
    lastname = request.args.get("lastname", default="",   type=str)
    greeting = base64.b64decode(b"SGVsbG8gYXBwc2Vjd29ybGQ=").decode()
    tail     = f"@{name}" + (f" {lastname}" if lastname else "")
    return f"{greeting} from {tail}\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF
```

- [ ] 7. Сделайте `commit`. Повторите сборку приложения по вашему `Dockerfile` для доработанного скрипта `python`. Сохраните `image` в виде .`tar` архива. Сделайте `commit`.

```
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# git add requirements.txt hello.py
warning: in the working copy of 'labs/lab05/source/hello.py', LF will be replaced by CRLF the next time Git touches it
warning: in the working copy of 'labs/lab05/source/requirements.txt', LF will be replaced by CRLF the next time Git touches it
                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# git commit -m "lab5: add requirements.txt & Flask-wrapper for typer script"
[develop 2c56fb0] lab5: add requirements.txt & Flask-wrapper for typer script
 2 files changed, 11 insertions(+), 10 deletions(-)
 
 ┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker buildx build -t hellow-appsec-world .
[+] Building 13.6s (13/13) FINISHED                                    docker:default
 => [internal] load build definition from Dockerfile                             0.0s
 => => transferring dockerfile: 599B                                             0.0s 
 => [internal] load metadata for docker.io/library/python:3.11-slim              1.0s 
 => [internal] load .dockerignore                                                0.0s
 => => transferring context: 2B                                                  0.0s 
 => [internal] load build context                                                0.0s 
 => => transferring context: 135B                                                0.0s 
 => [builder 1/4] FROM docker.io/library/python:3.11-slim@sha256:158caf0e080e2c  0.0s 
 => CACHED [builder 2/4] WORKDIR /hello                                          0.0s 
 => [builder 3/4] COPY requirements.txt .                                        0.1s 
 => [builder 4/4] RUN pip install --upgrade pip && pip wheel --wheel-dir=/wheel  8.3s 
 => [stage-1 3/6] COPY --from=builder /wheels /wheels                            0.1s 
 => [stage-1 4/6] COPY requirements.txt .                                        0.1s 
 => [stage-1 5/6] RUN pip install --no-index --find-links=/wheels -r requiremen  3.4s 
 => [stage-1 6/6] COPY hello.py .                                                0.1s 
 => exporting to image                                                           0.3s 
 => => exporting layers                                                          0.2s 
 => => writing image sha256:ca80b1f0b31fe785917e970636d18d9853e08490b80a801115a  0.0s 
 => => naming to docker.io/library/hellow-appsec-world                           0.0s 
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker run -p 8000:5000 hellow-appsec-world
 * Serving Flask app 'hello'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.                                                      
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://172.17.0.2:5000
Press CTRL+C to quit
172.17.0.1 - - [15/Dec/2025 13:46:32] "GET / HTTP/1.1" 200 -
172.17.0.1 - - [15/Dec/2025 13:46:32] "GET /favicon.ico HTTP/1.1" 404 -
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker save -o hello_with_deps.tar hellow-appsec-world
                                                                                      
 ┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# git add hello_with_deps.tar 
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# git commit -m "add tar image"            
[develop 9d565f1] add tar image
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 labs/lab05/source/hello_with_deps.tar
 
```

- [ ] 8. Выведите на терминале и проанализируйте следующие команды консоли

```bash
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker login
Authenticating with existing credentials... [Username: kenifor]

i Info → To login with a different account, run 'docker logout' followed by 'docker login'


Login Succeeded
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker tag hellow-appsec-world kenifor/hellow-appsec-world
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker push kenifor/hellow-appsec-world

Using default tag: latest
The push refers to repository [docker.io/kenifor/hellow-appsec-world]
a4816f2a838f: Pushed 
f1ea60eea430: Pushed 
4ed96d1d8ac5: Pushed 
bf2d6dfacd93: Pushed 
49ae95fb9faa: Pushed 
fa384bf02ac1: Mounted from library/python 
600af8de593b: Mounted from library/python 
424dc4972605: Mounted from library/python 
77a2b55fbe8b: Mounted from library/python 
latest: digest: sha256:5db56befdb1f992e2a4e2b3bbfbf5d747dfc597186fcdbc95d97f623f70166ba size: 2202
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker inspect kenifor/hellow-appsec-world
[
    {
        "Id": "sha256:ca80b1f0b31fe785917e970636d18d9853e08490b80a801115a4fffe0ae721aa",
        "RepoTags": [
            "kenifor/hellow-appsec-world:latest",
            "hellow-appsec-world:latest"
        ],
        "RepoDigests": [
            "kenifor/hellow-appsec-world@sha256:5db56befdb1f992e2a4e2b3bbfbf5d747dfc597186fcdbc95d97f623f70166ba"
        ],
        "Parent": "",
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2025-12-15T16:45:13.320872182+03:00",
        "DockerVersion": "",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",

┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker container create --name first hellow-appsec-world
93333b24899452e63394b2a9c55752f4503cb88961321019a39f07cdab2b5774

┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker image pull geminishkvdev/hello-appsec-world
Using default tag: latest
latest: Pulling from geminishkvdev/hello-appsec-world
no matching manifest for linux/amd64 in the manifest list entries
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker inspect geminishkvdev/hello-appsec-world
[]
Error: No such object: geminishkvdev/hello-appsec-world

$ ┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker container create --name second hello-appsec-world
WARNING: The requested image's platform (linux/arm64) does not match the detected host platform (linux/amd64/v3) and no specific platform was requested
a24cc6e9098bfeba5844fe8d92b324975cb3843ebd68cee1327687672f359f0e

``` 

- [ ] 9. Выведите на терминале и проанализируйте в консоли процессы, которые запущены, владельцев по пользователям

```bash 
                                                                              
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker container run -it ubuntu /bin/bash
root@d5c7aa552a5a:/# ps aux # запущен единственный полезный процесс – оболочка bash
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.7  0.0   4588  3780 pts/0    Ss   15:42   0:00 /bin/bash
root           9  0.0  0.0   7888  3844 pts/0    R+   15:42   0:00 ps aux

``` 
 
- [ ] 10. Выведите оба контейнера first и second на терминал
```
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# docker ps -a | grep -E "first|second"
a24cc6e9098b   hello-appsec-world                       "python hello.py"        9 minutes ago    Created                                                                                                                                                             second
93333b248994   hellow-appsec-world                      "python hello.py"        2 hours ago      Created                                                                                                                                                             first
```
- [ ] 11. Перейдите в основной корень `lab05` и выведите на терминале, и проанализируйте

```bash 
[+] Running 5/5
 ✔ client                    Built                                               0.0s 
 ✔ server                    Built                                               0.0s 
 ✔ Network lab05_app_net     Created                                             0.1s 
 ✔ Container lab05-server-1  Created                                             0.2s 
 ✔ Container lab05-client-1  Created                                             0.1s 
Attaching to client-1, server-1
server-1  |  * Serving Flask app 'app'
server-1  |  * Debug mode: off
server-1  | WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
server-1  |  * Running on all addresses (0.0.0.0)
server-1  |  * Running on http://127.0.0.1:8000
server-1  |  * Running on http://172.23.0.2:8000
server-1  | Press CTRL+C to quit
server-1  | 172.23.0.3 - - [15/Dec/2025 15:58:00] "GET / HTTP/1.1" 200 -
client-1  | 
client-1  |     <html>                                                                
client-1  |     <head><title>Colorful Output</title></head>                           
client-1  |     <body style="font-family: monospace; font-size: 24px;">               
server-1  | 172.23.0.1 - - [15/Dec/2025 15:59:05] "GET / HTTP/1.1" 200 -              
server-1  | 172.23.0.1 - - [15/Dec/2025 15:59:05] "GET /favicon.ico HTTP/1.1" 404 -

``` 

- [ ] 12. Откройте соседнее окно терминала и и выведите на терминале

```bash 
open -a "Google Chrome" http://localhost:8000

──(root㉿kali)-[/home/kali/Desktop]
└─# curl -I http://localhost:8000
HTTP/1.1 200 OK
Server: Werkzeug/2.3.7 Python/3.11.14
Date: Mon, 15 Dec 2025 16:02:05 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 761
Connection: close

```

- [ ] 13. Остановите работу `docker-compose`.

```bash 
┌──(root㉿kali)-[/home/kali/course_labs/labs/lab05]
└─# docker ps -a                         
CONTAINER ID   IMAGE                                    COMMAND                  CREATED          STATUS                       PORTS                                                                                                                                   NAMES
73cd1e02bc79   lab05-client                             "python client.py"       5 minutes ago    Exited (0) 3 minutes ago                                                                                                                                             lab05-client-1
32739d04cd4a   lab05-server                             "python app.py"          5 minutes ago    Exited (137) 5 seconds ago                                                                                                                                           lab05-server-1
d5c7aa552a5a   ubuntu                                   "/bin/bash"              21 minutes ago   Exited (0) 18 minutes ago                                                                                                                                            mystifying_neumann
1d29e237c1c5   ubuntu                                   "/bin/bash"              22 minutes ago   Exited (0) 22 minutes ago                                                                                                                                            vibrant_merkle
a24cc6e9098b   hello-appsec-world                       "python hello.py"        25 minutes ago   Created

┌──(root㉿kali)-[/home/kali/course_labs/labs/lab05]
└─# docker ps -q
790799fd567b
cb4d96c7182c
3e333f944f41
c2669a828bfe
7aae8b65fb09
c03d612ae72f
c772c4f1d827

$ ┌──(root㉿kali)-[/home/kali/course_labs/labs/lab05]
└─# docker images
REPOSITORY                      TAG        IMAGE ID       CREATED          SIZE
lab05-client                    latest     3aebaeefa7ed   11 minutes ago   138MB
lab05-server                    latest     19a1ad03b3cd   11 minutes ago   141MB
kenifor/hellow-appsec-world     latest     ca80b1f0b31f   2 hours ago      157MB
hellow-appsec-world             latest     ca80b1f0b31f   2 hours ago      157MB
<none>                          <none>     88f9a95897d0   2 hours ago      157MB

┌──(root㉿kali)-[/home/kali/course_labs/labs/lab05]
└─# docker ps -q | xargs docker stop
790799fd567b
cb4d96c7182c
3e333f944f41
c2669a828bfe
7aae8b65fb09
c03d612ae72f
c772c4f1d827

$ ┌──(root㉿kali)-[/home/kali/course_labs/labs/lab05]
└─# docker compose down             
WARN[0000] /home/kali/course_labs/labs/lab05/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
[+] Running 3/3
 ✔ Container lab05-client-1  Removed                                                                                                                                       0.0s 
 ✔ Container lab05-server-1  Removed                                                                                                                                       0.0s 
 ✔ Network lab05_app_net     Removed   
 
```
- [ ] 14. Доработайте `docker-compose` и скрипт, который вы подготовили ранее, что бы вы смогли воспроизвести шаги п.11 по п.13 с демонстрацией. Сделайте `commit`.

```
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# cat Dockerfile             
FROM python:3.11-slim
WORKDIR /hello
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY hello.py .
ENV PYTHONUNBUFFERED=1
CMD ["python", "hello.py"]
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# cat docker-compose.yml 
version: "3.9"
services:
  web:
    build: .
    ports:
      - "8000:5000"
    environment:
      - FLASK_RUN_HOST=0.0.0.0
                                                                                      
┌──(root㉿kali)-[/home/…/course_labs/labs/lab05/source]
└─# cat requirements.txt  
flask==2.2.3
werkzeug==2.3.6
requests==2.28.1
typer==0.12.5

```

- [ ] 15. Залейте изменения в свой удаленный репозиторий, проверьте историю `commit`.
```
┌──(root㉿kali)-[/home/kali/course_labs/labs/lab05]
└─# git log --oneline -5
a73dbbc (HEAD -> lab_05, origin/lab_05) lab5: docker-compose for Flask app (clean, no tar)

```
- [ ] 16. Подготовьте отчет `gist`.
 
***

Copyright (c) 2025 Balashov Denis aka kenifor
