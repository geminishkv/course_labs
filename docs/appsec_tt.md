---
hide:
  - toc

title: Аббревиатурное описание AppSec инструментов
description: Расшифровка аббревиатур, их класс, область применения и описание для AppSec/DevSecOps инструментов.
---

<table>
  <thead>
    <tr>
      <th style="width:8%;">Аббревиатура</th>
      <th style="width:22%;">Расшифровка</th>
      <th style="width:20%;">Класс / Тип</th>
      <th style="width:20%;">Где применять</th>
      <th style="width:30%;">Описание</th>
    </tr>
  </thead>
  <tbody>

    <tr>
      <td><strong>SAST</strong></td>
      <td>Static Application Security Testing</td>
      <td>Static AST</td>
      <td>Исходный код, IDE, pre‑commit, CI/CD (ранние стадии SDLC)</td>
      <td>Статический анализ исходного кода без запуска приложения. Помогает обнаруживать уязвимости, ошибки и нарушения безопасных практик ещё до сборки и деплоя.</td>
    </tr>

    <tr>
      <td><strong>DAST</strong></td>
      <td>Dynamic Application Security Testing</td>
      <td>Dynamic AST</td>
      <td>Работающие web‑ и API‑приложения, стенды QA/UAT, демо‑среды</td>
      <td>Динамическое тестирование безопасности «чёрным ящиком»: имитирует реальные атаки на запущенное приложение, анализирует ответы и поведение без доступа к коду.</td>
    </tr>

    <tr>
      <td><strong>IAST</strong></td>
      <td>Interactive Application Security Testing</td>
      <td>Interactive AST</td>
      <td>Интеграция агента в приложение на тестовых/QA‑средах</td>
      <td>Комбинирует подходы SAST и DAST. Агент внутри приложения отслеживает реальные потоки данных и вызовы, повышая точность и снижая количество ложных срабатываний.</td>
    </tr>

    <tr>
      <td><strong>RASP</strong></td>
      <td>Runtime Application Self‑Protection</td>
      <td>Runtime Protection</td>
      <td>Прод/пре‑прод окружения, высокорисковые приложения</td>
      <td>Средства самозащиты приложения в рантайме: перехватывают опасные операции (SQL, файлы, сеть), анализируют контекст и блокируют атаки внутри процесса.</td>
    </tr>

    <tr>
      <td><strong>SCA</strong></td>
      <td>Software Composition Analysis</td>
      <td>SCA / OSA</td>
      <td>Менеджеры зависимостей, репозитории, CI/CD, контейнеры</td>
      <td>Анализ состава ПО (зависимостей, библиотек, пакетов) на наличие известных уязвимостей (CVE), проблем лицензирования и рисков цепочки поставок.</td>
    </tr>

    <tr>
      <td><strong>OSA</strong></td>
      <td>Open Source Analysis</td>
      <td>SCA / OSA</td>
      <td>Использование OSS‑компонентов в продуктах и сервисах</td>
      <td>Фокус на компонентах с открытым исходным кодом: безопасность, качество сопровождения, совместимость лицензий, соответствие внутренней OSS‑политике.</td>
    </tr>

    <tr>
      <td><strong>SBOM</strong></td>
      <td>Software Bill of Materials</td>
      <td>SBOM / Inventory</td>
      <td>Продукты с большим количеством зависимостей, поставка ПО, комплаенс</td>
      <td>Структурированный перечень всех компонентов (библиотек, пакетов, образов), входящих в продукт. Нужен для управления рисками цепочки поставок и соответствия требованиям регуляторов.</td>
    </tr>

    <tr>
      <td><strong>SM</strong></td>
      <td>Secret Management</td>
      <td>Secret Management</td>
      <td>CI/CD, приложения, микросервисы, инфраструктура (VM, K8s)</td>
      <td>Централизованное хранение и выдача секретов (пароли, токены, ключи, сертификаты), ротация, аудит доступа, интеграция с приложениями и пайплайнами.</td>
    </tr>

    <tr>
      <td><strong>NVS</strong></td>
      <td>Network Vulnerability Scanner</td>
      <td>Infra / Network</td>
      <td>Сетевой периметр, внутренние сегменты, DMZ, VPN‑шлюзы</td>
      <td>Сканирование хостов и сервисов на уровне сети (L3/L4): поиск открытых портов, уязвимых версий сервисов и небезопасных конфигураций.</td>
    </tr>

    <tr>
      <td><strong>BCA</strong></td>
      <td>Bytecode and Container Analysis</td>
      <td>Binary / Container</td>
      <td>Контейнерные образы, бинарные сборки, артефакты CICD</td>
      <td>Анализ бинарного кода и контейнеров на уязвимости, вредоносный или подозрительный контент, плохие практики упаковки и конфигурации.</td>
    </tr>

    <tr>
      <td><strong>CIS</strong></td>
      <td>Container Image Scanner</td>
      <td>Container Security</td>
      <td>Docker/OCI‑образы, реестры контейнеров (public/private)</td>
      <td>Сканирование образов контейнеров на уязвимости (OS‑пакеты, библиотеки), утечки секретов и нарушения best practices (root‑юзер, лишние capabilities и т.п.).</td>
    </tr>

    <tr>
      <td><strong>CSPM</strong></td>
      <td>Cloud Security Posture Management</td>
      <td>Cloud Posture</td>
      <td>Публичные/частные облака, Kubernetes, IaaS/PaaS‑сервисы</td>
      <td>Непрерывный аудит конфигураций облака и K8s: IAM, сети, хранилища, политики. Ищет отклонения от бенчмарков (CIS, NIST) и внутренних требований.</td>
    </tr>

    <tr>
      <td><strong>CNAPP</strong></td>
      <td>Cloud‑Native Application Protection Platform</td>
      <td>Cloud Platform</td>
      <td>Крупные cloud‑ландшафты, мульти‑облако, K8s + контейнеры</td>
      <td>Объединяет CSPM, CWPP, контейнерную и рантайм‑безопасность. Дает сквозное представление рисков: от кода и образов до облачной инфраструктуры и production‑нагрузок.</td>
    </tr>

    <tr>
      <td><strong>CWPP</strong></td>
      <td>Cloud Workload Protection Platform</td>
      <td>Workload Protection</td>
      <td>VM, контейнеры, serverless‑функции в облаке и on‑prem</td>
      <td>Защита рабочих нагрузок: мониторинг процессов, сетевых соединений, файловой активности и политик безопасности на уровне хоста/агента.</td>
    </tr>

    <tr>
      <td><strong>ASPM</strong></td>
      <td>Application Security Posture Management</td>
      <td>AppSec Management</td>
      <td>Организации с большим количеством приложений и сканеров</td>
      <td>Консолидация результатов SAST, DAST, SCA, секрет‑сканеров и др. Помогает приоритизировать риски, связывать их с системами/компонентами и управлять устранением уязвимостей.</td>
    </tr>

    <tr>
      <td><strong>SCM</strong></td>
      <td>Source Code Management</td>
      <td>Source Control</td>
      <td>Все проекты, использующие системы контроля версий (Git и др.)</td>
      <td>Управление версиями исходного кода и артефактов. Базовая точка интеграции AppSec‑инструментов (hooks, PR‑checks, секрет‑сканеры, SBOM‑генерация).</td>
    </tr>

    <tr>
      <td><strong>License Policy</strong></td>
      <td>—</td>
      <td>License / Governance</td>
      <td>Организации с формальной OSS‑политикой и требованиями комплаенса</td>
      <td>Политики и проверки на соблюдение лицензионных условий (тип лицензии, совместимость, запрет определённых лицензий) при использовании сторонних и open‑source компонентов.</td>
    </tr>

    <tr>
      <td><strong>SCS</strong></td>
      <td>Secure Code Standards</td>
      <td>Secure Coding</td>
      <td>Команды разработки, внутренние стандарты и гайды</td>
      <td>Набор правил и практик безопасной разработки: что считать «безопасным кодом» в организации. Ложится в основу профилей SAST, code review и обучающих программ.</td>
    </tr>

    <tr>
      <td><strong>MLSecOps</strong></td>
      <td>Machine Learning Security Operations</td>
      <td>ML / AI Security</td>
      <td>Проекты с ML/LLM‑моделями и MLOps‑пайплайнами</td>
      <td>Инструменты и практики защиты ML/LLM‑моделей: защита данных, моделей и артефактов, тестирование устойчивости к атакам, управление рисками цепочки поставок ML.</td>
    </tr>

    <tr>
      <td><strong>SIEM</strong></td>
      <td>Security Information and Event Management</td>
      <td>Monitoring / Analytics</td>
      <td>SOC, центры мониторинга, крупные ландшафты</td>
      <td>Централизованный сбор и корреляция событий безопасности. В контексте AppSec получает события от CI/CD, приложений, WAF, контейнеров и помогает строить сценарии реагирования.</td>
    </tr>

    <tr>
      <td><strong>SOAR</strong></td>
      <td>Security Orchestration, Automation and Response</td>
      <td>Automation / Response</td>
      <td>Организации с SOC и высоким уровнем автоматизации</td>
      <td>Оркестрация и автоматизация реакций на инциденты: обработка алертов AppSec‑инструментов, создание тикетов, блокировка артефактов, обновление политик и запуск плейбуков.</td>
    </tr>

  </tbody>
</table>

![Логотип](artifacts/assets/logotypemd.jpg)