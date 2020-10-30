PROGRAM _INIT
    (* Set Shuttlepositions for Simulation (Starting at Position 0 on specified Sector) *)
	FOR i := 1 TO NUM_SIM_SHUTTLES DO
		SimShuttlePosition[i] := 0.15 * (i - 1);
	END_FOR
    
	(* Init Parameters for Shuttle movements *)
	gTrakAsm.Parameter.Velocity := 0.5;
	gTrakAsm.Parameter.Acceleration := 20;
	gTrakAsm.Parameter.Deceleration := 20;
    
	(* Write this value into the Size of Userdata in the Shuttle Stereotype configuration *)
	SizeofUserdata := SIZEOF(gShuttleUserData);

	(* Assembly reference for FUB's *)
	MC_BR_AsmPowerOn_AcpTrak_0.Assembly     := ADR(gAssembly_1);
	MC_BR_AsmGetShuttle_AcpTrak_0.Assembly  := ADR(gAssembly_1);
	MC_BR_AsmPowerOff_AcpTrak_0.Assembly    := ADR(gAssembly_1);
	MC_BR_AsmReadStatus_AcpTrak_0.Assembly  := ADR(gAssembly_1);
	MC_BR_AsmReset_AcpTrak_0.Assembly       := ADR(gAssembly_1);
    
	(* Enable reading of current status of the assembly *)
	MC_BR_AsmReadStatus_AcpTrak_0.Enable := TRUE;
    
END_PROGRAM

PROGRAM _CYCLIC

	IF HMI_Start THEN
		gTrakAsm.Command.Power := TRUE;
	END_IF
	
	IF HMI_stop THEN
		gTrakAsm.Command.Power := FALSE;
	END_IF		

	
	
	CASE Step OF
    
			(*        Assemply power off and waiting for power on command        *)
		POWER_OFF:
			Status := 'Power Off';
			IF EDGEPOS(MC_BR_AsmPowerOff_AcpTrak_0.Done) THEN    (* When power off is done, delete the shuttle reference *)
				MC_BR_AsmPowerOff_AcpTrak_0.Execute := FALSE;
				brsmemset(ADR(ShuttleAxis), 0, SIZEOF(ShuttleAxis));
			ELSIF NOT(gTrakAsm.Status.Disabled) THEN             (* Assembly is not powered off yet *)
				MC_BR_AsmPowerOff_AcpTrak_0.Execute := TRUE;
			ELSIF (gTrakAsm.Command.Power) THEN
				Step := POWER_ON;
			END_IF

			(*        Assembly power ON        *)
		POWER_ON:
			Status := 'Power On';
			MC_BR_AsmPowerOn_AcpTrak_0.Execute := TRUE;
            
			IF EDGEPOS(MC_BR_AsmPowerOn_AcpTrak_0.Done)THEN
				CntShuttle := 1;
				IF NOT DiagCpuIsARsim() THEN
					Step := GET_SHUTTLE;
				ELSIF NOT(Shuttles_exist) THEN
					Step := ADD_SHUTTLE;
				ELSE
					Step := READY;
				END_IF
			END_IF
			(*        Adding Shuttles for simulation (These steps are not needed on real Hardware)        *)
		ADD_SHUTTLE:
			Status := 'Add_Shuttle';
			IF (MC_BR_SecAddShuttle_AcpTrak_0.Done) THEN
				CntShuttle := CntShuttle + 1;
			ELSIF (CntShuttle <= NUM_SIM_SHUTTLES) THEN
				MC_BR_SecAddShuttle_AcpTrak_0.Sector   := ADR(SectorTrack1);
				MC_BR_SecAddShuttle_AcpTrak_0.Execute  := TRUE;
				MC_BR_SecAddShuttle_AcpTrak_0.Position := SimShuttlePosition[CntShuttle];
				MC_BR_SecAddShuttle_AcpTrak_0.AdvancedParameters.Velocity := 0.0;
			ELSE
				CntShuttle := 1;
				Step := GET_SHUTTLE; 
			END_IF
        
			(*        Get all available on the assembly (physically available on the real hardware or the added ones in the simulation)        *)
		GET_SHUTTLE:
			Status := 'Get_Shuttle';
			MC_BR_AsmGetShuttle_AcpTrak_0.Enable := TRUE;
            
			IF (MC_BR_AsmGetShuttle_AcpTrak_0.Valid) THEN
				IF (MC_BR_AsmGetShuttle_AcpTrak_0.RemainingCount <> (MC_BR_AsmGetShuttle_AcpTrak_0.TotalCount - CntShuttle)) THEN
					CntShuttle := CntShuttle + 1;
					MC_BR_AsmGetShuttle_AcpTrak_0.Next := FALSE;
				ELSE
					ShuttleAxis[CntShuttle] := MC_BR_AsmGetShuttle_AcpTrak_0.Axis;    (*Save all Axis References to an array for global movement commands*)
					MC_BR_AsmGetShuttle_AcpTrak_0.Next := TRUE;   (*Get next Shuttle reference with positive Edge on .next*)
					
					
					IF (MC_BR_AsmGetShuttle_AcpTrak_0.RemainingCount = 0) THEN
						MC_BR_AsmGetShuttle_AcpTrak_0.Enable := FALSE;
						MC_BR_AsmGetShuttle_AcpTrak_0.Next := FALSE;
						Shuttles_exist := TRUE;
						Step := READY;
					END_IF
				END_IF
			END_IF
        
			(*        Assembly Active and ready for movement        *)
		READY:
			Status := 'Ready';
			IF (gTrakAsm.Command.Power = FALSE) THEN     (*Power Off Command*)
				Step := POWER_OFF;
			ELSIF (gTrakAsm.Command.ShuttleStart) THEN   (*Waiting for Movement command*)
				gTrakAsm.Command.ShuttleStart := FALSE;
				CntShuttle := 1;
				Step := PROCESS;
			END_IF
    
			(*             Accelerate all shuttles in assembly via the same target position to the same velocity            *)
			(* Used for startup, to accelerate all shuttles to an initial velocity in order to pass the first process-point *)
		PROCESS:
			Status := 'Process';
			IF EDGEPOS(MC_BR_RoutedMoveVel_AcpTrak_0.Active) THEN
				CntShuttle := CntShuttle + 1;
				MC_BR_RoutedMoveVel_AcpTrak_0.Execute := FALSE;
			ELSIF (CntShuttle > 0) THEN
				IF (ShuttleAxis[CntShuttle].controlif <> 0) THEN 
					MC_BR_RoutedMoveVel_AcpTrak_0.Axis          := ADR(ShuttleAxis[CntShuttle]);
					MC_BR_RoutedMoveVel_AcpTrak_0.Execute       := TRUE;
                    
					MC_BR_RoutedMoveVel_AcpTrak_0.Sector        := ADR(SectorTrack1);
					MC_BR_RoutedMoveVel_AcpTrak_0.Position      := SimShuttlePosition[NUM_SIM_SHUTTLES] + 0.15;
					MC_BR_RoutedMoveVel_AcpTrak_0.Velocity      := gTrakAsm.Parameter.Velocity;
					MC_BR_RoutedMoveVel_AcpTrak_0.RouteVelocity := gTrakAsm.Parameter.Velocity;
					MC_BR_RoutedMoveVel_AcpTrak_0.Acceleration  := gTrakAsm.Parameter.Acceleration;
					MC_BR_RoutedMoveVel_AcpTrak_0.Deceleration  := gTrakAsm.Parameter.Deceleration;
					MC_BR_RoutedMoveVel_AcpTrak_0.Jerk          := 0.0;
					MC_BR_RoutedMoveVel_AcpTrak_0.BufferMode    := mcABORTING;
					MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.StartDirection     := mcDIR_UNDEFINED;
					MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.EndDirection       := mcDIR_POSITIVE;
					MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.ShuttleOrientation := mcDIR_UNDEFINED;
				END_IF
			END_IF
			
			
			
			IF PowerOffTrack2 THEN
				
				MC_BR_SegPowerOff_AcpTrak_0.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_1.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_2.Execute := TRUE;
//				MC_BR_SegPowerOff_AcpTrak_3.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_4.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_5.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_6.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_7.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_8.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_9.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_0.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_1.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_2.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_3.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_4.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_5.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_6.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_7.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_8.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_9.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_0.Segment := ADR(SEG_2_74);
				MC_BR_SegPowerOff_AcpTrak_1.Segment := ADR(SEG_2_75);
				MC_BR_SegPowerOff_AcpTrak_2.Segment := ADR(SEG_2_76);
//				MC_BR_SegPowerOff_AcpTrak_3.Segment := ADR(SEG_2_77);
				MC_BR_SegPowerOff_AcpTrak_4.Segment := ADR(SEG_2_78);
				MC_BR_SegPowerOff_AcpTrak_5.Segment := ADR(SEG_2_79);
				MC_BR_SegPowerOff_AcpTrak_6.Segment := ADR(SEG_2_80);
				MC_BR_SegPowerOff_AcpTrak_7.Segment := ADR(SEG_2_81);
				MC_BR_SegPowerOff_AcpTrak_8.Segment := ADR(SEG_2_82);
				MC_BR_SegPowerOff_AcpTrak_9.Segment := ADR(SEG_2_83);
				
		
	
			ELSIF MC_BR_SegPowerOff_AcpTrak_0.Execute AND NOT PowerOffTrack2 THEN
				
				MC_BR_SegPowerOn_AcpTrak_0.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_1.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_2.Execute := TRUE;
//				MC_BR_SegPowerOn_AcpTrak_3.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_4.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_5.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_6.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_7.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_8.Execute := TRUE;
				MC_BR_SegPowerOn_AcpTrak_9.Execute := TRUE;
				MC_BR_SegPowerOff_AcpTrak_0.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_1.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_2.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_3.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_4.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_5.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_6.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_7.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_8.Execute := FALSE;
				MC_BR_SegPowerOff_AcpTrak_9.Execute := FALSE;
				MC_BR_SegPowerOn_AcpTrak_0.Segment := ADR(SEG_2_74);
				MC_BR_SegPowerOn_AcpTrak_1.Segment := ADR(SEG_2_75);
				MC_BR_SegPowerOn_AcpTrak_2.Segment := ADR(SEG_2_76);
//				MC_BR_SegPowerOn_AcpTrak_3.Segment := ADR(SEG_2_77);
				MC_BR_SegPowerOn_AcpTrak_4.Segment := ADR(SEG_2_78);
				MC_BR_SegPowerOn_AcpTrak_5.Segment := ADR(SEG_2_79);
				MC_BR_SegPowerOn_AcpTrak_6.Segment := ADR(SEG_2_80);
				MC_BR_SegPowerOn_AcpTrak_7.Segment := ADR(SEG_2_81);
				MC_BR_SegPowerOn_AcpTrak_7.Segment := ADR(SEG_2_82);
				MC_BR_SegPowerOn_AcpTrak_9.Segment := ADR(SEG_2_83);
		
			END_IF
            
			IF(gTrakAsm.Command.ShuttleStop) AND (CntShuttle > NUM_SIM_SHUTTLES) THEN   (*Waiting for Stop command*)
				CntShuttle := 1;
				Step := STOPPING;
			END_IF
            
			(* When there is invalid speed or acceleration setting, or shuttle caused ErrorStop *)
			IF (MC_BR_RoutedMoveVel_AcpTrak_0.Error) THEN
				MC_BR_AsmReset_AcpTrak_0.Execute := TRUE;
				Step := RESET;
			END_IF
        
			(*        Stop all Shuttles with specified Deceleration at their current location        *)
		STOPPING:
			Status := 'Stopping';
			IF EDGEPOS(MC_Stop_0.Done) THEN
				CntShuttle := CntShuttle + 1;
				MC_Stop_0.Execute := FALSE;
			ELSIF (ShuttleAxis[CntShuttle].controlif <> 0) AND NOT(MC_Stop_0.Busy) THEN
				MC_Stop_0.Axis         := ADR(ShuttleAxis[CntShuttle]);
				MC_Stop_0.Execute      := TRUE;
				MC_Stop_0.Deceleration := 20;
				MC_Stop_0.Jerk         := 0.0;
				MC_BR_RoutedMoveVel_AcpTrak_0.Execute := FALSE;
			END_IF
        
			IF EDGEPOS(MC_Stop_0.Done) AND (CntShuttle > NUM_SIM_SHUTTLES) THEN (* Back to ready, after every shuttle on the trak has stopped *)
				gTrakAsm.Command.ShuttleStop := FALSE;
				Step := READY;
			END_IF
        
			(*        Reset Assembly due to an error        *)
		RESET:
			Status := 'Reset';
			IF EDGEPOS(MC_BR_AsmReset_AcpTrak_0.Done) THEN
				gTrakAsm.Command.ShuttleStart    := FALSE;
				gTrakAsm.Command.ShuttleStop     := FALSE;
				MC_BR_AsmReset_AcpTrak_0.Execute := FALSE;
				MC_BR_RoutedMoveVel_AcpTrak_0.Execute := FALSE;
                
				Step := READY;
			END_IF
        
	END_CASE
    
	(* Read Assembly status cyclic to Assembly interface *)
	gTrakAsm.Status.Disabled  := MC_BR_AsmReadStatus_AcpTrak_0.AssemblyDisabled;
	gTrakAsm.Status.Ready     := MC_BR_AsmReadStatus_AcpTrak_0.AssemblyReady;
	gTrakAsm.Status.Homing    := MC_BR_AsmReadStatus_AcpTrak_0.AssemblyHoming;
	gTrakAsm.Status.Stopping  := MC_BR_AsmReadStatus_AcpTrak_0.AssemblyStopping;
	gTrakAsm.Status.ErrorStop := MC_BR_AsmReadStatus_AcpTrak_0.AssemblyErrorStop;
    
	(*        Cyclic FUB call        *)
	MC_BR_AsmPowerOn_AcpTrak_0();
	MC_BR_AsmPowerOn_AcpTrak_0.Execute := FALSE;
	MC_BR_SecAddShuttle_AcpTrak_0();
	MC_BR_SecAddShuttle_AcpTrak_0.Execute := FALSE;
	MC_BR_AsmGetShuttle_AcpTrak_0();
	MC_BR_AsmPowerOff_AcpTrak_0();
	MC_BR_RoutedMoveVel_AcpTrak_0();
	MC_Stop_0();
	MC_BR_AsmReadStatus_AcpTrak_0();
	MC_BR_AsmReset_AcpTrak_0();
	MC_BR_SegPowerOff_AcpTrak_0();
	MC_BR_SegPowerOff_AcpTrak_1();
	MC_BR_SegPowerOff_AcpTrak_2();
	MC_BR_SegPowerOff_AcpTrak_3();
	MC_BR_SegPowerOff_AcpTrak_4();
	MC_BR_SegPowerOff_AcpTrak_5();
	MC_BR_SegPowerOff_AcpTrak_6();
	MC_BR_SegPowerOff_AcpTrak_7();
	MC_BR_SegPowerOff_AcpTrak_8();
	MC_BR_SegPowerOff_AcpTrak_9();
	MC_BR_SegPowerOn_AcpTrak_0();
	MC_BR_SegPowerOn_AcpTrak_1();
	MC_BR_SegPowerOn_AcpTrak_2();
	MC_BR_SegPowerOn_AcpTrak_3();
	MC_BR_SegPowerOn_AcpTrak_4();
	MC_BR_SegPowerOn_AcpTrak_5();
	MC_BR_SegPowerOn_AcpTrak_6();
	MC_BR_SegPowerOn_AcpTrak_7();
	MC_BR_SegPowerOn_AcpTrak_8();
	MC_BR_SegPowerOn_AcpTrak_9();
	
	
	IF EmptyFixtureCell1 = 1 AND EmptyFixtureCell2 = 1 AND NeedPartCell1 = 1 AND NeedPartCell2 = 1 AND MoveAssemblyPart = 1 AND TaskCompleteCell1 AND TaskCompleteCell2 AND LoadOnTrack AND LoadOffTrack THEN
		Ok := TRUE;
	END_IF
    
END_PROGRAM