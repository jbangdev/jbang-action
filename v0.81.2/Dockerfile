FROM adoptopenjdk:11-jdk-hotspot

LABEL "org.opencontainers.image.title"="jbang"
LABEL "org.opencontainers.image.description"="Unleash the power of Java"
LABEL "org.opencontainers.image.url"="https://jbang.dev"
LABEL "org.opencontainers.image.licenses"="MIT"
LABEL "org.opencontainers.image.version"="0.81.2"
LABEL "org.opencontainers.image.revision"="95a715e40c06316b8069555447a99a3a9c78584e"


COPY assembly/* /

RUN jar xf jbang-0.81.2.zip && \
    rm jbang-0.81.2.zip && \
    mv jbang-* jbang && \
    chmod +x jbang/bin/jbang

VOLUME /scripts

ENV PATH="${PATH}:/jbang-0.81.2/bin"

ADD ./entrypoint /bin/entrypoint

ENV SCRIPTS_HOME /scripts
ENV JBANG_VERSION 0.81.2

VOLUME /scripts

ENV PATH="${PATH}:/jbang/bin"

## github action does not allow writing to $HOME thus routing this elsewhere
ENV JBANG_DIR="/jbang/.jbang"

ENTRYPOINT ["entrypoint"]