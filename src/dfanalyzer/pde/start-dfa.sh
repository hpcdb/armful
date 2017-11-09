#!/bin/bash
clear
echo "Setting up environment variables..."
SIMULATION_DIR=`pwd`
DFA_PROPERTIES=$SIMULATION_DIR/DfA.properties
echo "--------------------------------------------"
echo "Cleaning up..."
rm $DFA_PROPERTIES
# organizing provenance directories
rm -rf provenance/*
# cleaning up MonetDB directory
killall mserver5
killall monetdbd
sleep 5
rm -rf data
echo "--------------------------------------------"
echo "Configuring DfA.properties file"
echo "di_dir="$SIMULATION_DIR >> $DFA_PROPERTIES
echo "dbms=MONETDB" >> $DFA_PROPERTIES
echo "db_server=localhost" >> $DFA_PROPERTIES
echo "db_port=50000" >> $DFA_PROPERTIES
echo "db_name=dataflow_analyzer" >> $DFA_PROPERTIES
echo "db_user=monetdb" >> $DFA_PROPERTIES
echo "db_password=monetdb" >> $DFA_PROPERTIES
echo "--------------------------------------------"
echo "Restoring MonetDB database..."
echo "localhost" >> database.conf
unzip -q backup/data-local.zip
clear
echo "--------------------------------------------"
echo "Starting database system..."
DATAPATH=$SIMULATION_DIR/data
$SIMULATION_DIR/dfa/database_starter.sh database.conf $SIMULATION_DIR $DATAPATH
echo "--------------------------------------------"
echo "Starting DfA RESTful API" # or PDE
$SIMULATION_DIR/dfa/REST-DfA-1.0

