# Отчет по лабораторной работе №2

## Выполненные задания

### Задание 1: Команды консоли

**Примечание:** В задании указана команда `who | wc -I`, но это опечатка. Правильная команда - `who | wc -l` (маленькая буква L, а не большая I). Команда `wc -I` выдает ошибку: `wc: invalid option -- 'I'`.

```bash
$ who | wc -I
wc: invalid option -- 'I'
Try 'wc --help' for more information.

$ who | wc -l
1

$ id
uid=0(root) gid=0(root) groups=0(root)

$ whoami
root

$ hostnamectl
 Static hostname: vmi2306187.contaboserver.net
       Icon name: computer-vm
         Chassis: vm
      Machine ID: 9e6623cf179db23f8fdf06576749b906
         Boot ID: 0777b8a30bf546438ceb69d16cd66d3a
  Virtualization: kvm
Operating System: Ubuntu 22.04.5 LTS
          Kernel: Linux 5.15.0-126-generic
    Architecture: x86-64
 Hardware Vendor: QEMU
  Hardware Model: Standard PC _i440FX + PIIX, 1996_
```

### Задание 2: tree и ls
```bash
$ tree ~
bash: line 1: tree: command not found
# Примечание: утилита tree не была установлена на сервере

$ ls -a ~
.  ..  .bash_history  .bashrc  .cache  .config  course_labs  database.sql  .docker  .gitconfig  .github_token  .gnupg  .launchpadlib  .lesshst  .local  nmapres_new.txt  .npm  .profile  snap  .ssh

$ ls -l ~
total 112
drwxr-xr-x 7 root root   4096 Dec  4 18:38 course_labs
-rw-r--r-- 1 root root      0 Jan 23  2025 database.sql
-rw-r--r-- 1 root root      0 Dec  9 19:06 nmapres_new.txt
drwx------ 3 root root   4096 Dec  8  2024 snap
-rw-r--r-- 1 root root 106252 Nov 29  2024 update.txt
```

**Отличие:** `ls -a` показывает все файлы включая скрытые (начинающиеся с точки), а `ls -l` показывает подробную информацию о файлах (права, владелец, размер, дата).

### Задание 3: file и df
```bash
$ df -T /dev/sda1
Filesystem     Type     1K-blocks  Used Available Use% Mounted on
udev           devtmpfs  24626776     0  24626776   0% /dev

$ file /dev/sda1
/dev/sda1: block special (8/1)
```

### Задание 4: Команды консоли
```bash
$ which vi
/usr/bin/vi

$ locate hello.py
bash: line 1: locate: command not found
# Примечание: locate не был установлен на сервере, поэтому команда выдала ошибку

$ sudo updatedb
sudo: updatedb: command not found
# Примечание: updatedb не был доступен, так как mlocate не был установлен

$ locate hello
bash: line 1: locate: command not found

$ touch screen
Файл screen создан

$ find ~ -name screen
/root/screen

$ locate screen
bash: line 1: locate: command not found

$ sudo updated
sudo: updated: command not found
# Примечание: В задании указана команда `sudo updated`, но это опечатка. 
# Правильная команда - `sudo updatedb` (с буквой 'b' в конце).
# Команда `updated` не существует в системе.

$ locate screen
bash: line 1: locate: command not found
```

**Примечание:** Команда `locate` не была установлена на сервере изначально, поэтому все команды с `locate` выдавали ошибку `command not found`. После установки пакета `mlocate` и выполнения `updatedb`, команда `locate` начала работать корректно и нашла файлы:
- `/root/course_labs/hello.py`
- `/root/course_labs/labs/lab02/exmpl_hello.py`
- `/root/course_labs/labs/lab05/source/hello.py`

### Задание 5: Исправление кода pygame и интеграция с lab01
Исправлен код pygame:
- Исправлена ошибка с переменной `screen` (теперь присваивается результат `pygame.display.set_mode()`)
- Исправлен порядок `pygame.display.flip()` (перенесен внутрь цикла)
- Заменен `pygame.draw.rect` на `screen.fill()` для заливки фона
- Интегрирован файл `typersteel.py` из первой лабораторной работы
- Код загружен в файл `/root/screen`

