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
  <div class="hero-stats" aria-label="Цифры курса">
  <div class="hero-stat"><b>10</b><span>лабораторных</span></div>
  <div class="hero-stat"><b>7</b><span>intro-гайдов</span></div>
  <div class="hero-stat"><b>7</b><span>тестов</span></div>
  <div class="hero-stat"><b>27</b><span>материалов</span></div>
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

<div class="sec-head">
  <h2 id="about">О курсе</h2>
  <span class="sec-note">appsec · devsecops · risk analysis</span>
</div>

<p class="lead">Цель курса — сформировать практические навыки в области AppSec и DevSecOps: от базовой работы с инструментами разработки до построения полноценного конвейера безопасности. Курс охватывает полный цикл безопасной разработки: от первого коммита до автоматизированного сканирования в CI/CD. Каждая лабораторная — самостоятельный мини-проект с реальными инструментами, которые используются в индустрии.</p>

<div class="about-grid">
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

<p class="mats-legend"><span class="mat mat--intro">intro-гайд</span><span class="mat mat--cheat">шпаргалка</span><span class="mat mat--owasp">OWASP</span><span class="mat mat--case">кейс</span><span class="mat mat--ref">справочник</span></p>

<ol class="track">
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
  <div class="stage-node"><div class="stage-head" aria-hidden="true">1</div></div>
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
  <div class="stage-node"><div class="stage-head" aria-hidden="true">2</div></div>
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
  <div class="stage-node"><div class="stage-head" aria-hidden="true">3</div></div>
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
  <div class="stage-node"><div class="stage-head" aria-hidden="true">4</div></div>
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
  <div class="stage-node"><div class="stage-head" aria-hidden="true">5</div></div>
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
  <div class="stage-node"><div class="stage-head" aria-hidden="true">6</div></div>
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
  <span class="sec-note">8 разделов · 27 документов · 7 тестов</span>
</div>

<div class="entries entries--four">
  <a class="entry" href="labs/intro/vmbox_tutorial/"><span class="entry-count">7 гайдов</span><span class="entry-title">Intro</span><span class="entry-text">Окружение, Git и GPG, отчёты в Gist, сети, Docker, CI/CD, AppSec-инструменты.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="labs/tests/basic/test01/"><span class="entry-count">5 + 2 варианта</span><span class="entry-title">Тесты</span><span class="entry-text">Пять базовых вариантов по лабам и два лекционных теста по Fintech.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/OWASPTOP10/Authentication/"><span class="entry-count">7 разборов</span><span class="entry-title">OWASP Top 10</span><span class="entry-text">Authentication, Authorization, Client-side, Command Execution, Logical, Information Disclosure, CI/CD Risks.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/examples/exmpl/"><span class="entry-count">5 кейсов</span><span class="entry-title">Примеры</span><span class="entry-text">Инциденты ИБ, Supply Chain Attacks, PrintNightmare, MultiSig, пример Risk Analysis.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/cheatsheet/CHEATSHEET_GIT/"><span class="entry-count">9 шпаргалок</span><span class="entry-title">CheatSheets</span><span class="entry-text">Git, Docker, YAML, HTTP Headers, Dockerfile Security, GitHub Actions Security, gh, .gitignore, .dockerignore.</span><span class="entry-link">Открыть →</span></a>
  <a class="entry" href="materials/appsec_tt/"><span class="entry-count">4 справочника</span><span class="entry-title">Справочники</span><span class="entry-text">AppSec Toolchain, порты и протоколы, лицензии ПО, приложение с командами и утилитами.</span><span class="entry-link">Открыть →</span></a>
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
