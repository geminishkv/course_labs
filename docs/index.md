---
hide:
  - toc

title: "Курс AppSec — практическая безопасность приложений и DevSecOps"
description: "Курс AppSec: лабораторные работы по безопасности приложений — OWASP Top 10, SAST, DAST, SCA, Docker, CI/CD и анализ рисков ИБ."
keywords: "AppSec, курс AppSec, DevSecOps, безопасность приложений, лабораторные работы, OWASP Top 10, SAST, DAST, SCA, Docker, CI/CD, GitHub Actions, анализ рисков, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="no-section-nums" markdown="1">

<div class="hero-section">
  <a href="https://geminishkv.tech/" target="_blank" rel="noopener noreferrer" class="hero-logo-wrap">
  <img src="artifacts/assets/logo_white.svg" class="hero-logo" alt="AppSecTA">
  </a>
  <div class="hero-content">
  <h1 class="hero-title">Application Security & DevSecOps Course</h1>
  <p class="hero-sub">Практический курс по прикладной безопасности приложений: от первого коммита до конвейера безопасности</p>
  <p class="hero-typewriter" id="typewriter-target"></p>
  <div class="hero-cta">
  <a class="btn btn-primary" href="labs/intro/vmbox_tutorial/">Начать с Intro</a>
  <a class="btn btn-ghost" href="#pipeline">Смотреть конвейер</a>
  </div>
  <div class="hero-stats" aria-label="Цифры курса">
  <div class="hero-stat"><b>10</b><span>лабораторных</span></div>
  <div class="hero-stat"><b>7</b><span>intro-гайдов</span></div>
  <div class="hero-stat"><b>7</b><span>тестов</span></div>
  <div class="hero-stat"><b>27</b><span>материалов</span></div>
  </div>
  </div>
</div>

## Конвейер курса { #pipeline }

<p class="lead">Каждый этап — узел конвейера безопасности. Лабы идут по порядку: открывай узел, делай работу, двигайся дальше по линии.</p>

<ol class="track">
  <li class="stage">
  <div class="stage-head" aria-hidden="true">1</div>
  <div class="stage-name">Основы</div>
  <div class="stage-cmd">git · linux · nmap</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab01/"><span class="lab-num">01</span><span class="lab-name">GitSCM — рабочее окружение</span><span class="lab-tags">Git</span></a>
  <a class="lab" href="labs/basic/lab02/"><span class="lab-num">02</span><span class="lab-name">*nix — права, SUID, ACL, процессы</span><span class="lab-tags">Linux · Bash · ACL</span></a>
  <a class="lab" href="labs/basic/lab03/"><span class="lab-num">03</span><span class="lab-name">Nmap — сканирование сети и NSE</span><span class="lab-tags">Nmap · NSE</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-head" aria-hidden="true">2</div>
  <div class="stage-name">Риски</div>
  <div class="stage-cmd">threat model</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab04/"><span class="lab-num">04</span><span class="lab-name">Анализ и меры снижения рисков ИБ</span><span class="lab-tags">Risk Analysis</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-head" aria-hidden="true">3</div>
  <div class="stage-name">Контейнеры</div>
  <div class="stage-cmd">docker · cis · trivy</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab05/"><span class="lab-num">05</span><span class="lab-name">Docker — контейнеризация приложений</span><span class="lab-tags">Docker</span></a>
  <a class="lab" href="labs/basic/lab06/"><span class="lab-num">06</span><span class="lab-name">Docker CIS Benchmark и Trivy</span><span class="lab-tags">CIS · Trivy</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-head" aria-hidden="true">4</div>
  <div class="stage-name">Код и приложение</div>
  <div class="stage-cmd">sast · sca · dast</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab07/"><span class="lab-num">07</span><span class="lab-name">SAST, SCA и Secret Detection</span><span class="lab-tags">Semgrep · Checkov · Gitleaks</span></a>
  <a class="lab" href="labs/basic/lab08/"><span class="lab-num">08</span><span class="lab-name">DAST уязвимого приложения</span><span class="lab-tags">OWASP ZAP</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-head" aria-hidden="true">5</div>
  <div class="stage-name">Конвейер</div>
  <div class="stage-cmd">github actions</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab09/"><span class="lab-num">09</span><span class="lab-name">DevSecOps CI/CD на GitHub Actions</span><span class="lab-tags">Semgrep · Trivy · ZAP</span></a>
  </div>
  </li>
  <li class="stage">
  <div class="stage-head" aria-hidden="true">6</div>
  <div class="stage-name">Итог</div>
  <div class="stage-cmd">risk assessment · pet</div>
  <div class="stage-labs">
  <a class="lab" href="labs/basic/lab10/"><span class="lab-num">10</span><span class="lab-name">Оценка анализа рисков ИБ — практика</span><span class="lab-tags">Risk Analysis</span></a>
  <a class="lab lab--gold" href="labs/pet_project/"><span class="lab-num">pet</span><span class="lab-name">Pet-project — полный AppSec/DevSecOps стек</span><span class="lab-tags">Full stack</span></a>
  </div>
  </li>
</ol>

## Куда дальше

<div class="entries">
  <a class="entry" href="labs/intro/vmbox_tutorial/">
  <span class="entry-count">7 гайдов</span>
  <span class="entry-title">Intro</span>
  <span class="entry-text">Окружение, Git и GPG, отчёты в Gist, сети, Docker, CI/CD, установка AppSec-инструментов.</span>
  <span class="entry-link">Открыть →</span>
  </a>
  <a class="entry" href="labs/tests/basic/test01/">
  <span class="entry-count">5 + 2 варианта</span>
  <span class="entry-title">Тесты</span>
  <span class="entry-text">Пять базовых вариантов по лабам и два лекционных теста по Fintech.</span>
  <span class="entry-link">Открыть →</span>
  </a>
  <a class="entry" href="materials/">
  <span class="entry-count">27 материалов</span>
  <span class="entry-title">Материалы</span>
  <span class="entry-text">OWASP Top 10, шпаргалки, кейсы, справочники портов и инструментов, troubleshooting.</span>
  <span class="entry-link">Открыть →</span>
  </a>
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
