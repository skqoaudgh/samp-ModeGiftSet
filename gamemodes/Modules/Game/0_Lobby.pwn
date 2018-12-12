/*
  [Functions]
	Function
*/

//-----/ Pre-Processing /
#if defined _MDPWN_0_Lobby
	#endinput
#endif
#define _MDPWN_0_Lobby

//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1

//-----/ News /
	//--/ 1_Run /


//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_0_Lobby();
forward InitHandler_0_Lobby();
forward SpawnHandler_0_Lobby(playerid);
forward CommandHandler_0_Lobby(playerid,cmdtext[]);
	//--/ Functions /


//==========/ Callback Functions /==============================================
//-----/ AddHandler_0_Lobby /---------------------------------------------------
public AddHandler_0_Lobby()
{
	AddHandler("0_Lobby",InitHandler);
	AddHandler("0_Lobby",SpawnHandler);
	AddHandler("0_Lobby",CommandHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}

//-----/ InitHandler_0_Lobby /--------------------------------------------------
public InitHandler_0_Lobby()
{
	CreateDynamicObject(19129, 1479.55469, -1615.62549, 13.04200,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19158, 1479.55469, -1615.62549, 14.19750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19159, 1479.55469, -1615.62549, 17.50750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18102, 1475.53687, -1605.16565, 15.49330,   90.00000, 0.00000, 180.00000);
	CreateDynamicObject(18102, 1483.58337, -1626.08508, 15.49330,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18102, 1490.07556, -1611.62488, 15.49330,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18102, 1469.17627, -1619.64612, 15.49330,   90.00000, 0.00000, 270.00000);
	CreateDynamicObject(18651, 1469.36218, -1606.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1609.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1612.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1615.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1618.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1621.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1624.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1606.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1609.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1612.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1615.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1618.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1621.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1624.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2179, 1488.91223, -1606.27356, 14.79600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2179, 1470.16333, -1606.27356, 14.79600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2179, 1470.16333, -1625.03357, 14.79600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2179, 1488.91223, -1625.03357, 14.79600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6965, 1479.57471, -1639.60815, 16.04840,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18739, 1479.57471, -1639.60815, 19.04840,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18652, 1457.93066, -1619.99878, 14.55590,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18652, 1502.35229, -1621.13831, 14.55590,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18652, 1501.28967, -1624.52991, 14.55590,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18652, 1498.36328, -1616.90723, 14.55590,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 1479.55469, -1615.62549, 13.66750,   0.00000, 0.00000, 0.00000);
}

//-----/ SpawnHandler_0_Lobby /-------------------------------------------------
public SpawnHandler_0_Lobby(playerid)
{
	if(GetPlayerMap(playerid) == 0)
	{
		SetPlayerColor(playerid,COLOR_WHITE);

		SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
		SetPlayerPos(playerid, 1479.5483,-1600.0005,13.5469);
		SetPlayerFacingAngle(playerid, 180.2658);
		SetPlayerSkin(playerid, 0);
        SetPlayerTime(playerid, 0, 0);
        ResetPlayerWeapons(playerid);
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 0);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
	}
}
//-----/ CommandHandler_0_Lobby /-------------------------------------------
public CommandHandler_0_Lobby(playerid,cmdtext[])
{
	if(GetPlayerMap(playerid) == 0)
	{
		new
			cmd[384],idx,
			string[384],temp[384]
		;
		cmd = strtok(cmdtext,idx);
		if(!strcmp("/help",cmd) || !strcmp("/?",cmd) || !strcmp("/����",cmd))
		{
			if(GetPlayerLanguage(playerid) == 0)
   			{
				SendClientMessage(playerid,COLOR_GREY,"[!] User - /���� /������� /���� /���");
				SendClientMessage(playerid,COLOR_GREY,"[!] Report - /�Ű�");
			}
			else
			{
 				SendClientMessage(playerid,COLOR_GREY,"[!] User - /sav /changepassword /stats /toggle");
				SendClientMessage(playerid,COLOR_GREY,"[!] Report - /report");
			}
			SendClientMessage(playerid,COLOR_GREY,"[!] Chat - (/g)lobal (/t)eam");
			return 1;
		}
	}
	return 0;
}
//==========/ Functions /=======================================================