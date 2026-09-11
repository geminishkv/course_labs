---
title: "Troubleshooting — решение проблем в лабораторных работах AppSec"
description: "Troubleshooting курса AppSec: решения частых ошибок Git, Docker, Python, CI/CD, SAST и DAST при выполнении лабораторных работ."
keywords: "troubleshooting, FAQ, ошибки, AppSec, Docker, Git, Python, CI/CD, SAST, DAST, решения, отладка, лабораторные работы, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Troubleshooting</h1>
    <p class="hero-sub">Частые проблемы и решения по лабораторным работам</p>
  </div>
</div>

## Git и GitHub (Lab 01, 09)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Permission denied (publickey)</div>
  <span class="lab-tag">git push · git clone</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">SSH-ключ не добавлен в GitHub или агент не запущен.</p>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>ssh-keygen -t ed25519</code> → скопировать <code>~/.ssh/id_ed25519.pub</code> → GitHub Settings → SSH Keys. Проверить: <code>ssh -T git@github.com</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">fatal: not a git repository</div>
  <span class="lab-tag">git</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Вы не в директории репозитория. Проверьте <code>pwd</code> и перейдите в корень проекта. Если репозиторий не создан: <code>git init</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Detached HEAD</div>
  <span class="lab-tag">git checkout</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">HEAD указывает на коммит, а не на ветку. Вернуться: <code>git switch develop</code>. Если есть незакоммиченные изменения: <code>git switch -c temp-branch</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Merge conflict</div>
  <span class="lab-tag">git merge · git pull</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Откройте конфликтные файлы, найдите маркеры <code>&lt;&lt;&lt;&lt;&lt;&lt;&lt;</code>, выберите нужный вариант, удалите маркеры. <code>git add .</code> → <code>git commit</code></p>
  </div>

</div>

***

## Linux и Shell (Lab 02)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">command not found</div>
  <span class="lab-tag">tree · locate · nmap</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Утилита не установлена. Ubuntu: <code>sudo apt install tree mlocate nmap</code>. macOS: <code>brew install tree nmap</code>. После установки <code>locate</code>: <code>sudo updatedb</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Permission denied</div>
  <span class="lab-tag">chmod · sudo</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Нет прав на выполнение скрипта: <code>chmod +x script.sh</code>. Нет прав на системное действие: <code>sudo command</code>. Для Docker без sudo: добавьте пользователя в группу <code>docker</code></p>
  </div>

</div>

***

## Nmap (Lab 03)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Nmap requires root privileges</div>
  <span class="lab-tag">nmap -sS · nmap -O</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">SYN-скан и OS detection требуют root: <code>sudo nmap -sS target</code>. Без root используйте connect-скан: <code>nmap -sT target</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Host seems down</div>
  <span class="lab-tag">nmap</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Хост блокирует ICMP. Используйте <code>nmap -Pn target</code> для пропуска ping-проверки. Или проверьте, что таргет доступен: <code>ping target</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">xsltproc: command not found</div>
  <span class="lab-tag">nmap XML → HTML</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Утилита для конвертации XML-отчёта в HTML. Ubuntu: <code>sudo apt install xsltproc</code>. macOS: <code>brew install libxslt</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">NSE scripts: not found</div>
  <span class="lab-tag">nmap --script</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">NSE-скрипты не установлены или путь неверен. Обновите базу: <code>sudo nmap --script-updatedb</code>. Проверьте: <code>ls /usr/share/nmap/scripts/</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Scan takes too long</div>
  <span class="lab-tag">nmap -p-</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Сканирование всех 65535 портов долгое. Используйте <code>-T4</code> для ускорения или ограничьте порты: <code>-p 22,80,443,3306,8080</code></p>
  </div>

</div>

***

