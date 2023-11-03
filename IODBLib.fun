(*
 * File: IODBLib.fun
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of IODBLib, licensed under the MIT License.
 *) 

FUNCTION InitIODB : UINT
	VAR_INPUT
		Database : IODataBase;
	END_VAR
	VAR
		TempString : REFERENCE TO STRING[80];
		DataPoint : REFERENCE TO IODataPoint;
	END_VAR
END_FUNCTION

FUNCTION CreateIODB : USINT
	VAR_INPUT
		Database : IODataBase;
	END_VAR
	VAR
		TempString : REFERENCE TO STRING[80];
		DataPoint : REFERENCE TO IODataPoint;
		Done : BOOL;
		len : INT;
		strind : USINT;
		iteration : USINT;
	END_VAR
END_FUNCTION

FUNCTION GetINAInfo : UDINT
	VAR_INPUT
		DataBase : IODataBase;
		Datapoint : STRING[80];
	END_VAR
	VAR_IN_OUT
		INADeviceName : STRING[80];
	END_VAR
	VAR
		pDatapoint : REFERENCE TO IODataPoint;
		index : UINT;
	END_VAR
END_FUNCTION

FUNCTION GetChannelNum : DINT
	VAR_INPUT
		DataBase : IODataBase;
		Datapoint : STRING[80];
	END_VAR
	VAR
		pDatapoint : REFERENCE TO IODataPoint;
		DPName : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION_BLOCK GetTaskInfo
	VAR_OUTPUT
		Info : Task_typ;
		Status : UINT;
	END_VAR
	VAR
		State : USINT;
	END_VAR
END_FUNCTION_BLOCK
