
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	IF resetNeeded THEN
		Safety_Status := 'Reset Needed';
	ELSIF safetyOK THEN
		Safety_Status := 'Safety OK';
	END_IF
	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

