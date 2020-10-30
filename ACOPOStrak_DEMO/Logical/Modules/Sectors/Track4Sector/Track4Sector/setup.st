
ACTION setup: 

	gTrack4.velocity     := SEL(gTrack4.velocity <> 0.0, 0.5, gTrack4.velocity); //default 0.5
    gTrack4.acceleration := SEL(gTrack4.acceleration <> 0.0, 1.0, gTrack4.acceleration); //default 1.0
    gTrack4.deceleration := SEL(gTrack4.deceleration <> 0.0, 1.0, gTrack4.deceleration); //default 1.0

	MC_BR_SecGetShuttle_AcpTrak_0.Sector := ADR(SectorTrack4);	//current sector

	MC_BR_TrgPointEnable_AcpTrak_0.ProcessPoint := ADR(PP_Track4);
	MC_BR_TrgPointGetInfo_AcpTrak_0.ProcessPoint := ADR(PP_Track4);
	
	MC_BR_RoutedMoveVel_AcpTrak_0.Sector 	:= ADR(SectorTrack1); //next sector
	MC_BR_RoutedMoveVel_AcpTrak_0.Position 	:= 0.0;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.StartDirection 	:= mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.EndDirection 		:= mcDIR_POSITIVE;
	MC_BR_RoutedMoveVel_AcpTrak_0.AdvancedParameters.ShuttleOrientation := mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_AcpTrak_0.Velocity 		:= gTrack4.velocity;
	MC_BR_RoutedMoveVel_AcpTrak_0.RouteVelocity := gTrack4.velocity;
	MC_BR_RoutedMoveVel_AcpTrak_0.Acceleration 	:= gTrack4.acceleration;
	MC_BR_RoutedMoveVel_AcpTrak_0.Deceleration 	:= gTrack4.deceleration;
	
	MC_BR_ElasticMoveVel_AcpTrak_0.Acceleration := gTrack4.acceleration;
	MC_BR_ElasticMoveVel_AcpTrak_0.Deceleration := gTrack4.deceleration;
	MC_BR_ElasticMoveVel_AcpTrak_0.Velocity 	:= gTrack4.velocity;
	MC_BR_ElasticMoveVel_AcpTrak_0.Direction 	:= mcDIR_NEGATIVE;
	
	MC_BR_BarrierCommand_AcpTrak_0.ProcessPoint := ADR(PP_Track4);
	MC_BR_BarrierReadInfo_AcpTrak_0.ProcessPoint := ADR(PP_Track4);
	
	this.userData.Color := SHUTTLE_COLOR_RED;
	
	//selector pre track
	MC_BR_TrgPointEnable_PreTrak.ProcessPoint := ADR(PP_Pre_Track4);
	
	MC_BR_TrgPointGetInfo_PreTrak.ProcessPoint := ADR(PP_Pre_Track4);
	
	MC_BR_RoutedMoveVel_PreTrak.Axis 			:= ADR(this.preAxis);
	MC_BR_RoutedMoveVel_PreTrak.Sector 			:= ADR(SectorTrack4); //this sector
	MC_BR_RoutedMoveVel_PreTrak.Acceleration 	:= gTrack1.acceleration;
	MC_BR_RoutedMoveVel_PreTrak.Deceleration 	:= gTrack1.deceleration;
	MC_BR_RoutedMoveVel_PreTrak.Position	  	:= 0.0;
	MC_BR_RoutedMoveVel_PreTrak.Velocity     	:= gTrack1.velocity;
	MC_BR_RoutedMoveVel_PreTrak.AdvancedParameters.StartDirection 		:= mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_PreTrak.AdvancedParameters.EndDirection			:= mcDIR_UNDEFINED;
	MC_BR_RoutedMoveVel_PreTrak.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	
	this.selector := gTrack4.selector;
	
	selector;
	
END_ACTION
