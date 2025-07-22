# Use official Python base image
FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy requirements and install system dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config net-tools iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app/backend

# Expose Django default port
EXPOSE 8000

# Run Django development server bound to 0.0.0.0 so it's accessible externally
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
