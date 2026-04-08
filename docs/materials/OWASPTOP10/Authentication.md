---
title: "Authentication — OWASP | Курс AppSec"
description: "OWASP Top 10 аутентификация: слабые пароли, отсутствие MFA, перехват сессий — уязвимости и методы защиты веб-приложений."
keywords: "OWASP, аутентификация, authentication, AppSec, MFA, безопасность, сессии, пароли, brute force, broken authentication, веб-безопасность, Шмаков Илья, Elijah Shmakov, geminishkv, AppSecTA"
---

<div class="hero-section hero-section--compact">
  <div class="hero-content">
    <h1 class="hero-title">OWASP — Authentication</h1>
    <p class="hero-sub">Нарушения аутентификации · OWASP Top 10</p>
  </div>
</div>

## О документе

Нарушения аутентификации (Broken Authentication) входят в OWASP Top 10 и возникают, когда приложение некорректно реализует механизмы проверки личности пользователя. Типичные проблемы: использование слабых или предсказуемых паролей, отсутствие многофакторной аутентификации (MFA), небезопасное хранение учётных данных и уязвимости механизма восстановления пароля.

Атакующий, эксплуатирующий данную уязвимость, получает доступ к аккаунтам легитимных пользователей или административным интерфейсам. Особенно опасны атаки credential stuffing, brute-force и session fixation, когда отсутствует ограничение количества попыток входа или ротация идентификатора сессии после аутентификации.

Данный материал связан с [лабораторной работой №8 (DAST)](../../labs/basic/lab08.md), где OWASP ZAP проверяет реализацию аутентификации в тестовом приложении, а также с [лабораторной работой №9](../../labs/basic/lab09.md), где проверки встраиваются в CI/CD. Смотри также: [Authorization](Authorization.md).

***

## Содержание документа

Раздел, посвященный аутентификации описывает атаки, направленные на используемые Web-приложением методы проверки идентификатора пользователя, службы или приложения. Аутентификация использует как минимум один из трех механизмов (факторов): "что-то, что мы имеем", "что-то, что мы знаем" или "что-то, что мы есть". В этом разделе описываются атаки, направленные на обход или эксплуатацию уязвимостей в механизмах реализации аутентификации Web-серверов.

### Подбор (Brute Force)

Подбор -- автоматизированный процесс проб и ошибок, использующийся для того, чтобы угадать имя пользователя, пароль, номер кредитной карточки, ключ шифрования и т.д.

Многие системы позволяют использовать слабые пароли или ключи шифрования, и пользователи часто выбирают легко угадываемые или содержащиеся в словарях парольные фразы.

Используя эту ситуацию, злоумышленник может воспользоваться словарем и попытаться использовать тысячи или даже миллионы содержащихся в нем комбинаций символов в качестве пароля. Если испытуемый пароль позволяет получить доступ к системе, атака считается успешной и атакующий может использовать учетную запись.

Подобная техника проб и ошибок может быть использована для подбора ключей шифрования. В случае использования сервером ключей недостаточной длины, злоумышленник может получить используемый ключ, протестировав все возможные комбинации.

Существует два вида подбора: **прямой** и **обратный**. При прямом подборе используются различные варианты пароля для одного имени пользователя. При обратном -- перебираются различные имена пользователей, а пароль остается неизменным. В системах с миллионами учетных записей вероятность использования различными пользователями одного пароля довольно высока. Несмотря на популярность и высокую эффективность, подбор может занимать несколько часов, дней или лет.

!!! example "Пример: прямой и обратный подбор"

    **Прямой подбор** -- перебор паролей для одного пользователя:

    ```
    Имя пользователя = Jon
    Пароли = smith, michael-jordan, [pet names], [birthdays], [car names], ...
    ```

    **Обратный подбор** -- перебор пользователей с одним паролем:

    ```
    Имена пользователей = Jon, Dan, Ed, Sara, Barbara, ...
    Пароль = 12345678
    ```

!!! warning "Внимание"

    Без ограничения количества попыток входа атакующий может автоматизировать подбор и перебрать миллионы комбинаций за короткое время. Обязательно применяйте rate limiting и account lockout.

#### Практический пример: защита от Brute Force

