---
hide:
  - toc
title: "OWASP — Information Disclosure: раскрытие данных"
description: "OWASP Top 10: раскрытие конфиденциальных данных — утечки, чувствительные заголовки, логи и меры защиты."
keywords: "OWASP, утечка данных, information disclosure, AppSec, конфиденциальность, заголовки"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — Information Disclosure</h1>
    <p class="hero-sub">Раскрытие конфиденциальных данных · OWASP Top 10</p>
  </div>
</div>

## О документе

Раскрытие конфиденциальных данных происходит, когда приложение непреднамеренно предоставляет чувствительную информацию: стектрейсы с внутренними путями файловой системы, версии используемых компонентов в HTTP-заголовках, незащищённые эндпоинты с отладочной информацией или исходный код через неправильно настроенный веб-сервер.

Чувствительные заголовки (`Server`, `X-Powered-By`, `X-AspNet-Version`) дают атакующему информацию о стеке технологий и упрощают выбор эксплойтов. Утечки через verbose error messages и подробные сообщения об ошибках валидации (например, «пользователь не существует» vs «неверный пароль») позволяют перечислять пользователей (user enumeration).

Выявляется инструментами DAST в [лабораторной работе №8](../../labs/basic/lab08.md) и статическим анализом в [лабораторной работе №7](../../labs/basic/lab07.md). Смотри также: [Authentication](Authentication.md), [Logical Attacks](logical-attacks.md).

## OWASP материалы

![OWASP Top 10 - Information_Disclosure](../../artifacts/owasp/Information_Disclosure.pdf){ type=application/pdf style="min-height:80vh;width:100%" }
