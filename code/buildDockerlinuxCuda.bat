@echo off
setlocal

echo -
echo ----- Building Cascade Locator -----
echo -

cd "./videoStream"
docker build -t stream --platform linux/arm64/v8 .   
cd ..

docker tag stream lcmoreira/smiletracker:latest

docker rmi stream

docker save lcmoreira/stream:latest -o ./filesToLoad/stream.tar

docker rmi lcmoreira/stream:latest

echo -
echo ----- Building Cascade Locator -----
echo -

cd "./videoLocator"
docker build -f DockerfileCuda -t facelocator --platform linux/arm64/v8 .   
cd ..

docker tag facelocator lcmoreira/facelocator:latest

docker rmi facelocator

docker save lcmoreira/facelocator:latest -o ./filesToLoad/facelocatorcuda.tar

docker rmi lcmoreira/facelocator:latest