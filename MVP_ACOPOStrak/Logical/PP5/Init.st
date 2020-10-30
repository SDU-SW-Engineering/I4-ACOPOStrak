

PROGRAM _INIT
(* Local variable to enable/disable the the process *)
	Speed_PP_04 := 2;
	CmdEnableProcess := TRUE;
	(* Processpointreference for Functionblocks *)
	MC_BR_TrgPointEnable_AcpTrak_0.ProcessPoint := ADR(PP5);
	MC_BR_TrgPointGetInfo_AcpTrak_0.ProcessPoint := ADR(PP5);
END_PROGRAM