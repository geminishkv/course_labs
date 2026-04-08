<div align="center">
<h1><a id="intro">Лабораторная работа №6</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a>
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white" alt="Docker">
<img src="https://img.shields.io/badge/CIS_Benchmark-D51A1A?style=flat" alt="CIS Benchmark">
<img src="https://img.shields.io/badge/Trivy-1904DA?style=flat&logo=aquasecurity&logoColor=white" alt="Trivy">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Салют :wave:,<br>
Данная лабораторная работа посвящена изучению аудита безопасности `Docker` при использовании `Docker Bench Security`. Мы рассмотрим как с ним работать. Мы разберем как проверить конфигурации безопасности и выявить их не корректность, как произвести чекап с `CIS Docker Benchmark v1.6.0`.

Для сдачи данной работы также будет требоваться ответить на дополнительные вопросы по описанным темам.

***

## Структура репозитория лабораторной работы

```bash
lab06
├── audit.sh
├── config
│   └── nginx.conf
├── docker-compose.yml
├── README.md
└── vulnerable-app.yml
```

***

## Материал

### Docker Bench Security

Официальный инструмент аудита безопасности от Docker, который проверяет практики развертывания на соответствие `CIS Docker Benchmark`.

Реальный аудит контейнерной безопасности выполняется на Linux‑хосте / WSL2 с нативным Docker Engine, что соответствует методике CIS и практике промышленного Docker hardening.

### Рассматриваемые вопросы безопасности

- Привилегированные контейнеры
- Захардкоженные данные учёток
- Отключенные профили безопасности (AppArmor, Seccomp)
- Прямое монтирование файловой системы
- Устаревшие образы и явный запуск сервисов от привилегированного пользователя
- Дополнительные сервисы, лишние утилиты
- Расширенные volume‑маунты
- env и SQL‑инициализации
- Примеры анти‑паттернов: privileged, host‑network, docker.sock, secrets-in-env, outdated images

### Контекст безопасности

