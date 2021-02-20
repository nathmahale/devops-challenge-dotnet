FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

## Copy all the contents from local
COPY . /app
WORKDIR /app


RUN ["dotnet", "restore"]

RUN ["dotnet", "publish", "-c", "Release", "-o", "out"]

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
EXPOSE 5000/tcp
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "DevOpsChallenge.SalesApi.dll"]

