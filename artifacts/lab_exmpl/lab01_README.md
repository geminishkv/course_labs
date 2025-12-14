<div align="center">
<h1><a id="intro">Лабораторная работа №1</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a> 
<a href="https://symbl.cc/en/unicode-table"><img src="https://img.shields.io/static/v1?logo=unicode&logoColor=fff&label=&message=Unicode&color=36393f&style=flat" alt="Unicode"></a> 
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<a href="https://img.shields.io/badge/Risk_Analyze-2448a2"><img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/AppSec-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge"></a></div>

***

Салют :wave:,<br>
Данная лабораторная работа посвящена изучению систем обмена данными. Работа позволит ознакомиться с базовыми навыками необходимыми для произведения `commit changes`, публикации изменений в удаленный репозиторий, обновлениями данных для них, `fork` и тд.

Для сдачи данной работы также будет требоваться ответить на дополнительные вопросы по описанным темам.

***

## Структура репозитория лабораторной работы

```bash
lab01
├── README.md
└── typersteel.py
```

***

## Задание

- [ ] 1. Зарегистрироваться на почтовом сервисе **Gmail**. В случае наличия аккаунта - не требуется
- [ ] 2. Зарегистрироваться на сервисе совместной разработки **GitHub**. В случае наличия аккаунта требуется произвести дополнительные настройки и обновить данные персонификации
- [ ] 3. Отправить зарегистрированный адрес почтового ящика личным сообщением
- [ ] 4. Отправить зарегистрированный логин личным сообщением
- [ ] 5. Ознакомиться со ссылками учебного материала и формализованными требованиями из основного описания
- [ ] 6. Сгенерировать **SSH** ключ и добавить его в список ключей для сервиса **GitHub**
- [ ] 7. Сгенерировать **Personal Token** с правами **gist** и сохранить его в файл
- [ ] 8. Сгенерировать GnuPG для подтверждения подписания коммитов и возможно использование Х.509 (включить в отчет описание, что такое `smimesign`)
- [ ] 9. Подготовить глобальные переменные окружения для **GitHub**
- [ ] 10. Ознакомиться с материалами `gh` сервиса и использовать их для авторизации, `commit`, `pull request` и тд.
- [ ] 11. Выполнить инструкцию учебного материала
- [ ] 12. Оформить `README.md` по аналогии и использовать `shield`, etc.
- [ ] 13. Составить `gist` отчет и отправить ссылку личным сообщением

***

## Tutorial

