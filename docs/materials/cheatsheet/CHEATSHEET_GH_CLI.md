---
hide:
  - toc
title: "CheatSheet: GitHub CLI | Курс AppSec"
description: "GitHub CLI шпаргалка: команды gh для управления PR, issues, releases, репозиториями и аутентификации в DevSecOps-конвейере."
keywords: "GitHub CLI, gh, cheatsheet, шпаргалка, pull request, issues, releases, DevOps, AppSec, DevSecOps, аутентификация, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">GitHub CLI</h1>
    <p class="hero-sub">Команды и флаги gh</p>
  </div>
</div>

***

## Аутентификация

```bash
gh auth login                                 # Авторизоваться в GitHub
gh auth logout                                # Выйти из аккаунта
gh auth status                                # Проверить статус авторизации
gh auth refresh                               # Обновить токен
```

## Репозитории

```bash
gh repo create <name>                         # Создать публичный репозиторий
gh repo create <name> --private               # Создать приватный репозиторий
gh repo clone <user>/<repo>                   # Клонировать репозиторий
gh repo view                                  # Информация о текущем репозитории
gh repo view --web                            # Открыть репозиторий в браузере
gh repo list <user>                           # Список репозиториев пользователя
gh repo fork <user>/<repo>                    # Создать fork репозитория
gh repo delete <user>/<repo>                  # Удалить репозиторий (требует подтверждения)
```

## Pull Requests

```bash
gh pr create --title "Title" --body "Body"    # Создать PR из текущей ветки
gh pr create \
  --title "Title" \
  --body "Description" \
  --base main \
  --head feature-branch \
  --assignee "@me" \
  --draft                                     # Черновой PR с параметрами

gh pr list                                    # Список открытых PR
gh pr list --state all                        # Все PR (открытые + закрытые + merged)
gh pr view <number>                           # Просмотр PR
gh pr view --web                              # Открыть PR в браузере
gh pr checkout <number>                       # Переключиться на ветку PR
gh pr merge <number> --squash                 # Слить PR через squash
gh pr merge <number> --rebase                 # Слить PR через rebase
gh pr merge <number> --merge                  # Слить PR через merge commit
gh pr close <number>                          # Закрыть PR без слияния
gh pr review <number> --approve               # Одобрить PR
gh pr review <number> --request-changes -b "" # Запросить изменения
gh pr diff <number>                           # Показать diff PR
```

## Issues

```bash
gh issue list                                 # Список открытых issues
gh issue list --assignee "@me"                # Только назначенные на тебя
gh issue create --title "Bug" --body "Desc"   # Создать issue
gh issue view <number>                        # Просмотр issue
gh issue close <number>                       # Закрыть issue
gh issue reopen <number>                      # Переоткрыть issue
```

## Actions / Workflows

```bash
gh workflow list                              # Список workflows
gh workflow run <workflow.yml>                 # Запустить workflow вручную
gh run list                                   # Список запусков
gh run view <run-id>                          # Просмотр конкретного запуска
gh run watch <run-id>                         # Следить за запуском в реальном времени
gh run download <run-id>                      # Скачать артефакты запуска
```

## Releases

```bash
gh release list                               # Список релизов
gh release create <tag> --title "v1.0.0"      # Создать релиз
gh release create <tag> \
  --title "v1.0.0" \
  --notes "Release notes" \
  --target main \
  ./dist/*.tar.gz                             # Релиз с файлами
gh release view <tag>                         # Просмотр релиза
gh release delete <tag>                       # Удалить релиз
```

## Gist

```bash
gh gist create <file>                         # Создать gist из файла
gh gist create <file> --public                # Публичный gist
gh gist list                                  # Список своих gist
gh gist view <id> --web                       # Открыть gist в браузере
gh gist edit <id>                             # Редактировать gist
```
