<div align="center">
<h1><a id="intro">Руководство по оформлению отчётов gistup</a><br></h1>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/GitHub_Gist-181717?style=flat&logo=github&logoColor=white" alt="GitHub Gist">
<img src="https://img.shields.io/badge/Markdown-000000?style=flat&logo=markdown&logoColor=white" alt="Markdown">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Каждая лабораторная работа сдаётся в виде отчёта `gistup` — GitHub Gist в формате Markdown. Данное руководство описывает формат, структуру и правила оформления.

***

## Что такое Gist

GitHub Gist — сервис для хранения фрагментов кода и заметок. Каждый Gist — мини-репозиторий с версионированием.

- **Public Gist** — виден всем, индексируется поисковиками
- **Secret Gist** — доступен только по прямой ссылке (не приватный, а скрытый)

> Для отчётов используем **Secret Gist** — отправляете ссылку преподавателю. Секретный гист открывается у любого, у кого есть ссылка: не публикуйте в отчёте токены, пароли и результаты сканирования чужих сетей.

## Цикл отчёта

Схема показывает путь отчёта от выполненной лабораторной до ссылки у преподавателя и две проверки, которые нельзя пропускать.

```mermaid
%%{init: {"flowchart": {"curve": "step"}}}%%
flowchart TB
    accTitle: Цикл отчёта по лабораторной
    accDescr: Команды и вывод терминала собираются в отчёт по структуре, отчёт проверяется на секреты и на корректный рендер Markdown, и только потом ссылка на секретный gist уходит преподавателю; любая проверка при неудаче возвращает отчёт на правку.

    lab_finished(["Лабораторная<br/>выполнена"])
    terminal_output[/"Команды и вывод<br/>терминала текстом"/]
    write_report["Написать отчёт: цель,<br/>ход, результаты, выводы"]
    secrets_join((" "))
    has_secrets{"В отчёте есть токены,<br/>пароли или ключи?"}
    secrets_fork((" "))
    redact_report["Заменить<br/>на заглушки"]
    create_gist[["gh gist create<br/>labNN_report.md"]]
    render_join((" "))
    renders_ok{"Markdown на GitHub<br/>выглядит верно?"}
    render_fork((" "))
    edit_gist[["gh gist edit"]]
    send_link[/"Ссылка на gist<br/>преподавателю"/]
    report_sent([Отчёт сдан])

    lab_finished --> terminal_output
    terminal_output --> write_report
    write_report --- secrets_join
    secrets_join --> has_secrets
    has_secrets --- secrets_fork
    secrets_fork -->|Нет| create_gist
    secrets_fork -->|Да| redact_report
    redact_report --> secrets_join
    create_gist --- render_join
    render_join --> renders_ok
    renders_ok --- render_fork
    render_fork -->|Да| send_link
    render_fork -->|Нет| edit_gist
    edit_gist --> render_join
    send_link --> report_sent

    classDef junction fill:#374151,stroke:#374151,stroke-width:1px,color:#374151,font-size:1px
    classDef stage fill:#dbeafe,stroke:#2563eb,stroke-width:2px,color:#1e3a5f
    classDef gate fill:#fef9c3,stroke:#ca8a04,stroke-width:2px,color:#713f12
    classDef done fill:#dcfce7,stroke:#16a34a,stroke-width:2px,color:#14532d

    class secrets_join,secrets_fork,render_join,render_fork junction
    class write_report,redact_report,create_gist,edit_gist stage
    class has_secrets,renders_ok gate
    class report_sent done
```

**Как читать схему:**

- Вход — команды и вывод терминала текстом: скриншоты вместо текста не принимаются.
- Первая проверка — на секреты. Секретный gist открывается у любого, у кого есть ссылка, поэтому токены, пароли и ключи заменяются заглушками до публикации, а не после.
- Вторая проверка — на рендер: незакрытый блок кода превращает весь остаток отчёта в один серый блок. Правки вносятся в тот же gist, ссылка при этом не меняется.
- Конец цикла — ссылка у преподавателя; по отчёту он задаёт вопросы, поэтому каждая команда должна быть вам понятна.