-  Подготовка пространства: установить [Oracle VMBox](https://www.virtualbox.org) и монтировать образ [Ubuntu](https://ubuntu.com/download), [Fedora](https://fedoraproject.org), [FreeBSD](https://www.freebsd.org), либо использовать личное устройство
    -  [Помощь](https://wiki.merionet.ru/articles/ustanovka-ubuntu-linux-na-virtual-box?ysclid=mi2bbxscjo286504194) для корректной настройки образа виртуальной машины или используйте иной материал. Обратите внимание на расширение при установке, сайзинг, ограничение памяти, выделяемый ресурс от своей рабочей машины.

-  Подготовить переменные окружения через конфигурацию git config на одном из трёх уровней:
    - Локальный (--local) - только для текущего репозитория, файл .git/config
    - Глобальный (--global) - для пользователя, файл ~/.gitconfig
    - Системный (--system) - для всех пользователей /etc/gitconfig

```bash
$ git config --global user.name "Ваше Имя" # Установить имя пользователя (глобально)
$ git config --global user.email "email@example.com" # Установить email пользователя (глобально)
$ git config --global core.editor "vim" # Установить текстовый редактор по умолчанию или nano
$ git config unset --global user.email # Удалить глобальную настройку email. Допустима замена "unset" на "--unset"
$ git config edit --global # Редактирование конфига на указанном уровне в редакторе "core.editor". Допустима замена "edit" на "-e"
$ git config list # Показать все текущие настройки. Допустима замена "list" на "--list"
$ git config user.name # Показать имя пользователя. Без атрибутов — локальная настройка
$ git config --global alias.co checkout # Создать псевдоним (например, "git co" вместо "git checkout")
$ git config --global help.autocorrect prompt # Предложения автозамены при ошибке набора команды.
$ git config --global core.autocrlf true # Настроить конвертацию концов строк (для Windows: "true", для Linux/macOS: "input")
$ git config --global credential.helper cache # Кэшировать учётные данные. По умолчанию 15 минут. Укажи "cache --timeout=3600" для часа. Не работает для пассфраз ключей.
$ git config --global commit.gpgsign true # Настроить автоматическое подписание коммитов
```

- Поставьте на машину необходимые компоненты для `gitscm`, `GitHub CLI`
- Поставьте дополнительные пакеты для своего удобства, рекомендуется поставить `zsh` 

```bash
$ echo $SHELL
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" # Homebrew
$ brew install zsh
$ zsh --version
```
- Поставьте `GnuPG` и используйте для подписания коммитов флагом `-S`

```bash
$ gpg --full-generate-key # Создание ключа с выбором его типа
$ gpg --list-secret-keys --keyid-format=long # Вывод всех ключей в длинной форме
$ gpg --armor --export xxxxxx  # Экспорт публичного ключа в ASCII формате (замените xxxxxx на ваш ключ)
$ git config --global --unset gpg.format
$ git config --global user.signingkey # Внесение вложенного ключа (обоих)
$ git config --global commit.gpgsign true # Подпись всех фиксаций
$ git config --global tag.gpgSign true # Подпись всех тегов
```

- Подготовьте и опишите материалы в отчете:
    1. Создайте локальный репозиторий на машине
    2. Проинициализируйте репозиторий
    3. Авторизуйтесь и используйте `GitHub CLI` для создания удаленного репозитория
    4. Создайте пустой README.md 
    5. Используйте указание URL своего созданного репозитория для присвоения ветки `master` статуса `origin`
    6. В локальном репозитории и сделайте `commit`
    7. Сделайте публикацию своего `commit` с флагом `-S` в удаленный репозиторий
    8. Создайте файл `hello.py` в локальном репозитории. Реализуйте **Hello appsec world** на языке python используя несколько интерпретаторов с "грязным" кодом
    9. Сделайте `commit` с флагом `-S`
    10. Измените исходный код, что бы скрипт запрашивал имя пользователя и выводил `Hello appsec world from @name`
    11. Сделайте `commit` с флагом `-S` и сделайте публикацию в удаленный репозиторий. Проверьте вывод истории изменений
    12. В локальном репозитории создайте ветку `patch1` и внесите изменения исправлению кода и модернизации до следующего вида, что бы код был рабочим. Сделайте публикацию своего `commit` с флагом `-S` в удаленный репозиторий:

```bash
import typer

def main(
    name: str,
    lastname: str = typer.Option("", help="Фамилия пользователя."),
    formal: bool = typer.Option(False, "--formal", "-f", help="Использовать формальное приветствие."),
):
    """
    Говорит "Привет" пользователю, опционально используя фамилию и формальный стиль.
    """
    if formal:
        print(f"Добрый день, {name} {lastname}!")
    else:
        print(f"Привет, {name}!")

if __name__ == "__main__":
    typer.run(main)
```

 - Доработайте материалы и также опишите их в отчете: 
    1. Проверьте, что ветка `patch1` в удалённом репозитории
    2. Создайте `pull-request` в виде `patch1 -> master`
    3. В ветке `patch1` добавьте в исходный код комментарии и убедитесь, что есть указанные изменения в `pull-request`
    4. В удалённый репозитории выполните слияние `pull-request` для `patch1 -> master` и удалите ветку `patch1`
    5. Стяните последние актуальные изменения и просмотрите историю изменений для `master`
    6. Удалите локальную ветку `patch1`
    7. Создайте новую локальную ветку `patch2`.
    8. Измените *code style* по своему усмотрению
    9. Сделайте публикацию своего `commit` с флагом `-S` в удаленный репозиторий и создайте pull-request `patch2 -> master`
    10. В ветке **master** удаленного репозитория явно измените комментарий
    11. Увидите, что в `pull-request` появились расхождения
    12. Локально сделайте **rebase** и исправьте расхождения (это называется **конфликт**)
    13. Сделайте `commit` и опубликуйте изменения в ветке `patch2`
    14. Убедитесь, что пропали конфликтны. 
    15. Сделайте `merge` для `pull-request` `patch2 -> master`.
    16. Подготовьте отчет `gist`.
    17. Продемонстрируйте в материалах отчета историю коммитов на локальном и удаленном репозитории.

***

## Links

- [Google Sheets](https://www.google.ru/intl/ru/sheets/about/)
- [Google Docs](https://www.google.ru/intl/ru/docs/about/)
- [GitHub](https://github.com)
- [GitHub SSH Key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
- [Markdown](https://stackedit.io)
- [Gist](https://gist.github.com)
- [GitHub Personal Token](https://github.com/settings/tokens/new)
- [GitHub CLI](https://cli.github.com)

Copyright (c) 2025 Elijah S Shmakov

![Logo](../../assets/logotype/logo.jpg)