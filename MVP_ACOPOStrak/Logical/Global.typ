(*shuttle-UserData structure*)

TYPE
	ShuttleUserData_typ : 	STRUCT 
		Task : ShuttleTask_enum;
		Partnumber : UDINT; (*example: product part number*)
		State : ShuttleState_enum;
	END_STRUCT;
	ShuttleTask_enum : 
		(
		NoTask,
		PartsToCell1,
		PartsFromCell1,
		PartsToCell2,
		PartsFromCell2,
		MoveSubAssembly,
		MoveAssembly
		);
	ShuttleState_enum : 
		(
		WaitingNewCommand,
		StartingProcess,
		InProcess,
		InPosition
		);
END_TYPE

(*Assembly Interface Type*)

TYPE
	TrakAsmCommand_type : 	STRUCT 
		Power : BOOL;
		ShuttleStart : BOOL;
		ShuttleStop : {REDUND_UNREPLICABLE} BOOL;
	END_STRUCT;
	TrakAsmParameter_type : 	STRUCT 
		Velocity : REAL;
		Acceleration : REAL;
		Deceleration : REAL;
	END_STRUCT;
	TrakAsmStatus_type : 	STRUCT 
		Disabled : BOOL;
		Ready : BOOL;
		Homing : BOOL;
		Stopping : BOOL;
		ErrorStop : BOOL;
	END_STRUCT;
	TrakAsm_type : 	STRUCT 
		Command : TrakAsmCommand_type;
		Parameter : TrakAsmParameter_type;
		Status : TrakAsmStatus_type;
	END_STRUCT;
END_TYPE
