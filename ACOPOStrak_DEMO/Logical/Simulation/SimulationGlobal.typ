
TYPE
	ShuttleUserData_typ : 	STRUCT 
		Color : ShuttleColor_enum; (*example: product colour*)
		Weight : REAL; (*example: product weight*)
		Partnumber : UDINT; (*example: product part number*)
	END_STRUCT;
	ShuttleColor_enum : 
		(
		SHUTTLE_COLOR_GREY := 0,
		SHUTTLE_COLOR_GREEN := 1,
		SHUTTLE_COLOR_RED := 2,
		SHUTTLE_COLOR_BLUE := 3,
		SHUTTLE_COLOR_WHITE := 4,
		SHUTTLE_COLOR_BLACK := 5,
		SHUTTLE_COLOR_YELLOW := 6,
		SHUTTLE_COLOR_PINK := 7,
		SHUTTLE_COLOR_BROWN := 8,
		SHUTTLE_COLOR_CYAN := 9,
		SHUTTLE_COLOR_ORANGE := 10
		);
END_TYPE