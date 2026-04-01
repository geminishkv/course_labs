---
hide:
  - toc
title: ".gitignore Cheatsheet — шпаргалка"
description: "Шпаргалка по .gitignore: правила исключения файлов из репозитория Git, шаблоны для Python, Node, Docker."
keywords: "gitignore, Git, cheatsheet, шпаргалка, репозиторий, исключение, Python, Node, Docker"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">.gitignore</h1>
    <p class="hero-sub">Синтаксис и паттерны игнорирования</p>
  </div>
</div>

***

## Шаблон .gitignore

```gitignore
# ── macOS ────────────────────────────────────────────────────────────────────
.DS_Store
.DS_Store?
._*
.AppleDouble
.LSOverride
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent
*.icloud
.AppleDB
.AppleDesktop
Network Trash Folder
Temporary Items
.apdisk

# ── Windows ──────────────────────────────────────────────────────────────────
ehthumbs.db
Thumbs.db
desktop.ini

# ── Python ───────────────────────────────────────────────────────────────────
__pycache__/
*.py[cod]
*.pyo
*.pyd
.ruff_cache/
venv/
.venv/
*.egg-info/
dist/
build/
.mypy_cache/
.pytest_cache/

# ── Node.js ──────────────────────────────────────────────────────────────────
node_modules/
/node_modules
jspm_packages/
.lock-wscript
.node_repl_history
.webpack/
.npm
dist/

# ── Yarn v2 ──────────────────────────────────────────────────────────────────
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
.pnp.*

# ── Java / Kotlin ─────────────────────────────────────────────────────────────
*.class
*.jar
*.war
*.ear
target/

# ── Go ───────────────────────────────────────────────────────────────────────
*.exe
*.exe~
*.test
*.out
vendor/

# ── Compiled source ───────────────────────────────────────────────────────────
*.com
*.dll
*.o
*.so

# ── Archives / packages ───────────────────────────────────────────────────────
*.7z
*.dmg
*.gz
*.iso
*.rar
*.tar
*.zip

# ── Logs and databases ────────────────────────────────────────────────────────
*.log
*.sql
*.sqlite
*.db
logs/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*
report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json

# ── Coverage ──────────────────────────────────────────────────────────────────
lib-cov/
.nyc_output/
coverage/
*.lcov

# ── IDE / Editor ──────────────────────────────────────────────────────────────
.vscode/
.idea/
*.swp
*.swo
*.swn
*.bak

# ── Secrets / Environment ─────────────────────────────────────────────────────
.env
.env.*
*.env
!.env.example

# ── Build artifacts ───────────────────────────────────────────────────────────
site/
dist/
build/
out/

# ── Misc ──────────────────────────────────────────────────────────────────────
*.pid
*.seed
*.pid.lock
pids/
Icon
CACHEDIR.TAG
```

## Синтаксис

```gitignore
# Комментарий
*.log          # Игнорировать все .log файлы
!important.log # Исключение — не игнорировать этот файл
/TODO          # Только в корне репозитория
build/         # Директория
doc/**/*.txt   # Все .txt внутри doc/ на любом уровне вложенности
```

## Полезные команды

```bash
git rm --cached <file>          # Убрать из отслеживания (файл остаётся на диске)
git rm --cached -r <dir>        # То же для директории рекурсивно
git ls-files --ignored \
  --exclude-standard -o         # Показать игнорируемые файлы
git check-ignore -v <file>      # Узнать, почему файл игнорируется
```

***