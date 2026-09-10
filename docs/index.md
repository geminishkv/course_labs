---
template: home.html
hide:
  - navigation
  - toc

title: "Курс AppSec — практическая безопасность приложений и DevSecOps"
description: "Курс AppSec: лабораторные работы по безопасности приложений — OWASP Top 10, SAST, DAST, SCA, Docker, CI/CD и анализ рисков ИБ."
keywords: "AppSec, курс AppSec, DevSecOps, безопасность приложений, лабораторные работы, OWASP Top 10, SAST, DAST, SCA, Docker, CI/CD, GitHub Actions, анализ рисков, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="no-section-nums" markdown="1">

<div class="hero-row">
<div class="hero-section hero-section--home">
  <div class="hero-content">
  <p class="hero-eyebrow">МГТУ · МФТИ · AppSecTA</p>
  <h1 class="hero-title">Application Security & DevSecOps Course</h1>
  <p class="hero-sub">Практический курс по прикладной безопасности приложений: от первого коммита до конвейера безопасности</p>
  <p class="hero-typewriter" id="typewriter-target"></p>
  <div class="hero-cta">
  <a class="btn btn-primary" href="labs/intro/vmbox_tutorial/">Начать с Intro</a>
  <a class="btn btn-ghost" href="#pipeline">Смотреть конвейер</a>
  </div>
  </div>
  <div class="hero-side">
  <div class="hero-stats" role="group" aria-label="Цифры курса">
  <div class="hero-stat"><b>{{ stats.labs }}</b><span>лабораторных</span></div>
  <div class="hero-stat"><b>{{ stats.intro }}</b><span>intro-гайдов</span></div>
  <div class="hero-stat"><b>{{ stats.tests }}</b><span>тестов</span></div>
  <div class="hero-stat"><b>{{ stats.materials }}</b><span>материалов</span></div>
  </div>
  <div class="hero-contacts">
  <span class="hero-contacts__label">Контакты</span>
  <div class="hero-contacts__row">
  <a href="https://t.me/geminishkv" target="_blank" rel="noopener" class="contact-btn contact-btn--telegram"><span class="contact-btn__avatar-inner"><span class="contact-btn__status"></span><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M11.944 0A12 12 0 0 0 0 12a12 12 0 0 0 12 12 12 12 0 0 0 12-12A12 12 0 0 0 12 0a12 12 0 0 0-.056 0zm4.962 7.224c.1-.002.321.023.465.14a.506.506 0 0 1 .171.325c.016.093.036.306.02.472-.18 1.898-.962 6.502-1.36 8.627-.168.9-.499 1.201-.82 1.23-.696.065-1.225-.46-1.9-.902-1.056-.693-1.653-1.124-2.678-1.8-1.185-.78-.417-1.21.258-1.91.177-.184 3.247-2.977 3.307-3.23.007-.032.014-.15-.056-.212s-.174-.041-.249-.024c-.106.024-1.793 1.14-5.061 3.345-.479.33-.913.49-1.302.48-.428-.008-1.252-.241-1.865-.44-.752-.245-1.349-.374-1.297-.789.027-.216.325-.437.893-.663 3.498-1.524 5.83-2.529 6.998-3.014 3.332-1.386 4.025-1.627 4.476-1.635z"></path></svg></span><span class="contact-btn__label">Telegram</span></a>
  <a href="mailto:shmakovis@inbox.ru" class="contact-btn"><span class="contact-btn__avatar-inner"><span class="contact-btn__status"></span><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6l8 5 8-5v2z"></path></svg></span><span class="contact-btn__label">Email</span></a>
  <a href="https://www.linkedin.com/in/geminishkvdev/" target="_blank" rel="noopener" class="social-icon social-icon--linkedin" aria-label="LinkedIn"><svg class="social-icon__svg" viewBox="0 0 448 512" aria-hidden="true"><path d="M100.28 448H7.4V148.9h92.88zM53.79 108.1C24.09 108.1 0 83.5 0 53.8a53.79 53.79 0 0 1 107.58 0c0 29.7-24.1 54.3-53.79 54.3zM447.9 448h-92.68V302.4c0-34.7-.7-79.2-48.29-79.2-48.29 0-55.69 37.7-55.69 76.7V448h-92.78V148.9h89.08v40.8h1.3c12.4-23.5 42.69-48.3 87.88-48.3 94 0 111.28 61.9 111.28 142.3V448z"></path></svg></a>
  <a href="https://www.instagram.com/geminishkv" target="_blank" rel="noopener" class="social-icon social-icon--instagram" aria-label="Instagram"><svg class="social-icon__svg" viewBox="0 0 16 16" aria-hidden="true"><path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z"></path></svg></a>
  </div>
  </div>
  </div>
