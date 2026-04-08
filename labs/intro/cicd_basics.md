<!-- markdownlint-disable MD033 -->
<div align="center">
<h1><a id="intro">Введение в CI/CD и GitHub Actions</a><br></h1>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/CI%2FCD-2088FF?style=flat&logo=githubactions&logoColor=white" alt="CI/CD">
<img src="https://img.shields.io/badge/GitHub_Actions-181717?style=flat&logo=github&logoColor=white" alt="GitHub Actions">
<img src="https://img.shields.io/badge/YAML-CB171E?style=flat&logo=yaml&logoColor=white" alt="YAML">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Введение в непрерывную интеграцию и доставку перед лабораторной Lab 09. Здесь — концепция CI/CD, структура GitHub Actions и минимальный workflow.

> Если вы уже настраивали пайплайны — переходите сразу к Lab 09.

***

## Что такое CI/CD

**CI (Continuous Integration)** — автоматическая сборка и тестирование кода при каждом изменении. Каждый push или pull request запускает проверки.

**CD (Continuous Delivery / Deployment)** — автоматическая доставка проверенного кода в staging или production.

```text
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌──────────┐    ┌────────────┐
│  Code   │───→│  Build  │───→│  Test   │───→│  Review  │───→│  Deploy    │
│  (push) │    │         │    │         │    │  (PR)    │    │  (release) │
└─────────┘    └─────────┘    └─────────┘    └──────────┘    └────────────┘
     └──────── CI ────────────────────┘            └──── CD ──────────────┘
```

### Зачем это нужно

- **Раннее обнаружение ошибок** — сломанный код не попадёт в основную ветку
- **Автоматизация рутины** — линтинг, тесты, сборка, публикация
- **Единый стандарт качества** — все проверки одинаковые для всех
- **Безопасность** — SAST, SCA, DAST, secret detection в каждом пайплайне

***

## GitHub Actions — основы

GitHub Actions — встроенная CI/CD платформа GitHub. Workflow описывается в YAML-файле.

### Ключевые термины

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Workflow</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">.yml</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Автоматизированный процесс, описанный в YAML-файле</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Event</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">trigger</span>
    </div>
    <div class="lab-card-tags"><span class="lab-tag">push</span><span class="lab-tag">pull_request</span><span class="lab-tag">schedule</span><span class="lab-tag">workflow_dispatch</span></div>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Job</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">задача</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Набор шагов, выполняемых на одном runner</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Step</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">шаг</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Отдельное действие внутри job</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Action</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Marketplace</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Переиспользуемый блок (из Marketplace или свой)</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Runner</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">VM</span>
    </div>
    <div class="lab-card-tags"><span class="lab-tag">ubuntu-latest</span><span class="lab-tag">macos-latest</span></div>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Artifact</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">output</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Файл-результат job (отчёты, бинарники)</p>
  </div>

</div>

### Структура проекта

```text
.github/
└── workflows/
    ├── ci.yml              ← основной пайплайн
    ├── security.yml        ← SAST/SCA проверки
    └── release.yml         ← публикация релизов
```

***

## Минимальный workflow

Файл: `.github/workflows/ci.yml`

{% raw %}
```yaml
name: CI                                    # название workflow

on:                                         # триггеры
  push:
    branches: [main, develop]               # при push в эти ветки
  pull_request:
    branches: [main]                        # при PR в main

jobs:
  build:                                    # имя job
    runs-on: ubuntu-latest                  # runner

    steps:
      - name: Checkout code                 # шаг 1: клонировать репо
        uses: actions/checkout@v4

      - name: Set up Python                 # шаг 2: настроить Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.12"

      - name: Install dependencies          # шаг 3: установить зависимости
        run: pip install -r requirements.txt

      - name: Run tests                      # шаг 4: запустить тесты
        run: pytest tests/
```
{% endraw %}

### Разбор структуры

{% raw %}
```yaml
name: CI                    # Имя — видно во вкладке Actions на GitHub
on:                         # Когда запускать
  push:                     #   при push
    branches: [main]        #     в ветку main
jobs:                       # Список задач
  build:                    # Задача "build"
    runs-on: ubuntu-latest  # На какой машине
    steps:                  # Последовательность шагов
      - uses: action@v4     #   готовое action
      - run: команда        #   shell-команда
```
{% endraw %}

***

## Триггеры (Events)

