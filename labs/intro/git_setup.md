<div align="center">
<h1><a id="intro">Настройка Git, GPG и GitHub CLI</a><br></h1>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/git-%23F05033.svg?style=flat&logo=git&logoColor=white" alt="Git">
<img src="https://img.shields.io/badge/GitHub_CLI-181717?style=flat&logo=github&logoColor=white" alt="GitHub CLI">
<img src="https://img.shields.io/badge/GnuPG-0093DD?style=flat&logo=gnuprivacyguard&logoColor=white" alt="GnuPG">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Данное руководство описывает настройку Git, SSH-ключей, GnuPG для подписания коммитов и GitHub CLI. Выполняется один раз перед началом лабораторных работ.

***

## Переменные окружения Git

Git config работает на трёх уровнях:

- `--local` — только для текущего репозитория, файл `.git/config`
- `--global` — для пользователя, файл `~/.gitconfig`
- `--system` — для всех пользователей, `/etc/gitconfig`

```bash
$ git config --global user.name "Ваше Имя"
$ git config --global user.email "email@example.com"
$ git config --global core.editor "vim"                    # или nano
$ git config --global alias.co checkout                    # git co вместо git checkout
$ git config --global help.autocorrect prompt              # автозамена при опечатке
$ git config --global core.autocrlf true                   # Windows: true, Linux/macOS: input
$ git config --global credential.helper cache              # кэш учётных данных (15 мин)
$ git config --global commit.gpgsign true                  # автоподпись коммитов
```

Полезные команды:

```bash
$ git config list                                          # показать все настройки
$ git config user.name                                     # показать конкретную
$ git config edit --global                                 # открыть конфиг в редакторе
$ git config unset --global user.email                     # удалить настройку
```

***

## Установка Git и GitHub CLI

```bash
# Ubuntu / Debian
$ sudo apt install -y git
$ curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
$ sudo apt update && sudo apt install gh -y

# Fedora
$ sudo dnf install -y git gh

# macOS
$ brew install git gh
```

Авторизация:

```bash
$ gh auth login                                            # интерактивная авторизация
$ gh auth status                                           # проверка
```

***

## SSH-ключ для GitHub

```bash
$ ssh-keygen -t ed25519 -C "email@example.com"             # генерация ключа
$ eval "$(ssh-agent -s)"                                   # запуск агента
$ ssh-add ~/.ssh/id_ed25519                                # добавление ключа в агент
$ cat ~/.ssh/id_ed25519.pub                                # скопировать публичный ключ
```

Добавить ключ в GitHub: `Settings → SSH and GPG keys → New SSH key` → вставить содержимое `.pub`

Проверка:

```bash
$ ssh -T git@github.com                                    # ожидается: "Hi username!"
```

***

## GnuPG для подписания коммитов

GPG-подпись подтверждает авторство коммита. GitHub показывает зелёный бейдж `Verified`.

```bash
$ gpg --full-generate-key                                  # создание ключа (RSA 4096, срок — 1 год)
$ gpg --list-secret-keys --keyid-format=long               # список ключей
```

Вывод покажет строку вида `sec rsa4096/ABCDEF1234567890` — `ABCDEF1234567890` это ваш KEY ID.

```bash
$ gpg --armor --export ABCDEF1234567890                    # экспорт публичного ключа
```

Скопируйте вывод (от `-----BEGIN PGP PUBLIC KEY BLOCK-----` до `-----END`) и добавьте в GitHub: `Settings → SSH and GPG keys → New GPG key`

Настройка Git:

```bash
$ git config --global user.signingkey ABCDEF1234567890     # указать ключ
$ git config --global commit.gpgsign true                  # автоподпись коммитов
$ git config --global tag.gpgSign true                     # автоподпись тегов
```

Коммит с подписью:

```bash
$ git commit -S -m "feat: signed commit"                   # -S для явной подписи
$ git log --show-signature -1                              # проверка подписи
```

> **smimesign** — альтернатива GPG для подписания коммитов через X.509 сертификаты (корпоративные PKI). Используется в организациях с существующей PKI-инфраструктурой вместо GPG.

***

## Установка zsh (опционально)

```bash
# Ubuntu / Debian
$ sudo apt install zsh -y

# macOS
$ brew install zsh

# Проверка
$ zsh --version

# Сделать дефолтным
$ chsh -s $(which zsh)

# Oh My Zsh (опционально)
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

***

## Personal Access Token

Нужен для работы с Gist и API.

- [ ] Перейдите на [github.com/settings/tokens/new](https://github.com/settings/tokens/new)
- [ ] Выберите scope: `gist`
- [ ] Сгенерируйте и **сохраните токен** — он показывается только один раз

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/materials/troubleshooting/).

***

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://git-scm.com/book/ru/v2" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Pro Git Book</div><div class="lab-card-tags"><span class="lab-tag">git-scm.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.github.com/en/authentication/connecting-to-github-with-ssh" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub SSH Key</div><div class="lab-card-tags"><span class="lab-tag">docs.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gnupg.org/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GnuPG</div><div class="lab-card-tags"><span class="lab-tag">gnupg.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/github/smimesign" target="_blank"><div class="lab-card-body"><div class="lab-card-title">smimesign (X.509)</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
