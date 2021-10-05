(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: DPLookup
 * File: GetChannelNum.st
 * Author: Josh
 * Created: November 12, 2012
 ********************************************************************
 * Implementation of library DPLookup
 ********************************************************************) 

(*  *)
FUNCTION GetChannelNum

	pDatapoint ACCESS GetINAInfo(DataBase,Datapoint,DPName);

	IF ADR(pDatapoint) <> 0 THEN
		DPName:=RIGHT(pDatapoint.IODPName,2);
		GetChannelNum := brsatoi( ADR(DPName));
	END_IF
		
END_FUNCTION