{% raw %}
```yaml
on:
  # При push
  push:
    branches: [main, develop]
    paths:
      - "src/**"                   # только при изменении src/
    tags:
      - "v*"                       # при создании тега v1.0.0

  # При pull request
  pull_request:
    branches: [main]
    types: [opened, synchronize]   # при открытии и обновлении PR

  # По расписанию (cron)
  schedule:
    - cron: "0 6 * * 1"            # каждый понедельник в 06:00 UTC

  # Ручной запуск
  workflow_dispatch:
    inputs:
      environment:
        description: "Target environment"
        required: true
        default: "staging"
```
{% endraw %}

***

## Переменные и секреты

### Переменные окружения

{% raw %}
```yaml
env:                                       # глобальные для workflow
  PYTHON_VERSION: "3.12"

jobs:
  build:
    env:                                   # для конкретного job
      NODE_ENV: production
    steps:
      - name: Use variable
        run: echo "Python ${{ env.PYTHON_VERSION }}"
        env:                               # для конкретного шага
          MY_VAR: value
```
{% endraw %}

### Секреты

Секреты хранятся в настройках репозитория (`Settings → Secrets and variables → Actions`).

{% raw %}
```yaml
steps:
  - name: Deploy
    run: ./deploy.sh
    env:
      API_TOKEN: ${{ secrets.API_TOKEN }}  # никогда не логируется
```
{% endraw %}

!!! warning "Безопасность секретов"
    - Секреты **не передаются** в workflow из форков (защита от кражи)
    - Секреты **маскируются** в логах (но не полагайтесь только на это)
    - Не используйте секреты в `if:` условиях — они могут утечь через имя шага

***

## Матрица стратегий

Запуск одного job на нескольких конфигурациях:

{% raw %}
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.10", "3.11", "3.12"]
        os: [ubuntu-latest, macos-latest]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
      - run: pytest tests/
```
{% endraw %}

Создаёт 6 параллельных jobs: 3 версии Python x 2 ОС.

***

## Артефакты

Сохранение результатов job для скачивания или передачи между jobs:

{% raw %}
```yaml
steps:
  - name: Run SAST
    run: semgrep scan --json > report.json

  - name: Upload report
    uses: actions/upload-artifact@v4
    with:
      name: sast-report
      path: report.json
      retention-days: 30
```
{% endraw %}

***

## Пример: DevSecOps пайплайн

Типичная структура для Lab 09:

{% raw %}
```yaml
name: DevSecOps Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: pip install ruff && ruff check .

  sast:
    runs-on: ubuntu-latest
    needs: lint                              # запускается после lint
    steps:
      - uses: actions/checkout@v4
      - run: pip install semgrep && semgrep scan --config auto

  container-scan:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4
      - run: docker build -t myapp .
      - name: Trivy scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: myapp
          severity: HIGH,CRITICAL

  deploy:
    runs-on: ubuntu-latest
    needs: [sast, container-scan]            # после всех проверок
    if: github.ref == 'refs/heads/main'      # только из main
    steps:
      - run: echo "Deploying..."
```
{% endraw %}

```text
    ┌────────┐
    │  lint  │
    └───┬────┘
        │
   ┌────┴────┐
   ▼         ▼
┌──────┐ ┌───────────────┐
│ sast │ │ container-scan│
└──┬───┘ └──────┬────────┘
   │            │
   └─────┬──────┘
         ▼
    ┌─────────┐
    │ deploy  │
    └─────────┘
```

***

## YAML — краткий справочник

Workflow пишутся на YAML. Основные правила:

```yaml
# Скаляры
string: "hello"
number: 42
boolean: true

# Списки
items:
  - first
  - second
  - third

# Словари
person:
  name: "Alice"
  age: 30

# Многострочные строки
description: |           # сохраняет переносы
  Первая строка
  Вторая строка

command: >               # склеивает в одну строку
  docker build
  --tag myapp
  --file Dockerfile .
```

!!! tip "Валидация YAML"
    Используйте [yamllint](https://github.com/adrienverber/yamllint) для проверки синтаксиса.

> Подробнее: [YAML CheatSheet](https://course.geminishkv.tech/materials/cheatsheet/CHEATSHEET_YAML/) и [GitHub Actions Security CheatSheet](https://course.geminishkv.tech/materials/cheatsheet/CHEATSHEET_GH_ACTIONS_SECURITY/).

***

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://docs.github.com/en/actions" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub Actions Documentation</div><div class="lab-card-tags"><span class="lab-tag">docs.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Workflow Syntax Reference</div><div class="lab-card-tags"><span class="lab-tag">docs.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/marketplace?type=actions" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub Actions Marketplace</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
