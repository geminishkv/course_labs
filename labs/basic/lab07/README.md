<div align="center">
<h1><a id="intro">Лабораторная работа №7</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a>
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/SAST-D51A1A?style=flat" alt="SAST">
<img src="https://img.shields.io/badge/SCA-D51A1A?style=flat" alt="SCA">
<img src="https://img.shields.io/badge/Semgrep-1B2333?style=flat" alt="Semgrep">
<img src="https://img.shields.io/badge/Checkov-333333?style=flat" alt="Checkov">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Салют :wave:,<br>
Данная лабораторная работа посвящена изучению аудита безопасности исходного кода приложения на статический анализ, включая проверки зависимостей. Мы рассмотрим как работать с `Semgrep`, `Checkov`, `Dependency Check` и правилами для них. Аналогично познакомимся с `maven`. Мы разберем как проверить конфигурации безопасности и выявить их не корректность, как произвести чекап.

Для сдачи данной работы также будет требоваться ответить на дополнительные вопросы по описанным темам.

***

## Структура репозитория лабораторной работы

```bash
lab07
├── cheat_check_yuorself.sh
├── docker-compose.yml
├── sast
│   ├── checkov-config.yaml
│   └── semgrep-rules.yml
├── sca
│   ├── dependency-check.sh
│   ├── generate_unified_report.sh
│   └── pom.xml
└── vulnerable-app
    ├── app.py
    ├── config.yaml
    ├── Dockerfile
    └── requirements.txt
```

***

## Материал

### SAST

Static Application Security Testing — статический анализ исходного кода, шаблонов и конфигураций на наличие уязвимостей без выполнения приложения:

> - Проверяются исходники, конфиги, Dockerfile, IaC‑файлы, шаблоны, но код не запускается
> - Инструменты SAST ищут небезопасные конструкции SQL‑инъекции, XSS, небезопасное использование криптографии, жёстко заданные секреты и т.п., сравнивая код с набором правил и паттернов
> - Подходит на ранних стадиях разработки: ошибки находят до деплоя, прямо на этапе коммита или CI

### SCA

Software Composition Analysis — анализ сторонних библиотек, зависимостей и компонентов, которые приложение использует:

> - Целью является поиск уязвимостей и проблем в сторонних пакетах
> - Инструменты строят «список компонентов» SBOM, сопоставляют версии библиотек с базами уязвимостей NVD, GitHub Advisories и др., а также показывают, какие зависимости нужно обновить

### Semgrep

Используется для анализа исходного кода и конфигураций по набору правил:

> - Работает по принципу «структурного grep»: ищет не просто строки, а языковые конструкции if, функции, вызовы библиотек, поэтому хорошо подходит для поиска уязвимых паттернов в Python, Java, JavaScript и т.д.
> - Поддерживает готовые правила, в том числе по OWASP Top 10, и кастомные, которые можно описать в YAML

### Checkov

Ориентирован на инфраструктуру как код (IaC) и Docker:

> - Анализирует Terraform, CloudFormation, Kubernetes‑манифесты, Dockerfile и другие инфраструктурные файлы на ошибки конфигурации, которые могут привести к уязвимостям, как открытые порты, небезопасные политики, отключённая проверка сертификатов и т.п.
> - Подходит для автоматической проверки Docker/IaC в пайплайнах, чтобы не пропускать небезопасные настройки в образах и инфраструктуре

### OWASP Dependency‑Check

Для поиска уязвимостей в зависимостях проекта:

> - Анализирует используемые библиотеки Maven‑зависимости, JAR‑файлы, Python‑пакеты и др., сопоставляет их с базами уязвимостей и выдаёт список известных проблем для конкретных версий по CVE

