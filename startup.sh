#!/bin/bash

if [ "$ENABLE_ENDPOINT_SELECTOR" == "true" ]; 
then
    sed -i '/\/\*\* endpoint-selector \*\//c\'"\/** .yasgui .endpointText {display:none !important;} *\/ \/** endpoint-selector *\/" /usr/share/nginx/html/index.html
else
    sed -i '/\/\*\* endpoint-selector \*\//c\'".yasgui .endpointText {display:none !important;} \/** endpoint-selector *\/" /usr/share/nginx/html/index.html
fi

sed -i '/default SPARQL endpoint/c\'"yasqe:{sparql:{endpoint:'$DEFAULT_SPARQL_ENDPOINT'}} \/\/ default SPARQL endpoint" /usr/share/nginx/html/index.html

exec "$@"
