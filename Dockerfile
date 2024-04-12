FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
COPY . .

RUN dotnet build "DotnetProject/DotnetProject.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DotnetProject/DotnetProject.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DotnetProject.dll"]