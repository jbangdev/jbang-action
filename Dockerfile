FROM adoptopenjdk:11-jdk-hotspot

RUN curl -Ls "https://github.com/maxandersen/jbang/releases/download/v0.24.0/jbang-0.24.0.zip" --output jbang.zip \
              && jar xf jbang.zip && rm jbang.zip && mv jbang-* jbang && chmod +x jbang/bin/jbang

ENTRYPOINT ["/jbang/bin/jbang"]
