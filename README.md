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
Just start the application using docker compose. YASGUI will be available on http://localhost:8080.

```bash
docker compose up -d
```

If `docker-compose.dev.yml` is not taken into account automatically on your machine, start the application as follows

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d
```

### Make your hosted SPARQL endpoint accessible via Yasgui

If you are hosting a stack that exposes a SPARQL endpoint, you can enable CORS to ensure Yasgui can access your SPARQL endpoint.

To do so, you have to add the following configuration to your `docker-compose.yml`:

```yaml
services:
  identifier:
    environment:
      DEFAULT_ACCESS_CONTROL_ALLOW_ORIGIN_HEADER: "*"
```
And add a route handler for `OPTION` calls to your `dispatcher.ex`:
```ex
options "*_path" do
  send_resp( conn, 200, "Option calls are accepted by default" )
end
```

For more information you can check the READMEs of the [mu-identifier service](https://github.com/mu-semtech/mu-identifier?tab=readme-ov-file#how-to-make-a-stack-accessible-from-an-external-host-cors) and the [mu-dispatcher service](https://github.com/mu-semtech/mu-dispatcher?tab=readme-ov-file#External-API-CORS-headers).

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
