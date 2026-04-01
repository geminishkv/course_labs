---
hide:
  - toc

title: Введение в курс AppSec
description: Практический курс по прикладной безопасности приложений — лабораторные работы, AppSec, DevSecOps, OWASP Top 10.
keywords: "AppSec, DevSecOps, лабораторные работы, OWASP, безопасность приложений, SAST, DAST, Docker, GitHub Actions"
---

<div class="hero-section">
  <img src="artifacts/assets/logo.svg" class="hero-logo" alt="AppSecTA">
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

## WHOA!

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

<div class="lab-grid">
<a class="lab-card" href="labs/basic/lab01/"><div class="lab-card-num">01</div><div class="lab-card-body"><div class="lab-card-title">GitSCM — подготовка рабочего окружения</div><div class="lab-card-tags"><span class="lab-tag">Git</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab02/"><div class="lab-card-num">02</div><div class="lab-card-body"><div class="lab-card-title">*nix — права доступа, управление процессами</div><div class="lab-card-tags"><span class="lab-tag">Linux</span><span class="lab-tag">Bash</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab03/"><div class="lab-card-num">03</div><div class="lab-card-body"><div class="lab-card-title">Nmap — сканирование сети и анализ уязвимостей</div><div class="lab-card-tags"><span class="lab-tag">Nmap</span><span class="lab-tag">Linux</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab04/"><div class="lab-card-num">04</div><div class="lab-card-body"><div class="lab-card-title">Анализ и определение мер снижения рисков ИБ</div><div class="lab-card-tags"><span class="lab-tag">Risk Analysis</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab05/"><div class="lab-card-num">05</div><div class="lab-card-body"><div class="lab-card-title">Docker — контейнеризация приложений</div><div class="lab-card-tags"><span class="lab-tag">Docker</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab06/"><div class="lab-card-num">06</div><div class="lab-card-body"><div class="lab-card-title">Docker CIS Benchmark — аудит Docker-хоста</div><div class="lab-card-tags"><span class="lab-tag">Docker</span><span class="lab-tag">CIS</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab07/"><div class="lab-card-num">07</div><div class="lab-card-body"><div class="lab-card-title">SAST и SCA — статический анализ и зависимости</div><div class="lab-card-tags"><span class="lab-tag">Semgrep</span><span class="lab-tag">Checkov</span><span class="lab-tag">OWASP DC</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab08/"><div class="lab-card-num">08</div><div class="lab-card-body"><div class="lab-card-title">DAST — динамическое тестирование уязвимого приложения</div><div class="lab-card-tags"><span class="lab-tag">OWASP ZAP</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab09/"><div class="lab-card-num">09</div><div class="lab-card-body"><div class="lab-card-title">DevSecOps CI/CD конвейер на GitHub Actions</div><div class="lab-card-tags"><span class="lab-tag">GH Actions</span><span class="lab-tag">Semgrep</span><span class="lab-tag">Trivy</span><span class="lab-tag">ZAP</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="labs/basic/lab10/"><div class="lab-card-num">10</div><div class="lab-card-body"><div class="lab-card-title">Оценка анализа рисков ИБ — практика</div><div class="lab-card-tags"><span class="lab-tag">Risk Analysis</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card lab-card--pet" href="labs/pet_project/"><div class="lab-card-num">pet</div><div class="lab-card-body"><div class="lab-card-title">Pet-project — итоговая работа, полный AppSec/DevSecOps стек</div><div class="lab-card-tags"><span class="lab-tag">Full stack</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

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
    <img src="artifacts/assets/logo.svg" class="tg-channel-logo" alt="AppSecTA">
    <div class="tg-channel-info">
      <span class="tg-channel-name">AppSECT.A.</span>
      <span class="tg-channel-desc">AppSec · DevSecOps · ИБ</span>
    </div>
    <a href="https://t.me/shmakovis_appsec" class="tg-channel-btn" target="_blank" rel="noopener">Подписаться</a>
  </div>
</div>

<div class="tg-embed-desktop">
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
</div>

---

<img src="artifacts/assets/logotypemd.jpg" alt="Логотип">
