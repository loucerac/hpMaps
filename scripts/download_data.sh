#!/usr/bin/env bash

current_folder="$(pwd)"
cd ${1:-${current_folder}}

# SBML celldesigner
url="https://acsn.curie.fr/files/dnarepair_v1.1.xml"
curl -O ${url}

# BioPax
url="https://acsn.curie.fr/files/dnarepair_v1.1.owl"
curl -O ${url}

cd -