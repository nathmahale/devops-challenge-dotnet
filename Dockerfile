# FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

# ## Copy all the contents from local
# COPY . /app
# WORKDIR /app


# RUN ["dotnet", "restore"]

# RUN ["dotnet", "publish", "-c", "Release", "-o", "out"]

ARG BUILD_ARTIFACTSTAGINGDIRECTORY

FROM mcr.microsoft.com/dotnet/aspnet:5.0

## Initial folder creation, copying contents
RUN mkdir -p /app/ReleaseFolder/
RUN chmod 755 /app/ReleaseFolder/

RUN apt-get update

## Install unzip utility
RUN apt install -y unzip

WORKDIR /app

COPY $BUILD_ARTIFACTSTAGINGDIRECTORY /app


## Expose port
EXPOSE 5000/tcp

# COPY --from=build-env /app/out .

## Unzip .zip [ output from dotnet publish task] /app/ReleaseFolder/ folder
RUN unzip /app/DevOpsChallenge.SalesApi.zip -d /app/ReleaseFolder/

ENTRYPOINT ["dotnet", "/app/ReleaseFolder/DevOpsChallenge.SalesApi.dll"]

