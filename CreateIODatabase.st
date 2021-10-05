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


FUNCTION CreateIODB
	

//Set return value to get rid of compiler warning

CreateIODB:=	0;

FOR iteration:= 0 TO 5 DO
	CASE Database.State OF

		1://Init
			Database.NumberVariables:=0;
			Database.ListDP.pLastDatapoint:= 0;	
			Database.ListDP.enable:=1;
			Database.ListDP();
			IF Database.ListDP.status = 0 THEN
			  	Database.State:= 	2;
			END_IF		 

		2://We have a datapoint!
			IF Database.ListDP.pDatapoint <> 0
				THEN
			  	Database.State := 				3;
				Database.PVInfo.index:=			0;
				Database.PVInfo.pDatapoint:=	Database.ListDP.pDatapoint;
				Database.PVInfo.enable:=		1;
				Database.PVInfo();
				TempString ACCESS Database.PVInfo.pDatapoint;
			ELSE
			  	Database.State := 	0;				
				CreateIODB:=		1;
			END_IF
		
		3://Get the status
			
			Database.PVInfo();			

			IF Database.PVInfo.status = 0 //We have the info
				THEN
			  	Database.State := 	4;					
			ELSIF Database.PVInfo.status = ERR_FUB_BUSY //We are getting the info
				THEN 
				
			ELSE	//We couldn't get info, get the next one
			  	Database.State := 	5;					
			END_IF
	
		4://Parse
			IF Database.PVInfo.pPvName <> 0 THEN
	
				//Get the current place in the buffer
				DataPoint  ACCESS (Database.Buffer + (Database.NumberVariables * Database.DataTypeSize));
						
				//Set the PV Name
				TempString ACCESS Database.PVInfo.pPvName;
				DataPoint.PVName:=	TempString;

				//Set the IO Datapoint name
				TempString ACCESS Database.ListDP.pDatapoint;
				DataPoint.IODPName:=	TempString;			
			
				//Get the IO Type			
				strind:=0;
				Done:=0;
				WHILE strind < brsstrlen(Database.ListDP.pDatapoint) 
					AND strind < SIZEOF(DataPoint.IODPType) 
					AND NOT Done 
					DO
					IF	brsmemcmp( Database.ListDP.pDatapoint + strind,ADR('.'),1) = 0 
					OR	brsmemcmp( Database.ListDP.pDatapoint + strind,ADR(':'),1) = 0
						THEN
						brsstrcpy( ADR(DataPoint.IODPType), Database.ListDP.pDatapoint );
						brsmemset( ADR(DataPoint.IODPType) + strind, 0, SIZEOF(DataPoint.IODPType)- strind);
						brsstrcpy( ADR(DataPoint.INAName),  Database.ListDP.pDatapoint + strind + 1 );
						Done:=1;
					END_IF
					strind:=strind+1;
				END_WHILE;
			
				len:= UDINT_TO_INT(brsstrlen( ADR(DataPoint.INAName) ));
				Done:=0;			
				//Start at the end and look for the last "." to separate the INA device from the IODatapoint name			
				WHILE( len > 0 AND NOT Done )  DO
					IF ( brsmemcmp( ADR(DataPoint.INAName) + len - 1, ADR('.' ), 1 ) = 0 )THEN
						Done := 1;
					END_IF			
					TempString ACCESS ADR(DataPoint.INAName) + len - 1;
					len := len - 1;		
				END_WHILE;

				brsstrcpy(ADR(DataPoint.IODPName),ADR(TempString)+1);	
				TempString := '';			

				Database.NumberVariables:= Database.NumberVariables+1;
				Database.State:= 	3;
				Database.PVInfo.index:=	Database.PVInfo.index+1;
			ELSE
				
				IF Database.PVInfo.index = 0 THEN
					Database.PVInfo.index:=	1;
					Database.State:= 	3;			
				ELSE
					Database.State:= 	5;	
				END_IF		
			END_IF

		5://Get the next one
			Database.ListDP.pLastDatapoint:= Database.ListDP.pDatapoint;
			Database.ListDP();	
			IF Database.ListDP.status = 0 
				THEN
			  	Database.State:= 	2;
			ELSIF Database.ListDP.pDatapoint = 0 THEN
				Database.State := 	0;				
			END_IF	
					
	END_CASE;
END_FOR

END_FUNCTION
