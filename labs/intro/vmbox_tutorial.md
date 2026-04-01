<div align="center">
<h1><a id="intro">Подготовка рабочего окружения</a><br></h1>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/VirtualBox-183A61?style=flat&logo=virtualbox&logoColor=white" alt="VirtualBox">
<img src="https://img.shields.io/badge/Ubuntu-E95420?style=flat&logo=ubuntu&logoColor=white" alt="Ubuntu">
<img src="https://img.shields.io/badge/Fedora-51A2DA?style=flat&logo=fedora&logoColor=white" alt="Fedora">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Данное руководство описывает установку Oracle VirtualBox и развёртывание Linux-машины для выполнения лабораторных работ по курсу AppSec.

> Если вы используете личное устройство с Linux/macOS — VirtualBox не обязателен. Убедитесь, что доступны: `git`, `docker`, `python3`, `nmap`.

***

## 1. Скачивание и установка VirtualBox

- [ ] 1.1. Перейдите на [virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
- [ ] 1.2. Скачайте установщик для вашей ОС:
    - **Windows:** `VirtualBox-x.x.x-Win.exe`
    - **macOS (Intel):** `VirtualBox-x.x.x-macOS-amd64.dmg`
    - **macOS (Apple Silicon):** `VirtualBox-x.x.x-macOS-arm64.dmg` (требуется VirtualBox 7.1+)
    - **Linux:** пакет `.deb` или `.rpm` для вашего дистрибутива
- [ ] 1.3. Установите VirtualBox, следуя инструкциям установщика
- [ ] 1.4. Скачайте **Extension Pack** с той же страницы и установите его через `VirtualBox → Настройки → Плагины`

> Extension Pack добавляет поддержку USB 3.0, RDP и PXE boot — полезно для лабораторных с сетевым сканированием.

***

## 2. Выбор и скачивание образа ОС

Рекомендуемые дистрибутивы (любой на выбор):

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
  <a class="lab-card" href="https://ubuntu.com/download/desktop" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Ubuntu 24.04 LTS Desktop</div><div class="lab-card-tags"><span class="lab-tag">Рекомендуется</span><span class="lab-tag">GUI</span><span class="lab-tag">apt</span></div></div><div class="lab-card-arrow">→</div></a>
  <a class="lab-card" href="https://ubuntu.com/download/server" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Ubuntu 24.04 LTS Server</div><div class="lab-card-tags"><span class="lab-tag">Без GUI</span><span class="lab-tag">Минимальный</span><span class="lab-tag">apt</span></div></div><div class="lab-card-arrow">→</div></a>
  <a class="lab-card" href="https://fedoraproject.org/workstation/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Fedora Workstation 41</div><div class="lab-card-tags"><span class="lab-tag">Актуальные пакеты</span><span class="lab-tag">dnf</span></div></div><div class="lab-card-arrow">→</div></a>
  <a class="lab-card" href="https://www.freebsd.org/where/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">FreeBSD 14</div><div class="lab-card-tags"><span class="lab-tag">Продвинутый</span><span class="lab-tag">pkg</span></div></div><div class="lab-card-arrow">→</div></a>
</div>

- [ ] 2.1. Скачайте ISO-образ выбранного дистрибутива

***

## 3. Создание виртуальной машины

- [ ] 3.1. Откройте VirtualBox → `Создать` (Machine → New)
- [ ] 3.2. Заполните параметры:
    - **Имя:** `appsec-lab` (любое понятное название)
    - **Тип:** `Linux`
    - **Версия:** `Ubuntu (64-bit)` / `Fedora (64-bit)` — в зависимости от выбранного дистрибутива
    - **Оперативная память:** `4096 MB` (минимум 2048, не более 50% RAM хост-машины)
    - **Процессоры:** `2 CPU` (минимум 1, не более 50% ядер хост-машины)
    - **Жёсткий диск:** `25 GB` (минимум 20, динамический VDI — занимает место по мере заполнения)
- [ ] 3.3. Нажмите `Создать`

***

## 4. Настройка виртуальной машины

Перед первым запуском настройте VM:

- [ ] 4.1. **Система → Материнская плата:**
    - Порядок загрузки: `Оптический диск` первым, затем `Жёсткий диск`
    - Включить `EFI` (для Ubuntu 24.04)
- [ ] 4.2. **Система → Процессор:**
    - Включить `PAE/NX`
    - Включить `VT-x/AMD-V` (вложенная виртуализация — нужна для Docker)
- [ ] 4.3. **Дисплей:**
    - Видеопамять: `128 MB`
    - Графический контроллер: `VMSVGA`
- [ ] 4.4. **Носители:**
    - Нажмите на пустой диск → иконка диска справа → `Выбрать файл` → укажите скачанный ISO
- [ ] 4.5. **Сеть:**
    - Адаптер 1: `NAT` (доступ в интернет)
    - Для лабораторной с Nmap (Lab 03): добавьте Адаптер 2 → `Внутренняя сеть` или `Виртуальный адаптер хоста`

***

## 5. Установка ОС

- [ ] 5.1. Запустите VM → загрузится с ISO
- [ ] 5.2. Следуйте стандартному установщику:
    - Язык: English (рекомендуется для совместимости с инструментами)
    - Разметка диска: `Erase disk and install` (для VM безопасно)
    - Имя пользователя и пароль — запомните, понадобятся для `sudo`
- [ ] 5.3. После установки — перезагрузите VM
- [ ] 5.4. Извлеките ISO: `Устройства → Оптические диски → Извлечь диск`

***

## 6. Первичная настройка после установки

- [ ] 6.1. Обновите систему:

```bash
# Ubuntu / Debian
$ sudo apt update && sudo apt upgrade -y

# Fedora
$ sudo dnf update -y
```

- [ ] 6.2. Установите базовые инструменты:

```bash
# Ubuntu / Debian
$ sudo apt install -y git curl wget tree vim nano htop net-tools \
    python3 python3-pip python3-venv \
    docker.io docker-compose nmap

# Fedora
$ sudo dnf install -y git curl wget tree vim nano htop net-tools \
    python3 python3-pip \
    docker docker-compose nmap
```

- [ ] 6.3. Добавьте пользователя в группу Docker (без sudo):

```bash
$ sudo usermod -aG docker $USER
$ newgrp docker
$ docker run hello-world  # проверка
```

- [ ] 6.4. Установите GitHub CLI:

```bash
# Ubuntu / Debian
$ curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
$ sudo apt update && sudo apt install gh -y

# Fedora
$ sudo dnf install gh -y
```

- [ ] 6.5. (Опционально) Установите `zsh` и `oh-my-zsh`:

```bash
$ sudo apt install zsh -y   # или sudo dnf install zsh
$ chsh -s $(which zsh)
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

***

## 7. Установка Guest Additions (для удобства)

Guest Additions добавляют: общий буфер обмена, drag & drop, автоматическое масштабирование экрана, общие папки.

- [ ] 7.1. В меню VM: `Устройства → Подключить образ диска Дополнений гостевой ОС`
- [ ] 7.2. Установите:

```bash
$ sudo apt install -y build-essential dkms linux-headers-$(uname -r)  # зависимости
$ sudo mount /dev/cdrom /mnt
$ sudo /mnt/VBoxLinuxAdditions.run
$ sudo reboot
```

- [ ] 7.3. После перезагрузки включите: `Устройства → Общий буфер обмена → Двунаправленный`

***

## 8. Проверка готовности

- [ ] 8.1. Проверьте, что всё установлено:

```bash
$ git --version
$ python3 --version
$ docker --version
$ nmap --version
$ gh --version
```

- [ ] 8.2. Если все команды возвращают версии — окружение готово к лабораторным работам.

***

## Рекомендации по ресурсам

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));">
  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">8 GB RAM</div>
    <div class="lab-card-tags"><span class="lab-tag">VM: 2-3 GB</span><span class="lab-tag">2 CPU</span><span class="lab-tag">20 GB диск</span></div>
  </div>
  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">16 GB RAM</div>
    <div class="lab-card-tags"><span class="lab-tag">VM: 4-6 GB</span><span class="lab-tag">2-4 CPU</span><span class="lab-tag">25 GB диск</span></div>
  </div>
  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div class="lab-card-title" style="font-weight:700;">32+ GB RAM</div>
    <div class="lab-card-tags"><span class="lab-tag">VM: 8 GB</span><span class="lab-tag">4 CPU</span><span class="lab-tag">40 GB диск</span></div>
  </div>
</div>

> Не выделяйте VM более 50% ресурсов хост-машины — иначе хост будет тормозить.

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/troubleshooting/).

***

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://www.virtualbox.org/manual/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">VirtualBox Documentation</div><div class="lab-card-tags"><span class="lab-tag">virtualbox.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://ubuntu.com/tutorials/install-ubuntu-desktop" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Ubuntu Installation Guide</div><div class="lab-card-tags"><span class="lab-tag">ubuntu.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.fedoraproject.org/en-US/fedora/latest/install-guide/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Fedora Installation Guide</div><div class="lab-card-tags"><span class="lab-tag">docs.fedoraproject.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.docker.com/engine/install/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker Engine Installation</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/cli/cli#installation" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI Installation</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
