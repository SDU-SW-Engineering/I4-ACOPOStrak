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
		

		ELSE
			brsmemset(ADR(Vis.Shuttle[i]), 0, SIZEOF(Vis.Shuttle[0]));  //If the selected shuttle is not available, it will be invisible in the Scene Viewer
		END_IF
	END_FOR
    
END_PROGRAM
