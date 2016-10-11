# PROV-Df: A PROV-Compliant Data Model
![alt text](PROV-Df.png "PROV-Df")

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
1. SQL script to generate a provenance database in PostgreSQL DBMS can be found [here](montage/montage.sql)
2. Example of this workflow can be found [here](../simulation/montage)

![alt text](montage/montage.png "Montage workflow with RDE")

