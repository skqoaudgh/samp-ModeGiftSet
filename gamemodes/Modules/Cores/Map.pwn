/*
  [Functions]
	GetPlayerMap(playerid)
	ShowPlayerMapList(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Map
	#endinput
#endif
#define _MDPWN_Map


//-----/ Defines /
#define MAX_MAP                     6
#define DialogID_Map(%1)			10200 + %1


//-----/ News /
	//--/ Map /
enum mInfo
{
	Type,       // 0:�����̵�
	KrName[128],
	EnName[128],
	PlayerCount
}
new
	MapInfo[MAX_MAP][mInfo]
;


//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Map();
forward InitHandler_Map();
forward CommandHandler_Map(playerid,cmdtext[]);
forward DialogHandler_Map(playerid,dialogid,response,listitem,inputtext[]);
forward ConnectHandler_Map(playerid);
forward DisconnectHandler_Map(playerid,reason);
	//--/ Functions /


//==========/ Callback Functions /==============================================
//-----/ AddHandler_Map /-------------------------------------------------------
public AddHandler_Map()
{
    AddHandler("Map",InitHandler);
    AddHandler("Map",CommandHandler);
    AddHandler("Map",ConnectHandler);
    AddHandler("Map",DialogHandler);
    AddHandler("Map",DisconnectHandler);
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
	format(MapInfo[0][KrName],128,"�κ�");
	format(MapInfo[1][KrName],128,"������ ���� : ������ũ");
	format(MapInfo[2][KrName],128,"����� ��Ű��");
	format(MapInfo[3][KrName],128,"���ƿ� �ù߸�� : �� ����");
	format(MapInfo[4][KrName],128,"���ƿ� �ù߸�� : ���� �����̹�");
	format(MapInfo[5][KrName],128,"���ƿ� �ù߸�� : 69 ����");
	
	format(MapInfo[0][EnName],128,"Lobby");
	format(MapInfo[1][EnName],128,"Sperm Adventure : Remake");
	format(MapInfo[2][EnName],128,"Protect President");
	format(MapInfo[3][EnName],128,"Fuck Mode Returned: Shovel DM");
	format(MapInfo[4][EnName],128,"Fuck Mode Returned: Zombie Survival");
	format(MapInfo[5][EnName],128,"Fuck Mode Returned: 69 Scamper");
}
//-----/ ConnectHandler_Map /----------------------------------------------
public ConnectHandler_Map(playerid)
{
	MapInfo[0][PlayerCount] ++;
}
//-----/ DisconnectHandler_Map /-----------------------------------------
public DisconnectHandler_Map(playerid,reason)
{
    MapInfo[GetPlayerMap(playerid)][PlayerCount] --;
    RemovePlayerMapIcon(playerid, 0);
}
//-----/ CommandHandler_Map /---------------------------------------------------
public CommandHandler_Map(playerid,cmdtext[]) //return 1: processed
{
	new
		cmd[256],idx
		//string[128]
	;
	cmd = strtok(cmdtext,idx);

	if(!strcmp("/��",cmd) || !strcmp("/map",cmd))
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
		case DialogID_Map(0): // �� ���
		{
			if(response)
			{
			    // ���� ���� ��, ���� ���� �� ó��
				// ����� ��Ű��
				if(GetPresidentPlayer() == playerid)
				{
			        KillTimer(GetRoundTimer());
			        SetPresidentPlayer(-1);
			        if(GetPlayerLanguage(playerid) == 0)
			        	SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] ������� ������ ������ ������ �ߴܵ˴ϴ�. ������� ���Ӱ� �����Ǹ� ������ �簳�˴ϴ�.");
					else
					{
					    SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] The game is paused because the president is disconnected.");
					    SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] The game will resume when new president is selected.");
					}
				}
				SetPlayerTeam(playerid,NO_TEAM);
				SetPlayerHasTeam(playerid, false);
				HidePlayerTeamTD(playerid);
				RemovePlayerMapIcon(playerid, 0);
			    //-----
			    new beforeIdx = GetPVarInt(playerid,"MapNumber");
				SetPVarInt(playerid,"MapNumber",listitem);
				MapInfo[listitem][PlayerCount] ++;
				MapInfo[beforeIdx][PlayerCount] --;
				SetPlayerMarkerForPlayerEx(playerid, GetPlayerColor(playerid));
				StopAudioStreamForPlayerEx(playerid);
				SpawnPlayer(playerid);
			}
		}
	}
	return 0;
}

//==========/ Functions /=======================================================
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
		format(string,sizeof(string),""C_PASTEL_YELLOW"��ȣ\t"C_PASTEL_YELLOW"�̸�\t"C_PASTEL_YELLOW"�ο�\n");
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
		ShowPlayerDialog(playerid, DialogID_Map(0), DIALOG_STYLE_TABLIST_HEADERS, ""C_PASTEL_GREEN"�� ����",string, "Ȯ��","�ݱ�");
	else
	    ShowPlayerDialog(playerid, DialogID_Map(0), DIALOG_STYLE_TABLIST_HEADERS, ""C_PASTEL_GREEN"Select Map",string, "OK","Cancel");
}
