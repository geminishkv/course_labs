---
title: "CheatSheet: YAML синтаксис | Курс AppSec"
description: "YAML шпаргалка: синтаксис, типы данных, якоря, многострочные строки и валидация для CI/CD, Docker Compose и GitHub Actions."
keywords: "YAML, cheatsheet, шпаргалка, синтаксис, CI/CD, Docker Compose, GitHub Actions, Kubernetes, DevSecOps, AppSec, якоря, валидация, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">YAML</h1>
    <p class="hero-sub">Синтаксис, типы данных и паттерны для DevSecOps</p>
  </div>
</div>

## Зачем

YAML используется **везде** в DevSecOps-стеке: GitHub Actions workflows, Docker Compose, Kubernetes manifests, Semgrep rules, Checkov configs, Trivy, ZAP. Без понимания синтаксиса невозможно ни написать пайплайн, ни настроить инструмент безопасности.

***

## Базовый синтаксис

```yaml
# Комментарии начинаются с #
# Отступы ТОЛЬКО пробелами (не табами!), обычно 2 пробела

# Скаляры (строки, числа, boolean)
name: "DevSecOps Pipeline"       # строка в кавычках
version: 3.8                      # число (float)
enabled: true                     # boolean: true/false, yes/no, on/off
count: 42                         # число (int)
empty_value: null                 # null: null, ~, пустое значение

# Строки без кавычек
title: Простая строка без кавычек
```

***

## Коллекции

```yaml
# Список (массив) — дефис + пробел
fruits:
  - apple
  - banana
  - cherry

# Список в одну строку (flow syntax)
tags: [SAST, SCA, DAST]

# Словарь (map) — ключ: значение
database:
  host: localhost
  port: 5432
  name: appdb

# Словарь в одну строку
point: {x: 1, y: 2}
```

***

## Вложенность

```yaml
# Вложенные структуры — через отступы
server:
  production:
    host: prod.example.com
    port: 443
    ssl: true
  staging:
    host: staging.example.com
    port: 8080
    ssl: false

# Список словарей
users:
  - name: admin
    role: superuser
    active: true
  - name: viewer
    role: readonly
    active: false
```

***

## Многострочные строки

```yaml
# | (literal block) — сохраняет переносы строк
script: |
  echo "Step 1"
  pip install -r requirements.txt
  pytest --cov

# > (folded block) — склеивает строки в одну (переносы → пробелы)
description: >
  Это длинное описание,
  которое будет склеено
  в одну строку.

# |- и >- — то же, но без завершающего \n
command: |-
  semgrep \
    --config auto \
    --json \
    app/
```

!!! warning "Частая ошибка"
    `|` и `>` требуют, чтобы содержимое было с отступом. Без отступа YAML-парсер не поймёт, где заканчивается блок.

***

## Якоря и алиасы (переиспользование)

```yaml
# &anchor — определить якорь
# *alias — использовать якорь
# <<: *alias — merge (вставить все ключи из якоря)

defaults: &defaults
  timeout: 30
  retries: 3
  log_level: info

production:
  <<: *defaults            # вставит timeout, retries, log_level
  log_level: warning       # перезапишет только log_level

staging:
  <<: *defaults
  timeout: 60              # перезапишет только timeout
```

***

## Типы данных и подводные камни

```yaml
# YAML автоматически определяет типы — это источник багов

# Строки, которые YAML трактует как boolean:
is_active: yes           # → true (не строка!)
is_active: "yes"         # → строка "yes"

# Строки, которые YAML трактует как числа:
version: 3.10            # → число 3.1 (отбрасывает trailing zero!)
version: "3.10"          # → строка "3.10"

# Строки, которые YAML трактует как null:
value:                   # → null
value: ~                 # → null
value: ""                # → пустая строка (не null)

# Строки, похожие на даты:
date: 2024-01-01         # → дата (datetime)
date: "2024-01-01"       # → строка
```

!!! danger "Правило"
    Если значение **должно быть строкой** — всегда используйте кавычки. Особенно для: версий (`"3.10"`), значений `yes/no/on/off`, пустых строк.

***

## YAML в GitHub Actions

