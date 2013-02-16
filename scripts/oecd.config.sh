#!/bin/bash

#
#    Author: Sarven Capadisli <info@csarven.ca>
#    Author URI: http://csarven.ca/#i
#

agency="oecd";
data="/data/$agency-linked-data/data/";
namespace="http://$agency.270a.info/";
state=".staging"; #or ''
db="/SSD/data/tdb/db/$agency$state/";
tdbAssembler="/usr/lib/fuseki/tdb.$agency$state.ttl";
tdbAssemblerStaging="/usr/lib/fuseki/tdb.$agency.staging.ttl";
JVM_ARGS="-Xmx12000M"
javatdbloader="java $JVM_ARGS tdb.tdbloader --desc=$tdbAssembler";
void="/var/www/$agency.270a.info/void.ttl";
voidInit="$agency.void.init.ttl";
graphs="/home/sarcap/Graphs/";

