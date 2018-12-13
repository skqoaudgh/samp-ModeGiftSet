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
		    SendClientMessage(playerid,COLOR_GREEN,"          ���ƿ� �ù߸�� : �� ����");
		    SendClientMessage(playerid,COLOR_GREEN,"����� ������ �ϴ� ���� ���⿡ �ѷ����� �뵿�ڵ��� �߰��մϴ�.");
		    SendClientMessage(playerid,COLOR_GREEN,"�� �������� ������ ��Ƴ��� ����� �ٸ� ������� ���̴� �� ���Դϴ�.");
		    SendClientMessage(playerid,COLOR_GREEN,"��ũ���� ���� �� ã�ƺ��� ���� ������ ���� �� ��������..?");
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
		if(!strcmp("/help",cmd) || !strcmp("/?",cmd) || !strcmp("/����",cmd))
		{
			if(GetPlayerLanguage(playerid) == 0)
				SendClientMessage(playerid,COLOR_WHITE,"* �� ���� ������ �����ϴ�.");
			else
				SendClientMessage(playerid,COLOR_WHITE,"* This map has no help message.");
			return 1;
		}
	}
	return 0;
}
//==========/ Functions /=======================================================
