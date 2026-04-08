<div align="center">
<a href="https://github.com/geminishkv/course_labs">
<img src="https://socialify.git.ci/geminishkv/course_labs/image?description=1&language=1&name=1&owner=1&theme=Dark" alt="course_labs" width="640" />
</a>
</div>

<div align="center">

![Repo Size](https://img.shields.io/github/repo-size/geminishkv/course_labs)![License](https://img.shields.io/github/license/geminishkv/course_labs)![CI](https://img.shields.io/github/actions/workflow/status/geminishkv/course_labs/ci.yml?branch=develop)![Status](https://img.shields.io/badge/status-active-success)![Release](https://img.shields.io/github/v/release/geminishkv/course_labs)![Contributors](https://img.shields.io/github/contributors/geminishkv/course_labs)![Open pull requests](https://img.shields.io/github/issues-pr/geminishkv/course_labs)![Commit Activity](https://img.shields.io/github/commit-activity/m/geminishkv/course_labs)![Last commit](https://img.shields.io/github/last-commit/geminishkv/course_labs)

</div>

Практический курс по прикладной безопасности приложений: от `Git` до полноценного DevSecOps-конвейера.

**Что изучаем:**

* **Инфраструктура:** `Git`, `CI/CD`, `Docker`, `Docker Compose`, `GitHub Actions`, `YAML`
* **Языки:** `Python`, `Shell` (`Java` и `Go` — в контексте SCA и анализа зависимостей)
* **AppSec инструменты:** `Semgrep`, `Checkov`, `OWASP Dependency-Check`, `Trivy`, `OWASP ZAP`, `Gitleaks`, `Hadolint`, `Bandit`
* **Стандарты:** OWASP Top 10, CIS Benchmarks, CVSS, ISO 27005
* **Анализ рисков:** оценка, приоритизация, стратегии снижения рисков ИБ

**Как устроен курс:**

* 10 лабораторных работ + итоговый pet-project + 5 тестов
* Каждая лабораторная — отдельный репозиторий с исходным кодом и отчётом в формате `gistup`
* Все работы выполняются в ветке `develop` → `pull request` → [approve](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/requesting-a-pull-request-review) от [geminishkv](https://github.com/geminishkv)
* Прогрессия: `Git` → `Linux` → `Nmap` → `Docker` → `CIS Benchmark` → `SAST/SCA` → `DAST` → `Secret Detection` → `CI/CD` → `Risk Analysis`

**Замечания:**

* Лабораторные обязательны для всех — вне зависимости от уровня подготовки
* Каждая работа разбивается на атомарные коммиты для трекинга изменений
* Отчёт сдаётся индивидуально с защитой: каждая команда — с описанием флагов и выводом из терминала
* В отчётах — вывод из консоли, не скриншоты
* Часть инструментов требует установки дополнительных `open-source` пакетов

### Этапы

1. Выполнить подготовительные инструкции:
    * [Подготовка рабочего окружения](labs/intro/vmbox_tutorial.md) — VirtualBox, установка Linux
    * [Настройка Git, GPG и GitHub CLI](labs/intro/git_setup.md) — git config, SSH, GnuPG, gh
    * [Оформление отчётов Gistup](labs/intro/gistup_guide.md) — формат, структура, правила
    * [Установка AppSec-инструментов](labs/intro/appsec_tools_setup.md) — Semgrep, Trivy, ZAP, Gitleaks, Checkov
2. Каждый репозиторий должен содержать `.gitignore`, `CODE_OF_CONDUCT`, `CONTRIBUTING`, `LICENSE`, `NOTICE`, `SECURITY`
3. Выполнить лабораторные работы по порядку:

-  [ ] lab01 — [GitSCM — подготовка рабочего окружения](labs/basic/lab01/README.md)
-  [ ] lab02 — [*nix — права доступа, SUID, ACL, процессы](labs/basic/lab02/README.md)
-  [ ] lab03 — [Nmap — сканирование сети, NSE и защита результатов](labs/basic/lab03/README.md)
-  [ ] lab04 — [Анализ и определение мер снижения рисков ИБ](labs/basic/lab04/README.md)
-  [ ] lab05 — [Docker — контейнеризация приложений](labs/basic/lab05/README.md)
-  [ ] lab06 — [Docker CIS Benchmark и Trivy](labs/basic/lab06/README.md)
-  [ ] lab07 — [SAST, SCA и Secret Detection](labs/basic/lab07/README.md)
-  [ ] lab08 — [DAST — OWASP ZAP и ручное тестирование](labs/basic/lab08/README.md)
-  [ ] lab09 — [DevSecOps CI/CD конвейер на GitHub Actions](labs/basic/lab09/README.md)
-  [ ] lab10 — [Оценка анализа рисков ИБ — практика](labs/basic/lab10/README.md)

4. Реализовать итоговую работу:

-  [ ] pet_project — [Индивидуальный проект: полный стек AppSec/DevSecOps](labs/pet_project/README.md)

***

### Карта

```mermaid
flowchart TD
    subgraph Intro["Подготовка"]
        I01["VirtualBox & Linux"]
        I02["Git, GPG, SSH, gh"]
        I03["Gistup отчёты"]
        I04["AppSec Tools Setup"]
    end

    subgraph Foundations["Основы"]
        L01["Lab 01 · Git SCM"]
        L02["Lab 02 · Linux, SUID, ACL"]
        L03["Lab 03 · Nmap, NSE"]
        L04["Lab 04 · Risk Analysis"]
    end

    subgraph Containers["Контейнеризация"]
        L05["Lab 05 · Docker"]
        L06["Lab 06 · CIS Benchmark, Trivy"]
    end

    subgraph AppSec["AppSec Toolchain"]
        L07["Lab 07 · SAST, SCA, Secret Detection\nSemgrep · Checkov · Gitleaks"]
        L08["Lab 08 · DAST\nOWASP ZAP"]
    end

    subgraph DevSecOps["DevSecOps"]
        L09["Lab 09 · CI/CD Pipeline\nGitHub Actions"]
        L10["Lab 10 · Risk Analysis · Practice"]
    end

    subgraph Tests["Тесты"]
        T01["Тест 01-05"]
    end

    PET["Pet Project — индивидуальная работа"]

    Intro --> Foundations
    Foundations --> Containers
    Containers --> AppSec
    AppSec --> DevSecOps
    DevSecOps --> Tests
    Tests --> PET
```

***

### Формализованные требования

- Единый стиль кода
- Все функции по работе с деревом должны находиться в пространстве имен
- Оформление `README.md` в соответствии с содержанием проекта
- Оформление `.gitignore` в соответствии с содержанием проекта
- Оформление `.dockerignore` в соответствии с содержанием проекта
- Использовать подходящий тип `LICENSE` для проекта и `NOTICE`
- Создать и использовать скрипты для автоматизации сборки проекта, примеров, тестов, пакетирования
- Обеспечить непрерывный процесс сборки проекта с использованием сервиса `GitHub Actions`
- Написать документацию к проекту с использованием инструмента **doxygen**
- Обеспечить размещение пакета проекта на сервисе `GitHub Release` при успешном слияние ветки `develop`
- Рефакторинг и поддержка лабораторных работ в процессной деятельности
- Все команды выполняться строго из `терминала/ консоли` без использования `WebUI` за исключениям работы с токенами, ключами и специфичными настройками

***

### Tutorial

* Подготовка окружения

```bash
$ python3 -m venv .venv
$ source .venv/bin/activate
$ pip install -r requirements.txt
$ python -m mkdocs serve --livereload
# or
$ mkdocs serve -a 127.0.0.1:8001 # прямое обозначение адреса
```

* Очистка локального репозитория

```bash
$ rm -rf __pycache__ scripts/__pycache__
$ rm -rf .venv
$ lsof -i :8000
$ kill <PID>
```

* Release

```bash
$ git tag -a v1.0.0 -m "v1.0.0"
$ git push origin v1.0.0

$ git tag -d v0.1.0                    # удалить локальный тег
$ git push --delete origin v1.2.3   # удалить тот же тег на GitHub
```

***

### Структура

```
├── docs/                              # MkDocs source
│   ├── index.md                       # Главная (hero + lab cards + tg widget)
│   ├── privacy.md                     # Политика конфиденциальности
│   ├── about.md                       # О проекте
│   ├── Security.md                    # Политика безопасности
│   ├── RELEASE_NOTES.md               # Релизы
│   ├── glossary.md                    # 39 аббревиатур
│   ├── labs/
│   │   ├── intro/                     # vmbox, git_setup, gistup, appsec_tools_setup
│   │   ├── basic/lab01-10.md          # 10 лабораторных
│   │   ├── pet_project.md             # Итоговый проект
│   │   └── tests/basic/               # 5 тестов + ответы
│   ├── materials/
│   │   ├── lectures/fintech_ru.md     # Лекция Fintech
│   │   ├── examples/                  # Кейсы ИБ
│   │   ├── OWASPTOP10/               # 7 OWASP материалов
│   │   ├── cheatsheet/               # 6 шпаргалок
│   │   ├── ports.md                   # Справочник портов
│   │   ├── appsec_tt.md              # 29 классов инструментов
│   │   ├── licenses.md               # 41 лицензия
│   │   ├── APPENDIX.md               # Команды и утилиты
│   │   └── troubleshooting.md        # FAQ
│   ├── stylesheets/                   # 8 CSS файлов
│   ├── javascripts/                   # 5 JS файлов
│   ├── overrides/                     # main.html, 404.html
│   └── artifacts/assets/             # Logo, favicon, images
├── labs/
│   ├── intro/                         # Исходники intro (include-markdown)
│   ├── basic/lab01-10/               # Код + отчёты + docker-compose
│   └── pet_project/
├── .github/workflows/
│   ├── ci.yml                         # Lint → Audit → Build → Deploy
│   └── release-from-notes.yml
├── hooks.py                           # Sitemap enrichment
├── mkdocs.yml
├── requirements.txt
└── RELEASE_NOTES.md
```
