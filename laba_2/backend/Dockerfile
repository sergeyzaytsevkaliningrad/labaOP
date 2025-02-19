FROM python:3.11-alpine

WORKDIR /backend

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY backend.py .

EXPOSE 9000

CMD ["uvicorn", "backend:app", "--host", "0.0.0.0", "--port", "9000"]
