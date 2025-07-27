FROM eclipse-temurin:11

LABEL "org.opencontainers.image.title"="jbang-action"
LABEL "org.opencontainers.image.description"="Unleash the power of Java"
LABEL "org.opencontainers.image.url"="https://jbang.dev"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.version"="0.128.5"
LABEL "org.opencontainers.image.revision"="915e09dd96062609a4cab07e37d72bf478db7a95"
LABEL org.opencontainers.image.source=https://github.com/jbangdev/jbang-action


COPY assembly/* /

## mkdir of .userPrefs is to fix https://github.com/jbangdev/jbang/issues/1831
RUN jar xf jbang-0.128.5.zip && \
    rm jbang-0.128.5.zip && \
    mv jbang-* jbang && \
    chmod +x jbang/bin/jbang && \
    mkdir -p $HOME/.java/.userPrefs


ENV PATH="${PATH}:/jbang/bin"

ADD ./entrypoint /bin/entrypoint

ENV SCRIPTS_HOME=/scripts
ENV JBANG_VERSION=0.128.5
ENV JBANG_PATH=/jbang/bin

VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

## github action does not allow writing to $HOME thus routing this elsewhere
ENV JBANG_DIR="/jbang/.jbang"

ENTRYPOINT ["entrypoint"]
