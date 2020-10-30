
PROGRAM _INIT
	
	MpAlarmXCore_0(MpLink:=ADR(gAlarmXCore), Enable:=TRUE);
	
	MpAlarmXHistory_0(MpLink:=ADR(gAlarmXHistory), Enable:=TRUE);
	
END_PROGRAM

PROGRAM _CYCLIC
	
	MpAlarmXCore_0(MpLink:=ADR(gAlarmXCore));
	
	MpAlarmXHistory_0(MpLink:=ADR(gAlarmXHistory));
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