### Сравнение инструментов

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Semgrep</span><div class="lab-card-tags"><span class="lab-tag">SAST</span><span class="lab-tag">Code</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Структурный grep по AST. Python, Java, JS. Кастомные YAML-правила, OWASP Top 10. Ищет SQLi, XSS, hardcoded secrets.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Bandit</span><div class="lab-card-tags"><span class="lab-tag">SAST</span><span class="lab-tag">Python only</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Python-специфичный SAST. eval, pickle, subprocess, hardcoded passwords. Быстрый, но только Python.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Checkov</span><div class="lab-card-tags"><span class="lab-tag">SAST</span><span class="lab-tag">IaC</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">IaC-сканер: Dockerfile, docker-compose, Terraform, K8s YAML. Проверяет конфигурации на мисконфигурации.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">OWASP DC</span><div class="lab-card-tags"><span class="lab-tag">SCA</span><span class="lab-tag">CVE</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Анализ зависимостей: Maven (pom.xml), JAR, Python. Сопоставляет версии с NVD, GitHub Advisories.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Gitleaks</span><div class="lab-card-tags"><span class="lab-tag">Secret Detection</span><span class="lab-tag">regex</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Сканирует git-историю на секреты: AWS keys, tokens, passwords. Regex-паттерны, pre-commit hook.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">TruffleHog</span><div class="lab-card-tags"><span class="lab-tag">Secret Detection</span><span class="lab-tag">entropy</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Поиск по энтропии строк + regex. Находит секреты, которые regex пропускает. Верификация найденного.</span></div>
</div>

***

## Задание

- [ ] 1. Разверните и подготовьте окружение для уязвимого приложения

```bash
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r vulnerable-app/requirements.txt
```

- [ ] 2. Запустите уязвимое приложение

```bash
$ docker compose -f docker-compose.yml up -d --build # http://localhost:8080
```

- [ ] 3. Запустите SAST Semgrep и проанализируйте результаты. Для каждой сработки опишите в отчёте:

    - Rule ID и severity (ERROR / WARNING / INFO)
    - Файл и строка, где сработало правило
    - Что именно ищет правило (паттерн из `semgrep-rules.yml`)
    - Почему это уязвимость (ссылка на CWE, если применимо)
    - Как исправить

```bash
$ semgrep --config sast/semgrep-rules.yml \
  --json \
  --output sast/semgrep-report.json \
  vulnerable-app/
```

- [ ] 4. Запустите SAST Checkov по Dockerfile и compose. Для каждой сработки опишите: Check ID (CKV_DOCKER_*), что проверяет, PASSED/FAILED/UNKNOWN, и как исправить

```bash
$ checkov \
  --framework dockerfile \
  --file vulnerable-app/Dockerfile docker-compose.yml \
  --output json \
  --output-file-path sast/checkov-report.json \
  --soft-fail
```

- [ ] 5. Установите Maven и JDK для SCA-сканирования (если не установлены):

```bash
# Ubuntu / Debian
$ sudo apt install -y maven default-jdk

# Fedora
$ sudo dnf install -y maven java-latest-openjdk

# macOS
$ brew install maven

# Проверка
$ mvn --version
$ java --version
```

- [ ] 6. Подготовка зависимостей Java и Maven‑скан для проведения SCA. Отчеты будут в директории SCA. Будет ошибка, которую надо поправить, чтобы уязвимости определялись или добавить дополнительные уязвимости для их вывода в отчете

```bash
$ bash sca/dependency-check.sh --update       # обновление базы NVD API
$ cd sca && mvn dependency:resolve            # резолвинг зависимостей из pom.xml
$ mvn dependency:copy-dependencies -DoutputDirectory=./lib  # JAR в ./lib
$ mvn org.owasp:dependency-check-maven:check || true        # Maven-плагин OWASP
$ cd ..                                       # возврат в корень lab07
```

- [ ] 7. Запустите SCA CLI OWASP Dependency-Check для уязвимого приложения. Опишите в отчёте:

    - Как DC определяет CPE (Common Platform Enumeration) для библиотек
    - Как сопоставляет CPE с базой NVD для поиска CVE
    - Разница сканирования `pom.xml` (Java, манифест зависимостей) vs `requirements.txt` (Python, pip)
    - Для каждой найденной CVE: пакет, версия, CVSS score, описание, рекомендуемая версия для обновления
