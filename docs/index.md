---
hide:
  - toc

title: Введение в курс AppSec
description: Практический курс по прикладной безопасности приложений — лабораторные работы, материалы по AppSec, DevSecOps, OWASP Top 10 и анализу рисков.
---

<div class="hero-section">
  <img src="artifacts/assets/logo-hero.png" class="hero-logo" alt="AppSecTA">
  <div class="hero-content">
    <h1 class="hero-title">Application Security Course</h1>
    <p class="hero-sub">Практический курс по прикладной безопасности приложений</p>
    <p class="hero-typewriter" id="typewriter-target"></p>
  </div>
</div>

<div class="tg-layout" markdown="1">
<div class="tg-layout-main" markdown="1">

<div align="center">

<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course">
<img src="https://img.shields.io/badge/Language-Русский-D51A1A?style=flat" alt="Language: Russian">
<img src="https://img.shields.io/badge/Difficulty-Intermediate-D51A1A?style=flat" alt="Difficulty">
<img src="https://img.shields.io/badge/Status-Active-success?style=flat" alt="Status">
<a href="https://www.apache.org/licenses/LICENSE-2.0"><img src="https://img.shields.io/badge/License-Apache_2.0-D51A1A?style=flat" alt="License: Apache 2.0"></a>
<a href="https://github.com/geminishkv/course_labs/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/geminishkv/course_labs/ci.yml?branch=develop&label=CI&logo=githubactions&logoColor=white" alt="CI"></a>
<a href="https://github.com/geminishkv/course_labs/releases"><img src="https://img.shields.io/github/v/release/geminishkv/course_labs?label=Release" alt="Release"></a>
<img src="https://img.shields.io/github/last-commit/geminishkv/course_labs?label=Last+commit" alt="Last commit">
<img src="https://img.shields.io/github/contributors/geminishkv/course_labs?label=Contributors" alt="Contributors">
<img src="https://img.shields.io/badge/git-%23F05033.svg?style=flat&logo=git&logoColor=white" alt="Git">
<img src="https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black" alt="Linux">
<a href="https://www.docker.com/"><img src="https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white" alt="Docker"></a>
<img src="https://img.shields.io/badge/Nmap-214478?style=flat" alt="Nmap">
<img src="https://img.shields.io/badge/Semgrep-1B2333?style=flat" alt="Semgrep">
<img src="https://img.shields.io/badge/Trivy-1904DA?style=flat&logo=aquasecurity&logoColor=white" alt="Trivy">
<img src="https://img.shields.io/badge/OWASP_ZAP-333333?style=flat" alt="OWASP ZAP">
<img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=githubactions&logoColor=white" alt="GitHub Actions">

</div>

---

## Intro

Цель курса — сформировать практические навыки в области AppSec и DevSecOps: от базовой работы с инструментами разработки до построения полноценного конвейера безопасности.

- Стек: `git`, `CI/CD`, `Docker`, `Packages`, `AppSec Toolchain`, `YAML`
- Языки в работах: `Go`, `Python`, `Java`, `Shell`
- Инструменты: `SAST`, `SCA`, `Container Security`, `DAST`, `Secret Detection`
- Каждый мини-проект размещается на `GitHub` с отчётом в формате `gistup`
- Для каждой лабораторной — отдельный репозиторий (или `fork`), исходный код + отчёт

---

## Этапы

1. Ознакомление с учебными материалами по лекциям и примерами
2. Каждый репозиторий должен содержать: `.gitignore`, `CODE_OF_CONDUCT`, `CONTRIBUTING`, `LICENSE`, `NOTICE`, `SECURITY`
3. Выполнить лабораторные работы по порядку
4. Итоговая работа — `pet_project` (тема согласовывается с преподавателем, применяется весь стек AppSec/DevSecOps)

!!! warning "Лицензии"
    Тип лицензии должен быть подобран корректно при переиспользовании материалов — ознакомьтесь дополнительно.

