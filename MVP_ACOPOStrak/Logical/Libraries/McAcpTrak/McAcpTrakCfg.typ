TYPE
	McSCSegPosRelToEnum :
		( (*Absolute position from which the position is counted*)
		mcSCSPRT_ST_OF_SEG := 0, (*Start of segment - Positive from start of segment*)
		mcSCSPRT_END_OF_SEG := 1 (*End of segment - Negative from end of segment*)
		);
	McSCSegType : STRUCT (*Begin of the sector*)
		SegmentReference : STRING[250]; (*Name of the referenced segment component*)
		Position : LREAL; (*Position on the segment [Measurement units]*)
		PositionRelativeTo : McSCSegPosRelToEnum; (*Absolute position from which the position is counted*)
	END_STRUCT;
	McSCIntmSegType : STRUCT (*Segments between the start and the end segment*)
		SegmentReference : McCfgUnboundedArrayType; (*Name of the referenced segment component*)
	END_STRUCT;
	McCfgSecCompType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_SEC_COMP*)
		StartSegment : McSCSegType; (*Begin of the sector*)
		IntermediateSegments : McSCIntmSegType; (*Segments between the start and the end segment*)
		EndSegment : McSCSegType; (*End of the sector*)
	END_STRUCT;
	McSSStPosRelToEnum :
		( (*Absolute position from which the position is counted*)
		mcSSSPRT_ST_OF_SEC := 0, (*Start of sector - Tail of the sector*)
		mcSSSPRT_END_OF_SEC := 1 (*End of sector - Head of the sector*)
		);
	McSSStType : STRUCT (*Begin of the sector*)
		Position : LREAL; (*Position on the sector [Measurement units]*)
		PositionRelativeTo : McSSStPosRelToEnum; (*Absolute position from which the position is counted*)
	END_STRUCT;
	McSSDirEnum :
		( (*Direction of the sub sector*)
		mcSSD_POS := 0, (*Positive - Same direction as sector*)
		mcSSD_NEG := 1 (*Negative - Opposite direction of sector*)
		);
	McCfgSecSubType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_SEC_SUB*)
		SectorReference : McCfgReferenceType; (*Name of the referenced sector component*)
		Start : McSSStType; (*Begin of the sector*)
		Length : LREAL; (*Length of the sub sector [Measurement units]*)
		Direction : McSSDirEnum; (*Direction of the sub sector*)
	END_STRUCT;
END_TYPE