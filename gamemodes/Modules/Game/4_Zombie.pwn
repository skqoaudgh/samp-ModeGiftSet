/*
  [Functions]
	SwitchInterval(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_4_Zombie
	#endinput
#endif
#define _MDPWN_4_Zombie

//-----/ News /
	//--/ Spawn Position /
new Float:SpawnPos_Human[5][4] = {
{810.8369,-1098.3204,25.9063,271.5120},
{814.7183,-1108.8276,25.7890,359.9785},
{815.7480,-1092.6204,25.7903,180.2488},
{810.7944,-1102.9802,26.9583,269.6554},
{820.0737,-1098.6196,25.7956,181.6704}
};
new Float:SpawnPos_Zombie[10][4] = {
{910.9846,-1094.7188,25.5175,95.2327},
{910.0493,-1085.9347,24.7184,89.5926},
{918.2030,-1078.5610,24.5316,88.6759},
{908.5730,-1112.0566,25.4406,90.1800},
{877.9747,-1119.5277,25.1227,92.8120},
{878.7032,-1094.3665,25.4765,87.9240},
{878.6434,-1085.9868,25.7888,94.6920},
{878.2018,-1077.0510,24.5843,94.1280},
{879.0248,-1067.1752,26.0148,94.3393},
{893.9465,-1101.8381,23.2969,86.8192}
};
	//--/ Team /
new bool:IsPlayerInTeamSelection[MAX_PLAYERS];
new bool:Switch[MAX_PLAYERS];
new SwitchTimer[MAX_PLAYERS];

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_4_Zombie();
forward InitHandler_4_Zombie();
forward SpawnHandler_4_Zombie(playerid);
forward UpdateHandler_4_Zombie(playerid);
forward CommandHandler_4_Zombie(playerid,cmdtext[]);
forward KeyHandler_4_Zombie(playerid,newkeys,oldkeys);
forward DisconnectHandler_4_Zombie(playerid,reason);
	//--/ Functions /
forward SwitchInterval(playerid);

//==========/ Callback Functions /==============================================
//-----/ AddHandler_4_Zombie /-----------------------------------------------------
public AddHandler_4_Zombie()
{
	AddHandler("4_Zombie",InitHandler);
	AddHandler("4_Zombie",SpawnHandler);
	AddHandler("4_Zombie",CommandHandler);
	AddHandler("4_Zombie",UpdateHandler);
	AddHandler("4_Zombie",KeyHandler);
	AddHandler("4_Zombie",DisconnectHandler);
}

//-----/ InitHandler_4_Zombie /----------------------------------------------------
public InitHandler_4_Zombie()
{
	CreateDynamicObject(3279, 816.16840, -1120.27917, 25.13690,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3279, 816.16840, -1085.79834, 25.13690,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3885, 816.77594, -1103.24243, 34.57800,   0.00000, 0.00000, 75.00000, .worldid=4);
	CreateDynamicObject(8483, 948.87341, -1103.87585, 29.26420,   0.00000, 0.00000, 180.00000, .worldid=4);
	CreateDynamicObject(3461, 840.64313, -1110.98193, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 854.12952, -1110.78467, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 869.38416, -1110.44836, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 881.27240, -1109.90344, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 905.52271, -1109.60938, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 921.29041, -1109.16052, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 841.22156, -1093.65942, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 856.00781, -1093.51196, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 868.54529, -1092.87341, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 880.11578, -1092.23254, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 907.07562, -1091.79224, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 920.96588, -1092.43201, 24.65940,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 822.55713, -1119.04382, 31.63860,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3461, 822.58112, -1086.78748, 31.63860,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(2780, 822.66559, -1103.05457, 14.79770,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(3528, 823.67914, -1103.43689, 31.73759,   0.00000, 0.00000, 0.00000, .worldid=4);
	CreateDynamicObject(7657, 831.31250, -1113.97949, 25.11190,   -60.00000, 90.00000, 90.00000, .worldid=4);
	CreateDynamicObject(7657, 831.31250, -1091.82861, 25.11190,   -60.00000, 90.00000, 90.00000, .worldid=4);
}
//-----/ DisconnectHandler_4_Zombie /-------------------------------------------
public DisconnectHandler_4_Zombie(playerid,reason)
{
    IsPlayerInTeamSelection[playerid] = false;
    Switch[playerid] = false;
}
//-----/ SpawnHandler_4_Zombie /---------------------------------------------------
public SpawnHandler_4_Zombie(playerid)
{
	if(GetPlayerMap(playerid) == 4)
	{
	    ClearChatting(playerid);
		if(GetPlayerLanguage(playerid) == 0)
		{
		    SendClientMessage(playerid,COLOR_GREEN,"          돌아온 시발모드 : 좀비 서바이벌");
		    SendClientMessage(playerid,COLOR_WHITE,"묘지의 시체들이 깨어나기 시작했다.");
		    SendClientMessage(playerid,COLOR_WHITE,"당신은 개조된 허술한 묘지에서 좀비로부터 살아남아야 한다.");
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREEN,"          Fuck Mode Returned: Zombie Survival");
		    SendClientMessage(playerid,COLOR_WHITE,"The bodies of the graves began to wake up");
		    SendClientMessage(playerid,COLOR_WHITE,"You have to survive from zombies in a fortified graveyard.");
		}
		//-----
		SetPlayerVirtualWorld(playerid, 4);
		SetPlayerInterior(playerid, 0);
        SetPlayerWorldBounds(playerid,939.6846, 808.0087, -1056.0449, -1129.5148);
        SetPlayerTime(playerid, 0, 0);
        SetPlayerWeather(playerid, 8);
  		ResetPlayerWeapons(playerid);
		if(GetPlayerTeam(playerid) != 255)
		{
			if(GetPlayerTeam(playerid) == 1) // 인간
			{
				SetPlayerSkin(playerid, 68);
		        SetPlayerHealth(playerid, 1.0);
		        SetPlayerArmour(playerid, 0.0);
		        GivePlayerWeapon(playerid, 38, 5000);
		        GivePlayerWeapon(playerid, 16, 10);

		        new rand = random(5);
		        SetPlayerPos(playerid, SpawnPos_Human[rand][0], SpawnPos_Human[rand][1], SpawnPos_Human[rand][2]);
		        SetPlayerFacingAngle(playerid, SpawnPos_Human[rand][3]);
			}
			else // 좀비
			{
			    SetPlayerSkin(playerid, 162);
		        SetPlayerHealth(playerid, 5000.0);
		        SetPlayerArmour(playerid, 0.0);
		        GivePlayerWeapon(playerid, 1, 1);

		        new rand = random(10);
		        SetPlayerPos(playerid, SpawnPos_Zombie[rand][0], SpawnPos_Zombie[rand][1], SpawnPos_Zombie[rand][2]);
		        SetPlayerFacingAngle(playerid, SpawnPos_Zombie[rand][3]);
			}
	        FreezePlayer(playerid, 1);
            GameTextForPlayer(playerid," ", 0, 6);
		}
		else
		{
		    IsPlayerInTeamSelection[playerid] = true;
		    GameTextForPlayer(playerid,"~b~Human", 10000, 3);
		    SetPlayerTeam(playerid, 1);
		    SetPlayerSkin(playerid, 68);
			SetPlayerVirtualWorld(playerid, 13+playerid);
			SetPlayerPos(playerid,823.6836,-1102.9181,25.7891);
			SetPlayerFacingAngle(playerid,265.1960);
			SetPlayerCameraPos(playerid,827.4348,-1102.9203,28.1943);
			SetPlayerCameraLookAt(playerid,823.6836,-1102.9181,25.7891);
			FreezePlayer(playerid);
		}
	}
}
//-----/ CommandHandler_4_Zombie /---------------------------------------------------
public CommandHandler_4_Zombie(playerid,cmdtext[])
{
	if(GetPlayerMap(playerid) == 4)
	{
		if(!strcmp("/help",cmdtext) || !strcmp("/도움말",cmdtext) || !strcmp("/?",cmdtext))
		{
			if(GetPlayerLanguage(playerid) == 0)
				SendClientMessage(playerid,COLOR_WHITE,"* 이 맵은 도움말이 없습니다.");
			else
				SendClientMessage(playerid,COLOR_WHITE,"* This map has no help message.");
			return 1;
		}
	}
	return 0;
}
//-----/ UpdateHandler_4_Zombie /--------------------------------------------
public UpdateHandler_4_Zombie(playerid)
{
	if(GetPlayerMap(playerid) == 4)
	{
		if(IsPlayerInTeamSelection[playerid] && !Switch[playerid])
		{
		    new Keys,ud,lr;
		    GetPlayerKeys(playerid,Keys,ud,lr);
		    if(lr == KEY_LEFT || lr == KEY_RIGHT)
		    {
		        Switch[playerid] = true;
		        KillTimer(SwitchTimer[playerid]);
		        SwitchTimer[playerid] = SetTimerEx("SwitchInterval",500,1,"d",playerid);
		        if(GetPlayerTeam(playerid) == 1)
		        {
                    SetPlayerTeam(playerid, 2);
                    SetPlayerSkin(playerid, 162);
                    SetPlayerColor(playerid, COLOR_RED);
                    GameTextForPlayer(playerid,"~r~Zombie", 10000, 3);
		        }
		        else
		        {
                    SetPlayerTeam(playerid, 1);
                    SetPlayerSkin(playerid, 68);
                    SetPlayerColor(playerid, COLOR_BLUE);
                    GameTextForPlayer(playerid,"~b~Human", 10000, 3);
		        }
		    }
		}
	}
}
//-----/ KeyHandler_4_Zombie /-----------------------------------------------
public KeyHandler_4_Zombie(playerid,newkeys,oldkeys)
{
	if(GetPlayerMap(playerid) == 4)
	{
		if(IsPlayerInTeamSelection[playerid])
		{
		    if(newkeys == KEY_JUMP || newkeys == KEY_YES) // 선택
		    {
		        IsPlayerInTeamSelection[playerid] = false;
		        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		        SetCameraBehindPlayer(playerid);
		        UnFreezePlayer(playerid);
		        SpawnPlayer(playerid);
		    }
		}
	}
	return 0;
}
//==========/ Functions /=======================================================
public SwitchInterval(playerid)
{
	Switch[playerid] = false;
}
