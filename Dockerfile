FROM eclipse-temurin:11

LABEL "org.opencontainers.image.title"="jbang-action"
LABEL "org.opencontainers.image.description"="Unleash the power of Java"
LABEL "org.opencontainers.image.url"="https://jbang.dev"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.version"="0.128.2"
LABEL "org.opencontainers.image.revision"="62d3cc5146c02ec0f20b0e39c1839055cc9e4c2f"
LABEL org.opencontainers.image.source=https://github.com/jbangdev/jbang-action


COPY assembly/* /

## mkdir of .userPrefs is to fix https://github.com/jbangdev/jbang/issues/1831
RUN jar xf jbang-0.128.2.zip && \
    rm jbang-0.128.2.zip && \
    mv jbang-* jbang && \
    chmod +x jbang/bin/jbang && \
    mkdir -p $HOME/.java/.userPrefs

VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

ADD ./entrypoint /bin/entrypoint

ENV SCRIPTS_HOME=/scripts
ENV JBANG_VERSION=0.128.2
ENV JBANG_PATH=/jbang/bin

VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

## github action does not allow writing to $HOME thus routing this elsewhere
ENV JBANG_DIR="/jbang/.jbang"

ENTRYPOINT ["entrypoint"]
