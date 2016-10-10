#!/bin/bash
echo "Raw Data Indexing"
CPATH=raw

rm -rf $CPATH/csv-*
rm -rf $CPATH/fb-*
rm -rf $CPATH/ofb-*

mkdir $CPATH/csv-idx-f1
mkdir $CPATH/ofb-idx-f1
mkdir $CPATH/fb-idx-f1
mkdir $CPATH/csv-idx-f2
mkdir $CPATH/ofb-idx-f2
mkdir $CPATH/fb-idx-f2

cp $CPATH/file-1.csv $CPATH/csv-idx-f1
cp $CPATH/file-1.csv $CPATH/ofb-idx-f1
cp $CPATH/file-1.csv $CPATH/fb-idx-f1

cp $CPATH/file-2.csv $CPATH/csv-idx-f2
cp $CPATH/file-2.csv $CPATH/ofb-idx-f2
cp $CPATH/file-2.csv $CPATH/fb-idx-f2

# file 1
./bin/RDA INDEXING:CSV:EXTRACT csv-idx-f1 $CPATH/csv-idx-f1 file-1.csv [customerID:numeric:key,country:text,continent:text] -delimiter=","
./bin/RDA INDEXING:OPTIMIZED_FASTBIT:EXTRACT ofb-idx-f1 $CPATH/ofb-idx-f1 file-1.csv [customerID:numeric:key,country:text,continent:text] -delimiter="," -bin="/Users/vitor/Documents/Program_Installations/fastbit-2.0.2/build/bin"
./bin/RDA INDEXING:FASTBIT:EXTRACT fb-idx-f1 $CPATH/fb-idx-f1 file-1.csv [customerID:numeric:key,country:text,continent:text] -delimiter="," -bin="/Users/vitor/Documents/Program_Installations/fastbit-2.0.2/build/bin"

# file 2
./bin/RDA INDEXING:CSV:EXTRACT csv-idx-f2 $CPATH/csv-idx-f2 file-2.csv [customerID:numeric:key,age:numeric,gender:text,children:numeric,status:text] -delimiter=","
./bin/RDA INDEXING:OPTIMIZED_FASTBIT:EXTRACT ofb-idx-f2 $CPATH/ofb-idx-f2 file-2.csv [customerID:numeric:key,age:numeric,gender:text,children:numeric,status:text] -delimiter="," -bin="/Users/vitor/Documents/Program_Installations/fastbit-2.0.2/build/bin"
./bin/RDA INDEXING:FASTBIT:EXTRACT fb-idx-f2 $CPATH/fb-idx-f2 file-2.csv [customerID:numeric:key,age:numeric,gender:text,children:numeric,status:text] -delimiter="," -bin="/Users/vitor/Documents/Program_Installations/fastbit-2.0.2/build/bin"




