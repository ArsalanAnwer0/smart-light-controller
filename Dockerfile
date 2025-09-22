FROM python:3.9-slim

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Run as non-root
RUN adduser --disabled-password appuser
USER appuser

EXPOSE 5000

CMD ["flask", "--app", "app:create_app", "run", "--host=0.0.0.0"]
