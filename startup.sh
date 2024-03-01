#!/bin/sh

cd /usr/local/apache2/htdocs
sed -i "s@~DEFAULT_SPARQL_ENDPOINT~@$DEFAULT_SPARQL_ENDPOINT@g" index.html

exec "$@"
