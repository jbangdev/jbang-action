FROM adoptopenjdk:11-jdk-hotspot

LABEL "org.opencontainers.image.title"="jbang"
LABEL "org.opencontainers.image.description"="Unleash the power of Java"
LABEL "org.opencontainers.image.url"="https://jbang.dev"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.version"="0.126.1"
LABEL "org.opencontainers.image.revision"="782647365b5f9c4d0738c58904a8e7d11d9f745e"


COPY assembly/* /

## mkdir of .userPrefs is to fix https://github.com/jbangdev/jbang/issues/1831
RUN jar xf jbang-0.126.1.zip && \
    rm jbang-0.126.1.zip && \
    mv jbang-* jbang && \
    chmod +x jbang/bin/jbang && \
    mkdir -p $HOME/.java/.userPrefs


VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

ADD ./entrypoint /bin/entrypoint

ENV SCRIPTS_HOME /scripts
ENV JBANG_VERSION 0.126.1
ENV JBANG_PATH=/jbang/bin

VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

## github action does not allow writing to $HOME thus routing this elsewhere
ENV JBANG_DIR="/jbang/.jbang"

ENTRYPOINT ["entrypoint"]
