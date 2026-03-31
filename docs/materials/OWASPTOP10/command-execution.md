---
hide:
  - toc
title: "OWASP — Command Execution: инъекции и RCE"
description: "OWASP Top 10: выполнение произвольных команд — SQL injection, OS injection, SSTI, XXE и методы защиты."
keywords: "OWASP, SQL injection, OS injection, SSTI, XXE, AppSec, RCE, инъекции, уязвимости"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — Command Execution</h1>
    <p class="hero-sub">Уязвимости выполнения команд · OWASP Top 10</p>
  </div>
</div>

## О документе

Уязвимости выполнения команд — класс инъекционных атак, при которых неочищенные пользовательские данные передаются интерпретатору (SQL, OS shell, шаблонизатор). SQL Injection позволяет читать и модифицировать базу данных или выполнять произвольные команды ОС через функции вроде `xp_cmdshell`. OS Command Injection — прямое выполнение системных команд через `system()`, `exec()` и аналоги.

SSTI (Server-Side Template Injection) возникает при подстановке пользовательских данных непосредственно в шаблонный движок (Jinja2, Twig, Freemarker) и зачастую приводит к Remote Code Execution (RCE). XXE (XML External Entity) — эксплуатация XML-парсеров для чтения произвольных файлов системы или SSRF.

Данный класс уязвимостей обнаруживается инструментами SAST в [лабораторной работе №7](../../labs/lab07.md) и DAST в [лабораторной работе №8](../../labs/lab08.md). Смотри также: [классификация SAST/DAST инструментов](../../appsec_tt.md).

## OWASP материалы

![OWASP Top 10 - Command_Execution](../../artifacts/owasp/Command_Execution.pdf){ type=application/pdf style="min-height:80vh;width:100%" }
