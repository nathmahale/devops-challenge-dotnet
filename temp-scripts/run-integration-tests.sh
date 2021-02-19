#!/bin/bash

OLD_APP_PROCESS=$(ps -ef | grep DevOpsChallenge.SalesApi.dll | grep -v grep | cut -d' ' -f2)

if [ $? -eq 0 ];
    then
        echo "[ INFO ] killing old server process"
        sleep 30
        kill -9 $OLD_APP_PROCESS
else
    echo "[ ERROR ] Please check logs"
    exit 1
fi

dotnet $BUILD_DIR/out/DevOpsChallenge.SalesApi.dll &
APP_RUN_PROCESS_ID=$!

echo $APP_RUN_PROCESS_ID
dotnet test --verbosity minimal $BUILD_DIR/tests/DevOpsChallenge.SalesApi.IntegrationTests

if [ $? -eq 0 ];
    then
        echo "[ INFO ] dotnet integration testing is completed successfully!"
        sleep 30
        kill -9 $APP_RUN_PROCESS_ID
        exit 0
else
    echo "[ ERROR ] Please check the logs"
    exit 1
fi