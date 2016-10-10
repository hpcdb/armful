from paraview.simple import *
from paraview.servermanager import *
import os
import shutil

mesh = ""
part = -1
path = "/"
xdmfFileName = "test.xdmf"
timeStep = 1
point1 = []
point2 = []
outputFileName = ""

def getInputArgumentsFromFile(filePath):
	f = open(filePath,'r')
	for line in f:
		pair = line.replace("\n","").split("=")
		key = pair[0].upper()
		value = pair[1]

		global path
		global mesh
		global part
		global xdmfFileName
		global timeStep
		global point1
		global point2
		global outputFileName
		global fullDataFiltering

		if(key == "PATH"):
			path = value
		elif(key == "MESH"):
			mesh = value
		elif(key == "PART"):
			part = value
		elif(key == "TIME_STEP"):
			timeStep = int(value)
		elif(key == "POINT_1" and len(value.split(",")) == 3):
			sp = value.replace("[","").replace("]","").split(",")
			for s in sp:
				point1 += [float(s)]
		elif(key == "POINT_2" and len(value.split(",")) == 3):
			sp = value.replace("[","").replace("]","").split(",")
			for s in sp:
				point2 += [float(s)]
		elif(key == "OUTPUT_FILE_NAME"):
			outputFileName = value
		elif(key == "FULL_DATA_FILTERING"):
			if(value.upper() == "TRUE"):
				fullDataFiltering = True
			else:
				fullDataFiltering = False

		xdmfFileName = str(mesh) + "_" + str(part) + ".xmf"

