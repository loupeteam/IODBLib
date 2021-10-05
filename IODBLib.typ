(********************************************************************
 * COPYRIGHT -- ARG
 ********************************************************************
 * Library: IODatabase
 * File: IODatabase.typ
 * Author: Administrator
 * Created: June 17, 2011
 ********************************************************************
 * Data types of library IODatabase
 ********************************************************************)

TYPE
	IODataBase : 	STRUCT 
		Buffer : REFERENCE TO UDINT; (*Pointer to the allocated memory*)
		BufferSize : UDINT; (*size of the allocated memory*)
		DataTypeSize : UDINT; (*size of IODatapoint type*)
		ListDP : AsIOListDP; (*function block to get the IO on the system*)
		PVInfo : AsIOPVInfo; (*function block to get the PV's connected to the IO on the system*)
		State : USINT;
		NumberVariables : UINT;
	END_STRUCT;
	IODataPoint : 	STRUCT  (*DO NOT CHANGE ORDER: PVName, IODPType, INAName, IODPName*)
		PVName : STRING[80]; (*Name of the connected process variable*)
		IODPType : STRING[20]; (*Type of IO Point that is connected*)
		INAName : STRING[80]; (*INA address to slice*)
		IODPName : STRING[80]; (*Name of the connected IO datapoint*)
	END_STRUCT;
	Task_typ : 	STRUCT 
		Name : STRING[80];
		Ident : UDINT;
		Group : USINT;
		State : USINT;
		Resource : SINT;
	END_STRUCT;
END_TYPE
