
PROGRAM _INIT
	
	MC_BR_TrgPointEnable_AcpTrak_0.Enable := TRUE;
	MC_BR_BarrierCommand_AcpTrak_0.Command := mcACPTRAK_BARRIER_ADD_TICKETS;
	MC_BR_BarrierCommand_AcpTrak_0.AdvancedParameters.TicketCount := 1;
	
	myTestDirection := mcDIR_POSITIVE;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	em.setup.parent.name := 'Main';

	setup;
	
	CASE em.state OF
		STATE_STOPPED:
			idx := 0;
			MC_BR_SecGetShuttle_AcpTrak_0.Enable := FALSE;
			em.cmd.sc := TRUE;
	
		STATE_RESETTING:
			CASE em.substate OF
				0:
					em.description := 'check for shuttles on this sector';
					MC_BR_SecGetShuttle_AcpTrak_0.Enable := gMain.status.power;
					IF MC_BR_SecGetShuttle_AcpTrak_0.Valid THEN
						em.substate := 10;
					END_IF
				10:
					em.description := 'loop through shuttles and save it';
					MC_BR_SecGetShuttle_AcpTrak_0.Next := FALSE;
					IF MC_BR_SecGetShuttle_AcpTrak_0.TotalCount > 0 THEN
						this.axis[idx] := MC_BR_SecGetShuttle_AcpTrak_0.Axis;
						em.substate := 20;
					ELSE
						em.cmd.sc := TRUE; //no shuttles
					END_IF
				20:
					em.description := 'get next shuttle or move on';
					IF MC_BR_SecGetShuttle_AcpTrak_0.RemainingCount > 0 THEN
						MC_BR_SecGetShuttle_AcpTrak_0.Next := TRUE;
						idx := idx + 1;
						em.substate := 10;
					ELSE
						idx := 0;
						em.cmd.sc := TRUE;
					END_IF
			END_CASE
	
		STATE_STARTING:
			CASE em.substate OF
				0:
					em.description := 'start shuttle movement';
					IF MC_BR_SecGetShuttle_AcpTrak_0.TotalCount > 0 THEN
						MC_BR_ElasticMoveVel_AcpTrak_0.Axis 	:= ADR(this.axis[idx]);
						MC_BR_ElasticMoveVel_AcpTrak_0.Execute 	:= TRUE;
						em.substate := 10;
					ELSE
						em.cmd.sc := TRUE; // no shuttles
					END_IF
				10:
					em.description := 'need a scan before checking if the fub is active or in velocity'; //when changing axis (still active from last execute)
					IF MC_BR_ElasticMoveVel_AcpTrak_0.Active THEN
						MC_BR_ElasticMoveVel_AcpTrak_0.Execute := FALSE;
						idx := idx+1;
						em.substate := 20;
					ELSIF MC_BR_ElasticMoveVel_AcpTrak_0.Error THEN 
						//todo: error handling
					END_IF
				20:
					em.description := 'move on or next shuttle';
					IF MC_BR_SecGetShuttle_AcpTrak_0.TotalCount = idx THEN
						idx := 0; 	//done
						em.cmd.sc := TRUE;
					ELSE			//next
						em.substate := 0;
					END_IF
			END_CASE
			
		STATE_EXECUTE:
			em.cmd.sc := TRUE;
			CASE em.substate OF
				0:
					em.description := 'waiting for shuttle';
					IF MC_BR_TrgPointEnable_AcpTrak_0.EventCount > 0 AND MC_BR_TrgPointEnable_AcpTrak_0.Valid THEN
						em.substate := 10;
					END_IF
				10:
					em.description := 'get axis id';
					MC_BR_TrgPointGetInfo_AcpTrak_0.Execute := TRUE;
					IF MC_BR_TrgPointGetInfo_AcpTrak_0.Done THEN
						axis := MC_BR_TrgPointGetInfo_AcpTrak_0.TrgPointInfo.Axis;
						MC_BR_TrgPointGetInfo_AcpTrak_0.Execute := FALSE;
						em.substate := 20;
					END_IF
				20:
					em.description := 'read axis user data';
					MC_BR_ShCopyUserData_AcpTrak_0.Axis 		:= ADR(axis);    				//Zuweisen der Achsreferenz
		            MC_BR_ShCopyUserData_AcpTrak_0.DataAddress 	:= ADR(this.userData);          //Zuweisen der zu lesenden Prozessvariable
		            MC_BR_ShCopyUserData_AcpTrak_0.DataSize 	:= SIZEOF(this.userData);       //Zuweisen der Länge der Prozessvariable
		            MC_BR_ShCopyUserData_AcpTrak_0.Mode 		:= mcACPTRAK_USERDATA_GET;      //Modus auf Schreiben setzen
		            MC_BR_ShCopyUserData_AcpTrak_0.Execute 		:= TRUE;                        //Werte der Prozessvariable auf die Anwenderdaten des Shuttles kopieren
		            IF MC_BR_ShCopyUserData_AcpTrak_0.Done THEN                            		//Kopieren der Werte war erfolgreich
		                MC_BR_ShCopyUserData_AcpTrak_0.Execute := FALSE;
		                em.substate := 30;
		            END_IF
		        30: 
					em.description := 'write axis user data';
					MC_BR_ShCopyUserData_AcpTrak_0.Axis 		:= ADR(axis);    				 //Zuweisen der Achsreferenz
					MC_BR_ShCopyUserData_AcpTrak_0.DataAddress 	:= ADR(this.userData);           //Zuweisen der zu beschreibenden Prozessvariable
		            MC_BR_ShCopyUserData_AcpTrak_0.DataSize 	:= SIZEOF(this.userData);        //Zuweisen der Länge der Prozessvariable
		            MC_BR_ShCopyUserData_AcpTrak_0.Mode 		:= mcACPTRAK_USERDATA_SET;       //Modus auf Lesen setzen
		            MC_BR_ShCopyUserData_AcpTrak_0.Execute 		:= TRUE;                         //Werte der Anwenderdaten des Shuttles auf die Prozessvariable kopieren
		            IF MC_BR_ShCopyUserData_AcpTrak_0.Done THEN                            		 //Kopieren der Werte war erfolgreich
		                MC_BR_ShCopyUserData_AcpTrak_0.Execute := FALSE;
		                em.substate := 40;
		            END_IF
				40:
					em.description := 'send shuttle to next sector';
					MC_BR_RoutedMoveVel_AcpTrak_0.Axis 		:= ADR(axis);
					MC_BR_RoutedMoveVel_AcpTrak_0.Execute 	:= TRUE;
					em.substate := 50;
				50:
					em.description := 'need a scan before checking if the fub is active'; //when changing axis
					IF MC_BR_RoutedMoveVel_AcpTrak_0.Active THEN
						MC_BR_RoutedMoveVel_AcpTrak_0.Execute := FALSE;
						em.substate := 0;
					END_IF
			END_CASE
			
			STATE_CLEARING:
				brsmemset(ADR(this.axis),0,SIZEOF(this.axis));
				em.cmd.sc := TRUE;
	ELSE
		em.cmd.sc := TRUE;
	END_CASE

	em();
	
	MC_BR_SecGetShuttle_AcpTrak_0();	
	MC_BR_TrgPointEnable_AcpTrak_0();
	MC_BR_TrgPointGetInfo_AcpTrak_0();
	MC_BR_RoutedMoveVel_AcpTrak_0();
	MC_BR_ElasticMoveVel_AcpTrak_0();
	MC_BR_ShCopyUserData_AcpTrak_0();
	MC_BR_BarrierCommand_AcpTrak_0();
	IF MC_BR_BarrierCommand_AcpTrak_0.Done THEN
		MC_BR_BarrierCommand_AcpTrak_0.Execute := FALSE;
	END_IF
	
	MC_BR_BarrierReadInfo_AcpTrak_0(Enable := TRUE);
	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

