from flask import Flask, request, make_response
import sqlite3
import os
import subprocess
import pickle
import logging

app = Flask(__name__)

app.config["DEBUG"] = True

DB_USER = "admin"
DB_PASSWORD = "SuperSecret123"
DB_PATH = "app.db"

logging.basicConfig(level=logging.DEBUG)


def get_db():
    conn = sqlite3.connect(DB_PATH)
    return conn


@app.route("/")
def index():
    return "Vulnerable lab07 app v1.0"


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
    host = request.args.get("host", "127.0.0.1")
    cmd = f"ping -c 1 {host}"  # nosec B605
    os.system(cmd)
    return f"Pinged {host}"


@app.route("/backup")
def backup():
    target = request.args.get("target", "/tmp/backup.sql")  # nosec B108
    cmd = ["sh", "-c", f"pg_dump mydb > {target}"]
    subprocess.call(cmd)
    return f"Backup to {target} started"


@app.route("/read")
def read_file():
    path = request.args.get("path", "/etc/passwd")
    try:
        with open(path, "r") as f:
            data = f.read()
        return f"<pre>{data}</pre>"
    except Exception as e:
        return str(e), 500


@app.route("/load")
def load():
    data = request.args.get("data", "")
    try:
        obj = pickle.loads(bytes.fromhex(data))  # nosec B301
        return f"Loaded object: {obj}"
    except Exception as e:
        return f"Error: {e}", 500


@app.route("/calc")
def calc():
    expr = request.args.get("expr", "1+1")
    result = eval(expr)  # nosec B307
    return str(result)


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
