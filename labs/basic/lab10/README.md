<div align="center">
<h1><a id="intro">Лабораторная работа №10</a><br></h1>
<a href="https://docs.github.com/en"><img src="https://img.shields.io/static/v1?logo=github&logoColor=fff&label=&message=Docs&color=36393f&style=flat" alt="GitHub Docs"></a>
<a href="https://daringfireball.net/projects/markdown"><img src="https://img.shields.io/static/v1?logo=markdown&logoColor=fff&label=&message=Markdown&color=36393f&style=flat" alt="Markdown"></a>
<a href="https://shields.io"><img src="https://img.shields.io/static/v1?logo=shieldsdotio&logoColor=fff&label=&message=Shields&color=36393f&style=flat" alt="Shields"></a>
<img src="https://img.shields.io/badge/Course-AppSec-D51A1A?style=flat" alt="Course: AppSec">
<img src="https://img.shields.io/badge/Risk_Analysis-D51A1A?style=flat" alt="Risk Analysis">
<img src="https://img.shields.io/badge/Contributor-Шмаков_И._С.-8b9aff?style=flat" alt="Contributor"></div>

***

Салют :wave:,<br>
Данная лабораторная работа посвящена закреплению всех приобретенных навыков, где вам следует использовать все полученные знания за все время обучения.

- **Эта работа позволит вам:**

> -  Проанализировать принципы обеспечения безопасности `CI/CD-конвейера`
> -  Выявить недостатки в веб-интерфейсе
> -  Исследовать логику возникновения уязвимостей в коде
> -  Оценить последствия отсутствия контроля в конвейере поставок ПО, которые позволяют злоумышленнику осуществить кражу конфиденциальных данных, получить несанкционированный доступ за счёт повышения привилегий, скомпрометировать архитектуру системы

- Ваша задача на практике отработать классификацию рисков ИБ на базе примеров задач бизнеса, использовать знания по обнаружению уязвимостей, выставлению требований к разработке ПО, какие анализаторы использовать и иное 
- Отработка знаний позволит вам научиться получать и добиваться нужного эффекта от бизнеса, приоритезировать задачи ИБ в продуктовом `RoadMap` и выделять косты бюджета на активности ИБ

Для сдачи данной работы также будет требоваться ответить на дополнительные вопросы по описанным темам. После выполнения задания вы получите корректировку ответов и пояснения для развития компетенций в области.

***

## Материал

### Методология оценки рисков

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">1. Инвентаризация</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Определить активы: ПДн, коммерческие данные, инфраструктура, репутация. Классифицировать по критичности.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">2. Идентификация угроз</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Описать сценарии: утечка ПДн, взлом ЛК, подмена данных, DDoS, инъекции, social engineering.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">3. Оценка рисков</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Вероятность × Влияние. Качественная (Высокий/Средний/Низкий) или количественная (CVSS, денежная оценка).</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">4. Меры снижения</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Техническое решение + организационные меры. Баланс стоимости меры и ущерба от реализации риска.</span></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><span class="lab-card-num" style="font-size:0.85rem; width:auto;">5. Остаточный риск</span><span style="font-size:0.72rem; color:#555; line-height:1.4;">Документирование принятых рисков с обоснованием. Мониторинг и пересмотр при изменении контекста.</span></div>
</div>

### Структура аналитической записки

> 1. **Описание ситуации** — что обнаружено, контекст бизнеса
> 2. **Классификация рисков** — регуляторные, утечки, киберпреступления
> 3. **Оценка** — вероятность, влияние, приоритет
> 4. **Меры снижения** — техническое решение, организационные меры
> 5. **Заключение** — остаточный риск, принятые риски, контроли

### Инструментарий AppSec для проекта

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));">
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><div class="lab-card-title" style="font-weight:700;">SAST</div><div class="lab-card-tags"><span class="lab-tag">Semgrep</span><span class="lab-tag">Checkov</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><div class="lab-card-title" style="font-weight:700;">SCA</div><div class="lab-card-tags"><span class="lab-tag">OWASP DC</span><span class="lab-tag">Trivy</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><div class="lab-card-title" style="font-weight:700;">DAST</div><div class="lab-card-tags"><span class="lab-tag">OWASP ZAP</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><div class="lab-card-title" style="font-weight:700;">Secrets</div><div class="lab-card-tags"><span class="lab-tag">Gitleaks</span><span class="lab-tag">TruffleHog</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><div class="lab-card-title" style="font-weight:700;">CI/CD</div><div class="lab-card-tags"><span class="lab-tag">GitHub Actions</span></div></div>
<div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.3rem;"><div class="lab-card-title" style="font-weight:700;">Container</div><div class="lab-card-tags"><span class="lab-tag">Trivy</span><span class="lab-tag">CIS Bench</span></div></div>
</div>

***

### Цель 

