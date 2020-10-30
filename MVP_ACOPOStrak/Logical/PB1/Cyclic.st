

PROGRAM _CYCLIC
	CASE Step OF
		CHECK_TRIGGER:
(* When the process is enabled and the assembly is ready,
the process will be activated *)
			IF((CmdEnableProcess) AND (gTrakAsm.Status.Ready))THEN
				MC_BR_TrgPointEnable_AcpTrak_0.Enable := TRUE;
(* If a shuttle passes the triggerpoint then
get the axis reference *)
				IF((MC_BR_TrgPointEnable_AcpTrak_0.Valid) AND
					(MC_BR_TrgPointEnable_AcpTrak_0.EventCount > 0))THEN
					MC_BR_TrgPointGetInfo_AcpTrak_0.Execute := TRUE;
				END_IF
			ELSE (* Else the processpoint will be disabled *)
				MC_BR_TrgPointEnable_AcpTrak_0.Enable := FALSE;
			END_IF
(* If axis reference is available,
save it AND go TO the next step *)
			IF EDGEPOS(MC_BR_TrgPointGetInfo_AcpTrak_0.Done) THEN
(* Save axis reference in local variable for use
in step machine *)
				ShuttleAxis := MC_BR_TrgPointGetInfo_AcpTrak_0.TrgPointInfo.Axis;
				MC_BR_TrgPointGetInfo_AcpTrak_0.Execute := FALSE;
				Step := GET_USERDATA;
				END_IF
				
		GET_USERDATA:
			(* The userdata is copied on a local variable *)
			MC_BR_ShCopyUserData_AcpTrak_0.Axis := ADR(ShuttleAxis);
			MC_BR_ShCopyUserData_AcpTrak_0.Execute := TRUE;
			MC_BR_ShCopyUserData_AcpTrak_0.DataAddress := ADR(ShuttleUserData);
			MC_BR_ShCopyUserData_AcpTrak_0.DataSize := SIZEOF(ShuttleUserData);
			MC_BR_ShCopyUserData_AcpTrak_0.Mode := mcACPTRAK_USERDATA_GET;
					(* After copying go to the next step *)
					
			IF EDGEPOS(MC_BR_ShCopyUserData_AcpTrak_0.Done) THEN
				MC_BR_ShCopyUserData_AcpTrak_0.Execute := FALSE;
				Step := PROCESS;
					END_IF
					
		PROCESS:
	
					
					IF 	MoveAssemblyPart >= 1 AND NOT Track6_Occupied THEN
						Track6_Occupied := TRUE;
						ShuttleUserData.State := InProcess;
						ShuttleUserData.Task := MoveAssembly;
						MoveAssemblyPart := MoveAssemblyPart-1;
						MC_BR_RoutedMoveAbs_AcpTrak_0.Execute := FALSE;
						PickupTimer.IN := TRUE;
						PickupTimer.PT := T#2s;
						WaitingCommand := FALSE;
						CommandGiven := TRUE;
						Step := SET_USERDATA;	
					ELSIF 	EmptyFixtureCell1 >= 1 THEN
						ShuttleUserData.State := InProcess;
						ShuttleUserData.Task := PartsFromCell1;
						EmptyFixtureCell1 := EmptyFixtureCell1-1;
						MC_BR_RoutedMoveAbs_AcpTrak_0.Execute := FALSE;
						WaitingCommand := FALSE;
						CommandGiven := TRUE;
						Step := SET_USERDATA;	
					ELSIF 	EmptyFixtureCell2 >= 1 THEN
						ShuttleUserData.State := InProcess;
						ShuttleUserData.Task := PartsFromCell2;
						EmptyFixtureCell2 := EmptyFixtureCell2-1;
						MC_BR_RoutedMoveAbs_AcpTrak_0.Execute := FALSE;
						WaitingCommand := FALSE;
						CommandGiven := TRUE;
						Step := SET_USERDATA;	
					ELSIF	NeedPartCell1 >= 1 AND NOT Track6_Occupied THEN
						Track6_Occupied := TRUE;
						ShuttleUserData.State := InProcess;
						ShuttleUserData.Task := PartsToCell1;
						NeedPartCell1 := NeedPartCell1-1;
						MC_BR_RoutedMoveAbs_AcpTrak_0.Execute := FALSE;
						WaitingCommand := FALSE;
						CommandGiven := TRUE;
						PickupTimer.IN := TRUE;
						PickupTimer.PT := T#2s;
						Step := SET_USERDATA;
					ELSIF 	NeedPartCell2 >= 1 AND NOT Track6_Occupied THEN
						Track6_Occupied := TRUE;
						ShuttleUserData.State := InProcess;
						ShuttleUserData.Task := PartsToCell2;
						NeedPartCell2 := NeedPartCell2-1;
						MC_BR_RoutedMoveAbs_AcpTrak_0.Execute := FALSE;
						WaitingCommand := FALSE;
						CommandGiven := TRUE;
						PickupTimer.IN := TRUE;
						PickupTimer.PT := T#2s;
			  			Step := SET_USERDATA;
					ELSIF 	MoveSubAssemblyPart >= 1 AND NOT Track6_Occupied THEN
						Track6_Occupied := TRUE;
						ShuttleUserData.State := InProcess;
						ShuttleUserData.Task := MoveSubAssembly;
						MoveSubAssemblyPart := MoveSubAssemblyPart-1;
						MC_BR_RoutedMoveAbs_AcpTrak_0.Execute := FALSE;
						PickupTimer.IN := TRUE;
						PickupTimer.PT := T#2s;
						WaitingCommand := FALSE;
						CommandGiven := TRUE;
						Step := SET_USERDATA;
					ELSE
						ShuttleUserData.State := InProcess;
						ShuttleUserData.Task := NoTask;
						MC_BR_RoutedMoveAbs_AcpTrak_0.Execute := FALSE;
						WaitingCommand := FALSE;
						CommandGiven := TRUE;
						Step := SET_USERDATA;
					END_IF
					
					
		SET_USERDATA:
			(* The modified userdata will be copied back on the shuttle *)
			MC_BR_ShCopyUserData_AcpTrak_0.Axis := ADR(ShuttleAxis);
			MC_BR_ShCopyUserData_AcpTrak_0.Execute := TRUE;
			MC_BR_ShCopyUserData_AcpTrak_0.DataAddress := ADR(ShuttleUserData);
			MC_BR_ShCopyUserData_AcpTrak_0.DataSize := SIZEOF(ShuttleUserData);
			MC_BR_ShCopyUserData_AcpTrak_0.Mode := mcACPTRAK_USERDATA_SET;

			(* After copying go to the first step and wait for new event *)
			IF EDGEPOS(MC_BR_ShCopyUserData_AcpTrak_0.Done) THEN
				MC_BR_ShCopyUserData_AcpTrak_0.Execute := FALSE;
				Step := CHECK_TRIGGER;
			END_IF
	END_CASE
	
	
	IF EmptyFixtureCell1+EmptyFixtureCell2 >= 1 AND NOT CommandGiven AND NOT PickupTimer.IN AND NOT TON_0.IN AND NOT WaitingCommand THEN
		TaskReady := TRUE;
		MC_BR_BarrierCommand_AcpTrak_0.Command := 2;
		MC_BR_BarrierCommand_AcpTrak_0.Execute := TRUE;	
		WaitingCommand := TRUE;
		TON_0.IN := TRUE;
		TON_0.PT :=T#500ms;
	ELSIF NeedPartCell1+NeedPartCell2+MoveAssemblyPart+MoveSubAssemblyPart >= 1 AND NOT CommandGiven AND NOT Track6_Occupied AND NOT TON_0.IN AND NOT WaitingCommand THEN
		TaskReady := TRUE;	
		MC_BR_BarrierCommand_AcpTrak_0.Command := 2;
		MC_BR_BarrierCommand_AcpTrak_0.Execute := TRUE;
		WaitingCommand := TRUE;
		TON_0.IN := TRUE;
		TON_0.PT :=T#500ms;
	ELSE
		TaskReady := FALSE;	
		MC_BR_BarrierCommand_AcpTrak_0.Execute := FALSE;
		CommandGiven := FALSE; 
	END_IF	
	
	IF TON_0.Q THEN
		TON_0.IN := FALSE;
	END_IF
	
	IF PickupTimer.Q THEN
		PickupTimer.IN := FALSE;
	END_IF
	
	
	IF EDGEPOS(HMI_Barrier_Open) THEN
		MC_BR_BarrierCommand_AcpTrak_0.Command := 0;
		MC_BR_BarrierCommand_AcpTrak_0.Execute := TRUE;
	ELSIF EDGEPOS(HMI_Barrier_Close) THEN
		MC_BR_BarrierCommand_AcpTrak_0.Command := 1;
		MC_BR_BarrierCommand_AcpTrak_0.Execute := TRUE;
	END_IF
		
	(* Call all function blocks *)
	MC_BR_TrgPointEnable_AcpTrak_0();
	MC_BR_TrgPointGetInfo_AcpTrak_0();
	MC_BR_ShCopyUserData_AcpTrak_0();
	MC_BR_RoutedMoveAbs_AcpTrak_0();
	MC_BR_BarrierCommand_AcpTrak_0();
	PickupTimer();
	TON_0();
	
	
	
	
END_PROGRAM
PROGRAM _EXIT
END_PROGRAM