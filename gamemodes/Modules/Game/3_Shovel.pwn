/*
  [Functions]
	Function
*/

//-----/ Pre-Processing /
#if defined _MDPWN_3_Shovel
	#endinput
#endif
#define _MDPWN_3_Shovel

//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1

//-----/ News /
	//--/ 3_Shovel /
new Float:SpawnPos[80][3] = {
	{922.9623, -1136.6386, 243.3506},
	{952.8538, -1114.7604, 242.8305},
	{955.5449, -1112.8409, 242.9382},
	{955.7282, -1114.6528, 242.9136},
	{955.6218, -1117.4144, 242.8141},
	{955.4597, -1121.6209, 242.57},
	{955.2689, -1126.5743, 242.3484},
	{955.088, -1131.2708, 242.4362},
	{954.9071, -1135.9667, 242.5334},
	{954.7191, -1140.8471, 242.7156},
	{954.564, -1144.8725, 242.6336},
	{954.4016, -1149.0832, 242.6208},
	{954.2387, -1153.3077, 242.7917},
	{951.2573, -1156.4861, 242.8636},
	{950.9174, -1151.0496, 242.9273},
	{950.6425, -1146.654, 242.6997},
	{950.351, -1141.991, 242.2478},
	{950.1173, -1138.2586, 242.0328},
	{949.9318, -1135.2902, 241.8448},
	{949.6845, -1131.3344, 241.8542},
	{949.3956, -1126.7148, 242.5054},
	{949.093, -1121.8776, 243.6044},
	{950.653, -1114.6238, 242.8038},
	{950.5615, -1113.1624, 242.7687},
	{945.4105, -1111.1468, 242.5175},
	{945.5114, -1131.2892, 241.4208},
	{945.6696, -1137.1135, 241.3224},
	{945.8068, -1142.1784, 242.2568},
	{945.9421, -1147.1653, 243.6195},
	{946.228, -1157.7044, 242.9888},
	{942.2686, -1156.9777, 243.6936},
	{942.304, -1145.6669, 243.5218},
	{942.3209, -1140.3042, 241.7364},
	{942.3438, -1133.089, 240.9846},
	{942.1473, -1116.3262, 244.4904},
	{941.9578, -1111.664, 242.6389},
	{932.7551, -1112.0724, 242.4196},
	{932.4893, -1116.4688, 242.1244},
	{932.2572, -1120.3063, 241.8786},
	{931.9909, -1124.7093, 241.4309},
	{928.7465, -1123.8842, 241.8088},
	{929.0963, -1120.4603, 242.1903},
	{929.5606, -1116.3501, 242.4273},
	{930.0252, -1112.2383, 242.5567},
	{925.2089, -1111.868, 242.916},
	{925.4564, -1116.9153, 243.3578},
	{925.6898, -1121.6727, 242.9526},
	{925.9849, -1127.6913, 241.667},
	{926.2706, -1133.5181, 240.8229},
	{926.6276, -1140.7952, 240.5034},
	{926.8494, -1145.3157, 241.1351},
	{927.0819, -1150.0575, 242.0494},
	{927.2816, -1154.1341, 242.755},
	{921.4035, -1154.9668, 242.7723},
	{921.3729, -1151.0364, 242.6325},
	{921.3375, -1146.508, 241.9911},
	{921.3023, -1141.986, 241.179},
	{921.2667, -1137.4081, 240.8404},
	{921.2346, -1133.2859, 241.1432},
	{921.1992, -1128.7779, 241.882},
	{921.1682, -1124.7907, 242.9163},
	{921.0692, -1112.1274, 243.0211},
	{916.8145, -1111.4585, 242.8128},
	{915.9926, -1114.9255, 243.1553},
	{915.6981, -1119.496, 243.5151},
	{915.5244, -1124.0087, 243.3928},
	{915.3599, -1128.2846, 242.9284},
	{915.1751, -1133.0837, 242.3213},
	{914.999, -1137.6603, 242.0926},
	{914.8479, -1141.5806, 242.3634},
	{914.7274, -1144.7128, 242.9705},
	{909.2631, -1157.0085, 244.0428},
	{910.3624, -1145.8655, 243.4671},
	{910.6505, -1142.2581, 242.9683},
	{909.6458, -1137.8387, 243.0534},
	{910.4276, -1132.6506, 243.2277},
	{910.4406, -1128.5164, 243.481},
	{910.4556, -1123.683, 243.3354},
	{910.4697, -1119.1193, 243.0151},
	{910.4838, -1114.5527, 242.8809}
};

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_3_Shovel();
forward InitHandler_3_Shovel();
forward SpawnHandler_3_Shovel(playerid);
forward CommandHandler_3_Shovel(playerid,cmdtext[]);
	//--/ Functions /


