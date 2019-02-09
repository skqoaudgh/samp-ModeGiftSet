/*
  [Functions]
	Function
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Object
	#endinput
#endif
#define _MDPWN_Object

//-----/ News /
new ignoreRemoveBuilding[MAX_PLAYERS];

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Object();
forward InitHandler_Object();
forward ConnectHandler_Object(playerid);
	//--/ Functions /





//==========/ Callback Functions /==============================================
//-----/ AddHandler_Object /----------------------------------------------------
public AddHandler_Object()
{
	AddHandler("Object",InitHandler);
	AddHandler("Object",ConnectHandler);
}
//-----/ InitHandler_Object /---------------------------------------------------
public InitHandler_Object()
{
    new name[MAX_PLAYER_NAME];
    for (new i = 0; i < MAX_PLAYERS; ++i)
    {
        if(GetPlayerName(i, name, sizeof(name)))
			ignoreRemoveBuilding[i] = 1;
    }
}
//-----/ ConnectHandler_Object /------------------------------------------------
public ConnectHandler_Object(playerid)
{
    if(ignoreRemoveBuilding[playerid] == 0)
    {
		RemoveBuildingForPlayer(playerid, 713, 1457.9375, -1620.6953, 13.4531, 1.00);
		RemoveBuildingForPlayer(playerid, 1280, 1479.4688, -1626.0234, 13.4531, 1.00);
		RemoveBuildingForPlayer(playerid, 1229, 1466.4844, -1598.0938, 14.1094, 1.00);
		RemoveBuildingForPlayer(playerid, 1226, 1471.3516, -1596.7031, 16.4219, 1.00);
		RemoveBuildingForPlayer(playerid, 1226, 1488.5313, -1596.7031, 16.4219, 1.00);
		RemoveBuildingForPlayer(playerid, 1229, 1498.0547, -1598.0938, 14.1094, 1.00);
		RemoveBuildingForPlayer(playerid, 620, 1503.1875, -1621.1250, 11.8359, 1.00);
		RemoveBuildingForPlayer(playerid, 673, 1501.2813, -1624.5781, 12.3984, 1.00);
		RemoveBuildingForPlayer(playerid, 673, 1498.3594, -1616.9688, 12.3984, 1.00);
    }
    else
		ignoreRemoveBuilding[playerid] = 0;
}
