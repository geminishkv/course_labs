---
hide:
  - toc

title: "Docker: команды и CIS Docker Benchmark — справочник курса AppSec"
description: "Справочник по Docker для курса AppSec: основные команды работы с образами и контейнерами и проверка конфигурации по CIS Docker Benchmark."
keywords: "Docker, docker run, docker build, docker compose, CIS Docker Benchmark, Docker Bench, справочник, AppSec, курс AppSec, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Команды: Docker</h1>
    <p class="hero-sub">Команды Docker и проверка по CIS Benchmark</p>
  </div>
</div>

Минимум команд для лабораторных 05 и 06 и для углублённого трека. Сборка образов разобрана в руководстве по Dockerfile, безопасный запуск и поставка — в работах трека.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">01</span>
    <span class="lab-card-title" style="font-weight:700;">Docker</span>
  </div>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <li><code>docker build -t &lt;name&gt; .</code> — сборка образа</li>
    <li><code>docker run -it --rm &lt;name&gt;</code> — запуск контейнера</li>
    <li><code>docker run -d -p 8080:80 &lt;name&gt;</code> — фоновый запуск с портом</li>
    <li><code>docker exec -it &lt;id&gt; bash</code> — шелл внутри контейнера</li>
    <li><code>docker ps -a</code> / <code>docker logs &lt;id&gt;</code> — статус и логи</li>
    <li><code>docker images</code> / <code>docker rmi &lt;id&gt;</code> — образы</li>
    <li><code>docker compose up -d</code> / <code>down</code> — Compose</li>
  </ul>
  <span class="lab-tag"><a href="https://docs.docker.com/reference/" style="color:inherit; text-decoration:none;">docs.docker.com/reference</a></span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">02</span>
    <span class="lab-card-title" style="font-weight:700;">Docker CIS Benchmark</span>
  </div>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
  <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Аудит Docker-окружения по CIS Benchmark — 100+ проверок хоста, демона, образов и контейнеров</p>
    <li><code>docker-bench-security</code> — автоматизированная проверка по 7 разделам CIS (PASS/WARN/NOTE)</li>
    <li>Разделы: Host Configuration, Docker Daemon, Images &amp; Build, Container Runtime, Security Operations</li>
    <li><code>hadolint Dockerfile</code> — линтинг: <code>DL3008</code> (pin versions), <code>DL3003</code> (use WORKDIR), <code>SC2086</code> (quote vars)</li>
    <li><code>dockle &lt;image&gt;</code> — проверка собранного образа: лишние пакеты, рутовый пользователь, healthcheck</li>
  </ul>
  </div>

</div>

## Смотри также

- [CheatSheet: Docker](cheatsheet/CHEATSHEET_DOCKER.md) — образы, контейнеры, сети, тома
- [CheatSheet: Dockerfile Security](cheatsheet/CHEATSHEET_DOCKERFILE_SECURITY.md) — безопасная сборка образов
- [Dockerfile: как писать правильно](guides/dockerfile_guide.md) — порядок инструкций, слои и кэш
- [Лаб. 06 · Docker CIS Benchmark и Trivy](../labs/basic/lab06.md) — аудит конфигурации и скан образов
- [Углублённый трек: Docker](../labs/advanced/index.md) — hardening рантайма и цепочка поставки образа
- [Приложение](APPENDIX.md) — все справочники команд на одной странице
