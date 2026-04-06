---
hide:
  - toc
title: "Шпаргалка .dockerignore — правила исключения файлов при сборке Docker"
description: ".dockerignore шпаргалка: синтаксис и паттерны исключения файлов при сборке Docker-образов — шаблоны для AppSec и DevOps проектов."
keywords: "dockerignore, Docker, cheatsheet, шпаргалка, сборка образа, исключение файлов, паттерны, AppSec, DevOps, безопасность"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">.dockerignore</h1>
    <p class="hero-sub">Синтаксис и паттерны игнорирования</p>
  </div>
</div>

***

## Шаблон .dockerignore

```dockerignore
# ── Git ───────────────────────────────────────────────────────────────────────
.git/
.gitignore
.gitattributes
.github/

# ── CI / CD ───────────────────────────────────────────────────────────────────
.github/
.gitlab-ci.yml
Jenkinsfile
.travis.yml
.circleci/

# ── Docker ────────────────────────────────────────────────────────────────────
Dockerfile
Dockerfile.*
docker-compose*.yml
.dockerignore

# ── Зависимости ───────────────────────────────────────────────────────────────
node_modules/
vendor/
.venv/
venv/

# ── Build / dist ──────────────────────────────────────────────────────────────
dist/
build/
out/
target/
*.egg-info/

# ── Тесты ────────────────────────────────────────────────────────────────────
test/
tests/
__tests__/
spec/
*.test.*
*.spec.*
coverage/
.nyc_output/

# ── Документация ──────────────────────────────────────────────────────────────
docs/
*.md
LICENSE
NOTICE
CONTRIBUTING*
CODE_OF_CONDUCT*

# ── Логи и отчёты ─────────────────────────────────────────────────────────────
logs/
*.log
reports/

# ── Secrets / ENV ─────────────────────────────────────────────────────────────
.env
.env.*
*.env
*.pem
*.key
*.crt
secrets/

# ── IDE / Editor ──────────────────────────────────────────────────────────────
.vscode/
.idea/
*.swp
*.swo

# ── macOS / Windows ───────────────────────────────────────────────────────────
.DS_Store
Thumbs.db
desktop.ini

# ── Misc ──────────────────────────────────────────────────────────────────────
.npmrc
.yarnrc
*.local
screenshots/
monitoring/
vagrant/
```

## Синтаксис

```dockerignore
# Комментарий
*.log           # Исключить все .log файлы
!app.log        # Исключение — включить этот файл
**/tmp          # Директория tmp на любом уровне
dir/            # Вся директория dir/
dir/*.txt       # Только .txt файлы в dir/ (не рекурсивно)
```

## Зачем нужен .dockerignore

`.dockerignore` уменьшает **build context** — набор файлов, который Docker передаёт
демону при сборке. Это влияет на:

- **Скорость сборки** — меньше данных передаётся демону
- **Размер образа** — лишние файлы не попадают в слои
- **Безопасность** — секреты (`.env`, ключи) не копируются в образ

## Проверка build context

```bash
docker build --no-cache . 2>&1 | head -5     # Показывает размер build context
```

***
