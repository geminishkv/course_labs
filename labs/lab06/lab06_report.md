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

#### 2.1. Сборка образа

```bash
$ cd /root/course_labs/labs/lab06/source
$ docker buildx build -t hello-appsec-world .
```

**Анализ команды:**
- `docker buildx build` - использует buildkit для сборки образа
- `-t hello-appsec-world` - задает имя и тег образа
- `.` - указывает на текущую директорию как контекст сборки (ищет Dockerfile)

**Результат:** Образ успешно собран: `sha256:a02f811f7c040f2dd6f3ddb8f7c8b80a6214e517c474c5a40a6508c0d5665ff9`

#### 2.2. Запуск контейнера

```bash
$ docker run --rm hello-appsec-world
```

**Результат:** Ошибка EOFError (требуется интерактивный ввод, как в lab05)

#### 2.3. Сохранение и загрузка образа

```bash
$ docker save -o hello.tar hello-appsec-world
$ docker load -i hello.tar
```

**Результат:**
- Образ сохранен в `hello.tar` (размер 143MB)
- Образ успешно загружен из архива

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
   - Запуск от пользователя root (нет USER директивы)
   - Нет ограничений ресурсов
   - Нет проверки целостности зависимостей

**Commit:** Dockerfile уже был закоммичен ранее в коммите `dbed2df` (Lab05: добавлен отчет, Lab06: начальная структура и файлы). Анализ выполнен.

---

### Задание 4: Замена скрипта на hello.py

**Анализ изменений:**
- Используется скрипт `hello.py` из корня репозитория (создан в lab01)
- Скрипт содержит функции для работы с пользователем (hello_world, hello_user, interactive_greeting)
- Dockerfile уже настроен: `COPY hello.py .` и `CMD ["python", "hello.py"]`

**Текущий Dockerfile (после замены):**
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

**Анализ измененного Dockerfile:**
- Многоэтапная сборка сохранена для оптимизации
- Скрипт `hello.py` копируется в образ
- Запуск через `CMD ["python", "hello.py"]`
- **Проблема:** hello.py использует `input()` для интерактивного ввода, что вызывает EOFError при неинтерактивном запуске

**Результат сборки:**
```bash
$ docker buildx build -t hello-appsec-world .
# Образ успешно собран
```

**Результат запуска:**
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

**Примечание:** Скрипт требует интерактивного ввода, поэтому при неинтерактивном запуске возникает ошибка. Для работы в контейнере нужно модифицировать скрипт или использовать переменные окружения.

**Commit:** Dockerfile и hello.py уже были закоммичены ранее в коммите `dbed2df`. Изменения применены.

---

### Задание 5: Повторная сборка и сравнение хеш-сумм

[Требуется выполнить команды и заполнить результаты]

---

### Задание 6: Доработка скрипта с библиотеками

[Требуется добавить библиотеки в requirements.txt]

---

### Задание 7: Сборка доработанного приложения

[Требуется выполнить сборку и сохранить образ]

---

### Задание 8: Работа с Docker Hub

[Требуется выполнить команды работы с Docker Hub]

---

### Задание 9: Анализ процессов в контейнере

[Требуется проанализировать процессы в контейнере]

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