- [ ] 8. Соберите единый отчет из всех сканирований в виде `html`, `csv`, `json`

```bash
$ bash sca/generate_unified_report.sh
```

- [ ] 9. Проанализируйте все уязвимости и объясните для SAST Checkov сработки статуса `Unknown`. Классифицируйте их и укажите какие не должны быть в отчетах. Внесите исправления и запустите повторное сканирование и убедитесь, что они устранены. Приложите исправленный файл и отчет без уязвимостей.
- [ ] 10. Опишите выведенные уязвимости для SAST Semgrep и принцип их работы. Поправьте скрипт `app.py`. Запустите повторное сканирование и убедитесь, что они устранены. Приложите исправленный файл `app.py` и отчет без уязвимостей.
- [ ] 11. Выявите минимум 1 false positive в результатах любого сканера. Обоснуйте, почему это FP, и настройте исключение:

```bash
# Semgrep: добавить nosemgrep-комментарий или .semgrepignore
# Checkov: --skip-check CKV_DOCKER_XXX
# Gitleaks: .gitleaksignore
```

Запустите повторное сканирование и убедитесь, что FP исключён, а реальные находки остались.

- [ ] 12. Напишите собственное Semgrep-правило для поиска hardcoded password в Python. Сохраните в `sast/custom-rules.yml`:

```yaml
rules:
  - id: hardcoded-password
    patterns:
      - pattern: $VAR = "..."
      - metavariable-regex:
          metavariable: $VAR
          regex: (?i)(password|passwd|secret|api_key|token)
    message: "Hardcoded secret in variable '$VAR'"
    languages: [python]
    severity: ERROR
```

Протестируйте на `vulnerable-app/app.py`:

```bash
$ semgrep --config sast/custom-rules.yml vulnerable-app/
```

- [ ] 13. Убедитесь, что в финальных отчётах остались только SCA-уязвимости (зависимости), а SAST-находки устранены.
- [ ] 14. Сведите все находки SAST и SCA в сравнительную таблицу:

    - Инструмент (Semgrep / Checkov / OWASP DC / Gitleaks)
    - Тип (SAST / SCA / Secret Detection)
    - Что нашёл (краткое описание)
    - Severity (Critical / High / Medium / Low)
    - True Positive или False Positive (с обоснованием)
    - Статус (Fixed / Accepted / Excluded)

- [ ] 15. Проверьте себя по найденным сработкам анализаторов

```bash
$ bash cheat_check_yuorself.sh
```

- [ ] 16. Делайте все коммиты на соответствующих шагах, далее заливайте изменения в удалённый репозиторий

***

## Secret Detection

Секреты в коде (API-ключи, токены, пароли) — одна из топовых причин компрометации. Даже удалённый коммит остаётся в `git reflog` и может быть извлечён.

### Инструменты Secret Detection

- **Gitleaks** — сканирует git-историю по regex-паттернам: AWS keys, GitHub tokens, passwords, private keys
- **TruffleHog** — поиск по entropy (высокая энтропия строки = вероятный секрет) + regex-паттерны
- **detect-secrets** — генерирует baseline: отслеживает новые секреты между коммитами, позволяет вести whitelist для false positives
- **Pre-commit hook** — блокирует коммит при обнаружении секрета до попадания в историю

> Секреты, попавшие в публичный репозиторий, считаются скомпрометированными **немедленно** — боты сканируют GitHub в реальном времени. Ротация секрета — первый шаг, очистка истории — второй.

### Практика Secret Detection

- [ ] 17. Установите `gitleaks` и просканируйте репозиторий лабораторной работы

```bash
# установка (macOS)
$ brew install gitleaks

# установка (Linux)
$ curl -sSfL https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks_linux_x64 -o /usr/local/bin/gitleaks && chmod +x /usr/local/bin/gitleaks

# сканирование текущего репозитория (вся git-история)
$ gitleaks detect -v

# сканирование с JSON-отчётом
$ gitleaks detect --source . --report-path gitleaks-report.json --report-format json
```

