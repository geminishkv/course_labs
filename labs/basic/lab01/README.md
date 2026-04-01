<div align="center">
<h1><a id="intro">Лабораторная работа №1</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a>
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/git-%23F05033.svg?style=flat&logo=git&logoColor=white" alt="Git">
<img src="https://img.shields.io/badge/GitHub_CLI-181717?style=flat&logo=github&logoColor=white" alt="GitHub CLI">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

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

## Материал

Git — распределённая система контроля версий. Ключевые концепции:

- **Working tree** — файлы на диске, с которыми вы работаете
- **Staging area (index)** — промежуточная область: `git add` переносит изменения сюда
- **Commit** — снимок состояния, сохранённый в локальном репозитории
- **Remote** — удалённый репозиторий (GitHub), синхронизация через `push` / `pull`

> Поток: `edit` → `git add` → `git commit` → `git push` — это базовый цикл, который вы будете повторять в каждой лабораторной

- **Ветки (branches)** — параллельные линии разработки. `master` / `main` — основная ветка, `develop` — рабочая, `patch*` — для исправлений
- **Pull Request** — запрос на слияние ветки в основную. Используется для code review и согласования изменений
- **Rebase** — перенос коммитов на другую базу. Создаёт линейную историю, но переписывает SHA-хеши
- **GPG-подпись** — криптографическое подтверждение авторства коммита. GitHub показывает зелёный бейдж `Verified`

### typersteel.py

Файл `typersteel.py` — пример Python-скрипта с использованием библиотеки `typer` для создания CLI-приложений. В задании вы будете модифицировать его: от простого "Hello World" до полноценного CLI с аргументами и опциями.

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

> Перед началом выполните подготовительные инструкции:
>
> - [Подготовка рабочего окружения](https://course.geminishkv.tech/labs/intro/vmbox_tutorial/) — VirtualBox, установка Linux
> - [Настройка Git, GPG и GitHub CLI](https://course.geminishkv.tech/labs/intro/git_setup/) — git config, SSH, GnuPG, gh

- [ ] 1. Создайте локальный репозиторий на машине и проинициализируйте его
- [ ] 2. Авторизуйтесь и используйте `GitHub CLI` для создания удаленного репозитория
- [ ] 3. Создайте пустой README.md и используйте указание URL своего созданного репозитория для присвоения ветки `master` статуса `origin`
- [ ] 4. В локальном репозитории сделайте `commit` и публикацию с флагом `-S` в удаленный репозиторий
- [ ] 5. Создайте файл `hello.py`. Реализуйте **Hello appsec world** на языке python используя несколько интерпретаторов с "грязным" кодом. Сделайте `commit` с флагом `-S`
- [ ] 6. Измените исходный код, чтобы скрипт запрашивал имя пользователя и выводил `Hello appsec world from @name`. Сделайте `commit` с флагом `-S` и публикацию. Проверьте историю изменений
- [ ] 7. В локальном репозитории создайте ветку `patch1` и внесите изменения исправлению кода и модернизации до следующего вида, чтобы код был рабочим. Сделайте публикацию своего `commit` с флагом `-S` в удаленный репозиторий:

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

- [ ] 8. Проверьте, что ветка `patch1` в удалённом репозитории
- [ ] 9. Создайте `pull-request` в виде `patch1 -> master`
- [ ] 10. В ветке `patch1` добавьте в исходный код комментарии и убедитесь, что есть указанные изменения в `pull-request`
- [ ] 11. В удалённом репозитории выполните слияние `pull-request` для `patch1 -> master` и удалите ветку `patch1`
- [ ] 12. Стяните последние актуальные изменения и просмотрите историю изменений для `master`. Удалите локальную ветку `patch1`
- [ ] 13. Создайте новую локальную ветку `patch2`. Измените *code style* по своему усмотрению
- [ ] 14. Сделайте публикацию своего `commit` с флагом `-S` и создайте pull-request `patch2 -> master`
- [ ] 15. В ветке **master** удаленного репозитория явно измените комментарий. Увидите, что в `pull-request` появились расхождения
- [ ] 16. Локально сделайте **rebase** и исправьте расхождения (это называется **конфликт**)
- [ ] 17. Сделайте `commit` и опубликуйте изменения в ветке `patch2`. Убедитесь, что пропали конфликты
- [ ] 18. Сделайте `merge` для `pull-request` `patch2 -> master`
- [ ] 19. Подготовьте отчет `gist`. Продемонстрируйте историю коммитов на локальном и удаленном репозитории

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/troubleshooting/).

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://git-scm.com/book/ru/v2" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Pro Git Book</div><div class="lab-card-tags"><span class="lab-tag">git-scm.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.github.com/en" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub Docs</div><div class="lab-card-tags"><span class="lab-tag">docs.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.github.com/en/authentication/connecting-to-github-with-ssh" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub SSH Key</div><div class="lab-card-tags"><span class="lab-tag">docs.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/settings/tokens/new" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub Personal Token</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gnupg.org/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GnuPG</div><div class="lab-card-tags"><span class="lab-tag">gnupg.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://www.markdownguide.org/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Markdown Guide</div><div class="lab-card-tags"><span class="lab-tag">markdownguide.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gist.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Gist</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://typer.tiangolo.com/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Typer Documentation</div><div class="lab-card-tags"><span class="lab-tag">typer.tiangolo.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
