# PROV-Df: A PROV-Compliant Data Model
![alt text](PROV-Df.png "PROV-Df")

# Validation of PROV-Df using [ProvToolbox](http://lucmoreau.github.io/ProvToolbox/) and [ProvValidator](https://provenance.ecs.soton.ac.uk/validator/view/validator.html)
## We generate the following files, when we executed a scientific workflow in Computational Fluid Dynamics domain using A-Chiron SWMS
**XML file format**

![alt text](a-chiron-cfd/prov-files/a-chiron-cfd.xml "PROV file in XML format")

**JSON file format**

![alt text](a-chiron-cfd/prov-files/a-chiron-cfd.json "PROV file in JSON format")

**PROV-N file format**

![alt text](a-chiron-cfd/prov-files/a-chiron-cfd.provn "PROV file in PROV-N format")

**DOT file format**

![alt text](a-chiron-cfd/prov-files/a-chiron-cfd.dot "PROV file in DOT format")

# A-Chiron's provenance database 
## Computational Fluid Dynamics (CFD) workflow
### Without Raw Data Extraction (RDE)
![alt text](a-chiron-cfd/cfd-default.png "CFD workflow without RDE")

### With RDE
![alt text](a-chiron-cfd/cfd-program.png "CFD workflow with RDE")

### With RDE and Raw Data Indexing (RDI) using a positional indexing algorithm
![alt text](a-chiron-cfd/cfd-positional.png "CFD workflow with RDE and Positional indexing")

### With RDE and RDI using FastBit tool
![alt text](a-chiron-cfd/cfd-fastbit.png "CFD workflow with RDE and RDI using FastBit tool")

## Montage workflow with RDE
1. SQL script to generate the provenance database in PostgreSQL DBMS can be found [here](montage/montage.sql)
2. Example of this workflow can be found [here](../simulation/montage)

![alt text](montage/montage.png "Montage workflow with RDE")

