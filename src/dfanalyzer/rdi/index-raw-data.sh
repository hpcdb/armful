#!/bin/bash
echo "Raw Data Indexing"
CPATH=raw
FASTBIT_PATH=/home/program/fastbit

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
./bin/RDI CSV:INDEX csv-idx-f1 $CPATH/csv-idx-f1 file-1.csv [customerID:numeric,country:text,continent:text] -delimiter=","
./bin/RDI OPTIMIZED_FASTBIT:INDEX ofb-idx-f1 $CPATH/ofb-idx-f1 file-1.csv [customerID:numeric,country:text,continent:text] -delimiter="," -bin="$FASTBIT_PATH/bin"
./bin/RDI FASTBIT:INDEX fb-idx-f1 $CPATH/fb-idx-f1 file-1.csv [customerID:numeric,country:text,continent:text] -delimiter="," -bin="$FASTBIT_PATH/bin"

# file 2
./bin/RDI CSV:INDEX csv-idx-f2 $CPATH/csv-idx-f2 file-2.csv [customerID:numeric,age:numeric,gender:text,children:numeric,status:text] -delimiter=","
./bin/RDI OPTIMIZED_FASTBIT:INDEX ofb-idx-f2 $CPATH/ofb-idx-f2 file-2.csv [customerID:numeric,age:numeric,gender:text,children:numeric,status:text] -delimiter="," -bin="$FASTBIT_PATH/bin"
./bin/RDI FASTBIT:INDEX fb-idx-f2 $CPATH/fb-idx-f2 file-2.csv [customerID:numeric,age:numeric,gender:text,children:numeric,status:text] -delimiter="," -bin="$FASTBIT_PATH/bin"




