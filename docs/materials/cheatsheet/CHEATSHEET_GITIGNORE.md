---
hide:
  - toc
title: "CheatSheet: .gitignore | Курс AppSec"
description: ".gitignore шпаргалка: правила и паттерны исключения файлов из Git-репозитория — готовые шаблоны для Python, Node.js и Docker."
keywords: "gitignore, Git, cheatsheet, шпаргалка, репозиторий, исключение, Python, Node.js, Docker, шаблоны, паттерны, AppSec, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">.gitignore</h1>
    <p class="hero-sub">Синтаксис и паттерны игнорирования</p>
  </div>
</div>

***

`.gitignore` говорит Git, какие файлы не предлагать к добавлению. Он действует только на файлы, которые ещё не отслеживаются: если файл уже попал в коммит, строка в `.gitignore` ничего не изменит, пока файл не убрать из индекса через `git rm --cached`. И это не защита секретов: закоммиченный секрет остаётся в истории — что с этим делать, разобрано в [шпаргалке Git](CHEATSHEET_GIT.md).

## Шаблон .gitignore

Шаблон собран под проекты курса: Python, Node.js, Docker, отчёты сканеров, служебные файлы редакторов и ОС. Служебные файлы своей ОС и редактора удобнее вынести в глобальный игнор (`git config --global core.excludesFile ~/.gitignore_global`), чтобы не засорять ими каждый репозиторий.

```bash title=".gitignore"
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

Комментарий — только отдельная строка, начинающаяся с `#`. Пояснение в конце строки с шаблоном Git считает частью шаблона, и правило перестаёт работать.

```bash title=".gitignore"
# Все файлы .log на любом уровне вложенности
*.log
# Исключение: этот файл игнорироваться не будет
!important.log
# Только в корне репозитория
/TODO
# Каталог целиком
build/
# Все .txt внутри doc/ на любом уровне вложенности
doc/**/*.txt
```

!!! warning "Правило"
    Исключение через `!` не сработает, если выше по списку исключён весь родительский каталог: Git в него уже не заглядывает. Вместо `logs/` и `!logs/keep.log` пишите `logs/*` и `!logs/keep.log`. Порядок строк важен: побеждает последнее подходящее правило.

## Полезные команды

Если файл «игнорируется, но всё равно попадает в коммит» — он уже отслеживается: первая команда. Если файл «не добавляется, хотя должен» — его закрывает какое-то правило: последняя команда покажет, какое именно и из какого файла.

```bash
git rm --cached <file>          # Убрать из отслеживания (файл остаётся на диске)
git rm --cached -r <dir>        # То же для директории рекурсивно
git ls-files --ignored \
  --exclude-standard -o         # Показать игнорируемые файлы
git check-ignore -v <file>      # Узнать, почему файл игнорируется
```
