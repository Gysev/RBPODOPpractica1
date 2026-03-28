FROM python:3.12-slim

WORKDIR /app

COPY webapp/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY webapp/ .

RUN groupadd -r app && useradd -r -g app -d /app appuser && chown -R appuser:app /app

ENV FLASK_APP=app.py
EXPOSE 8080

USER appuser

CMD ["flask", "run", "--host=0.0.0.0", "--port=8080"]
