FROM node:16-alpine as builder

LABEL maintainer="info@redpencil.io"

RUN apk add bash
RUN apk add git
RUN apk add yarn
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/TriplyDB/Yasgui.git
WORKDIR /app/Yasgui
RUN yarn install
RUN yarn run build

FROM httpd:alpine3.19

WORKDIR /usr/local/apache2/htdocs
COPY --from=builder /app/Yasgui/build .
COPY --from=builder /app/Yasgui/packages/yasgui/static/yasgui.polyfill.min.js .
COPY --from=builder /app/Yasgui/webpack/yasgui.png .
COPY ./index-replacement.html .
COPY ./FixHostedFiles.sh /
COPY ./startup.sh /
RUN sh /FixHostedFiles.sh

ENV DEFAULT_SPARQL_ENDPOINT http://localhost:8890/sparql
ENTRYPOINT ["sh", "/startup.sh"]
CMD ["httpd-foreground"]
