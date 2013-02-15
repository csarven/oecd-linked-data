#!/bin/bash

#
#    Author: Sarven Capadisli <info@csarven.ca>
#    Author URI: http://csarven.ca/#i
#

data="/data/oecd-linked-data/data/"

rm "$data"prov.rdf

echo '<?xml version="1.0" encoding="UTF-8"?>
<rdf:RDF
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:prov="http://www.w3.org/ns/prov#"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:sdmx="http://purl.org/linked-data/sdmx#">' > "$data"prov.rdf ;

xmllint --xpath "/ul/li/ul/li/ul/li/a[@class = \"ds\"]" oecd.html | sed 's/\/a>/\/a>\n/gi' > oecd.temp

Get=(Data DataStructure);

counter=1;
while read i ;
    do
        DataSetCode=$(echo "$i" | perl -pe 's/<a href=\"([^\"]*)\"(.*)(?=dscode)dscode=\"([^\"]*)\"[^>]*>([^<]*)<\/a>/$3/');

        for GD in "${Get[@]}" ;
            do
                echo "$counter $DataSetCode $GD" ;

                if [ "$GD" == "Data" ]
                then
                    DataType="http:\/\/purl.org\/linked-data\/sdmx#DataSet"
                    DataTypeLabel="Data"
                    DataTypePath=""
                else
                    DataType="http:\/\/purl.org\/linked-data\/sdmx#DataStructureDefinition"
                    DataTypeLabel="Structure"
                    DataTypePath=".Structure"
                fi
        sleep 1
                dtstart=$(date +"%Y-%m-%dT%H:%M:%SZ") ;
                dtstartd=$(echo "$dtstart" | sed 's/[^0-9]*//g') ;
#        wget -t 0 --no-http-keep-alive "http://stats.oecd.org/restsdmx/sdmx.ashx/Get$Get/$DataSetCode" -O ../data/"$DataSetCode".xml
        sleep 1
                dtend=$(date +"%Y-%m-%dT%H:%M:%SZ") ;
                dtendd=$(echo "$dtend" | sed 's/[^0-9]*//g') ;

                echo "$i" | perl -pe 's/<a href=\"([^\"]*)\"(.*)(?=dscode)dscode=\"([^\"]*)\"[^>]*>([^<]*)<\/a>/
                <rdf:Description rdf:about="http:\/\/oecd.270a.info\/provenance\/activity\/'$dtstartd'">
                    <rdf:type rdf:resource="http:\/\/www.w3.org\/ns\/prov#Activity"\/>
                    <prov:startedAtTime rdf:datatype="http:\/\/www.w3.org\/2001\/XMLSchema#dateTime">'$dtstart'<\/prov:startedAtTime>
                    <prov:endedAtTime rdf:datatype="http:\/\/www.w3.org\/2001\/XMLSchema#dateTime">'$dtend'<\/prov:endedAtTime>
                    <prov:wasAssociatedWith rdf:resource="http:\/\/csarven.ca\/#i"\/>
                    <prov:used rdf:resource="https:\/\/launchpad.net\/ubuntu\/+source\/wget"\/>
                    <prov:used>
                        <rdf:Description rdf:about="http:\/\/stats.oecd.org\/restsdmx\/sdmx.ashx\/Get'$GD'\/$3">
                            <rdf:type rdf:resource="'$DataType'"\/>
                            <foaf:page rdf:resource="http:\/\/stats.oecd.org\/$1"\/>
                            <dcterms:title>$4<\/dcterms:title>
                            <dcterms:identifier>'$DataSetCode'<\/dcterms:identifier>
                        <\/rdf:Description>
                    <\/prov:used>
                    <prov:generated rdf:resource="http:\/\/oecd.270a.info\/data\/'$DataSetCode''$DataTypePath'.xml"\/>
                    <rdfs:label xml:lang="en">Retrieved '$DataSetCode' '$DataTypeLabel'<\/rdfs:label>
                    <rdfs:comment xml:lang="en">'$DataTypeLabel' of dataset '$DataSetCode' retrieved from source and saved to local filesystem.<\/rdfs:comment>
                <\/rdf:Description>/' >> "$data"prov.rdf ;
            done
        (( counter++ ));
    done < oecd.temp

echo -e "\n</rdf:RDF>" >> "$data"prov.rdf ;

mv oecd.temp /tmp/

#wget "http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/$DataSetCode"
#wget "http://stats.oecd.org/restsdmx/sdmx.ashx/GetDataStructure/"$DataSetCode"

#Try GETing empty files again.
#find *.xml -empty | sed 's/.xml//' | while read i ; do wget -t 2 -c "http://stats.oecd.org/restsdmx/sdmx.ashx/GetData/$i" -O "$i".xml
