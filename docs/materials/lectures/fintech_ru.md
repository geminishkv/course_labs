---
title: "Где деньги, Лебовски? — Fintech по-русски | Лекция AppSec"
description: "Лекция по Fintech в России: рынок, регуляторы, AML/ПОД-ФТ, compliance, FinDevSecOps, Security Champion и вызовы финтех-индустрии."
keywords: "Fintech, финтех, Россия, AML, ПОД-ФТ, compliance, FinDevSecOps, Security Champion, AppSec, ЦБ РФ, PCI DSS, ГОСТ 57580, KYC"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">«Где деньги, Лебовски?» — Fintech по-русски</h1>
    <p class="hero-sub">Лекция · Fintech</p>
  </div>
</div>

## 01. Что такое Fintech

**Financial Technology** — технологии, которые трансформируют предоставление финансовых услуг, как фундаментальное изменение подхода к тому, как создаются, доставляются и потребляются финансовые продукты.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Цифровизация</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Полный отказ от бумажных процессов</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Автоматизация</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Алгоритмы вместо ручных операций</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Доступность</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Финансовые услуги 24/7 из любой точки</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Скорость</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Мгновенные переводы, онлайн-скоринг за секунды</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Персонализация</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">AI-driven подбор продуктов под клиента</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">API-first</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Открытые интерфейсы для интеграции сервисов</span></div>
</div>

---

## 02. Традиционный банкинг vs Fintech

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Скорость</span><div class="lab-card-tags"><span class="lab-tag">Банкинг: дни–недели</span><span class="lab-tag">Fintech: секунды–минуты</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Каналы</span><div class="lab-card-tags"><span class="lab-tag">Банкинг: офисы, банкоматы</span><span class="lab-tag">Fintech: мобильные приложения, API</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Скоринг</span><div class="lab-card-tags"><span class="lab-tag">Банкинг: ручной анализ КИ</span><span class="lab-tag">Fintech: AI/ML, альтернативные данные</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Инфраструктура</span><div class="lab-card-tags"><span class="lab-tag">Банкинг: ЦОД банка</span><span class="lab-tag">Fintech: облака, микросервисы</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Time-to-Market</span><div class="lab-card-tags"><span class="lab-tag">Банкинг: месяцы</span><span class="lab-tag">Fintech: недели</span></div></div>
</div>

### Примеры решений

- **Платежи и переводы:** СБП, Тинькофф Pay, Яндекс Pay, SberPay, VK Pay
- **Кредитование:** P2P-платформы, онлайн-скоринг, BNPL (Buy Now Pay Later), МФО нового поколения
- **Страхование (InsurTech):** онлайн-полисы, автоматическая оценка рисков, телематика
- **Инвестиции:** робо-эдвайзеры, брокерские приложения (Тинькофф Инвестиции, Финам), копитрейдинг
- **RegTech:** автоматизация compliance, KYC/AML-проверки, мониторинг транзакций
- **Цифровые активы:** ЦФА (цифровые финансовые активы), цифровой рубль, токенизация

---

## 03. Рынок Fintech в России

### Объём рынка

- **$3.57 млрд** — размер рынка в 2024 году и **$14.66 млрд** — прогноз к 2033 году
- **15.18%** — ежегодный темп роста (CAGR)
- **500+** fintech-компаний в России (рост с ~250 в 2019)
- **~130 млн** — ожидаемое число пользователей к 2027 году
- **85%** — граждан используют онлайн-банкинг

### Ключевые игроки

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">ЮMoney</span><span style="font-size:0.72rem; color:#555;">Лидер по выручке (14.13 млрд руб, I полугодие 2025)</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Сбер</span><span style="font-size:0.72rem; color:#555;">Экосистема: SberPay, Сбер ID, AI-сервисы</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Т-Банк</span><span style="font-size:0.72rem; color:#555;">Цифровой банк без отделений, инвестиции, страхование</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Альфа-Банк</span><span style="font-size:0.72rem; color:#555;">Мобильный банкинг, Open Banking пилот</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Яндекс</span><span style="font-size:0.72rem; color:#555;">Яндекс Pay, Яндекс Сплит (BNPL)</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Ozon</span><span style="font-size:0.72rem; color:#555;">Ozon Банк, микрофинансирование, рассрочка</span></div>
</div>

---

## 04. Тренды 2025–2026

