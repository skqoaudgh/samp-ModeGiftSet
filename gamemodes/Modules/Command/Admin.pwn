/*
  [Functions]
  
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Admin
	#endinput
#endif
#define _MDPWN_Admin



//-----/ Includes /



//-----/ Defines /
//#define Dialog_Admin(%1)			10400 + %1



//-----/ News /
	//--/  /



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Admin();
forward CommandHandler_Admin(playerid,cmdtext[]);
forward DialogHandler_Admin(playerid,dialogid,response,listitem,inputtext[]);
	//--/ Functions /





//==========/ Callback Functions /==============================================
//-----/ AddHandler_Admin /-----------------------------------------------------
public AddHandler_Admin()
{
	AddHandler("Admin",CommandHandler);
	AddHandler("Admin",DialogHandler);
	//AddHandler("WTF",InitHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}
//-----/ CommandHandler_Admin /-------------------------------------------------
public CommandHandler_Admin(playerid,cmdtext[])
{

	return 0;
}
//-----/ DialogHandler_Admin /--------------------------------------------------
public DialogHandler_Admin(playerid,dialogid,response,listitem,inputtext[])
{
	return 0;
}

//==========/ Functions /=======================================================

//==========/ Admin Functions /=================================================
//-----/ IsPlayerAdminEx /------------------------------------------------------
stock IsPlayerAdminEx(playerid,level=1)
{
	if(GetPVarInt(playerid,"Admin") >= level)
		return 1;
	return 0;
}
