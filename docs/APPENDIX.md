---
hide:
  - toc

title: Приложения для курса AppSec
description: Справочные материалы и команды для лабораторных работ AppSec — Git, Docker, Linux, Python, pip, venv.
keywords: "Git, Docker, Linux, Python, pip, venv, команды, AppSec, шпаргалка, справочник"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Приложение</h1>
    <p class="hero-sub">Команды и утилиты для лабораторных работ</p>
  </div>
</div>

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">01</span>
      <span class="lab-card-title" style="font-weight:700;">Git — Указатели</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
      <li><code>HEAD</code> — указатель на текущий коммит/ветку; родитель следующего коммита</li>
      <li><code>ORIG_HEAD</code> — коммит, с которого был перемещён HEAD (например, после <code>git reset</code>)</li>
      <li><code>master</code>, <code>develop</code> — указатели на коммит; перемещаются при добавлении коммита</li>
      <li><code>tags</code> — неизменяемые указатели на конкретные коммиты</li>
    </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">02</span>
      <span class="lab-card-title" style="font-weight:700;">Git — Конфигурация ENV</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
      <li><code>--local</code> — локальный уровень репозитория: <code>.git/config</code></li>
      <li><code>--global</code> — уровень пользователя: <code>~/.gitconfig</code></li>
      <li><code>--system</code> — системный уровень: <code>/etc/gitconfig</code></li>
    </ul>
    <span class="lab-tag">git config --global user.name "Name"</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">03</span>
      <span class="lab-card-title" style="font-weight:700;">Git — Основные команды</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
      <li><code>git init</code> / <code>git clone &lt;url&gt;</code> — инициализация и клонирование</li>
      <li><code>git add .</code> / <code>git commit -m "msg"</code> — stage и коммит</li>
      <li><code>git status</code> / <code>git log --oneline</code> — состояние и история</li>
      <li><code>git checkout -b &lt;name&gt;</code> / <code>git switch &lt;branch&gt;</code> — ветки</li>
      <li><code>git pull</code> / <code>git push origin &lt;branch&gt;</code> — синхронизация</li>
      <li><code>git diff</code> / <code>git stash</code> — просмотр изменений и стек</li>
      <li><code>git rebase -i HEAD~N</code> — интерактивный rebase</li>
    </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">04</span>
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
      <span class="lab-card-num">05</span>
      <span class="lab-card-title" style="font-weight:700;">Package Managers</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
      <li><a href="http://help.ubuntu.ru/wiki/apt">apt</a> — Debian/Ubuntu: <code>apt install &lt;pkg&gt;</code></li>
      <li><a href="https://en.wikipedia.org/wiki/DNF_(software)">dnf</a> / <a href="https://fedoraproject.org/wiki/Yum/ru">yum</a> — RHEL/Fedora/CentOS</li>
      <li><a href="https://brew.sh">brew</a> / <a href="http://linuxbrew.sh">linuxbrew</a> — macOS / Linux</li>
      <li><a href="https://docs.npmjs.com">npm</a> — Node.js: <code>npm install &lt;pkg&gt;</code></li>
      <li><a href="https://pip.pypa.io/en/stable/">pip</a> — Python: <code>pip install &lt;pkg&gt;</code></li>
      <li><a href="https://docs.docker.com/engine/install/">docker</a> — контейнеры</li>
    </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">06</span>
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
      <span class="lab-card-num">07</span>
      <span class="lab-card-title" style="font-weight:700;">Docker</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
      <li><code>docker build -t &lt;name&gt; .</code> — сборка образа</li>
      <li><code>docker run -it --rm &lt;name&gt;</code> — запуск контейнера</li>
      <li><code>docker run -d -p 8080:80 &lt;name&gt;</code> — фоновый запуск с портом</li>
      <li><code>docker exec -it &lt;id&gt; bash</code> — шелл внутри контейнера</li>
      <li><code>docker ps -a</code> / <code>docker logs &lt;id&gt;</code> — статус и логи</li>
      <li><code>docker images</code> / <code>docker rmi &lt;id&gt;</code> — образы</li>
      <li><code>docker compose up -d</code> / <code>down</code> — Compose</li>
    </ul>
    <span class="lab-tag"><a href="https://docs.docker.com/reference/" style="color:inherit; text-decoration:none;">docs.docker.com/reference</a></span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">08</span>
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

![Логотип](artifacts/assets/logotypemd.jpg)
