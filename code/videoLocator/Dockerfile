# Use an official Python runtime as a parent image
#FROM python:3.8-slim
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    python3-dev \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-ttf-dev \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Install any needed dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 1883
EXPOSE 1883

# Run your Python script that uses OpenCV with GPU support
CMD ["python", "faceLocator.py"]