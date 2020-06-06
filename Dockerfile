FROM adoptopenjdk:11-jdk-hotspot

RUN curl -Ls "https://github.com/jbangdev/jbang/releases/download/v0.28.0/jbang-0.28.0.zip" --output jbang.zip \
              && jar xf jbang.zip && rm jbang.zip && mv jbang-* jbang && chmod +x jbang/bin/jbang

ADD bin/entrypoint.sh /bin/entrypoint

ENV SCRIPTS_HOME /scripts
ENV JBANG_VERSION 0.28.0

RUN useradd -u 10001 -r -g 0 -m \
     -d ${SCRIPTS_HOME} -s /sbin/nologin -c "jbang user" jo \
   && chmod -R g+w /scripts \
   && chmod -R g+w /jbang \
   && chgrp -R root /scripts \
   && chgrp -R root /jbang \
   && chmod g+w /etc/passwd \
   && chmod +x /bin/entrypoint

VOLUME /scripts

USER 10001

ENV PATH="${PATH}:/jbang/bin"

ENTRYPOINT ["entrypoint"]
CMD ["--help"]