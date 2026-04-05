import hashlib
import os
import secrets
import sqlite3

from flask import (
    Flask,
    make_response,
    redirect,
    render_template_string,
    request,
    url_for,
)
from markupsafe import escape

app = Flask(__name__)
app.config["SECRET_KEY"] = secrets.token_hex(32)  # Для подписи сессий

DB_PATH = os.environ.get("APP_DB_PATH", "app.db")

# Хранилище сессий (в production использовать Redis или БД)
sessions = {}


def set_secure_cookie(resp, name, value, max_age=3600):
    """Установка безопасного cookie с флагами HttpOnly, Secure, SameSite"""
    resp.set_cookie(
        name,
        value,
        max_age=max_age,
        httponly=True,
        secure=False,  # True для HTTPS
        samesite="Lax",
    )


@app.after_request
def set_security_headers(response):
    """Установка security headers для всех ответов"""
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-Frame-Options"] = "DENY"
    response.headers["X-XSS-Protection"] = "1; mode=block"
    response.headers["Content-Security-Policy"] = (
        "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'"
    )
    response.headers["Permissions-Policy"] = "geolocation=(), microphone=(), camera=()"
    # Скрываем версию сервера
    response.headers["Server"] = "WebServer"
    return response


def init_db():
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    cur.execute(
        """
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT,
            role TEXT
        )
        """
    )
    cur.execute("DELETE FROM users")
    cur.execute(
        "INSERT INTO users (username, password, role) VALUES ('admin', 'admin123', 'admin')"
    )
    cur.execute(
        "INSERT INTO users (username, password, role) VALUES ('user', 'user123', 'user')"
    )
    conn.commit()
    conn.close()


@app.route("/")
def index():
    html = """
    <h1>Vulnerable DAST Demo App</h1>
    <p>Пример уязвимого приложения для лабораторной по DAST.</p>
    <ul>
      <li><a href="/echo?msg=Hello">Reflected XSS / echo</a></li>
      <li><a href="/search?username=admin">SQL Injection / search</a></li>
      <li><a href="/login">Небезопасный логин</a></li>
      <li><a href="/profile">Профиль (зависит от cookie)</a></li>
      <li><a href="/admin">«Админка» без нормальной авторизации</a></li>
      <li><a href="/files/">Directory listing</a></li>
    </ul>
    """
    resp = make_response(html)
    set_secure_cookie(resp, "session", "guest-session-id")
    return resp


@app.route("/echo")
def echo():
    msg = request.args.get("msg", "")
    # Экранирование HTML для предотвращения XSS
    msg_escaped = escape(msg)
    template = """
    <h2>Echo</h2>
    <p>Сообщение: {{ msg }}</p>
    <p>Попробуйте передать что-нибудь вроде: <code>&lt;script&gt;alert('XSS')&lt;/script&gt;</code></p>
    <a href="/">Назад</a>
    """
    return render_template_string(template, msg=msg_escaped)


@app.route("/search")
def search():
    username = request.args.get("username", "")
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    # Параметризованный запрос для предотвращения SQL Injection
    rows = []
    try:
        cur.execute(
            "SELECT id, username, role FROM users WHERE username = ?", (username,)
        )
        rows = cur.fetchall()
    except Exception:
        # Не раскрываем детали SQL ошибок
        pass

    conn.close()

    template = """
    <h2>Поиск пользователя</h2>
    {% if rows %}
      <ul>
      {% for id, username, role in rows %}
        <li>{{ id }} – {{ username }} ({{ role }})</li>
      {% endfor %}
      </ul>
    {% else %}
      <p>Ничего не найдено</p>
    {% endif %}
    <a href="/">Назад</a>
    """
    return render_template_string(template, rows=rows)


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "GET":
        form = """
        <h2>Логин</h2>
        <form method="post">
          <label>Username: <input type="text" name="username"></label><br>
          <label>Password: <input type="password" name="password"></label><br>
          <button type="submit">Login</button>
        </form>
        <p>Попробуйте: admin / admin123 или user / user123</p>
        <a href="/">Назад</a>
        """
        return render_template_string(form)

    username = request.form.get("username", "")
    password = request.form.get("password", "")

    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    # Параметризованный запрос для предотвращения SQL Injection
    cur.execute(
        "SELECT id, username, role FROM users WHERE username = ? AND password = ?",
        (username, password),
    )
    row = cur.fetchone()
    conn.close()

    if row:
        _, uname, role = row
        # Создаем безопасную сессию
        session_id = secrets.token_urlsafe(32)
        sessions[session_id] = {"user": uname, "role": role}

        resp = make_response(
            f"<h2>Добро пожаловать, {escape(uname)} ({escape(role)})!</h2><a href='/'>На главную</a>"
        )

        set_secure_cookie(resp, "session_id", session_id)
        return resp
    else:
        return render_template_string(
            "<h2>Неверные учетные данные</h2><a href='/login'>Попробовать снова</a>"
        )


