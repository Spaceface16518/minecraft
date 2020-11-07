FROM debian:slim

MAINTAINER Amrit Rathie <amrit.rathie@gmail.com>

RUN apt update && apt install -y openjdk-8-jre-headless ca-certificates-java wget

ENV MINECRAFT_VERSION 1.16.4

ENV MINECRAFT_JAR_URL https://launcher.mojang.com/v1/objects/35139deedbd5182953cf1caa23835da59ca3d7cd/server.jar

RUN wget $MINECRAFT_JAR_URL && mv server.jar /minecraft_server_${MINECRAFT_VERSION}.jar

# Create mount point, and mark it as holding externally mounted volume
WORKDIR /data
VOLUME /data

# Accept Minecraft EULA
RUN echo "eula=true" > /data/eula.txt

# Expose the container's network port: 25565 during runtime.
EXPOSE 25565


CMD java -jar /minecraft_server_${MINECRAFT_VERSION}.jar nogui
