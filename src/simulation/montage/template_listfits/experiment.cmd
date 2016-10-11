#!/bin/bash

# echo "copying input file"
cp -rf %=WFDIR%/input/%=REGION%-%=DEGREES%d/* .
# gunzip *.gz

# echo "extracting FITS images"
$MONTAGE/bin/mImgtbl . images-rawdir.tbl