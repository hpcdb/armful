# Provenance Data Gatherer (PG)

### Software requirements
1. [Java SE Development Kit (JDK)](http://www.oracle.com/technetwork/pt/java/index.html)

### Example of WordCount Application
To present PG, we consider a classic MapReduce application: WordCount. This application is divided in two steps:
1. Detection of word occurrences in each input file; and
2. Aggregation of occurrences by word to compute the amount of occurrences of each word.

The figure below presents WordCount steps and its associated dataflow.
![alt text](wordcount.png "WordCount")

### JAR program
Before to start the generation of provenance files in JSON format, a configuration file, named as *DfA.properties*, need to be created with the PG and DI directories (attributes *pg_dir* and *di_dir*, respectively) in the same directory that user invokes PG JAR program. PG directory contains the file path that PG will generate JSON files. Once a JSON file was completely edited by PG program, it is moved to the Data Ingestor (DI) directory with the purpose of being consumed by DI program. 

An example of this *DfA.properties* is presented below:

    pg_dir=/home/root/dfa/pg_dir
    di_dir=/home/root/dfa/di_dir

Considering WordCount example, the following command lines can be invoked, using PG JAR program, for generating a JSON file with prospective provenance data. 

Command lines for prospective provenance data

    java -jar PG.jar -dataflow -tag dfexample

	java -jar PG.jar -transformation -dataflow dfexample -tag dt1
	java -jar PG.jar -program -dataflow dfexample -transformation dt1 -name DT1 -filepath /root/DT1.bin

	java -jar PG.jar -set -dataflow dfexample -transformation dt1 -tag ds1 -type input
	java -jar PG.jar -attribute -dataflow dfexample -transformation dt1 -set ds1 -name FILE_ID -type numeric
	java -jar PG.jar -attribute -dataflow dfexample -transformation dt1 -set ds1 -name FILE -type file

	java -jar PG.jar -set -dataflow dfexample -transformation dt1 -tag ds2 -type output
	java -jar PG.jar -extractor -dataflow dfexample -transformation dt1 -set ds2 -tag ext1 -algorithm EXTRACTION:PROGRAM
	java -jar PG.jar -attribute -dataflow dfexample -transformation dt1 -set ds2 -name FILE_ID -type numeric
	java -jar PG.jar -attribute -dataflow dfexample -transformation dt1 -set ds2 -name WORD_FOUND -type text -extractor ext1
	java -jar PG.jar -attribute -dataflow dfexample -transformation dt1 -set ds2 -name COUNT -type numeric -extractor ext1

	java -jar PG.jar -transformation -dataflow dfexample -tag dt2
	java -jar PG.jar -program -dataflow dfexample -transformation dt2 -name DT2 -filepath /root/DT2.bin

	java -jar PG.jar -set -dataflow dfexample -transformation dt2 -tag ds2 -type input -dependency dt1
	java -jar PG.jar -set -dataflow dfexample -transformation dt2 -tag ds3 -type output 
	java -jar PG.jar -extractor -dataflow dfexample -transformation dt2 -set ds3 -tag ext2 -algorithm EXTRACTION:PROGRAM
	java -jar PG.jar -attribute -dataflow dfexample -transformation dt2 -set ds3 -name FILE_ID -type numeric 
	java -jar PG.jar -attribute -dataflow dfexample -transformation dt2 -set ds3 -name WORD -type text -extractor ext2
	java -jar PG.jar -attribute -dataflow dfexample -transformation dt2 -set ds3 -name TOTAL -type numeric -extractor ext2
	java -jar PG.jar -ingest -dataflow dfexample

