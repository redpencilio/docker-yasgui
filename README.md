# Yasgui Docker image

This is a Docker image for hosting a
[Yasgui](https://github.com/TriplyDB/Yasgui) instance.

> Yasgui provides various advanced features for creating, sharing, and
> visualizing SPARQL queries and their results.

**NOTE:** this project aims to be an upgrade and drop-in replacement for
[docker-yasgui](https://github.com/erikap/docker-yasgui). That repository
hasn't been maintained in over 6 years and there where a lot of bugs in the
Yasgui version used. Yasgui itself has also not seen any development in the
past 2 years, so it should be pretty stable.

## Installation

To use this image in a Docker Compose stack, put the following snippet in a
`docker-compose.yml` file:

```yaml
services:
  yasgui:
    image: <image-name>
    environment:
      DEFAULT_SPARQL_ENDPOINT: "http://some-endpoint:8890/sparql"
```

## Configuration

There is only one environment variable for now. Use it as given by the example
above.

* `DEFAULT_SPARQL_ENDPOINT`: *(optional, default:
  `http://localhost:8890/sparql`)*, give the host and path to a SPARQL endpoint
  you want this Yasgui instance to point to by default. You can always change
  the endpoint from the Yasgui itself later.

## How this repository works

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