!!! info "Пример отчёта"
    [Пример gistup-отчёта](https://gist.github.com/MishaBary/21ab63f83292a86268e039d484a86411)

---

## Лабораторные работы

| № | Лабораторная работа | Стек | Материалы |
| --- | --- | --- | --- |
| **lab01** | [GitSCM — подготовка рабочего окружения](labs/lab01.md) | `Git` | [→ repo](https://github.com/geminishkv/course_labs/tree/develop/labs/lab01) |
| **lab02** | [*nix — права доступа, управление процессами](labs/lab02.md) | `Linux` `Bash` | [→ repo](https://github.com/geminishkv/course_labs/tree/develop/labs/lab02) |
| **lab03** | [Nmap — сканирование сети и анализ уязвимостей](labs/lab03.md) | `Nmap` `Linux` | [→ repo](https://github.com/geminishkv/course_labs/tree/develop/labs/lab03) |
| **lab04** | [Анализ и определение мер снижения рисков ИБ](labs/lab04.md) | `Risk Analysis` | — |
| **lab05** | [Docker — контейнеризация приложений](labs/lab05.md) | `Docker` | [→ repo](https://github.com/geminishkv/course_labs/tree/develop/labs/lab05) |
| **lab06** | [Docker CIS Benchmark — аудит Docker-хоста](labs/lab06.md) | `Docker` `CIS` | [→ repo](https://github.com/geminishkv/course_labs/tree/develop/labs/lab06) |
| **lab07** | [SAST и SCA — статический анализ и зависимости](labs/lab07.md) | `Semgrep` `Checkov` `OWASP DC` | [→ repo](https://github.com/geminishkv/course_labs/tree/develop/labs/lab07) |
| **lab08** | [DAST — динамическое тестирование уязвимого приложения](labs/lab08.md) | `OWASP ZAP` | [→ repo](https://github.com/geminishkv/course_labs/tree/develop/labs/lab08) |
| **lab09** | [DevSecOps CI/CD конвейер на GitHub Actions](labs/lab09.md) | `GH Actions` `Semgrep` `Trivy` `ZAP` | [→ repo](https://github.com/geminishkv/course_labs/tree/develop/labs/lab09) |
| **lab10** | [Оценка анализа рисков ИБ — практика](labs/lab10.md) | `Risk Analysis` | — |
| **pet** | [Pet-project — итоговая работа, полный AppSec/DevSecOps стек](labs/pet_project.md) | `Full stack` | — |

---

## Формализованные требования

- [x] Единый стиль кода, функции в пространстве имён
- [x] `README.md` оформлен в соответствии с содержанием проекта
- [x] `.gitignore` и `.dockerignore` настроены под проект
- [x] Лицензия (`LICENSE`) и `NOTICE` подобраны корректно
- [x] Скрипты автоматизации сборки, тестов и пакетирования
- [x] Непрерывная сборка через `GitHub Actions`
- [x] Документация проекта через `doxygen`
- [x] Публикация пакета на `GitHub Releases` при слиянии в `develop`
- [x] Рефакторинг и поддержка лабораторных в процессе работы
- [x] Все команды — строго из терминала, без `WebUI` (кроме токенов и специфичных настроек)

---

## Замечания

1. Лабораторные обязательны для всех — вне зависимости от уровня подготовки
2. Скопируй этапы реализации и отмечай выполненные у себя
3. Каждая работа разбивается на атомарные коммиты для трекинга изменений
4. Отчёт сдаётся индивидуально с защитой: каждая команда — с описанием, флагами и выводом из терминала
5. Часть инструментов требует установки дополнительных `open-source` пакетов
6. В отчётах — вывод из консоли, не скриншоты; описание каждого флага и команды

</div>

<div class="tg-widget" markdown="1">

### Канал AppSecTA

<div class="tg-channel-card">
  <div class="tg-channel-header">
    <img src="artifacts/assets/logo.png" class="tg-channel-logo" alt="AppSecTA">
    <div class="tg-channel-info">
      <span class="tg-channel-name">AppSECT.A.</span>
      <span class="tg-channel-desc">AppSec · DevSecOps · ИБ</span>
    </div>
    <a href="https://t.me/shmakovis_appsec" class="tg-channel-btn" target="_blank" rel="noopener">Подписаться</a>
  </div>
</div>

<script async
        src="https://telegram.org/js/telegram-widget.js?22"
        data-telegram-post="shmakovis_appsec/61"
        data-width="100%"
        data-userpic="false"
        data-mode="compact"
        data-color="D51A1A"
        data-dark="0"></script>

</div>
</div>

---

<img src="artifacts/assets/logotypemd.jpg" alt="Логотип">
