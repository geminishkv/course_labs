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

Для сдачи данной работы также будет требоваться ответить на дополнительыне вопросы по описанным темам.

***

## Структура репозитория лабораторной работы

```bash
lab02
├── exmpl_hello.py
├── pygamesteel.py
└── README.md
```

***

## Материалы

Давайте начнем с описания как это работает, но следует подойти к этому вопросу изначально с **терминов** и **основных элекментов**, таких как: 

<table>
  <thead>
    <tr>
      <th style="width:15%;">Раздел</th>
      <th style="width:25%;">Описание</th>
      <th style="width:60%;">Основные элементы</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Терминал</strong></td>
      <td>Устройство ввода/ вывода</td>
      <td>
      </td>
    </tr>
    <tr>
      <td><strong>Оболочка (shell)</strong></td>
      <td>Интерпретатор команд, обеспечивающий интерфейс для взаимодействия пользователя с функциями ОС (в Linux по умолчанию bash).</td>
      <td>
        <ul>
          <li><code>env</code> – вывод списка переменных окружения</li>
          <li><code>export</code> – экспорт переменных окружения</li>
          <li><code>echo</code> – вывод переданного параметра</li>
          <li><code>reset</code> – сброс настроек терминала к значениям по умолчанию</li>
          <li><code>logout</code> – завершение сеанса</li>
          <li><code>exit</code> – завершение сеанса оболочки</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><strong>Консоль</strong></td>
      <td>Интерфейс командной строки с командами для работы с файлами.</td>
      <td>
        <ul>
          <li><code>ls</code> – вывод содержимого каталога</li>
          <li><code>cd</code> – смена текущего каталога</li>
          <li><code>touch</code> – создание файла</li>
          <li><code>mkdir</code> – создание каталога</li>
          <li><code>rm</code> / <code>rmdir</code> – удаление файла или каталога</li>
          <li><code>cp</code> – копирование</li>
          <li><code>mv</code> – перенос или переименование</li>
          <li><code>ln</code> – создание ссылок на файлы</li>
          <li><code>cat</code> / <code>tac</code> – вывод содержимого файла</li>
          <li><code>df</code> – отчёт об использовании дискового пространства</li>
          <li><code>du</code> – отчёт об используемом месте на диске</li>
          <li><code>wc</code> – подсчёт строк, слов и символов</li>
          <li><code>uniq</code> – нахождение/фильтрация дублирующихся строк</li>
          <li><code>grep</code> – поиск по шаблону</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><strong>Файловая система</strong></td>
      <td>Иерархия каталогов и файлов с правами доступа пользователей.</td>
      <td>
        <ul>
          <li><code>/bin</code> – исполняемые файлы (программы и скрипты)</li>
          <li><code>/sbin</code> – исполняемые файлы и системное ПО</li>
          <li><code>/dev</code> – файлы устройств</li>
          <li><code>/etc</code> – конфигурационные файлы системы и приложений</li>
          <li><code>/lib</code> – системные библиотеки</li>
          <li><code>/home</code> – домашние каталоги пользователей</li>
          <li><code>/root</code> – домашний каталог суперпользователя</li>
          <li><code>/usr</code> – приложения и дополнительные данные</li>
          <li><code>/var</code> – изменяемые данные приложений</li>
          <li><code>/tmp</code> – временный каталог системы</li>
          <li><code>/var/tmp</code> – временные каталоги приложений</li>
          <li><code>/proc</code> – файловый интерфейс ядра и процессов</li>
          <li><code>/mnt</code> – точки монтирования сетевых файловых систем</li>
          <li><code>/media</code> – точки монтирования съёмных носителей</li>
          <li><code>/boot</code> – загрузчики и файлы ядра</li>
          <li><code>/sys</code> – интерфейс к устройствам и подсистемам ядра</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td><strong>Переменные окружения</strong></td>
      <td>Переменные, задающие контекст работы пользователя и процессов.</td>
      <td>
        <ul>
          <li><code>SHELL</code> – оболочка текущего пользователя</li>
          <li><code>USER</code> – имя пользователя</li>
          <li><code>HOME</code> – домашний каталог пользователя</li>
          <li><code>PATH</code> – пути поиска исполняемых файлов</li>
          <li><code>PWD</code> – текущий каталог</li>
          <li><code>LANG</code> – текущая локаль (язык и формат)</li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