> Основные принципы безопасности Docker описаны в [Лаб. №5](https://course.geminishkv.tech/labs/basic/lab05/) — здесь фокус на аудите и проверке их выполнения через CIS Benchmark.

### Уровни CIS Docker Benchmark

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Level 1</span><div class="lab-card-tags"><span class="lab-tag">Базовый</span><span class="lab-tag">Обязательный</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Минимальный набор проверок, не влияющий на производительность. Подходит для всех окружений.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Level 2</span><div class="lab-card-tags"><span class="lab-tag">Расширенный</span><span class="lab-tag">Продвинутый</span></div><span style="font-size:0.72rem; color:#555; line-height:1.4;">Углублённые проверки, могут ограничивать функциональность. Для production и высокого уровня защиты.</span></div>
</div>

### Категории проверок CIS

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">1. Host Configuration</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Аудит, файловые разрешения, логирование Docker daemon, настройки ядра хоста</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">2. Docker Daemon</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">TLS, авторизация, сетевой режим, логирование, live restore, user namespace</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">3. Docker Daemon Files</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Права на docker.sock, конфиги daemon, TLS-сертификаты, /etc/docker</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">4. Container Images</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Доверенные базовые образы, USER не root, HEALTHCHECK, минимизация пакетов</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">5. Container Runtime</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">AppArmor/seccomp, capabilities, privileges, read-only FS, ресурсные лимиты</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">6. Docker Security Ops</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Сканирование образов, Content Trust, мониторинг, incident response</span></div>
</div>

***

## Задание

- [ ] 1. Необходимо установить `Docker Engine` для Linux

```bash
$ sudo apt-get update
$ sudo apt-get install -y docker.io
$ sudo usermod -aG docker "$USER"

$ sudo systemctl start docker
$ docker pull docker/docker-bench-security
```

- [ ] 2. Проверьте работу Docker и сделайте скрипт `audit.sh` исполняемым
- [ ] 3. Разверните уязвимое приложение как отдельные стенды

```bash
$ docker compose up -d # основной web, app, postgres
$ docker-compose -f vulnerable-app.yml up -d # поверх для vulnerable-web, debug-shell
    -f # file
    up # создает и поднимает файлы из compose
    -d # фоновый режим
```

- [ ] 4. Запустите скрипт из `venv` и проанализируйте то, что вывело на терминале и что вывело при конвертировании

```bash
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install openpyxl odfpy
$ ./audit.sh
$ deactivate # или $ deactivate 2>/dev/null || true
```
 
- [ ] 5. Проведите анализ уязвимостей, опишите их причину возникновения
- [ ] 6. Опишите влияния уязвимостей, их сценарий атаки
- [ ] 7. Оцените риски ИБ и предложите меры для их снижения: 
> - Следует разобрать `.yaml` описав, что в них считается не безопасным и почему
> - Опишите сценарии реализации рисков CR, DL
> - Предложите исправленные `.yaml`
- [ ] 8. Сделайте анализ уязвимостей из сгенерированных файлов .odt, .xlsx и опишите их в отчете. Файлы конвертируются в эти директории

```bash
"├── json/          (Trivy JSON outputs)"
"├── text/          (CIS audit text outputs)"
"├── xlsx/          (Excel spreadsheets)"
"└── odt/           (OpenDocument Text files)"
```

- [ ] 9. Подготовьте отчет `gist`.
- [ ] 10. Почистите кеш от `venv`, остановите уязвимое приложение и почистите контейнеры

```bash
$ rm -rf venv
$ docker-compose -f vulnerable-app.yml down
$ docker system prune -f
```
 
***

## Container Vulnerability Scanning (Trivy)

Помимо аудита конфигурации (CIS Benchmark), важно сканировать сами образы на известные CVE в OS-пакетах и языковых зависимостях.

- [ ] 11. Установите Trivy и просканируйте образы из `docker-compose.yml`

```bash
# установка (macOS)
$ brew install aquasecurity/trivy/trivy

# установка (Linux)
$ curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# сканирование образа из compose
$ trivy image --severity HIGH,CRITICAL <image_name>:<tag>

# JSON-отчёт для анализа
$ trivy image --format json --output audit_reports/json/trivy-report.json <image_name>:<tag>
```

- [ ] 12. Проанализируйте результаты Trivy: определите, из каких слоёв приходят уязвимости — из базового образа или из установленных зависимостей. Предложите меры снижения: обновление base image, пиннинг версий, multi-stage build
- [ ] 13. Сравните подходы: CIS Benchmark (конфигурация хоста) vs Trivy (CVE в образах). В каких ситуациях нужен каждый?

***

## Troubleshooting

- Права для исполнения скрипта

```bash
$ chmod +x xxx.sh # разрешение прав при permission denied
```

- На macOS/AArch64 docker-bench-security может не запускаться из‑за ограничений Docker Desktop и это работает для Linux‑VM. На Mac используем Trivy‑скан и разбор конфигурации compose‑файлов.

***

## Смотри также

- [Лаб. №5 — Docker](https://course.geminishkv.tech/labs/basic/lab05/) — основы Docker и контекст безопасности
- [Лаб. №7 — SAST/SCA](https://course.geminishkv.tech/labs/basic/lab07/) — статический анализ кода и зависимостей
- [CheatSheet: Dockerfile Security](https://course.geminishkv.tech/materials/cheatsheet/CHEATSHEET_DOCKERFILE_SECURITY/) — безопасная сборка образов
- [Установка AppSec-инструментов](https://course.geminishkv.tech/labs/intro/appsec_tools_setup/) — установка Trivy, Hadolint, Docker Bench

***

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://docs.docker.com/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.docker.com/engine/security/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker Engine security</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/docker/docker-bench-security" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker Bench for Security</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://www.cisecurity.org/benchmark/docker" target="_blank"><div class="lab-card-body"><div class="lab-card-title">CIS Docker Benchmark</div><div class="lab-card-tags"><span class="lab-tag">cisecurity.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://aquasecurity.github.io/trivy/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Trivy: Container Security Scanner</div><div class="lab-card-tags"><span class="lab-tag">aquasecurity.github.io</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gist.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Gist</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
