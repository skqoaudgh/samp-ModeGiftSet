/*
  [Functions]
	ShowPlayerLoginDialog(playerid,bool:failed=false)
	ShowPlayerChangePasswordDialog(playerid)
    ShowPlayerStatus(playerid,destid=-1)
    
	CheckPlayerAccount(playerid)
	LoginPlayer(playerid,password[])
	RegisterPlayer(playerid,password[])
	LoadPlayerData(playerid)
	SavePlayerData(playerid)
	IsPlayerLoggedIn(playerid)
	IsPlayerRegistered(playerid)
	ChangePlayerPassword(playerid,password[])
	
	IsPlayerSelectLanguage(playerid)
	ShowPlayerChangeLanguageDialog(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Userdata
	#endinput
#endif
#define _MDPWN_Userdata



//-----/ Defines /
#define DialogID_Userdata(%1)			10100 + %1
#define AUTOSAVE_TIME					60


//-----/ News /
	//--/ Login /
new
	bool:P_Registered[MAX_PLAYERS],
	bool:P_LoggedIn[MAX_PLAYERS],
	P_LoginRetry[MAX_PLAYERS],
	P_IP[MAX_PLAYERS][16],
	bool:P_Selected[MAX_PLAYERS],
	Player_LastSaveTime[MAX_PLAYERS]
;


//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Userdata();
forward ConnectHandler_Userdata(playerid);
forward DisconnectHandler_Userdata(playerid,reason);
forward RequestSpawnHandler_Userdata(playerid);
forward TextHandler_Userdata(playerid,text);
forward CommandHandler_Userdata(playerid,cmdtext[]);
forward DialogHandler_Userdata(playerid,dialogid,response,listitem,inputtext[]);
forward TimerHandler_Userdata_1S_P(playerid);
forward RequestClassHandler_Userdata(playerid,classid);
	//--/ Functions /
forward CheckPlayerAccount(playerid);
forward CheckPlayerAccountQE(playerid);
forward LoginPlayerQE(playerid);
forward LoadPlayerDataQE(playerid);


//==========/ Callback Functions /==============================================
//-----/ AddHandler_Userdata /--------------------------------------------------
public AddHandler_Userdata()
{
	AddHandler("Userdata",ConnectHandler);
	AddHandler("Userdata",DisconnectHandler,1);
	AddHandler("Userdata",RequestSpawnHandler);
	AddHandler("Userdata",TextHandler,1);
	AddHandler("Userdata",CommandHandler,1);
	AddHandler("Userdata",DialogHandler);
	AddHandler("Userdata",RequestClassHandler);
	AddTimer("Userdata_1S",TIMER_1S_PLAYER);
}
//-----/ ConnectHandler_Userdata /----------------------------------------------
public ConnectHandler_Userdata(playerid)
{
	SetPlayerColor(playerid,COLOR_GREY);
	CheckPlayerAccount(playerid);
	strcpy(P_IP[playerid],GetPlayerIP(playerid));
}
//-----/ DisconnectHandler_Userdata /-------------------------------------------
public DisconnectHandler_Userdata(playerid,reason)
{
	SavePlayerData(playerid);
	//-----
	P_Registered[playerid] = false;
	P_LoggedIn[playerid] = false;
	P_LoginRetry[playerid] = 0;
	P_Selected[playerid] = false;
	Player_LastSaveTime[playerid] = 0;
}
//-----/ RequestSpawnHandler_Userdata /-----------------------------------------
public RequestSpawnHandler_Userdata(playerid)
{
	if(!IsPlayerLoggedIn(playerid))
	{
		ShowPlayerLoginDialog(playerid);
		return 0;
	}
	return 1;
}
//-----/ RequestClassHandler_Userdata(playerid,classid) /-----------------------------------------
public RequestClassHandler_Userdata(playerid,classid)
{
	if(!IsPlayerLoggedIn(playerid))
	{
		SetPlayerPos(playerid,1479.6353,-1597.1534,9.3828);
		SetPlayerCameraPos(playerid,1479.4426,-1587.1444,33.5469);
		SetPlayerCameraLookAt(playerid,1479.5486,-1619.1360,14.1123);
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerWeather(playerid, 0);
		SetPlayerTime(playerid,0,0);
		Streamer_UpdateEx(playerid, 1479.6353,-1597.1534,9.3828);
		Streamer_UpdateEx(playerid, 1479.6353,-1597.1534,9.3828);
		FreezePlayer(playerid);
  	}
}
//-----/ TextHandler_Userdata /-------------------------------------------------
public TextHandler_Userdata(playerid,text)
{
	if(!IsPlayerLoggedIn(playerid))
		return 0;
	return 1;
}
//-----/ CommandHandler_Userdata /----------------------------------------------
public CommandHandler_Userdata(playerid,cmdtext[])
{
	if(!IsPlayerLoggedIn(playerid))
		return 1;

	if(!strcmp("/����",cmdtext) || !strcmp("/sav",cmdtext,true))
	{
		SavePlayerData(playerid);
		if(GetPlayerLanguage(playerid) == 0)
			SendClientMessage(playerid,COLOR_WHITE,"[!] �����Ͱ� ����Ǿ����ϴ�.");
		else
		    SendClientMessage(playerid,COLOR_WHITE,"[!] The data has been saved.");
		return 1;
	}

	if(!strcmp("/�������",cmdtext) || !strcmp("/��ȣ����",cmdtext) || !strcmp("/changepassword",cmdtext) || !strcmp("/cp",cmdtext))
	{
		ShowPlayerChangePasswordDialog(playerid);
		return 1;
	}
	
	if(!strcmp("/language",cmdtext) || !strcmp("/lan",cmdtext) || !strcmp("/���",cmdtext) || !strcmp("/����",cmdtext))
	{
		ShowPlayerChangeLanguageDialog(playerid);
		return 1;
	}

	if(!strcmp("/stat",cmdtext) || !strcmp("/stats",cmdtext) || !strcmp("/����",cmdtext) || !strcmp("/������",cmdtext))
	{
		ShowPlayerStatus(playerid,playerid);
		return 1;
	}
	return 0;
}
//-----/ DialogHandler_Userdata /-----------------------------------------------
public DialogHandler_Userdata(playerid,dialogid,response,listitem,inputtext[])
{
	switch(dialogid)
	{
		case DialogID_Userdata(0): // ��й�ȣ �Է�
		{
			if(response)
			{
				if(strlen(inputtext) >= 4 && strlen(inputtext) <= 32) // ��й�ȣ 4~32����
				{
					if(IsPlayerRegistered(playerid))
						LoginPlayer(playerid,inputtext);
					else
						RegisterPlayer(playerid,inputtext);
				} else ShowPlayerLoginDialog(playerid);
			} else ShowPlayerLoginDialog(playerid);
		}
		case DialogID_Userdata(1): // ��й�ȣ ����
		{
			if(response)
			{
				if(strlen(inputtext) >= 4 && strlen(inputtext) <= 32)
				{
					ChangePlayerPassword(playerid,inputtext);
					if(GetPlayerLanguage(playerid) == 0)
						SendClientMessage(playerid,COLOR_WHITE,"[!] ��ȣ�� ����Ǿ����ϴ�.");
					else
					    SendClientMessage(playerid,COLOR_WHITE,"[!] The password has been changed.");
				} else ShowPlayerChangePasswordDialog(playerid);
			}
		}
		case DialogID_Userdata(2):
		{
			if(response)
			{
				SetPVarInt(playerid,"Language",listitem);
				P_Selected[playerid] = true;
				if(IsPlayerLoggedIn(playerid))
					ShowPlayerChangeLanguageDialog(playerid);
			}
			if(!IsPlayerLoggedIn(playerid))
				ShowPlayerLoginDialog(playerid);
		}
	}
	return 0;
}
//-----/ TimerHandler_Userdata_1S_P /-------------------------------------------
public TimerHandler_Userdata_1S_P(playerid)
{
	if(IsPlayerLoggedIn(playerid))
	{
		if(GetPlayerMoney_o(playerid) != GetPlayerMoney(playerid))
			SetPlayerMoney(playerid,GetPlayerMoney(playerid));
		if(Player_LastSaveTime[playerid] && GetTickCount() - Player_LastSaveTime[playerid] > AUTOSAVE_TIME * 1000)
			SavePlayerData(playerid);
		if(GetPlayerScore(playerid) != GetPVarInt(playerid,"Level"))
		    SetPlayerScore(playerid, GetPVarInt(playerid,"Level"));
	}
	return 1;
}
//==========/ GUI Login Functions /=============================================
//-----/ ShowPlayerLoginDialog /------------------------------------------------
stock ShowPlayerLoginDialog(playerid,bool:failed=false)
{
	new string[350],button[10];
	new len = GetPlayerLanguage(playerid);
	if(len == 0)
		strcat(string,"{FF5A00}ALL IN ONE ����{FFFFFF}�� ���� �� ȯ���մϴ�!\n");
	else
	    strcat(string,"{FFFFFF}Welcome to the {FF5A00}ALL IN ONE Server!\n");
	strcat(string,"\n");
	if(IsPlayerRegistered(playerid))
	{
		button = "�α���";
		if(failed)
		{
            if(len == 0)
                strcat(string,"{FF69B4}��й�ȣ�� Ʋ���̾��. �ٽ� �õ��غ�����!\n");
			else
			    strcat(string,"{FF69B4}You entered wrong password. Try again!\n");
		}
		else
		{
		    if(len == 0)
		    	strcat(string,"{FF69B4}�̹� ��ϵǾ� �ִ� �г����̱���!\n");
			else
			    strcat(string,"{FF69B4}This account is already registered!\n");
		}
		strcat(string,"\n");
		if(len == 0)
			strcat(string,"{FFFFFF}�� �г��ӿ� �α��� �Ͻ÷���\n");
		else
            strcat(string,"{FFFFFF}To login this account,\n");
	}
	else
	{
	    if(IsPlayerSelectLanguage(playerid))
	    {
	        if(len == 0)
	        {
	            button = "���� ���";
				strcat(string,"{FF69B4}��, �̷�! ��Ÿ���Ե� ������ �����ñ���!\n");
				strcat(string,"\n");
				strcat(string,"{FFFFFF}�� �г������� �����Ͻ÷���\n");
			}
			else
			{
			    button = "Regist";
				strcat(string,"{FF69B4}Oooh! Unfortunately, This account is not registered!\n");
				strcat(string,"\n");
				strcat(string,"{FFFFFF}To regist this account,\n");
			}
	    }
	    else
	    {
	        ShowPlayerChangeLanguageDialog(playerid);
	        return;
	    }
	}
	if(len == 0)
	{
		strcat(string,"�Ʒ� �Է�ĭ�� ��й�ȣ�� �Է��ϼ���!\n");
		strcat(string,"\n");
		strcat(string,"{F0E68C}�Է��Ͻ� ������ ��й�ȣ��\n");
		strcat(string,"{FFFF00}SHA-1 160bit �˰���{F0E68C}���� ��ȣȭ�ǹǷ�\n");
		strcat(string,"���� �����ڵ� �� �� ������ �Ƚ��ϼ���!");
	}
	else
	{
		strcat(string,"Enter your password in the input box below!\n");
		strcat(string,"\n");
		strcat(string,"{F0E68C}The password that you entered\n");
		strcat(string,"{F0E68C}is encrypted{FFFF00}for SHA-1 160bit algorithm\n");
		strcat(string,"Server administrator never see your password. Feel safe!");
	}
	ShowPlayerDialog(playerid,DialogID_Userdata(0),DIALOG_STYLE_PASSWORD,"Login System",string,button,"");
}
//-----/ ShowPlayerChangePasswordDialog /---------------------------------------
stock ShowPlayerChangePasswordDialog(playerid)
{
	new string[256];
	if(GetPlayerLanguage(playerid) == 0)
	{
		strcat(string,"{FF69B4}��й�ȣ�� �����Ͻ÷�����?\n");
		strcat(string,"\n");
		strcat(string,"{FFFFFF}�� ������ ��й�ȣ�� �����Ͻ÷���\n");
		strcat(string,"�Ʒ� �Է�ĭ�� �����Ͻ� ��й�ȣ�� �Է��ϼ���!\n");
		strcat(string,"\n");
		strcat(string,"{F0E68C}�Է��Ͻ� ������ ��й�ȣ��\n");
		strcat(string,"{FFFF00}SHA-1 160bit �˰���{F0E68C}���� ��ȣȭ�ǹǷ�\n");
		strcat(string,"�����ڵ� �� �� ������ �Ƚ��ϼ���!");
	}
	else
	{
		strcat(string,"{FF69B4}Do you want to change password?\n");
		strcat(string,"\n");
		strcat(string,"{FFFFFF}To change your password of this account,\n");
		strcat(string,"Enter your new password in the input box below!\n");
		strcat(string,"\n");
		strcat(string,"{F0E68C}The password that you entered\n");
		strcat(string,"{F0E68C}is encrypted{FFFF00}for SHA-1 160bit algorithm\n");
		strcat(string,"Server administrator never see your password. Feel safe!");
	}
	ShowPlayerDialog(playerid,DialogID_Userdata(1),DIALOG_STYLE_PASSWORD,"Login System",string,"����","���");
}
//-----/ ShowPlayerStatus /-----------------------------------------------------
stock ShowPlayerStatus(playerid,destid=-1)
{
	new
		string[128],
		status[2560],
		k,d,w,l,
		Float:ratio_kd, Float:ratio_wl
	;
	//-----
	if(destid == -1)
		destid = playerid;
    //-----
	k = GetPVarInt(destid,"Kills"), d = GetPVarInt(destid,"Deaths");
	if(d == 0) ratio_kd = 0.0;
	else ratio_kd = k/d;
	//-----
	w = GetPVarInt(destid,"Wins"), l = GetPVarInt(destid,"Loses");
	new temp = w+l;
	if(temp == 0) ratio_wl = 0;
	else ratio_wl = w/(temp);
	//-----
	format(status,sizeof(status),"%s\n"C_WHITE"��:\t\t"C_GREY"[ $%d ]",status,GetPlayerMoney(destid));
	format(status,sizeof(status),"%s\n"C_WHITE"",status);
	format(status,sizeof(status),"%s\n"C_WHITE"����:\t\t"C_GREY"[ %d ]",status,GetPVarInt(destid,"Level"));
	format(status,sizeof(status),"%s\n"C_WHITE"����Ʈ:\t\t"C_GREY"[ %d/%d ]",status,GetPVarInt(destid,"Point"),(GetPVarInt(destid,"Level")+1)*10);
	format(status,sizeof(status),"%s\n"C_WHITE"",status);
	format(status,sizeof(status),"%s\n"C_WHITE"�·�:\t\t"C_GREY"[ %d / %d (%.0f%%) ]",status,GetPVarInt(destid,"Wins"),GetPVarInt(destid,"Losse"),ratio_wl);
	format(status,sizeof(status),"%s\n"C_WHITE"K/D:\t\t"C_GREY"[ %d / %d (%.2f:1) ]",status,GetPVarInt(destid,"Kills"),GetPVarInt(destid,"Deaths"),ratio_kd);
	//-----
	format(string,sizeof(string),"Status of %s(%d)",GetPlayerNameEx(destid),destid);

	if(GetPlayerLanguage(playerid) == 0)
		ShowPlayerDialog(playerid,DialogID_Userdata(3),DIALOG_STYLE_MSGBOX,string,status,"Ȯ��","");
	else
	    ShowPlayerDialog(playerid,DialogID_Userdata(3),DIALOG_STYLE_MSGBOX,string,status,"Close","");
}
//-----/ ShowPlayerChangeLanguageDialog /---------------------------------------
stock ShowPlayerChangeLanguageDialog(playerid)
{
	new lan = GetPVarInt(playerid,"Language");
	new string[256];
	if(lan == 0) // �ѱ��� ��� ��
	{
	    strcat(string,""C_PASTEL_YELLOW"�ѱ��� (Selected)\n");
	    strcat(string,"English");
	}
	else // ���� ��� ��
	{
	    strcat(string,"�ѱ���\n");
	    strcat(string,""C_PASTEL_YELLOW"English (Selected)");
	}
 	ShowPlayerDialog(playerid,DialogID_Userdata(2),DIALOG_STYLE_LIST,"Language Setting",string,"����","���");
}

//==========/ Account Functions /===============================================
//-----/ CheckPlayerAccount /---------------------------------------------------
public CheckPlayerAccount(playerid) // ������ ������ �����ϴ� �� Ȯ��. �������ڸ��� ȣ��
{
	new string[65];
	format(string,sizeof(string),"SELECT ID FROM user_data WHERE Username = '%s'",GetPlayerNameEx(playerid));
	mysql_tquery(GetMySQLHandle(),string,"CheckPlayerAccountQE","i",playerid);
}
//-----/ CheckPlayerAccountQE /-------------------------------------------------
public CheckPlayerAccountQE(playerid)
{
	new value;
	if(cache_num_rows() > 1)
	{
	    if(GetPlayerLanguage(playerid) == 0)
			SendClientMessage(playerid,COLOR_WHITE,"[!] �����ͺ��̽��� �ߺ� ������ �߻��Ͽ� �� �г����� ����� �� �����ϴ�. ������ ���� �ٶ��ϴ�.");
		else
		    SendClientMessage(playerid,COLOR_WHITE,"[!] This account can`t be used because a duplicate account has occurred in the database. Please contact the administrator.");
		Kick(playerid);
	} else {
		if(cache_num_rows() == 1) // ���� ����
		{
			cache_get_value_name_int(0,"ID",value);
			SetPVarInt(playerid,"ID",value);
			P_Registered[playerid] = true;
		}
		//-----
		ShowPlayerLoginDialog(playerid); // ��й�ȣ �Է� â ����
	}
}
//-----/ LoginPlayer /----------------------------------------------------------
stock LoginPlayer(playerid,password[])
{
	new string[129];
	format(string,sizeof(string),"SELECT 1 FROM user_data WHERE ID = %d AND Password = SHA1('%s')",GetPVarInt(playerid,"ID"),mysql_string_escape(password)); // Nickname�� �ƴ϶� ID ������� ��ȸ�� (������, �ӵ� ����)
	mysql_tquery(GetMySQLHandle(),string,"LoginPlayerQE","i",playerid);
}
//-----/ LoginPlayerQE /--------------------------------------------------------
public LoginPlayerQE(playerid)
{
	if(cache_num_rows())
	{
		// Success
		LoadPlayerData(playerid);
	} else {
		// Failed
		if(++P_LoginRetry[playerid] >= 3)
		{
			Kick(playerid);
		} else {
			ShowPlayerLoginDialog(playerid,true);
		}
	}
}
//-----/ RegisterPlayer /-------------------------------------------------------
stock RegisterPlayer(playerid,password[])
{
	new string[178];
	format(string,sizeof(string),"INSERT INTO user_data (Username,Password,IP) VALUES('%s',SHA1('%s'),INET_ATON('%s'))",GetPlayerNameEx(playerid),mysql_string_escape(password),P_IP[playerid]);
	mysql_tquery(GetMySQLHandle(),string,"CheckPlayerAccount","i",playerid);
}
//-----/ LoadPlayerData /-------------------------------------------------------
stock LoadPlayerData(playerid) // �����ͺ��̽� �������� ���� �����͸� ��������. �α��� �Ϸ� �� ȣ��
{
	new string[41];
	format(string,sizeof(string),"SELECT * FROM user_data WHERE ID = %d",GetPVarInt(playerid,"ID"));
	mysql_tquery(GetMySQLHandle(),string,"LoadPlayerDataQE","i",playerid);
}
//-----/ LoadPlayerDataQE /-----------------------------------------------------
public LoadPlayerDataQE(playerid)
{
	new
		//string[256],
		value_int
		//Float:value_float
	;
	if(cache_num_rows())
	{
	    cache_get_value_name_int(0,"Skin",value_int); SetPVarInt(playerid,"Skin",value_int);
	    cache_get_value_name_int(0,"Money",value_int); SetPVarInt(playerid,"Money",value_int);
        cache_get_value_name_int(0,"Point",value_int); SetPVarInt(playerid,"Point",value_int);
	    cache_get_value_name_int(0,"Level",value_int); SetPVarInt(playerid,"Level",value_int);
        cache_get_value_name_int(0,"Kills",value_int); SetPVarInt(playerid,"Kills",value_int);
	    cache_get_value_name_int(0,"Deaths",value_int); SetPVarInt(playerid,"Deaths",value_int);
        cache_get_value_name_int(0,"Wins",value_int); SetPVarInt(playerid,"Wins",value_int);
	    cache_get_value_name_int(0,"Loses",value_int); SetPVarInt(playerid,"Loses",value_int);
	    cache_get_value_name_int(0,"ToggleGlobal",value_int); SetPVarInt(playerid,"ToggleGlobal",value_int);
        cache_get_value_name_int(0,"TogglePM",value_int); SetPVarInt(playerid,"TogglePM",value_int);
        cache_get_value_name_int(0,"ToggleBGM",value_int); SetPVarInt(playerid,"ToggleBGM",value_int);
		//cache_get_value_name(0,"Value_S",string); SetPVarString(playerid,"Value_S",string);
		//cache_get_value_name_int(0,"Value_I",value_int); SetPVarInt(playerid,"Value_I",value_int);
		//cache_get_value_name_float(0,"Value_F",value_float); SetPVarFloat(playerid,"Value_F",value_float);

		//-----
		SetPlayerMoney(playerid,GetPVarInt(playerid,"Money"));
		SetPlayerScore(playerid,GetPVarInt(playerid,"Point"));
		//-----
		P_LoggedIn[playerid] = true;
		SpawnPlayerEx(playerid);
		Player_LastSaveTime[playerid] = GetTickCount();
	}
}
//-----/ SavePlayerData /-------------------------------------------------------
stock SavePlayerData(playerid)
{
	new string[2000];
	if(IsPlayerLoggedIn(playerid))
	{
		format(string,sizeof(string),"UPDATE user_data SET");
		format(string,sizeof(string),"%s IP=INET_ATON('%s')",string,P_IP[playerid]);
		//-----
        format(string,sizeof(string),"%s,Skin=%d",string,GetPVarInt(playerid,"Skin"));
		format(string,sizeof(string),"%s,Money=%d",string,GetPVarInt(playerid,"Money"));
        format(string,sizeof(string),"%s,Point=%d",string,GetPVarInt(playerid,"Point"));
        format(string,sizeof(string),"%s,Level=%d",string,GetPVarInt(playerid,"Level"));
        format(string,sizeof(string),"%s,Kills=%d",string,GetPVarInt(playerid,"Kills"));
        format(string,sizeof(string),"%s,Deaths=%d",string,GetPVarInt(playerid,"Deaths"));
        format(string,sizeof(string),"%s,Wins=%d",string,GetPVarInt(playerid,"Wins"));
        format(string,sizeof(string),"%s,Loses=%d",string,GetPVarInt(playerid,"Loses"));
		format(string,sizeof(string),"%s,ToggleGlobal=%d",string,GetPVarInt(playerid,"ToggleGlobal"));
        format(string,sizeof(string),"%s,TogglePM=%d",string,GetPVarInt(playerid,"TogglePM"));
        format(string,sizeof(string),"%s,ToggleBGM=%d",string,GetPVarInt(playerid,"ToggleBGM"));
		//format(string,sizeof(string),"%s,Value_S='%s'",string,GetPVarStringEx(playerid,"Value_S"));
		//format(string,sizeof(string),"%s,Value_I=%d",string,GetPVarInt(playerid,"Value_I"));
		//format(string,sizeof(string),"%s,Value_F=%.1f",string,GetPVarFloat(playerid,"Value_F"));

		//-----
		format(string,sizeof(string),"%s,LastUpdate=NOW()",string);
		format(string,sizeof(string),"%s WHERE ID = %d",string,GetPVarInt(playerid,"ID"));
		mysql_pquery(GetMySQLHandle(),string);
		
		Player_LastSaveTime[playerid] = GetTickCount();
	}
}
//-----/ IsPlayerLoggedIn /-----------------------------------------------------
stock IsPlayerLoggedIn(playerid)
{
	return P_LoggedIn[playerid];
}
//-----/ IsPlayerRegistered /---------------------------------------------------
stock IsPlayerRegistered(playerid)
{
	return P_Registered[playerid];
}
//-----/ IsPlayerSelectLanguage /-----------------------------------------------
stock IsPlayerSelectLanguage(playerid)
{
	return P_Selected[playerid];
}
//-----/ ChangePlayerPassword /-------------------------------------------------
stock ChangePlayerPassword(playerid,password[])
{
	new string[145];
	format(string,sizeof(string),"UPDATE user_data SET Password = SHA1('%s') WHERE Username = '%s'",mysql_string_escape(password),GetPlayerNameEx(playerid));
	mysql_pquery(GetMySQLHandle(),string);
}
//==========/ Spawn Functions /=================================================
//-----/ SpawnPlayerEx /--------------------------------------------------------
stock SpawnPlayerEx(playerid)
{
	SetPlayerColor(playerid,COLOR_WHITE);
	SetSpawnInfo(playerid, 0,0, 1479.5483,-1600.0005,13.5469,0.0, 0,0,0,0,0,0);
	SpawnPlayer(playerid);
	//-----
	SetPlayerPos(playerid, 1479.5483,-1600.0005,13.5469);
	SetPlayerFacingAngle(playerid, 180.2658);
	SetPlayerSkin(playerid, 0);
	
	SetPlayerHealth(playerid, 100);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);

	SetPVarInt(playerid,"MapNumber",0);
	SetPlayerMarkerForPlayerEx(playerid, GetPlayerColor(playerid));
}
