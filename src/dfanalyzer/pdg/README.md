# Provenance Data Gatherer (PDG)

Before to start the generation of provenance files in JSON format, a configuration file, named as *DfA.properties*, need to be created with the PDG and DI directories (attributes *pdg_dir* and *di_dir*, respectively) in the same directory that user invokes PDG program. PDG directory contains the file path that PDG will generate JSON files. Once a JSON file was completely edited by PDG program, it is moved to the Data Ingestor (DI) directory with the purpose of being consumed by DI program. 

An example of this *DfA.properties* is presented below:

    pg_dir=/home/root/dfa/pdg_dir
    di_dir=/home/root/dfa/di_dir

To generate those JSON files, the following types of command lines can be invoked by PDG. 

To initialize a JSON file for a specific dataflow:

    java –jar PDG.jar -dataflow -tag {dataflow_tag}
