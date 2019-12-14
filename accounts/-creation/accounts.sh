#!/bin/bash

find ../ -maxdepth 1 ! -name '-*' ! -path ../  -type d | jq -R -s -c 'split("\n") | map( { (.): "true" } ) | add'
