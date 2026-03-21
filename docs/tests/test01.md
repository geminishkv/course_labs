---
title: Тест №1
description: Тестовое задание №1 по курсу AppSec — 10 вопросов по Git, Linux, Nmap, Docker, SAST и анализу рисков.
---

<!-- markdownlint-disable MD013 -->
<div align="center">
<h1><a id="intro">Тест №1</a><br></h1>
<img src="https://img.shields.io/badge/Course-Risk_Analysis-2448a2" alt="RA">
<img src="https://img.shields.io/badge/AppSec-2448a2" alt="AppSec">
<img src="https://img.shields.io/badge/Вопросов-10-d4a520" alt="10 questions">
<img src="https://img.shields.io/badge/Темы-Git_·_Linux_·_Nmap_·_Docker_·_SAST_·_Риски-cc2200" alt="Topics">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff" alt="Contributor Badge">
</div>
<!-- markdownlint-enable MD013 -->

***

!!! info "Инструкция"
    Выберите **один** правильный ответ на каждый вопрос. Ответы — в файле **Ответы**.

***

**1.** Какому файлу конфигурации Git соответствует уровень `--global`?

- A) `.git/config`
- B) `/etc/gitconfig`
- C) `~/.gitconfig`
- D) `~/.git/global`

***

**2.** Что означают права `chmod 755` на файл?

- A) Владелец: чтение/запись; группа и остальные: только чтение
- B) Все пользователи имеют полные права (rwxrwxrwx)
- C) Владелец: все права; группа: чтение+выполнение; остальные: чтение+выполнение
- D) Только владелец имеет права на файл

***

**3.** Как называется тип сканирования Nmap, отправляющий SYN-пакеты без завершения TCP-рукопожатия?

- A) TCP Connect (`-sT`)
- B) UDP scan (`-sU`)
- C) NULL scan (`-sN`)
- D) TCP SYN/Stealth scan (`-sS`)

***

**4.** В чём принципиальное отличие Docker-образа от Docker-контейнера?

- A) Образ — запущенная среда, контейнер — статический шаблон
- B) Образ — статический шаблон; контейнер — запущенный экземпляр образа
- C) Образ и контейнер — одно и то же понятие
- D) Контейнер существует только во время сборки образа

***

**5.** В чём ключевое отличие SAST от DAST?

- A) SAST анализирует только зависимости, DAST — только конфигурации
- B) SAST анализирует исходный код без запуска; DAST тестирует работающее приложение
- C) SAST и DAST — разные названия одного подхода
- D) DAST требует доступа к исходному коду, SAST — нет

***

**6.** Как называется уязвимость, при которой вредоносный скрипт выполняется в браузере жертвы через отражённые входные данные?

- A) SQL Injection
- B) CSRF
- C) Path Traversal
- D) Reflected XSS

***

**7.** Какой регламент ЕС регулирует обработку персональных данных граждан Евросоюза?

- A) SOX (Sarbanes-Oxley Act)
- B) PCI DSS
- C) GDPR (General Data Protection Regulation)
- D) HIPAA

***

**8.** Какой инструмент реализует автоматическую проверку конфигурации Docker согласно CIS Benchmark?

- A) Nmap
- B) Docker Bench Security
- C) Semgrep
- D) OWASP ZAP

***

**9.** Что означает стратегия управления риском **Risk Acceptance**?

- A) Риск полностью устранён техническими мерами
- B) Ответственность за риск передана страховой компании
- C) Организация осознанно решает не принимать защитные меры
- D) Риск признан недопустимым и требует немедленного устранения

***

**10.** Какой флаг команды `git commit` используется для GPG-подписи коммита?

- A) `--signed`
- B) `--gpg`
- C) `-v`
- D) `-S`

***

![Logo](../artifacts/assets/logotypemd.jpg)
