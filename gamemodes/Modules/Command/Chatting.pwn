/*
  [Functions]
	GetPlayerLanguage(playerid)
	SendMessage(playerid, color, text[])
	SendMapMessage(mapid, color, text[])
	SendTeamMessage(playerid, text[])
	SendClientMessageToAdmin(color,text[])
	ClearChatting(playerid);
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Chatting
	#endinput
#endif
#define _MDPWN_Chatting


//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Chatting();
forward TextHandler_Chatting(playerid,text[]);
forward CommandHandler_Chatting(playerid,cmdtext[]);
forward DialogHandler_Chatting(playerid,dialogid,response,listitem,inputtext[]);
forward KeyHandler_Chatting(playerid,newkeys,oldkeys);
	//--/ Functions /



//==========/ Callback Functions /==============================================
//-----/ AddHandler_Chatting /--------------------------------------------------
public AddHandler_Chatting()
{
    AddHandler("Chatting",TextHandler,100);
	AddHandler("Chatting",CommandHandler);
	AddHandler("Chatting",KeyHandler);
	//AddHandler("WTF",InitHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}
//-----/ TextHandler_Chatting /-------------------------------------------------
public TextHandler_Chatting(playerid,text[])
{
	new string[384];
	if(IsPlayerTeamChatting(playerid))
	{
	    SendTeamMessage(playerid, text);
	    return 1;
	}
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerLanguage(pid) == 0)
			format(string,sizeof(string),"[����] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
		else
		    format(string,sizeof(string),"[Local] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
		SendClientMessage(pid, GetPlayerColor(playerid), string);
	}
	return 1;
}
//-----/ CommandHandler_Chatting /----------------------------------------------
public CommandHandler_Chatting(playerid,cmdtext[])
{
	new
		cmd[384],idx,
		string[384],temp[384]
	;
	cmd = strtok(cmdtext,idx);
	if(!strcmp("/g",cmd,true) || !strcmp("/global",cmd,true) || !strcmp("/o",cmd,true) || !strcmp("/ooc",cmd,true))
	{
	    /*
		if(GetPVarInt(playerid,"Mute"))
		{
			SendClientMessage(playerid,COLOR_WHITE,"[!] �����ڿ� ���� ���� �� �� ���� �����Դϴ�.");
			return 0;
		}
		*/
		cmd = strtok(cmdtext,idx);
		if(!GetPVarInt(playerid,"ToggleGlobal"))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] ��üä���� ��Ȱ��ȭ �Ǿ� �ֽ��ϴ�. [/���]���� �Ѱ� ����ϼ���.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Your Global Chatting is disbaled. Try again after enable Global Chatting [/toggle]");
		}
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] ����: (/g)lobal [����]");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Usage: (/g)lobal [Text]");
		}
		strcpy(string,stringslice_c(cmdtext,1));
  		
		for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
		{
			pid = GetConnectedPlayerID(i);
			if(GetPVarInt(pid,"ToggleGlobal"))
			{
			    if(GetPlayerLanguage(pid) == 0)
			    	format(string,sizeof(string),"[��ü] %s(%d): %s",GetPlayerNameEx(playerid),playerid,string);
				else
				    format(string,sizeof(string),"[Global] %s(%d): %s",GetPlayerNameEx(playerid),playerid,string);
			    SendClientMessage(pid,0xFDE8CDFF,string);
			}
		}
		return 1;
	}
	
	if(!strcmp("/w",cmd,true) || !strcmp("/ow",cmd,true) || !strcmp("/op",cmd,true) || !strcmp("/pm",cmd,true) || !strcmp("/oocw",cmd,true) || !strcmp("/�ӼӸ�",cmd,true) || !strcmp("/��",cmd,true))
	{
	    /*
		if(GetPVarInt(playerid,"Mute"))
		{
			SendClientMessage(playerid,COLOR_GREY,"[!] �����ڿ� ���� ���� �� �� ���� �����Դϴ�.");
			return 0;
		}
		*/
		cmd = strtok(cmdtext,idx);
		if(!GetPVarInt(playerid,"TogglePM"))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] �ӼӸ��� ��Ȱ��ȭ �Ǿ� �ֽ��ϴ�. [/���]���� �Ѱ� ����ϼ���.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Your PM is disbaled. Try again after enable PM [/toggle]");
		}
			
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] ����: /pm [������ȣ] [����]");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Usage: /pm [playerid] [Text]");
		}
			
		new destid = strval(cmd);
		if(destid == INVALID_PLAYER_ID)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] �߸��� ���� �����Դϴ�.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
		}
			
		if(playerid == destid)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] �ڱ� �ڽſ��� �ӼӸ��� ���� �� �����ϴ�.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You can`t send a message to yourself.");
		}
			
		if(!GetPVarInt(destid,"TogglePM"))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] ������ �ӼӸ��� �����ϰ� �ֽ��ϴ�.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] He/She has disabled PM.");
		}
			
  		strcpy(temp,stringslice_c(cmdtext,2));
		if(!strlen(temp))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] ����: /pm [������ȣ] [����]");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Usage: /pm [playerid] [Text]");
		}
		//-----
		format(string,sizeof(string),"[PM] >> %s(%d): %s",GetPlayerNameEx(destid),destid,temp);
		SendClientMessage(playerid,COLOR_PASTEL_YELLOW,string); // ������ ���
		format(string,sizeof(string),"[PM] << %s(%d): %s",GetPlayerNameEx(playerid),playerid,temp);
		SendClientMessage(destid,COLOR_YELLOW,string); // ��뿡�� ���
		//-----
		// ������ PM ����
		format(string,sizeof(string),"[PM] %s(%d) >> %s(%d): %s",GetPlayerNameEx(playerid),playerid,GetPlayerNameEx(destid),destid,temp);
		for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
		{
			pid = GetConnectedPlayerID(i);
			if(pid == playerid || pid == destid)
				continue;
			if(IsPlayerAdminEx(pid) && GetPVarInt(pid,"ToggleAdminPMCheck"))
				SendClientMessage(pid,COLOR_YELLOW,string);
		}
		return 1;
 	}
	return 0;
}
//-----/ KeyHandler_Chatting /--------------------------------------------------
public KeyHandler_Chatting(playerid,newkeys,oldkeys)
{
	if(newkeys == KEY_ANALOG_LEFT)
	{
	    if(GetPlayerTeam(playerid) != NO_TEAM)
	    {
	        if(GetPVarInt(playerid,"TeamChat"))
	        {
	            SetPVarInt(playerid,"TeamChat", 0);
	            SendClientMessage(playerid,COLOR_WHITE,"[!] �� ä���� ��Ȱ��ȭ�Ͽ����ϴ�.");
	        }
	            
	        else if(!GetPVarInt(playerid,"TeamChat"))
	        {
	            SetPVarInt(playerid,"TeamChat", 1);
	            SendClientMessage(playerid,COLOR_WHITE,"[!] �� ä���� Ȱ��ȭ�Ͽ����ϴ�.");
	        }
	    }
	}
	return 0;
}

//==========/ Message Functions /===============================================
//-----/ ClearChatting /--------------------------------------------------------
stock ClearChatting(playerid)
{
	for(new i=0; i<20; i++)
	    SendClientMessage(playerid,COLOR_BLACK," ");
}
//-----/ SendMessage /----------------------------------------------------------
stock SendMessage(playerid, color, text[])
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
        if(GetPlayerMap(pid) == GetPlayerMap(playerid)) // playerid�� ���� ������ ���� ���� �÷��̾�
			SendClientMessage(pid, color, text);
	}
}
//-----/ SendMapMessage /-------------------------------------------------------
stock SendMapMessage(mapid, color, text[])
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
        if(GetPlayerMap(pid) == mapid) // playerid�� ���� ������ ���� ���� �÷��̾�
			SendClientMessage(pid, color, text);
	}
}
//-----/ SendTeamMessage /------------------------------------------------------
stock SendTeamMessage(playerid, text[])
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
	    if(GetPlayerTeam(pid) == GetPlayerTeam(playerid) && GetPlayerMap(pid) == GetPlayerMap(playerid))
		{
		    new string[384];
			if(GetPlayerLanguage(pid) == 0)
				format(string,sizeof(string),"[��ä��] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
			else
			    format(string,sizeof(string),"[TeamChatting] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
			SendClientMessage(pid, COLOR_TEAM, string);
		}
	}
}
//-----/ SendClientMessageToAdmin /---------------------------------------------
stock SendClientMessageToAdmin(color,text[])
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(IsPlayerAdminEx(pid))
			SendClientMessage(pid,color,text);
	}
}
//==========/ Get/Set Functions /===============================================
//-----/ GetPlayerLanguage /----------------------------------------------------
stock GetPlayerLanguage(playerid)
{
	return GetPVarInt(playerid,"Language");
}
//-----/ IsPlayerTeamChatting /-------------------------------------------------
stock IsPlayerTeamChatting(playerid)
{
	return GetPVarInt(playerid,"TeamChat");
}
