---
hide:
  - toc
title: "OWASP Authentication — нарушения аутентификации и защита сессий"
description: "OWASP Top 10 аутентификация: слабые пароли, отсутствие MFA, перехват сессий — уязвимости и методы защиты веб-приложений."
keywords: "OWASP, аутентификация, authentication, AppSec, MFA, безопасность, сессии, пароли, brute force, broken authentication, веб-безопасность"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — Authentication</h1>
    <p class="hero-sub">Нарушения аутентификации · OWASP Top 10</p>
  </div>
</div>

## О документе

Нарушения аутентификации (Broken Authentication) входят в OWASP Top 10 и возникают, когда приложение некорректно реализует механизмы проверки личности пользователя. Типичные проблемы: использование слабых или предсказуемых паролей, отсутствие многофакторной аутентификации (MFA), небезопасное хранение учётных данных и уязвимости механизма восстановления пароля.

Атакующий, эксплуатирующий данную уязвимость, получает доступ к аккаунтам легитимных пользователей или административным интерфейсам. Особенно опасны атаки credential stuffing, brute-force и session fixation, когда отсутствует ограничение количества попыток входа или ротация идентификатора сессии после аутентификации.

Данный материал связан с [лабораторной работой №8 (DAST)](../../labs/basic/lab08.md), где OWASP ZAP проверяет реализацию аутентификации в тестовом приложении, а также с [лабораторной работой №9](../../labs/basic/lab09.md), где проверки встраиваются в CI/CD. Смотри также: [Authorization](Authorization.md).

## OWASP материалы

![OWASP Top 10 - Authentication](../../artifacts/owasp/Authentication.pdf){ type=application/pdf style="min-height:80vh;width:100%" }
