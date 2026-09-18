---
title: "CheatSheet: Dockerfile Security | Курс AppSec"
description: "Dockerfile security: USER, multi-stage, distroless, hadolint, pinning versions — лучшие практики безопасной контейнеризации."
keywords: "Dockerfile, Docker security, multi-stage, distroless, hadolint, USER, AppSec, контейнеры, CIS Benchmark, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Dockerfile Security</h1>
    <p class="hero-sub">Лучшие практики безопасной контейнеризации</p>
  </div>
</div>

## Базовый образ

Всё, что есть в базовом образе, становится вашей поверхностью атаки: каждый лишний пакет — возможная строка в отчёте Trivy. Правил два: образ минимальный (slim, alpine, distroless) и закреплённый — тегом версии, а лучше дайджестом, потому что тег можно переставить на другой образ.

=== "Плохо"

    ```dockerfile
    FROM python:latest
    ```

=== "Хорошо"

    ```dockerfile
    # Пинить версию + использовать slim/alpine
    FROM python:3.11-slim@sha256:abc123...

    # Или distroless для production
    FROM gcr.io/distroless/python3-debian12
    ```

!!! warning "Почему important"

    - `latest` — непредсказуемая версия, может сломать сборку
    - Полный образ (`python:3.11`) — 900+ МБ, 200+ CVE в ОС-пакетах
    - `slim` — ~150 МБ, минимум ОС-пакетов
    - `distroless` — ~20 МБ, нет shell, нет package manager — минимальная поверхность атаки

***

## Пользователь (USER)

По умолчанию процесс в контейнере работает от root. Контейнер — не виртуальная машина: при уязвимости ядра или небезопасных флагах запуска root внутри контейнера превращается в root на хосте. Отдельный пользователь без прав — самая дешёвая мера из всех.

=== "Плохо"

    ```dockerfile
    FROM python:3.11-slim
    COPY app.py /app/
    CMD ["python", "/app/app.py"]
    # Процесс запущен от root!
    ```

=== "Хорошо"

    ```dockerfile
    FROM python:3.11-slim

    RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /sbin/nologin appuser

    WORKDIR /app
    COPY --chown=appuser:appuser app.py .

    USER appuser
    CMD ["python", "app.py"]
    ```

!!! warning "Почему important"

    Container escape + root в контейнере = root на хосте. `USER` — обязательный для production.

***

## Multi-stage build

Компилятор, заголовочные файлы и dev-зависимости нужны, чтобы собрать приложение, но не чтобы оно работало. Многоэтапная сборка оставляет их на промежуточном этапе, а в итоговый образ копируется только результат: образ меньше, инструментов для атакующего внутри тоже меньше.

=== "Один этап (плохо)"

    ```dockerfile
    FROM python:3.11
    RUN pip install poetry
    COPY . .
    RUN poetry install
    CMD ["python", "app.py"]
    # Итог: 1.2 ГБ, poetry + build tools в production
    ```

=== "Multi-stage (хорошо)"

    ```dockerfile
    # Stage 1: build
    FROM python:3.11 AS builder
    RUN pip install poetry
    COPY pyproject.toml poetry.lock ./
    RUN poetry export -f requirements.txt > requirements.txt
    RUN pip install --target=/deps -r requirements.txt

    # Stage 2: production
    FROM python:3.11-slim
    RUN groupadd -r app && useradd -r -g app app
    COPY --from=builder /deps /usr/local/lib/python3.11/site-packages
    COPY --chown=app:app app.py /app/
    USER app
    CMD ["python", "/app/app.py"]
    # Итог: ~150 МБ, без build tools
    ```

***

## Секреты

Слой образа нельзя «перезаписать»: секрет, попавший в любой слой, достаётся через `docker history` или распаковкой образа, даже если следующая инструкция его удалила. Поэтому ни `COPY`, ни `ARG`, ни `ENV` для секретов не годятся — на время сборки их передают только через `--mount=type=secret`.

=== "Плохо"

    ```dockerfile
    # Секрет остаётся в слое образа навсегда
    ENV API_KEY=sk-1234567890
    COPY .env /app/.env
    RUN echo "password123" > /app/config
    ```

=== "Хорошо"

    ```dockerfile
    # BuildKit secrets — не сохраняются в слоях
    RUN --mount=type=secret,id=api_key \
        cat /run/secrets/api_key > /tmp/key && \
        ./configure --key="$(cat /tmp/key)" && \
        rm /tmp/key

    # Runtime: через env переменные или Docker secrets
    # docker run -e API_KEY=sk-xxx ...
    # docker secret create api_key key.txt
    ```

