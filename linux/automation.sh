#! /bin/bash

while getopts d:c: flag
do
  case "${flag}" in
    d) dockerfile=${OPTARG};;
    c) context=${OPTARG};;
  esac
done

echo "Building the dockerfile in $dockerfile with $context as context"