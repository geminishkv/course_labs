---
title: "CheatSheet: HTTP Security Headers | Курс AppSec"
description: "HTTP Security Headers: CSP, HSTS, X-Frame-Options, X-Content-Type-Options — настройка для nginx и Express с примерами."
keywords: "HTTP headers, CSP, HSTS, X-Frame-Options, CORS, security headers, nginx, Express, AppSec, веб-безопасность"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">HTTP Security Headers</h1>
    <p class="hero-sub">Чеклист заголовков безопасности для веб-приложений</p>
  </div>
</div>

## Обязательные заголовки

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">HSTS</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Strict-Transport-Security</span>
    </div>
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">CRITICAL</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Принуждает браузер использовать только HTTPS. Без этого заголовка возможна атака SSL stripping.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CSP</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Content-Security-Policy</span>
    </div>
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">CRITICAL</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Контролирует откуда загружаются ресурсы (скрипты, стили, изображения). Основная защита от XSS.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">X-Frame</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">X-Frame-Options + frame-ancestors</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Защита от clickjacking. <code>DENY</code> или <code>SAMEORIGIN</code>. CSP <code>frame-ancestors</code> — современная замена.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">X-Content</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">X-Content-Type-Options</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>nosniff</code> — запрещает MIME-sniffing. Без него браузер может интерпретировать файл как скрипт.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Referrer</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Referrer-Policy</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Контролирует утечку URL при переходах. <code>strict-origin-when-cross-origin</code> — оптимальный баланс.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Permissions</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Permissions-Policy</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Ограничивает доступ к API браузера: камера, микрофон, геолокация, payment. Замена Feature-Policy.</p>
  </div>

</div>

***

## Настройка nginx

```nginx
server {
    listen 443 ssl http2;

    # HSTS — 1 год, includeSubDomains, preload
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

    # CSP — базовый набор
    add_header Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self'; frame-ancestors 'none'; base-uri 'self'; form-action 'self'" always;

    # Clickjacking
    add_header X-Frame-Options "DENY" always;

    # MIME-sniffing
    add_header X-Content-Type-Options "nosniff" always;

    # Referrer
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    # Permissions
    add_header Permissions-Policy "camera=(), microphone=(), geolocation=(), payment=()" always;

    # Скрыть версию сервера
    server_tokens off;
}
```

***

## Настройка Express (Node.js)

=== "С helmet (рекомендуется)"

    ```javascript
    import helmet from "helmet";

    app.use(helmet({
      contentSecurityPolicy: {
        directives: {
          defaultSrc: ["'self'"],
          scriptSrc: ["'self'"],
          styleSrc: ["'self'", "'unsafe-inline'"],
          imgSrc: ["'self'", "data:"],
          frameAncestors: ["'none'"],
        },
      },
      hsts: { maxAge: 31536000, includeSubDomains: true, preload: true },
      referrerPolicy: { policy: "strict-origin-when-cross-origin" },
    }));
    ```

=== "Вручную"

    ```javascript
    app.use((req, res, next) => {
      res.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains; preload");
      res.setHeader("Content-Security-Policy", "default-src 'self'; frame-ancestors 'none'");
      res.setHeader("X-Frame-Options", "DENY");
      res.setHeader("X-Content-Type-Options", "nosniff");
      res.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
      res.setHeader("Permissions-Policy", "camera=(), microphone=(), geolocation=()");
      next();
    });
    ```

***

## Cookie-атрибуты безопасности

```
Set-Cookie: session=abc123; Secure; HttpOnly; SameSite=Strict; Path=/; Max-Age=3600
```

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Secure</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Только по HTTPS. Без него cookie утекает при HTTP downgrade.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">HttpOnly</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Недоступна из JavaScript. Без него XSS крадёт cookie через <code>document.cookie</code>.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SameSite</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>Strict</code> — не отправляется при cross-site запросах. Защита от CSRF.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Path</span>
    </div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;"><code>/</code> — ограничивает scope cookie конкретным путём.</p>
  </div>

</div>

***

## Проверка заголовков

```bash
# curl — быстрая проверка
curl -sI https://example.com | grep -iE "strict|content-security|x-frame|x-content|referrer|permissions"

# Nmap NSE
nmap --script http-headers -p 443 example.com

# OWASP ZAP — автоматически проверяет заголовки при baseline scan
docker run -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://example.com
```

!!! info "Онлайн-сервисы"

    - [securityheaders.com](https://securityheaders.com) — быстрая оценка A-F
    - [observatory.mozilla.org](https://observatory.mozilla.org) — детальный аудит от Mozilla