## Docker (Lab 05, 06)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Cannot connect to Docker daemon</div>
  <span class="lab-tag">docker</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Docker daemon не запущен. Linux: <code>sudo systemctl start docker</code>. macOS: запустите Docker Desktop. Проверка: <code>docker info</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Port already in use</div>
  <span class="lab-tag">docker-compose up</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Порт занят другим процессом. Найти: <code>lsof -i :8080</code>. Убить: <code>kill -9 PID</code>. Или измените порт в <code>docker-compose.yml</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">docker-bench-security не работает на macOS</div>
  <span class="lab-tag">Lab 06 · CIS</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Docker Desktop на macOS не поддерживает docker-bench-security напрямую (нет нативного Docker Engine). Используйте Trivy для сканирования образов: <code>trivy image &lt;name&gt;</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">No space left on device</div>
  <span class="lab-tag">docker build</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Диск забит Docker-артефактами. Очистка: <code>docker system prune -af</code> (удалит все неиспользуемые образы, контейнеры, volumes)</p>
  </div>

</div>

***

## SAST и SCA (Lab 07)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Semgrep: no rules found</div>
  <span class="lab-tag">semgrep scan</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Неправильный путь к конфигу. Проверьте: <code>semgrep --config sast/semgrep-rules.yml --test</code>. Для авто-правил: <code>semgrep --config auto</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">OSS Index 401 Unauthorized</div>
  <span class="lab-tag">dependency-check</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">OSS Index API требует авторизацию. Основное сканирование через NVD работает без неё. Для NVD API key: зарегистрируйтесь на <code>nvd.nist.gov</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Maven: mvn command not found</div>
  <span class="lab-tag">Lab 07 · SCA</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Maven не установлен. Ubuntu: <code>sudo apt install maven</code>. macOS: <code>brew install maven</code>. Проверка: <code>mvn --version</code></p>
  </div>

</div>

***

## DAST — OWASP ZAP (Lab 08)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">ZAP: Connection refused</div>
  <span class="lab-tag">zap-baseline.py</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Приложение не запущено или недоступно из контейнера ZAP. Проверьте: <code>curl http://localhost:8080</code>. В Docker-to-Docker: используйте <code>host.docker.internal</code> вместо <code>localhost</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">ZAP: scan takes too long</div>
  <span class="lab-tag">zap-full-scan</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Full scan может занять 15–60 мин. Для быстрой проверки используйте baseline scan: <code>zap-baseline.py -t URL</code> (~2 мин, только пассивные проверки)</p>
  </div>

</div>

***

## CI/CD — GitHub Actions (Lab 09)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Workflow не запускается</div>
  <span class="lab-tag">GitHub Actions</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Проверьте: файл лежит в <code>.github/workflows/</code> (точно с точкой в начале). Триггер совпадает с веткой push. YAML валиден: <code>yamllint .github/workflows/ci.yml</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Job failed: exit code 1</div>
  <span class="lab-tag">Trivy · ZAP · Semgrep</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Инструмент нашёл уязвимости и вернул ненулевой код. Это ожидаемо в режиме quality gate. Для режима аудита: <code>exit-code: "0"</code> или <code>--soft-fail</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Secret not available in workflow</div>
  <span class="lab-tag">GitHub Secrets</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Секреты не доступны в fork PR (по безопасности). Для своего репо: Settings → Secrets → Actions → New repository secret</p>
  </div>

</div>

***

## VirtualBox и VM (Подготовка окружения)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">VT-x is not available</div>
  <span class="lab-tag">VirtualBox</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Включите виртуализацию в BIOS: Intel VT-x / AMD-V. На ноутбуках часто отключена по умолчанию.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">VM не загружается с ISO</div>
  <span class="lab-tag">VirtualBox</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Проверьте порядок загрузки: Настройки → Система → Оптический диск первым. Убедитесь что ISO подключён в Носителях.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Нет интернета в VM</div>
  <span class="lab-tag">VirtualBox · Сеть</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Сетевой адаптер: NAT. Если не помогает — перезагрузите VM. Для доступа к VM с хоста: Host-only Adapter.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Маленький экран VM</div>
  <span class="lab-tag">Guest Additions</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Установите Guest Additions: <code>Устройства → Подключить образ диска Дополнений</code> → <code>sudo /mnt/VBoxLinuxAdditions.run</code> → reboot</p>
  </div>

</div>

***

