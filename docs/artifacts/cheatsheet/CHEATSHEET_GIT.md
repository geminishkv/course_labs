---
hide:
  - toc
---

<div class="hero-section">
  <div class="hero-content">
    <h1 class="hero-title">Git SCM</h1>
    <p class="hero-sub">Команды и флаги git</p>
  </div>
</div>

***

## Инициализация и подключение

```bash
git init                                      # Инициализация пустого локального репозитория
git remote add origin <URL>                   # Привязать удалённый репозиторий
git remote -v                                 # Показать подключённые удалённые репозитории
git remote show origin                        # Подробная информация о remote
git remote set-url origin <NEW_URL>           # Сменить URL удалённого репозитория
git clone <URL>                               # Клонировать репозиторий
```

## Основные команды

```bash
git status                                    # Состояние рабочей директории и индекса
git pull origin <branch>                      # Получить изменения из удалённой ветки
git add .                                     # Добавить все изменения в индекс
git add <file>                                # Добавить конкретный файл в индекс
git commit -S -m "message"                    # Подписанный коммит с сообщением
git push origin <branch>                      # Отправить изменения в удалённый репозиторий
git push --set-upstream origin <branch>       # Связать локальную ветку с удалённой
git show HEAD                                 # Информация о последнем коммите
git log --oneline --graph --decorate --all    # Граф истории коммитов
tree -I "dir1|dir2"                           # Дерево проекта с исключением каталогов
```

## Индексирование

```bash
git add -i                                    # Интерактивное добавление в индекс
git add -p                                    # Добавить изменения по частям (hunk)
git reset                                     # Убрать все изменения из индекса (сохранить в рабочей директории)
git reset <file>                              # Убрать из индекса конкретный файл
git reset HEAD <file>                         # Убрать файл из индекса (синоним)
git reset HEAD~                               # Отменить последний коммит (изменения останутся)
git reset --hard HEAD~                        # Удалить последний коммит вместе с изменениями
git reset --hard origin/<branch>              # Сбросить ветку до состояния удалённой (ОПАСНО)
git checkout -- <file>                        # Откатить файл до состояния в индексе (ОПАСНО)
git clean -df                                 # Удалить неотслеживаемые файлы и директории
git clean -fdn                                # Предварительный просмотр перед удалением
```

## Ветки

```bash
git branch                                    # Список локальных веток
git branch -a                                 # Список всех веток (включая удалённые)
git branch <name>                             # Создать новую ветку
git checkout <branch>                         # Переключиться на ветку
git checkout -b <branch>                      # Создать и переключиться
git branch -m <old> <new>                     # Переименовать ветку
git branch -d <branch>                        # Удалить локальную ветку
git push origin --delete <branch>             # Удалить ветку на удалённом репозитории
git push origin <new-name>                    # Опубликовать переименованную ветку
git branch -u origin/<branch> <branch>        # Установить upstream для ветки
```

## Слияние и ребейз

```bash
git merge <branch>                            # Слить ветку в текущую
git merge --no-ff <branch>                    # Слить без fast-forward (сохранить историю)
git rebase <branch>                           # Переместить коммиты поверх указанной ветки
git pull --rebase origin <branch>             # Получить изменения через rebase
git fetch origin                              # Получить изменения без слияния
git fetch --all --prune                       # Получить все ветки и удалить устаревшие
```

## Конфликты и восстановление

```bash
git status                                    # Показать файлы с конфликтами
git checkout -- <file>                        # Отменить изменение в файле
git reset --hard origin/<branch>              # Жёсткий сброс до удалённой ветки
git remote set-head origin -a                 # Обновить указатель HEAD удалённого репозитория
git stash                                     # Сохранить изменения во временное хранилище
git stash pop                                 # Восстановить последние сохранённые изменения
git stash list                                # Список сохранённых stash
```

***

![Logo](../assets/logotypemd.jpg)