@app.route("/profile")
def profile():
    # Проверка сессии вместо прямого чтения cookie
    session_id = request.cookies.get("session_id")
    if session_id and session_id in sessions:
        session_data = sessions[session_id]
        username = session_data.get("user", "guest")
        role = session_data.get("role", "guest")
    else:
        username = "guest"
        role = "guest"

    template = """
    <h2>Профиль пользователя</h2>
    <p>Имя: {{ username }}</p>
    <p>Роль: {{ role }}</p>
    <a href="/">Назад</a>
    """
    return render_template_string(
        template, username=escape(username), role=escape(role)
    )


@app.route("/admin")
def admin():
    # Проверка сессии вместо прямого чтения cookie
    session_id = request.cookies.get("session_id")
    if not session_id or session_id not in sessions:
        return (
            "<h2>Доступ запрещён: требуется авторизация</h2><a href='/login'>Войти</a>",
            403,
        )

    session_data = sessions[session_id]
    role = session_data.get("role", "guest")

    if role != "admin":
        return (
            "<h2>Доступ запрещён: недостаточно прав</h2><a href='/'>Назад</a>",
            403,
        )

    template = """
    <h2>Admin panel</h2>
    <p>Секретные настройки приложения (демо).</p>
    <ul>
      <li>DEBUG: true</li>
      <li>FEATURE_FLAG: experimental_mode</li>
    </ul>
    <a href="/">Назад</a>
    """
    return render_template_string(template)


@app.route("/files/")
@app.route("/files/<path:subpath>")
def files(subpath=""):
    # Ограничение доступа к файлам
    base_dir = os.path.abspath(os.path.dirname(__file__))
    target_dir = os.path.join(base_dir, "files")

    # Нормализация пути для предотвращения path traversal
    full_path = os.path.normpath(os.path.join(target_dir, subpath))

    # Проверка, что путь находится внутри разрешенной директории
    if not full_path.startswith(os.path.abspath(target_dir)):
        return "<h2>Доступ запрещён</h2><a href='/'>Назад</a>", 403

    if not os.path.exists(full_path):
        return "<h2>Путь не найден</h2><a href='/'>Назад</a>", 404

    # Отключен directory listing для безопасности
    if os.path.isdir(full_path):
        return "<h2>Directory listing отключен</h2><a href='/'>Назад</a>", 403

    # Разрешенные расширения файлов
    allowed_extensions = {".txt", ".md", ".json"}
    if not any(full_path.endswith(ext) for ext in allowed_extensions):
        return "<h2>Тип файла не разрешен</h2><a href='/'>Назад</a>", 403

    try:
        with open(full_path, encoding="utf-8", errors="ignore") as f:
            content = f.read()
        return f"<pre>{escape(content)}</pre>"
    except Exception:
        return "<h2>Ошибка чтения файла</h2><a href='/'>Назад</a>", 500


if __name__ == "__main__":
    init_db()
    # Отключен debug режим в production
    app.run(host="0.0.0.0", port=8080, debug=False)  # nosec B201,B104