</div>
<div class="brand-col" aria-hidden="true">
  <div class="brand-col__shapes">
  <div class="brand-col__circle brand-col__circle--gradient logo-glow logo-glow--brand">
  <span class="logo-glow__blur logo-glow__blur--1"></span>
  <span class="logo-glow__blur logo-glow__blur--2"></span>
  <div class="logo-glow__inner"><img src="artifacts/assets/logo_black.svg" alt="" class="brand-col__logo-img"></div>
  </div>
  <div class="brand-col__diamond-wrap"><div class="brand-col__diamond"><span class="brand-col__num">0</span></div></div>
  <div class="brand-col__circle brand-col__circle--outline"><span class="brand-col__num brand-col__num--dark">1</span></div>
  </div>
  <div class="spm-pill"><span class="spm-pill__text">Sic Parvis Magna</span></div>
</div>
</div>

<div class="badges" aria-label="Статус проекта и стек">
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
  <img src="https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white" alt="Python">
  <img src="https://img.shields.io/badge/Checkov-333333?style=flat" alt="Checkov">
  <img src="https://img.shields.io/badge/Gitleaks-333333?style=flat" alt="Gitleaks">
  <img src="https://img.shields.io/badge/Bandit-333333?style=flat" alt="Bandit">
</div>

<div class="sec-head">
  <h2 id="about">О курсе</h2>
  <span class="sec-note">appsec · devsecops · risk analysis</span>
</div>

<div class="about-grid">
  <section class="about-card">
  <h3>Цель курса</h3>
  <p>Сформировать практические навыки в области AppSec и DevSecOps: от базовой работы с инструментами разработки до построения полноценного конвейера безопасности.</p>
  <p>Курс охватывает полный цикл безопасной разработки: от первого коммита до автоматизированного сканирования в CI/CD. Каждая лабораторная — самостоятельный мини-проект с реальными инструментами, которые используются в индустрии.</p>
  </section>
  <section class="about-card">
  <h3>Что изучаем</h3>
  <ul>
  <li><b>Инфраструктура:</b> <code>git</code>, <code>CI/CD</code>, <code>Docker</code>, <code>Packages</code>, <code>YAML</code></li>
  <li><b>Языки:</b> <code>Python</code>, <code>Shell</code> (<code>Java</code> и <code>Go</code> — в контексте SCA и анализа зависимостей)</li>
  <li><b>Безопасность:</b> SAST, SCA, Container Security, DAST, Secret Detection</li>
  <li><b>Анализ рисков:</b> оценка, приоритизация, стратегии снижения рисков ИБ</li>
  </ul>
  </section>
  <section class="about-card">
  <h3>Как устроен курс</h3>
  <ul>
  <li>10 лабораторных работ + итоговый pet-project</li>
  <li>Каждый мини-проект размещается на <code>GitHub</code> с отчётом в формате <code>gistup</code></li>
  <li>Для каждой лабораторной — отдельный репозиторий (или <code>fork</code>), исходный код + отчёт</li>
  <li>Прогрессия: <code>Git</code> → <code>Linux</code> → <code>Nmap</code> → <code>Risk Analysis</code> → <code>Docker</code> → <code>CIS Benchmark</code> → <code>SAST/SCA</code> → <code>DAST</code> → <code>CI/CD</code> → <code>Итоговый Risk Analysis</code> → <code>Pet-project</code></li>
  </ul>
  </section>
</div>

<div class="sec-head">
  <h2 id="pipeline">Конвейер курса</h2>
  <span class="sec-note">лабы идут по порядку · 01 → 10 → pet</span>
</div>

