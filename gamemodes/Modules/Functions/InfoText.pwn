/*
  [Functions]
	GetPlayerInfoText(playerid)
	ResetPlayerInfoText(playerid)
	ShowPlayerInfoText(playerid)
	HidePlayerInfoText(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_InfoText
	#endinput
#endif
#define _MDPWN_InfoText



//-----/ Includes /



//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1



//-----/ News /
	//--/ Player Textdraw /
new PlayerText:Player_InfoText[MAX_PLAYERS];



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_InfoText();
forward ConnectHandler_InfoText(playerid);
	//--/ Functions /
forward PlayerText:GetPlayerInfoText(playerid);




//==========/ Callback Functions /==============================================
//-----/ AddHandler_InfoText /--------------------------------------------------
public AddHandler_InfoText()
{
	AddHandler("InfoText",ConnectHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}
//-----/ ConnectHandler_InfoText /----------------------------------------------
public ConnectHandler_InfoText(playerid)
{
	Player_InfoText[playerid] = CreatePlayerTextDraw(playerid, 480.000000, 400.000000, "");
	PlayerTextDrawLetterSize(playerid, Player_InfoText[playerid], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Player_InfoText[playerid], 1);
	PlayerTextDrawColor(playerid, Player_InfoText[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Player_InfoText[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Player_InfoText[playerid], 255);
	PlayerTextDrawFont(playerid, Player_InfoText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Player_InfoText[playerid], 1);
}


//==========/ Functions /=======================================================
//-----/ GetPlayerInfoText /----------------------------------------------------
stock PlayerText:GetPlayerInfoText(playerid)
{
	return Player_InfoText[playerid];
}
//-----/ ResetPlayerInfoText /--------------------------------------------------
stock ResetPlayerInfoText(playerid)
{
    PlayerTextDrawSetString(playerid, Player_InfoText[playerid], "");
}
//-----/ ShowPlayerInfoText /---------------------------------------------------
stock ShowPlayerInfoText(playerid)
{
    PlayerTextDrawShow(playerid,Player_InfoText[playerid]);
}
//-----/ HidePlayerInfoText /---------------------------------------------------
stock HidePlayerInfoText(playerid)
{
    PlayerTextDrawHide(playerid,Player_InfoText[playerid]);
}