=== "Уязвимый код"

    ```javascript
    const express = require("express");
    const app = express();

    app.use(express.json());

    // Эндпоинт входа без какой-либо защиты от перебора
    app.post("/login", (req, res) => {
      const { username, password } = req.body;

      const user = findUser(username);
      if (user && user.password === password) {
        return res.json({ success: true, token: generateToken(user) });
      }

      return res.status(401).json({ error: "Invalid credentials" });
    });
    ```

=== "Защищённый код"

    ```javascript
    const express = require("express");
    const rateLimit = require("express-rate-limit");
    const app = express();

    app.use(express.json());

    // Rate limiter: максимум 5 попыток входа за 15 минут с одного IP
    const loginLimiter = rateLimit({
      windowMs: 15 * 60 * 1000, // 15 минут
      max: 5,                   // лимит попыток
      message: { error: "Too many login attempts, please try again later" },
      standardHeaders: true,
      legacyHeaders: false,
    });

    // Дополнительно: отслеживание неудачных попыток по аккаунту
    const failedAttempts = new Map();
    const LOCKOUT_THRESHOLD = 5;
    const LOCKOUT_DURATION_MS = 30 * 60 * 1000; // 30 минут

    app.post("/login", loginLimiter, async (req, res) => {
      const { username, password } = req.body;

      // Проверка блокировки аккаунта
      const attempts = failedAttempts.get(username);
      if (attempts && attempts.count >= LOCKOUT_THRESHOLD) {
        const elapsed = Date.now() - attempts.lastAttempt;
        if (elapsed < LOCKOUT_DURATION_MS) {
          return res.status(423).json({
            error: "Account temporarily locked due to multiple failed attempts",
          });
        }
        failedAttempts.delete(username);
      }

      const user = await findUser(username);
      const isValid = user && (await bcrypt.compare(password, user.passwordHash));

      if (!isValid) {
        // Инкрементируем счётчик неудачных попыток
        const current = failedAttempts.get(username) || { count: 0 };
        failedAttempts.set(username, {
          count: current.count + 1,
          lastAttempt: Date.now(),
        });
        return res.status(401).json({ error: "Invalid credentials" });
      }

      // Сброс счётчика при успешном входе
      failedAttempts.delete(username);
      return res.json({ success: true, token: generateToken(user) });
    });
    ```