<p class="lead">Каждый этап — узел конвейера безопасности. Над узлом — сопроводительные материалы к этапу, под узлом — лабы. Открывай узел, делай работу, двигайся дальше по линии.</p>

<ol class="steps">
  <li><span class="steps__n">1</span><span>Изучи <a href="materials/">материалы</a> и <a href="materials/examples/exmpl/">примеры</a></span></li>
  <li><span class="steps__n">2</span><span>Заведи репозиторий с обвязкой: <code>.gitignore</code>, <code>CODE_OF_CONDUCT</code>, <code>CONTRIBUTING</code>, <code>LICENSE</code>, <code>NOTICE</code>, <code>SECURITY</code></span></li>
  <li><span class="steps__n">3</span><span>Пройди лабораторные по порядку — от Lab 01 до Lab 10</span></li>
  <li><span class="steps__n">4</span><span>Итог — <a href="labs/pet_project/">pet-project</a>: тема согласуется с преподавателем, применяется весь стек AppSec/DevSecOps</span></li>
</ol>

<p class="steps__foot">Лицензию при переиспользовании материалов подбирай по <a href="materials/licenses/">справочнику лицензий</a> · <a href="https://gist.github.com/MishaBary/21ab63f83292a86268e039d484a86411" target="_blank" rel="noopener">пример gistup-отчёта</a> — шаблон для всех работ</p>

