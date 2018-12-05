/*
 *
 *		[For a better future, Enthusiasm of Acu]
 *
 *			Module
 *			v1.0.4
 *
 *
 *		First Release:		2014/12/18
 *		Last Update:		2016/12/21
 *
 *
 *
 *		Coded by Acu 2006-2017 @ all rights reserved.
 *			acu.pe.kr@gmail.com
 *			http://acu.pe.kr
 *
 *
 */
/*
  [Informations]
	- Numerically lower value indicates higher priority. (default: 5)

  [Usage]

	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[Handler]; i++)
		CallLocalFunction(Callbacks[Handler][i],"");
	//----------------------------------------

	//-----/ Handlers /-----------------------
	for(new i; i<CallbacksIndex[Handler]; i++)
		if(CallLocalFunction(Callbacks[Handler][i],"") == 0)
			break;
	//----------------------------------------

	//-----/ Handlers /-----------------------
	new ret;
	for(new i; i<CallbacksIndex[Handler]; i++)
		if((ret = CallLocalFunction(Callbacks[Handler][i],"")) == 1)
			break;
	//----------------------------------------

  [Functions]
	AddModule(modulename[])
	InitializeModules()

	AddHandler(modulename[],callback,priority=MODULE_DEFAULT_PRIORITY) // a lower number has a higher priority (= will be executed first)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Module
	#endinput
#endif
#define _MDPWN_Module



//-----/ Defines /
	//--/ SA-MP Default Handlers /
#define InitHandler					0
#define ExitHandler					1
#define InConnectionHandler			2
#define RconCommandHandler			3
#define RconLoginHandler			4
#define ConnectHandler				5
#define DisconnectHandler			6
#define RequestClassHandler			7
#define RequestSpawnHandler			8
#define SpawnHandler				9
#define DeathHandler				10
#define TextHandler					11
#define CommandHandler				12
#define UpdateHandler				13
#define DialogHandler				14
#define KeyHandler					15
#define StateHandler				16
#define InteriorHandler				17
#define PickUpHandler				18
#define SelectObjectHandler			19
#define GiveDamageHandler			20
#define TakeDamageHandler			21
#define WeaponShotHandler			22
#define EnterVehicleHandler			23
#define ExitVehicleHandler			24
#define EnterCPHandler				25
#define LeaveCPHandler				26
#define EnterRCPHandler				27
#define LeaveRCPHandler				28
#define EditObjectHandler			29
#define EditAObjectHandler			30
#define ClickTDHandler				31
#define ClickPTDHandler				32
#define ClickMapHandler				33
#define ClickPlayerHandler			34
#define StreamInHandler				35
#define StreamOutHandler			36
#define ObjectMovedHandler			37
#define PObjectMovedHandler			38
#define VehicleSpawnHandler			39
#define VehicleDeathHandler			40
#define VStreamInHandler			41
#define VStreamOutHandler			42
#define VehicleDamageHandler		43
#define UnocVehicleHandler			44
#define TrailerHandler				45
#define ModHandler					46
#define PaintjobHandler				47
#define ResprayHandler				48
#define ModShopHandler				49
	//--/ Plug-in Handlers /
#define DObjectMovedHandler			50
#define EditDObjectHandler			51
#define SelectDObjectHandler		52
#define ShootDObjectHandler			53
#define PickUpDPHandler				54
#define EnterDCPHandler				55
#define LeaveDCPHandler				56
#define EnterDRCPHandler			57
#define LeaveDRCPHandler			58
#define EnterDAreaHandler			59
#define LeaveDAreaHandler			60
	//--/ Modules /
#define MAX_MODULES					128
#define MAX_CALLBACKS				61

#define MODULE_DEFAULT_PRIORITY		5



//-----/ News /
new
	ModuleName[MAX_MODULES][16],
	ModuleIndex,
	Callbacks[MAX_CALLBACKS][MAX_MODULES][64],
	CallbacksPriority[MAX_CALLBACKS][MAX_MODULES],
	CallbacksIndex[MAX_CALLBACKS],
	HandlerNames[MAX_CALLBACKS][32] = {
		"InitHandler", // 0
		"ExitHandler",
		"InConnectionHandler",
		"RconCommandHandler",
		"RconLoginHandler",
		"ConnectHandler",
		"DisconnectHandler",
		"RequestClassHandler",
		"RequestSpawnHandler",
		"SpawnHandler",
		"DeathHandler", // 10
		"TextHandler",
		"CommandHandler",
		"UpdateHandler",
		"DialogHandler",
		"KeyHandler",
		"StateHandler",
		"InteriorHandler",
		"PickUpHandler",
		"SelectObjectHandler",
		"GiveDamageHandler", // 20
		"TakeDamageHandler",
		"WeaponShotHandler",
		"EnterVehicleHandler",
		"ExitVehicleHandler",
		"EnterCPHandler",
		"LeaveCPHandler",
		"EnterRCPHandler",
		"LeaveRCPHandler",
		"EditObjectHandler",
		"EditAObjectHandler", // 30
		"ClickTDHandler",
		"ClickPTDHandler",
		"ClickMapHandler",
		"ClickPlayerHandler",
		"StreamInHandler",
		"StreamOutHandler",
		"ObjectMovedHandler",
		"PObjectMovedHandler",
		"VehicleSpawnHandler",
		"VehicleDeathHandler", // 40
		"VStreamInHandler",
		"VStreamOutHandler",
		"VehicleDamageHandler",
		"UnocVehicleHandler",
		"TrailerHandler",
		"ModHandler",
		"PaintjobHandler",
		"ResprayHandler",
		"ModShopHandler",
		//-----
		"DObjectMovedHandler", // 50
		"EditDObjectHandler",
		"SelectDObjectHandler",
		"ShootDObjectHandler",
		"PickUpDPHandler",
		"EnterDCPHandler",
		"LeaveDCPHandler",
		"EnterDRCPHandler",
		"LeaveDRCPHandler",
		"EnterDAreaHandler",
		"LeaveDAreaHandler" // 60
	}
;





//==========/ Module Functions /================================================
//-----/ AddModule /------------------------------------------------------------
stock AddModule(modulename[])
{
	strcpy(ModuleName[ModuleIndex++],modulename);
	return 1;
}
//-----/ InitializeModules /----------------------------------------------------
stock InitializeModules()
{
	new string[64];
	for(new i; i<ModuleIndex; i++)
	{
		format(string,sizeof(string),"AddHandler_%s",ModuleName[i]);
		CallLocalFunction(string,"");
	}
}
//-----/ AddHandler /----------------------------------------------------------
stock AddHandler(modulename[],callback,priority=MODULE_DEFAULT_PRIORITY)
{
	new string[64];
	new idx = CallbacksIndex[callback]++;
	format(string,sizeof(string),"%s_%s",HandlerNames[callback],modulename);
	//-----
	// Insertion Sort
	new i;
	for(i=idx-1; i>=0; i--)
	{
		if(CallbacksPriority[callback][i] <= priority)
			break;
		strcpy(Callbacks[callback][i+1],Callbacks[callback][i]);
		CallbacksPriority[callback][i+1] = CallbacksPriority[callback][i];
	}
	strcpy(Callbacks[callback][i+1],string);
	CallbacksPriority[callback][i+1] = priority;
	return 1;
}