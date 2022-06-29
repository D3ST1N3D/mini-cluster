FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /sample-app
COPY /sample-app/* .
RUN ls -als
RUN dotnet restore
RUN dotnet publish -c release -o /sample-app --no-restore
FROM mcr.microsoft.com/dotnet/aspnet:5.0
COPY --from=build /sample-app ./
ENTRYPOINT ["dotnet", "sample-app.dll"]