- Закрепить полученные знания 
- Развить навыки стратегического взаимодействия с бизнесом 
- Научиться прогнозировать влияние задач на процессы разработки и бизнес-результаты, а также анализировать последствия невыполнения требований ИБ
- Разбор архитектурного решения позволит понять на практике, куда и как встраиваются требования, инструменты, политики и человеческие ресурсы ИБ 

***

### Ремарка 

> Помните о акценте на быструю поставку ценности, а также только необходимого функционала – приоритет задач бизнеса, так как важно проработать изменение логики функциональных/ не функциональных требований ИБ. 

Зафиксируйте риски информационной безопасности, связанные с данной активностью, и классифицируйте их по следующим категориям:
> - регуляторные требования
> - утечки данных
> - киберпреступления

***

## Структура репозитория лабораторной работы

```bash
lab10
└── README.md
```

***

## Задание

Бизнес хочет протестировать гипотезу целесообразности нового продукта для клиентов в виде web-приложения. Гипотеза направлена на сбор информации из публичных источников о гастрономических заведениях и их оценках, продвижения – то есть анализ конкурентных преимуществ. 

> Активность бизнеса предполагает запуск веб-приложения по типу с отзывами о кафе и ресторанах. Бизнес предполагает, что необходим личный кабинет пользователя, который позволит идентифицировать человека и контролировать достоверность его отзывов. 

Бизнес понимает, что это нужно для снижения риска потери деловой репутации, как маркетера, так и порчи репутации заведений, которые оцениваются (учитывайте влияние на наш бизнес, когда контрагент, партнер получает негатив от наших клиентов) и, что следует контролировать контент. 

### Основное

1. Нам нужно оценить риски, которые повлияют на бизнес и предложить лучшие решения для них
2. Приложение позволяет осуществлять бронирование мест с данными о клиенте за индивидуальное вознаграждение (для увеличение роста клиентов) 
3. Страница бронирования включает:

> - информацию о заведении, 
> - рецензию, 
> - наименования личных аккаунтов пользователей, 
> - пользовательский рейтинг, 
> - балльную оценку заведения, 
> - текст отзыва (нам надо также учесть валидацию данных в формах, как подсказка: инъекция в placeholder исполняемого кода на стороне сервера),
> - возможность оставлять комментарии, 
> - возможность отмечать избранное, 
> - сохранять в закладки, 
> - просматривать аккаунты пользователей, а также личные данные пользователей, как пример фото, а там есть метаданные (`EXIF`), которые содержат информацию о устройстве, локации, профиле и иное.

4. Гипотеза бизнеса также ориентирована на использовании нотификаций, то есть отправки уведомлений на персональные аккаунты пользователей в мессенджеры, типа Telegram, включая веб, личные устройства, почту
5. Бизнесу проще и комфортнее выбрать **готовое решение** и сделать его на CMS для тестирования клиентского спроса и только частной визуализации web-дизайна (по этому учитывайте, что могут быть известные уязвимости этих CMS)
6. **Предлагается** рассмотреть 1С Битрикс, либо Wordpress, Opencart — следует найти информацию об уязвимостях на состояние 2025 года и оценить, какие риски они несут в текущей версии ПО, которое планируется использовать. Также приведите рекомендации об их устранении.

### Учтите

- Бизнес будет использовать публичные данные о заведениях и нам необходимо их верифицировать. С каждым заведением имеется агентский договор, где мы является оператором данных по ПДн и выставляем требования по обработке и хранению данных клиентов. Важно учитывать сбор данных (именно его формат) из открытых источников, где будут храниться, обрабатываться и передаваться при внешних интеграциях, также учтите размещение, хранение на выбранной платформе
- Будет иметься личный кабинет пользователя, который содержит ПДн, номера, иные данные (можете ограничить себе скоуп необходимой информации), например: номер телефона, почта, ФИО и иные идентификационные данные
- Бронирование осуществляется по средствам внешней интеграции путем передачи данных по API в заведения
- **Пример по разбору рисков:** ОТП-код имеет риск его перебора (брут-форсинга), подмены, абуза времени жизни кода, которая вываливается в риск киберпреступления, путем взлома личного кабинета и кражи данных. Для минимизации риска: ограничение времени жизни кода, количества запросов в момент времени, контроль длины кода (не меньше 6 символов) и т.д.
- Помните, что важен принцип упрощения задачи для разработчиков, не рассматривайте ситуации с углубленной технической точки зрения, будет достаточно описания вектора реализации риска ИБ
- **Возможность изменения:** на любом этапе можно предложить альтернативное решение со стороны ИБ, которое может снизить описанные риски до целевого уровня. 

### Итого

> Вам необходимо сформулировать минимальный и достаточный набор требований информационной безопасности для снижения рисков до приемлемого уровня. Сфокусируйтесь на рисках с наиболее простыми векторами реализации и кратчайшим временным циклом атаки. Изложите их на языке, понятном для бизнес-аудитории.

