---
hide:
  - toc
title: "OWASP — Authorization: нарушения контроля доступа"
description: "OWASP Top 10: нарушения контроля доступа — эскалация привилегий, горизонтальный IDOR, RBAC и меры защиты."
keywords: "OWASP, авторизация, authorization, контроль доступа, AppSec, RBAC, привилегии, IDOR"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — Authorization</h1>
    <p class="hero-sub">Нарушения авторизации · OWASP Top 10</p>
  </div>
</div>

## О документе

Нарушения контроля доступа (Broken Access Control) — наиболее распространённая уязвимость по данным OWASP, занимающая первое место в OWASP Top 10 2021. Уязвимость возникает, когда пользователь может выполнять действия или получать доступ к ресурсам, выходящим за рамки его полномочий.

Основные классы нарушений: IDOR (Insecure Direct Object Reference) — прямой доступ к чужим ресурсам через предсказуемые идентификаторы, вертикальная эскалация привилегий — выполнение функций администратора от имени обычного пользователя, и обход ограничений путём манипуляции HTTP-методами или параметрами запроса.

Материал применяется в [лабораторной работе №8 (DAST с OWASP ZAP)](../../labs/lab08.md) при анализе контроля доступа в уязвимом приложении. Связанные материалы: [Authentication](Authentication.md), [аналитические кейсы ИБ](../examples/exmpl.md), [классификация AppSec-инструментов](../../appsec_tt.md).

## OWASP материалы

![OWASP Top 10 - Authorization](../../artifacts/owasp/Authorization.pdf){ type=application/pdf style="min-height:80vh;width:100%" }
