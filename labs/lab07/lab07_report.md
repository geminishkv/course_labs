# Отчет по лабораторной работе №7
## SAST и SCA анализ безопасности приложения

## Выполненные задания

### Задание 1: Развертывание и подготовка окружения для уязвимого приложения

**Создание виртуального окружения:**
```bash
$ cd /root/course_labs/labs/lab07
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r vulnerable-app/requirements.txt
```

**Результат установки зависимостей:**
```
Successfully installed Django-2.2 Flask-2.0.1 Jinja2-3.0.1 MarkupSafe-2.0.1 PyYAML-5.3.1 
SQLAlchemy-1.3.23 Werkzeug-2.0.3 bcrypt-5.0.0 certifi-2018.4.16 cffi-2.0.0 chardet-3.0.4 
click-8.0.1 cryptography-3.2 gunicorn-20.1.0 idna-2.7 itsdangerous-2.0.1 paramiko-2.4.1 
pyasn1-0.6.1 pycparser-2.23 pyjwt-1.7.1 pynacl-1.6.1 pytz-2025.2 requests-2.19.1 
setuptools-80.9.0 six-1.15.0 sqlparse-0.5.4 urllib3-1.23
```

**Установленные пакеты:**
- Flask==2.0.1
- Django==2.2.0
- SQLAlchemy==1.3.23
- requests==2.19.1
- PyYAML==5.3.1
- pyjwt==1.7.1
- cryptography==3.2
- И другие зависимости

**Статус:** Виртуальное окружение создано, все зависимости установлены

---

### Задание 2: Запуск уязвимого приложения

**Запуск через docker-compose:**
```bash
$ cd /root/course_labs/labs/lab07
$ docker-compose -f docker-compose.yml up -d --build
```

**Результат:**
- Образ собран успешно: `sha256:82603a22d7d0e2da023bce3a93a3f9650541ec1b8214629016ad15aacc32ab23`
- Создана сеть `lab07_default`
- Контейнер `lab07-vulnerable-app-1` запущен
- Приложение доступно на `http://localhost:8080`

**Статус контейнера:**
```bash
$ docker ps --filter "name=lab07"
NAMES                    STATUS         PORTS
lab07-vulnerable-app-1   Up             0.0.0.0:8080->8080/tcp
```

---

### Задание 3: Запуск SAST Semgrep

**Установка Semgrep:**
```bash
$ source venv/bin/activate
$ pip install semgrep
```

**Запуск сканирования:**
```bash
$ semgrep --config sast/semgrep-rules.yml \
  --json \
  --output sast/semgrep-report.json \
  vulnerable-app/
```

**Результаты сканирования:**
- Всего правил выполнено: 16
- Файлов просканировано: 2 (app.py, config.yaml)
- Найдено уязвимостей: **5**

**Найденные уязвимости:**
1. **sast.py-info-version-disclosure** (LOW) - `vulnerable-app/app.py:26`
   - Раскрытие версии приложения в ответе
2. **sast.py-os-system-rce** (CRITICAL) - `vulnerable-app/app.py:52`
   - RCE через os.system с данными пользователя
3. **sast.py-arbitrary-file-read** (CRITICAL) - `vulnerable-app/app.py:68`
   - Чтение произвольного файла по пути из запроса (LFI/Path Traversal)
4. **sast.py-unsafe-pickle-deserialization** (CRITICAL) - `vulnerable-app/app.py:79`
   - Небезопасная десериализация через pickle.loads
5. **sast.py-eval-user-input** (HIGH) - `vulnerable-app/app.py:88`
   - Опасное использование eval на пользовательском вводе

**Отчет сохранен:** `sast/semgrep-report.json` (3.7 KB)

---

### Задание 4: Запуск SAST Checkov

**Установка Checkov:**
```bash
$ source venv/bin/activate
$ pip install checkov
```

**Запуск сканирования:**
```bash
$ checkov --framework dockerfile \
  --file vulnerable-app/Dockerfile docker-compose.yml \
  --output json \
  --output-file-path sast/checkov-report.json \
  --soft-fail
```

**Результаты сканирования:**
- Проверок пройдено: **50**
- Проверок провалено: **2**
- Версия Checkov: 3.2.495

**Найденные проблемы:**
1. **CKV_DOCKER_3** - `vulnerable-app/Dockerfile`
   - Отсутствует HEALTHCHECK инструкция
2. **CKV_DOCKER_2** - `vulnerable-app/Dockerfile`
   - Проблема с конфигурацией Dockerfile

**Отчет сохранен:** `sast/checkov-report.json` (102 KB)

---

### Задание 5: Подготовка зависимостей Java и Maven-скан для SCA

[Требуется выполнить команды и заполнить результаты]

---

### Задание 6: Запуск SCA CLI OWASP Dependency-Check

[Требуется выполнить команды и заполнить результаты]

---

### Задание 7: Сбор единого отчета

[Требуется выполнить команды и заполнить результаты]

---

### Задание 8: Анализ и исправление уязвимостей Checkov

[Требуется анализ и исправления]

---

### Задание 9: Исправление уязвимостей Semgrep в app.py

[Требуется анализ и исправления]

---

### Задание 10: Доработка SCA уязвимостей

[Требуется доработка]

---

### Задание 11: Проверка через cheat_check_yuorself.sh

[Требуется выполнить]

---

### Задание 12: Коммиты и push в репозиторий

[Требуется выполнить]

---

### Задание 13: Подготовка отчета в Gist

[Требуется выполнить]

---

### Задание 14: Очистка окружения

[Требуется выполнить]
