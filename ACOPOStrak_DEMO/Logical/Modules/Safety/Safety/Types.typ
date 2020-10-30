
TYPE
	safety_typ : 	STRUCT 
		cmd : safety_cmd_typ;
		status : safety_status_typ;
	END_STRUCT;
	safety_cmd_typ : 	STRUCT 
		reset : BOOL; (*command for resetting safety*)
	END_STRUCT;
	safety_status_typ : 	STRUCT 
		safetyStarted : BOOL; (*TRUE if safety application is running*)
		safetyOk : BOOL; (*TRUE if safety chain ok and reset not needed*)
		resetNeeded : BOOL; (*TRUE if safety has tripped and needs a reset*)
	END_STRUCT;
END_TYPE
