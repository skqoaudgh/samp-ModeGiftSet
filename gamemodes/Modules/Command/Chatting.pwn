/*
  [Functions]
	ShowPlayerToggleDialog(playerid)
	ShowPlayerChangeLanguageDialog(playerid)

	GetPlayerLanguage(playerid)
	
	SendMessage(playerid, color, text[])
	SendTeamMessage(playerid, text[])
	SendClientMessageToAdmin(color,text[])
	ClearChatting(playerid);
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Chatting
	#endinput
#endif
#define _MDPWN_Chatting



//-----/ Includes /



//-----/ Defines /
#define DialogID_Chatting(%1)			10300 + %1



//-----/ News /
	//--/  /



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Chatting();
forward TextHandler_Chatting(playerid,text[]);
forward CommandHandler_Chatting(playerid,cmdtext[]);
forward DialogHandler_Chatting(playerid,dialogid,response,listitem,inputtext[]);
	//--/ Functions /





//==========/ Callback Functions /==============================================
//-----/ AddHandler_Chatting /--------------------------------------------------
public AddHandler_Chatting()
{
    AddHandler("Chatting",TextHandler,100);
	AddHandler("Chatting",CommandHandler);
	AddHandler("Chatting",DialogHandler);
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
			format(string,sizeof(string),"[지역] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
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
	if(!strcmp("/채팅",cmd) || !strcmp("/스위치",cmd) || !strcmp("/토글",cmd) || !strcmp("/toggle",cmd) || !strcmp("/tog",cmd))
	{
		ShowPlayerToggleDialog(playerid);
		return 1;
	}
	
	if(!strcmp("/g",cmd,true) || !strcmp("/global",cmd,true) || !strcmp("/o",cmd,true) || !strcmp("/ooc",cmd,true))
	{
	    /*
		if(GetPVarInt(playerid,"Mute"))
		{
			SendClientMessage(playerid,COLOR_WHITE,"[!] 관리자에 의해 말을 할 수 없는 상태입니다.");
			return 0;
		}
		*/
		cmd = strtok(cmdtext,idx);
		if(!GetPVarInt(playerid,"ToggleGlobal"))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 전체채팅이 비활성화 되어 있습니다. [/토글]에서 켜고 사용하세요.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Your Global Chatting is disbaled. Try again after enable Global Chatting [/toggle]");
		}
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 사용법: (/g)lobal [내용]");
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
			    	format(string,sizeof(string),"[전체] %s(%d): %s",GetPlayerNameEx(playerid),playerid,string);
				else
				    format(string,sizeof(string),"[Global] %s(%d): %s",GetPlayerNameEx(playerid),playerid,string);
			    SendClientMessage(pid,0xFDE8CDFF,string);
			}
		}
		return 1;
	}
	
	if(!strcmp("/w",cmd,true) || !strcmp("/ow",cmd,true) || !strcmp("/op",cmd,true) || !strcmp("/pm",cmd,true) || !strcmp("/oocw",cmd,true) || !strcmp("/귓속말",cmd,true) || !strcmp("/귓",cmd,true))
	{
	    /*
		if(GetPVarInt(playerid,"Mute"))
		{
			SendClientMessage(playerid,COLOR_GREY,"[!] 관리자에 의해 말을 할 수 없는 상태입니다.");
			return 0;
		}
		*/
		cmd = strtok(cmdtext,idx);
		if(!GetPVarInt(playerid,"TogglePM"))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 귓속말이 비활성화 되어 있습니다. [/토글]에서 켜고 사용하세요.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Your PM is disbaled. Try again after enable PM [/toggle]");
		}
			
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 사용법: /pm [유저번호] [내용]");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Usage: /pm [playerid] [Text]");
		}
			
		new destid = strval(cmd);
		if(destid == INVALID_PLAYER_ID)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 잘못된 유저 정보입니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
		}
			
		if(playerid == destid)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 자기 자신에게 귓속말을 보낼 수 없습니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You can`t send a message to yourself.");
		}
			
		if(!GetPVarInt(destid,"TogglePM"))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 상대방이 귓속말을 차단하고 있습니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] He/She has disabled PM.");
		}
			
  		strcpy(temp,stringslice_c(cmdtext,2));
		if(!strlen(temp))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 사용법: /pm [유저번호] [내용]");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] Usage: /pm [playerid] [Text]");
		}
		//-----
		format(string,sizeof(string),"[PM] >> %s(%d): %s",GetPlayerNameEx(destid),destid,temp);
		SendClientMessage(playerid,COLOR_PASTEL_YELLOW,string); // 나한테 출력
		format(string,sizeof(string),"[PM] << %s(%d): %s",GetPlayerNameEx(playerid),playerid,temp);
		SendClientMessage(destid,COLOR_YELLOW,string); // 상대에게 출력
		//-----
		// 관리자 PM 감시
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
//-----/ DialogHandler_Chatting /-----------------------------------------------
public DialogHandler_Chatting(playerid,dialogid,response,listitem,inputtext[])
{
	switch(dialogid)
	{
		case DialogID_Chatting(0):
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(GetPVarInt(playerid,"ToggleGlobal"))
							SetPVarInt(playerid,"ToggleGlobal",0);
						else
							SetPVarInt(playerid,"ToggleGlobal",1);
					}
					case 1:
					{
						if(GetPVarInt(playerid,"TogglePM"))
							SetPVarInt(playerid,"TogglePM",0);
						else
							SetPVarInt(playerid,"TogglePM",1);
					}
				}
				SavePlayerData(playerid);
				ShowPlayerToggleDialog(playerid);
			}
		}
		case DialogID_Chatting(1):
		{
			if(response)
			{
				SetPVarInt(playerid,"Language",listitem);
				ShowPlayerChangeLanguageDialog(playerid);
			}
		}
	}
	return 0;
}

//==========/ Dialog Functions /================================================
//-----/ ShowPlayerToggleDialog /-----------------------------------------------
stock ShowPlayerToggleDialog(playerid)
{
	new dialog[1000];

	if(GetPlayerLanguage(playerid) == 0)
	{
		if(GetPVarInt(playerid,"ToggleGlobal"))
			strcat(dialog,"> 전체 채팅\t"C_PASTEL_GREEN"허용\n");
		else
			strcat(dialog,"> 전체 채팅\t"C_PASTEL_RED"거부\n");

		if(GetPVarInt(playerid,"TogglePM"))
			strcat(dialog,"> 귓속말\t"C_PASTEL_GREEN"허용\n");
		else
			strcat(dialog,"> 귓속말\t"C_PASTEL_RED"거부\n");
	}
	else
	{
		if(GetPVarInt(playerid,"ToggleGlobal"))
			strcat(dialog,"> Global Chatting\t"C_PASTEL_GREEN"Enabled\n");
		else
			strcat(dialog,"> Global Chatting\t"C_PASTEL_RED"Disabled\n");

		if(GetPVarInt(playerid,"TogglePM"))
			strcat(dialog,"> Private Message\t"C_PASTEL_GREEN"Enabled\n");
		else
			strcat(dialog,"> Private Message\t"C_PASTEL_RED"Disabled\n");
	}

	ShowPlayerDialog(playerid,DialogID_Chatting(0),DIALOG_STYLE_TABLIST,"Chatting Toggle",dialog,"선택","닫기");
}
//-----/ ShowPlayerChangeLanguageDialog /---------------------------------------
stock ShowPlayerChangeLanguageDialog(playerid)
{
	new lan = GetPVarInt(playerid,"Language");
	new string[256];
	if(lan == 0) // 한국어 사용 중
	{
	    strcat(string,""C_PASTEL_YELLOW"한국어 (Selected)\n");
	    strcat(string,"English");
	}
	else // 영어 사용 중
	{
	    strcat(string,"한국어\n");
	    strcat(string,""C_PASTEL_YELLOW"English (Selected)");
	}
	if(IsPlayerLoggedIn(playerid))
 		ShowPlayerDialog(playerid,DialogID_Chatting(1),DIALOG_STYLE_LIST,"Language Setting",string,"변경","취소");
 	else
 	    ShowPlayerLoginDialog(playerid);
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
        if(GetPlayerMap(pid) == GetPlayerMap(playerid)) // playerid와 같은 게임을 진행 중인 플레이어
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
				format(string,sizeof(string),"[팀채팅] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
			else
			    format(string,sizeof(string),"[TeamChatting] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
			SendClientMessage(pid, COLOR_TEAM, text);
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
//-----/ IsPlayerSelectLanguage /-----------------------------------------------
stock IsPlayerSelectLanguage(playerid)
{
	return P_Selected[playerid];
}
