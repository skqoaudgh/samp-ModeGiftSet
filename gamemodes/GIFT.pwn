/*
 *
 *		[For a better future, Enthusiasm of Acu]
 *
 *			MDPWN
 *			v1.0.001
 *
 *
 *		First Release:	2015/12/01
 *		Last Update:	2017/02/09
 *
 *
 *
 *		Coded by Acu 2006-2017 @ all rights reserved.
 *			acu.pe.kr@gmail.com
 *			http://acu.pe.kr
 *
 *
 */

//-----/ Pre-Defines /
	//--/ Mode Information /
#define MODE_NAME				"ALL IN ONE"
#define MODE_VERSION			"v1.0.0"
#define SERVER_HOSTNAME			"[GLOBAL][0.3.7] ALL IN ONE SERVER"



//-----/ Includes /
	//--/ Defaults /
#include <a_samp>
#include <a_http>
	//--/ Plug-ins /
#include <crashdetect>
#include <a_mysql>
#include <streamer>
#include <audio>
#include <mapandreas>
	//--/ Modulizations /
		// Cores //
#include "./Modules/Cores/Module.pwn"
#include "./Modules/Cores/Defines.pwn"
#include "./Modules/Cores/Timer.pwn"
#include "./Modules/Cores/MySQL.pwn"
#include "./Modules/Cores/RedefinedFunc.pwn"
#include "./Modules/Cores/ServerSide.pwn"
#include "./Modules/Cores/PlayerSide.pwn"
#include "./Modules/Cores/Userdata.pwn"
#include "./Modules/Cores/Map.pwn"
#include "./Modules/Cores/Death.pwn"
		// Functions //
#include "./Modules/Functions/ExtendedFunc.pwn"
#include "./Modules/Functions/FreezePlayer.pwn"
		// Command //
#include "./Modules/Command/Chatting.pwn"
#include "./Modules/Command/Admin.pwn"
		// Game //
#include "./Modules/Game/0_Lobby.pwn"
#include "./Modules/Game/1_Run.pwn"
#include "./Modules/Game/2_President.pwn"
#include "./Modules/Game/3_Shovel.pwn"
#include "./Modules/Game/4_Zombie.pwn"

//-----/ Defines /
#define DialogID(%1)			10000 + %1
#define VirtualID(%1)			10000 + %1
/*
 <DialogID List>
   Using negative values will close any open dialog.
   Max Value: 32,767
	10100: Userdata

 <VirtualID List>
   Max Value: 2,147,483,647
	10000: Core
	10100: Userdata
	10200: Map
	10300: Toggle
*/	



//-----/ Forwards /



//==========/ Callback Functions /==============================================
//-----/ main /-----------------------------------------------------------------
main() { }
//-----/ OnGameModeInit /-------------------------------------------------------
public OnGameModeInit()
{
	//------------/ Add Modules /-------------
		// Cores //
	AddModule("Timer");
	AddModule("MySQL");
	AddModule("ServerSide");
	AddModule("PlayerSide");
	AddModule("Userdata");
	AddModule("Object");
	AddModule("Map");
	AddModule("Admin");
	AddModule("Death");
	    // Command //
    AddModule("Chatting");
        // Function //
    AddModule("FreezePlayer");
	    // Game //
    AddModule("0_Lobby");
    AddModule("1_Run");
    AddModule("2_President");
    AddModule("3_Shovel");
    AddModule("4_Zombie");
		// Call Modules //
	InitializeModules();
	//----------------------------------------
	
	//-----/ Handlers /-----------------------
	/*
	  [Priorities]
		1: MySQL
	*/
	for(new i; i<CallbacksIndex[InitHandler]; i++)
		CallLocalFunction(Callbacks[InitHandler][i],"");
	//----------------------------------------
	return 1;
}
//-----/ OnGameModeExit /-------------------------------------------------------
public OnGameModeExit()
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ExitHandler]; i++)
		CallLocalFunction(Callbacks[ExitHandler][i],"");
	//----------------------------------------
	return 1;
}
//-----/ OnIncomingConnection /-------------------------------------------------
public OnIncomingConnection(playerid,ip_address[],port)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[InConnectionHandler]; i++)
		CallLocalFunction(Callbacks[InConnectionHandler][i],"isi",playerid,strblank(ip_address),port);
	//----------------------------------------
	return 1;
}
//-----/ OnRconCommand /--------------------------------------------------------
public OnRconCommand(cmd[])
{
	//-----/ Handlers /-----------------------
	new ret;
	for(new i; i<CallbacksIndex[RconCommandHandler]; i++)
		if((ret = CallLocalFunction(Callbacks[RconCommandHandler][i],"s",strblank(cmd))) == 1)
			break;
	//----------------------------------------
	if(ret == 0)
		printf("[mode] Unknown command: '%s'",cmd);
	return 1;
}
//-----/ OnRconLoginAttempt /---------------------------------------------------
public OnRconLoginAttempt(ip[],password[],success)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[RconLoginHandler]; i++)
		CallLocalFunction(Callbacks[RconLoginHandler][i],"ssi",strblank(ip),strblank(password),success);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerConnect /------------------------------------------------------
