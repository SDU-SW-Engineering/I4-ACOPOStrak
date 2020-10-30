
TYPE
	main_interface_typ : 	STRUCT 
		cmd : main_if_cmd_typ;
		status : main_if_status_typ;
	END_STRUCT;
	main_if_cmd_typ : 	STRUCT 
		reset : BOOL; (*Power on assembly*)
		start : BOOL; (*Start all shuttles*)
		stop : BOOL; (*Stop all shuttles*)
		clear : BOOL; (*Clear assembly error*)
		safety : main_if_cmd_safety_typ; (*safety*)
	END_STRUCT;
	main_if_cmd_safety_typ : 	STRUCT 
		reset : BOOL; (*reset safety*)
	END_STRUCT;
	main_if_status_typ : 	STRUCT 
		power : BOOL; (*power on*)
		ready : BOOL; (*ready to power on*)
		error : BOOL; (*assembly fault*)
		simulation : BOOL; (*target is simulated*)
		communication : BOOL; (*communication to all segments ok*)
		safety : main_if_status_safety_typ; (*safety*)
	END_STRUCT;
	main_if_status_safety_typ : 	STRUCT 
		moduleOK : BOOL; (*communication ok*)
		ready : BOOL; (*safety ready*)
		resetNeeded : BOOL; (*safety reset needed*)
		started : BOOL; (*safety running*)
	END_STRUCT;
END_TYPE
