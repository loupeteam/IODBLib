(********************************************************************
 * COPYRIGHT -- ARG
 ********************************************************************
 * Library: IODatabase
 * File: InitIODatabase.st
 * Author: Josh Polansky
 * Created: June 17, 2011
 ********************************************************************
 * Implementation of library IODatabase
 ********************************************************************) 


//This MUST be called in INIT and must finish before calling GetINAInfo()

//Goes through all the IO and finds the number of connected datapoints

//Allocates memory 

//Fills memory with datapoint info


FUNCTION InitIODB
	

//Set return value to get rid of compiler warning

InitIODB:=	0;


//Get size of required buffer

Database.Buffer:=		0; 
Database.BufferSize:=	0;
Database.DataTypeSize:=	SIZEOF( DataPoint);


//Get the first IO datapoint

Database.ListDP.pLastDatapoint:=	0;	
Database.ListDP.enable:=			1;
Database.ListDP();


//Go through all the datapoints IO datapoints and check to see if they are connected to a PV datapoint

WHILE Database.ListDP.pDatapoint <> 0 // 0 means no datapoint was found
	DO


	Database.ListDP.pLastDatapoint:= Database.ListDP.pDatapoint;
	Database.ListDP();
	
	
	//If the status is 0 a datapoint was found
	
	IF ( Database.ListDP.status = 0 ) THEN
		
		
		//If we found a datapoint, check if it is connected to a PV
		
		Database.PVInfo.pDatapoint:=	Database.ListDP.pDatapoint;
		Database.PVInfo.enable:=		1;
		Database.PVInfo.index:=0;
		Database.PVInfo();
		IF Database.PVInfo.pDatapoint <> 0 THEN
			TempString ACCESS Database.PVInfo.pDatapoint;
//			logError('IOFound',TempString);		
		END_IF
		
		//If there is a PV connected, add the size of the PV info to the buffer size
		
		//Get the producer			
		IF Database.PVInfo.pPvName <> 0 THEN
			TempString ACCESS Database.PVInfo.pPvName;
//			logError('ProdPVFound',TempString);
			Database.BufferSize:= Database.BufferSize + Database.DataTypeSize;
		END_IF;
		
		Database.PVInfo.index:= Database.PVInfo.index+1;
		Database.PVInfo();						
		
		//Get the Consumers
		WHILE Database.PVInfo.pPvName <> 0 DO
			TempString ACCESS Database.PVInfo.pPvName;
//			logError('ConsPVFound',TempString);
			Database.BufferSize:= Database.BufferSize + Database.DataTypeSize;
			Database.PVInfo.index:= Database.PVInfo.index+1;
			Database.PVInfo();	
		END_WHILE;	
		
	END_IF
	
		
END_WHILE;


//Get buffer		

IF ( TMP_alloc(	Database.BufferSize,ADR(Database.Buffer)) = 0 )THEN
	Database.State:=1;
END_IF


END_FUNCTION
