@echo off
setlocal

echo -
echo ----- Building Cascade Locator -----
echo -

cd "./videoLocator"
docker build -t facelocator --platform linux/arm64/v8 .   
cd ..

docker tag facelocator lcmoreira/facelocator:latest

docker rmi facelocator

docker save lcmoreira/facelocator:latest -o ./filesToLoad/facelocator.tar

docker rmi lcmoreira/facelocator:latest