public OnPlayerConnect(playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ConnectHandler]; i++)
		CallLocalFunction(Callbacks[ConnectHandler][i],"i",playerid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerDisconnect /---------------------------------------------------
public OnPlayerDisconnect(playerid,reason)
{
	//-----/ Handlers /-----------------------
	/*
	  [Priorities]
		1: MySQL
	*/
	for(new i; i<CallbacksIndex[DisconnectHandler]; i++)
		CallLocalFunction(Callbacks[DisconnectHandler][i],"ii",playerid,reason);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerRequestClass /-------------------------------------------------
public OnPlayerRequestClass(playerid,classid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[RequestClassHandler]; i++)
		CallLocalFunction(Callbacks[RequestClassHandler][i],"ii",playerid,classid);
	//----------------------------------------
	return 0;
}
//-----/ OnPlayerRequestSpawn /-------------------------------------------------
public OnPlayerRequestSpawn(playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[RequestSpawnHandler]; i++)
		if(CallLocalFunction(Callbacks[RequestSpawnHandler][i],"i",playerid) == 0)
			break;
	//----------------------------------------
	return 0;
}
//-----/ OnPlayerSpawn /--------------------------------------------------------
public OnPlayerSpawn(playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[SpawnHandler]; i++)
		CallLocalFunction(Callbacks[SpawnHandler][i],"i",playerid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerDeath /--------------------------------------------------------
public OnPlayerDeath(playerid,killerid,reason)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[DeathHandler]; i++)
		CallLocalFunction(Callbacks[DeathHandler][i],"iii",playerid,killerid,reason);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerText /---------------------------------------------------------
public OnPlayerText(playerid,text[])
{
	//-----/ Handlers /-----------------------
	/*
	  [Priorities]
		1: MySQL
	*/
	for(new i; i<CallbacksIndex[TextHandler]; i++)
		if(CallLocalFunction(Callbacks[TextHandler][i],"is",playerid,strblank(text)) == 0)
			break;
	//----------------------------------------
	return 0;
}
//-----/ OnPlayerCommandText /--------------------------------------------------
public OnPlayerCommandText(playerid,cmdtext[])
{
	new string[128];
	//-----/ Handlers /-----------------------
	/*
	  [Priorities]
		1: MySQL
	*/
	for(new i; i<CallbacksIndex[CommandHandler]; i++)
		if(CallLocalFunction(Callbacks[CommandHandler][i],"is",playerid,strblank(cmdtext)) == 1)
			return 1;
	//----------------------------------------
	format(string,sizeof(string),"존재하지 않는 명령어입니다. ('%s')",cmdtext);
	SendClientMessage(playerid,COLOR_WHITE,string);
	return 1;
}
//-----/ OnPlayerUpdate /-------------------------------------------------------
public OnPlayerUpdate(playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[UpdateHandler]; i++)
		CallLocalFunction(Callbacks[UpdateHandler][i],"i",playerid);
	//----------------------------------------
	return 1;
}
//-----/ OnDialogResponse /-----------------------------------------------------
public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[])
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[DialogHandler]; i++)
		CallLocalFunction(Callbacks[DialogHandler][i],"iiiis",playerid,dialogid,response,listitem,strblank(inputtext));
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerKeyStateChange /-----------------------------------------------
public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[KeyHandler]; i++)
		CallLocalFunction(Callbacks[KeyHandler][i],"iii",playerid,newkeys,oldkeys);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerStateChange /--------------------------------------------------
public OnPlayerStateChange(playerid,newstate,oldstate)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[StateHandler]; i++)
		CallLocalFunction(Callbacks[StateHandler][i],"iii",playerid,newstate,oldstate);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerInteriorChange /-----------------------------------------------
