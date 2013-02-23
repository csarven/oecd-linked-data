#!/bin/bash

#
#    Author: Sarven Capadisli <info@csarven.ca>
#    Author URI: http://csarven.ca/#i
#

. ./oecd.config.sh
exit;
echo "Removing $db";
rm -rf "$db";

#N-Triples
#224,720,270 triples loaded in 2,348.83 seconds [Rate: 95,673.16 per second]
#real    135m31.100s
#user    126m46.483s
#sys     11m37.268s

#RDF/XML
#ls -1S "$data"*.rdf | grep -vE "(Structure|prov).rdf" | while read i ; do file=$(basename "$i"); dataSetCode=${file%.*}; java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/"$dataSetCode" "$i"; done ;

ls -1S "$data"import/*.nt | grep -vE "(Structure|oecd).nt" | while read i ; do file=$(basename "$i"); dataSetCode=${file%.*}; java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/"$dataSetCode" "$i"; done ;


for i in "$data"import/*.Structure.nt ; do java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$i" ; done
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data""$agency".prov.archive.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data""$agency".prov.retrieval.rdf


#tail -n 266259 oecd.cl_location.nt > o.nt && sort -u o.nt > /data/oecd-linked-data/data/oecd.cl_location.nt
#rapper -g oecd-worldbank.country.trigrams.accept.nt > /data/oecd-linked-data/data/oecd.exactMatch.worldbank.nt
#rapper -g oecd-worldbank.country.trigrams.review.nt >> /data/oecd-linked-data/data/oecd.exactMatch.worldbank.nt
#rapper -g oecd-transparency.country.trigrams.accept.nt > /data/oecd-linked-data/data/oecd.exactMatch.transparency.nt
#rapper -g oecd-transparency.country.trigrams.review.nt >> /data/oecd-linked-data/data/oecd.exactMatch.transparency.nt
#sed -i 's/exactMatch/closeMatch/' oecd-dbpedia.country.trigrams.review.nt
#rapper -g oecd-dbpedia.country.trigrams.accept.nt > /data/oecd-linked-data/data/oecd.exactMatch.dbpedia.nt
#rapper -g oecd-dbpedia.country.trigrams.review.nt >> /data/oecd-linked-data/data/oecd.exactMatch.dbpedia.nt
#rapper -g oecd-bfs-location.trigrams.accept.nt > /data/oecd-linked-data/data/oecd.exactMatch.bfs.nt
#rapper -g oecd-bfs-location.trigrams.review.nt >> /data/oecd-linked-data/data/oecd.exactMatch.bfs.nt
#sort -u /data/oecd-linked-data/data/oecd.exactMatch.worldbank.nt > o.nt && mv o.nt /data/oecd-linked-data/data/oecd.exactMatch.worldbank.nt
#sort -u /data/oecd-linked-data/data/oecd.exactMatch.transparency.nt > o.nt && mv o.nt /data/oecd-linked-data/data/oecd.exactMatch.transparency.nt
#sort -u /data/oecd-linked-data/data/oecd.exactMatch.dbpedia.nt > o.nt && mv o.nt /data/oecd-linked-data/data/oecd.exactMatch.dbpedia.nt
#sort -u /data/oecd-linked-data/data/oecd.exactMatch.bfs.nt > o.nt && mv o.nt /data/oecd-linked-data/data/oecd.exactMatch.bfs.nt

java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.cl_location.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.worldbank.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.transparency.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.dbpedia.nt
java "$JVM_ARGS" tdb.tdbloader --desc="$tdbAssembler" --graph="$namespace"graph/meta "$data"oecd.exactMatch.bfs.nt


#real    146m42.351s
#user    137m42.912s
#sys     10m40.508s

#real    138m6.704s
#user    132m0.467s
#sys     9m36.368s


./oecd.tdbstats.sh

