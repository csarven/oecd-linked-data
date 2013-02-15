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

./oecd.drop.graph.void.sh

echo Importing LODStats into "$namespace"graph/void ;
for i in "$data"import/*stats.ttl ; do java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/void "$i"; done ;

./oecd.construct.void.sh

./oecd.drop.graph.void.sh

echo Inserting "$void" back into "$namespace"graph/void ;
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/void "$void"

