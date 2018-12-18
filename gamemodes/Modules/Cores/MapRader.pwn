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
stock SetPlayerMarkerForPlayerEx(playerid, color) // pid�� playerid�� color ����� ��
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerMap(pid) == GetPlayerMap(playerid)) // ���� �ʿ� �ִ� ����鸸 ���� ���̰�
		    SetPlayerMarkerForPlayer(pid, playerid, color);
		else    // �ٸ� �ʿ� �ִ� ������� �Ⱥ��̰�
		    SetPlayerMarkerForPlayer(pid, playerid, color | 0x000000FF);
	}
}
