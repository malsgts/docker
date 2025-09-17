FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Actualizar e instalar utilidades básicas
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    software-properties-common \
    apt-transport-https \
    lsb-release

# Instalar Git
RUN apt-get install -y git

# Instalar VS Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt-get update && apt-get install -y code

# Instalar Maven
RUN apt-get install -y maven

# Instalar PostgreSQL
RUN apt-get install -y postgresql postgresql-contrib

# Instalar Java JRE (y JDK para compilación)
RUN apt-get install -y openjdk-17-jdk

# Instalar .NET SDK
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-8.0

# Instalar Apache2
RUN apt-get install -y apache2

# Crear un index.html de “Hola Mundo”
RUN echo "Hola Mundo desde Apache en Docker" > /var/www/html/index.html

# Exponer puertos necesarios
EXPOSE 80 5432

# Iniciar Apache y PostgreSQL al arrancar el contenedor
CMD service postgresql start && apachectl -D FOREGROUND