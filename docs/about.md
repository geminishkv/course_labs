---
hide:
  - navigation
  - toc

title: "О проекте — цели и структура курса AppSec МГТУ"
description: "AppSec курс МГТУ: принципы, структура и цели лабораторных работ по прикладной безопасности приложений, DevSecOps и анализу рисков ИБ."
keywords: "AppSec, курс МГТУ, DevSecOps, о проекте, структура курса, лабораторные работы, информационная безопасность, OWASP, анализ рисков, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">О проекте</h1>
    <p class="hero-sub">Принципы, цели и структура курса AppSec</p>
  </div>
</div>

Практический курс по прикладной безопасности приложений: AppSec, Risk Analysis, Security Champion — Toolchain, Orchestration, CI/CD.

## Описание

Учебный проект по прикладной безопасности приложений, в котором собраны лабораторные работы от базовых практик DevOps до анализа рисков и применения инструментов Application Security.

> Курс ориентирован на разработчиков и инженеров, которые хотят научиться использовать Git, CI/CD, контейнеризацию, сканеры уязвимостей и сопутствующие сервисы в реальных мини‑проектах

## Цели

- Сформировать практические навыки работы с репозиториями, пайплайнами, Docker и сопутствующими инструментами
- Показать на примерах, как применять SAST, SCA, DAST, анализ контейнеров и Secret Detection в процессе разработки
- Научить описывать результаты в виде отчётов (gistup) и выстраивать итерационный процесс через осмысленные коммиты
- Дать понимание принципов анализа и оценки рисков ИБ с практической привязкой к инструментам

## Структура курса

### Intro (7 материалов)

Подготовительные руководства перед началом лабораторных работ:

- Подготовка рабочего окружения (VirtualBox, Ubuntu/Fedora)
- Настройка Git, GPG и GitHub CLI
- Оформление отчётов Gistup
- Введение в сети и TCP/IP
- Основы Docker и контейнеризации
- Введение в CI/CD и GitHub Actions
- Установка AppSec-инструментов (Semgrep, Trivy, ZAP, Gitleaks)

### Лабораторные работы (10 + pet-project)

Прогрессия: `Git` → `Linux` → `Nmap` → `Risk Analysis` → `Docker` → `CIS Benchmark` → `SAST/SCA` → `DAST` → `CI/CD` → `Итоговый Risk Analysis` → `Pet-project`

### Тесты

- **Базовое ознакомление** — 5 вариантов с вопросами по материалам лабораторных работ
- **Лекционные тесты** — кейсовые вопросы по лекциям (Fintech по-русски: 2 варианта)

### Материалы

- **Лекции** — Fintech по-русски
- **OWASP Top 10** — Authentication, Authorization, Client-side Attacks, Command Execution, Logical Attacks, Information Disclosure, CI/CD Risks
- **Примеры** — Cases, Supply Chain Attacks, PrintNightmare, MultiSig, Risk Analysis
- **CheatSheets** — Git, Docker, YAML, HTTP Headers, Dockerfile Security, GitHub Actions Security, GitHub CLI, .gitignore, .dockerignore
- **Справочники** — AppSec Toolchain, Порты и протоколы, Лицензии ПО, Troubleshooting

## Стек технологий

- **Инфраструктура:** Git, GitHub Actions, Docker, Docker Compose
- **Языки:** Python, Shell (Java и Go — в контексте SCA)
- **AppSec инструменты:** Semgrep, Checkov, Bandit, OWASP Dependency-Check, Trivy, Docker Bench, OWASP ZAP, Gitleaks, TruffleHog
- **Стандарты:** OWASP Top 10, CIS Docker Benchmark, CVSS, ISO 27005, NIST SP 800-30, PCI DSS, ГОСТ 57580

## Что ожидается от слушателя

- Для каждой лабораторной работы создаётся отдельный репозиторий с исходным кодом и конфигурацией
- Результаты оформляются в отчётах `gistup` с выводами инструментов и пояснениями к использованным командам
- Все команды — из терминала, каждая с описанием флагов и пояснением вывода
- Каждая работа разбивается на атомарные коммиты для трекинга изменений

## Автор

**Elijah S Shmakov** — Application Security Teamlead

- [geminishkv.tech](https://geminishkv.tech/)
- [GitHub](https://github.com/geminishkv)
- [Telegram](https://t.me/appsecta)
