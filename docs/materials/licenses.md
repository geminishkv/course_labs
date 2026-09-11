---
title: "Лицензии Open Source — типы MIT, GPL, Apache, BSD для AppSec"
description: "Лицензии Open Source в AppSec: сравнение MIT, GPL, Apache, BSD, SSPL, BUSL — типы, ограничения и выбор для безопасной разработки."
keywords: "лицензии, open source, MIT, GPL, Apache, BSD, SSPL, BUSL, AppSec, DevSecOps, свободное ПО, SCA, license compliance, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">Лицензии ПО</h1>
    <p class="hero-sub">Типы и применение open-source лицензий</p>
  </div>
</div>

<div style="display:flex; align-items:flex-start; gap:0.65rem; padding:0.75rem 1rem; background:rgba(249,179,97,0.08); border-left:3px solid #F9B361; border-radius:0 6px 6px 0; margin-bottom:1.5rem; font-size:0.82rem; color:#7a5c10;">
  <span style="font-family:'Unbounded',sans-serif; font-size:0.62rem; font-weight:700; color:#c48a20; flex-shrink:0; padding-top:0.1rem;">NOTE</span>
  <span>Данная таблица носит <strong>справочный характер</strong> и не является юридической консультацией. Для принятия решений по лицензированию в продуктах и контрактах рекомендуется консультироваться с юристами.</span>
</div>

## Разрешительные (Permissive)

Позволяют использовать, модифицировать и распространять код практически без ограничений — в том числе в проприетарных продуктах. Требуется только сохранение уведомлений об авторских правах.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/license/mit/" style="color:#D51A1A; text-decoration:none;">MIT License</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Минимум ограничений: только сохранять уведомление об авторских правах. Самая популярная лицензия в экосистемах JavaScript, Python и других.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.apache.org/licenses/LICENSE-2.0" style="color:#D51A1A; text-decoration:none;">Apache License 2.0</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Можно использовать, модифицировать и распространять (в т.ч. в проприетарных продуктах) при сохранении уведомлений об авторских правах и NOTICE. Содержит патентную лицензию с отзывом при исках.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/license/bsd-2-clause/" style="color:#D51A1A; text-decoration:none;">BSD 2-Clause</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Практически любое использование при сохранении уведомления об авторских правах и отказа от ответственности. Близка к MIT.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/license/bsd-3-clause/" style="color:#D51A1A; text-decoration:none;">BSD 3-Clause</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">BSD‑2 плюс запрет использовать имена авторов для продвижения производных продуктов без явного разрешения.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/licenses/0BSD" style="color:#D51A1A; text-decoration:none;">BSD 0-Clause (0BSD)</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Максимально упрощённая BSD — фактически public domain с юридической обёрткой. Даже не требует сохранения копирайта.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/licenses/ISC" style="color:#D51A1A; text-decoration:none;">ISC License</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Упрощённый аналог MIT/BSD, широко используется в OpenBSD и npm-пакетах. Дефолтная лицензия npm init.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.boost.org/users/license.html" style="color:#D51A1A; text-decoration:none;">Boost Software License 1.0</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Для библиотеки Boost C++. Совместима с открытыми и закрытыми проектами, минимум требований.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.postgresql.org/about/licence/" style="color:#D51A1A; text-decoration:none;">PostgreSQL License</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Разрешительная лицензия СУБД PostgreSQL, аналог BSD/MIT. Используется одной из самых популярных СУБД в мире.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/licenses/Zlib" style="color:#D51A1A; text-decoration:none;">zlib License</a></div>
  <span class="lab-tag">Свободное ПО · разрешительная</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Разрешительная лицензия для библиотек сжатия и игровых движков. Запрещает только ложное авторство.</p>
  </div>

</div>

***

## Слабый копилефт (Weak Copyleft)

