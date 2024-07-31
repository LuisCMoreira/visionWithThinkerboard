#!/bin/bash


docker rm -f $(sudo docker ps -aq)

docker rmi -f $(sudo docker images -aq)


# Remove stopped containers
docker container prune -f

# Remove unused volumes
docker volume prune -f

# Remove unused networks
docker network prune -f

# Remove unused images
docker image prune -f


########################################################################################
# Run Service
# Define variables
IMAGE_NAME="stream"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi


# Run the Docker container
docker run -d --privileged --name "${IMAGE_NAME}" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion

# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed



########################################################################################
# Run Service
# Define variables
IMAGE_NAME="facelocator"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi


# Run the Docker container
docker run -d --name "${IMAGE_NAME}" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion

# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed



########################################################################################
# Run Service
# Define variables
IMAGE_NAME="29999stateset"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi

# Run the Docker container
docker run -d --name  "${IMAGE_NAME}" -v "/home/linaro/Desktop/9dockerImgs/000namespace:/app/namespace" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion

# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed

########################################################################################
# Run Service
# Define variables
IMAGE_NAME="30001robotcommand"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi

# Run the Docker container
docker run -d --name  "${IMAGE_NAME}" -v "/home/linaro/Desktop/9dockerImgs/000namespace:/app/namespace" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion

# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed


########################################################################################
# Run Service
# Define variables
IMAGE_NAME="hmi"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi

# Run the Docker container
docker run -d -p 8080:8080 --name  "${IMAGE_NAME}" -v "/home/linaro/Desktop/9dockerImgs/000namespace:/app/namespace" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion


# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed

########################################################################################
# Run Service
# Define variables
IMAGE_NAME="robotstatusmonitor"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi

# Run the Docker container
docker run -d -p 23333:23333 --name "${IMAGE_NAME}" -v "/home/linaro/Desktop/9dockerImgs/000namespace:/app/namespace" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion


# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed

########################################################################################
# Run Service
# Define variables
IMAGE_NAME="joyread"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi




# Search for the specific USB device
usb_info=$(lsusb | grep "3Dconnexion SpaceMouse")

# Check if the USB device is found
if [ -z "$usb_info" ]; then
  echo "USB device not found"
  #exit 1
fi

# Extract the Bus and Device numbers from the device information
bus=$(echo "$usb_info" | awk '{print $2}' | cut -d ':' -f1)
device=$(echo "$usb_info" | awk '{print $4}' | cut -d ':' -f1)

# Check if Bus and Device numbers are found
if [ -z "$bus" ] || [ -z "$device" ]; then
  echo "Bus and/or Device numbers not found"
  #exit 1
fi




# Run the Docker container
docker run -d --privileged --device=/dev/bus/usb/$bus/$device --name "${IMAGE_NAME}" -v "/home/linaro/Desktop/9dockerImgs/000namespace:/app/namespace" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion


# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed


########################################################################################
# Run Service
# Define variables
IMAGE_NAME="smiletracker"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi

# Run the Docker container
docker run -d --name   "${IMAGE_NAME}" -v "/home/linaro/Desktop/9dockerImgs/000namespace:/app/namespace" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion

# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed

########################################################################################
# Run Service
# Define variables
IMAGE_NAME="vstream"
IMAGE_PREFIX="lcmoreira/"
IMAGE_TAG="latest"
IMAGE_FILE="${IMAGE_NAME}.tar"  # Corrected concatenation

# Check if the Docker image exists
if docker image inspect "${IMAGE_NAME}:${IMAGE_TAG}" &> /dev/null; then
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' already exists."
else
    echo "Docker image '${IMAGE_NAME}:${IMAGE_TAG}' not found. Loading..."
    # Load the Docker image from a .tar file
    docker load -i "$IMAGE_FILE"  # Corrected variable expansion
    #rm "$IMAGE_FILE"
fi

# Run the Docker container
docker run -d  -p 8081:8081 --name "${IMAGE_NAME}" -v "/home/linaro/Desktop/9dockerImgs/000namespace:/app/namespace" "${IMAGE_PREFIX}${IMAGE_NAME}:${IMAGE_TAG}"  # Corrected variable expansion

docker stop vstream

# Wait for the container to start
echo "Waiting for container to start..."
sleep 2  # Adjust sleep time as needed


####################################################################################################################


sleep 15 

sudo docker restart startup

sleep 2

docker restart 29999stateset

docker restart robotstatusmonitor

sleep 2

sudo docker restart startup

sudo docker restart 30001robotcommand

sleep 15

sudo docker restart smiletracker