!!! danger "Проверка"

    ```bash
    # Извлечение секретов из слоёв
    docker history --no-trunc <image>
    docker save <image> | tar -xf - && grep -r "password\|secret\|key" .
    ```

***

## COPY vs ADD

`ADD` умеет больше, чем кажется: сам распаковывает архивы и скачивает файлы по URL, не сверяя контрольную сумму. Поэтому по умолчанию — `COPY`, а `ADD` только там, где нужна именно распаковка локального архива.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">COPY</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Всегда по умолчанию</span>
  </div>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Предсказуемое поведение. Копирует файлы из контекста сборки.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
    <span class="lab-card-num" style="font-size:0.9rem; width:auto;">ADD</span>
    <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Только для .tar.gz</span>
  </div>
  <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">RISK</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Может скачать файл по URL без верификации — risk of RCE.</p>
  </div>

</div>

```dockerfile
# Хорошо
COPY requirements.txt .
COPY app.py .

# Плохо — ADD скачивает URL без верификации
ADD https://example.com/app.tar.gz /app/
```

***

## Оптимизация слоёв

Меньше слоёв и меньше файлов в них — меньше образ, быстрее доставка и короче отчёт сканера. Временные файлы удаляются в той же инструкции `RUN`, где появились: удаление следующей инструкцией размер образа не уменьшает, файл остаётся в предыдущем слое.

=== "Плохо"

    ```dockerfile
    RUN apt-get update
    RUN apt-get install -y curl
    RUN apt-get install -y git
    RUN rm -rf /var/lib/apt/lists/*
    # 4 слоя, кэш apt остаётся в первых слоях
    ```

=== "Хорошо"

    ```dockerfile
    RUN apt-get update && \
        apt-get install -y --no-install-recommends curl git && \
        rm -rf /var/lib/apt/lists/*
    # 1 слой, кэш удалён в том же слое
    ```

***

## .dockerignore

Первая линия защиты от утечки: то, что исключено из контекста сборки, в образ попасть не может. Полный шаблон и отличия от `.gitignore` — в [шпаргалке .dockerignore](CHEATSHEET_DOCKERIGNORE.md).

```bash title=".dockerignore"
.git
.github
.venv
__pycache__
*.pyc
.env
.env.*
*.key
*.pem
node_modules
.DS_Store
```

!!! warning "Без .dockerignore"

    `COPY . .` скопирует `.git` (вся история), `.env` (секреты), `node_modules` (100+ МБ).

***

## Hadolint — правила

Hadolint проверяет Dockerfile по списку правил и встраивается в конвейер. Ниже — правила, которые срабатывают чаще всего; CI этого репозитория падает на находках уровня error.

```bash
# Запуск
hadolint Dockerfile

# Или через Docker
docker run --rm -i hadolint/hadolint < Dockerfile
```

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DL3006</span>
  <p style="font-size:0.75rem; margin:0; color:#555;">Пинить версию базового образа</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DL3007</span>
  <p style="font-size:0.75rem; margin:0; color:#555;">Не использовать <code>latest</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DL3008</span>
  <p style="font-size:0.75rem; margin:0; color:#555;">Пинить версии apt-пакетов</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DL3009</span>
  <p style="font-size:0.75rem; margin:0; color:#555;">Удалять apt cache после install</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DL3025</span>
  <p style="font-size:0.75rem; margin:0; color:#555;">Использовать JSON-форму CMD</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DL4006</span>
  <p style="font-size:0.75rem; margin:0; color:#555;">Установить <code>SHELL ["/bin/bash", "-o", "pipefail", "-c"]</code></p>
  </div>

</div>

***

## Чек-лист

Перед pull request с Dockerfile пройдите список — каждый пункт отвечает одному из разделов выше. Основа, без которой чек-лист не имеет смысла, — в руководстве [Dockerfile: как устроен и как его писать](../guides/dockerfile_guide.md).

- [ ] Базовый образ: slim/alpine/distroless, пинить версию + digest
- [ ] `USER` — не root
- [ ] Multi-stage build для production
- [ ] Нет секретов в `ENV`, `COPY`, `ARG`
- [ ] `COPY` вместо `ADD`
- [ ] Один `RUN` для apt — с очисткой кэша
- [ ] `.dockerignore` — исключает `.git`, `.env`, `node_modules`
- [ ] `HEALTHCHECK` для orchestrators
- [ ] Hadolint в CI
- [ ] Trivy scan образа перед push
