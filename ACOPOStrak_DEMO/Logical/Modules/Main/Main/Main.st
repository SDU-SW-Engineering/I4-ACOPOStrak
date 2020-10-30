
PROGRAM _INIT

    (* Write this value into the Size of Userdata in the Shuttle Stereotype configuration *)
    SizeofUserdata := SIZEOF(gShuttleUserData);

	//dummy call
	gTrack1;
	gTrack2;
	gTrack3;
	gTrack4;
	gTrack5;
	gTrack6;
	
    gMain.status.simulation := DiagCpuIsSimulated();
	IF gMain.status.simulation THEN
		gMain.cmd.reset := TRUE;
	END_IF
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	IF gMain.status.error THEN
		em.cmd.abort := TRUE;
	END_IF

	CASE em.mode OF

		MODE_PRODUCING:	// #1			
			CASE em.state OF
					
				STATE_STOPPED:
					
					CASE em.substate OF
						0:
							em.description := 'waiting for communication to segments is ok';
							IF gMain.status.communication THEN
								em.substate := 10;
							END_IF
						10:
							em.description := 'waiting for assembly ready signal - estop ok?';
							IF gMain.status.ready OR gMain.status.power THEN
								em.substate := 20;
							ELSIF NOT gMain.status.communication THEN
								em.substate := 0;
							END_IF
						20:
							em.description := 'track ready, waiting for reset cmd';
							IF gMain.cmd.reset THEN
								gMain.cmd.reset := FALSE;
								idx := this.shuttleCount := 0;
								em.cmd.reset	:= TRUE;
								em.cmd.sc 		:= TRUE;
							ELSIF NOT gMain.status.ready OR NOT gMain.status.communication THEN
								gMain.cmd.reset := FALSE;
								em.cmd.sc 		:= FALSE;
								em.substate := 0;
							END_IF
					END_CASE

				STATE_RESETTING:
				
					CASE em.substate OF
						0:
							em.description := 'power on';
							IF MC_BR_AsmReadStatus_AcpTrak_0.AssemblyReady AND MC_BR_AsmReadStatus_AcpTrak_0.Valid THEN
								MC_BR_AsmPowerOn_AcpTrak_0.Execute 	:= FALSE;
								em.substate							:= 10;
							ELSE
								MC_BR_AsmPowerOn_AcpTrak_0.Execute := TRUE;
							END_IF	
						10:
							em.description := 'check for shuttles on this sector';
							MC_BR_AsmGetShuttle_AcpTrak_0.Enable := TRUE;
							IF MC_BR_AsmGetShuttle_AcpTrak_0.Valid THEN
								idx := 0;
								em.substate := 20;
							END_IF
						20:
							em.description := 'loop through shuttles and save it';
							MC_BR_AsmGetShuttle_AcpTrak_0.Next := FALSE;
							IF MC_BR_AsmGetShuttle_AcpTrak_0.TotalCount > 0 THEN
								ShuttleAxis[idx] := MC_BR_AsmGetShuttle_AcpTrak_0.Axis;
								em.substate := 30;
							END_IF
						30:
							em.description := 'get next shuttle or move on';
							IF MC_BR_AsmGetShuttle_AcpTrak_0.RemainingCount > 0 THEN
								MC_BR_AsmGetShuttle_AcpTrak_0.Next := TRUE;
								idx := idx + 1;
								em.substate := 20;
							ELSE
								em.substate := SC;
							END_IF
						SC://state complete
							em.description := 'waiting for childs';
							this.shuttleCount := idx;
							idx := 0;
							MC_BR_AsmGetShuttle_AcpTrak_0.Enable := FALSE;
							em.cmd.sc := TRUE;
					END_CASE
					
				STATE_IDLE:
					em.description := 'Wait for start command';
					IF gMain.cmd.start THEN
						gMain.cmd.start := FALSE;
						em.cmd.start	:= TRUE;
						em.cmd.sc		:= TRUE;
					END_IF						
				
				STATE_STARTING:
					em.cmd.sc := TRUE;
					em.description := 'waiting for children';
							
				STATE_EXECUTE:
					em.description := 'Waiting for stop command';					 
					IF gMain.cmd.stop THEN
						gMain.cmd.stop 	:= FALSE;
						em.cmd.stop 	:= TRUE;
					END_IF
					em.cmd.sc := TRUE;		

				STATE_STOPPING:	
					em.description := 'Stop all shuttles - normal';
					FOR i := 0 TO MAX_NUM_SHUTTLES DO
						this.shuttleFub[i].MC_Stop_0.Deceleration := 10.0;
						this.shuttleFub[i].MC_Stop_0.Execute := TRUE;
					END_FOR
					em.cmd.sc := TRUE;	
				
				STATE_ABORTING:
					em.description := 'Stop all shuttles - fast';
					FOR i := 0 TO MAX_NUM_SHUTTLES DO
						this.shuttleFub[i].MC_Stop_0.Deceleration := 35.0;
						this.shuttleFub[i].MC_Stop_0.Execute := TRUE;
					END_FOR
					em.cmd.sc := TRUE;
					
				STATE_ABORTED:
					em.description := 'assembly fault';
					IF gMain.cmd.clear THEN
						gMain.cmd.clear := FALSE;
						em.cmd.clear := TRUE;
					END_IF
					
				STATE_CLEARING:
					CASE em.substate OF
						0:
							em.description := 'delete all shuttles';
							MC_BR_AsmDeleteShuttle_AcpTrak_0.Execute := TRUE;
							MC_BR_AsmDeleteShuttle_AcpTrak_0.Command :=  mcACPTRAK_SH_DELETE_ALL;
							em.substate := 10;
							
						10:
							em.description := 'waiting for delete all shuttles done';
							IF MC_BR_AsmDeleteShuttle_AcpTrak_0.Done THEN
								MC_BR_AsmDeleteShuttle_AcpTrak_0.Execute := FALSE;
								em.substate := 20;
							END_IF
							
						20:
							em.description := 'reset error';
							brsmemset(ADR(ShuttleAxis),0,SIZEOF(ShuttleAxis));
							MC_BR_AsmReset_AcpTrak_0.Execute := TRUE;
							em.substate := 30;
							
						30:
							em.description := 'waiting for error reset done';
							IF MC_BR_AsmReset_AcpTrak_0.Done OR NOT gMain.status.error THEN
								MC_BR_AsmReset_AcpTrak_0.Execute := FALSE;
								em.cmd.sc := TRUE;
							END_IF
					END_CASE
				
				ELSE	// if need add the missing states 
					em.cmd.sc := TRUE;

			END_CASE

		MODE_MANUAL: // #3
			CASE em.state OF

				STATE_STOPPED:		
					em.description := 'this is a good place to write what the module is waiting for';

				STATE_RESETTING:
				
				STATE_IDLE:

				STATE_STARTING:

				STATE_EXECUTE:

				STATE_STOPPING:

				ELSE	// if need add the missing states 
					em.cmd.sc := TRUE;

			END_CASE
		
		ELSE
			em.cmd.sc := TRUE;
	
	END_CASE
	
	
	FOR i := 0 TO MAX_NUM_SHUTTLES DO
		IF ShuttleAxis[i].controlif <> 0 THEN
			this.shuttleFub[i].MC_Stop_0.Axis			:= ADR(ShuttleAxis[i]);
			this.shuttleFub[i].MC_Stop_0.Deceleration	:= 2.0;
			this.shuttleFub[i].MC_Stop_0();
			IF this.shuttleFub[i].MC_Stop_0.Done THEN
				this.shuttleFub[i].MC_Stop_0.Execute := FALSE;
			END_IF
		ELSE
			this.shuttleFub[i].MC_Stop_0.Execute := FALSE;
		END_IF
	END_FOR	
	
	MC_BR_AsmPowerOn_AcpTrak_0.Assembly := ADR(gAssembly_1);
	MC_BR_AsmPowerOn_AcpTrak_0();
	
	MC_BR_AsmPowerOff_AcpTrak_0.Assembly := ADR(gAssembly_1);
	MC_BR_AsmPowerOff_AcpTrak_0();
	
	
	MC_BR_AsmReadStatus_AcpTrak_0.Assembly 	:= ADR(gAssembly_1);
	MC_BR_AsmReadStatus_AcpTrak_0.Enable	:= TRUE;
	MC_BR_AsmReadStatus_AcpTrak_0();
	
	MC_BR_AsmGetShuttle_AcpTrak_0.Assembly	:= ADR(gAssembly_1);
	MC_BR_AsmGetShuttle_AcpTrak_0();

	MC_BR_AsmReadInfo_AcpTrak_0.Assembly := ADR(gAssembly_1);
	MC_BR_AsmReadInfo_AcpTrak_0.Enable := TRUE;
	MC_BR_AsmReadInfo_AcpTrak_0();
	
	MC_BR_AsmReset_AcpTrak_0.Assembly := ADR(gAssembly_1);
	MC_BR_AsmReset_AcpTrak_0();
	
	MC_BR_AsmDeleteShuttle_AcpTrak_0.Assembly := ADR(gAssembly_1);
	MC_BR_AsmDeleteShuttle_AcpTrak_0();
	
	
	em();								// call the module
	
	
	gMain.status.ready := MC_BR_AsmReadInfo_AcpTrak_0.AssemblyInfo.ReadyForPowerOn AND MC_BR_AsmReadInfo_AcpTrak_0.Valid;
	gMain.status.power := MC_BR_AsmReadStatus_AcpTrak_0.AssemblyReady AND MC_BR_AsmReadStatus_AcpTrak_0.Valid;
	gMain.status.communication := MC_BR_AsmReadInfo_AcpTrak_0.AssemblyInfo.CommunicationReady AND MC_BR_AsmReadInfo_AcpTrak_0.Valid;
	gMain.status.error := MC_BR_AsmReadStatus_AcpTrak_0.AssemblyErrorStop AND MC_BR_AsmReadStatus_AcpTrak_0.Valid;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

