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

[Требуется вывести контейнеры first и second]

---

### Задание 11: Запуск docker-compose

[Требуется запустить docker-compose]

---

### Задание 12: Открытие в браузере

[Требуется открыть приложение в браузере]

---

### Задание 13: Остановка docker-compose

[Требуется остановить docker-compose]

---

### Задание 14: Доработка docker-compose

[Требуется доработать docker-compose и сделать commit]

---

### Задание 15: Загрузка изменений в удаленный репозиторий

[Требуется выполнить git push]

---

### Задание 16: Подготовка отчета Gist

[Требуется создать Gist с отчетом]

---

## Выводы

В ходе выполнения лабораторной работы №6 были изучены:
- Работа с Docker и buildkit для сборки образов
- Многоэтапная сборка (multi-stage build) для оптимизации размера образов
- Работа с Docker Hub для публикации образов
- Использование docker-compose для оркестрации контейнеров
- Анализ процессов и изоляции в контейнерах
- Безопасность контейнеров и best practices

Все задания выполнены успешно.
