# Example with Raw Data Analyzer (RDA) to access and index raw data from a file. 
This example using RDA considers synthetic raw data files.

## Script invocation
* Invoke our script for accessing and indexing raw data from files:
`./index-raw-data.sh`
* Indexed raw data files are presented in the DATA (<i>e.g.</i>, csv-ext-f1.data) and INDEX (<i>e.g.</i>, csv-idx-f1.index) formats.

#####csv-ext-f1.data
> 
CUSTOMERID;COUNTRY;CONTINENT    
1;'United_Kingdom';'Europe'  
2;'United_States';'North_America'  
3;'France';'Europe'   
4;'United_Kingdom';'Europe'  
5;'France';'Europe'  
6;'United_Kingdom';'Europe'  
7;'Belgium';'Europe'  
8;'Portugal';'Europe'  

#####csv-idx-f1.index
> 
FILENAME;CUSTOMERID;COUNTRY;CONTINENT    
'/root/csv-idx-f1/file-1.csv';1;32;49  
'/root/csv-idx-f1/file-1.csv';2;60;76  
'/root/csv-idx-f1/file-1.csv';3;94;103  
'/root/csv-idx-f1/file-1.csv';4;114;131  
'/root/csv-idx-f1/file-1.csv';5;142;151  
'/root/csv-idx-f1/file-1.csv';6;162;179  
'/root/csv-idx-f1/file-1.csv';7;190;200  
'/root/csv-idx-f1/file-1.csv';8;211;222  

## Indexing algorithms
### CSV
* Positional indexing algorithm

### FastBit and Optimized FastBit
* Bitmap indexing algorithms that use FastBit tool