/*
 *
 *		[For a better future, Enthusiasm of Acu]
 *
 *			Server Side
 *			v1.0.0
 *
 *
 *		First Release:		2017/02/08
 *		Last Update:		2017/02/08
 *
 *
 *
 *		Coded by Acu 2006-2017 @ all rights reserved.
 *			acu.pe.kr@gmail.com
 *			http://acu.pe.kr
 *
 *
 */

//-----/ Pre-Processing /
#if defined _MDPWN_ServerSide
	#endinput
#endif
#define _MDPWN_ServerSide



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_ServerSide();
forward InitHandler_ServerSide();
forward ExitHandler_ServerSide();





//==========/ Callback Functions /==============================================
//-----/ AddHandler_ServerSide /------------------------------------------------
public AddHandler_ServerSide()
{
	AddHandler("ServerSide",InitHandler);
	AddHandler("ServerSide",ExitHandler);
}
//-----/ InitHandler_ServerSide /-----------------------------------------------
public InitHandler_ServerSide()
{
	// Server Settings
	new string[32];
	format(string,sizeof(string),"* %s %s",MODE_NAME,MODE_VERSION);
	SetGameModeText(string);
	SendRconCommand("hostname "SERVER_HOSTNAME"");
	SendRconCommand("mapname Los Angeles");
	//-----
	// SA:MP Options
	SetWorldTime(12);
	SetWeather(1);
	//ShowNameTags(0);
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	AllowInteriorWeapons(0);
	EnableStuntBonusForAll(0);
	//DisableInteriorEnterExits();
	//ManualVehicleEngineAndLights();
	//------
	// Plug-In Settings
	MapAndreas_Init(MAP_ANDREAS_MODE_MINIMAL);
}
//-----/ ExitHandler_ServerSide /-----------------------------------------------
public ExitHandler_ServerSide()
{
	printf("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	printf("[mode] Mode has been unloaded.");
}