- **Цифровой рубль** — массовый запуск с 1 сентября 2026 года. Крупнейшие банки и торговцы с выручкой >120 млн руб обязаны принимать. Для граждан все операции бесплатны
- **ЦФА** — цифровые финансовые активы: токенизация активов, новый класс инструментов для инвестиций
- **Open Banking** — пилоты Сбер, Т-Банк, Альфа, ВТБ. Стандарт открытых API для обмена данными о счетах (с согласия клиента)
- **AI/ML** — генеративный AI в скоринге, фрод-мониторинге, персонализации продуктов, чат-ботах
- **Биометрия** — ЕБС (Единая биометрическая система), биоэквайринг
- **Embedded Finance** — встраивание финансовых услуг в нефинансовые платформы (маркетплейсы, такси, доставка)

---

## 05. Регулирование

### Кто регулирует Fintech в России

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">ЦБ РФ</span><span style="font-size:0.72rem; color:#555;">Лицензирование банков, НКФО, МФО, страховых. Надзор за платёжными системами. Требования к ИБ</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Росфинмониторинг</span><span style="font-size:0.72rem; color:#555;">Финансовая разведка. Контроль 115-ФЗ (ПОД-ФТ). Отчёты о подозрительных операциях</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">ФСТЭК России</span><span style="font-size:0.72rem; color:#555;">Требования к ИБ для финансовых и критически важных организаций</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">Роскомнадзор</span><span style="font-size:0.72rem; color:#555;">Надзор за обработкой персональных данных (152-ФЗ)</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">ФАС</span><span style="font-size:0.72rem; color:#555;">Защита конкуренции. Контроль экосистем и маркетплейсов</span></div>
</div>

### Ключевые законы

- **161-ФЗ** (27.06.2011) — О национальной платёжной системе (НПС). Основа для СБП и цифрового рубля
- **115-ФЗ** (07.08.2001) — О противодействии легализации (отмыванию) доходов и финансированию терроризма. ПОД-ФТ
- **152-ФЗ** (27.07.2006) — О персональных данных. Защита ПДн клиентов финтех-компаний
- **187-ФЗ** (26.07.2017) — О безопасности КИИ. Три категории объектов по значимости

---

## 06. AML / ПОД-ФТ

**AML** — комплекс мер по противодействию отмыванию денег, полученных преступным путём.

**ПОД-ФТ** — противодействие легализации (отмыванию) доходов, полученных преступным путём, и финансированию терроризма.

### Порядок

1. **Идентификация клиента (KYC)** — верификация личности, проверка по спискам (террористы, экстремисты, ПЕП), определение бенефициарного владельца
2. **Мониторинг операций** — автоматический анализ всех транзакций в реальном времени. Пороговый контроль: операции свыше 600 000 руб подлежат обязательному контролю
3. **Отчётность в Росфинмониторинг** — ежемесячные отчёты о подозрительных операциях
4. **Внутренний контроль** — разработка ПВК, назначение ответственного, обучение персонала

### Ответственность

- Физлица: штрафы **30 000 – 50 000 руб**
- Юрлица: штрафы **400 000 – 1 000 000 руб**
- Неподача информации: **200 000 – 400 000 руб**
- Последствия: отзыв лицензии ЦБ, блокировка счетов, **уголовная ответственность до 7 лет** (ст. 174, 174.1 УК РФ)

---

## 07. Стандарты безопасности

### Российские

- **ГОСТ Р 57580.1-2017** — безопасность финансовых (банковских) операций. Обязателен для банков и НКФО
- **ГОСТ 56939-2024** — безопасная разработка ПО. Требования к процессам разработки
- **Положения ЦБ РФ** — требования к НКФО, подготовка к цифровому рублю

### Международные

- **PCI DSS** — стандарт безопасности данных платёжных карт. Обязателен для всех, кто обрабатывает карточные данные
- **ISO 27001** — система управления информационной безопасностью
- **SOC 2** — контроль безопасности, доступности, конфиденциальности для сервис-провайдеров

---

## 08. Compliance в Fintech

Compliance — система процессов, которая обеспечивает работу бизнеса строго в соответствии с законодательством, отраслевыми стандартами и внутренними регламентами.

Для fintech-компании compliance непрерывный процесс:

- Соответствие требованиям ЦБ РФ и других регуляторов
- Исполнение 115-ФЗ (AML/ПОД-ФТ)
- Защита персональных данных (152-ФЗ)
- Безопасность КИИ (187-ФЗ)
- Выполнение стандартов ИБ (ГОСТ Р 57580, PCI DSS)
- Внутренний аудит и контроль
- Обучение сотрудников

> **Цена несоответствия:** штрафы, отзыв лицензии, уголовная ответственность, репутационные потери.

---

## 09. Мониторинг

### Уровень 1 — Автоматический

- Системы мониторинга транзакций
- AML-скрининг в реальном времени
- Автоматические проверки по санкционным спискам
- Алерты при превышении пороговых значений

### Уровень 2 — Регулярный контроль

