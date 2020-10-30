
PROGRAM _INIT
	(* Insert code here *)
	AddJob :=FALSE;
	NeedPartcell1Bool :=FALSE;
	NeedPartCell2Bool :=FALSE;
	EmptyFixtureCell1Bool :=FALSE;
	EmptyFixtureCell2Bool :=FALSE;
	MoveAssemblyBool :=FALSE;
	brestart := FALSE;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	IF NeedPartcell1Bool AND EDGEPOS(AddJob) THEN
		NeedPartCell1 := NeedPartCell1 + 1;
	END_IF
	IF NeedPartCell2Bool AND EDGEPOS(AddJob) THEN
		NeedPartCell2 := NeedPartCell2 + 1;
	END_IF	
	IF EmptyFixtureCell1Bool AND EDGEPOS(AddJob) THEN
		EmptyFixtureCell1 := EmptyFixtureCell1 + 1;
	END_IF
	IF EmptyFixtureCell2Bool AND EDGEPOS(AddJob) THEN
		EmptyFixtureCell2 := EmptyFixtureCell2 + 1;
	END_IF
	IF MoveAssemblyBool AND EDGEPOS(AddJob) THEN
		MoveAssemblyPart := MoveAssemblyPart + 1;
	END_IF
	IF MoveSubAssemblyPartBool AND EDGEPOS(AddJob) THEN
		MoveSubAssemblyPart := MoveAssemblyPart + 1;
	END_IF
	
	SYSreset(brestart,bootmode);
	
	IF EDGEPOS(AddJob) THEN
		NeedPartcell1Bool := FALSE;
		NeedPartCell2Bool := FALSE;
		EmptyFixtureCell1Bool := FALSE;
		EmptyFixtureCell2Bool := FALSE;
		MoveAssemblyBool := FALSE;
		MoveSubAssemblyPartBool := FALSE;
	END_IF
		
	IF HMILoadOffTrack AND WaitingLoadOff THEN
		LoadOffTrack := TRUE;
	END_IF
	IF HMILoadOnTrack AND WaitingLoadOn THEN
		LoadOnTrack := TRUE;
	END_IF
	IF HMITaskCompleteCell1 AND WaitingCell1 THEN
		TaskCompleteCell1 := TRUE;
	END_IF
	IF HMITaskCompleteCell2 AND WaitingCell2 THEN
		TaskCompleteCell2 := TRUE;
	END_IF
	
	
	
	
		
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

