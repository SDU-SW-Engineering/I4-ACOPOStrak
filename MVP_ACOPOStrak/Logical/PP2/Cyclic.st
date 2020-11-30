

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
			
		IF ShuttleUserData.Task = PartsToCell1 OR ShuttleUserData.Task = PartsFromCell1 OR ShuttleUserData.Task = MoveAssembly THEN	
			
			MC_BR_RoutedMoveVel_AcpTrak_0.Axis := ADR(ShuttleAxis);
			MC_BR_RoutedMoveVel_AcpTrak_0.Execute := TRUE;
			MC_BR_RoutedMoveVel_AcpTrak_0.Sector := ADR(SectorTrack2);
			MC_BR_RoutedMoveVel_AcpTrak_0.Position := 0;
			MC_BR_RoutedMoveVel_AcpTrak_0.Velocity := Speed_PP_04;
			MC_BR_RoutedMoveVel_AcpTrak_0.RouteVelocity := Speed_PP_04;
			MC_BR_RoutedMoveVel_AcpTrak_0.Acceleration := 10;
			MC_BR_RoutedMoveVel_AcpTrak_0.Deceleration := 10;
			MC_BR_RoutedMoveVel_AcpTrak_0.Jerk := 0.0;
			MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.StartDirection := mcDIR_UNDEFINED;
			MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.ShuttleOrientation := mcDIR_NEGATIVE;
			MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.EndDirection := mcDIR_UNDEFINED;
			
			
			IF EDGEPOS (MC_BR_RoutedMoveVel_AcpTrak_0.Active) THEN
				MC_BR_RoutedMoveVel_AcpTrak_0.Execute := FALSE;
				Step := SET_USERDATA;
				END_IF
			ELSE
				
				MC_BR_RoutedMoveVel_AcpTrak_0.Axis := ADR(ShuttleAxis);
				MC_BR_RoutedMoveVel_AcpTrak_0.Execute := TRUE;
				MC_BR_RoutedMoveVel_AcpTrak_0.Sector := ADR(SectorTrack1);
				MC_BR_RoutedMoveVel_AcpTrak_0.Position := 5;
				MC_BR_RoutedMoveVel_AcpTrak_0.Velocity := Speed_PP_04;
				MC_BR_RoutedMoveVel_AcpTrak_0.RouteVelocity := Speed_PP_04;
				MC_BR_RoutedMoveVel_AcpTrak_0.Acceleration := 10;
				MC_BR_RoutedMoveVel_AcpTrak_0.Deceleration := 10;
				MC_BR_RoutedMoveVel_AcpTrak_0.Jerk := 0.0;
				MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.StartDirection := mcDIR_POSITIVE;
				MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.ShuttleOrientation := mcDIR_UNDEFINED;
				MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.EndDirection := mcDIR_UNDEFINED;	
				
				
				IF EDGEPOS (MC_BR_RoutedMoveVel_AcpTrak_0.Active) THEN
					MC_BR_RoutedMoveVel_AcpTrak_0.Execute := FALSE;
					Step := SET_USERDATA;
				END_IF
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
	
	(* Call all function blocks *)
	MC_BR_TrgPointEnable_AcpTrak_0();
	MC_BR_TrgPointGetInfo_AcpTrak_0();
	MC_BR_ShCopyUserData_AcpTrak_0();
	MC_BR_RoutedMoveVel_AcpTrak_0();
	MC_BR_BarrierCommand_AcpTrak_0();

	
	
	
	
END_PROGRAM
PROGRAM _EXIT
END_PROGRAM