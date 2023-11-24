FROM adoptopenjdk:11-jdk-hotspot

LABEL "org.opencontainers.image.title"="jbang"
LABEL "org.opencontainers.image.description"="Unleash the power of Java"
LABEL "org.opencontainers.image.url"="https://jbang.dev"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.version"="0.113.0"
LABEL "org.opencontainers.image.revision"="4c1221ae7f2c9f3560870cb56d795abfde64abfd"


COPY assembly/* /

RUN jar xf jbang-0.113.0.zip && \
    rm jbang-0.113.0.zip && \
    mv jbang-* jbang && \
    chmod +x jbang/bin/jbang

VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

ADD ./entrypoint /bin/entrypoint

ENV SCRIPTS_HOME /scripts
ENV JBANG_VERSION 0.113.0
ENV JBANG_PATH=/jbang/bin

VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

## github action does not allow writing to $HOME thus routing this elsewhere
ENV JBANG_DIR="/jbang/.jbang"

ENTRYPOINT ["entrypoint"]
