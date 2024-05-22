#! /bin/bash

echo "" # for spacing
echo "*******************"
echo "UPDATING SUBMODULES"
echo "*******************"
echo "" # for spacing

git submodule update --init --remote
result=$?

if [ $result -ne 0 ]; then
    echo "ERROR -- COULD NOT GET SUBMODULES"
    exit 1
fi

echo "****************************"
echo "BUILDING SERVER DOCKER IMAGE"
echo "****************************"
echo "" # for spacing

cd todo-back

docker build -t todo-back .
result=$?
cd ..

if [ $result -ne 0 ]; then
    echo "ERROR -- COULD NOT BUILD SERVER DOCKER IMAGE"
    exit 1
fi

echo "" # for spacing
echo "**************************"
echo "STARTING DOCKER CONTAINERS"
echo "**************************"
echo "" # for spacing

cd todo-back

docker-compose up -d
result=$?
cd ..

if [ $result -ne 0 ]; then
    echo "ERROR -- COULD NOT START DOCKER CONTAINERS"
    exit 1
fi

echo "" # for spacing
echo "********************************"
echo "INSTALLING FRONTEND DEPENDENCIES"
echo "********************************"
echo "" # for spacing

cd todo-front
npm install
result=$?
cd ..

if [ $result -ne 0 ]; then
    echo "ERROR -- COULD NOT INSTALL FRONTEND DEPENDENCIES"
    exit 1
fi

echo "" # for spacing
echo "*****************"
echo "STARTING FRONTEND"
echo "*****************"
echo "" # for spacing

cd todo-front
npm run start
result=$?
cd ..

if [ $result -ne 0 ]; then
    echo "ERROR -- COULD NOT START FRONTEND"
    exit 1
fi