public OnPlayerInteriorChange(playerid,newinteriorid,oldinteriorid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[InteriorHandler]; i++)
		CallLocalFunction(Callbacks[InteriorHandler][i],"iii",playerid,newinteriorid,oldinteriorid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerPickUpPickup /-------------------------------------------------
public OnPlayerPickUpPickup(playerid,pickupid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[PickUpHandler]; i++)
		CallLocalFunction(Callbacks[PickUpHandler][i],"ii",playerid,pickupid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerSelectObject /-------------------------------------------------
public OnPlayerSelectObject(playerid,type,objectid,modelid,Float:fX,Float:fY,Float:fZ)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[SelectObjectHandler]; i++)
		CallLocalFunction(Callbacks[SelectObjectHandler][i],"iiiifff",playerid,type,objectid,modelid,fX,fY,fZ);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerGiveDamage /---------------------------------------------------
public OnPlayerGiveDamage(playerid,damagedid,Float:amount,weaponid,bodypart)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[GiveDamageHandler]; i++)
		CallLocalFunction(Callbacks[GiveDamageHandler][i],"iifii",playerid,damagedid,amount,weaponid,bodypart);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerTakeDamage /---------------------------------------------------
public OnPlayerTakeDamage(playerid,issuerid,Float:amount,weaponid,bodypart)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[TakeDamageHandler]; i++)
		CallLocalFunction(Callbacks[TakeDamageHandler][i],"iifii",playerid,issuerid,amount,weaponid,bodypart);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerWeaponShot /---------------------------------------------------
public OnPlayerWeaponShot(playerid,weaponid,hittype,hitid,Float:fX,Float:fY,Float:fZ)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[WeaponShotHandler]; i++)
		if(CallLocalFunction(Callbacks[WeaponShotHandler][i],"iiiifff",playerid,weaponid,hittype,hitid,fX,fY,fZ) == 0)
			return 0;
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEnterVehicle /-------------------------------------------------
public OnPlayerEnterVehicle(playerid,vehicleid,ispassenger)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EnterVehicleHandler]; i++)
		CallLocalFunction(Callbacks[EnterVehicleHandler][i],"iii",playerid,vehicleid,ispassenger);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerExitVehicle /--------------------------------------------------
public OnPlayerExitVehicle(playerid,vehicleid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ExitVehicleHandler]; i++)
		CallLocalFunction(Callbacks[ExitVehicleHandler][i],"ii",playerid,vehicleid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEnterCheckpoint /----------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EnterCPHandler]; i++)
		CallLocalFunction(Callbacks[EnterCPHandler][i],"i",playerid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerLeaveCheckpoint /----------------------------------------------
public OnPlayerLeaveCheckpoint(playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[LeaveCPHandler]; i++)
		CallLocalFunction(Callbacks[LeaveCPHandler][i],"i",playerid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEnterRaceCheckpoint /------------------------------------------
public OnPlayerEnterRaceCheckpoint(playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EnterRCPHandler]; i++)
		CallLocalFunction(Callbacks[EnterRCPHandler][i],"i",playerid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerLeaveRaceCheckpoint /------------------------------------------
public OnPlayerLeaveRaceCheckpoint(playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[LeaveRCPHandler]; i++)
		CallLocalFunction(Callbacks[LeaveRCPHandler][i],"i",LeaveRCPHandler);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEditObject /---------------------------------------------------
public OnPlayerEditObject(playerid,playerobject,objectid,response,Float:fX,Float:fY,Float:fZ,Float:fRotX,Float:fRotY,Float:fRotZ)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EditObjectHandler]; i++)
		CallLocalFunction(Callbacks[EditObjectHandler][i],"iiiiffffff",playerid,playerobject,objectid,response,fX,fY,fZ,fRotX,fRotY,fRotZ);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEditAttachedObject /-------------------------------------------
public OnPlayerEditAttachedObject(playerid,response,index,modelid,boneid,Float:fOffsetX,Float:fOffsetY,Float:fOffsetZ,Float:fRotX,Float:fRotY,Float:fRotZ,Float:fScaleX,Float:fScaleY,Float:fScaleZ)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EditAObjectHandler]; i++)
		CallLocalFunction(Callbacks[EditAObjectHandler][i],"iiiiifffffffff",playerid,response,index,modelid,boneid,fOffsetX,fOffsetY,fOffsetZ,fRotX,fRotY,fRotZ,fScaleX,fScaleY,fScaleZ);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerClickTextDraw /------------------------------------------------
