# Release Notes

## v2.1.0

**Контент и материалы:**

* Введение в сети и TCP/IP — модель OSI/TCP-IP, IP-адреса, порты, TCP vs UDP, DNS, HTTP
* Основы Docker и контейнеризации — VM vs Container, образы, Dockerfile, базовые команды, Docker Compose
* Введение в CI/CD и GitHub Actions — концепция CI/CD, структура workflow, триггеры, секреты, пример DevSecOps пайплайна
* Lab 04 — добавлена секция «Материал»: ключевые понятия рисков, стратегии обработки, compliance-контекст
* Lab 05 — установка Docker для Linux (не только brew), аудит Dockerfile по security-чеклисту, `.dockerignore`, `docker history`, `whoami`, ресурсные лимиты, Docker-сети, namespaces изнутри контейнера
* Lab 06 — убран дублированный контент из Lab 05, добавлены уровни CIS Benchmark (Level 1/2) и 6 категорий проверок
* Lab 07 — сравнение 6 инструментов (Semgrep/Bandit/Checkov/OWASP DC/Gitleaks/TruffleHog), установка Maven/JDK, структура анализа Semgrep/Checkov, сравнительная таблица SAST vs SCA, задание на false positives, кастомное Semgrep-правило, Secret Detection перенесён перед cleanup
* Lab 08 — исправлена сломанная команда `pip install`, добавлена curl-эксплуатация из терминала, анализ HTTP security headers, повторное сканирование ZAP после исправлений, сравнение ручных vs автоматических находок
* Lab 09 — исправлены HTML entities `&#123;` на `{% raw %}`, добавлены hints к блокам «доработайте необходимое» (Checkov, DC, Trivy)
* Lab 10 — добавлена секция «Материал» (методология из 5 шагов, структура аналитической записки, инструментарий AppSec), переформулированы задания из контекста в конкретные deliverables, добавлена секция Links
* Все лабы 04–10: добавлена секция «Смотри также» с перекрёстными ссылками
* Созданы docs-обёртки для 5 базовых тестов (lab-hero стилизация)
* Созданы 2 варианта теста по лекции «Fintech по-русски» — кейсовые вопросы с привязкой к 115-ФЗ, PCI DSS, ГОСТ 57580, CWE
* 7 Mermaid-диаграмм: TCP handshake, CI/CD pipeline, DevSecOps DAG, Docker lifecycle, Docker layers, VM vs Container, Risk chain
* Troubleshooting -Добавлены 4 секции (14 карточек): Сети и TCP/IP, Docker Compose/Dockerfile, GitHub Actions YAML, CMS Security
* CSP: добавлены mc.yandex.ru (Метрика), cdn.jsdelivr.net (twemoji), telegram.org (виджет)

---

## v2.0.0

**Дизайн и UI/UX:**

* Полная переработка дизайн-системы: создан `tokens.css` с CSS custom properties (цвета, типографика, spacing, радиусы, transitions)
* Устранен render-blocking
* Переработан адаптив: hero-section, lab-cards, TG-виджет, sidebar, таблицы
* TG-виджет: на мобилке скрыт embed, оставлена компактная карточка канала
* Переработана 404-страница: бренд-шрифты (Unbounded + Roboto), SVG-логотип как фон, адаптив через `clamp()`
* Добавлен repo-stats.js: звёзды, форки и версия релиза в хедере через GitHub API с кэшированием в localStorage
* Оптимизация CSS
* Добавлена анимация логотипа в hero banner

**Контент и материалы:**

* Страница лицензий (`licenses.md`): 19 → 41 лицензия, разделение по 7 категориям (Permissive, Weak/Strong Copyleft, Network Copyleft, Public Domain, Creative Commons, Source-Available)
* Страница AppSec Toolchain (`appsec_tt.md`): 22 → 29 карточек, разделение по 8 секциям (добавлены MAST, API Security, Fuzzing, IaC Security, KSPM, VDP, WAF, LLM Security)
* Приложение (`APPENDIX.md`): 8 → 16 карточек с контекстом для слушателей (Nmap, SAST, SCA, DAST, CIS Benchmark, Secret Detection, GitHub Actions, Risk Analysis)
* Создана страница Troubleshooting: ~20 карточек с решениями по Git, Linux, Docker, SAST/SCA, DAST, CI/CD, Python
* Создан YAML Cheatsheet: синтаксис, типы данных, многострочные строки, якоря, подводные камни, примеры для GitHub Actions/Docker Compose/Semgrep

---

## v1.5.0

**Доработанные материалы:**

* Добавлено описание и Mermaid-карта лабораторных работ в README.md
* Добавлена информация по pet_project и lab09 в README.md и docs/index.md
* Актуализированы конфиги линтеров и инструментов сборки: `.gitattributes`, `.gitignore`, `.dockerignore`, `ruff.toml`, `mypy.ini`, `.markdownlint.yaml`
* Полностью переписан `.dockerignore`
* Устранён баг сборки MkDocs: удалена несуществующая страница `Metro4Shell.md` из навигации `mkdocs.yml`
* Выровнены отступы в sidebar: переработаны стили `sidebar.css`
* Обновлены shields на главной странице сайта: добавлены бейджи инструментов безопасности (Semgrep, Checkov, Trivy, OWASP ZAP, Nmap) и GitHub-метрики
* Добавлены тестовые задания по лабораторным работам
* Прочие доработки

**Материалы, которые будут доработаны позже:**

* CI to shellchecks
* minor bugs

---

## v1.4.0

**Доработанные материалы:**

* Описан site_description
* Исправлены неучтенные материалы, поправлены пути для файлов и запросов
* Изменены shields и кастомизированы под лабораторные работы и их содержание
* Скорректированы линки для shields
* Переработана структура репозитория и изменены пути для лабораторных работ, дополнительных материалов и примеров кейсов ИБ
* Подготовлены мета данные для поисковых запросов, оптимизации этих запросов, а также конфиги .yml
* Добавлен job для сборки и проверки генерации sitemap.xml
* Подготовлен скрипт для генерации sitemap.xml
* Оптимизирован robots.txt
* Оптимизированы отладчики для lint и шаги сборок
* Доработан и оптимизирован UI/UX
* Доработан mkdocs.yml
* Доработан stylesheet и layout:
    * Исправлены поисковые запросы по сайту
    * Доработаны и изменены icon
    * Доработаны стили для sidebar, search, burger
    * Доработан функционал для clipboard
    * Поправлены features для корректной генерации markdown страниц сайта
    * Доработаны стили для читаемости отображаемого кода и его корректного clipboard

**Материалы, которые будут доработаны позже:**

* lab09
* pet_project
* CI to shellchecks
* minor bugs

---

## v1.3.0

* fix release-from-notes.yml and ci.yml
* Выстроена логика работы для сайта, таблицы инструментов и ее фильтрации
* Построены конфиги и подготовлен полноценный релиз
* Изменено: подход и цветовая палитра, форматирование и т.д.
* Первый публичный черновой релиз
* Подготовлены репозитории и окружения для Лабораторных работ №1 - 8, 10:
* Подготовлен единый стиль кода
* Все функции в пространстве имен
* Используются скрипты для автоматизации сборки проекта, примеров, тестов, пакетирования
* Обеспечен непрерывный процесс сборки проекта GitHub Actions
* Обеспечено размещение пакета проекта GitHub Release
* Проведен полный рефакторинг проекта, изменена структура репозитория, дублированы материалы для сайта и изменена стилистика
* Проект реализован на MkDocs Material
