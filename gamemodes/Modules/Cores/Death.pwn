/*
  [Functions]
	IsPlayerSpawnedEx(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Death
	#endinput
#endif
#define _MDPWN_Death



//-----/ Includes /



//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1



//-----/ News /
	//--/ Death /
new bool:P_Spanwed[MAX_PLAYERS];



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Death();
forward DeathHandler_Death(playerid,killerid,reason);
forward SpawnHandler_Death(playerid);
	//--/ Functions /



//==========/ Callback Functions /==============================================
//-----/ AddHandler_WTF /-------------------------------------------------------
public AddHandler_Death()
{
	AddHandler("Death",DeathHandler);
	AddHandler("Death",SpawnHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}
//-----/ SpawnHandler_Death /---------------------------------------------------
public SpawnHandler_Death(playerid)
{
    P_Spanwed[playerid] = true;
}
//-----/ DeathHandler_Death /---------------------------------------------------
public DeathHandler_Death(playerid,killerid,reason)
{
	new WeaponName[32], string[128];
    GetWeaponName(reason, WeaponName, sizeof(WeaponName));
	if(killerid != INVALID_PLAYER_ID)
	{
	    if(GetPlayerLanguage(playerid) == 0)
			format(string,sizeof(string),"* %s(%d) ¥‘¿Ã %s(%d) ¥‘¿ª %s (¿∏)∑Œ ¡◊ø¥Ω¿¥œ¥Ÿ (Point +1, Money +100).",GetPlayerNameEx(killerid),killerid,GetPlayerNameEx(playerid),playerid,WeaponName);
		else
		    format(string,sizeof(string),"* %s(%d) has killed %s(%d) with %s (Point +1, Money +100).",GetPlayerNameEx(killerid),killerid,GetPlayerNameEx(playerid),playerid,WeaponName);
		SendMessage(2, COLOR_RED, string);

		GivePlayerPoint(playerid, 1);
		SetPVarInt(killerid,"Money",GetPVarInt(killerid,"Money")+100);
		SetPVarInt(killerid,"Kills",GetPVarInt(killerid,"Kills")+1);
		SetPVarInt(playerid,"Deaths",GetPVarInt(killerid,"Deaths")+1);
	}
	P_Spanwed[playerid] = false;
}

//==========/ Functions /=======================================================
//-----/ IsPlayerSpawnedEx /----------------------------------------------------
stock IsPlayerSpawnedEx(playerid)
{
	return P_Spanwed[playerid];
}
