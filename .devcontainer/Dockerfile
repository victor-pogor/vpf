FROM mcr.microsoft.com/devcontainers/base:bullseye

ENV LIQUIBASE_VERSION=4.30.0

RUN apt-get update && apt-get install -y openjdk-11-jdk curl \
    && curl -L -o liquibase-${LIQUIBASE_VERSION}.tar.gz https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz \
    && tar -xzf liquibase-${LIQUIBASE_VERSION}.tar.gz -C /opt \
    && ln -s /opt/liquibase /usr/local/bin/liquibase

ENV LIQUIBASE_DEFAULTS_FILE=/workspace/liquibase/liquibase.properties