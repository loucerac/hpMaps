#!/usr/bin/env bash

### Working environment setup
# get script folder
project_root_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Download data
sh ${project_root_folder}/scripts/download_data.sh ${project_root_folder}/data/dna_repair

# Convert from (celldesigner)-sbml to sbgn
# See https://github.com/royludo/cd2sbgnml
# Dependencies: java-8, maven, javafx
# on debian based systems: apt install openjdk8 maven openjfx

# download the quasi official repository
url="https://github.com/royludo/cd2sbgnml/archive/master.zip"

curl -LOk ${url}
unzip -o master.zip -d apps/
rm master.zip
cd apps/cd2sbgnml-master

# Install
mvn clean
mvn install

# build api (must be run from the project's root directory)
sh buildCellDesignerAPI.sh

# convert to SBGN
sh cd2sbgnml.sh \
	${project_root_folder}/data/dna_repair/dnarepair_v1.1.xml \
	${project_root_folder}/data/dna_repair/dnarepair_v1.1.xml.sbgn \

cd ${project_root_folder}

## Test conversion
# SBGN render via webservice
in_file="${project_root_folder}/data/dna_repair/dnarepair_v1.1.xml.sbgn"
out_file="${project_root_folder}/figs/dnarepair_v1.1.xml.sbgn.png"
sh ${project_root_folder}/scripts/sbgn2png.sh ${in_file} ${out_file}