Изменения в файлах/библиотеке под лицензией должны оставаться открытыми, но основной проект может быть проприетарным. Удобно для библиотек и плагинных архитектур.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.gnu.org/licenses/lgpl-3.0.en.html" style="color:#D51A1A; text-decoration:none;">GNU LGPL v3.0</a></div>
  <span class="lab-tag">Свободное ПО · слабый копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">«Мягкая» GPL для библиотек: позволяет связывать с проприетарным ПО без распространения GPL на всё приложение.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html" style="color:#D51A1A; text-decoration:none;">GNU LGPL v2.1</a></div>
  <span class="lab-tag">Свободное ПО · слабый копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Старая версия LGPL, широко используемая в библиотеках C/C++. Разрешает связывание с проприетарным ПО при возможности замены библиотеки.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.mozilla.org/en-US/MPL/2.0/" style="color:#D51A1A; text-decoration:none;">Mozilla Public License 2.0</a></div>
  <span class="lab-tag">Свободное ПО · файловый копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Изменения в файлах под MPL остаются под MPL, но проект в целом может иметь смешанную лицензию. Firefox, Thunderbird.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.eclipse.org/legal/epl-2.0/" style="color:#D51A1A; text-decoration:none;">Eclipse Public License 2.0</a></div>
  <span class="lab-tag">Свободное ПО · слабый копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Изменения исходников под EPL остаются под EPL, но возможна комбинация с проприетарными модулями. Eclipse IDE.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/licenses/CDDL-1.0" style="color:#D51A1A; text-decoration:none;">CDDL 1.0</a></div>
  <span class="lab-tag">Свободное ПО · слабый копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Common Development and Distribution License от Sun/Oracle. Используется в ZFS и illumos. Не совместима с GPL.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://eupl.eu/" style="color:#D51A1A; text-decoration:none;">EUPL 1.2</a></div>
  <span class="lab-tag">Свободное ПО · копилефт ЕС</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">European Union Public License — совместима с GPL/LGPL/MPL. Мультиязычная, содержит SaaS-триггер. Используется в европейских госпроектах.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.eclipse.org/legal/cpl-v10.html" style="color:#D51A1A; text-decoration:none;">Common Public License 1.0</a></div>
  <span class="lab-tag">Свободное ПО · слабый копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Предшественник EPL (IBM/Eclipse). Требует CPL для модификаций, но допускает комбинацию с проприетарным кодом. Заменяется на EPL‑2.0.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/license/artistic-2-0/" style="color:#D51A1A; text-decoration:none;">Artistic License 2.0</a></div>
  <span class="lab-tag">Свободное ПО</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Связана с Perl. Комбинирует разрешительные и копилефт‑подходы, совместима с GPL.</p>
  </div>

</div>

***

## Сильный копилефт (Strong Copyleft)

Производные работы обязаны распространяться под той же лицензией с предоставлением исходного кода. Самый строгий тип — «вирусный» эффект на весь проект.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.gnu.org/licenses/gpl-3.0.en.html" style="color:#D51A1A; text-decoration:none;">GNU GPL v3.0</a></div>
  <span class="lab-tag">Свободное ПО · сильный копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Производные работы должны распространяться под GPL с предоставлением исходного кода. Включает защиту от патентных ловушек и DRM.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html" style="color:#D51A1A; text-decoration:none;">GNU GPL v2.0</a></div>
  <span class="lab-tag">Свободное ПО · сильный копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Ранняя версия GPL с той же идеей копилефта, без уточнений v3 в части патентов и аппаратных ограничений. Linux kernel.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opensource.org/licenses/OSL-3.0" style="color:#D51A1A; text-decoration:none;">OSL 3.0</a></div>
  <span class="lab-tag">Свободное ПО · сильный копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Open Software License — сильный копилефт с патентным грантом и SaaS-триггером. Используется в Magento 2.</p>
  </div>

</div>

***

## Сетевой копилефт (Network Copyleft)