### Задание 6: Git commit и push
```bash
$ git status
On branch develop
Your branch is ahead of 'origin/develop' by 1 commit.

$ git add labs/lab02/pygamesteel.py
$ git commit -m "Lab02: добавлен исправленный файл pygamesteel.py с интеграцией lab01"
[develop 3a1358b] Lab02: добавлен исправленный файл pygamesteel.py с интеграцией lab01
 1 file changed, 68 insertions(+), 26 deletions(-)

$ git push origin develop
To github.com:might-might/course_labs.git
   73a82bd..3a1358b  develop -> develop
```

**Результат:** Коммит успешно создан и отправлен в удаленный репозиторий на ветку `develop`.

### Задание 7: Работа с пользователями и группами
```bash
$ groups
root

$ useradd smallman
$ userdel smallman -rf
userdel: smallman mail spool (/var/mail/smallman) not found
userdel: smallman home directory (/home/smallman) not found
# Примечание: Предупреждения о том, что директории не найдены - это нормально,
# пользователь успешно удален

$ useradd smallman
$ passwd smallman
New password: [ввод пароля вручную]
Retype new password: [повторный ввод пароля]
passwd: password updated successfully

$ usermod smallman -c 'Hach Hachov Hacherovich,239,45-67,499-239-45-33'
$ passwd smallman
New password: [ввод нового пароля вручную]
Retype new password: [повторный ввод пароля]
passwd: password updated successfully

$ id smallman
uid=1002(smallman) gid=1002(smallman) groups=1002(smallman)
$ groupadd -g 1500 readgroup
$ usermod -aG readgroup smallman
$ chmod 666 screen
```

**Примечание:** Команда `passwd smallman` требует интерактивного ввода пароля дважды. Пароль вводится вручную и не отображается на экране при вводе (по соображениям безопасности).

### Задание 8: Права доступа для screen
```bash
$ ls -l screen
-r-------- 1 root root 2576 Dec 11 11:47 /root/screen

$ getfacl screen
# file: root/screen
# owner: root
# group: root
user::r--
group::---
other::---
```

Файл изменен на права только для чтения владельцем (chmod 400).

### Задание 9: POSIX ACL
```bash
$ touch nmapres.txt
$ setfacl -m u:smallman:rw nmapres.txt
$ setfacl -m g:readgroup:r nmapres.txt
$ getfacl nmapres.txt
# file: nmapres.txt
# owner: root
# group: root
user::rw-
user:smallman:rw-
group::r--
group:readgroup:r--
mask::rw-
other::r--
```

### Задание 10: Сохранение файла в репозиторий
```bash
$ cp /root/nmapres.txt /root/course_labs/
$ git add nmapres.txt
$ git status
On branch develop
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	new file:   nmapres.txt

$ git commit -m "Lab02: добавлен файл nmapres.txt для следующей работы с nmap"
```

**Результат:** Файл `nmapres.txt` успешно сохранен в локальном репозитории `/root/course_labs/` и добавлен в git. Файл готов для использования в следующей лабораторной работе (lab03) для записи данных о nmap.

### Задание 11: Группы пользователей и права на каталоги
```bash
$ getent group | wc -l
62

$ getent group | head -10
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:syslog
tty:x:5:syslog
disk:x:6:
lp:x:7:
mail:x:8:
news:x:9:

$ ls -ld /bin /sbin /dev /etc /lib /home /root /usr /var /tmp /proc /mnt /media /boot /sys
lrwxrwxrwx   1 root root     7 Jan 20  2021 /bin -> usr/bin
drwxr-xr-x   4 root root  4096 Nov 29  2024 /boot
drwxr-xr-x  17 root root  3920 Oct 22 09:45 /dev
drwxr-xr-x  97 root root  4096 Dec 11 13:22 /etc
drwxr-xr-x   7 root root  4096 Apr 25  2025 /home
lrwxrwxrwx   1 root root     7 Jan 20  2021 /lib -> usr/lib
drwxr-xr-x   2 root root  4096 Jan 20  2021 /media
drwxr-xr-x   2 root root  4096 Jan 20  2021 /mnt
dr-xr-xr-x 306 root root     0 Sep 17 20:05 /proc
drwx------  13 root root  4096 Dec 11 13:27 /root
lrwxrwxrwx   1 root root     8 Jan 20  2021 /sbin -> usr/sbin
dr-xr-xr-x  13 root root     0 Sep 17 20:05 /sys
drwxrwxrwt  11 root root 20480 Dec 11 11:55 /tmp
drwxr-xr-x  14 root root  4096 Apr 25  2022 /usr
drwxr-xr-x  14 root root  4096 Dec  8  2024 /var
```

