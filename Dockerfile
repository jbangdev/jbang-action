FROM adoptopenjdk:11-jdk-hotspot

RUN curl -Ls "https://github.com/maxandersen/jbang/releases/download/v0.21.0/jbang-0.21.0.zip" --output jbang.zip \
              && jar xf jbang.zip && mv jbang-* jbang && chmod +x jbang/bin/jbang

ENTRYPOINT ["/jbang/bin/jbang"]
