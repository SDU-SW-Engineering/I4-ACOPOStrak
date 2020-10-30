
TYPE
	trak_parameter_typ : 	STRUCT 
		velocity : REAL;
		acceleration : REAL;
		deceleration : REAL;
		selector : trak_parameter_selector_typ;
	END_STRUCT;
	trak_parameter_selector_typ : 
		(
		TRAK_SELECTOR_ALL := 0,
		TRAK_SELECTOR_NONE := 1,
		TRAK_SELECTOR_2ND := 2,
		TRAK_SELECTOR_3RD := 3,
		TRAK_SELECTOR_4TH := 4
		);
END_TYPE
