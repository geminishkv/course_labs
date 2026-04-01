---
hide:
  - toc
title: "OWASP Top 10 — CI/CD Risks"
description: "Топ-10 рисков безопасности CI/CD конвейеров по OWASP: компрометация SCM, ненадёжные зависимости, небезопасные секреты."
keywords: "OWASP, CI/CD, DevSecOps, риски, GitHub Actions, pipeline, секреты, AppSec"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — CI/CD Risks</h1>
    <p class="hero-sub">Риски безопасности конвейеров поставки</p>
  </div>
</div>

## О документе

OWASP Top 10 CI/CD Security Risks — методология оценки рисков безопасности в конвейерах непрерывной интеграции и доставки. Документ описывает десять наиболее критичных векторов атак, которые возникают при ненадлежащей конфигурации SCM-систем, некорректном управлении секретами и ненадёжных зависимостях сборочного процесса.

Ключевые риски охватывают компрометацию цепочки поставки (CI0CS-1), недостаточный контроль идентичности (CI0CS-2), небезопасное управление секретами (CI0CS-4) и использование ненадёжных сторонних плагинов (CI0CS-6). Каждый риск сопровождается описанием вектора атаки, примерами реальных инцидентов и рекомендациями по снижению.

На практике риски CI/CD напрямую затрагивают лабораторную работу [Лаб. №9 — DevSecOps CI/CD конвейер](../../labs/basic/lab09.md), где студенты строят собственный безопасный пайплайн с Semgrep, Trivy и OWASP ZAP. Смотри также: [классификацию AppSec-инструментов](../../appsec_tt.md) и [читшит по GitHub CLI](../../artifacts/cheatsheet/CHEATSHEET_GH_CLI.md).

## OWASP материалы

![OWASP Top 10 - OWASP_Top_10_CICD_Risks](../../artifacts/owasp/OWASP_Top_10_CICD_Risks.pdf){ type=application/pdf style="min-height:80vh;width:100%" }
