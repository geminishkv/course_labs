---
title: Аббревиатурное описание AppSec инструментов
description: Расшифровка аббревиатур AppSec инструментов — класс, область применения для SAST, DAST, SCA, SBOM, IAST.
keywords: "AppSec, DevSecOps, SAST, DAST, SCA, SBOM, IAST, RASP, MAST, инструменты, аббревиатуры"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Application Security Toolchain</h1>
    <p class="hero-sub">Аббревиатуры и классы инструментов AppSec / DevSecOps</p>
  </div>
</div>

## Анализ кода (Code Analysis)

Инструменты, работающие с исходным кодом и байткодом — до запуска приложения. Встраиваются в IDE, pre-commit hooks и ранние стадии CI/CD.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SAST</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Static Application Security Testing</span>
    </div>
    <span class="lab-tag">Static AST</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Статический анализ исходного кода без запуска приложения. Обнаруживает инъекции, XSS, hardcoded secrets, небезопасные вызовы. Высокий false positive rate — требует тюнинга правил.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Semgrep · Checkov · Bandit · SonarQube</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SCS</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Secure Code Standards</span>
    </div>
    <span class="lab-tag">Secure Coding</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Правила и практики безопасной разработки: OWASP Secure Coding Practices, CERT, CWE Top 25. Ложатся в основу профилей SAST и code review.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">OWASP · CERT · CWE</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SCM</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Source Code Management</span>
    </div>
    <span class="lab-tag">Source Control</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Управление версиями исходного кода. Базовая точка интеграции AppSec: pre-commit hooks, PR-checks, секрет-сканеры, branch protection.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Git · GitHub · GitLab · Bitbucket</span>
  </div>

</div>

---

## Тестирование приложений (Application Testing)

Инструменты, работающие с запущенным приложением — от «чёрного ящика» до агентного анализа внутри процесса.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DAST</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Dynamic Application Security Testing</span>
    </div>
    <span class="lab-tag">Dynamic AST</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Тестирование «чёрным ящиком»: имитирует реальные атаки на запущенное приложение. Находит то, что SAST не видит: IDOR, broken auth, misconfigured CORS.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">OWASP ZAP · Burp Suite · Nuclei</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">IAST</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Interactive Application Security Testing</span>
    </div>
    <span class="lab-tag">Interactive AST</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Агент внутри приложения отслеживает реальные потоки данных и вызовы. Комбинирует SAST и DAST, значительно снижает false positive rate.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Contrast Security · Hdiv · Seeker</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">MAST</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Mobile Application Security Testing</span>
    </div>
    <span class="lab-tag">Mobile AST</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Анализ мобильных приложений: реверс APK/IPA, проверка хранения данных, сетевых вызовов, криптографии, jailbreak/root detection.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">MobSF · QARK · Objection</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">RASP</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Runtime Application Self-Protection</span>
    </div>
    <span class="lab-tag">Runtime Protection</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Самозащита приложения в рантайме: перехватывает SQL-инъекции, path traversal, command injection внутри процесса и блокирует атаки в реальном времени.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Sqreen · OpenRASP · Contrast Protect</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">API Security</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">API Security Testing</span>
    </div>
    <span class="lab-tag">API AST</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Специализированное тестирование API: BOLA, broken auth, mass assignment, rate limiting. Работает с OpenAPI/Swagger спецификациями.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">OWASP API Top 10 · Postman · 42Crunch</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">Fuzzing</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Fuzz Testing</span>
    </div>
    <span class="lab-tag">Fuzzing / Fault Injection</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Автоматическая генерация случайных или мутированных входных данных для обнаружения crash, memory corruption, assertion failures.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">AFL++ · libFuzzer · Atheris · OSS-Fuzz</span>
  </div>

</div>

---

## Анализ зависимостей и цепочки поставок (Supply Chain)

Проверка сторонних компонентов, лицензий и формирование инвентаря ПО — ключевая часть управления рисками supply chain.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SCA</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Software Composition Analysis</span>
    </div>
    <span class="lab-tag">SCA / OSA</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Анализ зависимостей на CVE, проблемы лицензирования и риски цепочки поставок. Основа для управления third-party рисками.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Trivy · OWASP DC · Snyk · pip-audit</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">OSA</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Open Source Analysis</span>
    </div>
    <span class="lab-tag">SCA / OSA</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Фокус на OSS-компонентах: безопасность, качество сопровождения (maintainer activity), совместимость лицензий, соответствие внутренней OSS-политике.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Scorecard · deps.dev · Socket</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SBOM</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Software Bill of Materials</span>
    </div>
    <span class="lab-tag">SBOM / Inventory</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Структурированный перечень всех компонентов продукта (CycloneDX, SPDX). Регуляторное требование: EO 14028 (US), NIS2 (EU).</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Syft · cdxgen · SPDX Tools</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">License Policy</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">License / Governance</span>
    </div>
    <span class="lab-tag">Governance</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Политики лицензионного комплаенса: запрет AGPL в SaaS, проверка совместимости GPL + proprietary, автоматизация в CI.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">FOSSA · Snyk License · ScanCode</span>
  </div>

</div>

---

## Контейнеры и инфраструктура (Container & Infra Security)