Закрывает «SaaS-дыру»: предоставление ПО через сеть считается распространением — пользователи должны получить исходный код.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.gnu.org/licenses/agpl-3.0.en.html" style="color:#D51A1A; text-decoration:none;">GNU AGPL v3.0</a></div>
  <span class="lab-tag">Свободное ПО · сетевой копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">При использовании через сеть пользователи должны получать исходный код. Для серверных приложений: Nextcloud, Grafana (до v10).</p>
  </div>

</div>

***

## Общественное достояние (Public Domain)

Автор максимально отказывается от авторских прав. Минимум юридических ограничений.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; color:#1A1919; margin-bottom:0.1rem;">The Unlicense</div>
  <span class="lab-tag">Свободное ПО · публичное достояние</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Автор максимально возможным образом передаёт работу в общественное достояние. Не во всех юрисдикциях трактуется однозначно.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://creativecommons.org/publicdomain/zero/1.0/" style="color:#D51A1A; text-decoration:none;">CC0 1.0</a></div>
  <span class="lab-tag">Общественное достояние</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Creative Commons: автор отказывается от максимального набора прав. Используется для данных, документации, примеров и не‑кода.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.sqlite.org/copyright.html" style="color:#D51A1A; text-decoration:none;">SQLite Blessing</a></div>
  <span class="lab-tag">Public domain</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Уникальная «антилицензия» SQLite — благословение вместо лицензии. Код передан в public domain. Самая встраиваемая СУБД в мире.</p>
  </div>

</div>

***

## Creative Commons (для документации и данных)

Семейство лицензий для нон-кода: документация, наборы данных, изображения, обучающие материалы. Не рекомендуются для программного кода.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://creativecommons.org/licenses/by/4.0/" style="color:#D51A1A; text-decoration:none;">CC BY 4.0</a></div>
  <span class="lab-tag">Свободное · указание авторства</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Свободное использование (в т.ч. коммерческое) с указанием авторства. Самая открытая CC-лицензия.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://creativecommons.org/licenses/by-sa/4.0/" style="color:#D51A1A; text-decoration:none;">CC BY-SA 4.0</a></div>
  <span class="lab-tag">Свободное · копилефт для контента</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Как CC BY, но производные работы — под той же лицензией. Wikipedia использует CC BY-SA.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://creativecommons.org/licenses/by-nc/4.0/" style="color:#D51A1A; text-decoration:none;">CC BY-NC 4.0</a></div>
  <span class="lab-tag">Некоммерческое · указание авторства</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Только некоммерческое использование с указанием авторства. Часто используется для обучающих материалов.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://creativecommons.org/licenses/by-nd/4.0/" style="color:#D51A1A; text-decoration:none;">CC BY-ND 4.0</a></div>
  <span class="lab-tag">Без производных · указание авторства</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Указание авторства, но запрет на производные работы. Для контента, который нельзя модифицировать.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://creativecommons.org/licenses/by-nc-sa/4.0/" style="color:#D51A1A; text-decoration:none;">CC BY-NC-SA 4.0</a></div>
  <span class="lab-tag">Некоммерческое · копилефт</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Некоммерческое + копилефт для производных работ. Популярна для научных публикаций.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://creativecommons.org/licenses/by-nc-nd/4.0/" style="color:#D51A1A; text-decoration:none;">CC BY-NC-ND 4.0</a></div>
  <span class="lab-tag">Самая строгая CC</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Некоммерческое, без изменений, с авторством — самая ограничительная Creative Commons лицензия.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://opendatacommons.org/licenses/odbl/1-0/" style="color:#D51A1A; text-decoration:none;">ODbL 1.0</a></div>
  <span class="lab-tag">Копилефт для баз данных</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Open Database License — копилефт специально для баз данных. Используется в OpenStreetMap.</p>
  </div>

  <div class="lab-card" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.gnu.org/licenses/fdl-1.3.html" style="color:#D51A1A; text-decoration:none;">GNU FDL 1.3</a></div>
  <span class="lab-tag">Копилефт для документации</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">GNU Free Documentation License — копилефт для документации. Используется в man-страницах GNU и ряде wiki-проектов.</p>
  </div>

