FROM python:3.12-slim

WORKDIR /app

COPY webapp/requirements.txt .
ENV PIP_DEFAULT_TIMEOUT=300
RUN pip install --no-cache-dir --retries 15 --timeout 300 -r requirements.txt

COPY webapp/ .

RUN groupadd -r app && useradd -r -g app -d /app appuser && chown -R appuser:app /app

ENV FLASK_APP=app.py
EXPOSE 8080

USER appuser

CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]
