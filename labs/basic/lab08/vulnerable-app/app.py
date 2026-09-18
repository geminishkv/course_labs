from flask import (
    Flask,
    request,
    make_response,
    render_template_string,
    redirect,
    url_for,
)
import sqlite3
import os

app = Flask(__name__)

DB_PATH = os.environ.get("APP_DB_PATH", "app.db")


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
    resp.set_cookie("session", "guest-session-id")
    return resp


@app.route("/echo")
def echo():
    msg = request.args.get("msg", "")
    template = """
    <h2>Echo</h2>
    <p>Сообщение: {msg}</p>
    <p>Попробуйте передать что-нибудь вроде: <code>&lt;script&gt;alert('XSS')&lt;/script&gt;</code></p>
    <a href="/">Назад</a>
    """.format(msg=msg)
    return render_template_string(template)


@app.route("/search")
def search():
    username = request.args.get("username", "")
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    query = f"SELECT id, username, role FROM users WHERE username = '{username}'"  # nosec B608
    rows = []
    error = None
    try:
        for row in cur.execute(query):
            rows.append(row)
    except Exception as e:
        error = str(e)

    conn.close()

    template = """
    <h2>Поиск пользователя</h2>
    <p>Запрос: <code>{{ query }}</code></p>
    {% if error %}
      <p style="color:red;">SQL error: {{ error }}</p>
    {% endif %}
    {% if rows %}
      <ul>
      {% for id, username, role in rows %}
        <li>{{ id }} – {{ username }} ({{ role }})</li>
      {% endfor %}
      </ul>
    {% else %}
      <p>Ничего не найдено</p>
    {% endif %}
    <p>Попробуйте, например: <code>?username=admin' OR '1'='1</code></p>
    <a href="/">Назад</a>
    """
    return render_template_string(template, query=query, rows=rows, error=error)


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

    query = f"SELECT id, username, role FROM users WHERE username = '{username}' AND password = '{password}'"  # nosec B608
    row = cur.execute(query).fetchone()
    conn.close()

    if row:
        _, uname, role = row
        resp = make_response(
            f"<h2>Добро пожаловать, {uname} ({role})!</h2><a href='/'>На главную</a>"
        )

        resp.set_cookie("user", uname)
        resp.set_cookie("role", role)
        return resp
    else:
        return render_template_string(
            "<h2>Неверные учетные данные</h2><a href='/login'>Попробовать снова</a>"
        )


@app.route("/profile")
def profile():
    username = request.cookies.get("user", "guest")
    role = request.cookies.get("role", "guest")

    template = """
    <h2>Профиль пользователя</h2>
    <p>Имя: {{ username }}</p>
    <p>Роль: {{ role }}</p>
    <p>Cookie легко подделать: можно выдать себе роль 'admin'.</p>
    <a href="/">Назад</a>
    """
    return render_template_string(template, username=username, role=role)


@app.route("/admin")
def admin():
    role = request.cookies.get("role", "guest")
    if role != "admin":
        return (
            "<h2>Доступ запрещён: вы не admin</h2><p>Попробуйте изменить cookie 'role'.</p><a href='/'>Назад</a>",
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
    base_dir = os.path.abspath(os.path.dirname(__file__))
    target_dir = os.path.join(base_dir, "files")

    full_path = os.path.join(target_dir, subpath)

    if not os.path.exists(full_path):
        return "<h2>Путь не найден</h2><a href='/'>Назад</a>", 404

    if os.path.isdir(full_path):
        entries = os.listdir(full_path)
        items = "".join(
            f"<li><a href='/files/{subpath}{'' if subpath.endswith('/') or subpath == '' else '/'}{e}'>{e}</a></li>"
            for e in entries
        )
        html = f"""
        <h2>Files under /files/{subpath}</h2>
        <ul>{items}</ul>
        <p>Пример directory listing без ограничений.</p>
        <a href="/">Назад</a>
        """
        return html

    with open(full_path, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()
    return f"<pre>{content}</pre>"


if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=8080, debug=True)  # nosec B201,B104
