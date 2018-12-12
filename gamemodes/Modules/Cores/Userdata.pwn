/*
 *
 *		[For a better future, Enthusiasm of Acu]
 *
 *			Userdata
 *			v1.0.0
 *
 *
 *		First Release:		2018/12/07
 *		Last Update:		2018/12/07
 *
 *
 *
 *		Coded by Acu 2006-2017 @ all rights reserved.
 *      Updated by Cada
 *			acu.pe.kr@gmail.com
 *			http://acu.pe.kr
 *
 *
 */
/*
  [Functions]
	ShowPlayerLoginDialog(playerid,bool:failed=false)
	ShowPlayerChangePasswordDialog(playerid)
    
	CheckPlayerAccount(playerid)
	LoginPlayer(playerid,password[])
	RegisterPlayer(playerid,password[])
	LoadPlayerData(playerid)
	SavePlayerData(playerid)
	IsPlayerLoggedIn(playerid)
	IsPlayerRegistered(playerid)
	ChangePlayerPassword(playerid,password[])
	
	IsPlayerSelectLanguage(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Userdata
	#endinput
#endif
#define _MDPWN_Userdata



//-----/ Defines /
#define DialogID_Userdata(%1)			10100 + %1



//-----/ News /
	//--/ Login /
new
	bool:P_Registered[MAX_PLAYERS],
	bool:P_LoggedIn[MAX_PLAYERS],
	P_LoginRetry[MAX_PLAYERS],
	P_IP[MAX_PLAYERS][16],
	bool:P_Selected[MAX_PLAYERS]
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

	if(!strcmp("/저장",cmdtext) || !strcmp("/sav",cmdtext,true))
	{
		SavePlayerData(playerid);
		if(GetPlayerLanguage(playerid) == 0)
			SendClientMessage(playerid,COLOR_WHITE,"[!] 데이터가 저장되었습니다.");
		else
		    SendClientMessage(playerid,COLOR_WHITE,"[!] The data has been saved.");
		return 1;
	}

	if(!strcmp("/비번변경",cmdtext) || !strcmp("/암호변경",cmdtext) || !strcmp("/changepassword",cmdtext) || !strcmp("/cp",cmdtext))
	{
		ShowPlayerChangePasswordDialog(playerid);
		return 1;
	}
	
	if(!strcmp("/language",cmdtext) || !strcmp("/lan",cmdtext) || !strcmp("/언어",cmdtext) || !strcmp("/언어변경",cmdtext))
	{
		ShowPlayerChangeLanguageDialog(playerid);
		return 1;
	}
	
	return 0;
}
//-----/ DialogHandler_Userdata /-----------------------------------------------
public DialogHandler_Userdata(playerid,dialogid,response,listitem,inputtext[])
{
	switch(dialogid)
	{
		case DialogID_Userdata(0): // 비밀번호 입력
		{
			if(response)
			{
				if(strlen(inputtext) >= 4 && strlen(inputtext) <= 32) // 비밀번호 4~32글자
				{
					if(IsPlayerRegistered(playerid))
						LoginPlayer(playerid,inputtext);
					else
						RegisterPlayer(playerid,inputtext);
				} else ShowPlayerLoginDialog(playerid);
			} else ShowPlayerLoginDialog(playerid);
		}
		case DialogID_Userdata(1): // 비밀번호 변경
		{
			if(response)
			{
				if(strlen(inputtext) >= 4 && strlen(inputtext) <= 32)
				{
					ChangePlayerPassword(playerid,inputtext);
					if(GetPlayerLanguage(playerid) == 0)
						SendClientMessage(playerid,COLOR_WHITE,"[!] 암호가 변경되었습니다.");
					else
					    SendClientMessage(playerid,COLOR_WHITE,"[!] The password has been changed.");
				} else ShowPlayerChangePasswordDialog(playerid);
			}
		}
	}
	return 0;
}


//==========/ GUI Login Functions /=============================================
//-----/ ShowPlayerLoginDialog /------------------------------------------------
stock ShowPlayerLoginDialog(playerid,bool:failed=false)
{
	new string[512],button[10];
	new len = GetPlayerLanguage(playerid);
	if(len == 0)
		strcat(string,"{FF5A00}ALL IN ONE 서버{FFFFFF}에 오신 걸 환영합니다!\n");
	else
	    strcat(string,"{FFFFFF}Welcome to the {FF5A00}ALL IN ONE Server!\n");
	strcat(string,"\n");
	if(IsPlayerRegistered(playerid))
	{
		button = "로그인";
		if(failed)
		{
            if(len == 0)
                strcat(string,"{FF69B4}비밀번호를 틀리셨어요. 다시 시도해보세요!\n");
			else
			    strcat(string,"{FF69B4}You entered wrong password. Try again!\n");
		}
		else
		{
		    if(len == 0)
		    	strcat(string,"{FF69B4}이미 등록되어 있는 닉네임이군요!\n");
			else
			    strcat(string,"{FF69B4}This account is already registered!\n");
		}
		strcat(string,"\n");
		if(len == 0)
			strcat(string,"{FFFFFF}이 닉네임에 로그인 하시려면\n");
		else
            strcat(string,"{FFFFFF}To login this account,\n");
	}
	else
	{
	    if(IsPlayerSelectLanguage(playerid))
	    {
	        if(len == 0)
	        {
	            button = "계정 등록";
				strcat(string,"{FF69B4}오, 이런! 안타깝게도 계정이 없으시군요!\n");
				strcat(string,"\n");
				strcat(string,"{FFFFFF}이 닉네임으로 가입하시려면\n");
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
		strcat(string,"아래 입력칸에 비밀번호를 입력하세요!\n");
		strcat(string,"\n");
		strcat(string,"{F0E68C}입력하신 소중한 비밀번호는\n");
		strcat(string,"{FFFF00}SHA-1 160bit 알고리즘{F0E68C}으로 암호화되므로\n");
		strcat(string,"서버 관리자도 알 수 없으니 안심하세요!");
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
		strcat(string,"{FF69B4}비밀번호를 변경하시려구요?\n");
		strcat(string,"\n");
		strcat(string,"{FFFFFF}이 계정의 비밀번호를 변경하시려면\n");
		strcat(string,"아래 입력칸에 변경하실 비밀번호를 입력하세요!\n");
		strcat(string,"\n");
		strcat(string,"{F0E68C}입력하신 소중한 비밀번호는\n");
		strcat(string,"{FFFF00}SHA-1 160bit 알고리즘{F0E68C}으로 암호화되므로\n");
		strcat(string,"관리자도 알 수 없으니 안심하세요!");
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
	ShowPlayerDialog(playerid,DialogID_Userdata(1),DIALOG_STYLE_PASSWORD,"Login System",string,"변경","취소");
}

//==========/ Account Functions /===============================================
//-----/ CheckPlayerAccount /---------------------------------------------------
public CheckPlayerAccount(playerid) // 서버에 계정이 존재하는 지 확인. 접속하자마자 호출
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
			SendClientMessage(playerid,COLOR_WHITE,"[!] 데이터베이스에 중복 계정이 발생하여 이 닉네임을 사용할 수 없습니다. 관리자 문의 바랍니다.");
		else
		    SendClientMessage(playerid,COLOR_WHITE,"[!] This account can`t be used because a duplicate account has occurred in the database. Please contact the administrator.");
		Kick(playerid);
	} else {
		if(cache_num_rows() == 1) // 계정 존재
		{
			cache_get_value_name_int(0,"ID",value);
			SetPVarInt(playerid,"ID",value);
			P_Registered[playerid] = true;
		}
		//-----
		ShowPlayerLoginDialog(playerid); // 비밀번호 입력 창 띄우기
	}
}
//-----/ LoginPlayer /----------------------------------------------------------
stock LoginPlayer(playerid,password[])
{
	new string[129];
	format(string,sizeof(string),"SELECT 1 FROM user_data WHERE ID = %d AND Password = SHA1('%s')",GetPVarInt(playerid,"ID"),mysql_string_escape(password)); // Nickname이 아니라 ID 기반으로 조회함 (안정성, 속도 문제)
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
stock LoadPlayerData(playerid) // 데이터베이스 서버에서 유저 데이터를 가져오기. 로그인 완료 후 호출
{
	new string[41];
	format(string,sizeof(string),"SELECT * FROM user_data WHERE ID = %d",GetPVarInt(playerid,"ID"));
	mysql_tquery(GetMySQLHandle(),string,"LoadPlayerDataQE","i",playerid);
}
//-----/ LoadPlayerDataQE /-----------------------------------------------------
public LoadPlayerDataQE(playerid)
{
	new
		string[256],
		value_int,Float:value_float
	;
	if(cache_num_rows())
	{
	    cache_get_value_name_int(0,"Money",value_int); SetPVarInt(playerid,"Money",value_int);
        cache_get_value_name_int(0,"Point",value_int); SetPVarInt(playerid,"Point",value_int);
	    cache_get_value_name_int(0,"ToggleGlobal",value_int); SetPVarInt(playerid,"ToggleGlobal",value_int);
        cache_get_value_name_int(0,"TogglePM",value_int); SetPVarInt(playerid,"TogglePM",value_int);
		//cache_get_value_name(0,"Value_S",string); SetPVarString(playerid,"Value_S",string);
		//cache_get_value_name_int(0,"Value_I",value_int); SetPVarInt(playerid,"Value_I",value_int);
		//cache_get_value_name_float(0,"Value_F",value_float); SetPVarFloat(playerid,"Value_F",value_float);

		//-----
		SetPlayerMoney(playerid,GetPVarInt(playerid,"Money"));
		SetPlayerScore(playerid,GetPVarInt(playerid,"Point"));
		//-----
		P_LoggedIn[playerid] = true;
		SpawnPlayerEx(playerid);
	}
}
//-----/ SavePlayerData /-------------------------------------------------------
stock SavePlayerData(playerid)
{
	new string[1000];
	if(IsPlayerLoggedIn(playerid))
	{
		format(string,sizeof(string),"UPDATE user_data SET");
		format(string,sizeof(string),"%s IP=INET_ATON('%s')",string,P_IP[playerid]);
		//-----
		format(string,sizeof(string),"%s,Money=%d",string,GetPVarInt(playerid,"Money"));
        format(string,sizeof(string),"%s,Point=%d",string,GetPVarInt(playerid,"Point"));
		format(string,sizeof(string),"%s,ToggleGlobal=%d",string,GetPVarInt(playerid,"ToggleGlobal"));
        format(string,sizeof(string),"%s,TogglePM=%d",string,GetPVarInt(playerid,"TogglePM"));
		//format(string,sizeof(string),"%s,Value_S='%s'",string,GetPVarStringEx(playerid,"Value_S"));
		//format(string,sizeof(string),"%s,Value_I=%d",string,GetPVarInt(playerid,"Value_I"));
		//format(string,sizeof(string),"%s,Value_F=%.1f",string,GetPVarFloat(playerid,"Value_F"));

		//-----
		format(string,sizeof(string),"%s,LastUpdate=NOW()",string);
		format(string,sizeof(string),"%s WHERE ID = %d",string,GetPVarInt(playerid,"ID"));
		mysql_pquery(GetMySQLHandle(),string);
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
}
