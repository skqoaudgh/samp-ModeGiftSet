/*
  [Functions]
	Function
*/

//-----/ Pre-Processing /
#if defined _MDPWN_1_Run
	#endinput
#endif
#define _MDPWN_1_Run

//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1

//-----/ News /
	//--/ 1_Run /


//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_1_Run();
forward InitHandler_1_Run();
forward SpawnHandler_1_Run(playerid);
	//--/ Functions /


//==========/ Callback Functions /==============================================
//-----/ AddHandler_1_Run /-----------------------------------------------------
public AddHandler_1_Run()
{
	AddHandler("1_Run",InitHandler);
	AddHandler("1_Run",SpawnHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}

//-----/ InitHandler_1_Run /----------------------------------------------------
public InitHandler_1_Run()
{

}

//-----/ SpawnHandler_1_Run /---------------------------------------------------
public SpawnHandler_1_Run(playerid)
{
	if(GetPlayerMap(playerid) == 1)
	{
		SetPlayerPos(playerid,6919.6401,-3086.9556,56.2338);
		SetPlayerFacingAngle(playerid,268.6034);
		FreezePlayer(playerid,2);

		SetPlayerHealth(playerid,10);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		
		Goal[playerid] = false;
	}
}
//==========/ Functions /=======================================================
