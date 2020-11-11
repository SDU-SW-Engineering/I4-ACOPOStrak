PROGRAM _INIT 

    // size of Vis structure - this value has to be entered in B&R scene viewer (PVI -> Options -> Size)
	SizeofVis := SIZEOF(Vis);
	// max number of displayed shuttles  
	NumVisShuttle := SIZEOF(Vis.Shuttle) / SIZEOF(Vis.Shuttle[0]);  
	//dummy call
	gShuttleMon;
	
END_PROGRAM

PROGRAM _CYCLIC 

	FOR i:=0 TO (NumVisShuttle-1) DO 
		IF gShuttleMon.Shuttle[i].Available THEN
			// format selected monitor data to fit B&R scene viewer  
			Vis.Shuttle[i].Available     := 1;
			Vis.Shuttle[i].PositionX     := LREAL_TO_REAL(gShuttleMon.Shuttle[i].Position.X);
			Vis.Shuttle[i].PositionY     := LREAL_TO_REAL(gShuttleMon.Shuttle[i].Position.Y);
			Vis.Shuttle[i].RotationZ     := LREAL_TO_REAL(gShuttleMon.Shuttle[i].Orientation.Angle1);
			Vis.Shuttle[i].ExtentToFront := LREAL_TO_REAL(gShuttleMon.Shuttle[i].ExtentToFront);
			Vis.Shuttle[i].ExtentToBack  := LREAL_TO_REAL(gShuttleMon.Shuttle[i].ExtentToBack);
			Vis.Shuttle[i].Width         := LREAL_TO_REAL(gShuttleMon.Shuttle[i].Width);  
			brsitoa(gShuttleMon.Shuttle[i].Index, ADR(Vis.Shuttle[i].Text));
			Shuttle1_X := LREAL_TO_REAL(gShuttleMon.Shuttle[0].Position.X);
			Shuttle1_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[0].Position.Y);
			Shuttle1_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[0].Orientation.Angle1);
			Shuttle2_X := LREAL_TO_REAL(gShuttleMon.Shuttle[1].Position.X);
			Shuttle2_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[1].Position.Y);
			Shuttle2_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[1].Orientation.Angle1);
			Shuttle3_X := LREAL_TO_REAL(gShuttleMon.Shuttle[2].Position.X);
			Shuttle3_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[2].Position.Y);
			Shuttle3_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[2].Orientation.Angle1);
			Shuttle4_X := LREAL_TO_REAL(gShuttleMon.Shuttle[3].Position.X);
			Shuttle4_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[3].Position.Y);
			Shuttle4_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[3].Orientation.Angle1);
			Shuttle5_X := LREAL_TO_REAL(gShuttleMon.Shuttle[4].Position.X);
			Shuttle5_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[4].Position.Y);
			Shuttle5_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[4].Orientation.Angle1);

		ELSE
			brsmemset(ADR(Vis.Shuttle[i]), 0, SIZEOF(Vis.Shuttle[0]));  //If the selected shuttle is not available, it will be invisible in the Scene Viewer
		END_IF
	END_FOR
    
END_PROGRAM
