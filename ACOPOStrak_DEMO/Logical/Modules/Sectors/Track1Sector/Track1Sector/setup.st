
ACTION setup: 

	gTrack1.velocity     := SEL(gTrack1.velocity <> 0.0, 0.5, gTrack1.velocity); //default 0.5
    gTrack1.acceleration := SEL(gTrack1.acceleration <> 0.0, 1.0, gTrack1.acceleration); //default 1.0
    gTrack1.deceleration := SEL(gTrack1.deceleration <> 0.0, 1.0, gTrack1.deceleration); //default 1.0

	MC_BR_SecGetShuttle_AcpTrak_0.Sector := ADR(SectorTrack1);	//current sector

	MC_BR_TrgPointEnable_AcpTrak_0.Enable := FALSE; //<--- only valid for Track1 (not used)
	MC_BR_TrgPointEnable_AcpTrak_0.ProcessPoint := ADR(PP_Track1);
	MC_BR_TrgPointGetInfo_AcpTrak_0.ProcessPoint := ADR(PP_Track1);
	
	MC_BR_RoutedMoveVel_AcpTrak_0.Sector 	:= ADR(SectorTrack4); //next sector
	MC_BR_RoutedMoveVel_AcpTrak_0.Position 	:= 0.0;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.StartDirection 	:= mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.EndDirection 		:= mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.ShuttleOrientation := mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_AcpTrak_0.Velocity 		:= gTrack1.velocity;
	MC_BR_RoutedMoveVel_AcpTrak_0.RouteVelocity := gTrack1.velocity;
	MC_BR_RoutedMoveVel_AcpTrak_0.Acceleration 	:= gTrack1.acceleration;
	MC_BR_RoutedMoveVel_AcpTrak_0.Deceleration 	:= gTrack1.deceleration;
	
	MC_BR_ElasticMoveVel_AcpTrak_0.Acceleration := gTrack1.acceleration;
	MC_BR_ElasticMoveVel_AcpTrak_0.Deceleration := gTrack1.deceleration;
	MC_BR_ElasticMoveVel_AcpTrak_0.Velocity 	:= gTrack1.velocity;
	MC_BR_ElasticMoveVel_AcpTrak_0.Direction 	:= myTestDirection;
	
	MC_BR_BarrierCommand_AcpTrak_0.ProcessPoint := ADR(PP_Track1);
	MC_BR_BarrierReadInfo_AcpTrak_0.ProcessPoint := ADR(PP_Track1);
	
	this.userData.Color := SHUTTLE_COLOR_BLUE;

END_ACTION
