"""Учебный сервис лабораторной docker01: показывает, с какими правами он запущен."""

import json
import os
import socket
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

STATE_DIR = os.environ.get("STATE_DIR", "/var/lib/api")
HITS_FILE = os.path.join(STATE_DIR, "hits")
SECRET_FILE = os.environ.get("DB_PASSWORD_FILE", "/run/secrets/db_password")
DB_HOST = os.environ.get("DB_HOST", "db")
DB_PORT = int(os.environ.get("DB_PORT", "5432"))


def count_hit() -> int:
    """Счётчик запросов хранится в файле: так видно, куда сервис пишет на диск."""
    os.makedirs(STATE_DIR, exist_ok=True)
    hits = 0
    if os.path.exists(HITS_FILE):
        with open(HITS_FILE, encoding="utf-8") as f:
            hits = int(f.read().strip() or 0)
    hits += 1
    with open(HITS_FILE, "w", encoding="utf-8") as f:
        f.write(str(hits))
    return hits


def secret_source() -> dict:
    """Откуда пришёл пароль БД. Значение не возвращается никогда, только длина."""
    if os.path.isfile(SECRET_FILE):
        with open(SECRET_FILE, encoding="utf-8") as f:
            return {"source": "file", "path": SECRET_FILE, "length": len(f.read().strip())}
    if "DB_PASSWORD" in os.environ:
        return {"source": "env", "name": "DB_PASSWORD", "length": len(os.environ["DB_PASSWORD"])}
    return {"source": "none"}


def db_reachable() -> dict:
    try:
        with socket.create_connection((DB_HOST, DB_PORT), timeout=2):
            return {"host": DB_HOST, "port": DB_PORT, "reachable": True}
    except OSError as err:
        return {"host": DB_HOST, "port": DB_PORT, "reachable": False, "error": str(err)}


class Handler(BaseHTTPRequestHandler):
    def _send(self, code: int, body: dict) -> None:
        data = json.dumps(body, ensure_ascii=False).encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", "application/json; charset=utf-8")
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self) -> None:  # noqa: N802 - имя задано http.server
        if self.path == "/health":
            self._send(200, {"status": "ok"})
        elif self.path == "/db":
            self._send(200, db_reachable())
        elif self.path == "/secret":
            self._send(200, secret_source())
        elif self.path == "/":
            try:
                hits = count_hit()
            except OSError as err:
                self._send(500, {"error": f"не могу записать {HITS_FILE}: {err}"})
                return
            self._send(200, {"service": "api", "uid": os.getuid(), "gid": os.getgid(),
                             "hostname": socket.gethostname(), "hits": hits})
        else:
            self._send(404, {"error": "not found"})

    def log_message(self, fmt: str, *args) -> None:
        print(f"{self.address_string()} {fmt % args}", flush=True)


if __name__ == "__main__":
    # Внутри контейнера сервис слушает все интерфейсы контейнера; кто до него
    # дотянется, решают сети и публикация портов в compose — это и есть тема лабы.
    server = ThreadingHTTPServer(("0.0.0.0", 5050), Handler)  # nosec B104
    print("api: слушаю :5050", flush=True)
    server.serve_forever()
