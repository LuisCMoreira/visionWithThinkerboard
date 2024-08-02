@echo off
setlocal



echo -
echo ----- Building Cascade Locator -----
echo -

cd "./videoLocator"
docker build -f Dockerfile -t facelocator .   
cd ..

docker tag facelocator lcmoreira/facelocator:latest

docker rmi facelocator



docker run -d --privileged --device=/dev/video0 --name videostream lcmoreira/stream:latest

docker run -d --name videolocator lcmoreira/facelocator:latest 