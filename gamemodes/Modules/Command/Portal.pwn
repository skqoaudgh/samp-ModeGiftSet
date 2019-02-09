/*
  [Functions]
	Function
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Portal
	#endinput
#endif
#define _MDPWN_Portal



//-----/ Includes /



//-----/ Defines /
//#define DialogID_Portal(%1)			10000 + %1
//#define VirtualID_Portal(%1)			10000 + %1



//-----/ News /
	//--/  /



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Portal();
	//--/ Functions /





//==========/ Callback Functions /==============================================
//-----/ AddHandler_Portal /-------------------------------------------------------
public AddHandler_Portal()
{
	//AddHandler("Portal",InitHandler);
	//AddTimer("Portal",TIMER_1S_PLAYER);
}
//-----/  /---------------------------------------------------------------------
/*
public TimerHandler_Portal() //return 1;
public TimerHandler_Portal_P(playerid) //return 1;
public InitHandler_Portal()
public ExitHandler_Portal()
public InConnectionHandler_Portal(playerid,ip_address[],port)
public RconCommandHandler_Portal(cmd[]) //return 1: processed
public RconLoginHandler_Portal(ip[],password[],success)
public ConnectHandler_Portal(playerid)
public DisconnectHandler_Portal(playerid,reason)
public RequestClassHandler_Portal(playerid,classid) //return 0: prevent spawn button
public RequestSpawnHandler_Portal(playerid) //return 0: prevent spawning
public SpawnHandler_Portal(playerid)
public DeathHandler_Portal(playerid,killerid,reason)
public TextHandler_Portal(playerid,text) //return 0: not sent
public CommandHandler_Portal(playerid,cmdtext[]) //return 1: processed
public UpdateHandler_Portal(playerid)
public DialogHandler_Portal(playerid,dialogid,response,listitem,inputtext[]) //return 1: processed
public KeyHandler_Portal(playerid,newkeys,oldkeys)
public StateHandler_Portal(playerid,newstate,oldstate)
public InteriorHandler_Portal(playerid,newinteriorid,oldinteriorid)
public PickUpHandler_Portal(playerid,pickupid)
public SelectObjectHandler_Portal(playerid,type,objectid,modelid,Float:fX,Float:fY,Float:fZ)
public GiveDamageHandler_Portal(playerid,damagedid,Float:amount,weaponid,bodypart)
public TakeDamageHandler_Portal(playerid,issuerid,Float:amount,weaponid,bodypart)
public WeaponShotHandler_Portal(playerid,weaponid,hittype,hitid,Float:fX,Float:fY,Float:fZ) //return 1;
public EnterVehicleHandler_Portal(playerid,vehicleid,ispassenger)
public ExitVehicleHandler_Portal(playerid,vehicleid)
public EnterCPHandler_Portal(playerid)
public LeaveCPHandler_Portal(playerid)
public EnterRCPHandler_Portal(playerid)
public LeaveRCPHandler_Portal(playerid)
public EditObjectHandler_Portal(playerid,playerobject,objectid,response,Float:fX,Float:fY,Float:fZ,Float:fRotX,Float:fRotY,Float:fRotZ)
public EditAObjectHandler_Portal(playerid,response,index,modelid,boneid,Float:fOffsetX,Float:fOffsetY,Float:fOffsetZ,Float:fRotX,Float:fRotY,Float:fRotZ,Float:fScaleX,Float:fScaleY,Float:fScaleZ)
public ClickTDHandler_Portal(playerid,Text:clickedid)
public ClickPTDHandler_Portal(playerid,PlayerText:playertextid)
public ClickMapHandler_Portal(playerid,Float:fX,Float:fY,Float:fZ)
public ClickPlayerHandler_Portal(playerid,clickedplayerid,source)
public StreamInHandler_Portal(playerid,forplayerid)
public StreamOutHandler_Portal(playerid,forplayerid)
public ObjectMovedHandler_Portal(objectid)
public PObjectMovedHandler_Portal(playerid,objectid)
public VehicleSpawnHandler_Portal(vehicleid)
public VehicleDeathHandler_Portal(vehicleid,killerid)
public VStreamInHandler_Portal(vehicleid,forplayerid)
public VStreamOutHandler_Portal(vehicleid,forplayerid)
public VehicleDamageHandler_Portal(vehicleid,playerid)
public UnocVehicleHandler_Portal(vehicleid,playerid,passenger_seat,Float:new_x,Float:new_y,Float:new_z,Float:vel_x,Float:vel_y,Float:vel_z)
public TrailerHandler_Portal(playerid,vehicleid)
public ModHandler_Portal(playerid,vehicleid,componentid)
public PaintjobHandler_Portal(playerid,vehicleid,paintjobid)
public ResprayHandler_Portal(playerid,vehicleid,color1,color2)
public ModShopHandler_Portal(playerid,enterexit,interiorid)
public HttpResponse_Portal(index,response_code,data[]) //HTTP(idx,HTTP_GET,"URL","POST","HttpResponse_Portal");

public DObjectMovedHandler_Portal(objectid)
public EditDObjectHandler_Portal(playerid,objectid,response,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
public SelectDObjectHandler_Portal(playerid,objectid,modelid,Float:x,Float:y,Float:z)
public ShootDObjectHandler_Portal(playerid,weaponid,objectid,Float:x,Float:y,Float:z)
public PickUpDPHandler_Portal(playerid,pickupid)
public EnterDCPHandler_Portal(playerid,checkpointid)
public LeaveDCPHandler_Portal(playerid,checkpointid)
public EnterDRCPHandler_Portal(playerid,checkpointid)
public LeaveDRCPHandler_Portal(playerid,checkpointid)
public EnterDAreaHandler_Portal(playerid,areaid)
public LeaveDAreaHandler_Portal(playerid,areaid)
*/