!!! info "Ссылки"

    - [OWASP Brute Force Attack](https://owasp.org/www-community/attacks/Brute_force_attack)
    - [OWASP Testing for Brute Force](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/04-Authentication_Testing/04-Testing_for_Brute_Force)

### Недостаточная аутентификация (Insufficient Authentication)

Эта уязвимость возникает, когда Web-сервер позволяет атакующему получать доступ к важной информации или функциям сервера без должной аутентификации. Интерфейсы администрирования через Web -- яркий пример критичных систем.

В зависимости от специфики приложения, подобные компоненты не должны быть доступны без должной аутентификации. Чтобы не использовать аутентификацию некоторые ресурсы "прячутся" по определенному адресу, который не указан на основных страницах сервера или других общедоступных ресурсах. Однако, подобный подход не более чем "безопасность через сокрытие". Важно понимать, что, несмотря на то, что злоумышленник не знает адреса страницы, она все равно доступна через Web.

Необходимый URL может быть найден перебором типичных файлов и директорий (таких как `/admin/`), с использованием сообщений об ошибках, журналов перекрестных ссылок или путем простого чтения документации. Подобные ресурсы должны быть защищены адекватно важности их содержимого и функциональных возможностей.

!!! example "Пример: скрытая административная панель"

    Многие Web-приложения по умолчанию используют для административного доступа ссылку в корневой директории сервера (`/admin/`). Обычно ссылка на эту страницу не фигурирует в содержимом сервера, однако страница доступна с помощью стандартного браузера. Поскольку пользователь или разработчик предполагает, что никто не воспользуется этой страницей, так как ссылки на нее отсутствуют, зачастую реализацией аутентификации пренебрегают. И для получения контроля над сервером злоумышленнику достаточно зайти на эту страницу.

#### Практический пример: защита маршрутов middleware

=== "Уязвимый код"

    ```javascript
    const express = require("express");
    const app = express();

    // Административная панель без аутентификации --
    // "безопасность через сокрытие" (security by obscurity)
    app.get("/super-secret-admin-panel", (req, res) => {
      const users = getAllUsers();
      const config = getSystemConfig();
      res.json({ users, config });
    });

    app.delete("/super-secret-admin-panel/users/:id", (req, res) => {
      deleteUser(req.params.id);
      res.json({ success: true });
    });
    ```

=== "Защищённый код"

    ```javascript
    const express = require("express");
    const jwt = require("jsonwebtoken");
    const app = express();

    // Middleware аутентификации -- проверяет наличие и валидность JWT
    function authenticate(req, res, next) {
      const token = req.headers.authorization?.split(" ")[1];
      if (!token) {
        return res.status(401).json({ error: "Authentication required" });
      }
      try {
        req.user = jwt.verify(token, process.env.JWT_SECRET);
        next();
      } catch {
        return res.status(401).json({ error: "Invalid or expired token" });
      }
    }

    // Middleware авторизации -- проверяет роль пользователя
    function requireRole(role) {
      return (req, res, next) => {
        if (req.user.role !== role) {
          return res.status(403).json({ error: "Insufficient permissions" });
        }
        next();
      };
    }

    // Все маршруты /admin защищены аутентификацией + проверкой роли
    app.get("/admin/users", authenticate, requireRole("admin"), (req, res) => {
      const users = getAllUsers();
      res.json({ users });
    });

    app.delete(
      "/admin/users/:id",
      authenticate,
      requireRole("admin"),
      (req, res) => {
        deleteUser(req.params.id);
        res.json({ success: true });
      }
    );
    ```

!!! info "Ссылки"

    - [OWASP Broken Access Control](https://owasp.org/Top10/A01_2021-Broken_Access_Control/)
    - [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)

### Небезопасное восстановление паролей (Weak Password Recovery Validation)

Эта уязвимость возникает, когда Web-сервер позволяет атакующему несанкционированно получать, модифицировать или восстанавливать пароли других пользователей.

Часто аутентификация на Web-сервере требует от пользователя запоминания пароля или парольной фразы. Только пользователь должен знать пароль, причем помнить его отчетливо. Со временем пароль забывается. Ситуация усложняется, поскольку в среднем пользователь посещает около 20 сайтов, требующих ввода пароля. Таким образом, функция восстановления пароля является важной составляющей предоставляемой Web-серверами сервиса.

Примером реализации подобной функции является использование "секретного вопроса", ответ на который указывается в процессе регистрации. Вопрос либо выбирается из списка или вводится самим пользователем. Еще один механизм позволяет пользователю указать "подсказку", которая поможет ему вспомнить пароль. Другие способы требуют от пользователя указать часть персональных данных, таких как номер соц. страхования, ИНН, домашний адрес, почтовый индекс и т.д., которые затем будут использоваться для установления личности.

Уязвимости, связанные с недостаточной проверкой при восстановлении пароля, возникают, когда атакующий получает возможность обойти используемый механизм. Это случается, когда информацию, используемую для проверки пользователя, легко угадать или сам процесс подтверждения можно обойти. Система восстановления пароля может быть скомпрометирована путем использования подбора, уязвимостей системы или из-за легко угадываемого ответа на секретный вопрос.

!!! example "Пример: проверка информации"

    Многие серверы требуют от пользователя указать его e-mail в комбинации с домашним адресом и номером телефона. Эта информация может быть легко получена из сетевых справочников. В результате, данные, используемые для проверки, не являются большим секретом. Кроме того, эта информация может быть получена злоумышленником с использованием других методов, таких как Cross-Site Scripting или фишинг (Phishing).

!!! example "Пример: парольные подсказки"

    Сервер, использующий подсказки для облегчения запоминания паролей, может быть атакован, поскольку подсказки помогают в реализации подбора паролей. Пользователь может использовать стойкий пароль, например, `221277King` с соответствующей подсказкой: "д-р+люб писатель". Атакующий может заключить, что пользовательский пароль состоит из даты рождения и имени любимого автора пользователя. Это помогает сформировать относительно короткий словарь для атаки путём перебора.

!!! example "Пример: секретный вопрос и ответ"

    Предположим, ответ пользователя "Бобруйск", а секретный вопрос "Место рождения". Злоумышленник может ограничить словарь для подбора секретного ответа названиями городов. Более того, если атакующий располагает некоторой информацией о пользователе, узнать его место рождения несложно.

#### Практический пример: генерация токена восстановления пароля

=== "Уязвимый код"

    ```javascript
    const express = require("express");
    const app = express();

    app.use(express.json());

    // Предсказуемый токен на основе timestamp + userId --
    // атакующий может подобрать или вычислить токен
    app.post("/forgot-password", async (req, res) => {
      const { email } = req.body;
      const user = await findUserByEmail(email);

      if (!user) {
        // Утечка информации: раскрывает, существует ли аккаунт
        return res.status(404).json({ error: "User not found" });
      }

      // Предсказуемый токен!
      const resetToken = Buffer.from(`${user.id}-${Date.now()}`).toString("base64");

      // Токен без срока действия
      await saveResetToken(user.id, resetToken);
      await sendEmail(email, `Reset link: https://example.com/reset?token=${resetToken}`);

      return res.json({ success: true });
    });

    app.post("/reset-password", async (req, res) => {
      const { token, newPassword } = req.body;
      const record = await findResetToken(token);

      if (!record) {
        return res.status(400).json({ error: "Invalid token" });
      }

      // Нет проверки срока действия токена
      // Нет проверки сложности нового пароля
      await updatePassword(record.userId, newPassword);
      // Токен остаётся валидным и может быть использован повторно!

      return res.json({ success: true });
    });
    ```

=== "Защищённый код"

    ```javascript
    const express = require("express");
    const crypto = require("crypto");
    const bcrypt = require("bcrypt");
    const app = express();

    app.use(express.json());

    const TOKEN_EXPIRY_MS = 60 * 60 * 1000; // 1 час

    app.post("/forgot-password", async (req, res) => {
      const { email } = req.body;
      const user = await findUserByEmail(email);

      // Единый ответ независимо от существования аккаунта --
      // предотвращает перечисление пользователей (user enumeration)
      if (!user) {
        return res.json({
          message: "If this email exists, a reset link has been sent",
        });
      }

      // Криптографически стойкий случайный токен
      const resetToken = crypto.randomBytes(32).toString("hex");

      // Хэшируем токен перед сохранением в БД --
      // даже при утечке базы атакующий не получит рабочие токены
      const tokenHash = crypto
        .createHash("sha256")
        .update(resetToken)
        .digest("hex");

      await saveResetToken(user.id, tokenHash, Date.now() + TOKEN_EXPIRY_MS);
      await sendEmail(
        email,
        `Reset link: https://example.com/reset?token=${resetToken}`
      );

      return res.json({
        message: "If this email exists, a reset link has been sent",
      });
    });

    app.post("/reset-password", async (req, res) => {
      const { token, newPassword } = req.body;

      // Хэшируем полученный токен для сравнения с БД
      const tokenHash = crypto
        .createHash("sha256")
        .update(token)
        .digest("hex");

      const record = await findResetToken(tokenHash);

      if (!record) {
        return res.status(400).json({ error: "Invalid or expired token" });
      }

      // Проверка срока действия
      if (Date.now() > record.expiresAt) {
        await deleteResetToken(tokenHash);
        return res.status(400).json({ error: "Invalid or expired token" });
      }

      // Проверка сложности пароля
      if (newPassword.length < 12) {
        return res
          .status(400)
          .json({ error: "Password must be at least 12 characters" });
      }

      const passwordHash = await bcrypt.hash(newPassword, 12);
      await updatePassword(record.userId, passwordHash);

      // Однократное использование: удаляем токен после сброса
      await deleteResetToken(tokenHash);

      // Инвалидируем все активные сессии пользователя
      await invalidateAllSessions(record.userId);

      return res.json({ success: true });
    });
    ```

!!! info "Ссылки"

    - [OWASP Forgot Password Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Forgot_Password_Cheat_Sheet.html)
    - [OWASP Testing for Weak Password Recovery](https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/04-Authentication_Testing/09-Testing_for_Weak_Password_Change_or_Reset_Functionalities)
