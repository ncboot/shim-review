#!/bin/sh

docker buildx build --progress=plain --no-cache -t shim-build . 2>&1 | tee build.log
docker run shim-build 2>&1 | tee -a build.log
ID=$(docker ps -a | grep shim-build | awk '{print $1;}')
docker cp $ID:/opt/shim-16.1/shimx64.efi ./

