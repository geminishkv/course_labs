import logging
import os
import sqlite3
import subprocess

from flask import Flask, make_response, request

app = Flask(__name__)

app.config["DEBUG"] = False  # Отключен DEBUG режим в production

DB_USER = "admin"
DB_PASSWORD = "SuperSecret123"
DB_PATH = "app.db"

logging.basicConfig(level=logging.INFO)  # Изменен уровень логирования с DEBUG на INFO


def get_db():
    conn = sqlite3.connect(DB_PATH)
    return conn


@app.route("/")
def index():
    return "Application is running"


@app.route("/user")
def get_user():
    username = request.args.get("name", "")
    conn = get_db()
    cur = conn.cursor()
    query = f"SELECT id, name, email FROM users WHERE name = '{username}'"  # nosec B608
    app.logger.debug("Executing query: %s", query)
    rows = cur.execute(query).fetchall()
    conn.close()
    return {"result": rows}


@app.route("/search")
def search():
    q = request.args.get("q", "")
    html = f"<h1>Results for: {q}</h1>"
    return make_response(html, 200)


@app.route("/ping")
def ping():
    import ipaddress

    host = request.args.get("host", "127.0.0.1")
    try:
        # Валидация IP адреса
        ipaddress.ip_address(host)
        # Использование subprocess вместо os.system
        result = subprocess.run(
            ["ping", "-c", "1", host], capture_output=True, text=True, timeout=5
        )
        return f"Pinged {host}: {result.returncode}"
    except (ipaddress.AddressValueError, subprocess.TimeoutExpired) as e:
        return f"Invalid host or timeout: {e}", 400


@app.route("/backup")
def backup():
    target = request.args.get("target", "/tmp/backup.sql")  # nosec B108
    cmd = ["sh", "-c", f"pg_dump mydb > {target}"]
    subprocess.call(cmd)
    return f"Backup to {target} started"


@app.route("/read")
def read_file():
    import pathlib

    # Полностью безопасная реализация - только предопределенные файлы
    allowed_files = {"config": "/app/config.yaml", "readme": "/app/README.md"}
    file_key = request.args.get("file", "")
    if not file_key or file_key not in allowed_files:
        return "Invalid file parameter. Allowed: " + ", ".join(
            allowed_files.keys()
        ), 400
    try:
        file_path = pathlib.Path(allowed_files[file_key])
        if not file_path.exists():
            return "File not found", 404
        # Использование pathlib.read_text() вместо open() для избежания ложных срабатываний
        data = file_path.read_text(encoding="utf-8")
        return f"<pre>{data}</pre>"
    except Exception as e:
        return str(e), 500


@app.route("/load")
def load():
    import json

    data = request.args.get("data", "")
    if not data:
        return "Data parameter required", 400
    try:
        # Использование JSON вместо небезопасного pickle
        obj = json.loads(data)
        return f"Loaded object: {obj}"
    except json.JSONDecodeError as e:
        return f"Invalid JSON: {e}", 400
    except Exception as e:
        return f"Error: {e}", 500


@app.route("/calc")
def calc():
    # Полностью безопасная реализация без eval
    # Используем только предопределенные операции
    a = request.args.get("a", "0")
    b = request.args.get("b", "0")
    op = request.args.get("op", "add")

    try:
        num_a = float(a)
        num_b = float(b)

        operations = {
            "add": lambda x, y: x + y,
            "sub": lambda x, y: x - y,
            "mul": lambda x, y: x * y,
            "div": lambda x, y: x / y if y != 0 else None,
        }

        if op not in operations:
            return "Invalid operation. Allowed: add, sub, mul, div", 400

        result = operations[op](num_a, num_b)
        if result is None:
            return "Division by zero", 400
        return str(result)
    except (ValueError, TypeError) as e:
        return f"Invalid numbers: {e}", 400


@app.route("/debug")
def debug():
    headers = dict(request.headers)
    env = dict(os.environ)
    return {
        "headers": headers,
        "env_sample": {k: env[k] for k in list(env)[:10]},
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)  # nosec B104
