#! /bin/bash

echo "" # for spacing
echo "**************************"
echo "STOPPING DOCKER CONTAINERS"
echo "**************************"
echo "" # for spacing

cd todo-back
docker-compose down
result=$?
cd ..

if [ $result -ne 0 ]; then
    echo "ERROR -- UNABLE TO BRING DOWN DOCKER CONTAINERS"
    exit 1
fi