## GPG и подпись коммитов (Lab 01)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">error: gpg failed to sign the data</div>
  <span class="lab-tag">git commit -S</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">GPG не может получить доступ к TTY. Решение: <code>export GPG_TTY=$(tty)</code> (добавьте в <code>~/.bashrc</code> или <code>~/.zshrc</code>)</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Коммит без бейджа Verified</div>
  <span class="lab-tag">GitHub · GPG</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Email в GPG-ключе не совпадает с email в GitHub. Проверьте: <code>gpg --list-keys</code> и <code>git config user.email</code> — должны совпадать. Публичный ключ должен быть добавлен в GitHub.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">gpg: keyserver receive failed</div>
  <span class="lab-tag">gpg</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Проблема с сетью или keyserver. Генерируйте ключ локально: <code>gpg --full-generate-key</code> — keyserver не нужен для GitHub.</p>
  </div>

</div>

***

## Gist и отчёты

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">gh gist create: 401 Unauthorized</div>
  <span class="lab-tag">GitHub CLI · Gist</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Не авторизованы или токен без scope <code>gist</code>. Решение: <code>gh auth login</code> → выбрать HTTPS → вставить токен с правами <code>gist</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Markdown не рендерится в Gist</div>
  <span class="lab-tag">Gist · Markdown</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Файл должен иметь расширение <code>.md</code>. Проверьте имя: <code>lab01_report.md</code>, не <code>.txt</code>. Превью: откройте Gist в браузере.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Код в отчёте не подсвечивается</div>
  <span class="lab-tag">Markdown</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Указывайте язык после тройных бэктиков: <code>```bash</code>, <code>```python</code>, <code>```yaml</code>. Без указания языка — подсветки не будет.</p>
  </div>

</div>

***

## Secret Detection (Lab 07)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">gitleaks: command not found</div>
  <span class="lab-tag">gitleaks</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Не установлен. macOS: <code>brew install gitleaks</code>. Linux: скачайте бинарник с <a href="https://github.com/gitleaks/gitleaks/releases">GitHub Releases</a>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">pre-commit hook не блокирует коммит</div>
  <span class="lab-tag">pre-commit · gitleaks</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Хуки не установлены: <code>pre-commit install</code>. Проверьте <code>.pre-commit-config.yaml</code> в корне репо. Тест: <code>pre-commit run --all-files</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Секрет уже попал в публичный репо</div>
  <span class="lab-tag">Инцидент · Ротация</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">1) Немедленно ротировать секрет. 2) Очистить историю: <code>git filter-repo</code> или BFG. 3) Force push. Секрет считается скомпрометированным с момента push.</p>
  </div>

</div>

***

## Trivy и Container Scanning (Lab 06)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">trivy: command not found</div>
  <span class="lab-tag">trivy</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">macOS: <code>brew install aquasecurity/trivy/trivy</code>. Linux: <code>curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Trivy: db download timeout</div>
  <span class="lab-tag">trivy · сеть</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Первый запуск скачивает базу уязвимостей (~30 MB). При медленном интернете: <code>trivy image --download-db-only</code> заранее. В CI используйте кэш.</p>
  </div>

</div>

***

## Risk Analysis (Lab 04, 10)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Не понимаю как оценить риск</div>
  <span class="lab-tag">Risk Analysis</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Используйте матрицу 5×5: Вероятность × Ущерб. Начните с актива (что защищаем), угрозы (от чего), уязвимости (через что), затем оцените вероятность и последствия.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Как выбрать стратегию снижения риска</div>
  <span class="lab-tag">Стратегии</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><strong>Снижение</strong> — патч, WAF. <strong>Передача</strong> — страховка, SLA. <strong>Принятие</strong> — осознанное, с мониторингом. <strong>Избежание</strong> — отказ от фичи. Выбор зависит от стоимости меры vs ущерба.</p>
  </div>

</div>

***

## Сети и TCP/IP (Intro)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">dig / nslookup: command not found</div>
  <span class="lab-tag">DNS · диагностика</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Утилиты DNS не установлены. Ubuntu: <code>sudo apt install dnsutils</code>. Fedora: <code>sudo dnf install bind-utils</code>. macOS: встроены.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">ss: command not found</div>
  <span class="lab-tag">Порты · сеть</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">На macOS <code>ss</code> нет — используйте <code>netstat -an</code> или <code>lsof -i -P</code>. На Linux: <code>sudo apt install iproute2</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">traceroute: Network unreachable</div>
  <span class="lab-tag">traceroute</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Нет маршрута. Проверьте интернет: <code>ping 8.8.8.8</code>. В VM — адаптер должен быть NAT. Альтернатива: <code>mtr target</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">curl: Connection refused</div>
  <span class="lab-tag">HTTP · порты</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Сервис не слушает на указанном порту. Проверьте: <code>ss -tlnp | grep :PORT</code>. Убедитесь, что приложение запущено и биндится на <code>0.0.0.0</code>, а не <code>127.0.0.1</code>.</p>
  </div>

</div>

***

## Docker Compose и Dockerfile (Intro, Lab 05)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">docker compose vs docker-compose</div>
  <span class="lab-tag">Docker Compose v2</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Docker Compose v2 — плагин: <code>docker compose</code> (без дефиса). Старый v1: <code>docker-compose</code>. Если v2 не работает: <code>sudo apt install docker-compose-plugin</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">COPY failed: file not found</div>
  <span class="lab-tag">Dockerfile · COPY</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">COPY работает относительно build context, а не Dockerfile. Убедитесь, что файл не исключён в <code>.dockerignore</code> и путь верный.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Image build: pip install fails</div>
  <span class="lab-tag">Dockerfile · pip</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Нет <code>requirements.txt</code> в контексте сборки или ошибка версий. Проверьте: <code>COPY requirements.txt .</code> стоит до <code>RUN pip install</code>. Пиньте версии: <code>flask==3.0.0</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">docker buildx: unknown flag</div>
  <span class="lab-tag">buildx · buildkit</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Buildx не установлен. Используйте <code>docker build</code> вместо <code>docker buildx build</code>. Или установите: <code>sudo apt install docker-buildx-plugin</code>.</p>
  </div>

</div>

***

## GitHub Actions YAML (Intro CI/CD, Lab 09)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">YAML syntax error: mapping values not allowed</div>
  <span class="lab-tag">YAML · Actions</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Отступы — только пробелы, не табы. 2 пробела на уровень. Двоеточие требует пробел после: <code>key: value</code>. Валидируйте: <code>yamllint file.yml</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Actions: Resource not accessible by integration</div>
  <span class="lab-tag">Permissions</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Workflow не имеет прав. Добавьте в YAML: <code>permissions: contents: read</code> (или <code>write</code> для push). Settings → Actions → General → Workflow permissions.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Artifact upload: No files found</div>
  <span class="lab-tag">upload-artifact</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Путь в <code>path:</code> не совпадает с реальным выводом инструмента. Проверьте, куда пишет отчёт: <code>ls -la pipeline/</code>. Путь чувствителен к регистру.</p>
  </div>

</div>

***

## CMS Security (Lab 10)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Где искать CVE для CMS</div>
  <span class="lab-tag">Lab 10 · WordPress · Битрикс</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">NVD: <code>nvd.nist.gov</code> поиск по CPE. WordPress: <code>wpscan.com/wordpresses</code>. Битрикс: <code>bdu.fstec.ru</code>. Также: <code>cve.mitre.org</code>, <code>exploit-db.com</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Как описать Proof-of-Concept</div>
  <span class="lab-tag">Lab 10 · CWE · PoC</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Структура: CWE-ID → описание уязвимости → условия эксплуатации → шаги воспроизведения → ожидаемый результат → мера устранения. Не нужен работающий exploit — достаточно вектора.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">Как оформить матрицу рисков</div>
  <span class="lab-tag">Lab 10 · Risk Matrix</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Таблица: Риск | Актив | Вероятность (1-5) | Влияние (1-5) | Оценка | Стратегия | Мера | Остаточный риск. Сортируйте по убыванию оценки (Вероятность × Влияние).</p>
  </div>

</div>

***

## Python и venv (общее)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">ModuleNotFoundError</div>
  <span class="lab-tag">Python · pip</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Зависимости не установлены или venv не активирован. Проверьте: <code>which python</code> (должен указывать на venv). <code>pip install -r requirements.txt</code></p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
  <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red); margin-bottom:0.1rem;">python: command not found</div>
  <span class="lab-tag">Python</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">На Linux/macOS команда <code>python3</code>, не <code>python</code>. Или создайте алиас: <code>alias python=python3</code>. Проверка версии: <code>python3 --version</code></p>
  </div>

</div>