<ol class="track" role="list">
  <li class="stage">
  <div class="stage-mats">
    <a class="mat mat--intro" href="labs/intro/vmbox_tutorial/">Окружение: VirtualBox, Linux</a>
  <a class="mat mat--intro" href="labs/intro/git_setup/">Git, GPG, gh</a>
  <a class="mat mat--intro" href="labs/intro/gistup_guide/">Отчёты gistup</a>
  <a class="mat mat--intro" href="labs/intro/networking_basics/">Сети и TCP/IP</a>
  <a class="mat mat--cheat" href="materials/cheatsheet/CHEATSHEET_GIT/">Git</a>
  <a class="mat mat--cheat" href="materials/cheatsheet/CHEATSHEET_GITIGNORE/">.gitignore</a>
  <a class="mat mat--ref" href="materials/ports/">Порты и протоколы</a>
  </div>
  <div class="stage-node"><div class="stage-head">1</div></div>
  <div class="stage-name">Основы</div>
  <div class="stage-cmd">git · linux · nmap</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab01/"><span class="lab-num">01</span><span class="lab-name">GitSCM — рабочее окружение</span><span class="lab-tags">Git</span></a>
  <a class="lab" href="labs/basic/lab02/"><span class="lab-num">02</span><span class="lab-name">*nix — права, SUID, ACL, процессы</span><span class="lab-tags">Linux · Bash · ACL</span></a>
  <a class="lab" href="labs/basic/lab03/"><span class="lab-num">03</span><span class="lab-name">Nmap — сканирование сети и NSE</span><span class="lab-tags">Nmap · NSE</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-mats">
    <a class="mat mat--case" href="materials/examples/RA/">Risk Analysis — пример отчёта</a>
  <a class="mat mat--case" href="materials/examples/exmpl/">Cases — инциденты ИБ</a>
  </div>
  <div class="stage-node"><div class="stage-head">2</div></div>
  <div class="stage-name">Риски</div>
  <div class="stage-cmd">threat model</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab04/"><span class="lab-num">04</span><span class="lab-name">Анализ и меры снижения рисков ИБ</span><span class="lab-tags">Risk Analysis</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-mats">
    <a class="mat mat--intro" href="labs/intro/docker_basics/">Основы Docker</a>
  <a class="mat mat--cheat" href="materials/cheatsheet/CHEATSHEET_DOCKER/">Docker</a>
  <a class="mat mat--cheat" href="materials/cheatsheet/CHEATSHEET_DOCKERFILE_SECURITY/">Dockerfile Security</a>
  <a class="mat mat--cheat" href="materials/cheatsheet/CHEATSHEET_DOCKERIGNORE/">.dockerignore</a>
  </div>
  <div class="stage-node"><div class="stage-head">3</div></div>
  <div class="stage-name">Контейнеры</div>
  <div class="stage-cmd">docker · cis · trivy</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab05/"><span class="lab-num">05</span><span class="lab-name">Docker — контейнеризация приложений</span><span class="lab-tags">Docker</span></a>
  <a class="lab" href="labs/basic/lab06/"><span class="lab-num">06</span><span class="lab-name">Docker CIS Benchmark и Trivy</span><span class="lab-tags">CIS · Trivy</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-mats">
    <a class="mat mat--intro" href="labs/intro/appsec_tools_setup/">AppSec-инструменты</a>
  <a class="mat mat--owasp" href="materials/OWASPTOP10/Authentication/">OWASP Top 10</a>
  <a class="mat mat--cheat" href="materials/cheatsheet/CHEATSHEET_HTTP_HEADERS/">HTTP Security Headers</a>
  <a class="mat mat--case" href="materials/examples/supply_chain_attacks/">Supply Chain Attacks</a>
  <a class="mat mat--case" href="materials/examples/PrintNightmare/">PrintNightmare</a>
  </div>
  <div class="stage-node"><div class="stage-head">4</div></div>
  <div class="stage-name">Код и приложение</div>
  <div class="stage-cmd">sast · sca · dast</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab07/"><span class="lab-num">07</span><span class="lab-name">SAST, SCA и Secret Detection</span><span class="lab-tags">Semgrep · Checkov · Gitleaks</span></a>
  <a class="lab" href="labs/basic/lab08/"><span class="lab-num">08</span><span class="lab-name">DAST уязвимого приложения</span><span class="lab-tags">OWASP ZAP</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-mats">
    <a class="mat mat--intro" href="labs/intro/cicd_basics/">CI/CD и GitHub Actions</a>
  <a class="mat mat--cheat" href="materials/cheatsheet/CHEATSHEET_YAML/">YAML</a>
  <a class="mat mat--cheat" href="materials/cheatsheet/CHEATSHEET_GH_ACTIONS_SECURITY/">GitHub Actions Security</a>
  <a class="mat mat--owasp" href="materials/OWASPTOP10/OWASP_Top_10_CICD_Risks/">OWASP CI/CD Risks</a>
  </div>
  <div class="stage-node"><div class="stage-head">5</div></div>
  <div class="stage-name">Конвейер</div>
  <div class="stage-cmd">github actions</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab09/"><span class="lab-num">09</span><span class="lab-name">DevSecOps CI/CD на GitHub Actions</span><span class="lab-tags">Semgrep · Trivy · ZAP</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-mats">
    <a class="mat mat--ref" href="materials/appsec_tt/">AppSec Toolchain</a>
  <a class="mat mat--ref" href="materials/licenses/">Лицензии ПО</a>
  <a class="mat mat--ref" href="materials/troubleshooting/">Troubleshooting</a>
  <a class="mat mat--case" href="materials/examples/Multisignature/">MultiSig</a>
  <a class="mat mat--ref" href="materials/lectures/fintech_ru/">Лекция: Fintech</a>
  </div>
  <div class="stage-node"><div class="stage-head">6</div></div>
  <div class="stage-name">Итог</div>
  <div class="stage-cmd">risk assessment · pet</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab10/"><span class="lab-num">10</span><span class="lab-name">Оценка анализа рисков ИБ — практика</span><span class="lab-tags">Risk Analysis</span></a>
  <a class="lab lab--gold" href="labs/pet_project/"><span class="lab-num">pet</span><span class="lab-name">Pet-project — полный AppSec/DevSecOps стек</span><span class="lab-tags">Full stack</span></a>
  </div>
  </li>
</ol>

