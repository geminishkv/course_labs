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

- SAST Static Application Security Testing — это статический анализ исходного кода, шаблонов и конфигураций на наличие уязвимостей без выполнения приложения, где:

> - Проверяются исходники, конфиги, Dockerfile, IaC‑файлы, шаблоны, но код не запускается
> - Инструменты SAST ищут небезопасные конструкции SQL‑инъекции, XSS, небезопасное использование криптографии, жёстко заданные секреты и т.п., сравнивая код с набором правил и паттернов
> - Подходит на ранних стадиях разработки: ошибки находят до деплоя, прямо на этапе коммита или CI

- SCA Software Composition Analysis — анализ сторонних библиотек, зависимостей и компонентов, которые приложение использует, где:

> - Целью является поиск уязвимостей и проблем в сторонних пакетах
> - Инструменты строят «список компонентов» SBOM, сопоставляют версии библиотек с базами уязвимостей NVD, GitHub Advisories и др., а также показывают, какие зависимости нужно обновить

- Semgrep используется для анализа исходного кода и конфигураций по набору правил, где:

> - Работает по принципу «структурного grep»: ищет не просто строки, а языковые конструкции if, функции, вызовы библиотек, поэтому хорошо подходит для поиска уязвимых паттернов в Python, Java, JavaScript и т.д.
> - Поддерживает готовые правила, в том числе по OWASP Top 10, и кастомные, которые можно описать в YAML

- Checkov ориентирован на инфраструктуру как код (IaC) и Docker, где:

> - Анализирует Terraform, CloudFormation, Kubernetes‑манифесты, Dockerfile и другие инфраструктурные файлы на ошибки конфигурации, которые могут привести к уязвимостям, как открытые порты, небезопасные политики, отключённая проверка сертификатов и т.п.
> - Подходит для автоматической проверки Docker/IaC в пайплайнах, чтобы не пропускать небезопасные настройки в образах и инфраструктуре

- OWASP Dependency‑Check для поиска уязвимостей в зависимостях проекта, где

> - Анализирует используемые библиотеки Maven‑зависимости, JAR‑файлы, Python‑пакеты и др., сопоставляет их с базами уязвимостей и выдаёт список известных проблем для конкретных версий по CVE

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
$ docker-compose -f docker-compose.yml up -d --build # http://localhost:8080
```

- [ ] 3. Запустите SAST Semgrep и проанализируйте выведенный лог в консоли и опишите логику правил для `semgrep-rules.yml` исходя из паттернов, которые используются. Отчет будет в директории SAST

```bash
$ semgrep --config sast/semgrep-rules.yml \
  --json \
  --output sast/semgrep-report.json \
  vulnerable-app/
```

- [ ] 4. Запустите SAST Checkov по Dockerfile, compose и проанализируйте выведенный лог в консоли и опишите логику правил для `checkov-config.yaml` по `Docker`. Отчет будет в директории SAST

```bash
$ checkov \
  --framework dockerfile \
  --file vulnerable-app/Dockerfile docker-compose.yml \
  --output json \
  --output-file-path sast/checkov-report.json \
  --soft-fail
