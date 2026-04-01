FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && pip wheel --wheel-dir=/wheels -r requirements.txt
FROM python:3.11-slim 
WORKDIR /app
COPY --from=builder /wheels /wheels 
COPY requirements.txt .
RUN pip install --no-index --find-links=/wheels -r requirements.txt
COPY client.py .

ENV PYTHONUNBUFFERED=1
CMD ["python", "client.py"]