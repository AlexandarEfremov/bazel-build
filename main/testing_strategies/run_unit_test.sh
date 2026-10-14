#!/bin/bash

VAR="random"

if [[ -z $VAR ]]; then
    echo "No variable was supplied!" && exit 1;
else
    echo "The variable is $VAR" && exit 0;
fi