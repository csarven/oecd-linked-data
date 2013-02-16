#!/bin/bash

#
#    Author: Sarven Capadisli <info@csarven.ca>
#    Author URI: http://csarven.ca/#i
#

. ./oecd.config.sh


dtstart=$(date +"%Y-%m-%dT%H:%M:%SZ") ;
dtstartd=$(echo "$dtstart" | sed 's/[^0-9]*//g') ;

echo Exporting "$data"oecd.metadata.archive."$dtstartd".ttl ;
java "$JVM_ARGS" tdb.tdbquery --time --desc="$tdbAssembler" --results=turtle 'CONSTRUCT { ?s ?p ?o } WHERE { GRAPH <'"$namespace"'/graph/void> { ?s ?p ?o } }' > "$data"oecd.metadata.archive."$dtstartd".nt

echo Exporting "$data"oecd.prov.archive.ttl ;
java "$JVM_ARGS" tdb.tdbquery --time --desc="$tdbAssembler" --results=turtle 'CONSTRUCT { ?s ?p ?o } WHERE { ?s a <http://www.w3.org/ns/prov#Activity> . ?s ?p ?o . }' > "$data"oecd.prov.archive.nt

