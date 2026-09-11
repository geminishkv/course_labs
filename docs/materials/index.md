---
title: "Материалы курса AppSec — OWASP Top 10, шпаргалки, кейсы, справочники"
description: "Все учебные материалы курса AppSec на одной странице: разборы OWASP Top 10, шпаргалки по Git, Docker, YAML и CI/CD, кейсы и справочники по портам, лицензиям и инструментам."
keywords: "материалы AppSec, OWASP Top 10, шпаргалки DevSecOps, cheatsheet, кейсы ИБ, справочник портов, лицензии ПО, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Материалы</h1>
    <p class="hero-sub">OWASP Top 10, шпаргалки, кейсы, справочники и troubleshooting</p>
  </div>
</div>

## OWASP Top 10

<div class="lab-grid">
<a class="lab-card" href="OWASPTOP10/OWASP_Top_10_CICD_Risks/"><div class="lab-card-body"><div class="lab-card-title">CI/CD Risks</div><div class="lab-card-tags"><span class="lab-tag">Pipeline</span><span class="lab-tag">Supply Chain</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/Authentication/"><div class="lab-card-body"><div class="lab-card-title">Authentication</div><div class="lab-card-tags"><span class="lab-tag">Brute Force</span><span class="lab-tag">OTP</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/Authorization/"><div class="lab-card-body"><div class="lab-card-title">Authorization</div><div class="lab-card-tags"><span class="lab-tag">IDOR</span><span class="lab-tag">RBAC</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/client-side-attacks/"><div class="lab-card-body"><div class="lab-card-title">Client-side Attacks</div><div class="lab-card-tags"><span class="lab-tag">XSS</span><span class="lab-tag">CSRF</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/command-execution/"><div class="lab-card-body"><div class="lab-card-title">Command Execution</div><div class="lab-card-tags"><span class="lab-tag">SQLi</span><span class="lab-tag">RCE</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/logical-attacks/"><div class="lab-card-body"><div class="lab-card-title">Logical Attacks</div><div class="lab-card-tags"><span class="lab-tag">Business Logic</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="OWASPTOP10/information-disclosure/"><div class="lab-card-body"><div class="lab-card-title">Information Disclosure</div><div class="lab-card-tags"><span class="lab-tag">Утечки</span><span class="lab-tag">Debug</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Примеры и кейсы

<div class="lab-grid">
<a class="lab-card" href="examples/exmpl/"><div class="lab-card-body"><div class="lab-card-title">Cases — разбор инцидентов ИБ</div><div class="lab-card-tags"><span class="lab-tag">Кейсы</span><span class="lab-tag">Анализ</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="examples/supply_chain_attacks/"><div class="lab-card-body"><div class="lab-card-title">Supply Chain Attacks</div><div class="lab-card-tags"><span class="lab-tag">SolarWinds</span><span class="lab-tag">Log4Shell</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="examples/PrintNightmare/"><div class="lab-card-body"><div class="lab-card-title">PrintNightmare</div><div class="lab-card-tags"><span class="lab-tag">CVE-2021-34527</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="examples/Multisignature/"><div class="lab-card-body"><div class="lab-card-title">MultiSig — мультиподпись</div><div class="lab-card-tags"><span class="lab-tag">Crypto</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="examples/RA/"><div class="lab-card-body"><div class="lab-card-title">Risk Analysis — пример отчёта</div><div class="lab-card-tags"><span class="lab-tag">RA</span><span class="lab-tag">Template</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Справочники и шпаргалки

<div class="lab-grid">
<a class="lab-card" href="appsec_tt/"><div class="lab-card-body"><div class="lab-card-title">AppSec Toolchain — классификация инструментов</div><div class="lab-card-tags"><span class="lab-tag">SAST</span><span class="lab-tag">DAST</span><span class="lab-tag">SCA</span><span class="lab-tag">SBOM</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="ports/"><div class="lab-card-body"><div class="lab-card-title">Порты и протоколы</div><div class="lab-card-tags"><span class="lab-tag">TCP</span><span class="lab-tag">UDP</span><span class="lab-tag">Сервисы</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="licenses/"><div class="lab-card-body"><div class="lab-card-title">Лицензии ПО</div><div class="lab-card-tags"><span class="lab-tag">Open Source</span><span class="lab-tag">Проприетарные</span><span class="lab-tag">CC</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_GIT/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: Git</div><div class="lab-card-tags"><span class="lab-tag">Git</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_DOCKER/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: Docker</div><div class="lab-card-tags"><span class="lab-tag">Docker</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_YAML/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: YAML</div><div class="lab-card-tags"><span class="lab-tag">YAML</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_HTTP_HEADERS/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: HTTP Security Headers</div><div class="lab-card-tags"><span class="lab-tag">CSP</span><span class="lab-tag">HSTS</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_DOCKERFILE_SECURITY/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: Dockerfile Security</div><div class="lab-card-tags"><span class="lab-tag">Hardening</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_GH_ACTIONS_SECURITY/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: GitHub Actions Security</div><div class="lab-card-tags"><span class="lab-tag">CI/CD</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_GH_CLI/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">gh</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_GITIGNORE/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: .gitignore</div><div class="lab-card-tags"><span class="lab-tag">Шаблоны</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="cheatsheet/CHEATSHEET_DOCKERIGNORE/"><div class="lab-card-body"><div class="lab-card-title">CheatSheet: .dockerignore</div><div class="lab-card-tags"><span class="lab-tag">Шаблоны</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="APPENDIX/"><div class="lab-card-body"><div class="lab-card-title">Приложение — команды и утилиты</div><div class="lab-card-tags"><span class="lab-tag">Git</span><span class="lab-tag">Docker</span><span class="lab-tag">Nmap</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="lectures/fintech_ru/"><div class="lab-card-body"><div class="lab-card-title">Лекция: Fintech по-русски</div><div class="lab-card-tags"><span class="lab-tag">FinTech</span><span class="lab-tag">ИБ</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="troubleshooting/"><div class="lab-card-body"><div class="lab-card-title">Troubleshooting — частые проблемы</div><div class="lab-card-tags"><span class="lab-tag">FAQ</span><span class="lab-tag">Ошибки</span><span class="lab-tag">Решения</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
