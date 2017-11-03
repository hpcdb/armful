# Raw Data Extractor (RDE)

It aims at accessing and extracting data from a raw data file. 

## RDE invocation

	RDE <cartridge>:<operation> <extractor_name> 
		<directory_path> <file_name or invocation> 
		{<attribute>:<attribute_type>} 
		[-delimeter="<delimeter>"] 

**Mandatory parameters**

* **cartridge:** name of the implemented cartridge. At this moment, we have two types of cartridges for raw data extraction: (1) invocation of an ad-hoc program (external program), named as `PROGRAM`, and (2) execution of an algorithm for extracting scientific data from CSV files, named as `CSV`.
* **operation:** there are two operations (`EXTRACT`, `ACCESS`). `EXTRACT` operations is specific for raw data extraction. `ACCESS` retrieves raw data accessed in files, depending on the cartridge used before.
* **extractor_name:** name of the extractor
* **directory_path:** path of the directory that presents the raw data file
* **file_name or invocation:** name of the raw data file (for `EXTRACT` operation) or the file with extracted data to be accessed (for `ACCESS` operation)
* **{<attribute>:<attribute_type>}:** set of pairs with attribute name and attribute type (e.g., TEXT, NUMERIC, or FILE)

**Optional parameters**

* **delimeter:** special character(s) for separating attribute values in raw data files

Example of RDE invocation:

**Raw data extraction**

	./bin/RDE PROGRAM:EXTRACT extractor 
			/root/dfa ./bin/program.bin 
			[A:numeric:key,B:numeric,C:numeric]

### Running RDE

#####file1.csv
> 
A;B;C  
0;0.0;99  
1;1.0;98  
2;2.0;97  
3;3.0;96  
4;4.0;95  
5;5.0;94  
6;6.0;93  
7;7.0;92  
8;8.0;91  
9;9.0;90  

#####extractor.data
> 
A;B;C  
0;0.0;99  
1;1.0;98  
2;2.0;97  
3;3.0;96  
4;4.0;95  
5;5.0;94  
6;6.0;93  
7;7.0;92  
8;8.0;91  
9;9.0;90  

## Extraction cartridges
### CSV
* Extraction of raw data from CSV file(s)

### PROGRAM
* Invocation of an ad-hoc program to extract raw data from file(s)