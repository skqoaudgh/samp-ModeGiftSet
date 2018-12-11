/*
  [Usage]
	서버에 접속한 모든 유저에 대해 루프:
		for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
		{
			pid = GetConnectedPlayerID(i);
		}
		
  [Functions]
	SetPlayerConnected(playerid)
	SetPlayerDisconnected(playerid)
	GetConnectedPlayers()
*/

//-----/ Pre-Processing /
#if defined _MDPWN_PlayerSide
	#endinput
#endif
#define _MDPWN_PlayerSide



//-----/ Includes /



//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1



//-----/ News /
	//--/ Player Connected /
new
	ConnectPlayers[MAX_PLAYERS],
	bool:ConnectPlayers_Connedted[MAX_PLAYERS],
	ConnectPlayers_Index
;



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_PlayerSide();
forward ConnectHandler_PlayerSide(playerid);
forward DisconnectHandler_PlayerSide(playerid,reason);
	//--/ Functions /





//==========/ Callback Functions /==============================================
//-----/ AddHandler_PlayerSide /------------------------------------------------
public AddHandler_PlayerSide()
{
	AddHandler("PlayerSide",ConnectHandler);
	AddHandler("PlayerSide",DisconnectHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}
//-----/ ConnectHandler_PlayerSide /--------------------------------------------
public ConnectHandler_PlayerSide(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
		new string[128];
		SetPlayerConnected(playerid);
		SetPlayerColor(playerid,COLOR_BLACK);
		for(new i; i<10; i++)
			RemovePlayerAttachedObject(playerid, i);
		//-----
		for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
		{
			pid = GetConnectedPlayerID(i);
			if(GetPlayerLanguage(pid) == 0)
			    format(string,sizeof(string),"%s(%d) 님이 접속하였습니다.",GetPlayerNameEx(pid),pid);
			else
			    format(string,sizeof(string),"%s(%d) has joined server.",GetPlayerNameEx(pid),pid);
            SendClientMessage(pid,COLOR_GREY,string);
		}
	}
}
//-----/ DisconnectHandler_PlayerSide /-----------------------------------------
public DisconnectHandler_PlayerSide(playerid,reason)
{
	if(!IsPlayerNPC(playerid))
	{
		new string[128];
		SetPlayerDisconnected(playerid);
		//-----
		for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
		{
			pid = GetConnectedPlayerID(i);
			if(GetPlayerLanguage(pid) == 0)
			{
				switch(reason)
				{
					case 0: string = "(타임아웃)";
					case 1: string = " ";
					case 2: string = "(킥&밴)";
				}
				format(string,sizeof(string),"%s(%d) 님이 접속을 종료하였습니다. %s",GetPlayerNameEx(pid),pid, string);
			}
			else
			{
				switch(reason)
				{
					case 0: string = "(Timeout)";
					case 1: string = " ";
					case 2: string = "(Kick&Ban)";
				}
				format(string,sizeof(string),"%s(%d) has quit server. %s",GetPlayerNameEx(pid),pid, string);
			}
            SendClientMessage(pid,COLOR_GREY,string);
		}
	}
}

//==========/ Functions /=======================================================
//-----/ IsPlayerTeamChatting /-------------------------------------------------
stock IsPlayerTeamChatting(playerid)
{
	return GetPVarInt(playerid,"TeamChat");
}
//-----/ ReturnUser /-----------------------------------------------------------
stock ReturnUser(text[])
{
	new pos = 0;
	while(text[pos] < 0x21)
	{
		if(text[pos] == 0)
			return INVALID_PLAYER_ID;
		pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if(IsNumeric(text[pos]))
	{
		userid = strval(text[pos]);
		if(userid >= 0 && userid < GetMaxPlayers())
		{
			if(!IsPlayerConnected(userid))
				userid = INVALID_PLAYER_ID;
			else
				return userid;
		}
	}
	new len = strlen(text[pos]);
	new count = 0;
	new name[MAX_PLAYER_NAME];
	for(new i=0,t=GetMaxPlayers(); i<t; i++)
		if(IsPlayerConnected(i))
		{
			GetPlayerName(i,name,sizeof(name));
			if(strcmp(name,text[pos],true,len) == 0)
			{
				if(len == strlen(name))
					return i;
				else {
					count++;
					userid = i;
				}
			}
		}
	if(count != 1)
		userid = INVALID_PLAYER_ID;
	return userid;
}
//-----/ IsNumeric /------------------------------------------------------------
stock IsNumeric(const string[])
{
	for(new i=0,t=strlen(string); i<t; i++)
		if(string[i] < '0' || string[i] > '9')
			return false;
	return true;
}
//-----/ stringslice_c /--------------------------------------------------------
stock stringslice_c(const string[],index,separator=' ')
{
	new
		sliceidx,
		bool:copy,bool:find,
		result[256],idx
	;
	for(new i,t=strlen(string); i<t; i++)
	{
		if(!copy)
			if(find)
			{
				if(string[i] == separator)
				{
					sliceidx ++;
					find = false;
				}
			} else {
				if(string[i] != separator)
				{
					if(sliceidx == index)
						copy = true;
					find = true;
				}
			}
		if(copy)
			result[idx++] = string[i];
	}
	return result;
}

//==========/ Connected Players Functions /=====================================
//-----/ SetPlayerConnected /---------------------------------------------------
stock SetPlayerConnected(playerid)
{
	if(!IsPlayerConnectedEx(playerid))
		ConnectPlayers[ConnectPlayers_Index++] = playerid;
	ConnectPlayers_Connedted[playerid] = true;
}
//-----/ SetPlayerDisconnected /------------------------------------------------
stock SetPlayerDisconnected(playerid)
{
	for(new i; i<ConnectPlayers_Index; i++)
		if(ConnectPlayers[i] == playerid)
		{
			for(new j=i+1; j<ConnectPlayers_Index; j++)
				ConnectPlayers[j-1] = ConnectPlayers[j];
			ConnectPlayers_Index--;
			break;
		}
	ConnectPlayers_Connedted[playerid] = false;
}
//-----/ IsPlayerConnectedEx /--------------------------------------------------
stock IsPlayerConnectedEx(playerid)
	return ConnectPlayers_Connedted[playerid];
//-----/ GetConnectedPlayers /--------------------------------------------------
stock GetConnectedPlayers()
	return ConnectPlayers_Index;
//-----/ GetConnectedPlayersArray /---------------------------------------------
stock GetConnectedPlayerID(idx)
	return ConnectPlayers[idx];
//-----/ GetPlayerIDByUserID /--------------------------------------------------
stock GetPlayerIDByUserID(userid)
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPVarInt(pid,"ID") == userid)
			return pid;
	}
	return INVALID_PLAYER_ID;
}
//-----/ IsPlayerConnectedByID /------------------------------------------------
stock IsPlayerConnectedByID(userid)
{
	return GetPlayerIDByUserID(userid) == INVALID_PLAYER_ID ? 0 : 1;
}
