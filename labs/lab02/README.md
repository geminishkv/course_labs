<div align="center">
<h1><a id="intro">Лабораторная работа №2</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a> 
<a href="https://symbl.cc/en/unicode-table"><img src="https://img.shields.io/static/v1?logo=unicode&logoColor=fff&label=&message=Unicode&color=36393f&style=flat" alt="Unicode"></a> 
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<a href="https://img.shields.io/badge/Risk_Analyze-2448a2"><img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/AppSec-2448a2" alt= "RA"></a> <img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge"></a></div>

***

Салют :wave:,<br>
Данная лабораторная работа посвещена изучению *nix машин и как они работают, позволяет приобрести навыки для работы с терминалом/ консолью и приобрести знания по работе ОС. В лабоработрной работе описываются материалы по командам, скриптам и подключаемым приложениям.

***

## Задание

✅ 1. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ who | wc -I - # who показывает активные интерактивные сессии, wc -l считает строки → сколько пользователей "в системе" сейчас
# wc — word count, считает строки/слова/байты."-l" — выводит количество строк.
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ who | wc -l
2

$ id - UID, GID и группы текущего пользователя
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ id  
uid=1000(tigo) gid=1000(tigo) groups=1000(tigo),4(adm),20(dialout),24(cdrom),25(floppy),27(sudo),29(audio),30(dip),44(video),46(plugdev),100(users),101(netdev),116(bluetooth),121(wireshark),123(lpadmin),129(scanner),134(vboxsf),135(kaboxer)

$ whoami - имя текущего пользователя
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ whoami     
tigo

$ hostnamectl - информация об ОС, версии ядра и архитектуре
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ hostnamectl        
 Static hostname: tigo
       Icon name: computer-vm
         Chassis: vm 🖴
      Machine ID: aa75c642a0f54a42b4ac4676f59a7c1c
         Boot ID: 5ae34270fcf1445abca673e9df1b01d5
  Virtualization: oracle
Operating System: Kali GNU/Linux Rolling          
          Kernel: Linux 6.11.2-amd64
    Architecture: x86-64
 Hardware Vendor: innotek GmbH
  Hardware Model: VirtualBox
Firmware Version: VirtualBox
   Firmware Date: Fri 2006-12-01
    Firmware Age: 19y 1month 2w  

