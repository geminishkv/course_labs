# Project: tplabworks (AppSecCourse)

## Purpose
MkDocs-based практический курс по AppSec/DevSecOps для МГТУ.
Развёрнут на GitHub Pages: https://geminishkv.github.io/course_labs/

## Stack
- MkDocs Material (Python), mkdocs-macros-plugin
- Python 3.x (scripts)
- ruff, mypy (lint)
- stylelint, eslint (JS/CSS lint)
- GitHub Actions (CI/CD)

## Key Directories
```
docs/          — материалы курса (лабораторные, аннотации, методички)
labs/          — практические лабораторные работы
scripts/       — вспомогательные скрипты
assets/        — логотипы, favicon
mkdocs.yml     — конфигурация сайта
requirements.txt
```

## Deploy
```bash
mkdocs build
mkdocs gh-deploy
# live at: https://geminishkv.github.io/course_labs/
```
