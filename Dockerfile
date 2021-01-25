FROM debian:stretch

MAINTAINER Amrit Rathie <amrit.rathie@gmail.com>

RUN apt update && apt install -y openjdk-8-jre-headless ca-certificates-java wget

ENV MINECRAFT_VERSION 1.16.5

ENV MINECRAFT_JAR_URL https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar

RUN wget $MINECRAFT_JAR_URL && mv server.jar /minecraft_server_${MINECRAFT_VERSION}.jar

# Create mount point, and mark it as holding externally mounted volume
WORKDIR /data
VOLUME /data

# Accept Minecraft EULA
RUN echo "eula=true" > /data/eula.txt

# Expose the container's network port: 25565 during runtime.
EXPOSE 25565


CMD java -jar /minecraft_server_${MINECRAFT_VERSION}.jar nogui