- [ ] 18. Изучите `vulnerable-app/app.py` и `vulnerable-app/config.yaml` — найдите в них захардкоженные секреты вручную. Сопоставьте с тем, что нашёл `gitleaks`

- [ ] 19. Установите `trufflehog` и запустите сканирование. Сравните результаты с `gitleaks` — какой инструмент нашёл больше? Почему?

```bash
# установка
$ pip install trufflehog

# сканирование git-репозитория
$ trufflehog git file://. --only-verified
```

- [ ] 20. Настройте pre-commit hook для блокировки коммитов с секретами

```bash
# установка pre-commit
$ pip install pre-commit

# создайте .pre-commit-config.yaml
$ cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks
EOF

# установка хуков
$ pre-commit install

# проверка: попробуйте закоммитить файл с секретом
$ echo 'API_KEY = "AKIAIOSFODNN7EXAMPLE"' > test_secret.py
$ git add test_secret.py
$ git commit -m "test: should be blocked"
# ожидается: gitleaks заблокирует коммит
$ rm test_secret.py
```

- [ ] 21. Опишите в отчёте:
    - Какие секреты были найдены каждым инструментом
    - Разница в подходах: regex (gitleaks) vs entropy (trufflehog)
    - Как pre-commit hook предотвращает попадание секретов в историю
    - Что делать, если секрет уже попал в публичный репозиторий (порядок действий)

***

- [ ] 22. Подготовьте отчёт `gist`
- [ ] 23. Почистите кеш от `venv` и остановите уязвимое приложение

```bash
$ deactivate
$ rm -rf venv
$ docker compose -f docker-compose.yml down
$ docker system prune -f
```

***

## Смотри также

- [Лаб. №6 — CIS Benchmark](https://course.geminishkv.tech/labs/basic/lab06/) — аудит конфигурации Docker
- [Лаб. №8 — DAST](https://course.geminishkv.tech/labs/basic/lab08/) — динамическое тестирование (следующий этап)
- [Лаб. №9 — CI/CD](https://course.geminishkv.tech/labs/basic/lab09/) — автоматизация SAST/SCA в пайплайне
- [Установка AppSec-инструментов](https://course.geminishkv.tech/labs/intro/appsec_tools_setup/) — установка Semgrep, Checkov, Gitleaks
- [AppSec Toolchain](https://course.geminishkv.tech/materials/appsec_tt/) — классификация инструментов

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/troubleshooting/).

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://docs.docker.com/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://stackedit.io" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Markdown</div><div class="lab-card-tags"><span class="lab-tag">stackedit.io</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gist.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Gist</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://pvs-studio.ru/ru/blog/posts/csharp/0876/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">OWASP Top Ten и Software Composition Analysis</div><div class="lab-card-tags"><span class="lab-tag">pvs-studio.ru</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://owasp.org/www-project-dependency-check/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">OWASP Dependency-Check</div><div class="lab-card-tags"><span class="lab-tag">owasp.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://semgrep.dev/docs/getting-started/cli" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Semgrep CLI – Local scans</div><div class="lab-card-tags"><span class="lab-tag">semgrep.dev</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://semgrep.dev/docs/cli-reference/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Semgrep CLI reference</div><div class="lab-card-tags"><span class="lab-tag">semgrep.dev</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://www.checkov.io/2.Basics/CLI%20Command%20Reference.html" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Checkov CLI Command Reference</div><div class="lab-card-tags"><span class="lab-tag">checkov.io</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/gitleaks/gitleaks" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Gitleaks</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/trufflesecurity/trufflehog" target="_blank"><div class="lab-card-body"><div class="lab-card-title">TruffleHog</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/Yelp/detect-secrets" target="_blank"><div class="lab-card-body"><div class="lab-card-title">detect-secrets</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://pre-commit.com/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Pre-commit</div><div class="lab-card-tags"><span class="lab-tag">pre-commit.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.github.com/en" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub Docs</div><div class="lab-card-tags"><span class="lab-tag">docs.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
