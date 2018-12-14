/*
  [Functions]
	FreezePlayer(playerid)
	UnFreezePlayer(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_FreezePlayer
	#endinput
#endif
#define _MDPWN_FreezePlayer

//-----/ News /
new
	FreezeTimer[MAX_PLAYERS]
;

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_FreezePlayer();
forward DisconnectHandler_FreezePlayer(playerid,reason);
	//--/ Functions /
forward UnFreezePlayer(playerid);

//==========/ Callback Functions /==============================================
//-----/ AddHandler_FreezePlayer /----------------------------------------------
public AddHandler_FreezePlayer()
{
    AddHandler("FreezePlayer",DisconnectHandler);
}
//-----/ DisconnectHandler_FreezePlayer /---------------------------------------
public DisconnectHandler_FreezePlayer(playerid,reason)
{
	KillTimer(FreezeTimer[playerid]);
}

//==========/ Functions /=======================================================
//-----/ FreezePlayer /---------------------------------------------------------
stock FreezePlayer(playerid, time=0)
{
    TogglePlayerControllable(playerid,0);
	KillTimer(FreezeTimer[playerid]);
    if(time > 0)
		FreezeTimer[playerid] = SetTimerEx("UnFreezePlayer",time*1000,0,"d",playerid);
}

//-----/ UnFreezePlayer /-------------------------------------------------------
public UnFreezePlayer(playerid)
{
    TogglePlayerControllable(playerid,1);
}
