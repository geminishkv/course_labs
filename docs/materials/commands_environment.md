---
hide:
  - toc

title: "Окружение: Unix-утилиты, пакетные менеджеры, Python venv и pip — справочник курса AppSec"
description: "Справочник по рабочему окружению курса AppSec: базовые утилиты Unix, пакетные менеджеры, установка ПО, виртуальные окружения Python и pip."
keywords: "Linux, Unix, apt, brew, пакетный менеджер, Python, venv, pip, окружение, справочник, AppSec, курс AppSec, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Команды: окружение</h1>
    <p class="hero-sub">Unix-утилиты, пакетные менеджеры, ПО и Python venv</p>
  </div>
</div>

Команды, без которых не обходится ни одна лабораторная: работа с файлами и процессами, установка пакетов, изолированное окружение Python. Подробные разборы с примерами лежат в шпаргалке по Linux.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">01</span>
    <span class="lab-card-title" style="font-weight:700;">Unix — Базовые утилиты</span>
  </div>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <li><a href="https://en.wikipedia.org/wiki/Cat_(Unix)">cat</a>, <a href="https://en.wikipedia.org/wiki/Echo_(command)">echo</a>, <a href="https://en.wikipedia.org/wiki/Pwd">pwd</a> — вывод содержимого и переменных</li>
    <li><a href="https://en.wikipedia.org/wiki/Ls">ls</a>, <a href="https://en.wikipedia.org/wiki/Cd_(command)">cd</a>, <a href="https://en.wikipedia.org/wiki/Mkdir">mkdir</a>, <a href="https://en.wikipedia.org/wiki/Rm_(Unix)">rm</a>, <a href="https://en.wikipedia.org/wiki/Mv">mv</a>, <a href="https://en.wikipedia.org/wiki/Cp_(Unix)">cp</a> — работа с ФС</li>
    <li><a href="https://en.wikipedia.org/wiki/Find">find</a>, <a href="https://en.wikipedia.org/wiki/Cut_(Unix)">cut</a>, <a href="https://en.wikipedia.org/wiki/Sed">sed</a> — поиск и обработка текста</li>
    <li><a href="https://en.wikipedia.org/wiki/Ps_(Unix)">ps</a>, <a href="https://en.wikipedia.org/wiki/File_(command)">file</a>, <a href="https://en.wikipedia.org/wiki/Nm_(Unix)">nm</a>, <a href="https://en.wikipedia.org/wiki/Ar_(Unix)">ar</a> — процессы и бинарники</li>
    <li><a href="https://en.wikipedia.org/wiki/Man_page">man</a>, <a href="https://en.wikipedia.org/wiki/Touch_(Unix)">touch</a>, <a href="https://en.wikipedia.org/wiki/Env_(shell)">env</a> — справка, метаданные, окружение</li>
  </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">02</span>
    <span class="lab-card-title" style="font-weight:700;">Package Managers</span>
  </div>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <li><a href="http://help.ubuntu.ru/wiki/apt">apt</a> — Debian/Ubuntu: <code>apt install &lt;pkg&gt;</code></li>
    <li><a href="https://en.wikipedia.org/wiki/DNF_(software)">dnf</a> / <a href="https://fedoraproject.org/wiki/Yum/ru">yum</a> — RHEL/Fedora/CentOS</li>
    <li><a href="https://brew.sh">brew</a> / <a href="https://docs.brew.sh/Homebrew-on-Linux">linuxbrew</a> — macOS / Linux</li>
    <li><a href="https://docs.npmjs.com">npm</a> — Node.js: <code>npm install &lt;pkg&gt;</code></li>
    <li><a href="https://pip.pypa.io/en/stable/">pip</a> — Python: <code>pip install &lt;pkg&gt;</code></li>
    <li><a href="https://docs.docker.com/engine/install/">docker</a> — контейнеры</li>
  </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">03</span>
    <span class="lab-card-title" style="font-weight:700;">Software</span>
  </div>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <li><a href="https://curl.se/docs/manpage.html">curl</a> — HTTP-запросы из CLI</li>
    <li><a href="https://www.gnu.org/software/wget/manual/wget.pdf">wget</a> — загрузка файлов по HTTP/FTP</li>
    <li><a href="https://www.openssl.org">openssl</a> — TLS, сертификаты, шифрование</li>
    <li><a href="https://linux.die.net/man/1/tree">tree</a> — дерево директорий</li>
    <li><a href="https://www.vim.org">vim</a> / <a href="https://www.nano-editor.org">nano</a> — редакторы в терминале</li>
    <li><a href="https://jqlang.github.io/jq/">jq</a> — обработка JSON в CLI</li>
  </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">04</span>
    <span class="lab-card-title" style="font-weight:700;">Python — venv & pip</span>
  </div>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <li><code>python3 -m venv .venv</code> — создать виртуальное окружение</li>
    <li><code>source .venv/bin/activate</code> — активировать (Linux/macOS)</li>
    <li><code>.venv\Scripts\activate</code> — активировать (Windows)</li>
    <li><code>pip install -r requirements.txt</code> — установить зависимости</li>
    <li><code>pip freeze &gt; requirements.txt</code> — зафиксировать зависимости</li>
    <li><code>pip list --outdated</code> — устаревшие пакеты</li>
    <li><code>deactivate</code> — выйти из окружения</li>
  </ul>
  <span class="lab-tag"><a href="https://docs.python.org/3/library/venv.html" style="color:inherit; text-decoration:none;">docs.python.org/3/library/venv</a></span>
  </div>

</div>

## Смотри также

- [CheatSheet: Linux и сети](cheatsheet/CHEATSHEET_LINUX.md) — права, процессы, сеть, диагностика
- [Подготовка рабочего окружения](guides/vmbox_tutorial.md) — ВМ, сеть ВМ и первичная настройка
- [Установка AppSec-инструментов](guides/appsec_tools_setup.md) — сканеры курса по шагам
- [Лаб. 02 · Linux: права доступа и процессы](../labs/basic/lab02.md) — где команды применяются
- [Приложение](APPENDIX.md) — все справочники команд на одной странице
