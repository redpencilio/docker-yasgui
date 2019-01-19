# docker-yasgui

Docker image of nginx hosting [YASGUI](http://doc.yasgui.org/).

## Installation
Add the following snippet to your `docker-compose.yml` to add YASGUI to your stack:

```
services:
  yasgui:
    image: erikap/yasgui
    environment:
      DEFAULT_SPARQL_ENDPOINT: "http://linked.toerismevlaanderen.be/sparql"
```

## Configuration
The following environment variables can be set to configure YASGUI:

#### DEFAULT_SPARQL_ENDPOINT
The default SPARQL endpoint used by YASGUI. Defaults to `http://localhost/sparql`. The endpoint must be the publicly accessible URL of the SPARQL endpoint as used on the client-side.

#### ENABLE_ENDPOINT_SELECTOR
Flag to enable the SPARQL endpoint input field. Defaults to `false`. Set to `true` if you want the user to be able to enter a custom SPARQL endpoint URL. If set to `false` all SPARQL queries will be executed against the `DEFAULT_SPARQL_ENDPOINT`.
