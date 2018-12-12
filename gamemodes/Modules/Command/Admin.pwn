/*
  [Functions]
  
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Admin
	#endinput
#endif
#define _MDPWN_Admin



//-----/ Includes /



//-----/ Defines /
//#define Dialog_Admin(%1)			10400 + %1



//-----/ News /
	//--/  /



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Admin();
forward CommandHandler_Admin(playerid,cmdtext[]);
forward DialogHandler_Admin(playerid,dialogid,response,listitem,inputtext[]);
	//--/ Functions /





//==========/ Callback Functions /==============================================
//-----/ AddHandler_Admin /-----------------------------------------------------
public AddHandler_Admin()
{
	AddHandler("Admin",CommandHandler);
	AddHandler("Admin",DialogHandler);
	//AddHandler("WTF",InitHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}
//-----/ CommandHandler_Admin /-------------------------------------------------
public CommandHandler_Admin(playerid,cmdtext[])
{
	new
		cmd[384],idx,
		string[384],temp[384]
	;
	if(!strcmp("/�Ű�",cmd) || !strcmp("/report",cmd))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid))
		    	return SendClientMessage(playerid,COLOR_GREY,"[!] ����: /�Ű� [��ȣ�� �̸��� �Ϻ�] [����]");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /report [playerid or part of name] [Text]");
		}
		new destid = ReturnUser(cmd);
		if(destid == INVALID_PLAYER_ID)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] �߸��� ���� �����Դϴ�.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
		}
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid))
		    	return SendClientMessage(playerid,COLOR_GREY,"[!] ����: /�Ű� [��ȣ�� �̸��� �Ϻ�] [����]");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /report [playerid or part of name] [Text]");
		}
		//-----
		strcpy(cmd,stringslice_c(cmdtext,2));
		format(string,sizeof(string),"[!] %s(%d) -> %s(%d) �Ű�: %s",GetPlayerNameEx(playerid),playerid,GetPlayerNameEx(destid),destid,cmd);
		SendClientMessageToAdmin(COLOR_PASTEL_GREEN,string);
	    if(GetPlayerLanguage(playerid))
	    	SendClientMessage(playerid,0xC0E0FFFF,"�����ڿ��� ������ �����Ͽ����ϴ�.");
		else
		    SendClientMessage(playerid,0xC0E0FFFF,"Your report has been send to administrator");
		return 1;
	}
	return 0;
}
//-----/ DialogHandler_Admin /--------------------------------------------------
public DialogHandler_Admin(playerid,dialogid,response,listitem,inputtext[])
{
	return 0;
}

//==========/ Functions /=======================================================

//==========/ Admin Functions /=================================================
//-----/ IsPlayerAdminEx /------------------------------------------------------
stock IsPlayerAdminEx(playerid,level=1)
{
	if(GetPVarInt(playerid,"Admin") >= level)
		return 1;
	return 0;
}