***

### Права доступа

При монтировании образа для каждой *nix ОС задаются права доступа к файлам и путям каталогов, которые позволяют их индивидуально профилировать, а также изменять, но давайте посмотрим на общую картину, советую ознакомиться изначально с Петром Девянином и его описанием `take-grant` [модели](https://academia-moscow.ru/ftp_share/_books/fragments/fragment_20276.pdf). Система безопасности построена на:

> - chmod — изменение прав доступа

```bash
$ chmod [-R] [option] [rules] # пользователь может менять только у принадлежащих ему файлов, а root у всех файлов в системе
```

> - umask — маска прав доступа
дляполученияреальныхправвновь
. 
> - chown — изменение владельца

```bash
$ chown [-R] user[:group] file # доступна только для root
         -R # рекурсивная смена
```

> - chgrp — изменение группы

```bash
$ chgrp [-R] group ... file # изменение группы файла для пользователя только там, где он является ее членом
```

У каждого файла или каталога имеются определенные права доступа, такие как:

> - r — право на чтение из файла / просмотр содержимого директории
> - w — право на запись в файл / создание, удаление файлов в директории
> - x — право на исполнение / доступ в директорию и сабдиректории

По умолчанию права для директории **777**, а для файлов **666**. А теперь давайте посмотрим, как можно поменять права. На сейчас все `*nix` поддерживают `POSIX ACL`, который позволяет указать права доступа для конкретных пользователей и групп.

```bash
$ getfacl [option] file ... # показывает список access list
$ setfacl [option] file ... # устанавливает или удаляет access list
         -m # изменение или установка
         -х # удаление
         
# Пример
$ setfacl -m u:user1:rw file # для пользователя
$ setfacl -m g:users:r file # для группы
$ setfacl -m m::rw file для # маски

```
 
***

### Процессы

А теперь давай посмотрим, что каждому выполняемому процессу присваивается уникальный номер `PID` Process ID, где его ID после завершения процесса высвобождается. У всех процессов в системе кроме самого первого (**PID = 1** - `init`) есть родительские, которые запускают процесс. 

```bash
$ ps [option] # список процессо в всистеме
    -a # список всех процессов привязанных к терминалу
    -x # ... не привязанных к терминалу
    —е # показывает все процессы системы
    -f # показывает дерево процессов
    -u user # список процессов пользователя
$ pstree # дерево процессов

$ kill [-l] PID # пример как можно вывести спиок всех сигналов
$ killall [-signal] # определение процесса по имени
```

После завершения работы родительского процесса у наследователя становится init. Также, если `shell` заканчивает работу, то все процессы будут завершены. Но если надо, что бы программа работала далее без оболочки, то ее необходимо запускать при помощи `nohup`, так как отключает программу от терминала. А теперь, все вы знаете про `daemon`, а это именно то, что работает после запуска и сразу же отключается от терминала.

***

## Задание

- [ ] 1. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ who | wc -I
$ id
$ whoami
$ hostnamectl
```

- [ ] 2. Выведите утилитой `tree` список вложенности дерева диреторий для каталога своего пользователя. Далее используйте `ls -a` и укажите отличие от `ls -l`.
- [ ] 3. Используйте утилиту `file` и `df` для определения какая файловая система на разделе `/dev/sda1`.
- [ ] 4. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ which vi
$ locate hello.py
$ sudo updatedb
$ locate hello
$ touch screen
$ find ~ -name screen
$ locate screen
$ sudo updated
$ locate screen
```

- [ ]  5. Используйте конструкцию и вставьте ее в созданный файл ранее. Подключите `pygame` - используем исключительно для стилизации окна.

```py
import pygame
pygame.init()

# Устанавливаем размеры окна
screen_width = 800
screen_height = 600
window_size = (screen_width, screen_height)
pygame.display.set_mode(window_size) # Создаем окно

# Задаем цвет фона
bg_color = (255, 255, 255)
pygame.draw.rect(screen, bg_color, [0, 0, screen_width, screen_height], 1)

# Выводим текст на экран
font = pygame.font.SysFont(None, 75)
text = font.render("Hello appsec world*", True, (0, 255, 0))
text_rect = text.get_rect()
text_rect.center = (400, 300)
screen.blit(text, text_rect)

while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            quit()
pygame.display.flip() # Обновляем экран
```

- [ ] 6. Сделайте `commit` и `push` в свой репозиторий с изменениями в `master branch`. На следующих лабораторных работах мы вернемся к этому файлу.
- [ ] 7. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ groups
$ useradd smallman
$ userdel smallman -rf
$ useradd smallman
$ passwd smallman
$ usermod smallman -c 'Hach Hachov Hacherovich,239,45-67,499-239-45-33'
$ passwd smallman
$ id smallman
$ groupadd -g 1500 readgroup
$ usermod -aG readgroup smallman
$ chmod 666 screen 
```


- [ ] 8. Выведите группу прав для `screen` и измените, что бы файл был доступен только для чтения созданному пользователю и выведите права этого польователя для измененного файла только используя `readgroup`.
- [ ] 9. Используйте `POSIX ACL`. Выведите на терминале и проанализируйте следующие команды консоли

```bash
$ touch nmapres.txt
$ setfacl -m u:smallman:rw nmapres.txt
$ setfacl -m g:readgroup:r nmapres.txt
$ getfacl nmapres.txt
```

- [ ] 10. Сохраните файл внутри локального репозитория, так как следующая работа будет подразумевать запись в нее данных о nmap.
- [ ] 11. Для закрепления выведите все списки групп пользователей на вашей ОС и права на верхнеуровневые каталоги.
- [ ] 12. Выведите все права для файлов и директорий локального репозитория которые имеют различные пользователи  (без использования длинных путей)
- [ ] 13. Выведите процессы которые у вас запущены в термине и вне его.
- [ ] 14. Оформить `README.md` по аналогии и использовать `shield`, etc.
- [ ] 15. Составить `gist` отчет и отправить ссылку личным сообщением

***

## Links

- [Gist](https://gist.github.com)
- [GitHub CLI](https://cli.github.com)
- [cat](https://en.wikipedia.org/wiki/Cat_(Unix))
- [cd](https://en.wikipedia.org/wiki/Cd_(command))
- [cp](https://en.wikipedia.org/wiki/Cp_(Unix))
- [echo](https://en.wikipedia.org/wiki/Echo_(command))
- [env](https://en.wikipedia.org/wiki/Env_(shell))
- [file](https://en.wikipedia.org/wiki/File_(command))
- [ls](https://en.wikipedia.org/wiki/Ls)
- [mkdir](https://en.wikipedia.org/wiki/Mkdir)
- [mv](https://en.wikipedia.org/wiki/Mv)
- [ps](https://en.wikipedia.org/wiki/Ps_(Unix))
- [pwd](https://en.wikipedia.org/wiki/Pwd)
- [rm](https://en.wikipedia.org/wiki/Rm_(Unix))
- [touch](https://en.wikipedia.org/wiki/Touch_(Unix))
- [apt](http://help.ubuntu.ru/wiki/apt)
- [brew](https://brew.sh)
- [npm](https://docs.npmjs.com)

Copyright (c) 2025 Elijah S Shmakov

![Logo](../../assets/logotype/logo.jpg)