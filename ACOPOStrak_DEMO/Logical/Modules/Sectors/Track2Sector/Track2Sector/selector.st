ACTION selector: 
	
	CASE cm.state OF
		0:	
			MC_BR_TrgPointEnable_PreTrak.Enable := TRUE;
			cm.state := 100;
			
		100:
			IF MC_BR_TrgPointEnable_PreTrak.EventCount > 0 AND MC_BR_TrgPointEnable_PreTrak.Valid THEN
				MC_BR_TrgPointGetInfo_PreTrak.Execute := TRUE;
				cm.state := 110;
			END_IF
			
		110:
			IF MC_BR_TrgPointGetInfo_PreTrak.Done THEN
				this.preAxis := MC_BR_TrgPointGetInfo_PreTrak.TrgPointInfo.Axis;
				MC_BR_TrgPointGetInfo_PreTrak.Execute := FALSE;
				cm.state := 120;
			END_IF
			
		120:
			cm.description := 'evaluate shuttle';
			CASE this.selector OF
				TRAK_SELECTOR_NONE:
					cm.state := 100;
				
				TRAK_SELECTOR_ALL:
					CASE cm.substate OF
						0:
							MC_BR_RoutedMoveVel_PreTrak.Execute := TRUE;
							cm.substate := 10;
						10:
							IF MC_BR_RoutedMoveVel_PreTrak.Active THEN
								MC_BR_RoutedMoveVel_PreTrak.Execute := FALSE;
								cm.state := 100;
								cm.substate := 0;
							END_IF
					END_CASE
				
				TRAK_SELECTOR_2ND:
					CASE cm.substate OF
						0:
							IF this.counter >= 1 THEN
								MC_BR_RoutedMoveVel_PreTrak.Execute := TRUE;
								this.counter := 0;
								cm.substate := 10;
							ELSE
								cm.state := 100; // do nothing
								this.counter := this.counter + 1;
							END_IF
						10:
							IF MC_BR_RoutedMoveVel_PreTrak.Active THEN
								MC_BR_RoutedMoveVel_PreTrak.Execute := FALSE;
								cm.state := 100;
								cm.substate := 0;
							END_IF
					END_CASE
				
				TRAK_SELECTOR_3RD:
					CASE cm.substate OF
						0:
							IF this.counter >= 2 THEN
								MC_BR_RoutedMoveVel_PreTrak.Execute := TRUE;
								this.counter := 0;
								cm.substate := 10;
							ELSE
								cm.state := 100; // do nothing
								this.counter := this.counter + 1;
							END_IF
						10:
							IF MC_BR_RoutedMoveVel_PreTrak.Active THEN
								MC_BR_RoutedMoveVel_PreTrak.Execute := FALSE;
								cm.state := 100;
								cm.substate := 0;
							END_IF
					END_CASE
				
				TRAK_SELECTOR_4TH:
					CASE cm.substate OF
						0:
							IF this.counter >= 3 THEN
								MC_BR_RoutedMoveVel_PreTrak.Execute := TRUE;
								this.counter := 0;
								cm.substate := 10;
							ELSE
								cm.state := 100; // do nothing
								this.counter := this.counter + 1;
							END_IF
						10:
							IF MC_BR_RoutedMoveVel_PreTrak.Active THEN
								MC_BR_RoutedMoveVel_PreTrak.Execute := FALSE;
								cm.state := 100;
								cm.substate := 0;
							END_IF
					END_CASE
			END_CASE
			
	END_CASE

	MC_BR_TrgPointEnable_PreTrak();
	
	MC_BR_TrgPointGetInfo_PreTrak();
	
	MC_BR_RoutedMoveVel_PreTrak();
	
	cm();
	
END_ACTION
