#!/bin/bash

#
#    Author: Sarven Capadisli <info@csarven.ca>
#    Author URI: http://csarven.ca/#i
#

data="/data/oecd-linked-data/data/";
namespace="http://oecd.270a.info/";
db="/SSD/data/tdb/db/oecd/";
tdbAssembler="/usr/lib/fuseki/tdb.oecd.ttl";
JVM_ARGS="-Xmx12000M"
void="/var/www/oecd.270a.info/void.ttl";
query="oecd.void.init.ttl";

echo Exporting "$namespace"graph/void to "$void" ;
java "$JVM_ARGS" tdb.tdbquery --time --desc="$tdbAssembler" --results=turtle --query="$query" > "$void" ;

