
ACTION setup: 

	gTrack6.velocity     := SEL(gTrack6.velocity <> 0.0, 0.5, gTrack6.velocity); //default 0.5
    gTrack6.acceleration := SEL(gTrack6.acceleration <> 0.0, 1.0, gTrack6.acceleration); //default 1.0
    gTrack6.deceleration := SEL(gTrack6.deceleration <> 0.0, 1.0, gTrack6.deceleration); //default 1.0

	MC_BR_SecGetShuttle_AcpTrak_0.Sector := ADR(SectorTrack6);	//current sector

	MC_BR_TrgPointEnable_AcpTrak_0.ProcessPoint := ADR(PP_Track6);
	MC_BR_TrgPointGetInfo_AcpTrak_0.ProcessPoint := ADR(PP_Track6);
	
	MC_BR_RoutedMoveVel_AcpTrak_0.Sector 	:= ADR(SectorTrack1); //next sector
	MC_BR_RoutedMoveVel_AcpTrak_0.Position 	:= 3.0;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.StartDirection 	:= mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.EndDirection 		:= mcDIR_POSITIVE;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.ShuttleOrientation := mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_AcpTrak_0.Velocity 		:= gTrack6.velocity;
	MC_BR_RoutedMoveVel_AcpTrak_0.RouteVelocity := gTrack6.velocity;
	MC_BR_RoutedMoveVel_AcpTrak_0.Acceleration 	:= gTrack6.acceleration;
	MC_BR_RoutedMoveVel_AcpTrak_0.Deceleration 	:= gTrack6.deceleration;
	
	MC_BR_ElasticMoveVel_AcpTrak_0.Acceleration := gTrack6.acceleration;
	MC_BR_ElasticMoveVel_AcpTrak_0.Deceleration := gTrack6.deceleration;
	MC_BR_ElasticMoveVel_AcpTrak_0.Velocity 	:= gTrack6.velocity;
	MC_BR_ElasticMoveVel_AcpTrak_0.Direction 	:= mcDIR_POSITIVE;
	
	MC_BR_BarrierCommand_AcpTrak_0.ProcessPoint := ADR(PP_Track6);
	MC_BR_BarrierReadInfo_AcpTrak_0.ProcessPoint := ADR(PP_Track6);
	
	this.userData.Color := SHUTTLE_COLOR_ORANGE;
	
END_ACTION
