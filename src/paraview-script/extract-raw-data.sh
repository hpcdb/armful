#!/bin/bash
# delete previous file with raw data
rm paraview.csv
# data selection from xmf files
meshName=`basename cavp.1`
numberOfTimeSteps=`find . -maxdepth 1 -name "$meshName*.h5" | wc -l`
numberOfTimeSteps=`expr $numberOfTimeSteps - 1`
# script for gathering raw data from XDMF and HDF5 files using ParaView API
for timeStep in $(seq 0 1 `echo $numberOfTimeSteps`)
do
   python bin/edit_Configuration_File-XDMF.py `basename cavp.1` 1 `echo $timeStep` [0.5,0.5,0.0] [0.5,0.5,1.0] paraview.csv FALSE
   $PARAVIEW/bin/pvpython bin/XDMF-Extractor.py config.properties
done
rm config.properties