- [ ] 1. Изучите формы авторизации на примере `tripadvisor.com` или аналогичного сервиса отзывов. Опишите: как работает вход в ЛК, восстановление доступа, какие данные хранятся в профиле. Зафиксируйте наблюдения в отчёте
- [ ] 2. Составьте перечень инструментов **AppSec** для данного проекта: какие SAST, SCA, DAST, Secret Detection инструменты будете использовать и на каком этапе SDLC. Язык программирования не важен — фокус на процессе
- [ ] 3. Для каждого выявленного риска определите стратегию обработки: **снижение**, **передача**, **принятие** или **избежание**. Для принятых рисков — обоснуйте решение (стоимость реализации vs ущерб) и опишите необходимые компенсирующие контроли
- [ ] 4. Опишите риски ИБ, связанные с обработкой ПДн клиентов (телефон, ФИО, мессенджер) и авторизацией через ОТП-код. Для каждого риска укажите: вектор атаки, влияние и меру снижения
- [ ] 5. Определите минимально необходимый объём ПДн по принципу KYC (Know Your Customer). Опишите требования к хранению (шифрование БД, выделенный инстанс), передаче (безопасный канал, API) и отображению (маскирование на UI) данных
- [ ] 6. Проведите анализ уязвимостей выбранной CMS (1С Битрикс / WordPress / Opencart) на 2025 год. Найдите минимум 3 известные CVE, оцените их критичность и предложите меры устранения. Учтите риски затягивания уязвимых зависимостей при обновлении CMS
- [ ] 7. Подготовьте аналитическую записку со следующими разделами:
    - [ ] 7.1 — Типовые ошибки разработчиков при реализации проекта
    - [ ] 7.2 — Анализ угроз: взлом, утечка, доступность — с классификацией активов по значимости
    - [ ] 7.3 — Требования ИБ к проекту (функциональные и нефункциональные)
    - [ ] 7.4 — Матрица рисков: риск → вероятность → влияние → мера → эффективность меры
    - [ ] 7.5 — Описание 3 уязвимостей со ссылками на CWE: причина, Proof-of-Concept, мера устранения
    - [ ] 7.6 — Принятые риски с обоснованием (простота реализации vs стоимость решения)
    - [ ] 7.7 — Перечень контролей ИБ
    - [ ] 7.8 — Критерии качества кода для разработчиков (Security Gates)
- [ ] 8. Оформите `README.md` по аналогии и подготовьте отчёт `gist`

***

## Смотри также

- [Лаб. №4 — Risk Analysis](https://course.geminishkv.tech/labs/basic/lab04/) — первая лаба по анализу рисков ИБ
- [Лаб. №7 — SAST/SCA](https://course.geminishkv.tech/labs/basic/lab07/) — статический анализ и зависимости
- [Лаб. №8 — DAST](https://course.geminishkv.tech/labs/basic/lab08/) — динамическое тестирование
- [Лаб. №9 — CI/CD](https://course.geminishkv.tech/labs/basic/lab09/) — DevSecOps пайплайн
- [Supply Chain Attacks](https://course.geminishkv.tech/materials/examples/supply_chain_attacks/) — атаки на цепочку поставок

***

## Troubleshooting

Если столкнулись с проблемами — смотрите [Troubleshooting](https://course.geminishkv.tech/troubleshooting/).

***

## Links

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">
<a class="lab-card" href="https://owasp.org/www-community/OWASP_Risk_Rating_Methodology" target="_blank"><div class="lab-card-body"><div class="lab-card-title">OWASP Risk Rating Methodology</div><div class="lab-card-tags"><span class="lab-tag">owasp.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://owasp.org/www-project-top-ten/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">OWASP Top 10</div><div class="lab-card-tags"><span class="lab-tag">owasp.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://csrc.nist.gov/pubs/sp/800/30/r1/final" target="_blank"><div class="lab-card-body"><div class="lab-card-title">NIST SP 800-30 — Risk Assessment</div><div class="lab-card-tags"><span class="lab-tag">csrc.nist.gov</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gdpr-info.eu/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GDPR — General Data Protection Regulation</div><div class="lab-card-tags"><span class="lab-tag">gdpr-info.eu</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cwe.mitre.org/" target="_blank"><div class="lab-card-body"><div class="lab-card-title">CWE — Common Weakness Enumeration</div><div class="lab-card-tags"><span class="lab-tag">cwe.mitre.org</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://github.com/geminishkv/course_labs/blob/develop/artifacts/exmpls/Пример_аналитических_отчетов_по_задачам_ИБ.pdf" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Пример аналитических отчетов</div><div class="lab-card-tags"><span class="lab-tag">github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://gist.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">Gist</div><div class="lab-card-tags"><span class="lab-tag">gist.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
<a class="lab-card" href="https://cli.github.com" target="_blank"><div class="lab-card-body"><div class="lab-card-title">GitHub CLI</div><div class="lab-card-tags"><span class="lab-tag">cli.github.com</span></div></div><div class="lab-card-arrow">→</div></a>
</div>
