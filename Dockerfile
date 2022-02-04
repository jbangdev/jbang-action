FROM adoptopenjdk:11-jdk-hotspot

LABEL "org.opencontainers.image.title"="jbang"
LABEL "org.opencontainers.image.description"="Unleash the power of Java"
LABEL "org.opencontainers.image.url"="https://jbang.dev"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.version"="0.88.0"
LABEL "org.opencontainers.image.revision"="d12a0a4da74480f3a876464ab1b3df034b33b86c"


COPY assembly/* /

RUN jar xf jbang-0.88.0.zip && \
    rm jbang-0.88.0.zip && \
    mv jbang-* jbang && \
    chmod +x jbang/bin/jbang

VOLUME /scripts

ENV PATH="${PATH}:/jbang-0.88.0/bin"

ADD ./entrypoint /bin/entrypoint

ENV SCRIPTS_HOME /scripts
ENV JBANG_VERSION 0.88.0

VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

## github action does not allow writing to $HOME thus routing this elsewhere
ENV JBANG_DIR="/jbang/.jbang"

ENTRYPOINT ["entrypoint"]
