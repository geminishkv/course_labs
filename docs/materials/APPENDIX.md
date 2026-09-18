---
hide:
  - toc

title: "Приложение — справочники команд курса AppSec по темам"
description: "Справочники команд курса AppSec по темам: Git, окружение Unix и Python, Docker и CIS Benchmark, сканеры и конвейер GitHub Actions, анализ рисков."
keywords: "Git, Docker, Linux, Python, pip, venv, Nmap, SAST, SCA, DAST, GitHub Actions, команды, AppSec, справочник, лабораторные работы, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Приложение</h1>
    <p class="hero-sub">Справочники команд по темам</p>
  </div>
</div>

Раньше все команды лежали на этой странице одним списком. Теперь они разнесены по темам: у каждой темы своя статья с вводкой и ссылками на шпаргалки и лабораторные, где команды применяются.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(19rem, 100%), 1fr));">
<a class="lab-card" href="../commands_git/"><div class="lab-card-body"><div class="lab-card-title">Команды: Git</div><div class="lab-card-tags"><span class="lab-tag">Указатели, уровни конфигурации и основные команды</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="../commands_environment/"><div class="lab-card-body"><div class="lab-card-title">Команды: окружение</div><div class="lab-card-tags"><span class="lab-tag">Unix-утилиты, пакетные менеджеры, ПО и Python venv</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="../commands_docker/"><div class="lab-card-body"><div class="lab-card-title">Команды: Docker</div><div class="lab-card-tags"><span class="lab-tag">Команды Docker и проверка по CIS Benchmark</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="../commands_scanners/"><div class="lab-card-body"><div class="lab-card-title">Команды: сканеры и конвейер</div><div class="lab-card-tags"><span class="lab-tag">Nmap, SAST, SCA, DAST, поиск секретов и GitHub Actions</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="../risk_scoring/#risk-basics"><div class="lab-card-body"><div class="lab-card-title">Анализ рисков ИБ</div><div class="lab-card-tags"><span class="lab-tag">Цепочка анализа, матрица, стратегии, стандарты</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Что где лежит

- **Команды: Git.** Как Git хранит указатели `HEAD`, `ORIG_HEAD`, ветки и теги, три уровня конфигурации и команды на каждый день. Нужны с лабораторной 01.
- **Команды: окружение.** Утилиты Unix для файлов и процессов, пакетные менеджеры, установка ПО, виртуальные окружения Python и `pip`. Нужны с лабораторной 02.
- **Команды: Docker.** Работа с образами и контейнерами и проверка конфигурации по CIS Docker Benchmark. Нужны в лабораторных 05 и 06 и в углублённом треке.
- **Команды: сканеры и конвейер.** Запуск `Nmap`, SAST, SCA, DAST и поиска секретов и сборка их в конвейер `GitHub Actions`. Нужны в лабораторных 03, 07, 08 и 09.
- **Анализ рисков ИБ.** Цепочка от актива к мере, матрица вероятности и ущерба, стратегии обработки и стандарты. Раздел справочника «CVSS и реестр рисков», нужен в лабораторных 04 и 10.

Развёрнутые сценарии с пояснениями собраны в [шпаргалках](index.md#cheatsheets), а типовые ошибки и их решения — в [troubleshooting](troubleshooting.md).
