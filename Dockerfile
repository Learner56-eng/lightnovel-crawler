# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    aria2 \
    git \
    wget \
    pv \
    jq \
    python3-dev \
    mediainfo && \
    rm -rf /var/lib/apt/lists/*

# Install the necessary Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Run gunicorn and lncrawl bot
CMD ["sh", "-c", "gunicorn app:app & python3 -m lncrawl --suppress --bot telegram"]