<div class="rules-grid">
  <section class="rules-card">
  <h3>Формализованные требования</h3>
  <ul class="checks">
  <li>Единый стиль кода, функции в пространстве имён</li>
  <li><code>README.md</code> оформлен в соответствии с содержанием проекта</li>
  <li><code>.gitignore</code> и <code>.dockerignore</code> настроены под проект</li>
  <li>Лицензия (<code>LICENSE</code>) и <code>NOTICE</code> подобраны корректно</li>
  <li>Скрипты автоматизации сборки, тестов и пакетирования</li>
  <li>Непрерывная сборка через <code>GitHub Actions</code></li>
  <li>Документация проекта через <code>doxygen</code></li>
  <li>Публикация пакета на <code>GitHub Releases</code> при слиянии в <code>develop</code></li>
  <li>Рефакторинг и поддержка лабораторных в процессе работы</li>
  <li>Все команды — строго из терминала, без <code>WebUI</code> (кроме токенов и специфичных настроек)</li>
  </ul>
  </section>
  <section class="rules-card">
  <h3>Замечания</h3>
  <ol class="notes">
  <li>Лабораторные обязательны для всех — вне зависимости от уровня подготовки</li>
  <li>Скопируй этапы реализации и отмечай выполненные у себя</li>
  <li>Каждая работа разбивается на атомарные коммиты для трекинга изменений</li>
  <li>Отчёт сдаётся индивидуально с защитой: каждая команда — с описанием, флагами и выводом из терминала</li>
  <li>Часть инструментов требует установки дополнительных <code>open-source</code> пакетов</li>
  <li>В отчётах — вывод из консоли, не скриншоты; описание каждого флага и команды</li>
  </ol>
  </section>
</div>

<div class="sec-head">
  <h2 id="materials">Материалы</h2>
  <span class="sec-note">9 разделов · {{ stats.materials }} документов · {{ stats.tests }} тестов</span>
</div>

<div class="entries">
  <a class="entry" href="labs/intro/vmbox_tutorial/"><span class="entry-count">7 гайдов</span><span class="entry-title">Intro</span><span class="entry-text">Окружение, Git и GPG, отчёты в Gist, сети, Docker, CI/CD, AppSec-инструменты.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="labs/tests/basic/test01/"><span class="entry-count">5 + 2 варианта</span><span class="entry-title">Тесты</span><span class="entry-text">Пять базовых вариантов по лабам и два лекционных теста по Fintech.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/OWASPTOP10/Authentication/"><span class="entry-count">7 разборов</span><span class="entry-title">OWASP Top 10</span><span class="entry-text">Authentication, Authorization, Client-side, Command Execution, Logical, Information Disclosure, CI/CD Risks.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/examples/exmpl/"><span class="entry-count">5 кейсов</span><span class="entry-title">Примеры</span><span class="entry-text">Инциденты ИБ, Supply Chain Attacks, PrintNightmare, MultiSig, пример Risk Analysis.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/cheatsheet/CHEATSHEET_GIT/"><span class="entry-count">9 шпаргалок</span><span class="entry-title">CheatSheets</span><span class="entry-text">Git, Docker, YAML, HTTP Headers, Dockerfile Security, GitHub Actions Security, gh, .gitignore, .dockerignore.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/appsec_tt/"><span class="entry-count">3 справочника</span><span class="entry-title">Справочники</span><span class="entry-text">AppSec Toolchain, порты и протоколы, приложение с командами и утилитами.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/licenses/"><span class="entry-count">справочник</span><span class="entry-title">Лицензии ПО</span><span class="entry-text">Какую лицензию выбрать для репозитория и как переиспользовать чужие материалы без нарушений.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/troubleshooting/"><span class="entry-count">45 карточек</span><span class="entry-title">Troubleshooting</span><span class="entry-text">Частые проблемы по 13 темам: окружение, Git, Docker, сканеры, CI/CD.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/lectures/fintech_ru/"><span class="entry-count">1 лекция</span><span class="entry-title">Fintech по-русски</span><span class="entry-text">Лекция о безопасности финтеха и два кейсовых теста к ней.</span><span class="entry-link">Открыть →</span></a>
</div>

<div class="tg-strip">
  <div class="tg-strip__left">
  <img src="artifacts/assets/logo_white.svg" class="tg-strip__logo" alt="AppSecTA">
  <div>
  <div class="tg-strip__name">Канал AppSECT.A.</div>
  <div class="tg-strip__desc">AppSec · DevSecOps · ИБ — практика без воды и купюр.</div>
  </div>
  </div>
  <a class="btn btn-primary" href="https://t.me/appsecta" target="_blank" rel="noopener">Подписаться</a>
</div>

</div>
