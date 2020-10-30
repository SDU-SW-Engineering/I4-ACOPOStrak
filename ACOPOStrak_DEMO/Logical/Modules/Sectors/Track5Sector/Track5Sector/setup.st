
ACTION setup: 

	gTrack5.velocity     := SEL(gTrack5.velocity <> 0.0, 0.5, gTrack5.velocity); //default 0.5
    gTrack5.acceleration := SEL(gTrack5.acceleration <> 0.0, 1.0, gTrack5.acceleration); //default 1.0
    gTrack5.deceleration := SEL(gTrack5.deceleration <> 0.0, 1.0, gTrack5.deceleration); //default 1.0

	MC_BR_SecGetShuttle_AcpTrak_0.Sector := ADR(SectorTrack5);	//current sector

	MC_BR_TrgPointEnable_AcpTrak_0.ProcessPoint := ADR(PP_Track5);
	MC_BR_TrgPointGetInfo_AcpTrak_0.ProcessPoint := ADR(PP_Track5);
	
	MC_BR_RoutedMoveVel_AcpTrak_0.Sector 	:= ADR(SectorTrack1); //next sector
	MC_BR_RoutedMoveVel_AcpTrak_0.Position 	:= 0.0;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.StartDirection 	:= mcDIR_POSITIVE;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.EndDirection 		:= mcDIR_NEGATIVE;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.ShuttleOrientation := mcDIR_NEGATIVE;
	MC_BR_RoutedMoveVel_AcpTrak_0.Velocity 		:= gTrack5.velocity;
	MC_BR_RoutedMoveVel_AcpTrak_0.RouteVelocity := gTrack5.velocity;
	MC_BR_RoutedMoveVel_AcpTrak_0.Acceleration 	:= gTrack5.acceleration;
	MC_BR_RoutedMoveVel_AcpTrak_0.Deceleration 	:= gTrack5.deceleration;
	
	MC_BR_ElasticMoveVel_AcpTrak_0.Acceleration := gTrack5.acceleration;
	MC_BR_ElasticMoveVel_AcpTrak_0.Deceleration := gTrack5.deceleration;
	MC_BR_ElasticMoveVel_AcpTrak_0.Velocity 	:= gTrack5.velocity;
	MC_BR_ElasticMoveVel_AcpTrak_0.Direction 	:= mcDIR_POSITIVE;
	
	MC_BR_BarrierCommand_AcpTrak_0.ProcessPoint := ADR(PP_Track5);
	MC_BR_BarrierReadInfo_AcpTrak_0.ProcessPoint := ADR(PP_Track5);
	
	this.userData.Color := SHUTTLE_COLOR_CYAN;
	
END_ACTION
