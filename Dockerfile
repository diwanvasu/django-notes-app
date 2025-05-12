# Use an official Python image as the base
FROM python:3.10-slim

# Set the working directory
WORKDIR /app/backend

# Copy only requirements first to leverage Docker cache
COPY requirements.txt .

# Install system dependencies
RUN apt-get update && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir mysqlclient && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose port
EXPOSE 8000

# You can uncomment these if needed in container startup:
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# Define default command (optional)
 CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
