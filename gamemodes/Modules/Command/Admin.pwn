/*
  [Functions]
	StartPlayerSpectate(playerid,destid)
	FinishPlayerSpectate(playerid)
	RefreshSpectate(playerid)
	RefreshSpectateAction(playerid)
	IsPlayerSpectating(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Admin
	#endinput
#endif
#define _MDPWN_Admin


//-----/ Defines /
//#define Dialog_Admin(%1)			10400 + %1
#define KEY_PRESSED(%0)			( !(oldkeys & (%0)) && (newkeys & (%0)) )


//-----/ News /
	//--/ Spectate /
enum eSpectateInfo
{
	bool:siToggle,
	siDestID,
	//-----
	siSkin,
	Float:siPos[4],
	siInterior,
	siVirtual,
	//-----
	siDestVehicle,
	siDestInterior,
	siDestVirtual
}
new SpectateInfo[MAX_PLAYERS][eSpectateInfo];
	//--/ InfoText /
new
	PlayerText:Player_Text_Info[MAX_PLAYERS],
	bool:Player_InfoText_Hide[MAX_PLAYERS],
	Player_InfoText_String[MAX_PLAYERS][128]
;


//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Admin();
forward CommandHandler_Admin(playerid,cmdtext[]);
forward DialogHandler_Admin(playerid,dialogid,response,listitem,inputtext[]);
forward ConnectHandler_Admin(playerid);
forward DisconnectHandler_Admin(playerid,reason);
forward KeyHandler_Admin(playerid,newkeys,oldkeys);
	//--/ Functions /
forward RefreshSpectateAction(playerid);
forward DelayedKick(playerid);
forward DelayedBan(playerid);



//==========/ Callback Functions /==============================================
//-----/ AddHandler_Admin /-----------------------------------------------------
public AddHandler_Admin()
{
	AddHandler("Admin",CommandHandler);
	AddHandler("Admin",DialogHandler);
	AddHandler("Admin",ConnectHandler);
	AddHandler("Admin",DisconnectHandler);
	AddHandler("Admin",KeyHandler);
	//AddHandler("WTF",InitHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}
//-----/ ConnectHandler_Admin /-------------------------------------------------
public ConnectHandler_Admin(playerid)
{
	Player_Text_Info[playerid] = CreatePlayerTextDraw(playerid, 150.000000, 390.000000, "LOADING");
	PlayerTextDrawBackgroundColor(playerid, Player_Text_Info[playerid], 255);
	PlayerTextDrawFont(playerid, Player_Text_Info[playerid], 2);
	PlayerTextDrawLetterSize(playerid, Player_Text_Info[playerid], 0.350000, 1.300000);
	PlayerTextDrawColor(playerid, Player_Text_Info[playerid], -1);
	PlayerTextDrawSetOutline(playerid, Player_Text_Info[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Player_Text_Info[playerid], 1);
	PlayerTextDrawSetShadow(playerid, Player_Text_Info[playerid], 1);
}
//-----/ DisconnectHandler_Admin /----------------------------------------------
public DisconnectHandler_Admin(playerid,reason)
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(IsPlayerSpectating(pid) && SpectateInfo[pid][siDestID] == playerid)
			FinishPlayerSpectate(pid);
	}
	new dummy1[eSpectateInfo];
	SpectateInfo[playerid] = dummy1;
	Player_InfoText_Hide[playerid] = false;
}
//-----/ CommandHandler_Admin /-------------------------------------------------
public CommandHandler_Admin(playerid,cmdtext[])
{
	new
		cmd[384],idx,
		string[384]
	;
	cmd = strtok(cmdtext,idx);
	//-----/ Admin Commands /---------------------------------------------------
	if(!strcmp("/kick",cmd) || !strcmp("/킥",cmd) || !strcmp("/강퇴",cmd) || !strcmp("/추방",cmd))
	{
	    if(!IsPlayerAdminEx(playerid))
	    {
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 이 관리자 명령어를 사용할 권한이 없습니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You do not have permission to use this administrator command.");
		}
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /강퇴 [번호] [이유]");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /kick [playerid] [reason]");
		}
		new destid = strval(cmd);
		if(destid == INVALID_PLAYER_ID)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 잘못된 유저 정보입니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
		}
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /강퇴 [번호] [이유]");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /kick [playerid] [reason]");
		}
		//-----
		strcpy(cmd,stringslice_c(cmdtext,2));
		KickPlayer(destid, cmd, GetPlayerNameEx(playerid));
		return 1;
	}
	
	if(!strcmp("/ban",cmd) || !strcmp("/밴",cmd) || !strcmp("/영밴",cmd) || !strcmp("/영구밴",cmd) || !strcmp("/영구강퇴",cmd) || !strcmp("/영구추방",cmd))
	{
	    if(!IsPlayerAdminEx(playerid))
	    {
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 이 관리자 명령어를 사용할 권한이 없습니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You do not have permission to use this administrator command.");
		}
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /영구강퇴 [번호] [이유]");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /ban [playerid] [reason]");
		}
		new destid = strval(cmd);
		if(destid == INVALID_PLAYER_ID)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 잘못된 유저 정보입니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
		}
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /영구강퇴 [번호] [이유]");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /ban [playerid] [reason]");
		}
		//-----
		strcpy(cmd,stringslice_c(cmdtext,2));
		BanPlayer(destid, cmd, GetPlayerNameEx(playerid));
		return 1;
	}

	if(!strcmp("/위성",cmd) || !strcmp("/감시",cmd) || !strcmp("/spec",cmd) || !strcmp("/spectate",cmd))
	{
	    if(!IsPlayerAdminEx(playerid))
	    {
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 이 관리자 명령어를 사용할 권한이 없습니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You do not have permission to use this administrator command.");
		}
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
			if(IsPlayerSpectating(playerid))
				FinishPlayerSpectate(playerid);
			else
			{
			    if(GetPlayerLanguage(playerid) == 0)
			        SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /위성 [번호]");
				else
				    SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /spectate [playerid]");
			}
		}
		else
		{
			new destid = strval(cmd);
			if(destid == INVALID_PLAYER_ID)
			{
			    if(GetPlayerLanguage(playerid) == 0)
			    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 잘못된 유저 정보입니다.");
				else
				    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
			}
			if(destid == playerid)
			{
			    if(GetPlayerLanguage(playerid) == 0)
			    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 자기 자신을 위성 감시할 수 없습니다.");
				else
				    return SendClientMessage(playerid,COLOR_WHITE,"[!] You can`t spectate yourself.");
			}
				
			if(!IsPlayerSpawnedEx(destid))
			{
			    if(GetPlayerLanguage(playerid) == 0)
			    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 아직 스폰하지 않은 유저입니다.");
				else
				    return SendClientMessage(playerid,COLOR_WHITE,"[!] This player does not spawned yet.");
			}
			//-----
			StartPlayerSpectate(playerid,destid);
			SendClientMessage(playerid,COLOR_WHITE,"[!] 위성 감시를 시작합니다. '/위성'을 입력하면 종료합니다.");
			SendClientMessage(playerid,COLOR_WHITE,"[!] 이전: [NUM 4] / 다음: [NUM 6] / 다시 위성: [NUM 1]");
			format(string,sizeof(string),"[Admin] %s(%d) 관리자가 %s(%d)를 위성 감시합니다.",GetPlayerNameEx(playerid),playerid,GetPlayerNameEx(destid),destid);
			SendClientMessageToAdmin(0xC0E0FFFF,string);
		}
		return 1;
	}

	if(!strcmp("/좌표이동",cmd))
	{
		if(!IsPlayerAdminEx(playerid,2))
			return SendClientMessage(playerid,COLOR_WHITE,"[!] 이 관리자 명령어를 사용할 권한이 없습니다.");
		//-----
		strcpy(string,stringslice_c(cmdtext,1));
		if(!strlen(string))
			return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /좌표이동 [x,y,z]");
		//-----
		new splited[3][32];
		split(string,splited,',');
		SetPlayerPos(playerid, floatstr(splited[0]),floatstr(splited[1]),floatstr(splited[2]));
		SendClientMessage(playerid,COLOR_WHITE,"[!] 해당 좌표로 이동했습니다.");
		return 1;
	}


	//-----/ Player Commands /---------------------------------------------------
	if(!strcmp("/신고",cmd) || !strcmp("/report",cmd))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /신고 [번호] [내용]");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /report [playerid or part of name] [Text]");
		}
		new destid = strval(cmd);
		if(destid == INVALID_PLAYER_ID)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 잘못된 유저 정보입니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
		}
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
		{
		    if(GetPlayerLanguage(playerid) == 0)
		    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /신고 [번호] [내용]");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /report [playerid or part of name] [Text]");
		}
		//-----
		strcpy(cmd,stringslice_c(cmdtext,2));
		format(string,sizeof(string),"[!] %s(%d) -> %s(%d) 신고: %s",GetPlayerNameEx(playerid),playerid,GetPlayerNameEx(destid),destid,cmd);
		SendClientMessageToAdmin(COLOR_PASTEL_GREEN,string);
	    if(GetPlayerLanguage(playerid) == 0)
	    	SendClientMessage(playerid,0xC0E0FFFF,"관리자에게 내용을 전달하였습니다.");
		else
		    SendClientMessage(playerid,0xC0E0FFFF,"Your report has been send to administrator");
		return 1;
	}
	return 0;
}
//-----/ KeyHandler_Admin /-----------------------------------------------------
public KeyHandler_Admin(playerid,newkeys,oldkeys)
{
	new destid,maxusers;
	if(IsPlayerSpectating(playerid))
	{
		destid = SpectateInfo[playerid][siDestID];
		maxusers = GetMaxPlayers();
		if(KEY_PRESSED(KEY_SUBMISSION))
			StartPlayerSpectate(playerid,destid);
		else if(KEY_PRESSED(KEY_ANALOG_LEFT))
		{
			do {
				if(--destid < 0)
					destid = maxusers - 1;
				if(playerid != destid && IsPlayerSpawnedEx(destid))
				{
					StartPlayerSpectate(playerid,destid);
					break;
				}
			} while(destid != SpectateInfo[playerid][siDestID]);
		}
		else if(KEY_PRESSED(KEY_ANALOG_RIGHT))
		{
			do {
				if(++destid >= maxusers)
					destid = 0;
				if(playerid != destid && IsPlayerSpawnedEx(destid))
				{
					StartPlayerSpectate(playerid,destid);
					break;
				}
			} while(destid != SpectateInfo[playerid][siDestID]);
		}
	}
}
//-----/ DialogHandler_Admin /--------------------------------------------------
public DialogHandler_Admin(playerid,dialogid,response,listitem,inputtext[])
{
	return 0;
}

//==========/ Functions /=======================================================

//==========/ Admin Functions /=================================================
//-----/ KickPlayer /-----------------------------------------------------------
stock KickPlayer(playerid, reason[], admin[])
{
	new string[256];
	ClearChatting(playerid);
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerLanguage(pid) == 0)
    		format(string,sizeof(string),"%s(%d)님이 서버에서 추방되었습니다. (이유: %s) (담당자: %s)",GetPlayerNameEx(playerid),playerid,reason,admin);
		else
		    format(string,sizeof(string),"%s(%d) has been kicked from the server. (reason: %s) (admin: %s)",GetPlayerNameEx(playerid),playerid,reason,admin);
    	SendClientMessage(pid,COLOR_GREY,string);
	}
    SetTimerEx("DelayedKick",200,0,"d",playerid);
}
//-----/ DelayedKick /----------------------------------------------------------
public DelayedKick(playerid)
	Kick(playerid);
//-----/ BanPlayer /------------------------------------------------------------
stock BanPlayer(playerid, reason[], admin[])
{
    new string[256];
	ClearChatting(playerid);
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerLanguage(pid) == 0)
    		format(string,sizeof(string),"%s(%d)님이 서버에서 영구추방되었습니다. (이유: %s) (담당자: %s)",GetPlayerNameEx(playerid),playerid,reason,admin);
		else
		    format(string,sizeof(string),"%s(%d) has been banned from the server. (reason: %s) (admin: %s)",GetPlayerNameEx(playerid),playerid,reason,admin);
    	SendClientMessage(pid,COLOR_GREY,string);
	}
    SetTimerEx("DelayedBan",200,0,"d",playerid);
}
//-----/ DelayedBan /----------------------------------------------------------
public DelayedBan(playerid)
	Ban(playerid);
//-----/ StartPlayerSpectate /--------------------------------------------------
stock StartPlayerSpectate(playerid,destid)
{
	new string[128];
	if(!IsPlayerSpectating(playerid))
	{
		SpectateInfo[playerid][siSkin] = GetPlayerSkin(playerid);
		GetPlayerPos(playerid,SpectateInfo[playerid][siPos][0],SpectateInfo[playerid][siPos][1],SpectateInfo[playerid][siPos][2]);
		GetPlayerFacingAngle(playerid, SpectateInfo[playerid][siPos][3]);
		SpectateInfo[playerid][siInterior] = GetPlayerInterior(playerid);
		SpectateInfo[playerid][siVirtual] = GetPlayerVirtualWorld(playerid);
	}
	SpectateInfo[playerid][siToggle] = true;
	SpectateInfo[playerid][siDestID] = destid;
	//-----
	TogglePlayerSpectating(playerid,true);
	SpectateInfo[playerid][siDestVehicle] = IsPlayerInAnyVehicle(destid);
	SpectateInfo[playerid][siDestInterior] = GetPlayerInterior(destid);
	SpectateInfo[playerid][siDestVirtual] = GetPlayerVirtualWorld(destid);
	SetPlayerInterior(playerid,SpectateInfo[playerid][siDestInterior]);
	SetPlayerVirtualWorld(playerid,SpectateInfo[playerid][siDestVirtual]);
	if(SpectateInfo[playerid][siDestVehicle])
		PlayerSpectateVehicle(playerid,GetPlayerVehicleID(destid));
	else
		PlayerSpectatePlayer(playerid,destid);
	//-----
	TogglePlayerInfoText(playerid,true);
	format(string,sizeof(string),"~h~~b~ID: ~w~%d~n~~h~~b~Name: ~w~%s",destid,GetPlayerNameEx(destid));
	if(GetPlayerInterior(destid) || GetPlayerVirtualWorld(destid))
		format(string,sizeof(string),"%s~n~~y~Interior: ~w~%d~n~~y~Virtual: ~w~%d",string,GetPlayerInterior(destid),GetPlayerVirtualWorld(destid));
	UpdatePlayerInfoText(playerid,string);
}
//-----/ FinishPlayerSpectate /-------------------------------------------------
stock FinishPlayerSpectate(playerid)
{
	TogglePlayerInfoText(playerid,false);
	TogglePlayerSpectating(playerid,false);
	//-----
	SpectateInfo[playerid][siToggle] = false;
	SetPlayerSkin(playerid,SpectateInfo[playerid][siSkin]);
	SetPlayerPos(playerid, SpectateInfo[playerid][siPos][0],SpectateInfo[playerid][siPos][1],SpectateInfo[playerid][siPos][2]);
	SetPlayerFacingAngle(playerid,SpectateInfo[playerid][siPos][3]);
	SetPlayerVirtualWorld(playerid,SpectateInfo[playerid][siVirtual]);
	SetPlayerInterior(playerid,SpectateInfo[playerid][siInterior]);
}
//-----/ RefreshSpectate /------------------------------------------------------
stock RefreshSpectate(playerid)
{
	new
		string[128],
		destid
	;
	if(IsPlayerSpectating(playerid))
	{
		destid = SpectateInfo[playerid][siDestID];
		if(SpectateInfo[playerid][siDestVehicle] != IsPlayerInAnyVehicle(destid)
		|| SpectateInfo[playerid][siDestInterior] != GetPlayerInterior(destid)
		|| SpectateInfo[playerid][siDestVirtual] != GetPlayerVirtualWorld(destid))
		{
			SpectateInfo[playerid][siDestVehicle] = IsPlayerInAnyVehicle(destid);
			SpectateInfo[playerid][siDestInterior] = GetPlayerInterior(destid);
			SpectateInfo[playerid][siDestVirtual] = GetPlayerVirtualWorld(destid);
			//-----
			SetPlayerInterior(playerid,GetPlayerInterior(destid));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(destid));
			SetTimerEx("RefreshSpectateAction",500,0,"i",playerid);
			//-----
			format(string,sizeof(string),"~y~ID: ~w~%d~n~~y~Name: ~w~%s",destid,GetPlayerRealName(destid));
			if(SpectateInfo[playerid][siDestVehicle])
				format(string,sizeof(string),"%s~n~~y~Car: ~w~%s",string,GetVehicleNumberPlate(GetPlayerVehicleID(destid)));
			if(GetPlayerInterior(destid) || GetPlayerVirtualWorld(destid))
				format(string,sizeof(string),"%s~n~~y~Interior: ~w~%d~n~~y~Virtual: ~w~%d",string,GetPlayerInterior(destid),GetPlayerVirtualWorld(destid));
			UpdatePlayerInfoText(playerid,string);
		}
	}
}
//-----/ RefreshSpectateAction /------------------------------------------------
public RefreshSpectateAction(playerid)
	if(IsPlayerSpectating(playerid))
	{
		new destid = SpectateInfo[playerid][siDestID];
		if(IsPlayerInAnyVehicle(destid))
			PlayerSpectateVehicle(playerid,GetPlayerVehicleID(destid));
		else
			PlayerSpectatePlayer(playerid,destid);
	}
//-----/ IsPlayerSpectating /---------------------------------------------------
stock IsPlayerSpectating(playerid)
	return SpectateInfo[playerid][siToggle];
//-----/ TogglePlayerInfoText /-------------------------------------------------
stock TogglePlayerInfoText(playerid,bool:toggle)
{
	if(toggle)
		PlayerTextDrawShow(playerid,Player_Text_Info[playerid]);
	else
		PlayerTextDrawHide(playerid,Player_Text_Info[playerid]);
}
//-----/ UpdatePlayerInfoText /-------------------------------------------------
stock UpdatePlayerInfoText(playerid,text[])
{
	strcpy(Player_InfoText_String[playerid],text);
	if(!Player_InfoText_Hide[playerid])
		PlayerTextDrawSetString(playerid,Player_Text_Info[playerid],text);
}
//-----/ TogglePlayerInfoTextHide /---------------------------------------------
stock TogglePlayerInfoTextHide(playerid,bool:toggle)
{
	Player_InfoText_Hide[playerid] = toggle;
	if(toggle)
		PlayerTextDrawSetString(playerid,Player_Text_Info[playerid]," ");
	else
		PlayerTextDrawSetString(playerid,Player_Text_Info[playerid],Player_InfoText_String[playerid]);
}
//-----/ IsPlayerAdminEx /------------------------------------------------------
stock IsPlayerAdminEx(playerid,level=1)
{
	if(GetPVarInt(playerid,"Admin") >= level || IsPlayerAdmin(playerid))
		return 1;
	return 0;
}
