/*
  [Functions]
	SetPlayerMarkerForPlayerEx(playerid, showplayerid, color)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_MapRader
	#endinput
#endif
#define _MDPWN_MapRader



//-----/ Includes /



//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1



//-----/ News /
	//--/  /



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_MapRader();
	//--/ Functions /




//==========/ Callback Functions /==============================================
//-----/ AddHandler_MapRader /--------------------------------------------------
public AddHandler_MapRader()
{
	//AddHandler("MapRader",InitHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}

//==========/ Functions /=======================================================
//-----/ SetPlayerMarkerForPlayerEx /-------------------------------------------
stock SetPlayerMarkerForPlayerEx(playerid) // pid°¡ playerid¸¦ color »ö±ò·Î º½
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(playerid == pid) continue;
		if(GetPlayerMap(pid) == GetPlayerMap(playerid)) // °°Àº ¸Ê¿¡ ÀÖ´Â »ç¶÷µé¸¸ »ö±ò º¸ÀÌ°Ô
		{
		    SetPlayerMarkerForPlayer(pid, playerid, GetPlayerColor(playerid));
		    SetPlayerMarkerForPlayer(playerid, pid, GetPlayerColor(pid));
		}
		else if(GetPlayerMap(pid) != GetPlayerMap(playerid))
		{
			SetPlayerMarkerForPlayer(pid, playerid, 0x00000000);
			SetPlayerMarkerForPlayer(playerid, pid, 0x00000000);
		}
	}
}