public OnPlayerClickTextDraw(playerid,Text:clickedid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ClickTDHandler]; i++)
		CallLocalFunction(Callbacks[ClickTDHandler][i],"ii",playerid,_:clickedid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerClickPlayerTextDraw /------------------------------------------
public OnPlayerClickPlayerTextDraw(playerid,PlayerText:playertextid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ClickPTDHandler]; i++)
		CallLocalFunction(Callbacks[ClickPTDHandler][i],"ii",playerid,_:playertextid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerClickMap /-----------------------------------------------------
public OnPlayerClickMap(playerid,Float:fX,Float:fY,Float:fZ)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ClickMapHandler]; i++)
		CallLocalFunction(Callbacks[ClickMapHandler][i],"ifff",playerid,fX,fY,fZ);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerClickPlayer /--------------------------------------------------
public OnPlayerClickPlayer(playerid,clickedplayerid,source)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ClickPlayerHandler]; i++)
		CallLocalFunction(Callbacks[ClickPlayerHandler][i],"iii",playerid,clickedplayerid,source);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerStreamIn /-----------------------------------------------------
public OnPlayerStreamIn(playerid,forplayerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[StreamInHandler]; i++)
		CallLocalFunction(Callbacks[StreamInHandler][i],"ii",playerid,forplayerid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerStreamOut /----------------------------------------------------
public OnPlayerStreamOut(playerid,forplayerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[StreamOutHandler]; i++)
		CallLocalFunction(Callbacks[StreamOutHandler][i],"ii",playerid,forplayerid);
	//----------------------------------------
	return 1;
}
//-----/ OnObjectMoved /--------------------------------------------------------
public OnObjectMoved(objectid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ObjectMovedHandler]; i++)
		CallLocalFunction(Callbacks[ObjectMovedHandler][i],"i",objectid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerObjectMoved /--------------------------------------------------
public OnPlayerObjectMoved(playerid,objectid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[PObjectMovedHandler]; i++)
		CallLocalFunction(Callbacks[PObjectMovedHandler][i],"ii",playerid,objectid);
	//----------------------------------------
	return 1;
}
//-----/ OnVehicleSpawn /-------------------------------------------------------
public OnVehicleSpawn(vehicleid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[VehicleSpawnHandler]; i++)
		CallLocalFunction(Callbacks[VehicleSpawnHandler][i],"i",vehicleid);
	//----------------------------------------
	return 1;
}
//-----/ OnVehicleDeath /-------------------------------------------------------
public OnVehicleDeath(vehicleid,killerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[VehicleDeathHandler]; i++)
		CallLocalFunction(Callbacks[VehicleDeathHandler][i],"ii",vehicleid,killerid);
	//----------------------------------------
	return 1;
}
//-----/ OnVehicleStreamIn /----------------------------------------------------
public OnVehicleStreamIn(vehicleid,forplayerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[VStreamInHandler]; i++)
		CallLocalFunction(Callbacks[VStreamInHandler][i],"ii",vehicleid,forplayerid);
	//----------------------------------------
	return 1;
}
//-----/ OnVehicleStreamOut /---------------------------------------------------
public OnVehicleStreamOut(vehicleid,forplayerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[VStreamOutHandler]; i++)
		CallLocalFunction(Callbacks[VStreamOutHandler][i],"ii",vehicleid,forplayerid);
	//----------------------------------------
	return 1;
}
//-----/ OnVehicleDamageStatusUpdate /------------------------------------------
public OnVehicleDamageStatusUpdate(vehicleid,playerid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[VehicleDamageHandler]; i++)
		CallLocalFunction(Callbacks[VehicleDamageHandler][i],"ii",vehicleid,playerid);
	//----------------------------------------
	return 1;
}
//-----/ OnUnoccupiedVehicleUpdate /--------------------------------------------
public OnUnoccupiedVehicleUpdate(vehicleid,playerid,passenger_seat,Float:new_x,Float:new_y,Float:new_z,Float:vel_x,Float:vel_y,Float:vel_z)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[UnocVehicleHandler]; i++)
		if(CallLocalFunction(Callbacks[UnocVehicleHandler][i],"iiiffffff",vehicleid,playerid,passenger_seat,new_x,new_y,new_z,vel_x,vel_y,vel_z) == 0)
			return 0;
	//----------------------------------------
	return 1;
}
//-----/ OnTrailerUpdate /------------------------------------------------------
public OnTrailerUpdate(playerid,vehicleid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[TrailerHandler]; i++)
		CallLocalFunction(Callbacks[TrailerHandler][i],"ii",playerid,vehicleid);
	//----------------------------------------
	return 1;
}
//-----/ OnVehicleMod /---------------------------------------------------------
public OnVehicleMod(playerid,vehicleid,componentid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ModHandler]; i++)
		CallLocalFunction(Callbacks[ModHandler][i],"iii",playerid,vehicleid,componentid);
	//----------------------------------------
	return 1;
}
//-----/ OnVehiclePaintjob /----------------------------------------------------
public OnVehiclePaintjob(playerid,vehicleid,paintjobid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[PaintjobHandler]; i++)
		CallLocalFunction(Callbacks[PaintjobHandler][i],"iii",playerid,vehicleid,paintjobid);
	//----------------------------------------
	return 1;
}
//-----/ OnVehicleRespray /-----------------------------------------------------
public OnVehicleRespray(playerid,vehicleid,color1,color2)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ResprayHandler]; i++)
		CallLocalFunction(Callbacks[ResprayHandler][i],"iiii",playerid,vehicleid,color1,color2);
	//----------------------------------------
	return 1;
}
//-----/ OnEnterExitModShop /---------------------------------------------------
public OnEnterExitModShop(playerid,enterexit,interiorid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ModShopHandler]; i++)
		CallLocalFunction(Callbacks[ModShopHandler][i],"iii",playerid,enterexit,interiorid);
	//----------------------------------------
	return 1;
}





