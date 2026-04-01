---
hide:
  - toc

title: "Приложение — справочные материалы и команды для курса AppSec"
description: "AppSec справочник: команды Git, Docker, Linux, Python, pip и venv — шпаргалки и утилиты для выполнения лабораторных работ курса."
keywords: "Git, Docker, Linux, Python, pip, venv, команды, AppSec, шпаргалка, справочник, cheatsheet, лабораторные работы"
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

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">09</span>
      <span class="lab-card-title" style="font-weight:700;">Nmap — Сетевое сканирование</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Первый этап разведки: определить открытые порты, сервисы и потенциальные точки входа</p>
      <li><code>nmap -sV &lt;target&gt;</code> — определение версий сервисов (позволяет сопоставить с CVE)</li>
      <li><code>nmap -sS -p 1-65535 &lt;target&gt;</code> — SYN-сканирование всех портов (быстрое, не завершает TCP-handshake)</li>
      <li><code>nmap -sU -p 53,161 &lt;target&gt;</code> — UDP-сканирование (DNS, SNMP — часто забытые сервисы)</li>
      <li><code>nmap -O &lt;target&gt;</code> — определение ОС (fingerprinting по TTL и TCP window)</li>
      <li><code>nmap --script vuln &lt;target&gt;</code> — NSE-скрипты для проверки известных уязвимостей</li>
      <li><code>nmap -oX report.xml &lt;target&gt;</code> — экспорт в XML для последующего парсинга</li>
    </ul>
    <span class="lab-tag"><a href="https://nmap.org/book/man.html" style="color:inherit; text-decoration:none;">nmap.org/book/man</a></span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">10</span>
      <span class="lab-card-title" style="font-weight:700;">SAST — Статический анализ</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Анализ кода без запуска — ищет паттерны уязвимостей, мисконфигурации и нарушения best practices</p>
      <li><code>semgrep scan --config auto .</code> — авто-правила: инъекции, XSS, hardcoded secrets</li>
      <li><code>semgrep scan --config p/owasp-top-ten .</code> — проверка по OWASP Top 10 категориям</li>
      <li><code>semgrep scan --json -o report.json .</code> — машиночитаемый отчёт для CI</li>
      <li><code>checkov -d . --framework dockerfile</code> — Checkov: IaC-мисконфигурации (Dockerfile, Terraform, K8s)</li>
      <li><code>bandit -r src/ -f json -o bandit.json</code> — Bandit: Python-специфичные уязвимости (eval, pickle, subprocess)</li>
      <li>В отчёте смотреть: <strong>severity</strong> (ERROR/WARNING), <strong>CWE ID</strong> для маппинга на стандарты</li>
    </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">11</span>
      <span class="lab-card-title" style="font-weight:700;">SCA — Анализ зависимостей</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Проверка зависимостей на известные CVE — одна из самых частых причин компрометации (supply chain attacks)</p>
      <li><code>pip-audit</code> — проверяет Python-пакеты по базе OSV/PyPI Advisory</li>
      <li><code>trivy fs --scanners vuln .</code> — Trivy: универсальный сканер (Python, Node, Go, Java, Ruby)</li>
      <li><code>trivy image &lt;name&gt;:&lt;tag&gt;</code> — сканирование Docker-образа (ОС-пакеты + языковые зависимости)</li>
      <li><code>dependency-check.sh -s . -o ./reports</code> — OWASP DC: маппинг CPE → NVD, HTML-отчёт</li>
      <li><code>npm audit</code> / <code>npm audit fix</code> — встроенный аудит Node.js</li>
      <li>В отчёте искать: <strong>CRITICAL/HIGH</strong> с публичным эксплойтом → приоритет на обновление</li>
    </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">12</span>
      <span class="lab-card-title" style="font-weight:700;">DAST — Динамическое тестирование</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Тестирование запущенного приложения — находит то, что SAST не видит: IDOR, broken auth, misconfigured CORS</p>
      <li><code>zap-baseline.py -t &lt;url&gt;</code> — быстрый baseline-скан (пассивные проверки, ~2 мин)</li>
      <li><code>zap-full-scan.py -t &lt;url&gt; -r report.html</code> — полное сканирование (активные атаки, ~15–30 мин)</li>
      <li><code>zap-api-scan.py -t &lt;openapi.json&gt; -f openapi</code> — API-скан по спецификации OpenAPI</li>
      <li>В отчёте: <strong>High/Medium</strong> алерты → воспроизвести вручную → подтвердить → исправить</li>
      <li>HUD Mode — интерактивный прокси: видите алерты прямо в браузере при ручном тестировании</li>
    </ul>
    <span class="lab-tag"><a href="https://www.zaproxy.org/docs/" style="color:inherit; text-decoration:none;">zaproxy.org/docs</a></span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">13</span>
      <span class="lab-card-title" style="font-weight:700;">Docker CIS Benchmark</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Аудит Docker-окружения по CIS Benchmark — 100+ проверок хоста, демона, образов и контейнеров</p>
      <li><code>docker-bench-security</code> — автоматизированная проверка по 7 разделам CIS (PASS/WARN/NOTE)</li>
      <li>Разделы: Host Configuration, Docker Daemon, Images &amp; Build, Container Runtime, Security Operations</li>
      <li><code>hadolint Dockerfile</code> — линтинг: <code>DL3008</code> (pin versions), <code>DL3003</code> (use WORKDIR), <code>SC2086</code> (quote vars)</li>
      <li><code>dockle &lt;image&gt;</code> — проверка собранного образа: лишние пакеты, рутовый пользователь, healthcheck</li>
    </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">14</span>
      <span class="lab-card-title" style="font-weight:700;">Secret Detection</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Секреты в git-истории — одна из топ причин утечек. Даже удалённый коммит остаётся в reflog</p>
      <li><code>gitleaks detect -v</code> — сканирует всю git-историю по regex-паттернам (AWS keys, tokens, passwords)</li>
      <li><code>gitleaks detect --source . --report-path report.json</code> — машиночитаемый отчёт для CI</li>
      <li><code>trufflehog git file://.</code> — поиск по entropy (высокая энтропия = вероятный секрет)</li>
      <li><code>detect-secrets scan &gt; .secrets.baseline</code> — baseline: отслеживает новые секреты между коммитами</li>
      <li>Pre-commit hook: <code>gitleaks protect --staged</code> — блокирует коммит если найден секрет</li>
    </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">15</span>
      <span class="lab-card-title" style="font-weight:700;">GitHub Actions — CI/CD</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Автоматизация DevSecOps конвейера — каждый push проходит через lint → SAST → SCA → build → DAST → deploy</p>
      <li><code>on: push / pull_request</code> — триггеры (push для CI, PR для review gates)</li>
      <li><code>jobs.&lt;id&gt;.runs-on: ubuntu-latest</code> — GitHub-hosted раннер (бесплатно для public repos)</li>
      <li><code>needs: [sast, sca]</code> — зависимости: DAST ждёт завершения SAST и SCA</li>
      <li><code>env / secrets.$&#123;&#123; secrets.TOKEN &#125;&#125;</code> — секреты хранятся в Settings → Secrets, не в коде</li>
      <li><code>if: github.ref == 'refs/heads/main'</code> — deploy только из main (защита от случайного деплоя)</li>
      <li><code>actions/upload-artifact@v4</code> — сохранение отчётов SAST/DAST как артефактов</li>
    </ul>
    <span class="lab-tag"><a href="https://docs.github.com/en/actions" style="color:inherit; text-decoration:none;">docs.github.com/actions</a></span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
    <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
      <span class="lab-card-num">16</span>
      <span class="lab-card-title" style="font-weight:700;">Анализ рисков ИБ</span>
    </div>
    <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
    <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Риск-ориентированный подход: не все уязвимости одинаково опасны — приоритизация по бизнес-импакту</p>
      <li><strong>Актив</strong> → <strong>Угроза</strong> → <strong>Уязвимость</strong> → <strong>Риск</strong> → <strong>Мера</strong> (цепочка анализа)</li>
      <li>Вероятность × Ущерб = Уровень риска (матрица 5×5: от незначительного до критического)</li>
      <li>Стратегии: <strong>снижение</strong> (патч), <strong>передача</strong> (страховка), <strong>принятие</strong> (осознанное), <strong>избежание</strong> (отказ от фичи)</li>
      <li>CVSS v3.1: Base (техническая критичность) + Temporal (есть ли эксплойт) + Environmental (ваш контекст)</li>
      <li>Стандарты: ISO 27005, NIST SP 800-30, ГОСТ Р ИСО/МЭК 27005 — выбор зависит от требований регулятора</li>
      <li>Практика: CVSS ≥ 9.0 + публичный эксплойт + доступ из интернета = <strong>немедленный патч</strong></li>
    </ul>
  </div>

</div>