- Ежедневная проверка операций, подлежащих обязательному контролю
- Еженедельный анализ подозрительной активности
- Ежемесячная отчётность в Росфинмониторинг
- Квартальный внутренний аудит

### Уровень 3 — Стратегический

- Ежегодная оценка рисков (Risk Assessment)
- Обновление ПВК (правила внутреннего контроля)
- Обучение и аттестация персонала
- Подготовка к проверкам ЦБ РФ

---

## 10. Автоматизация

- **KYC/KYT** — автоматическая верификация клиентов и транзакций
- **Мониторинг транзакций** — ML-модели выявляют аномалии, снижение ложных блокировок в 5-7 раз
- **Скрининг санкционных списков** — проверка в реальном времени по базам Росфинмониторинга, OFAC, EU
- **Отчётность** — автоматическая генерация и подача отчётов регулятору
- **Compliance as Code** — политики соответствия описываются как код: OPA, Kyverno, InSpec
- **Аудит-трейл** — автоматическая фиксация всех действий для проверок

---

## 11. FinDevSecOps

**FinDevSecOps = Fintech + DevSecOps** — объединение практик безопасной разработки и специфики финансового сектора. Shift-Left подход к безопасности в финтех-продуктах.

### Почему обычного DevSecOps недостаточно

- Финансовые данные — максимальный уровень критичности
- Регуляторные требования жёстче, чем в других отраслях
- Транзакции — необратимы, цена ошибки = реальные деньги
- PCI DSS, ГОСТ 57580 — специфические стандарты ИБ
- Постоянный контроль со стороны ЦБ, Росфинмониторинга, ФСТЭК
- Время реагирования на инциденты — минуты, не дни

---

## 12. Security Champion

Security Champion — идеолог ИБ в команде разработки:

- **Знает свой продукт** — что с чем взаимодействует, на что смотреть в первую очередь
- **Указывает на дефект / УЯЗ кода** — и его слово имеет больше «веса» в команде
- **Доносит конечную ценность ИБ** — при разработке и выполнении требований для бизнеса
- **Управляет задачами ИБ** — и приоритизирует их внутри команды разработки

---

## 13. Что это даёт?

- **Понимание ландшафта угроз** — fintech-специфичные атаки: фрод, подмена транзакций, атаки на API платёжных шлюзов, credential stuffing
- **Осознанная приоритизация** — когда знаешь бизнес-контекст (AML, PCI DSS, ГОСТ 57580), приоритизируешь уязвимости не по CVSS, а по реальному влиянию
- **Говоришь на языке бизнеса** — вместо «у нас Critical в зависимости» говоришь «мы рискуем не пройти аудит ЦБ по ГОСТ 57580 и получить предписание»
- **Compliance как драйвер безопасности** — требования регуляторов дают мандат на внедрение практик
- **Security by design** — участие AppSec на этапе проектирования
- **Автоматизация проверок в CI/CD** — политики ИБ как код, Quality Gate с учётом финтех-специфики
- **Влияние на архитектуру** — шифрование at rest и in transit, токенизация карточных данных, изоляция PII, zero trust

---

## 14. Вызовы и возможности

### Вызовы

- Баланс инноваций и безопасности — быстрый TTM vs строгие требования регуляторов
- Импортозамещение — переход на отечественные решения в условиях санкций
- Кадровый дефицит — нехватка специалистов на стыке финансов, разработки и ИБ
- Усложнение регуляторной среды — новые требования ЦБ, изменения в 115-ФЗ, 187-ФЗ
- Рост киберугроз — финтех как приоритетная цель для атак
- Консолидация рынка — малым игрокам всё сложнее конкурировать с экосистемами

### Возможности

- Цифровой рубль — новый пласт сервисов и интеграций с сентября 2026
- Open Banking — стандартизация API, новые бизнес-модели
- AI/ML — генеративный AI для скоринга, фрод-мониторинга, персонализации
- RegTech — растущий рынок автоматизации compliance
- Open Source — снижение затрат, развитие сообщества
- ЦФА — новый класс активов, токенизация

---

## Ключевые выводы

1. Российский финтех растёт на 15% в год и достигнет $14.66 млрд к 2033
2. Цифровой рубль кардинально изменит ландшафт с сентября 2026
3. Регуляторная среда усложняется каждый год — compliance становится конкурентным преимуществом
4. AML/ПОД-ФТ — не формальность, а реальный риск: штрафы до 1 млн руб, уголовная ответственность до 7 лет
5. Безопасность финтеха требует специализированного подхода с учётом специфики финансовых данных и регуляторов
6. Кадровый дефицит на стыке финансов, разработки и ИБ — специалисты на вес золота
7. AI/ML меняет правила игры — генеративный AI в скоринге, фрод-мониторинге уже production-реальность
