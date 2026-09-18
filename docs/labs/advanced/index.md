---
title: "Углублённый трек по Docker — hardening рантайма и цепочка поставки образа | Курс AppSec"
description: "Две углублённые лабораторные курса AppSec по Docker: безопасный запуск контейнера и сегментация сети, затем цепочка поставки образа, SBOM, подпись и гейт допуска. С разбором ложных срабатываний."
keywords: "углублённый трек Docker, Docker hardening, цепочка поставки образа, SBOM, cosign, seccomp, capabilities, ложные срабатывания, AppSec, DevSecOps, курс AppSec, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Углублённый трек: Docker</h1>
    <p class="hero-sub">Две работы поверх лабораторных 05, 06 и 09: как образ безопасно запустить и почему ему можно доверять</p>
  </div>
</div>

Базовая линия курса учит собрать образ и найти в нём проблемы. Трек отвечает на два следующих вопроса. Первая работа про **запуск**: один и тот же образ может работать как процесс без прав и как процесс с доступом ко всему хосту, и решается это параметрами запуска. Вторая работа про **поставку**: из чего образ собран, не осталось ли в нём секретов и кто решает, допускать ли его к запуску.

Трек необязательный и в основной конвейер не входит: финалом курса остаются лабораторная 10 и pet-project.

## Работы трека

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(19rem, 100%), 1fr));">
<a class="lab-card" href="docker01/"><div class="lab-card-num">D1</div><div class="lab-card-body"><div class="lab-card-title">Рантайм: hardening и сегментация</div><div class="lab-card-tags"><span class="lab-tag">capabilities</span><span class="lab-tag">seccomp</span><span class="lab-tag">read-only</span><span class="lab-tag">secrets</span><span class="lab-tag">networks</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="docker02/"><div class="lab-card-num">D2</div><div class="lab-card-body"><div class="lab-card-title">Поставка: сборка, SBOM, подпись</div><div class="lab-card-tags"><span class="lab-tag">digest</span><span class="lab-tag">BuildKit</span><span class="lab-tag">SBOM</span><span class="lab-tag">cosign</span><span class="lab-tag">CI</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Что нужно до начала

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14.5rem, 100%), 1fr));">
<a class="lab-card" href="../basic/lab05/"><div class="lab-card-num">05</div><div class="lab-card-body"><div class="lab-card-title">Docker: образы и контейнеры</div><div class="lab-card-tags"><span class="lab-tag">свой образ для переноса мер</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="../basic/lab06/"><div class="lab-card-num">06</div><div class="lab-card-body"><div class="lab-card-title">Docker CIS Benchmark и Trivy</div><div class="lab-card-tags"><span class="lab-tag">аудит до и после</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="../basic/lab07/"><div class="lab-card-num">07</div><div class="lab-card-body"><div class="lab-card-title">SAST, SCA и поиск секретов</div><div class="lab-card-tags"><span class="lab-tag">исключения у сканеров</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="../basic/lab09/"><div class="lab-card-num">09</div><div class="lab-card-body"><div class="lab-card-title">DevSecOps CI/CD</div><div class="lab-card-tags"><span class="lab-tag">конвейер для D2</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

## Чем трек отличается от базовых работ

- **Готовый стенд, затем свой образ.** Сначала меры отрабатываются на учебном стенде, где шаги воспроизводятся у всех одинаково. Финальный шаг переносит их на образ из лабораторной 05.
- **Каждая мера доказывается проверкой.** В отчёт идёт не «добавил строку в compose», а команда и её вывод до и после.
- **Проверяющий скрипт вместо чек-листа.** В каждой работе есть скрипт, который снимает факты и превращает отклонения в находки. Работа закончена, когда открытых находок нет.
- **Ложные срабатывания заложены намеренно.** Скрипты устроены как настоящие сканеры и ошибаются так же. Отличить ложное срабатывание от настоящей находки и оформить исключение с причиной — часть задания. Порядок разбора описан в справочнике [Разбор находок сканеров](../../materials/findings_triage/).

Работы сдаются по общим [правилам курса](../../#rules): ветка, pull request, отчёт `gist`.
