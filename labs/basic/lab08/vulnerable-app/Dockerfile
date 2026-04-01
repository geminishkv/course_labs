FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .

ENV APP_DB_PATH=/app/app.db
ENV PYTHONUNBUFFERED=1

EXPOSE 8080

CMD ["python", "app.py"]