Обозначения — в материале [Как читать схемы курса](https://course.geminishkv.tech/materials/diagrams_legend/).

***

## Создание Gist

### Через веб-интерфейс

- [ ] 2.1. Перейдите на [gist.github.com](https://gist.github.com)
- [ ] 2.2. Имя файла: `lab01_report.md` (номер лабораторной)
- [ ] 2.3. Напишите отчёт в формате Markdown
- [ ] 2.4. Нажмите `Create secret gist`

### Через GitHub CLI

На Windows команды те же — в PowerShell или Git Bash после `winget install --id GitHub.cli -e`.

```bash
# Создание из файла
$ gh gist create lab01_report.md --desc "Lab 01: Git SCM"    # без --public гист создаётся секретным

# Создание из stdin
$ cat report.md | gh gist create --filename lab01_report.md --desc "Lab 01"

# Редактирование существующего
$ gh gist edit <GIST_ID>

# Просмотр своих гистов
$ gh gist list
```

***

## Структура отчёта

```markdown
# Лабораторная работа №X — Название

**Автор:** Фамилия Имя
**Группа:** ХХХХ-ХХ-ХХ
**Дата:** ГГГГ-ММ-ДД

***

## Цель работы

Краткое описание цели лабораторной работы (1-2 предложения).

***

## Ход выполнения

### Шаг 1. Название шага

Описание что было сделано и зачем.

Команда: блок кода с указанием языка (` ```bash `)

Вывод: блок кода без языка (` ``` `)

Пояснение: что означает вывод, какие флаги использованы и почему.

### Шаг 2. ...

***

## Результаты

- Что было достигнуто
- Какие инструменты использованы
- Какие проблемы возникли и как решены

***

## Выводы

Краткие выводы по работе (3-5 предложений).
```

***

## Правила оформления

### Команды и вывод

Каждая команда в отчёте должна содержать:

- **Саму команду** в блоке `` ```bash ``
- **Вывод** в блоке `` ``` `` (без подсветки)
- **Пояснение:** что делает команда, что означают флаги, что показывает вывод

```bash
# Пример правильного оформления
$ nmap -sV -p 22,80,443 192.168.1.1
```

```
Starting Nmap 7.94 ( https://nmap.org )
PORT    STATE SERVICE VERSION
22/tcp  open  ssh     OpenSSH 8.9p1
80/tcp  open  http    nginx 1.18.0
443/tcp open  https   nginx 1.18.0
```

> Флаг `-sV` определяет версии сервисов на открытых портах. `-p 22,80,443` сканирует только указанные порты. Результат: на хосте запущены SSH (OpenSSH 8.9) и веб-сервер nginx 1.18.0.

### Что НЕ делать

- Скриншоты вместо текста — **запрещено** (исключение: GUI-инструменты где текст невозможен)
- Команды без пояснений — каждый флаг должен быть описан
- Копипаст без понимания — преподаватель задаёт вопросы по отчёту

### Форматирование

- Используйте `inline code` для команд, путей, имён файлов в тексте
- Используйте **жирный** для ключевых терминов
- Используйте `> цитата` для важных замечаний
- Разделяйте секции через `***`

***

## Пример отчёта

Эталонный пример оформления:

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr));">
<a class="lab-card" href="https://gist.github.com/MishaBary/21ab63f83292a86268e039d484a86411" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Пример gistup-отчёта</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span><span class="lab-tag">Эталон</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

***

## Отправка отчёта

- [ ] 6.1. Убедитесь, что Gist содержит все шаги лабораторной
- [ ] 6.2. Проверьте, что Markdown рендерится корректно (превью на GitHub)
- [ ] 6.3. Скопируйте ссылку на Gist
- [ ] 6.4. Отправьте ссылку преподавателю

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/materials/troubleshooting/).

***

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr));">
<a class="lab-card" href="https://gist.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub Gist</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.github.com/en/get-started/writing-on-github/editing-and-sharing-content-with-gists" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub Gist Documentation</div><div class="lab-card-tags"><span class="lab-tag">docs.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://www.markdownguide.org/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Markdown Guide</div><div class="lab-card-tags"><span class="lab-tag">markdownguide.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com/manual/gh_gist" target="_blank"><div class="lab-card-body"><div class="lab-card-title">gh gist CLI reference</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
