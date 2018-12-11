/*
  [Functions]
	GetPlayerMap(playerid)
	ShowPlayerMapList(playerid)
	FreezePlayer(playerid)
	UnFreezePlayer(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Map
	#endinput
#endif
#define _MDPWN_Map



//-----/ Includes /



//-----/ Defines /
#define MAX_MAP                     4
#define DialogID_Map(%1)			10200 + %1



//-----/ News /
	//--/ Map /
enum mInfo
{
	Type,       // 0:아케이드
	KrName[128],
	EnName[128],
	PlayerCount
}
new
	MapInfo[MAX_MAP][mInfo],
	FreezeTimer[MAX_PLAYERS]
;



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Map();
forward InitHandler_Map();
forward CommandHandler_Map(playerid,cmdtext[]);
forward DialogHandler_Map(playerid,dialogid,response,listitem,inputtext[]);
forward ConnectHandler_Map(playerid);
forward DisconnectHandler_Map(playerid,reason);
forward SpawnHandler_Map(playerid);

	//--/ Functions /
forward UnFreezePlayer(playerid);


//==========/ Callback Functions /==============================================
//-----/ AddHandler_Map /-------------------------------------------------------
public AddHandler_Map()
{
    AddHandler("Map",InitHandler);
    AddHandler("Map",CommandHandler);
    AddHandler("Map",ConnectHandler);
    AddHandler("Map",DisconnectHandler);
    AddHandler("Map",DialogHandler);
    AddHandler("Map",SpawnHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}

//-----/ InitHandler_Map /--------------------------------------------------
public InitHandler_Map()
{
	for(new i=0; i<MAX_MAP; i++)
	{
	    MapInfo[i][Type] = 0;
	    MapInfo[i][PlayerCount] = 0;
	}
	format(MapInfo[0][KrName],128,"로비");
	format(MapInfo[1][KrName],128,"정자의 모험 : 리메이크");
	format(MapInfo[2][KrName],128,"대통령 지키기");
	format(MapInfo[3][KrName],128,"돌아온 시발모드 : 삽 대전");
	
	format(MapInfo[0][EnName],128,"Lobby");
	format(MapInfo[1][EnName],128,"Sperm Adventure : Remake");
	format(MapInfo[2][EnName],128,"Protect President");
	format(MapInfo[3][EnName],128,"Fuck Mode Returned: Shovel DM");
}
//-----/ ConnectHandler_Map /----------------------------------------------
public ConnectHandler_Map(playerid)
{
	MapInfo[0][PlayerCount] ++;
}
//-----/ DisconnectHandler_Map /------------------------------------------------
public DisconnectHandler_Map(playerid,reason)
{
	KillTimer(FreezeTimer[playerid]);
}
//-----/ CommandHandler_Map /---------------------------------------------------
public CommandHandler_Map(playerid,cmdtext[]) //return 1: processed
{
	new
		cmd[256],idx
		//string[128]
	;
	cmd = strtok(cmdtext,idx);

	if(!strcmp("/맵",cmd) || !strcmp("/map",cmd))
	{
		ShowPlayerMapList(playerid);
	    return 1;
	}
	return 0;
}
//-----/ SpawnHandler_Map /---------------------------------------------------
public SpawnHandler_Map(playerid)
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
//-----/ DialogHandler_Map /---------------------------------------------------
public DialogHandler_Map(playerid,dialogid,response,listitem,inputtext[])
{
	switch(dialogid)
	{
		case DialogID_Map(0): // 맵 목록
		{
			if(response)
			{
			    // 게임 진행 중, 게임 변경 시 처리
				// 대통령 지키기
				if(GetPresidentPlayer() == playerid)
				{
			        KillTimer(GetRoundTimer());
			        SetPresidentPlayer(-1);
			        if(GetPlayerLanguage(playerid) == 0)
			        	SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] 대통령이 접속을 종료해 게임이 중단됩니다. 대통령이 새롭게 선정되면 게임이 재개됩니다.");
					else
					{
					    SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] The game is paused because the president is disconnected.");
					    SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] The game will resume when new president is selected.");
					}
				}
				SetPlayerHasTeam(playerid, false);
				HidePlayerTeamTD(playerid);
			    //-----
			    new beforeIdx = GetPVarInt(playerid,"MapNumber");
				SetPVarInt(playerid,"MapNumber",listitem);
				MapInfo[listitem][PlayerCount] ++;
				MapInfo[beforeIdx][PlayerCount] --;
				SpawnPlayer(playerid);
			}
		}
	}
	return 0;
}

//==========/ Functions /=======================================================
//-----/ FreezePlayer /---------------------------------------------------------
stock FreezePlayer(playerid, time=0)
{
    TogglePlayerControllable(playerid,0);
    if(time > 0)
		FreezeTimer[playerid] = SetTimerEx("UnFreezePlayer",time*1000,0,"d",playerid);
}

//-----/ UnFreezePlayer /-------------------------------------------------------
public UnFreezePlayer(playerid)
{
    TogglePlayerControllable(playerid,1);
}

//-----/ GetPlayerMap /---------------------------------------------------------
stock GetPlayerMap(playerid)
{
	return GetPVarInt(playerid,"MapNumber");
}

//-----/ ShowPlayerMapList /----------------------------------------------------
stock ShowPlayerMapList(playerid)
{
	new string[2048], temp[128];
	new len = GetPlayerLanguage(playerid);
	if(len == 0)
		format(string,sizeof(string),""C_PASTEL_YELLOW"번호\t"C_PASTEL_YELLOW"이름\t"C_PASTEL_YELLOW"인원\n");
	else
	    format(string,sizeof(string),""C_PASTEL_YELLOW"No.\t"C_PASTEL_YELLOW"Name\t"C_PASTEL_YELLOW"Playing\n");
	for(new i=0; i<MAX_MAP; i++)
	{
		if(len == 0)
	    	format(temp,sizeof(temp),"%d\t%s\t%d\n",i,MapInfo[i][KrName],MapInfo[i][PlayerCount]);
		else
		    format(temp,sizeof(temp),"%d\t%s\t%d\n",i,MapInfo[i][EnName],MapInfo[i][PlayerCount]);
		strcat(string,temp);
	}
	if(len == 0)
		ShowPlayerDialog(playerid, DialogID_Map(0), DIALOG_STYLE_TABLIST_HEADERS, ""C_PASTEL_GREEN"맵 선택",string, "확인","닫기");
	else
	    ShowPlayerDialog(playerid, DialogID_Map(0), DIALOG_STYLE_TABLIST_HEADERS, ""C_PASTEL_GREEN"Select Map",string, "OK","Cancel");
}
