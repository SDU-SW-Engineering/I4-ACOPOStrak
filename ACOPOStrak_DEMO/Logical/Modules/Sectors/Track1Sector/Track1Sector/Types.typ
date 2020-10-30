
TYPE
	this_typ : 	STRUCT 
		axis : ARRAY[0..29]OF McAxisType;
		shiftSector : BOOL;
		userData : ShuttleUserData_typ;
		selector : trak_parameter_selector_typ;
		preAxis : McAxisType;
		counter : USINT;
	END_STRUCT;
END_TYPE
