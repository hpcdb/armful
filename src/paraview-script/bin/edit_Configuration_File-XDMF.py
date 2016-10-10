import os
import sys

path = os.getcwd()
mesh = sys.argv[1]
part = sys.argv[2]
timeStep = sys.argv[3]
point1 = sys.argv[4]
point2 = sys.argv[5]
outputFileName = sys.argv[6]
fullDataFiltering = sys.argv[7]

wfile = open("config.properties",'w+')

wfile.write("PATH=" + path + "\n")
wfile.write("MESH=" + mesh + "\n")
wfile.write("PART=" + part + "\n")
wfile.write("TIME_STEP=" + timeStep + "\n")
wfile.write("POINT_1=" + point1 + "\n")
wfile.write("POINT_2=" + point2 + "\n")
wfile.write("OUTPUT_FILE_NAME=" + outputFileName + "\n")
wfile.write("FULL_DATA_FILTERING=" + fullDataFiltering + "\n")

wfile.close()