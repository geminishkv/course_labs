---
title: "Материалы курса AppSec — руководства, шпаргалки, справочники, OWASP Top 10, кейсы"
description: "Все учебные материалы курса AppSec на одной странице: вводные руководства, разборы OWASP Top 10, шпаргалки по Git, Docker, YAML и CI/CD, кейсы и справочники по портам, лицензиям и инструментам."
keywords: "материалы AppSec, OWASP Top 10, шпаргалки DevSecOps, cheatsheet, кейсы ИБ, справочник портов, лицензии ПО, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Материалы</h1>
    <p class="hero-sub">Руководства, шпаргалки, справочники, OWASP Top 10, кейсы и troubleshooting</p>
  </div>
</div>

## Руководства {#guides}

Восемь вводных гайдов: с них начинается курс. Окружение и Git — до Лаб. 01, сети — до Лаб. 03, Docker и Dockerfile — до Лаб. 05, инструменты и CI/CD — до Лаб. 06–09.

<div class="lab-grid">
<a class="lab-card" href="guides/vmbox_tutorial/"><div class="lab-card-body"><div class="lab-card-title">Подготовка рабочего окружения</div><div class="lab-card-tags"><span class="lab-tag">VirtualBox</span><span class="lab-tag">Linux</span><span class="lab-tag">Windows</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="guides/git_setup/"><div class="lab-card-body"><div class="lab-card-title">Настройка Git, GPG и GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">Git</span><span class="lab-tag">SSH</span><span class="lab-tag">GnuPG</span><span class="lab-tag">gh</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="guides/gistup_guide/"><div class="lab-card-body"><div class="lab-card-title">Оформление отчётов gistup</div><div class="lab-card-tags"><span class="lab-tag">Gist</span><span class="lab-tag">Отчёт</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="guides/networking_basics/"><div class="lab-card-body"><div class="lab-card-title">Введение в сети и TCP/IP</div><div class="lab-card-tags"><span class="lab-tag">OSI</span><span class="lab-tag">TCP/IP</span><span class="lab-tag">DNS</span><span class="lab-tag">HTTP</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="guides/docker_basics/"><div class="lab-card-body"><div class="lab-card-title">Основы Docker</div><div class="lab-card-tags"><span class="lab-tag">Docker</span><span class="lab-tag">Dockerfile</span><span class="lab-tag">Compose</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="guides/dockerfile_guide/"><div class="lab-card-body"><div class="lab-card-title">Dockerfile: как устроен и как его писать</div><div class="lab-card-tags"><span class="lab-tag">Dockerfile</span><span class="lab-tag">Кэш сборки</span><span class="lab-tag">CMD</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="guides/cicd_basics/"><div class="lab-card-body"><div class="lab-card-title">Введение в CI/CD</div><div class="lab-card-tags"><span class="lab-tag">GitHub Actions</span><span class="lab-tag">workflow</span><span class="lab-tag">YAML</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="guides/appsec_tools_setup/"><div class="lab-card-body"><div class="lab-card-title">Установка AppSec-инструментов</div><div class="lab-card-tags"><span class="lab-tag">SAST</span><span class="lab-tag">SCA</span><span class="lab-tag">DAST</span><span class="lab-tag">Secrets</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Шпаргалки {#cheatsheets}

