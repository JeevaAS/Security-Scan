FROM mcr.microsoft.com/dotnet/sdk:8.0-bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_NOLOGO=true
ENV NUGET_XMLDOC_MODE=skip

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        curl \
        openjdk-17-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/blackduck

COPY detect.jar /opt/blackduck/detect.jar

WORKDIR /workspace

ENV BLACKDUCK_DETECT_JAR="/opt/blackduck/detect.jar"

RUN dotnet --version && \
    java -version

ENTRYPOINT ["/bin/bash"]