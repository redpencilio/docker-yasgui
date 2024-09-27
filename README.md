# Yasgui Docker image

This is a Docker image for hosting a
[Yasgui](https://github.com/TriplyDB/Yasgui) instance.

> Yasgui provides various advanced features for creating, sharing, and
> visualizing SPARQL queries and their results.

## How to guides
### Add YASGUI as a service to your application stack
To use this image in a Docker Compose stack, put the following snippet in a
`docker-compose.yml` file:

```yaml
services:
  yasgui:
    image: redpencil/yasgui:latest
    environment:
      DEFAULT_SPARQL_ENDPOINT: "http://localhost:8890/sparql"
```

### Run YASGUI as a standalone application
Just start the application using docker compose. You probably first want to publish a port to make the YASGUI editor available on localhost

Open `docker-compose.yml` and add port publication to the service, for example on port 8891
```yaml
services:
  yasgui:
    image: redpencil/yasgui:latest
    ports: 
      - "8080:80"
```

Next, start the application

```bash
docker compose up -d
```
## Reference
### Configuration

There is only one environment variable for now. Use it as given by the example
above.

* `DEFAULT_SPARQL_ENDPOINT`: *(optional, default:
  `http://localhost:8890/sparql`)*, give the host and path to a SPARQL endpoint
  you want this Yasgui instance to point to by default. You can always change
  the endpoint from the Yasgui itself later.

## Discussion
### How this repository works

This repository contains a Dockerfile that is used to build a complete Yasgui
image. It prepares an image based on Node 16 with Alpine as its base, clones
the official GitHub repository for [Yasgui](https://github.com/TriplyDB/Yasgui)
into it and builds the application. The built sources are copied to another
image, Apache on Alpine, to serve these files as a static web application.

The extra scripts are helper scripts to move and rename files, as well as to
dynamically replace the default SPARQL endpoint with the value provided via the
environment variable.

When using the built image, no external hosts (e.g. CDNs) are needed to load
scripts. Everything is contained in this image (except for some font files).