//==========/ Streamer Callback Functions /=====================================
//-----/ OnDynamicObjectMoved /-------------------------------------------------
public OnDynamicObjectMoved(objectid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[DObjectMovedHandler]; i++)
		CallLocalFunction(Callbacks[DObjectMovedHandler][i],"i",objectid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEditDynamicObject /--------------------------------------------
public OnPlayerEditDynamicObject(playerid,objectid,response,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EditDObjectHandler]; i++)
		CallLocalFunction(Callbacks[EditDObjectHandler][i],"iiiffffff",playerid,objectid,response,x,y,z,rx,ry,rz);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerSelectDynamicObject /------------------------------------------
public OnPlayerSelectDynamicObject(playerid,objectid,modelid,Float:x,Float:y,Float:z)
{
	if(GetTickCount()-GetPVarInt(playerid,"SelectObjectDelay") < 200)
		return 1;
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[SelectDObjectHandler]; i++)
		CallLocalFunction(Callbacks[SelectDObjectHandler][i],"iiifff",playerid,objectid,modelid,x,y,z);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerShootDynamicObject /-------------------------------------------
public OnPlayerShootDynamicObject(playerid,weaponid,objectid,Float:x,Float:y,Float:z)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[ShootDObjectHandler]; i++)
		CallLocalFunction(Callbacks[ShootDObjectHandler][i],"iiifff",playerid,weaponid,objectid,x,y,z);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerPickUpDynamicPickup /------------------------------------------
public OnPlayerPickUpDynamicPickup(playerid,pickupid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[PickUpDPHandler]; i++)
		CallLocalFunction(Callbacks[PickUpDPHandler][i],"ii",playerid,pickupid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEnterDynamicCP /-----------------------------------------------
public OnPlayerEnterDynamicCP(playerid,checkpointid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EnterDCPHandler]; i++)
		CallLocalFunction(Callbacks[EnterDCPHandler][i],"ii",playerid,checkpointid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerLeaveDynamicCP /-----------------------------------------------
public OnPlayerLeaveDynamicCP(playerid,checkpointid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[LeaveDCPHandler]; i++)
		CallLocalFunction(Callbacks[LeaveDCPHandler][i],"ii",playerid,checkpointid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEnterDynamicRaceCP /-------------------------------------------
public OnPlayerEnterDynamicRaceCP(playerid,checkpointid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EnterDRCPHandler]; i++)
		CallLocalFunction(Callbacks[EnterDRCPHandler][i],"ii",playerid,checkpointid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerLeaveDynamicRaceCP /-------------------------------------------
public OnPlayerLeaveDynamicRaceCP(playerid,checkpointid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[LeaveDRCPHandler]; i++)
		CallLocalFunction(Callbacks[LeaveDRCPHandler][i],"ii",playerid,checkpointid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerEnterDynamicArea /---------------------------------------------
public OnPlayerEnterDynamicArea(playerid,areaid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[EnterDAreaHandler]; i++)
		CallLocalFunction(Callbacks[EnterDAreaHandler][i],"ii",playerid,areaid);
	//----------------------------------------
	return 1;
}
//-----/ OnPlayerLeaveDynamicArea /---------------------------------------------
public OnPlayerLeaveDynamicArea(playerid,areaid)
{
	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[LeaveDAreaHandler]; i++)
		CallLocalFunction(Callbacks[LeaveDAreaHandler][i],"ii",playerid,areaid);
	//----------------------------------------
	return 1;
}
