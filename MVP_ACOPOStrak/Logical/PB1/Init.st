



PROGRAM _INIT
(* Local variable to enable/disable the the process *)
	Speed_PP_04 := 2;
	CmdEnableProcess := TRUE;
	(* Processpointreference for Functionblocks *)
	MC_BR_TrgPointEnable_AcpTrak_0.ProcessPoint := ADR(PB1);
	MC_BR_TrgPointGetInfo_AcpTrak_0.ProcessPoint := ADR(PB1);
	MC_BR_BarrierCommand_AcpTrak_0.ProcessPoint := ADR(PB1);
	MC_BR_BarrierCommand_AcpTrak_0.Command := 1;
	MC_BR_BarrierCommand_AcpTrak_0.AdvancedParameters.TicketCount := 1;
	MC_BR_BarrierCommand_AcpTrak_0.Execute := TRUE;
	MC_BR_BarrierCommand_AcpTrak_0();
	SubStep := 0;
	
END_PROGRAM