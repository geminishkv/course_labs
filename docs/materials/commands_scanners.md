---
hide:
  - toc

title: "Команды сканеров: Nmap, SAST, SCA, DAST, CI | Курс AppSec"
description: "Справочник команд сканеров курса AppSec: Nmap, Semgrep и Bandit, анализ зависимостей, OWASP ZAP, поиск секретов и сборка их в конвейер GitHub Actions."
keywords: "Nmap, SAST, SCA, DAST, Semgrep, Bandit, Trivy, OWASP ZAP, Gitleaks, TruffleHog, GitHub Actions, CI/CD, справочник, AppSec, DevSecOps, курс AppSec, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Команды: сканеры и конвейер</h1>
    <p class="hero-sub">Nmap, SAST, SCA, DAST, поиск секретов и GitHub Actions</p>
  </div>
</div>

Команды запуска сканеров из лабораторных 03, 07 и 08 и то, как они собираются в конвейер в лабораторной 09. Что каждый класс инструментов видит и чего не видит, описано в классификации инструментов. В карточке про GitHub Actions actions показаны по тегу версии для краткости: в своём конвейере закрепляйте их по SHA коммита, как в шпаргалке по безопасности GitHub Actions.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">01</span>
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
    <span class="lab-card-num">02</span>
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
    <span class="lab-card-num">03</span>
    <span class="lab-card-title" style="font-weight:700;">SCA — Анализ зависимостей</span>
  </div>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
  <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Проверка зависимостей на известные CVE — одна из самых частых причин компрометации (supply chain attacks)</p>
    <li><code>pip-audit</code> — проверяет Python-пакеты по базе OSV/PyPI Advisory</li>
    <li><code>trivy fs --scanners vuln .</code> — Trivy: универсальный сканер (Python, Node, Go, Java, Ruby)</li>
    <li><code>trivy image &lt;name&gt;:&lt;tag&gt;</code> — сканирование Docker-образа (ОС-пакеты + языковые зависимости)</li>
    <li><code>dependency-check -s . -o ./reports --nvdApiKey "$NVD_API_KEY"</code> — OWASP DC: маппинг CPE → NVD, HTML-отчёт</li>
    <li><code>npm audit</code> / <code>npm audit fix</code> — встроенный аудит Node.js</li>
    <li>В отчёте искать: <strong>CRITICAL/HIGH</strong> с публичным эксплойтом → приоритет на обновление</li>
  </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">04</span>
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
    <span class="lab-card-num">05</span>
    <span class="lab-card-title" style="font-weight:700;">Secret Detection</span>
  </div>
  <ul style="font-size:0.77rem; margin:0; padding-left:1.1rem; color:#444; line-height:1.7;">
  <p style="font-size:0.72rem; color:#888; margin:0 0 0.4rem;">Секреты в git-истории — одна из топ причин утечек. Даже удалённый коммит остаётся в reflog</p>
    <li><code>gitleaks detect -v</code> — сканирует всю git-историю по regex-паттернам (AWS keys, tokens, passwords)</li>
    <li><code>gitleaks detect --source . --report-path report.json</code> — машиночитаемый отчёт для CI</li>
    <li><code>trufflehog git file://.</code> — детекторы форматов ключей конкретных сервисов и проверка найденного ключа через API сервиса</li>
    <li><code>detect-secrets scan &gt; .secrets.baseline</code> — baseline: отслеживает новые секреты между коммитами</li>
    <li>Pre-commit hook: <code>gitleaks protect --staged</code> — блокирует коммит если найден секрет</li>
  </ul>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.5rem;">
  <div style="display:flex; align-items:center; gap:0.7rem; width:100%;">
    <span class="lab-card-num">06</span>
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

</div>

## Смотри также

- [Классификация инструментов](appsec_tt.md) — что видит и чего не видит каждый класс сканеров
- [Разбор находок сканеров](findings_triage.md) — ложные срабатывания, исключения, принятый риск
- [CheatSheet: Nmap](cheatsheet/CHEATSHEET_NMAP.md) — сценарии сканирования и NSE
- [CheatSheet: GitHub Actions Security](cheatsheet/CHEATSHEET_GH_ACTIONS_SECURITY.md) — права, закрепление по SHA, секреты
- [Лаб. 09 · DevSecOps CI/CD на GitHub Actions](../labs/basic/lab09.md) — конвейер из сканеров
- [Приложение](APPENDIX.md) — все справочники команд на одной странице
