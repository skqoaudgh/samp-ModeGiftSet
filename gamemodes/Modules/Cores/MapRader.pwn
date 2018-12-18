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
stock SetPlayerMarkerForPlayerEx(playerid, color) // pid가 playerid를 color 색깔로 봄
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerMap(pid) == GetPlayerMap(playerid)) // 같은 맵에 있는 사람들만 색깔 보이게
		    SetPlayerMarkerForPlayer(pid, playerid, color);
		else    // 다른 맵에 있는 사람들은 안보이게
		    SetPlayerMarkerForPlayer(pid, playerid, color | 0x000000FF);
	}
}
