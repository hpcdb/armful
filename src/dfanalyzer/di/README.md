# Data Ingestor (DI)

----
## Software requirements

1. [Java SE Development Kit (JDK)](http://www.oracle.com/technetwork/pt/java/index.html)
2. [MonetDB database system](https://www.monetdb.org/Home)

----
## Database configuration

After the installation of MonetDB database system (see [MonetDB Installation Guide](https://www.monetdb.org/Documentation/Guide/Installation)), a database named as *dataflow_analyzer* has to be created. The following command lines present how to set a directory for storing MonetDB's data and to create a database.

	monetdbd create /path/to/data_directory
	monetdbd start /path/to/data_directory
	monetdb create dataflow_analyzer
	monetdb release dataflow_analyzer

To test the database creation, it is possible to access a command-line interface to the MonetDB server, as follows:

	mclient -u monetdb -d dataflow_analyzer

Then, it is necessary to configure the create database with the database schema from DfAnalyzer. To do that, the SQL script (*create-dfa-db.sql*) need to be run in the database dataflow_analyzer. More information about how to run a SQL script in MonetDB can be found [here](https://www.monetdb.org/Documentation/UserGuide/DumpRestore).

----
## Data Ingestor daemon invocation

Before to run Data Ingestor, a configuration file, named as *DfA.properties*, need to be created with the DI directory (attribute *di_dir*) in the same directory that user invokes DI JAR program. Moreover, this configuration file contains information about the database system, such as the database system, hostname, port, name, user, and password.

An example of this *DfA.properties* is presented below:

	# DI directory
    di_dir=/root/dfa/di_dir

    # MonetDB
	dbms=MONETDB
	db_server=localhost
	db_port=50000
	db_name=dataflow_analyzer
	db_user=monetdb
	db_password=monetdb

Once dataflow_analyzer database is configured, user can start DI daemon for selecting JSON files in the DI directory and storing provenance data present in those files into the provenance database.

To invoke DI program as a long-running background process (or daemon), the following command line has to be used:

	java -jar DI-2.0.jar -daemon start