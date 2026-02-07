FROM python:3.11-slim

# =========================
# ENV
# =========================
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# =========================
# SYSTEM DEPENDENCIES
# =========================
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# =========================
# WORKDIR
# =========================
WORKDIR /app

# =========================
# PYTHON DEPENDENCIES
# =========================
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# =========================
# PROJECT FILES
# =========================
COPY . .

# =========================
# COLLECT STATIC
# =========================
RUN python manage.py collectstatic --noinput

# =========================
# PORT
# =========================
EXPOSE 8000

# =========================
# START SERVER
# =========================
CMD ["gunicorn", "notesapp.wsgi:application", "--bind", "0.0.0.0:8000"]
