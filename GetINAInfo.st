(********************************************************************
 * COPYRIGHT -- ARG
 ********************************************************************
 * Library: IODatabase
 * File: GetINAInfo.st
 * Author: Josh Polansky
 * Created: June 20, 2011
 ********************************************************************
 * Implementation of library IODatabase
 ********************************************************************) 


FUNCTION GetINAInfo


(****************************************)
(* Check for invalid database 			*)
(****************************************)

IF( DataBase.Buffer = 0 )THEN

	GetINAInfo:=	0;	
	INADeviceName:=	'Database not initialized';
	
	RETURN;

END_IF
	

(****************************************************************************)
(* Search through database for a PVName which matches the Datapoint input	*)
(****************************************************************************)

pDatapoint ACCESS (DataBase.Buffer + (DataBase.DataTypeSize * index) ); 

WHILE pDatapoint.PVName <> Datapoint AND index < DataBase.BufferSize/ DataBase.DataTypeSize DO

	pDatapoint ACCESS (DataBase.Buffer + (DataBase.DataTypeSize * index) ); 
	index:= index+1;

END_WHILE;


(****************************************)
(* Set return value						*)
(****************************************)

IF pDatapoint.PVName = Datapoint THEN

	GetINAInfo:=	ADR(pDatapoint);
	INADeviceName:=	pDatapoint.INAName;

ELSE

	GetINAInfo:=	0;	
	INADeviceName:=	'Datapoint not found';

END_IF	


END_FUNCTION
