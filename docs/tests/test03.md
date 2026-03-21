---
title: Тест №3
description: Тестовое задание №3 по курсу AppSec — 10 вопросов по Git, Linux, Nmap, Docker, DAST и анализу рисков.
---

<!-- markdownlint-disable MD013 -->
<div align="center">
<h1><a id="intro">Тест №3</a><br></h1>
<img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt="RA">
<img src="https://img.shields.io/badge/AppSec-2448a2" alt="AppSec">
<img src="https://img.shields.io/badge/Вопросов-10-d4a520" alt="10 questions">
<img src="https://img.shields.io/badge/Темы-Git_·_Linux_·_Nmap_·_Docker_·_DAST_·_Риски-cc2200" alt="Topics">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge">
</div>
<!-- markdownlint-enable MD013 -->

***

!!! info "Инструкция"
    Выберите **один** правильный ответ на каждый вопрос. Ответы — в файле **Ответы**.

***

**1.** Как убрать файл из отслеживания Git, **сохранив** его на диске?

- A) `git delete <file>`
- B) `git rm <file>`
- C) `git rm --cached <file>`
- D) `git untrack <file>`

***

**2.** Какой сигнал отправляет команда `kill -9 <PID>`?

- A) SIGTERM — запрос на корректное завершение
- B) SIGHUP — перечитать конфигурацию
- C) SIGKILL — принудительное немедленное завершение
- D) SIGSTOP — приостановка процесса

***

**3.** Какая опция Nmap сохраняет результаты сканирования в XML-формат?

- A) `nmap -oN report.xml target`
- B) `nmap --xml report.xml target`
- C) `nmap -oX report.xml target`
- D) `nmap --output xml=report.xml target`

***

**4.** Какой механизм Linux используется в Docker для управления ресурсами (CPU, RAM) контейнера?

- A) Namespaces
- B) AppArmor
- C) SELinux
- D) cgroups

***

**5.** Какой инструмент рекомендуется для сканирования Docker-образов на CVE-уязвимости, особенно на macOS?

- A) OWASP ZAP
- B) OWASP Dependency-Check
- C) Trivy
- D) Burp Suite

***

**6.** На какой тип файлов в первую очередь направлен инструмент Checkov?

- A) Исходный код Python и JavaScript
- B) Infrastructure as Code (Terraform, Dockerfile, Kubernetes YAML)
- C) Конфигурации сетевых маршрутизаторов
- D) Журналы веб-серверов

***

**7.** Что обеспечивает атрибут `HttpOnly` у cookie?

- A) Делает cookie доступным только через HTTPS-соединение
- B) Запрещает доступ к cookie через JavaScript, защищая от XSS-кражи
- C) Ограничивает время жизни cookie одним сеансом браузера
- D) Шифрует содержимое cookie на клиентской стороне

***

**8.** Что такое Threat Modeling (моделирование угроз)?

- A) Сканирование приложения на уязвимости в runtime
- B) Анализ возможных угроз и векторов атак на этапе проектирования системы
- C) Автоматический поиск вредоносного кода в репозитории
- D) Тестирование на проникновение производственной системы

***

**9.** Какой флаг команды `docker run` автоматически удаляет контейнер после его остановки?

- A) `--delete`
- B) `--clean`
- C) `--auto-remove`
- D) `--rm`

***

**10.** Какой подход к управлению риском предполагает передачу ответственности третьей стороне?

- A) Risk Avoidance (уклонение от риска)
- B) Risk Mitigation (снижение риска)
- C) Risk Transfer (передача риска)
- D) Risk Acceptance (принятие риска)

***

![Logo](../artifacts/assets/logotypemd.jpg)
