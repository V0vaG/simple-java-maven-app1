#!/bin/bash

echo "Massege:  $(docker run vova0911/project)"

echo "User:     $(docker run vova0911/project whoami)"

echo "Artifact: $(docker run vova0911/project ls | grep .jar)"

# echo "Enter container:" 
# docker run -it vova0911/project bash

echo "Stoping containers:"
docker stop $(docker ps -aq)

echo "Removing containers:"
docker rm $(docker ps -aq)

echo "Removing image:"
docker rmi vova0911/project

