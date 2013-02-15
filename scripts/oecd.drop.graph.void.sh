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

echo Dropping graph "$namespace"graph/void ;
java "$JVM_ARGS" tdb.tdbupdate --desc="$tdbAssembler" 'DROP GRAPH <'"$namespace"'graph/void>'