```

✅ 2. Выведите утилитой `tree` список вложенности дерева диреторий для каталога своего пользователя. Далее используйте `ls -a` и укажите отличие от `ls -l`.
``` bash 
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ tree ~
/home/tigo
├── course_labs
│   ├── assets
│   │   └── logotype
│   │       ├── logo2.jpg
│   │       └── logo.jpg
│   ├── CODE_OF_CONDUCT.md
│   ├── CONTRIBUTING.md
│   ├── docs
│   │   ├── about.md
│   │   ├── APPENDIX.md
│   │   ├── appsec_tt.md
│   │   ├── artifacts
│   │   │   ├── assets
│   │   │   │   ├── favicon.ico
│   │   │   │   ├── logo.png
│   │   │   │   └── logotypemd.jpg
│   │   │   ├── cheatsheet
│   │   │   │   ├── CHEATSHEET_DOCKERIGNORE.md
│   │   │   │   ├── CHEATSHEET_DOCKER.md
│   │   │   │   ├── CHEATSHEET_GH_CLI.md
│   │   │   │   ├── CHEATSHEET_GITIGNORE.md
│   │   │   │   └── CHEATSHEET_GIT.md
│   │   │   ├── exmpls
│   │   │   │   ├── risk-analysis.png
│   │   │   │   ├── table1.png
│   │   │   │   └── transaction.png
│   │   │   ├── owasp
│   │   │   │   ├── Authentication.pdf
│   │   │   │   ├── Authorization.pdf
│   │   │   │   ├── Client-side_Attacks.pdf
│   │   │   │   ├── Command_Execution.pdf
│   │   │   │   ├── Information_Disclosure.pdf
│   │   │   │   ├── Logical_Attacks.pdf
│   │   │   │   └── OWASP_Top_10_CICD_Risks.pdf
│   │   │   └── ppt
│   │   │       └── Лекция_Управление Рисками ИБ_intro.pdf
│   │   ├── Authentication.md
│   │   ├── Authorization.md
│   │   ├── channel.md
│   │   ├── Client-side Attacks.md
│   │   ├── Command Execution.md
│   │   ├── exmpl.md
│   │   ├── index.md
│   │   ├── Information Disclosure.md
│   │   ├── javascripts
│   │   │   ├── custom-title.js
│   │   │   └── typewriter-target.js
│   │   ├── labs
│   │   │   ├── lab01.md
│   │   │   ├── lab02.md
│   │   │   ├── lab03.md
│   │   │   ├── lab04.md
│   │   │   ├── lab05.md
│   │   │   ├── lab06.md
│   │   │   ├── lab07.md
│   │   │   ├── lab08.md
│   │   │   ├── lab09.md
│   │   │   ├── lab10.md
│   │   │   └── pet_project.md
│   │   ├── licenses.md
│   │   ├── Logical Attacks.md
│   │   ├── Multisignature.md
│   │   ├── OWASP_Top_10_CICD_Risks.md
│   │   ├── PrintNightmare.md
│   │   ├── RA.md
│   │   ├── RELEASE_NOTES.md
│   │   ├── robots.txt
│   │   ├── Security.md
│   │   └── stylesheets
│   │       ├── burger.css
│   │       ├── footer.css
│   │       ├── header.css
│   │       ├── layout.css
│   │       ├── mobile-logo.css
│   │       ├── search.css
│   │       ├── sidebar.css
│   │       ├── tools-overlay.css
│   │       └── typeset.css
│   ├── eslint.config.js
│   ├── labs
│   │   ├── lab01
│   │   │   ├── README.md
│   │   │   └── typersteel.py
│   │   ├── lab02
│   │   │   ├── exmpl_hello.py
│   │   │   ├── pygamesteel.py
│   │   │   └── README.md
│   │   ├── lab03
│   │   │   ├── exmp_targets.txt
│   │   │   └── README.md
│   │   ├── lab04
│   │   │   └── README.md
│   │   ├── lab05
│   │   │   ├── client
│   │   │   │   ├── client.py
│   │   │   │   ├── Dockerfile
│   │   │   │   └── requirements.txt
│   │   │   ├── docker-compose.yml
│   │   │   ├── README.md
│   │   │   ├── server
│   │   │   │   ├── app.py
│   │   │   │   ├── Dockerfile
│   │   │   │   └── requirements.txt
│   │   │   └── source
│   │   │       ├── Dockerfile
│   │   │       ├── hello.py
│   │   │       └── requirements.txt
│   │   ├── lab06
│   │   │   ├── audit.sh
│   │   │   ├── config
│   │   │   │   └── nginx.conf
│   │   │   ├── docker-compose.yml
│   │   │   ├── README.md
│   │   │   └── vulnerable-app.yml
│   │   ├── lab07
│   │   │   ├── cheat_check_yuorself.sh
│   │   │   ├── docker-compose.yml
│   │   │   ├── README.md
│   │   │   ├── sast
│   │   │   │   ├── checkov-config.yaml
│   │   │   │   └── semgrep-rules.yml
│   │   │   ├── sca
│   │   │   │   ├── dependency-check.sh
│   │   │   │   └── pom.xml
│   │   │   └── vulnerable-app
│   │   │       ├── app.py
│   │   │       ├── config.yaml
│   │   │       ├── Dockerfile
│   │   │       └── requirements.txt
│   │   ├── lab08
│   │   │   ├── dast
│   │   │   │   ├── convert_reports.py
│   │   │   │   ├── zap-baseline.conf
│   │   │   │   └── zap_scan.sh
│   │   │   ├── docker-compose.yml
│   │   │   ├── README.md
│   │   │   ├── requirements.txt
│   │   │   └── vulnerable-app
│   │   │       ├── app.py
│   │   │       ├── Dockerfile
│   │   │       ├── files
│   │   │       │   └── secret.txt
│   │   │       └── requirements.txt
│   │   ├── lab09
│   │   │   └── README.md
│   │   ├── lab10
│   │   │   └── README.md
│   │   └── pet_project
│   │       └── README.md
│   ├── LICENSE.md
│   ├── mkdocs.yml
│   ├── mypy.ini
│   ├── NOTICE.md
│   ├── overrides
│   │   └── material
│   │       └── partials
│   │           └── toc.html
│   ├── README.md
│   ├── RELEASE_NOTES.md
│   ├── requirements.txt
│   ├── ruff.toml
│   ├── SECURITY.md
│   └── stylelint.config.cjs
├── Desktop
├── Documents
├── Downloads
├── gist.txt
├── IFT606
│   ├── HostKeyAlgorithms=+ssh-rsa
│   ├── inconspicuous.py
│   ├── inconspicuous.service
│   ├── install.sh
│   ├── main.py
│   ├── mirai_creds.txt
│   ├── passwords.txt
│   ├── remote_infect.py
│   ├── scan.py
│   └── users.txt


┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ ls -a
.   exmpl_hello.py  README.md
..  pygamesteel.py  .README.md.swp

┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ ls -l
total 28
-rw-rw-r-- 1 tigo tigo   403 Dec 15 06:25 exmpl_hello.py
-rw-rw-r-- 1 tigo tigo   790 Dec 15 06:25 pygamesteel.py
-rw-rw-r-- 1 tigo tigo 17951 Dec 15 06:25 README.md

`tree` — показывает иерархию каталогов.  
`ls -a` — показывает скрытые файлы (`.` и `..`).  
`ls -l` — показывает права, владельца, размер и дату.

```
✅ 3. Используйте утилиту `file` и `df` для определения какая файловая система на разделе `/dev/sda1`.

``` bash 
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ file /dev/sda1  # type of device
/dev/sda1: block special (8/1)

┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ df -T /dev/sda1  # type of FS
Filesystem     Type 1K-blocks     Used Available Use% Mounted on
/dev/sda1      ext4  24253528 15788044   7208116  69% /


```
✅ 4. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ which vi  # показывает путь к vi 
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ which vi
/usr/bin/vi

$ locate hello.py # hello.py в locate
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ locate hello.py
/home/tigo/course_labs/labs/lab02/exmpl_hello.py
/home/tigo/course_labs/labs/lab05/source/hello.py
/home/tigo/lab1/hello.py
/usr/lib/python3/dist-packages/mitmproxy/contrib/kaitaistruct/dtls_client_hello.py
/usr/lib/python3/dist-packages/mitmproxy/contrib/kaitaistruct/tls_client_hello.py

$ sudo updatedb # обновляет базу locate
$ locate hello # ищет где встречается hello
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ locate hello 
/boot/grub/i386-pc/hello.mod
/home/tigo/course_labs/labs/lab02/exmpl_hello.py
/home/tigo/course_labs/labs/lab05/source/hello.py
/home/tigo/lab1/hello.py
/usr/lib/grub/i386-pc/hello.mod
/usr/lib/python2.7/__phello__.foo.py
/usr/lib/python2.7/__phello__.foo.pyc
/usr/lib/python3/dist-packages/dsinternals/common/data/hello
/usr/lib/python3/dist-packages/dsinternals/common/data/hello/CustomKeyInformation.py

$ touch screen
$ find ~ -name screen # поиск по файловой системе в ~
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ find ~ -name screen
/home/tigo/course_labs/labs/lab02/screen

$ locate screen
──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ locate screen
/etc/screenrc
/etc/alternatives/desktop-lockscreen.xml
/etc/init.d/screen-cleanup
/etc/rcS.d/S01screen-cleanup
/etc/tmpfiles.d/screen-cleanup.conf
/etc/xdg/kscreenlockerrc
/etc/xdg/autostart/xscreensaver.desktop

$ sudo updated
$ locate screen
```

✅ 5. Используйте конструкцию и вставьте ее в созданный файл ранее. Подключите `pygame` - используем исключительно для стилизации окна.

```py
mport pygame
pygame.init()

# Устанавливаем размеры окна
screen_width = 800
screen_height = 600
window_size = (screen_width, screen_height)
screen = pygame.display.set_mode(window_size)

# Задаем цвет фона
bg_color = (255, 255, 255)
screen.fill(bg_color)

# Выводим текст на экран
font = pygame.font.SysFont(None, 75)
text = font.render("Hello appsec world*", True, (0, 255, 0))
text_rect = text.get_rect(center=(400, 300))
screen.blit(text, text_rect)

pygame.display.flip()

while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            quit()

```

