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
			
		
			
			Shuttle0_X := LREAL_TO_REAL(gShuttleMon.Shuttle[0].Position.X);
			Shuttle0_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[0].Position.Y);
			Shuttle0_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[0].Orientation.Angle1);
			Shuttle1_X := LREAL_TO_REAL(gShuttleMon.Shuttle[1].Position.X);
			Shuttle1_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[1].Position.Y);
			Shuttle1_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[1].Orientation.Angle1);
			Shuttle2_X := LREAL_TO_REAL(gShuttleMon.Shuttle[2].Position.X);
			Shuttle2_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[2].Position.Y);
			Shuttle2_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[2].Orientation.Angle1);
			Shuttle3_X := LREAL_TO_REAL(gShuttleMon.Shuttle[3].Position.X);
			Shuttle3_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[3].Position.Y);
			Shuttle3_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[3].Orientation.Angle1);
			Shuttle4_X := LREAL_TO_REAL(gShuttleMon.Shuttle[4].Position.X);
			Shuttle4_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[4].Position.Y);
			Shuttle4_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[4].Orientation.Angle1);
			Shuttle5_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[5].Orientation.Angle1);
			Shuttle5_X := LREAL_TO_REAL(gShuttleMon.Shuttle[5].Position.X);
			Shuttle5_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[5].Position.Y);
			Shuttle6_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[6].Orientation.Angle1);
			Shuttle6_X := LREAL_TO_REAL(gShuttleMon.Shuttle[6].Position.X);
			Shuttle6_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[6].Position.Y);
			Shuttle7_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[7].Orientation.Angle1);
			Shuttle7_X := LREAL_TO_REAL(gShuttleMon.Shuttle[7].Position.X);
			Shuttle7_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[7].Position.Y);
			Shuttle8_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[8].Orientation.Angle1);
			Shuttle8_X := LREAL_TO_REAL(gShuttleMon.Shuttle[8].Position.X);
			Shuttle8_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[8].Position.Y);
			Shuttle9_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[9].Orientation.Angle1);
			Shuttle9_X := LREAL_TO_REAL(gShuttleMon.Shuttle[9].Position.X);
			Shuttle9_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[9].Position.Y);
			Shuttle10_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[10].Orientation.Angle1);
			Shuttle10_X := LREAL_TO_REAL(gShuttleMon.Shuttle[10].Position.X);
			Shuttle10_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[10].Position.Y);
			Shuttle11_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[11].Orientation.Angle1);
			Shuttle11_X := LREAL_TO_REAL(gShuttleMon.Shuttle[11].Position.X);
			Shuttle11_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[11].Position.Y);
			Shuttle12_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[12].Orientation.Angle1);
			Shuttle12_X := LREAL_TO_REAL(gShuttleMon.Shuttle[12].Position.X);
			Shuttle12_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[12].Position.Y);
			Shuttle13_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[13].Orientation.Angle1);
			Shuttle13_X := LREAL_TO_REAL(gShuttleMon.Shuttle[13].Position.X);
			Shuttle13_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[13].Position.Y);
			Shuttle14_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[14].Orientation.Angle1);
			Shuttle14_X := LREAL_TO_REAL(gShuttleMon.Shuttle[14].Position.X);
			Shuttle14_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[14].Position.Y);
			Shuttle15_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[15].Orientation.Angle1);
			Shuttle15_X := LREAL_TO_REAL(gShuttleMon.Shuttle[15].Position.X);
			Shuttle15_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[15].Position.Y);
			Shuttle16_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[16].Orientation.Angle1);
			Shuttle16_X := LREAL_TO_REAL(gShuttleMon.Shuttle[16].Position.X);
			Shuttle16_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[16].Position.Y);
			Shuttle17_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[17].Orientation.Angle1);
			Shuttle17_X := LREAL_TO_REAL(gShuttleMon.Shuttle[17].Position.X);
			Shuttle17_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[17].Position.Y);
			Shuttle18_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[18].Orientation.Angle1);
			Shuttle18_X := LREAL_TO_REAL(gShuttleMon.Shuttle[18].Position.X);
			Shuttle18_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[18].Position.Y);
			Shuttle19_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[19].Orientation.Angle1);
			Shuttle19_X := LREAL_TO_REAL(gShuttleMon.Shuttle[19].Position.X);
			Shuttle19_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[19].Position.Y);
			Shuttle20_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[20].Orientation.Angle1);
			Shuttle20_X := LREAL_TO_REAL(gShuttleMon.Shuttle[20].Position.X);
			Shuttle20_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[20].Position.Y);
			Shuttle21_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[21].Orientation.Angle1);
			Shuttle21_X := LREAL_TO_REAL(gShuttleMon.Shuttle[21].Position.X);
			Shuttle21_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[21].Position.Y);
			Shuttle22_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[22].Orientation.Angle1);
			Shuttle22_X := LREAL_TO_REAL(gShuttleMon.Shuttle[22].Position.X);
			Shuttle22_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[22].Position.Y);
			Shuttle23_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[23].Orientation.Angle1);
			Shuttle23_X := LREAL_TO_REAL(gShuttleMon.Shuttle[23].Position.X);
			Shuttle23_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[23].Position.Y);
			Shuttle24_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[24].Orientation.Angle1);
			Shuttle24_X := LREAL_TO_REAL(gShuttleMon.Shuttle[24].Position.X);
			Shuttle24_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[24].Position.Y);
			Shuttle25_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[25].Orientation.Angle1);
			Shuttle25_X := LREAL_TO_REAL(gShuttleMon.Shuttle[25].Position.X);
			Shuttle25_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[25].Position.Y);
			Shuttle26_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[26].Orientation.Angle1);
			Shuttle26_X := LREAL_TO_REAL(gShuttleMon.Shuttle[26].Position.X);
			Shuttle26_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[26].Position.Y);
			Shuttle27_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[27].Orientation.Angle1);
			Shuttle27_X := LREAL_TO_REAL(gShuttleMon.Shuttle[27].Position.X);
			Shuttle27_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[27].Position.Y);
			Shuttle28_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[28].Orientation.Angle1);
			Shuttle28_X := LREAL_TO_REAL(gShuttleMon.Shuttle[28].Position.X);
			Shuttle28_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[28].Position.Y);
			Shuttle29_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[29].Orientation.Angle1);
			Shuttle29_X := LREAL_TO_REAL(gShuttleMon.Shuttle[29].Position.X);
			Shuttle29_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[29].Position.Y);
			Shuttle30_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[30].Orientation.Angle1);
			Shuttle30_X := LREAL_TO_REAL(gShuttleMon.Shuttle[30].Position.X);
			Shuttle30_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[30].Position.Y);
			Shuttle31_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[31].Orientation.Angle1);
			Shuttle31_X := LREAL_TO_REAL(gShuttleMon.Shuttle[31].Position.X);
			Shuttle31_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[31].Position.Y);
			Shuttle32_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[32].Orientation.Angle1);
			Shuttle32_X := LREAL_TO_REAL(gShuttleMon.Shuttle[32].Position.X);
			Shuttle32_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[32].Position.X);
			Shuttle33_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[33].Orientation.Angle1);
			Shuttle33_X := LREAL_TO_REAL(gShuttleMon.Shuttle[33].Position.X);
			Shuttle33_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[33].Position.Y);
			Shuttle34_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[34].Orientation.Angle1);
			Shuttle34_X := LREAL_TO_REAL(gShuttleMon.Shuttle[34].Position.X);
			Shuttle34_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[34].Position.Y);
			Shuttle35_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[35].Orientation.Angle1);
			Shuttle35_X := LREAL_TO_REAL(gShuttleMon.Shuttle[35].Position.X);
			Shuttle35_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[35].Position.Y);
			Shuttle36_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[36].Orientation.Angle1);
			Shuttle36_X := LREAL_TO_REAL(gShuttleMon.Shuttle[36].Position.X);
			Shuttle36_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[36].Position.Y);
			Shuttle37_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[37].Orientation.Angle1);
			Shuttle37_X := LREAL_TO_REAL(gShuttleMon.Shuttle[37].Position.X);
			Shuttle37_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[37].Position.Y);
			Shuttle38_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[38].Orientation.Angle1);
			Shuttle38_X := LREAL_TO_REAL(gShuttleMon.Shuttle[38].Position.X);
			Shuttle38_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[38].Position.Y);
			Shuttle39_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[39].Orientation.Angle1);
			Shuttle39_X := LREAL_TO_REAL(gShuttleMon.Shuttle[39].Position.X);
			Shuttle39_Y	:= LREAL_TO_REAL(gShuttleMon.Shuttle[39].Position.Y);
			Shuttle40_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[40].Orientation.Angle1);
			Shuttle40_X := LREAL_TO_REAL(gShuttleMon.Shuttle[40].Position.X);
			Shuttle40_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[40].Position.Y);
			Shuttle41_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[41].Orientation.Angle1);
			Shuttle41_X := LREAL_TO_REAL(gShuttleMon.Shuttle[41].Position.X);
			Shuttle41_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[41].Position.Y);
			Shuttle42_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[42].Orientation.Angle1);
			Shuttle42_X := LREAL_TO_REAL(gShuttleMon.Shuttle[42].Position.X);
			Shuttle42_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[42].Position.Y);
			Shuttle43_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[43].Orientation.Angle1);
			Shuttle43_X := LREAL_TO_REAL(gShuttleMon.Shuttle[43].Position.X);
			Shuttle43_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[43].Position.Y);
			Shuttle44_X := LREAL_TO_REAL(gShuttleMon.Shuttle[44].Position.X);
			Shuttle44_Y := LREAL_TO_REAL(gShuttleMon.Shuttle[44].Position.Y);
			Shuttle44_Angel := LREAL_TO_REAL(gShuttleMon.Shuttle[44].Orientation.Angle1);
			
			
			

		ELSE
			brsmemset(ADR(Vis.Shuttle[i]), 0, SIZEOF(Vis.Shuttle[0]));  //If the selected shuttle is not available, it will be invisible in the Scene Viewer
		END_IF
	END_FOR
    
END_PROGRAM