def generateDataUsingParaView(filePath):
	getInputArgumentsFromFile(filePath)

	# global variables
	global path
	global mesh
	global part
	global xdmfFileName
	global timeStep
	global point1
	global point2
	global outputFileName
	global fullDataFiltering

	print "PATH = " + path
	print "XDMF_FILE_NAME = " + xdmfFileName
	print "TIME_STEP = " + str(timeStep)
	print "POINT_1"
	print "X = " + str(point1[0])
	print "Y = " + str(point1[1])
	print "Z = " + str(point1[2])
	print "POINT_2"
	print "X = " + str(point2[0])
	print "Y = " + str(point2[1])
	print "Z = " + str(point2[2])
	print "FULL_DATA_FILTERING = " + str(fullDataFiltering)

	# file system variables
	outputPath = path + "/"
	outputFilePath = outputPath + "/" + outputFileName
	print "OUTPUT_FILE_PATH = " + outputFilePath

	# disable automatic camera reset on 'Show'
	# paraview.simple._DisableFirstRenderCameraReset()

	# create a new 'XDMF Reader'
	cav2_1xmf = XDMFReader(FileNames=[outputPath + xdmfFileName])
	cav2_1xmf.UpdatePipeline()

	if fullDataFiltering:
		SaveData(outputPath + "fulldata.csv", proxy=cav2_1xmf, Precision=10,
		    UseScientificNotation=0,
		    WriteAllTimeSteps=1,
		    FieldAssociation='Points')

		for i in range(timeStep+1):
			nindex = 0
			if(i==12):
				nindex = 1
				i = 11

			readFile = open(outputPath + "fulldata" + str(nindex) + "." + str(i) + ".csv",'r')

			SetActiveSource(cav2_1xmf)
			tsteps = cav2_1xmf.TimestepValues # trying to read all time step directories
			DataRepresentation7 = Show()
			view = GetActiveView()
			view.ViewTime = tsteps[i]

			writeFile = None
			writeHeader = True
		  	if(os.path.exists(outputFilePath)):
		  		writeFile = open(outputFilePath,'a')
		  		writeHeader = False
	  		else:
	  			writeFile = open(outputFilePath,'w+')
		  	
		  	first = True
			for line in readFile:
				if(first):
		  			if(writeHeader):
			  			line = line.replace("\"","")
			  			line = line.replace(":","_").upper()
			  			# writeFile.write("MESH;PART;TIMESTEP;" + line.replace(",",";"))
			  			writeFile.write("TIMESTEP;TIME;" + line.replace(",",";"))
		  			first = False
		  		else:
	  				# writeFile.write(mesh + ";" + str(part) + ";" + str(timeStep))
	  				ctime = "%.1f" % float(tsteps[i])
	  				writeFile.write(repr(i) + ";" + ctime)
	  				values = line.split(",")
	  				for index in range(len(values)):
	  					vfloat = float(values[index])
	  					vstr = "-"
	  					if(index == 0):
	  						vstr = "%.7f" % vfloat
	  					elif(index < 4):
	  						vstr = "%.10f" % vfloat
						elif(index == 4):
	  						vstr = str(int(vfloat))
						else:
							vstr = "%.2f" % vfloat
	  					writeFile.write(";" + vstr)
					writeFile.write("\n");
			readFile.close()
			os.remove(outputPath + "fulldata" + str(nindex) + "." + str(i) + ".csv")
			writeFile.close()
	else:
		SetActiveSource(cav2_1xmf)

		if(timeStep <= len(cav2_1xmf.TimestepValues)):
			PlotOverLine1 = PlotOverLine(Source="High Resolution Line Source")
			PlotOverLine1.PassPartialArrays = 1
			PlotOverLine1.ComputeTolerance = 1
			PlotOverLine1.Tolerance = 2.220446049250313e-16
			DataRepresentation7 = Show()

			PlotOverLine1.Source.Point1 = point1
			PlotOverLine1.Source.Point2 = point2

			source = PlotOverLine1

			view = GetActiveView()
			tsteps = cav2_1xmf.TimestepValues # trying to read all time step directories
			# Render()
		  	
			if(timeStep < len(tsteps)):
			  	csvFileName = outputPath + "file_%d.csv" %(timeStep)
			  	writer = CreateWriter(csvFileName, source)
			  	writer.FieldAssociation = "Points"
			  	writer.UpdatePipeline()
			  	# Render()
			  	del writer

			  	view.ViewTime = tsteps[timeStep]

				print csvFileName
			  	readFile = open(csvFileName,'r')
			  	
			  	writeFile = None
				writeHeader = True
			  	if(os.path.exists(outputFilePath)):
			  		writeFile = open(outputFilePath,'a')
			  		writeHeader = False
		  		else:
		  			writeFile = open(outputFilePath,'w+')
			  	
			  	first = True
				for line in readFile:
					if(first):
			  			if(writeHeader):
				  			line = line.replace("\"","")
				  			line = line.replace(":","_").upper()
				  			# writeFile.write("MESH;PART;TIMESTEP;" + line.replace(",",";"))
				  			writeFile.write("TIMESTEP;TIME;" + line.replace(",",";"))
			  			first = False
			  		else:
			  			# writeFile.write(mesh + ";" + str(part) + ";" + str(timeStep))
		  				ctime = "%.1f" % float(tsteps[timeStep])
		  				writeFile.write(repr(timeStep) + ";" + ctime)
		  				values = line.split(",")
		  				for index in range(len(values)):
		  					vfloat = float(values[index])
		  					vstr = "-"
		  					if(index == 0):
		  						vstr = "%.7f" % vfloat
		  					elif(index < 4):
		  						vstr = "%.10f" % vfloat
							elif(index == 4):
		  						vstr = str(int(vfloat))
							else:
								vstr = "%.2f" % vfloat
		  					writeFile.write(";" + vstr)
						writeFile.write("\n");
				readFile.close()
				os.remove(csvFileName)
				writeFile.close()
		else:
			print "Error: XDMF file is limited to %s time steps" % len(cav2_1xmf.TimestepValues)

if __name__ == "__main__":
	if(len(sys.argv) > 1):
		# to debug
		# filePath = "/Users/vitor/Documents/Repository/Thesis/EdgeCFD-trunk/analysis/paraview/config.properties"
		filePath = sys.argv[1]

		print "###################"
		print "XDMF Filter"
		print "INPUT_FILE_PATH = " + filePath
		
		generateDataUsingParaView(filePath)



