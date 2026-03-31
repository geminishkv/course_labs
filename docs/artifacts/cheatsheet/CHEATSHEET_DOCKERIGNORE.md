---
hide:
  - toc
---

<div class="hero-section">
  <div class="hero-content">
    <h1 class="hero-title">.dockerignore</h1>
    <p class="hero-sub">Синтаксис и паттерны игнорирования</p>
  </div>
</div>

<!-- markdownlint-disable MD013 -->
<div align="center">
<h1><a id="intro">CheatSheet — .dockerignore</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a>
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt="RA">
<img src="https://img.shields.io/badge/AppSec-2448a2" alt="AppSec">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge">
</div>
<!-- markdownlint-enable MD013 -->

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

![Logo](../assets/logotypemd.jpg)
