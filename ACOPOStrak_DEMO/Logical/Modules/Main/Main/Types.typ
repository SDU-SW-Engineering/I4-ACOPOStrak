
TYPE
	local_typ : 	STRUCT 
		shuttleCount : USINT; (*nr of shuttles added*)
		shuttleFub : ARRAY[0..MAX_NUM_SHUTTLES]OF shuttleFub_typ;
	END_STRUCT;
	shuttleFub_typ : 	STRUCT 
		MC_Stop_0 : MC_Stop; (*Function block for stopping shuttles*)
	END_STRUCT;
END_TYPE