✅ 6. Сделайте `commit` и `push` в свой репозиторий с изменениями в `master branch`. На следующих лабораторных работах мы вернемся к этому файлу.
✅ 7. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ groups # группы пользователя 
┌──(venv)─(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ groups
tigo adm dialout cdrom floppy sudo audio dip video plugdev users netdev bluetooth wireshark lpadmin scanner vboxsf kaboxer

$ useradd smallman # создаёт пользователя smallman
$ userdel smallman -rf # удаляет
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ sudo userdel smallman -rf
userdel: smallman mail spool (/var/mail/smallman) not found
userdel: smallman home directory (/home/smallman) not found

$ useradd smallman
$ passwd smallman # задает пароль пользователю
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ sudo passwd smallman
New password: 
Retype new password: 
passwd: password updated successfully

$ usermod smallman -c 'Hach Hachov Hacherovich,239,45-67,499-239-45-33' # -c записывает GECOS-комментарий
$ passwd smallman
$ id smallman # выводит uid/gid и группы smallman
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ id smallman
uid=1001(smallman) gid=1001(smallman) groups=1001(smallman)

$ groupadd -g 1500 readgroup # -g — задать GID группы
$ usermod -aG readgroup smallman # добавляет smallman в readgroup
# -a — append (добавить, а не заменить группы)
# -G — добавить в группы
$ chmod 666 screen 
```
✅ 8. Выведите группу прав для `screen` и измените, что бы файл был доступен только для чтения созданному пользователю и выведите права этого польователя для измененного файла только используя `readgroup`.
``` bash
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ ls -l screen 

┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ sudo chgrp readgroup screen # меняем группу файла на readgroup
                                                   
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ ls -l screen               
-rw-rw-rw- 1 tigo readgroup 0 Jan 14 06:41 screen
                                                   
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ chmod 640 screen # владелец rw, группа r
                                                   
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ ls -l screen    
-rw-r----- 1 tigo readgroup 0 Jan 14 06:41 screen

```
✅ 9. Используйте `POSIX ACL`. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ touch nmapres.txt
$ setfacl -m u:smallman:rw nmapres.txt
$ setfacl -m g:readgroup:r nmapres.txt
$ getfacl nmapres.txt
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ getfacl nmapres.txt
# file: nmapres.txt
# owner: tigo
# group: tigo
user::rw-
user:smallman:rw-
group::rw-
group:readgroup:r--
mask::rw-
other::r--

```
✅ 10. Сохраните файл внутри локального репозитория, так как следующая работа будет подразумевать запись в нее данных о nmap.
✅ 11. Для закрепления выведите все списки групп пользователей на вашей ОС и права на верхнеуровневые каталоги.
``` bash 
┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ cat /etc/group

root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:tigo
tty:x:5:
disk:x:6:
lp:x:7:
mail:x:8:
news:x:9:
uucp:x:10:
man:x:12:
proxy:x:13:
kmem:x:15:
dialout:x:20:tigo
fax:x:21:
voice:x:22:
cdrom:x:24:tigo
floppy:x:25:tigo
tape:x:26:
sudo:x:27:tigo
audio:x:29:tigo
dip:x:30:tigo
www-data:x:33:
backup:x:34:
operator:x:37:
list:x:38:
irc:x:39:
src:x:40:
shadow:x:42:
utmp:x:43:
video:x:44:tigo
sasl:x:45:
plugdev:x:46:tigo
staff:x:50:
games:x:60:
users:x:100:tigo
nogroup:x:65534:
systemd-journal:x:999:
systemd-network:x:998:
crontab:x:997:
input:x:996:
sgx:x:995:
kvm:x:994:
render:x:993:
netdev:x:101:tigo
mysql:x:102:
tss:x:103:
systemd-timesync:x:992:
kismet:x:104:
_gophish:x:105:
messagebus:x:106:
tcpdump:x:107:
_ssh:x:108:
ssl-cert:x:109:postgres
redis:x:110:_gvm
i2c:x:111:
plocate:x:112:
mosquitto:x:113:
redsocks:x:114:
stunnel4:x:991:stunnel4
Debian-snmp:x:115:
bluetooth:x:116:tigo
sslh:x:117:
postgres:x:118:
avahi:x:119:
nm-openvpn:x:120:
wireshark:x:121:tigo
_gvm:x:122:
lpadmin:x:123:tigo
sambashare:x:990:
inetsim:x:124:
winbindd_priv:x:989:
pipewire:x:125:
nm-openconnect:x:126:
geoclue:x:127:
lightdm:x:128:
scanner:x:129:saned,tigo
saned:x:130:
polkitd:x:988:
rtkit:x:131:
colord:x:132:
kali-trusted:x:133:
tigo:x:1000:
vboxsf:x:134:tigo
kaboxer:x:135:tigo
smallman:x:1001:
readgroup:x:1500:smallman

┌──(tigo㉿tigo)-[~/course_labs/labs/lab02]
└─$ ls -ld /bin /etc /home /root /usr /var /tmp
lrwxrwxrwx   1 root root     7 Sep 11 16:25 /bin -> usr/bin
drwxr-xr-x 180 root root 12288 Jan 14 07:05 /etc
drwxr-xr-x   3 root root  4096 Sep 11 16:40 /home
drwx------   5 root root  4096 Nov 30 17:25 /root
drwxrwxrwt  14 root root   340 Jan 14 07:39 /tmp
drwxr-xr-x  15 root root  4096 Sep 11 16:32 /usr
drwxr-xr-x  12 root root  4096 Sep 11 16:45 /var

```
✅ 12. Выведите все права для файлов и директорий локального репозитория которые имеют различные пользователи  (без использования длинных путей)
``` bash
──(tigo㉿tigo)-[~/course_labs]
└─$ ls -l           
total 96
drwxrwxr-x  3 tigo tigo  4096 Dec 15 06:25 assets
-rw-rw-r--  1 tigo tigo  5479 Dec 15 06:25 CODE_OF_CONDUCT.md
-rw-rw-r--  1 tigo tigo  1391 Dec 15 06:25 CONTRIBUTING.md
drwxrwxr-x  6 tigo tigo  4096 Dec 15 06:25 docs
-rw-rw-r--  1 tigo tigo   360 Dec 15 06:25 eslint.config.js
drwxrwxr-x 13 tigo tigo  4096 Dec 15 06:25 labs
-rw-rw-r--  1 tigo tigo 10172 Dec 15 06:25 LICENSE.md
-rw-rw-r--  1 tigo tigo  4007 Dec 15 06:25 mkdocs.yml
-rw-rw-r--  1 tigo tigo   224 Dec 15 06:25 mypy.ini
-rw-rw-r--  1 tigo tigo   614 Dec 15 06:25 NOTICE.md
drwxrwxr-x  3 tigo tigo  4096 Dec 15 06:25 overrides                                                  
-rw-rw-r--  1 tigo tigo 20127 Dec 15 06:25 README.md
-rw-rw-r--  1 tigo tigo  1359 Dec 15 06:25 RELEASE_NOTES.md
-rw-rw-r--  1 tigo tigo   426 Dec 15 06:25 requirements.txt
-rw-rw-r--  1 tigo tigo   195 Dec 15 06:25 ruff.toml
-rw-rw-r--  1 tigo tigo  2083 Dec 15 06:25 SECURITY.md
-rw-rw-r--  1 tigo tigo   527 Dec 15 06:25 stylelint.config.cjs
```
✅ 13. Выведите процессы которые у вас запущены в термине и вне его.
``` bash
┌──(tigo㉿tigo)-[~/course_labs]
└─$ ps                    
    PID TTY          TIME CMD
 372140 pts/3    00:00:02 zsh
 401720 pts/3    00:00:00 ps

┌──(tigo㉿tigo)-[~/course_labs]
└─$ ps aux

USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.4  23180 14220 ?        Ss   Jan13   0:04 /sbin/init splash
root           2  0.0  0.0      0     0 ?        S    Jan13   0:00 [kthreadd]

┌──(tigo㉿tigo)-[~/course_labs]
└─$ pstree

```
✅ 14. Оформить `README.md` по аналогии и использовать `shield`, etc.
✅ 15. Составить `gist` отчет и отправить ссылку личным сообщением


