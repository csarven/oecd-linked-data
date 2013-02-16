#!/bin/bash

. ./oecd.config.sh

cd "$data"
tar -cvzf meta.tar.gz *.Structure.rdf oecd.*

tar -cvzf data.tar.gz *.rdf --exclude='*.Structure.rdf' --exclude='oecd.*'

