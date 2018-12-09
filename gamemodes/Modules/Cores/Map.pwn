/*
  [Functions]
	GetPlayerMap(playerid)
	ShowPlayerMapList(playerid)
	FreezePlayer(playerid)
	UnFreezePlayer(playerid)
	SendMessage(playerid, text[])
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Map
	#endinput
#endif
#define _MDPWN_Map



//-----/ Includes /



//-----/ Defines /
#define MAX_MAP                     1
#define DialogID_Map(%1)			10100 + %1



//-----/ News /
	//--/ Map /
enum mInfo
{
	Type,       // 0:아케이드
	Name[128],
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
forward DisconnectHandler_Map(playerid,reason);
forward DialogHandler_Map(playerid,dialogid,response,listitem,inputtext[]);
	//--/ Functions /
forward UnFreezePlayer(playerid);


//==========/ Callback Functions /==============================================
//-----/ AddHandler_Map /-------------------------------------------------------
public AddHandler_Map()
{
    AddHandler("Map",InitHandler);
    AddHandler("Map",CommandHandler);
    AddHandler("Map",DisconnectHandler);
    AddHandler("Map",DialogHandler);
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
	strmid(MapInfo[0][Name], "정자의 모험 리메이크", 0, strlen("정자의 모험 리메이크"));
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

//-----/ DialogHandler_Map /---------------------------------------------------
public DialogHandler_Map(playerid,dialogid,response,listitem,inputtext[])
{
	switch(dialogid)
	{
		case DialogID_Map(0): // 맵 목록
		{
			
		}
	}
	return 0;
}

//==========/ Functions /=======================================================
//-----/ FreezePlayer /---------------------------------------------------------
stock FreezePlayer(playerid, time)
{
    TogglePlayerControllable(playerid,0);
	FreezeTimer[playerid] = SetTimerEx("UnFreezePlayer",time*1000,"d",playerid);
}

//-----/ UnFreezePlayer /-------------------------------------------------------
public UnFreezePlayer(playerid)
{
    TogglePlayerControllable(playerid,1);
}

//-----/ SendMessage /----------------------------------------------------------
stock SendMessage(playerid, color, text[])
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(GetPVarInt(playerid,"MapNumber") == GetPVarInt(i,"MapNumber")) // playerid와 같은 게임을 진행 중인 플레이어
				SendClientMessage(i, color, text);
	    }
	}
}

//-----/ GetPlayerMap /---------------------------------------------------------
stock GetPlayerMap(playerid)
{
	return GetPVarInt(playerid,"MapNumber");
}

//-----/ ShowPlayerMapList /----------------------------------------------------
stock ShowPlayerMapList(playerid)
{
	new string[1024], temp[56];
	for(new i=0; i<MAX_MAP; i++)
	{
	    format(temp,sizeof(temp),"%d\t",i+1);
		strcat(string,temp);
	    format(temp,sizeof(temp),"%s\t",MapInfo[i][Name]);
		strcat(string,temp);
	    format(temp,sizeof(temp),"%d\n",MapInfo[i][PlayerCount]);
		strcat(string,temp);
	}
	ShowPlayerDialog(playerid, DialogID_Map(0), DIALOG_STYLE_TABLIST_HEADERS, ""C_PASTEL_YELLOW"번호\t"C_PASTEL_YELLOW"이름\t"C_PASTEL_YELLOW"인원", string, "확인","닫기");
}
