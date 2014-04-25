#!/bin/bash

#
#    Author: Sarven Capadisli <info@csarven.ca>
#    Author URI: http://csarven.ca/#i
#

. ./oecd.config.sh
#exit;
echo "Removing $db";
rm -rf "$db";

#N-Triples
#224,720,270 triples loaded in 2,348.83 seconds [Rate: 95,673.16 per second]
#real    135m31.100s
#user    126m46.483s
#sys     11m37.268s

#RDF/XML
#ls -1S "$data"*.rdf | grep -vE "(Structure|prov).rdf" | while read i ; do file=$(basename "$i"); dataSetCode=${file%.*}; java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/"$dataSetCode" "$i"; done ;

ls -1S "$data"import/*.nt | grep -vE "Structure.nt" | grep -vE "/import/oecd.*nt" | while read i ; do file=$(basename "$i"); dataSetCode=${file%.*}; java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/"$dataSetCode" "$i"; done ;


rm "$data""$agency".observations.meta.nt
ls -1S "$data"import/*.nt | grep -Ev "Structure.nt" | grep -vE "/import/oecd.*nt" | while read i ; do file=$(basename "$i"); DataSetCode=${file%.*}; echo "<$namespace""dataset/$DataSetCode> <http://www.w3.org/2000/01/rdf-schema#seeAlso> <$namespace""data/$agency.observations.ttl> ." >> "$data""$agency".observations.meta.nt ; done
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data""$agency".observations.meta.nt

for i in "$data"import/*.Structure.nt ; do java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$i" ; done
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data""$agency".prov.archive.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data""$agency".prov.retrieval.rdf

java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.oecd.cl_location.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.worldbank.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.worldbank.currency.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.transparency.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.dbpedia.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.bfs.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.fao.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.ecb.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.imf.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.uis.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.frb.currency.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.eurostat.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.geonames.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.hr.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.qudt.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.property.meta.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.dataset.names.nt

#real    146m42.351s
#user    137m42.912s
#sys     10m40.508s

#real    138m6.704s
#user    132m0.467s
#sys     9m36.368s


./oecd.tdbstats.sh

