# Use the official Python image
FROM python:3.9-slim

# Set environment variables
#ENV AWS_ACCESS_KEY_ID=
#ENV AWS_SECRET_ACCESS_KEY=
#ENV S3_URI=
#ENV SQL_HOST=
#ENV SQL_USER=
#ENV SQL_PASSWORD=
#ENV SQL_DB=mydatabase
#ENV SQL_TABLE=customers

# Install necessary packages
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    default-libmysqlclient-dev

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create working directory
WORKDIR /app

# Copy application code
COPY . /app

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# Command to run the application
CMD ["python", "app.py"]
