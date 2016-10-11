# PROV-Df: A PROV-Compliant Data Model
![alt text](PROV-Df.png "PROV-Df")

# Validation of PROV-Df using [ProvToolbox](http://lucmoreau.github.io/ProvToolbox/) and [ProvValidator](https://provenance.ecs.soton.ac.uk/validator/view/validator.html)
## We generate the following files, when we executed a scientific workflow in Computational Fluid Dynamics domain using A-Chiron SWMS
### PROV files in:
* [XML file format](a-chiron-cfd/prov-files/a-chiron-cfd.xml)
* [JSON file format](a-chiron-cfd/prov-files/a-chiron-cfd.json)
* [PROV-N file format](a-chiron-cfd/prov-files/a-chiron-cfd.provn)
* [DOT file format](a-chiron-cfd/prov-files/a-chiron-cfd.dot)

# A-Chiron's provenance database 
## Computational Fluid Dynamics (CFD) workflow
### Without Raw Data Extraction (RDE)
![CFD workflow without RDE](a-chiron-cfd/cfd-default.png)

### With RDE
![CFD workflow with RDE](a-chiron-cfd/cfd-program.png)

### With RDE and Raw Data Indexing (RDI) using a positional indexing algorithm
![CFD workflow with RDE and Positional indexing](a-chiron-cfd/cfd-positional.png)

### With RDE and RDI using FastBit tool
![CFD workflow with RDE and RDI using FastBit tool](a-chiron-cfd/cfd-fastbit.png)

## Montage workflow with RDE
1. SQL script to generate the provenance database in PostgreSQL DBMS can be found [here](montage/montage.sql)
2. Example of this workflow can be found [here](../simulation/montage)

![Montage workflow with RDE](montage/montage.png)

