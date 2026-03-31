---
hide:
  - toc

title: Аббревиатурное описание AppSec инструментов
description: Расшифровка аббревиатур, их класс, область применения и описание для AppSec/DevSecOps инструментов.
---

<div class="hero-section">
  <div class="hero-content">
    <h1 class="hero-title">Application Security Toolchain</h1>
    <p class="hero-sub">Аббревиатуры и классы инструментов AppSec / DevSecOps</p>
  </div>
</div>

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SAST</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Static Application Security Testing</span>
    </div>
    <span class="lab-tag">Static AST</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Статический анализ исходного кода без запуска приложения. Обнаруживает уязвимости, ошибки и нарушения безопасных практик ещё до сборки и деплоя.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">IDE · pre-commit · CI/CD (ранние стадии)</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">DAST</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Dynamic Application Security Testing</span>
    </div>
    <span class="lab-tag">Dynamic AST</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Тестирование «чёрным ящиком»: имитирует реальные атаки на запущенное приложение, анализирует ответы и поведение без доступа к коду.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Web · API · QA/UAT · демо-среды</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">IAST</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Interactive Application Security Testing</span>
    </div>
    <span class="lab-tag">Interactive AST</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Агент внутри приложения отслеживает реальные потоки данных и вызовы. Комбинирует SAST и DAST, снижает число ложных срабатываний.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Агент в QA-среде</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">RASP</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Runtime Application Self-Protection</span>
    </div>
    <span class="lab-tag">Runtime Protection</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Самозащита приложения в рантайме: перехватывает опасные операции (SQL, файлы, сеть), анализирует контекст и блокирует атаки внутри процесса.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Прод · пре-прод · высокорисковые приложения</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SCA</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Software Composition Analysis</span>
    </div>
    <span class="lab-tag">SCA / OSA</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Анализ зависимостей, библиотек и пакетов на CVE, проблемы лицензирования и риски цепочки поставок.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Репозиторий · CI/CD · контейнеры</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">OSA</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Open Source Analysis</span>
    </div>
    <span class="lab-tag">SCA / OSA</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Фокус на OSS-компонентах: безопасность, качество сопровождения, совместимость лицензий, соответствие внутренней OSS-политике.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">OSS-компоненты в продуктах и сервисах</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SBOM</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Software Bill of Materials</span>
    </div>
    <span class="lab-tag">SBOM / Inventory</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Структурированный перечень всех компонентов продукта. Нужен для управления рисками цепочки поставок и соответствия регуляторным требованиям.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Поставка ПО · комплаенс</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SM</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Secret Management</span>
    </div>
    <span class="lab-tag">Secret Management</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Централизованное хранение и выдача секретов (пароли, токены, ключи, сертификаты), ротация, аудит доступа, интеграция с пайплайнами.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">CI/CD · микросервисы · K8s</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">NVS</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Network Vulnerability Scanner</span>
    </div>
    <span class="lab-tag">Infra / Network</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Сканирование хостов и сервисов на уровне сети (L3/L4): открытые порты, уязвимые версии сервисов, небезопасные конфигурации.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Периметр · внутренние сегменты · DMZ</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">BCA</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Bytecode and Container Analysis</span>
    </div>
    <span class="lab-tag">Binary / Container</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Анализ бинарного кода и контейнеров на уязвимости, вредоносный контент, плохие практики упаковки и конфигурации.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Контейнерные образы · бинарные сборки</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CIS</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Container Image Scanner</span>
    </div>
    <span class="lab-tag">Container Security</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Сканирование образов на CVE (OS, библиотеки), утечки секретов и нарушения best practices (root, лишние capabilities).</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Docker/OCI · реестры контейнеров</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CSPM</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Cloud Security Posture Management</span>
    </div>
    <span class="lab-tag">Cloud Posture</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Непрерывный аудит конфигураций облака и K8s: IAM, сети, хранилища, политики. Отклонения от CIS, NIST и внутренних требований.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Публичные/частные облака · K8s · IaaS/PaaS</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CNAPP</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Cloud-Native Application Protection Platform</span>
    </div>
    <span class="lab-tag">Cloud Platform</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Объединяет CSPM, CWPP, контейнерную и рантайм-безопасность. Сквозное представление рисков: от кода до production-нагрузок.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Мульти-облако · K8s + контейнеры</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">CWPP</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Cloud Workload Protection Platform</span>
    </div>
    <span class="lab-tag">Workload Protection</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Защита рабочих нагрузок: мониторинг процессов, сетевых соединений, файловой активности и политик безопасности на уровне хоста/агента.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">VM · контейнеры · serverless</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">ASPM</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Application Security Posture Management</span>
    </div>
    <span class="lab-tag">AppSec Management</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Консолидация SAST, DAST, SCA, секрет-сканеров. Приоритизация рисков, привязка к системам/компонентам, управление устранением.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Организации с большим числом приложений</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SCM</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Source Code Management</span>
    </div>
    <span class="lab-tag">Source Control</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Управление версиями исходного кода. Базовая точка интеграции AppSec-инструментов: hooks, PR-checks, секрет-сканеры, SBOM-генерация.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Git · SCM-платформы</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SCS</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Secure Code Standards</span>
    </div>
    <span class="lab-tag">Secure Coding</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Правила и практики безопасной разработки. Ложатся в основу профилей SAST, code review и обучающих программ.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Команды разработки · внутренние стандарты</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">License Policy</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">License / Governance</span>
    </div>
    <span class="lab-tag">Governance</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Политики и проверки соблюдения лицензионных условий: тип, совместимость, запрет определённых лицензий при использовании OSS-компонентов.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">Формальная OSS-политика · комплаенс</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">MLSecOps</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Machine Learning Security Operations</span>
    </div>
    <span class="lab-tag">ML / AI Security</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Защита ML/LLM-моделей: данные, артефакты, устойчивость к атакам, риски цепочки поставок ML.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">ML/LLM-проекты · MLOps-пайплайны</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SIEM</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Security Information and Event Management</span>
    </div>
    <span class="lab-tag">Monitoring / Analytics</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Централизованный сбор и корреляция событий безопасности из CI/CD, приложений, WAF, контейнеров. Основа сценариев реагирования.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">SOC · центры мониторинга</span>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.4rem;">
    <div style="display:flex; align-items:baseline; gap:0.6rem; width:100%;">
      <span class="lab-card-num" style="font-size:0.9rem; width:auto;">SOAR</span>
      <span style="font-size:0.65rem; color:#888; font-family:'JetBrains Mono',monospace;">Security Orchestration, Automation and Response</span>
    </div>
    <span class="lab-tag">Automation / Response</span>
    <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Оркестрация и автоматизация реакций на инциденты: обработка алертов, создание тикетов, блокировка артефактов, запуск плейбуков.</p>
    <span class="lab-tag" style="color:#888; border-color:rgba(0,0,0,0.1); background:rgba(0,0,0,0.03);">SOC · высокий уровень автоматизации</span>
  </div>

</div>

![Логотип](artifacts/assets/logotypemd.jpg)