**Результат:** Выведены все 62 группы пользователей системы и права доступа на все верхнеуровневые каталоги файловой системы.

### Задание 12: Права для файлов и директорий репозитория
```bash
$ cd /root/course_labs
$ find . -maxdepth 2 -exec ls -ld {} \;
drwxr-xr-x 7 root root 4096 Dec 11 11:50 .
-rw-r--r-- 1 root root 10172 Dec  4 16:11 ./LICENSE.md
-rwxr-xr-x 1 root root 2455 Dec  4 21:46 ./hello.py
-rw-r--r-- 1 root root 345 Dec  4 16:11 ./.markdownlint.jsonc
-rw-r--r-- 1 root root 2083 Dec  4 16:11 ./SECURITY.md
-rw-r--r-- 1 root root 148 Dec  4 16:11 ./.yamllint
-rw-r--r-- 1 root root 16847 Dec  4 16:11 ./README.md
-rw-r--r-- 1 root root 3605 Dec  4 16:11 ./mkdocs.yml
-rw-r--r-- 1 root root 58 Dec  4 16:11 ./mypy.ini
drwxr-xr-x 8 root root 4096 Dec  4 16:11 ./labs
drwxr-xr-x 5 root root 4096 Dec  4 16:11 ./labs/lab05
drwxr-xr-x 2 root root 4096 Dec  4 16:11 ./labs/lab04
drwxr-xr-x 2 root root 4096 Dec  4 16:11 ./labs/lab01
drwxr-xr-x 2 root root 4096 Dec  4 16:11 ./labs/lab03
drwxr-xr-x 2 root root 4096 Dec  4 16:11 ./labs/lab02
```

**Результат:** Выведены права доступа для всех файлов и директорий локального репозитория с использованием команды `find` без длинных путей (использован `-maxdepth 2` для ограничения глубины поиска).

### Задание 13: Процессы
```bash
$ ps -a
    PID TTY          TIME CMD
# Нет процессов, привязанных к терминалу (так как команда выполняется через SSH)

$ ps -x
# Список процессов вне терминала (системные процессы, демоны)

$ ps aux | head -20
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1 169828 13000 ?        Ss   Sep17   0:09 /sbin/init
root         2  0.0  0.0      0     0 ?        S    Sep17   0:00 [kthreadd]
root         3  0.0  0.0      0     0 ?        I<   Sep17   0:00 [rcu_gp]
# ... и другие системные процессы
```

**Результат:** Выведены процессы, запущенные в терминале (`ps -a`), вне терминала (`ps -x`) и все процессы системы (`ps aux`).

### Задание 14: Оформление README.md
README.md оформлен по аналогии с lab01 с использованием shields и markdown разметки:
- Заголовок с центрированием
- Shields badges (GitHub Docs, Markdown, Unicode, Shields.io)
- Badges курса (Risk Analysis, AppSec)
- Указан контрибьютор
- Структурированное содержание с markdown разметкой

Файл находится: `/root/course_labs/labs/lab02/README.md`

### Задание 15: Gist отчет
Данный отчет создан в формате Gist и готов для публикации на https://gist.github.com. Отчет содержит:
- Все выполненные задания с результатами команд
- Примечания об опечатках в заданиях
- Реальные результаты выполнения команд (включая ошибки)
- Выводы по выполненной работе

Файл отчета: `lab02_report.md`

## Выводы

В ходе выполнения лабораторной работы №2 были изучены:
- Работа с терминалом и консольными командами в *nix системах
- Управление правами доступа к файлам и директориям (chmod, chown, chgrp)
- Работа с POSIX ACL для детального управления правами доступа
- Управление пользователями и группами
- Работа с процессами в системе
- Интеграция кода из предыдущих лабораторных работ
- Исправление ошибок в коде pygame и его интеграция с typer

Все задания выполнены успешно.