Безопасность контейнерных образов, Docker-хостов, IaC-конфигураций и сетевой инфраструктуры.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CIS</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Container Image Scanner</span>
    </div>
    <span class="lab-tag">Container Security</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Сканирование образов на CVE (OS-пакеты + языковые зависимости), утечки секретов, root-пользователь, лишние capabilities.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Trivy · Grype · Docker Scout · Dockle</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">BCA</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Bytecode and Container Analysis</span>
    </div>
    <span class="lab-tag">Binary / Container</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Анализ бинарного кода и контейнерных слоёв: вредоносный контент, плохие практики упаковки, встроенные бэкдоры в base images.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Dive · Anchore · Clair</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">IaC Security</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Infrastructure as Code Security</span>
    </div>
    <span class="lab-tag">IaC Scanning</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Проверка Terraform, CloudFormation, Kubernetes YAML, Dockerfiles на мисконфигурации ещё до деплоя: открытые порты, публичные S3, отсутствие шифрования.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Checkov · tfsec · KICS · Hadolint</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">NVS</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Network Vulnerability Scanner</span>
    </div>
    <span class="lab-tag">Infra / Network</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Сканирование хостов и сервисов: открытые порты, уязвимые версии, небезопасные конфигурации на уровне сети (L3/L4).</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Nmap · Nessus · OpenVAS · Qualys</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SM</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Secret Management</span>
    </div>
    <span class="lab-tag">Secret Management</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Хранение, ротация и выдача секретов (токены, ключи, сертификаты). Интеграция с CI/CD: секреты не хранятся в коде, не хардкодятся в конфигах.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Vault · AWS SM · Gitleaks · TruffleHog</span>
  </div>

</div>

---

## Облачная безопасность (Cloud Security)

Управление безопасностью облачных конфигураций, рабочих нагрузок и cloud-native приложений.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CSPM</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Cloud Security Posture Management</span>
    </div>
    <span class="lab-tag">Cloud Posture</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Непрерывный аудит конфигураций облака: IAM, сети, хранилища, политики. Отклонения от CIS Benchmarks, NIST и внутренних требований.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Prowler · ScoutSuite · Prisma Cloud</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CWPP</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Cloud Workload Protection Platform</span>
    </div>
    <span class="lab-tag">Workload Protection</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Защита рабочих нагрузок в рантайме: мониторинг процессов, сетевых соединений, файловой активности. Детектирование криптомайнеров, шеллов, lateral movement.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Falco · Sysdig · Aqua · Wiz</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CNAPP</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Cloud-Native Application Protection Platform</span>
    </div>
    <span class="lab-tag">Cloud Platform</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Объединяет CSPM + CWPP + контейнерную безопасность. Сквозное представление рисков: от кода до production-нагрузок в одной консоли.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Wiz · Prisma Cloud · Orca · Lacework</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">KSPM</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Kubernetes Security Posture Management</span>
    </div>
    <span class="lab-tag">K8s Security</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Аудит конфигураций Kubernetes: RBAC, Network Policies, Pod Security Standards, проверка по CIS Kubernetes Benchmark.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">kube-bench · Kubescape · Polaris</span>
  </div>

</div>

---

## Управление и оркестрация (Management & Orchestration)

Инструменты консолидации, приоритизации и управления уязвимостями из всех источников.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">ASPM</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Application Security Posture Management</span>
    </div>
    <span class="lab-tag">AppSec Management</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Консолидация SAST, DAST, SCA, секрет-сканеров в единую картину. Приоритизация рисков, привязка к бизнес-контексту, трекинг устранения.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">DefectDojo · Kondukto · ArmorCode</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">VDP</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Vulnerability Disclosure Program</span>
    </div>
    <span class="lab-tag">Bug Bounty / VDP</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Программа ответственного раскрытия уязвимостей: security.txt, bug bounty, triage и коммуникация с исследователями.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">HackerOne · Bugcrowd · Intigriti</span>
  </div>

</div>

---

## Мониторинг и реагирование (Monitoring & Response)

Сбор событий, корреляция, автоматизация реагирования — операционная безопасность.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SIEM</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Security Information and Event Management</span>
    </div>
    <span class="lab-tag">Monitoring / Analytics</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Централизованный сбор и корреляция событий из CI/CD, приложений, WAF, контейнеров. Основа detection engineering и threat hunting.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">ELK · Splunk · Wazuh · QRadar</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SOAR</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Security Orchestration, Automation and Response</span>
    </div>
    <span class="lab-tag">Automation / Response</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Оркестрация реакций на инциденты: обработка алертов, создание тикетов, блокировка артефактов, запуск playbooks. Снижает MTTR.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">XSOAR · Shuffle · Tines · TheHive</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">WAF</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Web Application Firewall</span>
    </div>
    <span class="lab-tag">Perimeter Defense</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Фильтрация HTTP-трафика на уровне приложения: блокировка SQL-инъекций, XSS, path traversal на периметре до достижения бэкенда.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">ModSecurity · Cloudflare WAF · AWS WAF</span>
  </div>

</div>

---

## AI/ML безопасность

Безопасность моделей машинного обучения, LLM и ML-пайплайнов — относительно новое направление.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">MLSecOps</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Machine Learning Security Operations</span>
    </div>
    <span class="lab-tag">ML / AI Security</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Защита ML-моделей: adversarial attacks, data poisoning, model extraction, prompt injection. Безопасность артефактов и ML supply chain.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">OWASP ML Top 10 · Garak · Rebuff</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">LLM Security</span>
      <span style="font-size:0.65rem; color:#888; font-family:var(--font-code);">Large Language Model Security</span>
    </div>
    <span class="lab-tag">LLM / GenAI</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Специфика LLM: prompt injection, jailbreaking, data leakage, insecure output handling. OWASP LLM Top 10 — фреймворк для оценки.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">OWASP LLM Top 10 · NeMo Guardrails</span>
  </div>

</div>