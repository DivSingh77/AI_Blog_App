FROM python:3.11.4-slim-bullseye
WORKDIR /app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN pip install --upgrade pip setuptools wheel
COPY ./requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the project files
COPY . /app

ENTRYPOINT [ "gunicorn", "core.wsgi", "-b", "0.0.0.0:8000"]
