(*
 * File: GetChannelNum.st
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of IODBLib, licensed under the MIT License.
 *) 

(*  *)
FUNCTION GetChannelNum

	pDatapoint ACCESS GetINAInfo(DataBase,Datapoint,DPName);

	IF ADR(pDatapoint) <> 0 THEN
		DPName:=RIGHT(pDatapoint.IODPName,2);
		GetChannelNum := brsatoi( ADR(DPName));
	END_IF
		
END_FUNCTION
