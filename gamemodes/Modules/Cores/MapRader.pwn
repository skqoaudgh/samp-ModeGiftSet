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
stock SetPlayerMarkerForPlayerEx(playerid, color) // pid°¡ playerid¸¦ color »ö±ò·Î º½
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerMap(pid) == GetPlayerMap(playerid)) // °°Àº ¸Ê¿¡ ÀÖ´Â »ç¶÷µé¸¸ »ö±ò º¸ÀÌ°Ô
		{
		    SetPlayerMarkerForPlayer(pid, playerid, color);
		    SetPlayerMarkerForPlayer(playerid, pid, GetPlayerColor(pid));
		}
		else if(GetPlayerMap(pid) != GetPlayerMap(playerid) || IsPlayerNPC(playerid))
		{
			SetPlayerMarkerForPlayer(pid, playerid, color | 0x000000FF);
			SetPlayerMarkerForPlayer(playerid, pid, color | 0x000000FF);
		}
	}
}