```yaml
name: CI Pipeline

on:
  push:
    branches: [develop, main]
  pull_request:
    branches: [main]

env:
  PYTHON_VERSION: "3.12"         # кавычки — иначе 3.12 → 3.12 (ок), но 3.10 → 3.1

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"  # кавычки обязательны!

      - name: Run linter
        run: |                    # | для многострочных команд
          pip install ruff
          ruff check .
```

***

## YAML в Docker Compose

```yaml
version: "3.8"                   # кавычки — версия как строка

services:
  app:
    build:
      context: ./app
      dockerfile: Dockerfile
    ports:
      - "8080:80"                # кавычки — порты как строки
    environment:
      - DEBUG=false
      - DATABASE_URL=postgres://db:5432/app
    depends_on:
      - db
    restart: unless-stopped

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: app
      POSTGRES_USER: user
      POSTGRES_PASSWORD: secret   # в проде → Docker Secrets или .env
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
```

***

## YAML в Semgrep Rules

```yaml
rules:
  - id: hardcoded-secret
    patterns:
      - pattern: |
          $KEY = "..."
      - metavariable-regex:
          metavariable: $KEY
          regex: (password|secret|api_key|token)
    message: "Hardcoded secret detected in $KEY"
    languages: [python]
    severity: ERROR
```

***

## Валидация

```bash
# Python (встроенный)
$ python3 -c "import yaml; yaml.safe_load(open('file.yml'))"

# yamllint (рекомендуется для CI)
$ pip install yamllint
$ yamllint file.yml
$ yamllint -d "{extends: default, rules: {line-length: disable}}" .

# yq (jq для YAML)
$ brew install yq                     # macOS
$ yq eval '.services' docker-compose.yml
$ yq eval '.jobs | keys' .github/workflows/ci.yml
```

***

## Частые ошибки

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem; border-left-color: #F9B361;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-gold-dark); margin-bottom:0.1rem;">3.10 → 3.1</div>
  <span class="lab-tag" style="border-color:rgba(249,179,97,0.3); color:#c48a20; background:rgba(249,179,97,0.08);">Потеря trailing zero</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>python-version: 3.10</code> → число 3.1. Решение: <code>"3.10"</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem; border-left-color: #F9B361;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-gold-dark); margin-bottom:0.1rem;">yes → true</div>
  <span class="lab-tag" style="border-color:rgba(249,179,97,0.3); color:#c48a20; background:rgba(249,179,97,0.08);">Неявное приведение</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>deploy: yes</code> → boolean. Также <code>no</code>, <code>on</code>, <code>off</code>. Решение: <code>"yes"</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem; border-left-color: #F9B361;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-gold-dark); margin-bottom:0.1rem;">Табы вместо пробелов</div>
  <span class="lab-tag" style="border-color:rgba(249,179,97,0.3); color:#c48a20; background:rgba(249,179,97,0.08);">Ошибка парсинга</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Только пробелы, 2 на уровень. <code>indent_style = space</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem; border-left-color: #F9B361;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-gold-dark); margin-bottom:0.1rem;">Пробел после :</div>
  <span class="lab-tag" style="border-color:rgba(249,179,97,0.3); color:#c48a20; background:rgba(249,179,97,0.08);">Обязателен</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>key:value</code> — ошибка. <code>key: value</code> — правильно</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem; border-left-color: #F9B361;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-gold-dark); margin-bottom:0.1rem;">Дублирующиеся ключи</div>
  <span class="lab-tag" style="border-color:rgba(249,179,97,0.3); color:#c48a20; background:rgba(249,179,97,0.08);">Тихая перезапись</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Два <code>name:</code> — YAML берёт последний без ошибки. Используйте <code>yamllint</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem; border-left-color: #F9B361;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-gold-dark); margin-bottom:0.1rem;">Кириллица без кавычек</div>
  <span class="lab-tag" style="border-color:rgba(249,179,97,0.3); color:#c48a20; background:rgba(249,179,97,0.08);">Потенциальная проблема</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>title: Привет</code> → безопаснее <code>title: "Привет"</code></p>
  </div>

</div>

***

## Links

- [YAML Specification](https://yaml.org/spec/1.2.2/)
- [YAML Lint — онлайн-валидатор](https://www.yamllint.com/)
- [Learn YAML in Y Minutes](https://learnxinyminutes.com/docs/yaml/)
- [yamllint Documentation](https://yamllint.readthedocs.io/)
- [yq — CLI YAML processor](https://mikefarah.gitbook.io/yq/)
