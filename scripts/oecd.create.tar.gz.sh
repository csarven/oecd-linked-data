#!/bin/bash

data="/data/oecd-linked-data/data/"

cd "$data"
tar -cvzf meta.tar.gz *.Structure.rdf prov.rdf oecd*.nt
#*Structure.rdf is 52M

tar -cvzf data.tar.gz *.rdf --exclude='*.Structure.rdf' --exclude='prov.rdf' --exclude='oecd*.nt'
#.rdf -Structure is 22G

#326M    data.tar.gz
#1.9M    meta.tar.gz

