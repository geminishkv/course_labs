---
hide:
  - toc

title: "Команды Git: указатели, конфигурация, основы | Курс AppSec"
description: "Справочник по Git для лабораторных курса AppSec: HEAD, ORIG_HEAD, ветки и теги как указатели, уровни конфигурации local, global и system, основные команды."
keywords: "Git, HEAD, ORIG_HEAD, detached HEAD, git config, команды Git, справочник, AppSec, курс AppSec, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Команды: Git</h1>
    <p class="hero-sub">Указатели, уровни конфигурации и основные команды</p>
  </div>
</div>

Короткая опора для лабораторной 01 и всех следующих: как Git хранит указатели, где лежит конфигурация и какие команды нужны каждый день. Развёрнутые сценарии собраны в шпаргалке по Git.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">01</span>
    <span class="lab-card-title" style="font-weight:700;">Git — Указатели</span>
  </div>
  <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Понимание указателей — ключ к отладке ситуаций с «потерянными» коммитами и merge-конфликтами</p>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <li><code>HEAD</code> — указатель на текущий коммит/ветку; родитель следующего коммита. Если HEAD указывает на коммит напрямую — это <em>detached HEAD</em></li>
    <li><code>ORIG_HEAD</code> — коммит, с которого был перемещён HEAD (спасает после неудачного <code>git reset</code>: <code>git reset ORIG_HEAD</code>)</li>
    <li><code>master</code>, <code>develop</code> — указатели на коммит; перемещаются при добавлении коммита. Ветка — это просто файл с SHA-хешем</li>
    <li><code>tags</code> — неизменяемые указатели на конкретные коммиты. Используются для маркировки релизов (<code>v1.0.0</code>)</li>
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

</div>

## Смотри также

- [CheatSheet: Git](cheatsheet/CHEATSHEET_GIT.md) — сценарии: ветки, откат, подпись коммитов
- [CheatSheet: GitHub CLI](cheatsheet/CHEATSHEET_GH_CLI.md) — pull request и релизы из терминала
- [Настройка Git, GPG и GitHub CLI](guides/git_setup.md) — первичная настройка окружения
- [Лаб. 01 · Git: окружение и первый коммит](../labs/basic/lab01.md) — где команды применяются
- [Приложение](APPENDIX.md) — все справочники команд на одной странице