```

- [ ] 5. Подготовка зависимостей Java и Maven‑скан для проведения SCA. Отчеты будут в директории SCA. Будет ошибка, которую надо поправить, что бы уязвимости определялись или добавить дополнительные уязвимости для их вывода в отчете

```bash
$ cd sca
$ ./dependency-check.sh --update # обновление и поставка базы NVD API
$ mvn dependency:resolve
$ mvn dependency:copy-dependencies -DoutputDirectory=./lib # зависимости из $ pom.xml как jar в ./lib
$ mvn org.owasp:dependency-check-maven:check || true # Maven-плагин OWASP
```

- [ ] 6. Запустите SCA CLI OWASP Dependency-Check для уязвимого приложения. Отчеты будут в директории SCA. Опишите как работает сканирование SCA для `pom.xml` и `app.py`
- [ ] 7. Соберите единый отчет из всех сканирований в виде `html`, `csv`, `json`

```bash
$ bash sca/generate_unified_report.sh
```

- [ ] 8. Проанализируйте все уязвимости и обьясните для SAST Checkov сработки статуса `Unknown`. Классифицируйте их и укажите какие не должны быть в отчетах. Внесите исправления и запустите повторное сканирование и убедитесь, что они устранены. Приложите исправленный файл и отчет без уязвимостей. 
- [ ] 9. Опишите выведенные уязвимости для SAST Semgrep и принцип их работы. Поправьте скрипт `app.py`. Запустите повторное сканирование и убедитесь, что они устранены. Приложите исправленный файл `app.py` и отчет без уязвимостей. 
- [ ] 10. Доработайте SCA уязвимости, чтобы они только остались в финальной версии отчетов.
- [ ] 11. Проверьте себя по найденным сработкам анализаторов и так вы сможете помочь себе разобраться в ситуации, если возникнут сложности

```bash
$ bash cheat_check_yuorself.sh
```

- [ ] 12. Делайте все коммиты на соответствующих шагах, далее заливайте изменения в удаленный репозиторий.
- [ ] 13. Подготовьте отчет `gist`.
- [ ] 14. Почистите кеш от `venv` и остановите уязвимое приложение

```bash
$ deactivate
$ rm -rf venv
$ docker-compose -f xxx down
$ docker-compose -f docker-compose.yml down
$ docker system prune -f
```

***

## Secret Detection (дополнительный блок)

Секреты в коде (API-ключи, токены, пароли) — одна из топовых причин компрометации. Даже удалённый коммит остаётся в `git reflog` и может быть извлечён.

### Инструменты Secret Detection

- **Gitleaks** — сканирует git-историю по regex-паттернам: AWS keys, GitHub tokens, passwords, private keys
- **TruffleHog** — поиск по entropy (высокая энтропия строки = вероятный секрет) + regex-паттерны
- **detect-secrets** — генерирует baseline: отслеживает новые секреты между коммитами, позволяет вести whitelist для false positives
- **Pre-commit hook** — блокирует коммит при обнаружении секрета до попадания в историю

> Секреты, попавшие в публичный репозиторий, считаются скомпрометированными **немедленно** — боты сканируют GitHub в реальном времени. Ротация секрета — первый шаг, очистка истории — второй.

### Практика Secret Detection

- [ ] 15. Установите `gitleaks` и просканируйте репозиторий лабораторной работы

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

- [ ] 16. Изучите `vulnerable-app/app.py` и `vulnerable-app/config.yaml` — найдите в них захардкоженные секреты вручную. Сопоставьте с тем, что нашёл `gitleaks`

- [ ] 17. Установите `trufflehog` и запустите сканирование. Сравните результаты с `gitleaks` — какой инструмент нашёл больше? Почему?

```bash
# установка
$ pip install trufflehog

# сканирование git-репозитория
$ trufflehog git file://. --only-verified
```

- [ ] 18. Настройте pre-commit hook для блокировки коммитов с секретами

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

- [ ] 19. Опишите в отчёте:
    - Какие секреты были найдены каждым инструментом
    - Разница в подходах: regex (gitleaks) vs entropy (trufflehog)
    - Как pre-commit hook предотвращает попадание секретов в историю
    - Что делать, если секрет уже попал в публичный репозиторий (порядок действий)

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/troubleshooting/).

## Links

- [Docker](https://docs.docker.com/)
- [Markdown](https://stackedit.io)
- [Gist](https://gist.github.com)
- [GitHub CLI](https://cli.github.com)
- [OWASP Top Ten и Software Composition Analysis](https://pvs-studio.ru/ru/blog/posts/csharp/0876/)
- [OWASP Dependency-Check](https://owasp.org/www-project-dependency-check/)
- [Semgrep CLI – Local scans](https://semgrep.dev/docs/getting-started/cli)
- [Semgrep CLI reference](https://semgrep.dev/docs/cli-reference/)
- [Checkov CLI Command Reference](https://www.checkov.io/2.Basics/CLI%20Command%20Reference.html)
- [Gitleaks](https://github.com/gitleaks/gitleaks)
- [TruffleHog](https://github.com/trufflesecurity/trufflehog)
- [detect-secrets](https://github.com/Yelp/detect-secrets)
- [Pre-commit](https://pre-commit.com/)
- [GitHub Docs](https://docs.github.com/en)
