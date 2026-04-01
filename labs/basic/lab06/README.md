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

- **Docker Bench Security** - официальным инструментом аудита безопасности от Docker, который проверяет наличие практик при развертывания на `CIS Docker Benchmark`

- Реальный аудит контейнерной безопасности выполняется на Linux‑хосте / WSL2 с нативным Docker Engine», что соответствует методике CIS и практике промышленного Docker hardening

- **Рассматриваемые вопросы безопасности**
    - Привилегированные контейнеры
    - Захардкоженные данные учеток
    - Отключенные профили безопасности (AppArmor, Seccomp)
    - Прямое монтирования файловой системы
    - Устаревшие образы и явный запуск сервисов от привилегированного пользователя
    - Дополнительные сервисы, лишние утилиты
    - Расширенные volume‑маунты
    - env и SQL‑инициализации
    - Примеры анти‑паттернов privileged, host‑network, docker.sock, secrets-in-env, outdated images

-  **Контекст безопасности**

    - Не задавать пользователей с правами «root» для работы сервисов внутри контейнеров. 
    - Не запускать контейнеры в привилегированном режиме. 
    - Не отключать профили безопасности Docker. 
    - Не допускать запуск контейнеров, использующих тип сети «host»
    - Не разрешать доступ к docker.socket изнутри контейнера. Не подключать docker socket в контейнер без необходимости, либо с использованием плагинов авторизации. 
    - Не использовать секреты в открытом виде в Docker-файлах образов. По возможности не использовать переменные окружения и не хранить секреты внутри контейнера. Хранение и управление секретами возложить на сторонний сервис.
    - Ограничивать и контролировать использование ресурсов контейнерами. Указывать ограничения на уровне самого ПО или на уровне контейнеров для использования ресурсов хоста.
    - Контролировать качество базовых образов контейнеров. Использовать официальные образы и использовать образы с минимально необходимым набором инструментов.
    - Сканировать образы на наличие уязвимостей и проверки требований ИБ (Compliance Checks)
    - Сбрасывание capabilities уменьшает поверхность атаки
    - Файловые системы только для чтения предотвращают фальсификацию
    - Пространства имен пользователя улучшает изоляцию

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

- [ ] 2. Проверьте работу докера и сделать скрипт `audit.sh` исполняемым
- [ ] 3. Развернуть уязвимое приложение как отдельные стенды

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
> - Предложили исправленные `.yaml`
- [ ] 8. Сделайте анализ уязвимостей из сгенерированных файлов .odt, .xlsx и опишите их в отчете. Файлы конвертируются в эти директории

```bash
"├── json/          (Trivy JSON outputs)"
"├── text/          (CIS audit text outputs)"
"├── xlsx/          (Excel spreadsheets)"
"└── odt/           (OpenDocument Text files)"
```

- [ ] 9. Подготовьте отчет `gist`.
- [ ] 10. Почистите кеш от `venv` и остановите уязвимостей приложение, почистите контейнера

```bash
$ rm -rf venv
$ docker-compose -f demo-vulnerable-app.yml down
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

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://docs.docker.com/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.docker.com/engine/security/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker Engine security</div><div class="lab-card-tags"><span class="lab-tag">docs.docker.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/docker/docker-bench-security" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Docker Bench for Security</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://www.cisecurity.org/benchmark/docker" target="_blank"><div class="lab-card-body"><div class="lab-card-title">CIS Docker Benchmark</div><div class="lab-card-tags"><span class="lab-tag">cisecurity.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://aquasecurity.github.io/trivy/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Trivy: Container Security Scanner</div><div class="lab-card-tags"><span class="lab-tag">aquasecurity.github.io</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://stackedit.io" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Markdown</div><div class="lab-card-tags"><span class="lab-tag">stackedit.io</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gist.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Gist</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://docs.github.com/en" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub Docs</div><div class="lab-card-tags"><span class="lab-tag">docs.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