<div class="lab-grid">
<a class="lab-card" href="cheatsheet/CHEATSHEET_GIT/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: Git</div><div class="lab-card-tags"><span class="lab-tag">Git</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_GH_CLI/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">gh</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_GITIGNORE/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: .gitignore</div><div class="lab-card-tags"><span class="lab-tag">Шаблоны</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_DOCKER/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: Docker</div><div class="lab-card-tags"><span class="lab-tag">Docker</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_DOCKERFILE_SECURITY/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: Dockerfile Security</div><div class="lab-card-tags"><span class="lab-tag">Hardening</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_DOCKERIGNORE/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: .dockerignore</div><div class="lab-card-tags"><span class="lab-tag">Шаблоны</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_YAML/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: YAML</div><div class="lab-card-tags"><span class="lab-tag">YAML</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_GH_ACTIONS_SECURITY/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: GitHub Actions Security</div><div class="lab-card-tags"><span class="lab-tag">CI/CD</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_LINUX/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: Linux — права и процессы</div><div class="lab-card-tags"><span class="lab-tag">chmod</span><span class="lab-tag">SUID</span><span class="lab-tag">Процессы</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_NMAP/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: Nmap</div><div class="lab-card-tags"><span class="lab-tag">Порты</span><span class="lab-tag">NSE</span><span class="lab-tag">Вывод</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_HTTP_HEADERS/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: HTTP Security Headers</div><div class="lab-card-tags"><span class="lab-tag">CSP</span><span class="lab-tag">HSTS</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Справочники {#reference}

<div class="lab-grid">
<a class="lab-card" href="ports/"><div class="lab-card-body"><div class="lab-card-title">Порты и протоколы</div><div class="lab-card-tags"><span class="lab-tag">TCP</span><span class="lab-tag">UDP</span><span class="lab-tag">Сервисы</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="appsec_tt/"><div class="lab-card-body"><div class="lab-card-title">AppSec Toolchain — классификация инструментов</div><div class="lab-card-tags"><span class="lab-tag">SAST</span><span class="lab-tag">DAST</span><span class="lab-tag">SCA</span><span class="lab-tag">SBOM</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="licenses/"><div class="lab-card-body"><div class="lab-card-title">Лицензии ПО</div><div class="lab-card-tags"><span class="lab-tag">Open Source</span><span class="lab-tag">Проприетарные</span><span class="lab-tag">CC</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="risk_scoring/"><div class="lab-card-body"><div class="lab-card-title">CVSS и реестр рисков</div><div class="lab-card-tags"><span class="lab-tag">CVSS</span><span class="lab-tag">Матрица</span><span class="lab-tag">Реестр</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="findings_triage/"><div class="lab-card-body"><div class="lab-card-title">Разбор находок сканеров</div><div class="lab-card-tags"><span class="lab-tag">Триаж</span><span class="lab-tag">False positive</span><span class="lab-tag">Baseline</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="diagrams_legend/"><div class="lab-card-body"><div class="lab-card-title">Как читать схемы курса</div><div class="lab-card-tags"><span class="lab-tag">ГОСТ 19.701-90</span><span class="lab-tag">Mermaid</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="commands_git/"><div class="lab-card-body"><div class="lab-card-title">Команды: Git</div><div class="lab-card-tags"><span class="lab-tag">HEAD</span><span class="lab-tag">config</span><span class="lab-tag">команды</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="commands_environment/"><div class="lab-card-body"><div class="lab-card-title">Команды: окружение</div><div class="lab-card-tags"><span class="lab-tag">Unix</span><span class="lab-tag">пакеты</span><span class="lab-tag">venv</span><span class="lab-tag">pip</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="commands_docker/"><div class="lab-card-body"><div class="lab-card-title">Команды: Docker</div><div class="lab-card-tags"><span class="lab-tag">Docker</span><span class="lab-tag">CIS Benchmark</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="commands_scanners/"><div class="lab-card-body"><div class="lab-card-title">Команды: сканеры и конвейер</div><div class="lab-card-tags"><span class="lab-tag">Nmap</span><span class="lab-tag">SAST</span><span class="lab-tag">SCA</span><span class="lab-tag">DAST</span><span class="lab-tag">Secrets</span><span class="lab-tag">CI/CD</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="APPENDIX/"><div class="lab-card-body"><div class="lab-card-title">Приложение — справочники команд по темам</div><div class="lab-card-tags"><span class="lab-tag">входная страница</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Угрозы: OWASP Top 10 {#owasp}

<div class="lab-grid">
<a class="lab-card" href="OWASPTOP10/OWASP_Top_10_CICD_Risks/"><div class="lab-card-body"><div class="lab-card-title">CI/CD Risks</div><div class="lab-card-tags"><span class="lab-tag">Pipeline</span><span class="lab-tag">Supply Chain</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/Authentication/"><div class="lab-card-body"><div class="lab-card-title">Authentication</div><div class="lab-card-tags"><span class="lab-tag">Brute Force</span><span class="lab-tag">OTP</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/Authorization/"><div class="lab-card-body"><div class="lab-card-title">Authorization</div><div class="lab-card-tags"><span class="lab-tag">IDOR</span><span class="lab-tag">RBAC</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/client-side-attacks/"><div class="lab-card-body"><div class="lab-card-title">Client-side Attacks</div><div class="lab-card-tags"><span class="lab-tag">XSS</span><span class="lab-tag">CSRF</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/command-execution/"><div class="lab-card-body"><div class="lab-card-title">Command Execution</div><div class="lab-card-tags"><span class="lab-tag">SQLi</span><span class="lab-tag">RCE</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/logical-attacks/"><div class="lab-card-body"><div class="lab-card-title">Logical Attacks</div><div class="lab-card-tags"><span class="lab-tag">Business Logic</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/information-disclosure/"><div class="lab-card-body"><div class="lab-card-title">Information Disclosure</div><div class="lab-card-tags"><span class="lab-tag">Утечки</span><span class="lab-tag">Debug</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Кейсы {#cases}

<div class="lab-grid">
<a class="lab-card" href="examples/exmpl/"><div class="lab-card-body"><div class="lab-card-title">Cases — разбор инцидентов ИБ</div><div class="lab-card-tags"><span class="lab-tag">Кейсы</span><span class="lab-tag">Анализ</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="examples/supply_chain_attacks/"><div class="lab-card-body"><div class="lab-card-title">Supply Chain Attacks</div><div class="lab-card-tags"><span class="lab-tag">SolarWinds</span><span class="lab-tag">Log4Shell</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="examples/PrintNightmare/"><div class="lab-card-body"><div class="lab-card-title">PrintNightmare</div><div class="lab-card-tags"><span class="lab-tag">CVE-2021-34527</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="examples/Multisignature/"><div class="lab-card-body"><div class="lab-card-title">MultiSig — мультиподпись</div><div class="lab-card-tags"><span class="lab-tag">Crypto</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="examples/RA/"><div class="lab-card-body"><div class="lab-card-title">Risk Analysis — пример отчёта</div><div class="lab-card-tags"><span class="lab-tag">RA</span><span class="lab-tag">Template</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Лекции {#lectures}

<div class="lab-grid">
<a class="lab-card" href="lectures/fintech_ru/"><div class="lab-card-body"><div class="lab-card-title">Лекция: Fintech по-русски</div><div class="lab-card-tags"><span class="lab-tag">FinTech</span><span class="lab-tag">ИБ</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Troubleshooting {#troubleshooting}

<div class="lab-grid">
<a class="lab-card" href="troubleshooting/"><div class="lab-card-body"><div class="lab-card-title">Troubleshooting — частые проблемы</div><div class="lab-card-tags"><span class="lab-tag">FAQ</span><span class="lab-tag">Ошибки</span><span class="lab-tag">Решения</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