</div>

***

## Source-Available и проприетарные

Исходный код доступен, но с ограничениями использования. Не признаются OSI как Open Source. Часто запрещают конкурирующее SaaS-использование.

<div class="lab-grid" style="grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));">

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; color:#1A1919; margin-bottom:0.1rem;">SSPL (Server Side Public License)</div>
  <span class="lab-tag lab-tag--gold">Проприетарное ПО · условно свободное</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Формально на базе GPL, но с ограничениями для SaaS. Не признаётся OSI. MongoDB.</p>
  </div>

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; color:#1A1919; margin-bottom:0.1rem;">BUSL (Business Source License)</div>
  <span class="lab-tag lab-tag--gold">Проприетарное ПО · исходники доступны</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Исходники доступны, но использование ограничено. Через N лет автоматически переходит под OSS‑лицензию. HashiCorp (Terraform, Vault).</p>
  </div>

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://www.elastic.co/licensing/elastic-license" style="color:var(--brand-gold-dark); text-decoration:none;">Elastic License 2.0</a></div>
  <span class="lab-tag lab-tag--gold">Source-available · запрет SaaS</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Разрешает всё, кроме предоставления как управляемого сервиса. Elasticsearch, Kibana. Причина появления форка OpenSearch.</p>
  </div>

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://fsl.software/" style="color:var(--brand-gold-dark); text-decoration:none;">FSL (Functional Source License)</a></div>
  <span class="lab-tag lab-tag--gold">Source-available · автопереход в OSS</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Source-available с автоматическим переходом в Apache/MIT через 2 года. Sentry, GitButler. Новый тренд.</p>
  </div>

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://redis.io/legal/licenses/" style="color:var(--brand-gold-dark); text-decoration:none;">Redis RSALv2</a></div>
  <span class="lab-tag lab-tag--gold">Source-available · двойная лицензия</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Двойная RSALv2/SSPL для модулей Redis, запрещает конкурирующие сервисы. Причина появления форка Valkey.</p>
  </div>

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://commonsclause.com/" style="color:var(--brand-gold-dark); text-decoration:none;">Commons Clause</a></div>
  <span class="lab-tag lab-tag--gold">Надстройка · запрет продажи</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Дополнение к любой OSS-лицензии, запрещающее продажу ПО. Меняет суть базовой лицензии — делает её non-OSS.</p>
  </div>

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://polyformproject.org/licenses/shield/1.0.0" style="color:var(--brand-gold-dark); text-decoration:none;">Polyform Shield 1.0</a></div>
  <span class="lab-tag lab-tag--gold">Source-available · запрет конкуренции</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Source-available, запрещает конкурирующее использование. Набирает популярность среди SaaS-вендоров.</p>
  </div>

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; margin-bottom:0.1rem;"><a href="https://polyformproject.org/licenses/noncommercial/1.0.0" style="color:var(--brand-gold-dark); text-decoration:none;">Polyform Noncommercial 1.0</a></div>
  <span class="lab-tag lab-tag--gold">Source-available · только некоммерческое</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">Source-available, запрещает коммерческое использование. Альтернатива CC BY-NC для кода.</p>
  </div>

  <div class="lab-card lab-card--gold" style="flex-direction: column; align-items: flex-start; gap: 0.45rem;">
  <div style="font-size:0.82rem; font-weight:700; color:#1A1919; margin-bottom:0.1rem;">Custom / Vendor License</div>
  <span class="lab-tag lab-tag--gold">Проприетарное ПО</span>
  <p style="font-size:0.75rem; margin:0.2rem 0 0; color:#555; line-height:1.5;">EULA и коммерческие лицензии вендора. Условия определяются договором и, как правило, не соответствуют Open Source Definition.</p>
  </div>

</div>
