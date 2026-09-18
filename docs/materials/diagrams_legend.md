---
title: "Как читать схемы курса — обозначения и правила"
description: "Легенда схем курса AppSec: символы блок-схем по ГОСТ 19.701-90, развилки и циклы, цвета, диаграммы последовательности и состояний."
keywords: "схемы, блок-схема, ГОСТ 19.701-90, ISO 5807, mermaid, диаграмма последовательности, диаграмма состояний, AppSec, DevSecOps, курс AppSec, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Как читать схемы курса</h1>
    <p class="hero-sub">Обозначения, развилки, циклы и цвета</p>
  </div>
</div>

Схемы в курсе нарисованы в одной нотации — по ГОСТ 19.701-90 (ISO 5807). Форма блока говорит, что это: действие, данные или вопрос. Достаточно один раз запомнить семь обозначений, и любая схема курса читается без пояснений.

## Символы

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(15rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Терминатор</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">([текст])</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Начало и конец: событие, которое запускает процесс, и результат, которым он заканчивается. Вход в процесс один, концов может быть несколько.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Процесс</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">[текст]</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Действие. Названо глаголом: «Собрать проект», «Оценить уровень». Один блок — один шаг, который можно выполнить и проверить.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Готовый блок</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">[[текст]]</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Предопределённый процесс: то, что вызывают целиком и не расписывают по шагам — команда, job конвейера, reusable workflow (<code>docker build</code>, <code>lint: ruff</code>).</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Данные</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">[/текст/]</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">То, что подаётся на вход или получается на выходе: файл, отчёт сканера, слой образа, артефакт сборки, выход транзакции.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Решение</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">{текст?}</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Вопрос, на который отвечают «Да» или «Нет». В ромб входит одна линия, выходы подписаны. Каждый ромб в лабораторной — место, где нужно остановиться и проверить результат.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Точка</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">((&nbsp;))</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Развилка или слияние линий. После ромба линия сначала приходит в точку, и уже из неё расходятся «Да» и «Нет». В точку же возвращаются циклы и сходятся параллельные ветки.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Группа</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">subgraph</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Рамка с заголовком: этап или зона ответственности — «CI», «Образ», «Параллельно после lint». Линия, которая входит в рамку, относится ко всей группе, а не к одному блоку.</p>
  </div>

</div>

## Схема-образец

В образце встречаются все семь обозначений. Сюжет — разбор находки сканера, которым заканчиваются Лаб. 06–09.

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Разбор находки сканера
    accDescr: Образец схемы курса со всеми символами: отчёт сканера проверяется вручную, подтверждённая находка уходит в задачу на исправление, неподтверждённая записывается как ложное срабатывание, после чего разбор завершается.

    triage_start([Сканер завершил работу])
    scan_report[/"Отчёт сканера:<br/>список находок"/]
    reproduce_finding["Воспроизвести находку<br/>вручную"]
    is_confirmed{"Находка<br/>подтвердилась?"}
    confirm_fork((" "))
    create_fix_task[["Завести задачу<br/>на исправление"]]
    record_false_positive["Записать ложное<br/>срабатывание с причиной"]
    result_join((" "))
    triage_done([Находка разобрана])

    triage_start --> scan_report
    scan_report --> reproduce_finding
    reproduce_finding --> is_confirmed
    is_confirmed --- confirm_fork
    confirm_fork -->|Да| create_fix_task
    confirm_fork -->|Нет| record_false_positive
    create_fix_task --- result_join
    record_false_positive --- result_join
    result_join --> triage_done

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class confirm_fork,result_join junction
    class reproduce_finding,create_fix_task,record_false_positive stage
    class is_confirmed gate
    class triage_done done
```

**Как читать схему:**

- Сверху вниз. Стрелка означает «затем» или «передаётся дальше»; линия без стрелки ведёт в точку.
- Терминатор сверху — событие, с которого всё начинается; параллелограмм под ним — данные, с которыми работают дальше.
- Ромб — единственное место, где путь раздваивается. Подписи «Да» и «Нет» стоят на линиях после точки, а не на самом ромбе.
- Обе ветки сходятся во второй точке: процесс заканчивается одинаково, каким бы ни был ответ.
- Линия, уходящая вверх, — возврат на предыдущий шаг, то есть цикл. В образце его нет, в схеме анализа рисков (Лаб. 04) он есть: остаточный риск возвращается на оценку.

## Цвета

Цвет повторяет форму и не несёт смысла сам по себе: схема читается и в чёрно-белой печати.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(13rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Синий</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">stage</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Действие: процесс или готовый блок.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Жёлтый</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">gate</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Решение: развилка, на которой процесс может пойти по другому пути.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Зелёный</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">done</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Результат: чем заканчивается успешный путь, либо то, что остаётся после процесса (непотраченный выход, записываемый слой).</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-title" style="font-weight:700;">Серый или без заливки</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">data</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Данные и терминаторы. В структурных схемах — служебный слой (гипервизор, Docker Engine).</p>
  </div>

</div>

## Другие типы схем

**Диаграмма последовательности** — кто кому и в каком порядке что отправляет. Участники стоят сверху, время идёт вниз, стрелка — одно сообщение, плашка поперёк — примечание к этапу. Так нарисовано TCP-рукопожатие.

**Диаграмма состояний** — в каких состояниях бывает объект и что переводит его из одного в другое. Скруглённый блок — состояние, стрелка — переход, подпись на стрелке — команда. Чёрный кружок — начало, кружок в кольце — конец. Так нарисован жизненный цикл контейнера.

## Где схемы в курсе

- [Введение в CI/CD](guides/cicd_basics.md) — конвейер от push до релиза и порядок jobs в DevSecOps-пайплайне
- [Введение в сети и TCP/IP](guides/networking_basics.md) — установка и закрытие TCP-соединения
- [Основы Docker](guides/docker_basics.md) — виртуальные машины и контейнеры, слои образа, жизненный цикл контейнера
- [Лаб. 04 · Анализ и снижение рисков ИБ](../labs/basic/lab04.md) — цепочка анализа риска
- [MultiSig](examples/Multisignature.md) — транзакции Bitcoin в модели UTXO
- [Порты и протоколы](ports.md) — разбор открытого порта
- [CheatSheet: Git](cheatsheet/CHEATSHEET_GIT.md) — где живут изменения в Git
- [CheatSheet: GitHub CLI](cheatsheet/CHEATSHEET_GH_CLI.md) — цикл сдачи работы через pull request
- [OWASP — CI/CD Risks](OWASPTOP10/OWASP_Top_10_CICD_Risks.md) — риски по этапам конвейера
