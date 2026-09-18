FROM python:3.13-slim

# непривилегированный пользователь с фиксированным uid: его удобно проверять в шагах лабы
RUN groupadd --gid 10001 app \
    && useradd --uid 10001 --gid app --no-create-home --shell /usr/sbin/nologin app \
    && install -d -o app -g app /var/lib/api

WORKDIR /app
COPY app.py .

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

USER 10001:10001
EXPOSE 5050

HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
    CMD ["python", "-c", "import urllib.request; urllib.request.urlopen('http://127.0.0.1:5050/health', timeout=2)"]

CMD ["python", "app.py"]
