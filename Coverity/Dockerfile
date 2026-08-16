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
        tar \
        gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/coverity

COPY coverity-analysis-linux64.tar.gz /tmp/coverity.tar.gz

RUN tar -xzf /tmp/coverity.tar.gz \
        --strip-components=1 \
        -C /opt/coverity && \
    rm -f /tmp/coverity.tar.gz

ENV PATH="/opt/coverity/bin:${PATH}"

WORKDIR /workspace

# Verify basic tools; don't fail the build if Coverity tools are not present in placeholder builds
RUN dotnet --version && \
    (cov-build --version || true) && \
    (cov-analyze --version || true)

ENTRYPOINT ["/bin/bash"]