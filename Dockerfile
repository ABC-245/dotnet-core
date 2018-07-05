FROM microsoft/aspnetcore:2.0 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/aspnetcore-build:2.0 AS build
WORKDIR /src
COPY sampleapplication.sln ./
COPY sampleapplication/sampleapplication.csproj sampleapplication/
RUN dotnet restore -nowarn:msb3202,nu1503
COPY . .
WORKDIR /src/sampleapplication
RUN dotnet build -c Release -o /app

FROM build AS publish
RUN dotnet publish -c Release -o /app
RUN systemctl enable sampleapplication.service

RUN yum update -y
RUN yum -y install httpd mod_ssl

COPY sampleapplication.conf /etc/httpd/conf.d/

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "sampleapplication.dll"]
