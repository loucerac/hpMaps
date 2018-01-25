#!/usr/bin/env bash

# SBGN render via webservice
curl -X POST -F \
	file=@"${1}" http://sysbioapps.dyndns.org/Layout/GenerateImage \
	-o ${2}