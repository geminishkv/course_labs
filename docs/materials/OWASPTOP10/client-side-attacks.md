---
hide:
  - toc
title: "OWASP — Client-side Attacks: XSS, CSRF, Clickjacking"
description: "OWASP Top 10: клиентские атаки — XSS, CSRF, Clickjacking, DOM-уязвимости и методы защиты веб-приложений."
keywords: "OWASP, XSS, CSRF, Clickjacking, клиентские атаки, AppSec, веб-безопасность, DOM"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — Client-side Attacks</h1>
    <p class="hero-sub">Атаки на стороне клиента · OWASP Top 10</p>
  </div>
</div>

## О документе

Клиентские атаки направлены против браузера и пользовательского окружения, а не против серверной части приложения. Наиболее распространённые типы: XSS (Cross-Site Scripting) — внедрение вредоносного JavaScript в страницу, CSRF (Cross-Site Request Forgery) — выполнение нежелательных действий от имени аутентифицированного пользователя, и Clickjacking — перехват кликов через прозрачные iframe-оверлеи.

DOM-based XSS особенно опасен, поскольку вредоносный код исполняется без обращения к серверу и не фиксируется в серверных логах. Эффективные меры защиты: Content Security Policy (CSP), заголовок `X-Frame-Options`, SameSite cookie-атрибуты и валидация всех пользовательских данных на стороне клиента.

Данные уязвимости проверяются в [лабораторной работе №8 (DAST)](../../labs/basic/lab08.md) с помощью OWASP ZAP. Смотри также: [Command Execution](command-execution.md), [Information Disclosure](information-disclosure.md).

## OWASP материалы

![OWASP Top 10 - Client-side Attacks](../../artifacts/owasp/Client-side_Attacks.pdf){ type=application/pdf style="min-height:80vh;width:100%" }
