---
title: "Troubleshooting — решение проблем в лабораторных работах AppSec"
description: "Troubleshooting курса AppSec: решения частых ошибок Git, Docker, Python, CI/CD, SAST и DAST при выполнении лабораторных работ."
keywords: "troubleshooting, FAQ, ошибки, AppSec, Docker, Git, Python, CI/CD, SAST, DAST, решения, отладка, лабораторные работы"
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

---

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

---

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

</div>

---

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

---

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

---

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

---

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

---

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
