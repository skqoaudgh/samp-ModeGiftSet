/*
  [Functions]
	Function
*/

//-----/ Pre-Processing /
#if defined _MDPWN_3_Shovel
	#endinput
#endif
#define _MDPWN_3_Shovel

//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1

//-----/ News /
	//--/  /

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_3_Shovel();

	//--/ Functions /


//==========/ Callback Functions /==============================================
//-----/ AddHandler_1_Run /-----------------------------------------------------
public AddHandler_3_Shovel()
{
	AddHandler("3_Shovel",InitHandler);
	AddHandler("3_Shovel",SpawnHandler);
	AddHandler("3_Shovel",CommandHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}

//-----/ InitHandler_3_Shovel /----------------------------------------------------
public InitHandler_3_Shovel()
{

}
//-----/ SpawnHandler_3_Shovel /---------------------------------------------------
public SpawnHandler_3_Shovel(playerid)
{
	if(GetPlayerMap(playerid) == 3)
	{
	    ClearChatting(playerid);
		if(GetPlayerLanguage(playerid) == 0)
		{
		    SendClientMessage(playerid,COLOR_GREEN,"          돌아온 시발모드 : 삽 대전");
		    SendClientMessage(playerid,COLOR_GREEN,"당신은 삽질을 하던 도중 광기에 둘러쌓인 노동자들을 발견합니다.");
		    SendClientMessage(playerid,COLOR_GREEN,"이 지옥같은 곳에서 살아남는 방법은 다른 사람들을 죽이는 것 뿐입니다.");
		    SendClientMessage(playerid,COLOR_GREEN,"포크레인 위를 잘 찾아보면 좋은 물건을 얻을 수 있을지도..?");
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREEN,"          Fuck Mode Returned: Shovel DM");
		    SendClientMessage(playerid,COLOR_GREEN,"You have found workers surrounded by madness while shoveling.");
		    SendClientMessage(playerid,COLOR_GREEN,"The only way to survive in this hell is to kill others.");
		    SendClientMessage(playerid,COLOR_GREEN,"If you look up the forklane well, you may get something good..");
		}
		//-----
		SetPlayerVirtualWorld(playerid, 3);
		SetPlayerInterior(playerid, 0);
        SetPlayerColor(playerid,COLOR_GREY);
        SetPlayerHealth(playerid, 20.0);
        SetPlayerArmour(playerid, 0.0);
        SetPlayerWorldBounds(playerid,958.0458, 906.5814, -1108.8313, -1160.3292);
        SetPlayerTime(playerid, 12, 0);
        
        ResetPlayerWeapons(playerid);
        GivePlayerWeapon(playerid, 6, 1);
        
        new rand = random(80);
        SetPlayerPos(playerid, SpawnPos[rand][0], SpawnPos[rand][1], SpawnPos[rand][2]);
        FreezePlayer(playerid, 2);
	}
}
//-----/ CommandHandler_3_Shovel /---------------------------------------------------
public CommandHandler_3_Shovel(playerid,cmdtext[]) //return 1: processed
{
	if(GetPlayerMap(playerid) == 2)
	{
		new
			cmd[256],idx
			//string[128]
		;
		cmd = strtok(cmdtext,idx);
		if(!strcmp("/help",cmd) || !strcmp("/?",cmd) || !strcmp("/도움말",cmd))
		{
			if(GetPlayerLanguage(playerid) == 0)
				SendClientMessage(playerid,COLOR_WHITE,"* 이 맵은 도움말이 없습니다.");
			else
				SendClientMessage(playerid,COLOR_WHITE,"* This map has no help message.");
			return 1;
		}
	}
	return 0;
}
//==========/ Functions /=======================================================
