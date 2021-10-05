(********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: IODBLib
 * File: GetTaskInfo.st
 * Author: Josh
 * Created: September 26, 2012
 ********************************************************************
 * Implementation of library IODBLib
 ********************************************************************) 

(*  *)
FUNCTION_BLOCK GetTaskInfo

	CASE State OF
		0:
			Status:= ERR_FUB_BUSY;
			IF ST_name(0,ADR(Info.Name),ADR(Info.Group)) = 0 THEN
				State:=1;			
			END_IF

		1:
			IF ST_ident(ADR(Info.Name),Info.Group,ADR(Info.Ident)) = 0 THEN
				State:=2;			
			END_IF

		2:
			IF ST_info(Info.Ident,ADR(Info.State),ADR(Info.Resource)) = 0 THEN
				Status:= ERR_OK;
				State:=3;			
			END_IF

	END_CASE
			
END_FUNCTION_BLOCK
