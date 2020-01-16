FROM adoptopenjdk:11-jdk-hotspot

RUN curl -Ls "https://github.com/maxandersen/jbang/releases/download/v0.6.5/jbang-0.6.5.zip" --output jbang.zip \
              && jar xf jbang.zip && mv jbang-* jbang && chmod +x jbang/bin/jbang

ENTRYPOINT ["/jbang/bin/jbang"]