//==========/ Functions /=======================================================
//-----/ CreatePortal /---------------------------------------------------------
stock CreatePortal(text[],Float:x,Float:y,Float:z,interior,virtualworld)
{
	new obj;
	obj = CreateDynamicObject(19604, x, y, z+3.89, 90.0000, 0.0000, 0.0000, virtualworld, interior);
	SetDynamicObjectMaterial(obj,0,19604,"waterplane2","waterclear256",0xFFFF00FF);
	obj = CreateDynamicObject(18762, x-3.0, y, z+1.49, 0.0000, 0.0000, 0.0000, virtualworld, interior);
	SetDynamicObjectMaterial(obj, 0, 9362, "sfn_byofficeint", "CJ_Black_metal", 0xFFFFFFFF);
	obj = CreateDynamicObject(18762, x-3.0, y, z+6.49, 0.0000, 0.0000, 0.0000, virtualworld, interior);
	SetDynamicObjectMaterial(obj, 0, 9362, "sfn_byofficeint", "CJ_Black_metal", 0xFFFFFFFF);
	obj = CreateDynamicObject(18762, x+3.0, y, z+1.49, 0.0000, 0.0000, 0.0000, virtualworld, interior);
	SetDynamicObjectMaterial(obj, 0, 9362, "sfn_byofficeint", "CJ_Black_metal", 0xFFFFFFFF);
	obj = CreateDynamicObject(18762, x+3.0, y, z+6.49, 0.0000, 0.0000, 0.0000, virtualworld, interior);
	SetDynamicObjectMaterial(obj, 0, 9362, "sfn_byofficeint", "CJ_Black_metal", 0xFFFFFFFF);
	obj = CreateDynamicObject(18762, x, y, z+8.491, 0.0000, 90.0000, 0.0000, virtualworld, interior);
	SetDynamicObjectMaterial(obj, 0, 9362, "sfn_byofficeint", "CJ_Black_metal", 0xFFFFFFFF);
	obj = CreateDynamicObject(18762, x, y, z-1.11, 0.0000, 90.0000, 0.0000, virtualworld, interior);
	SetDynamicObjectMaterial(obj, 0, 9362, "sfn_byofficeint", "CJ_Black_metal", 0xFFFFFFFF);
	
	CreateDynamic3DTextLabel(text,COLOR_PASTEL_YELLOW,x,y,z+1.0,50.0,.worldid=virtualworld,.interiorid=interior);
}
