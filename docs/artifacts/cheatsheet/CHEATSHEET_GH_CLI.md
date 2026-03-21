---
hide:
  - toc
---

<!-- markdownlint-disable MD013 -->
<div align="center">
<h1><a id="intro">CheatSheet — GitHub CLI</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a>
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt="RA">
<img src="https://img.shields.io/badge/AppSec-2448a2" alt="AppSec">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge">
</div>
<!-- markdownlint-enable MD013 -->

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

***

![Logo](../assets/logotypemd.jpg)
