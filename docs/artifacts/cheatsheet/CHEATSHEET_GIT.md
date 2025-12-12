---
hide:
  - toc
---

<div align="center">
<h1><a id="intro">CheatSheet</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a> 
<a href="https://symbl.cc/en/unicode-table"><img src="https://img.shields.io/static/v1?logo=unicode&logoColor=fff&label=&message=Unicode&color=36393f&style=flat" alt="Unicode"></a> 
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<a href="https://img.shields.io/badge/Risk_Analyze-2448a2"><img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/AppSec-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge"></a></div>

***

- gitscm

```bash
$ git init # Инициализация пустого локального репозитория
$ git remote add origin URL_link # Связывание удалённого репозитория с именем "origin" по ссылке "URL_link" с локальным

$ git pull origin name_branch # Ветка из которой мы берем изменения для тестирования
$ git remote show # Показать подключенные удалённые репозитории
$ git status 	# Показывает состояние локального репозитория (отслеживаемые, изменённые, новые файлы и пр.)

$ git add . # Добавить в индекс все новые, изменённые, удалённые файлы из текущей директории и её поддиректорий
$ git commit -S -m"added sources" # Зафиксировать в коммите проиндексированные изменения (закоммитить), добавить сообщение

$ git push origin name_branch # Отправляем изменения из локального репозитория в удалённый в ветку "name_branch"
$ git show HEAD # Информация о последнем комите (git log -1)
$ git push --set-upstream origin new-name # Установка upstream (связывает локальную ветку с удаленной)
$ git push origin :old-name # Удаление старой ветки в удаленном репо
$ git push origin new-name # Публикация новой ветки

$ git log --oneline --graph --decorate --all
$ tree -I "katalog|katalog" # Вывод с исключением каталогов для дерева проекта
```

- gitscm index

```bash
$ git add text.txt # Добавить в индекс указанный файл (был изменён, был удалён или это новый файл)
$ git add -i # Запустить интерактивную оболочку для добавления в индекс только выбранных файлов
$ git add -p # Показать новые/изменённые файлы по очереди с указанием их изменений и вопросом об отслеживании/индексировании

$ git reset # Убрать из индекса все добавленные в него изменения (в рабочей директории все изменения сохранятся), антипод git add
$ git reset readme.txt # Убрать из индекса изменения указанного файла (в рабочей директории изменения сохранятся)
$ git reset --hard # ОПАСНО: отменить изменения; вернуть то, что в коммите, на который указывает HEAD (незакомиченные изменения удалены из индекса и из рабочей директории, неотслеживаемые файлы останутся на месте)
$ git reset --hard origin/<branch_name>

$ git checkout text.txt # ОПАСНО: отменить изменения в файле, вернуть состояние файла, имеющееся в индексе
$ git clean -df # Удалить неотслеживаемые файлы и директории
$ git clean -fdn # Удаляет неотслеживаемые файлы и каталоги с предварительным просмотром
```

- gitscm конфликты

```bash

$ git remote set-url origin ssh://git@github.com_gitlab.com/username/newRepoName.git # Замена URL
$ git remote -v # Проверка правильности указанного link
$ git remote set-head origin -a
$ git pull --rebase origin name_branch # Переинициализация

$ git reset HEAD file # Убирает файл из индекса
$ git reset HEAD~ # Отмена последнего commit $ git reset --hard HEAD~ # Удаление commit с изменениями

$ git push origin --delete name_branch / git branch -rD origin/name_branch
$ git branch -d name_branch # Удаление локального репо
$ git checkout -- file # Отменяет изменение

$ git clean -fdn # Удаляет неотслеживаемые файлы и каталоги с предварительным просмотром

# Установка новой master/main ветки
$ git fetch origin
$ git fetch origin # Жесткая перезапись репозитория

$ git branch -u origin/gpages gpages
$ git branch -m master gpages
```

![Logo](../assets/logotypemd.jpg)