# Start with the base image
FROM python:3.11-slim

# Set work directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies required for mysqlclient
RUN apt-get update && apt-get install -y \
    build-essential \
    libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --upgrade pip

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy the rest of your application code
COPY . .

# Expose the port your app runs on
EXPOSE 8000

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
