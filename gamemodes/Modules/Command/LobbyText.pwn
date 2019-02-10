/*
  [Functions]
	TogglePlayer3DText(playerid,language)
	SetTingGameNpc()
*/

//-----/ Pre-Processing /
#if defined _MDPWN_LobbyText
	#endinput
#endif
#define _MDPWN_LobbyText



//-----/ Includes /



//-----/ Defines /
#define MAX_GAMENPC 6



//-----/ News /
	//--/ LobbyText /
new Text3D:GameText[MAX_PLAYERS][MAX_GAMENPC];
new GameNPC[MAX_GAMENPC];


//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_LobbyText();
forward InitHandler_LobbyText();
forward KeyHandler_LobbyText(playerid,newkeys,oldkeys);
	//--/ Functions /





//==========/ Callback Functions /==============================================
//-----/ AddHandler_LobbyText /-------------------------------------------------
public AddHandler_LobbyText()
{
	AddHandler("LobbyText",InitHandler);
	AddHandler("LobbyText",KeyHandler);
	//AddTimer("LobbyText",TIMER_1S_PLAYER);
}
//-----/ InitHandler_LobbyText /------------------------------------------------
public InitHandler_LobbyText()
{
    new obj;
    //-----
    SetTingGameNpc();
	
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
//-----/ KeyHandler_LobbyText /-------------------------------------------------
public KeyHandler_LobbyText(playerid,newkeys,oldkeys)
{
	if(KEY_PRESSED(KEY_FIRE) || KEY_PRESSED(KEY_SECONDARY_ATTACK))
	{
	    if(GetDistanceFromPlayerToPoint(playerid, 1481.59875, -1625.29370, 13.62970) <= 1.5)
	    {
	        ChangePlayerMap(playerid,1);
	    }
	    else if(GetDistanceFromPlayerToPoint(playerid, 1477.50537, -1625.29370, 13.62970) <= 1.5)
	    {
	        ChangePlayerMap(playerid,2);
	    }
	    else if(GetDistanceFromPlayerToPoint(playerid, 1484.91150, -1623.45313, 13.62970) <= 1.5)
	    {
            ChangePlayerMap(playerid,3);
	    }
	    else if(GetDistanceFromPlayerToPoint(playerid, 1488.25342, -1623.45313, 13.62970) <= 1.5)
	    {
            ChangePlayerMap(playerid,4);
	    }
	    else if(GetDistanceFromPlayerToPoint(playerid, 1474.15063, -1623.45313, 13.62970) <= 1.5)
	    {
            ChangePlayerMap(playerid,5);
	    }
	    else if(GetDistanceFromPlayerToPoint(playerid, 1470.82178, -1623.45313, 13.62970) <= 1.5)
	    {
            ChangePlayerMap(playerid,6);
	    }
	}
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
