/*
  [Functions]
	TogglePlayer3DText(playerid,language)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_0_Lobby
	#endinput
#endif
#define _MDPWN_0_Lobby

//-----/ Defines /
#define MAX_GAMENPC 6

//-----/ News /
	//--/ 0_Lobby /
new Text3D:GameText[MAX_PLAYERS][MAX_GAMENPC];
new GameNPC[MAX_GAMENPC];

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
    SetTingGameNpc();
    
	new obj;
	CreateDynamicObject(19129, 1479.55469, -1594.62549, 13.04200,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19158, 1479.55469, -1594.62549, 14.19750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19159, 1479.55469, -1594.62549, 17.50750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18102, 1475.53687, -1584.16565, 15.49330,   90.00000, 0.00000, 180.00000);
	CreateDynamicObject(18102, 1483.58337, -1605.08508, 15.49330,   90.00000, 0.00000, 0.00000);
	CreateDynamicObject(18102, 1490.07556, -1590.62488, 15.49330,   90.00000, 0.00000, 90.00000);
	CreateDynamicObject(18102, 1469.17627, -1598.64612, 15.49330,   90.00000, 0.00000, 270.00000);
	CreateDynamicObject(18651, 1469.36218, -1585.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1588.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1591.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1594.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1597.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1600.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1469.36218, -1603.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1585.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1588.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1591.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1594.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1597.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1600.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18651, 1489.75073, -1603.64856, 13.04580,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2179, 1488.91223, -1585.27356, 14.79600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2179, 1470.16333, -1585.27356, 14.79600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2179, 1470.16333, -1604.03357, 14.79600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(2179, 1488.91223, -1604.03357, 14.79600,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(6965, 1479.57471, -1639.60815, 16.04840,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18739, 1479.57471, -1618.60815, 19.04840,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19124, 1479.55469, -1594.62549, 13.66750,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3077, 1501.50525, -1625.01160, 13.77840,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3077, 1501.50525, -1621.01160, 13.77840,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3077, 1501.50525, -1617.01160, 13.77840,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3077, 1457.40515, -1625.01160, 13.77840,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3077, 1457.40515, -1621.01160, 13.77840,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3077, 1457.40515, -1617.01160, 13.77840,   0.00000, 0.00000, 90.00000);
	obj = CreateDynamicObject(19772, 1481.59875, -1625.29370, 13.62970,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(obj, 0, 5174, "warehus_las2", "ws_alley_conc1", 0xFFFFFFFF);
	obj = CreateDynamicObject(19772, 1477.50537, -1625.29370, 13.62970,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(obj, 0, 5174, "warehus_las2", "ws_alley_conc1", 0xFFFFFFFF);
	obj = CreateDynamicObject(19772, 1484.91150, -1623.45313, 13.62970,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(obj, 0, 5174, "warehus_las2", "ws_alley_conc1", 0xFFFFFFFF);
	obj = CreateDynamicObject(19772, 1488.25342, -1623.45313, 13.62970,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(obj, 0, 5174, "warehus_las2", "ws_alley_conc1", 0xFFFFFFFF);
	obj = CreateDynamicObject(19772, 1474.15063, -1623.45313, 13.62970,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(obj, 0, 5174, "warehus_las2", "ws_alley_conc1", 0xFFFFFFFF);
	obj = CreateDynamicObject(19772, 1470.82178, -1623.45313, 13.62970,   0.00000, 0.00000, 90.00000);
	SetDynamicObjectMaterial(obj, 0, 5174, "warehus_las2", "ws_alley_conc1", 0xFFFFFFFF);
}

//-----/ SpawnHandler_0_Lobby /-------------------------------------------------
public SpawnHandler_0_Lobby(playerid)
{
	if(GetPlayerMap(playerid) == 0)
	{
	    ClearChatting(playerid);
	    if(GetPlayerLanguage(playerid) == 0)
	    	SendClientMessage(playerid,COLOR_GREEN,"* [/help] 를 통해 서버 명령어를 확인할 수 있습니다.");
		else
		    SendClientMessage(playerid,COLOR_GREEN,"* Enter [/map] to see server commands");
		SetPlayerColor(playerid,COLOR_WHITE);

		SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
		SetPlayerPos(playerid, 1479.5483,-1600.0005,13.5469);
		SetPlayerFacingAngle(playerid, 180.2658);
		SetPlayerSkin(playerid,GetPVarInt(playerid,"Skin"));
        SetPlayerTime(playerid, 0, 0);
        SetPlayerWeather(playerid, 0);
        ResetPlayerWeapons(playerid);
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 0);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerTeam(playerid,NO_TEAM);
		
		PlayAudioStreamForPlayerEx(playerid);
	}
	return 1;
}
//-----/ CommandHandler_0_Lobby /-----------------------------------------------
public CommandHandler_0_Lobby(playerid,cmdtext[])
{
	if(GetPlayerMap(playerid) == 0)
	{
		new
			cmd[384],idx
			//string[384],temp[384]
		;
		cmd = strtok(cmdtext,idx);
		if(!strcmp("/help",cmd) || !strcmp("/?",cmd) || !strcmp("/도움말",cmd))
		{
			if(GetPlayerLanguage(playerid) == 0)
   			{
				SendClientMessage(playerid,COLOR_GREY,"[!] User - /저장 /비번변경 /스탯 /토글 /언어변경");
				SendClientMessage(playerid,COLOR_GREY,"[!] Game - /맵");
				SendClientMessage(playerid,COLOR_GREY,"[!] Style - /스킨 /악세사리");
				SendClientMessage(playerid,COLOR_GREY,"[!] Report - /신고");
			}
			else
			{
 				SendClientMessage(playerid,COLOR_GREY,"[!] User - /sav /changepassword /stat /toggle /language");
				SendClientMessage(playerid,COLOR_GREY,"[!] Game - /map");
				SendClientMessage(playerid,COLOR_GREY,"[!] Style - /skin /toy");
				SendClientMessage(playerid,COLOR_GREY,"[!] Report - /report");
			}
			SendClientMessage(playerid,COLOR_GREY,"[!] Global Chat - (/g)lobal");
			SendClientMessage(playerid,COLOR_GREY,"[!] Team Chat - NUM4");
			return 1;
		}
	}
	return 0;
}
//==========/ Functions /=======================================================
//-----/ TogglePlayer3DText /---------------------------------------------------
stock TogglePlayer3DText(playerid,language)
{
	new string[128];
	//-----
    for(new i=0; i<MAX_GAMENPC; i++)
        DestroyDynamic3DTextLabel(GameText[playerid][i]);
	if(language == 0)
	{
		format(string,sizeof(string),""C_YELLOW"플레이하려면 클릭\n"C_AQUA"정자의 모험 : 리메이크\n"C_YELLOW"%d명 플레이 중",GetMapPlayingCount(1));
	    GameText[playerid][0] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[0], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"플레이하려면 클릭\n"C_AQUA"대통령 지키기\n"C_YELLOW"%d명 플레이 중",GetMapPlayingCount(2));
	    GameText[playerid][1] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[1], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"플레이하려면 클릭\n"C_AQUA"돌아온 시발모드 : 삽 대전\n"C_YELLOW"%d명 플레이 중",GetMapPlayingCount(3));
	    GameText[playerid][2] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[2], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"플레이하려면 클릭\n"C_AQUA"돌아온 시발모드 : 좀비 서바이벌\n"C_YELLOW"%d명 플레이 중",GetMapPlayingCount(4));
	    GameText[playerid][3] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[3], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"플레이하려면 클릭\n"C_AQUA"돌아온 시발모드 : 69 질주\n"C_YELLOW"%d명 플레이 중",GetMapPlayingCount(5));
	    GameText[playerid][4] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[4], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"플레이하려면 클릭\n"C_AQUA"경찰과 도둑\n"C_YELLOW"%d명 플레이 중",GetMapPlayingCount(6));
	    GameText[playerid][5] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[5], .playerid = playerid);
	    for(new i=0; i<MAX_GAMENPC; i++)
	        Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, GameText[playerid][i], E_STREAMER_ATTACH_OFFSET_Z, 0.3);
	}
	else
	{
		format(string,sizeof(string),""C_YELLOW"Click to play\n"C_AQUA"Sperm Adventure : Remake\n"C_YELLOW"%d Playing",GetMapPlayingCount(1));
	    GameText[playerid][0] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[0], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"Click to play\n"C_AQUA"Protect President\n"C_YELLOW"%d Playing",GetMapPlayingCount(2));
	    GameText[playerid][1] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[1], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"Click to play\n"C_AQUA"Fuck Mode Returned: Shovel DM\n"C_YELLOW"%d Playing",GetMapPlayingCount(3));
	    GameText[playerid][2] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[2], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"Click to play\n"C_AQUA"Fuck Mode Returned: Zombie Survival\n"C_YELLOW"%d Playing",GetMapPlayingCount(4));
	    GameText[playerid][3] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[3], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"Click to play\n"C_AQUA"Fuck Mode Returned: 69 Scamper\n"C_YELLOW"%d Playing",GetMapPlayingCount(5));
	    GameText[playerid][4] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[4], .playerid = playerid);
	    format(string,sizeof(string),""C_YELLOW"Click to play\n"C_AQUA"Cops and Robbers\n"C_YELLOW"%d Playing",GetMapPlayingCount(6));
	    GameText[playerid][5] = CreateDynamic3DTextLabel(string, COLOR_AQUA, 0.0, 0.0, 0.0, 10.0, GameNPC[5], .playerid = playerid);
	    for(new i=0; i<MAX_GAMENPC; i++)
	        Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, GameText[playerid][i], E_STREAMER_ATTACH_OFFSET_Z, 0.3);
	}
}
//-----/ SetTingGameNpc /-------------------------------------------------------
stock SetTingGameNpc()
{
	GameNPC[0] = FCNPC_Create("Game1");
	GameNPC[1] = FCNPC_Create("Game2");
	GameNPC[2] = FCNPC_Create("Game3");
	GameNPC[3] = FCNPC_Create("Game4");
	GameNPC[4] = FCNPC_Create("Game5");
	GameNPC[5] = FCNPC_Create("Game6");
	//-----
	FCNPC_Spawn(GameNPC[0],52,1481.5987,-1625.2937,15.2313);
	FCNPC_SetAngle(GameNPC[0], 0.0);
	SetPlayerColor(GameNPC[0],0x00000000);
	FCNPC_SetHealth(GameNPC[0], 1000);

	FCNPC_Spawn(GameNPC[1],147,1477.5053,-1625.2937,15.2313);
	FCNPC_SetAngle(GameNPC[1], 0.0);
	SetPlayerColor(GameNPC[1],0x00000000);
    FCNPC_SetHealth(GameNPC[1], 1000);

	FCNPC_Spawn(GameNPC[2],27,1484.9115,-1623.4531,15.2313);
	FCNPC_SetAngle(GameNPC[2], 0.0);
	SetPlayerColor(GameNPC[2],0x00000000);
    FCNPC_SetWeapon(GameNPC[2], 6);
    FCNPC_SetHealth(GameNPC[2], 1000);

	FCNPC_Spawn(GameNPC[3],162,1488.2534,-1623.4531,15.2313);
	FCNPC_SetAngle(GameNPC[3], 0.0);
	SetPlayerColor(GameNPC[3],0x00000000);
	FCNPC_SetHealth(GameNPC[3], 1000);

	FCNPC_Spawn(GameNPC[4],2,1474.1506,-1623.4531,15.2313);
	FCNPC_SetAngle(GameNPC[4], 0.0);
	SetPlayerColor(GameNPC[4],0x00000000);
	FCNPC_SetHealth(GameNPC[4], 1000);

	FCNPC_Spawn(GameNPC[5],280,1470.8217,-1623.4531,15.2313);
	FCNPC_SetAngle(GameNPC[5], 0.0);
	SetPlayerColor(GameNPC[5],0x00000000);
	FCNPC_SetWeapon(GameNPC[5], 3);
	FCNPC_SetHealth(GameNPC[5], 1000);
}