//==========/ Callback Functions /==============================================
//-----/ AddHandler_1_Run /-----------------------------------------------------
public AddHandler_3_Shovel()
{
	AddHandler("3_Shovel",InitHandler);
	AddHandler("3_Shovel",SpawnHandler);
	AddHandler("3_Shovel",CommandHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}

//-----/ InitHandler_3_Shovel /----------------------------------------------------
public InitHandler_3_Shovel()
{
	CreateDynamicObject(13603, 932.3099, -1134.5492, 235.6068, 0.0, 0.0, 0.0, 3);
	CreateDynamicObject(18248, 929.7824, -1141.7442, 247.7178, 0.0, 0.0, 0.0, 3);
	CreateDynamicObject(1358, 955.9492, -1158.5013, 243.1687, 0.0, 0.0, 0.0, 3);
	CreateDynamicObject(1225, 942.1812, -1121.2714, 245.2709, 0.0, 0.0, 0.0, 3);
	CreateDynamicObject(1225, 937.9542, -1152.9871, 244.1013, 0.0, 0.0, 0.0, 3);
	CreateDynamicObject(1225, 914.0863, -1153.3117, 244.3349, 0.0, 0.0, 0.0, 3);
	CreateDynamicObject(1225, 920.7824, -1120.1109, 243.2814, 0.0, 0.0, 0.0, 3);
	CreateDynamicObject(2228, 938.607, -1120.4014, 244.3638, 0.0, 329.9197, 7.7348, 3);
	CreateDynamicObject(2228, 950.0527, -1134.7314, 241.3166, 0.0, 13.751, 19.767, 3);
	CreateDynamicObject(2228, 924.6691, -1129.8877, 240.8093, 0.0, 22.3453, 226.9506, 3);
	CreateDynamicObject(2228, 917.2043, -1118.0552, 242.9745, 9.4538, 0.0, 10.3131, 3);
	CreateDynamicObject(2228, 912.772, -1146.7524, 243.1731, 346.2489, 0.0, 0.0, 3);
	CreateDynamicObject(2228, 928.9961, -1150.3759, 241.6708, 9.4538, 0.0, 0.0, 3);
	CreateDynamicObject(2228, 946.7438, -1152.487, 243.153, 8.5944, 0.0, 326.25, 3);
	AddStaticPickup(1242, 2, 933.5089, -1142.271, 250.1669, 3);
	AddStaticPickup(351, 2, 935.5422, -1131.6376, 248.0215, 3);
}
//-----/ SpawnHandler_3_Shovel /---------------------------------------------------
public SpawnHandler_3_Shovel(playerid)
{
	if(GetPlayerMap(playerid) == 3)
	{
	    ClearChatting(playerid);
		if(GetPlayerLanguage(playerid) == 0)
		{
		    SendClientMessage(playerid,COLOR_GREEN,"          돌아온 시발모드 : 삽 대전");
		    SendClientMessage(playerid,COLOR_WHITE,"당신은 삽질을 하던 도중 광기에 둘러쌓인 노동자들을 발견합니다.");
		    SendClientMessage(playerid,COLOR_WHITE,"이 지옥같은 곳에서 살아남는 방법은 다른 사람들을 죽이는 것 뿐입니다.");
		    SendClientMessage(playerid,COLOR_WHITE,"포크레인 위를 잘 찾아보면 좋은 물건을 얻을 수 있을지도..?");
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREEN,"          Fuck Mode Returned: Shovel DM");
		    SendClientMessage(playerid,COLOR_WHITE,"You have found workers surrounded by madness while shoveling.");
		    SendClientMessage(playerid,COLOR_WHITE,"The only way to survive in this hell is to kill others.");
		    SendClientMessage(playerid,COLOR_WHITE,"If you look up the forklane well, you may get something good..");
		}
		//-----
		SetPlayerVirtualWorld(playerid, 3);
		SetPlayerInterior(playerid, 0);
        SetPlayerColor(playerid,COLOR_GREY);
        SetPlayerHealth(playerid, 20.0);
        SetPlayerArmour(playerid, 0.0);
        SetPlayerWorldBounds(playerid,958.0458, 906.5814, -1108.8313, -1160.3292);
        SetPlayerTime(playerid, 12, 0);
        SetPlayerWeather(playerid, 0);
        ResetPlayerWeapons(playerid);
        GivePlayerWeapon(playerid, 6, 1);
        SetPlayerSkin(playerid,GetPVarInt(playerid,"Skin"));
        
        new rand = random(80);
        SetPlayerPos(playerid, SpawnPos[rand][0], SpawnPos[rand][1], SpawnPos[rand][2]);
        FreezePlayer(playerid, 2);
	}
}
//-----/ CommandHandler_3_Shovel /---------------------------------------------------
public CommandHandler_3_Shovel(playerid,cmdtext[]) //return 1: processed
{
	if(GetPlayerMap(playerid) == 2)
	{
		if(!strcmp("/help",cmdtext) || !strcmp("/도움말",cmdtext) || !strcmp("/?",cmdtext))
		{
			if(GetPlayerLanguage(playerid) == 0)
				SendClientMessage(playerid,COLOR_WHITE,"* 이 맵은 도움말이 없습니다.");
			else
				SendClientMessage(playerid,COLOR_WHITE,"* This map has no help message.");
			return 1;
		}
	}
	return 0;
}
//==========/ Functions /=======================================================
