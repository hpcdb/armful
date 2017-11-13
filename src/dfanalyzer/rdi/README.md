# Raw Data Indexer (RDI) 

It aims at accessing and indexing raw data from a file. 

## RDI invocation

	RDI <cartridge>:<operation> <extractor_name> 
		<directory_path> <file_name> 
		{<attribute>:<attribute_type>} 
		[-delimeter="<delimeter>"] 
		[-bin="<fastbit_bin_path>"]

**Mandatory parameters**

* **cartridge:** name of the implemented cartridge, e.g., a cartridge that implements an algorithm for indexing raw data from CSV files (`CSV`)
* **operation:** there are two operations (`INDEX`, `ACCESS`). `INDEX` operation generates indexes to the gathered raw data. `ACCESS` gather raw data using the generated indexes in the previous operation
* **extractor_name:** name of the extractor, e.g., positionalIndexingExtractor
* **directory_path:** path of the directory that presents the raw data file
* **file_name:** name of the raw data file
* **{<attribute>:<attribute_type>}:** set of pairs with attribute name and attribute type (e.g., TEXT, NUMERIC, or FILE)

**Optional parameters**

* **delimeter:** special character(s) for separating attribute values in raw data files
* **fastbit_bin_path:** path to the binary directory where FastBit was installed. E.g., /root/program/fastbit/bin

Example of RDI invocation:

	./bin/RDI OPTIMIZED_FASTBIT:INDEX ofb-idx-f1 
		/root/dfa file-1.csv 
		[customerID:numeric:key,country:text,continent:text] 
		-delimiter="," 
		-bin="/root/program/fastbit/bin"


## Example with synthetic raw data files

This example using RDI considers synthetic raw data files.

### Script invocation

* Invoke our script for accessing and indexing raw data from files:
`./index-raw-data.sh`

* Indexed raw data files are presented in the DATA (<i>e.g.</i>, csv-ext-f1.data) and INDEX (<i>e.g.</i>, csv-idx-f1.index) formats.

### Running RDI

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
'/root/files/file-1.csv';1;32;49  
'/root/files/file-1.csv';2;60;76  
'/root/files/file-1.csv';3;94;103  
'/root/files/file-1.csv';4;114;131  
'/root/files/file-1.csv';5;142;151  
'/root/files/file-1.csv';6;162;179  
'/root/files/file-1.csv';7;190;200  
'/root/files/file-1.csv';8;211;222  

## Indexing algorithms
### CSV
* Positional indexing algorithm

### PostgresRaw
* Positional indexing algorithm based on the NoDB philosophy

### FastBit and Optimized FastBit (known as OPTIMIZED_FASTBIT)
* Bitmap indexing algorithms that use FastBit tool
