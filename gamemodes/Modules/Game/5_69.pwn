/*
  [Functions]
	SwitchInterval(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_5_69
	#endinput
#endif
#define _MDPWN_5_69

//-----/ News /
	//--/ 69 /
new _GoalPickup;
new _Goal[MAX_PLAYERS];

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_5_69();
forward InitHandler_5_69();
forward SpawnHandler_5_69(playerid);
forward CommandHandler_5_69(playerid,cmdtext[]);
forward PickUpHandler_5_69(playerid,pickupid);
	//--/ Functions /
forward Boom_A();
forward Boom_B();
forward Boom_C();


//==========/ Callback Functions /==============================================
//-----/ AddHandler_5_69 /------------------------------------------------------
public AddHandler_5_69()
{
	AddHandler("5_69",InitHandler);
	AddHandler("5_69",SpawnHandler);
	AddHandler("5_69",CommandHandler);
	AddHandler("5_69",PickUpHandler);
}

//-----/ InitHandler_5_69 /----------------------------------------------------
public InitHandler_5_69()
{
	SetTimer("Boom_A", 4000, true);
	SetTimer("Boom_B", 3000, true);
	SetTimer("Boom_C", 2000, true);
	
	_GoalPickup = CreatePickup(19605,1,-1657.5291,-164.8431,14.1484,5);
	
	begin = AddStaticVehicleEx(511, -1657.6016, -164.8854, 13.8088, 316.0, -1, -1, 1);
	AddStaticVehicleEx(593, -1194.5156, -276.262, 13.8088, 44.0, -1, -1, 1);
	AddStaticVehicleEx(476, -1177.4062, -259.4709, 13.8088, 44.0, -1, -1, 1);
	AddStaticVehicleEx(520, -1160.6009, -242.7308, 13.8043, 44.0, -1, -1, 1);
	AddStaticVehicleEx(581, 981.5781, 2173.4084, 3210.5085, 226.0, -1, -1, 1);
	AddStaticVehicleEx(581, 984.3682, 2176.1547, 3210.5136, 226.0, -1, -1, 1);
	AddStaticVehicleEx(581, 987.3262, 2179.0061, 3210.5263, 226.0, -1, -1, 1);
	AddStaticVehicleEx(521, 990.0021, 2181.5495, 3210.5417, 226.0, -1, -1, 1);
	AddStaticVehicleEx(521, 992.8729, 2184.4108, 3210.5429, 226.0, -1, -1, 1);
	AddStaticVehicleEx(521, 995.7144, 2187.4355, 3210.5214, 226.0, -1, -1, 1);
	AddStaticVehicleEx(522, 998.4688, 2190.1442, 3210.5268, 226.0, -1, -1, 1);
	AddStaticVehicleEx(522, 1001.4136, 2192.9738, 3210.5402, 226.0, -1, -1, 1);
	AddStaticVehicleEx(522, 1004.3144, 2195.8627, 3210.5417, 226.0, -1, -1, 1);
	AddStaticVehicleEx(463, 1006.8858, 2198.4472, 3210.5402, 226.0, -1, -1, 1);
	AddStaticVehicleEx(463, 1009.7432, 2201.3986, 3210.529, 226.0, -1, -1, 1);
	AddStaticVehicleEx(463, 1012.796, 2204.28, 3210.5493, 226.0, -1, -1, 1);
	AddStaticVehicleEx(468, 1016.627, 2200.6618, 3210.5051, 226.0, -1, -1, 1);
	AddStaticVehicleEx(468, 1013.9468, 2197.8996, 3210.5146, 226.0, -1, -1, 1);
	AddStaticVehicleEx(468, 1011.197, 2195.0356, 3210.528, 226.0, -1, -1, 1);
	AddStaticVehicleEx(462, 1008.2973, 2192.0136, 3210.5424, 226.0, -1, -1, 1);
	AddStaticVehicleEx(462, 1005.4738, 2189.5183, 3210.5039, 226.0, -1, -1, 1);
	AddStaticVehicleEx(462, 1002.9033, 2186.3647, 3210.5725, 226.0, -1, -1, 1);
	AddStaticVehicleEx(448, 999.8851, 2183.6188, 3210.5405, 226.0, -1, -1, 1);
	AddStaticVehicleEx(448, 996.9948, 2180.863, 3210.5246, 226.0, -1, -1, 1);
	AddStaticVehicleEx(448, 994.1239, 2177.9907, 3210.5249, 226.0, -1, -1, 1);
	AddStaticVehicleEx(481, 991.3609, 2175.2233, 3210.5253, 226.0, -1, -1, 1);
	AddStaticVehicleEx(509, 988.5476, 2172.2966, 3210.5388, 226.0, -1, -1, 1);
	AddStaticVehicleEx(510, 985.736, 2169.55, 3210.531, 226.0, -1, -1, 1);
	AddStaticVehicleEx(451, 992.7526, 2166.7097, 3210.5268, 316.0, -1, -1, 1);
	AddStaticVehicleEx(518, 995.528, 2163.9895, 3210.5332, 316.0, -1, -1, 1);
	AddStaticVehicleEx(419, 998.3694, 2161.0761, 3210.5249, 316.0, -1, -1, 1);
	AddStaticVehicleEx(474, 1001.2266, 2158.4682, 3210.5541, 316.0, -1, -1, 1);
	AddStaticVehicleEx(580, 1004.0371, 2155.4394, 3210.5285, 316.0, -1, -1, 1);
	AddStaticVehicleEx(491, 1006.9315, 2152.7988, 3210.5583, 316.0, -1, -1, 1);
	AddStaticVehicleEx(528, 1009.6503, 2150.1523, 3210.5668, 316.0, -1, -1, 1);
	AddStaticVehicleEx(598, 988.3936, 2162.2253, 3210.4997, 316.0, -1, -1, 1);
	AddStaticVehicleEx(420, 991.2266, 2159.4555, 3210.507, 316.0, -1, -1, 1);
	AddStaticVehicleEx(535, 993.9091, 2156.5644, 3210.4826, 316.0, -1, -1, 1);
	AddStaticVehicleEx(506, 996.6306, 2153.8027, 3210.4777, 316.0, -1, -1, 1);
	AddStaticVehicleEx(494, 999.5298, 2150.9782, 3210.4865, 316.0, -1, -1, 1);
	AddStaticVehicleEx(587, 1002.3187, 2148.2355, 3210.4919, 316.0, -1, -1, 1);
	AddStaticVehicleEx(402, 1004.9355, 2145.4062, 3210.467, 316.0, -1, -1, 1);
	AddStaticVehicleEx(602, 1012.8022, 2147.3349, 3210.549, 316.0, -1, -1, 1);
	AddStaticVehicleEx(545, 1008.1353, 2142.3906, 3210.2873, 316.0, -1, -1, 1);
	AddStaticVehicleEx(431, 1036.6181, 2171.0168, 3210.5214, 135.0, -1, -1, 1);
	AddStaticVehicleEx(544, 1031.0386, 2176.675, 3210.5122, 135.0, -1, -1, 1);
	AddStaticVehicleEx(443, 1025.4819, 2182.1599, 3210.5207, 135.0, -1, -1, 1);
	AddStaticVehicleEx(532, 1019.9791, 2187.9555, 3210.4863, 135.0, -1, -1, 1);
	AddStaticVehicleEx(578, 1042.3037, 2165.2016, 3210.2656, 135.0, -1, -1, 1);
	AddStaticVehicleEx(571, 1033.4869, 2162.0993, 3210.5832, 135.0, -1, -1, 1);
	AddStaticVehicleEx(530, 1030.588, 2165.0241, 3210.5803, 135.0, -1, -1, 1);
	AddStaticVehicleEx(457, 1028.0267, 2167.7636, 3210.5593, 135.0, -1, -1, 1);
	AddStaticVehicleEx(485, 1025.1007, 2170.4982, 3210.5817, 135.0, -1, -1, 1);
	AddStaticVehicleEx(531, 1022.4515, 2173.2993, 3210.5639, 135.0, -1, -1, 1);
	AddStaticVehicleEx(573, 1019.3588, 2176.3977, 3210.5632, 135.0, -1, -1, 1);
	AddStaticVehicleEx(424, 1016.5935, 2179.1359, 3210.5664, 135.0, -1, -1, 1);
	end = AddStaticVehicleEx(568, 1013.9102, 2181.7753, 3210.5715, 135.0, -1, -1, 1);
	for(new i=begin; i<=end; i++)
	    SetVehicleVirtualWorld(i, 5);
	    
	CreateDynamicObject(8356, -987.3019, 505.644, 24.5194, 13.751, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -896.922, 596.0316, 78.7168, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -959.5386, 533.3957, 35.3922, 18.0482, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -779.4845, 713.4689, 165.1938, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -661.9882, 830.9498, 251.7134, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -544.5135, 948.4216, 338.2417, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -427.0781, 1065.8577, 424.7129, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -309.5309, 1183.394, 511.2695, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -192.0039, 1300.9212, 597.8133, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, -74.4659, 1418.4479, 684.3493, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 43.0157, 1535.9077, 770.8437, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 160.4418, 1653.3106, 857.2943, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 284.9896, 1777.8598, 889.3732, 353.1245, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 407.8628, 1900.7426, 921.4352, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 332.5093, 1825.4141, 873.522, 15.4699, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 525.378, 2018.2432, 1007.9446, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 642.8764, 2135.7478, 1094.4552, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 760.3105, 2253.1901, 1180.9317, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 877.7439, 2370.6108, 1267.3778, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 995.2376, 2488.0969, 1353.8774, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 1112.5858, 2605.4411, 1440.2814, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 1236.5609, 2729.4248, 1500.3354, 10.3131, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 1366.9234, 2859.7949, 1533.901, 10.3131, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 1490.4797, 2983.3496, 1593.6756, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 1607.8472, 3100.715, 1680.123, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 1725.3068, 3218.164, 1766.6159, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 1842.7781, 3335.6357, 1853.1069, 27.502, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 1966.3466, 3542.3, 1917.5069, 27.502, 0.0, 45.0, 5);
	CreateDynamicObject(8356, 1841.316, 3563.0668, 1960.8059, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(8356, 1709.1662, 3430.9423, 1960.8121, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(8356, 1576.7346, 3298.5241, 1960.8126, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(8356, 1444.6866, 3166.5004, 1960.7912, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(8356, 1314.3267, 3036.1638, 1937.1882, 345.3895, 0.0, 135.0, 5);
	CreateDynamicObject(8356, 1305.4252, 2923.0458, 1919.9113, 0.0, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 1434.3215, 2794.1452, 1940.3037, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 1577.7615, 2679.2575, 1982.1535, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 1462.6054, 2822.3996, 1940.3223, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 1335.4565, 2949.385, 1889.2155, 18.9076, 0.0, 225.0, 5);
	CreateDynamicObject(11435, 1403.9155, 2853.7883, 1930.3105, 0.0, 0.0, 45.0, 5);
	CreateDynamicObject(8356, 1706.0343, 2550.9755, 2023.6805, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 1835.0284, 2421.9792, 2065.4367, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 1963.5366, 2293.5026, 2107.0505, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2092.4704, 2164.5732, 2148.7937, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2178.8537, 1992.936, 2190.7402, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2206.9726, 2021.1984, 2190.7827, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(4818, 2176.5402, 2108.6516, 2179.1674, 0.0, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 2165.2687, 1979.265, 2190.7575, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(4818, 2120.4946, 2052.5837, 2179.143, 0.0, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 2036.4418, 2108.0874, 2149.1081, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2314.2145, 1872.4696, 2232.1369, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(11435, 1240.1253, 2989.0329, 1924.5491, 0.0, 0.0, 45.0, 5);
	CreateDynamicObject(11435, 1907.2779, 3628.3635, 1965.5324, 0.0, 0.0, 315.0, 5);
	CreateDynamicObject(16776, 1972.6284, 2153.9169, 2130.5903, 0.0, 12.8915, 135.0, 5);
	CreateDynamicObject(16776, 1265.9575, 2999.468, 1859.4284, 0.0, 19.767, 135.0, 5);
	CreateDynamicObject(8356, 2443.0673, 1743.566, 2273.8596, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2572.0117, 1614.6352, 2315.6062, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2700.9755, 1485.6723, 2357.3469, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2829.2055, 1357.4411, 2398.9128, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2958.0112, 1228.6297, 2440.5981, 12.8915, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2984.5556, 1097.7772, 2461.52, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(8356, 2852.1191, 965.3836, 2461.5529, 0.0, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 2719.8549, 833.1068, 2461.5961, 0.0, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 2594.3693, 707.6362, 2502.0937, 334.2168, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 2680.3085, 793.5278, 2456.6015, 348.8273, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 2468.4638, 685.9801, 2542.8774, 0.0, 0.0, 225.0, 5);
	CreateDynamicObject(8356, 2440.6169, 553.8626, 2542.8591, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(11435, 2523.1215, 631.5544, 2547.1904, 0.0, 0.0, 225.0, 5);
	CreateDynamicObject(11435, 2378.5312, 489.9027, 2547.5366, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(8356, 2308.4357, 581.7775, 2542.8457, 0.0, 0.0, 45.0, 5);
	CreateDynamicObject(8356, 2217.7551, 672.4796, 2577.8432, 43.8312, 0.0, 45.0, 5);
	CreateDynamicObject(8356, 2258.6938, 631.5198, 2531.9365, 30.0802, 0.0, 45.0, 5);
	CreateDynamicObject(11435, 3036.3891, 1151.3103, 2465.2465, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(4818, 1828.2946, 3349.1914, 1856.5306, 0.0, 332.4979, 45.0, 5);
	CreateDynamicObject(11435, 1182.9093, 2675.0314, 1491.0576, 0.0, 0.0, 315.0, 5);
	CreateDynamicObject(8356, 2339.81, 814.6298, 2573.2722, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(8356, 2214.6057, 939.8345, 2633.9323, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(8356, 2089.3691, 1065.0871, 2694.613, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(8356, 1964.1201, 1190.3464, 2755.2905, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(8356, 1838.8826, 1315.5974, 2815.9609, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(8356, 1713.7125, 1440.7891, 2876.6394, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(8356, 1588.4365, 1566.0247, 2937.3261, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(8356, 1463.1744, 1691.285, 2998.0524, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(8356, 1353.1501, 1830.35, 3058.4257, 341.0924, 0.0, 225.0001, 5);
	CreateDynamicObject(10473, 1239.552, 1944.1936, 3121.0905, 0.0, 335.9357, 135.0, 5);
	CreateDynamicObject(8356, 1160.8713, 2023.9713, 3170.9433, 335.9357, 0.0, 225.0001, 5);
	CreateDynamicObject(4818, 1139.5518, 2017.2462, 3179.2292, 0.0, 335.9357, 135.0, 5);
	CreateObject(10766, 1070.4895, 2114.3798, 3207.2687, 0.0, 0.0, 45.0);
	CreateDynamicObject(16776, 1079.2174, 2074.0383, 3208.6132, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(11435, 1119.2128, 2104.8762, 3213.6252, 0.0, 0.0, 213.75, 5);
	CreateDynamicObject(8356, 1967.8474, 3460.6767, 1896.3835, 0.0, 0.0, 135.0, 5);
	CreateDynamicObject(11435, 2022.4565, 3490.4875, 1901.0291, 0.0, 0.0, 45.0, 5);
	CreateDynamicObject(8955, 2066.6003, 2189.5637, 600.3104, 268.0403, 358.281, 0.0, 5);
}
//-----/ SpawnHandler_5_69 /------------------------------------------------
public SpawnHandler_5_69(playerid)
{
	if(GetPlayerMap(playerid) == 5)
	{
	    ClearChatting(playerid);
		if(GetPlayerLanguage(playerid) == 0)
		{
		    SendClientMessage(playerid,COLOR_GREEN,"          돌아온 시발모드 : 69 질주");
		    SendClientMessage(playerid,COLOR_WHITE,"스피드를 원하시다구요? 그렇다면 잘 찾아오셨습니다.");
		    SendClientMessage(playerid,COLOR_WHITE,"원하는 차량을 타고 마음껏 달려보세요! 누구도 막을 수 없습니다.");
		}
		else
		{
		    SendClientMessage(playerid,COLOR_GREEN,"          Fuck Mode Returned: 69 Scamper");
		    SendClientMessage(playerid,COLOR_WHITE,"Do you want speed? Then, good to here.");
		    SendClientMessage(playerid,COLOR_WHITE,"Get on the vehicle and rush! No one can stop you.");
		}
		//-----
	    SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
		SetPlayerPos(playerid,1004.8827, 2181.4301, 3212.5507);
		SetPlayerFacingAngle(playerid,317.0281);
		FreezePlayer(playerid,2);

		SetPlayerSkin(playerid,GetPVarInt(playerid,"Skin"));
		SetPlayerHealth(playerid,100);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,5);
        SetPlayerTime(playerid, 12, 0);
        SetPlayerWeather(playerid, 0);
        SetPlayerMapIcon(playerid,0,-1657.5291,-164.8431,14.1484,53,0,MAPICON_GLOBAL);
        PlayAudioStreamForPlayerEx(playerid);

        _Goal[playerid] = false;
	}
}
//-----/ CommandHandler_5_69 /--------------------------------------------------
public CommandHandler_5_69(playerid,cmdtext[])
{
	if(GetPlayerMap(playerid) == 5)
	{
		if(!strcmp("/help",cmdtext) || !strcmp("/도움말",cmdtext) || !strcmp("/?",cmdtext))
		{
			if(GetPlayerLanguage(playerid) == 0)
				SendClientMessage(playerid,COLOR_GREY,"[!] 질주하세요! 처음부터 다시 시작하려면 [/맵] 을 이용해주세요.");
			else
				SendClientMessage(playerid,COLOR_GREY,"[!] Be a scamper! you can try again by entering [/map].");
			return 1;
		}
	}
	return 0;
}
//-----/ PickUpHandler_5_69 /--------------------------------------------------
public PickUpHandler_5_69(playerid,pickupid)
{
	if(pickupid == _GoalPickup && !_Goal[playerid])
	{
	    new string[256];
	    new len = GetPlayerLanguage(playerid);

	    _Goal[playerid] = true;
	    if(len == 0)
	    {
	    	format(string,sizeof(string),"*** %s (%d) 님이 목적지에 도착했습니다! (Point +50, Money +5000) ***",GetPlayerNameEx(playerid),playerid);
	    	SendMessage(playerid,COLOR_PASTEL_YELLOW,string);
	    	SendClientMessage(playerid,COLOR_WHITE,"* 재도전 하려면 [/맵]을 통해 다시 입장해 주시길 바랍니다.");
	    }
	    else
	    {
		    format(string,sizeof(string),"*** %s (%d) has reached the destination! (Point +50, Money +5000) ***",GetPlayerNameEx(playerid),playerid);
		    SendMessage(playerid,COLOR_PASTEL_YELLOW,string);
		    SendClientMessage(playerid,COLOR_WHITE,"* If you want to try again this game, enter [/map].");
	    }

	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    GivePlayerPoint(playerid, 50);
		SetPVarInt(playerid,"Money",GetPVarInt(playerid,"Money")+5000);
	}
}
//==========/ Functions /=======================================================
//-----/ Boom_A /---------------------------------------------------------------
public Boom_A()
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerMap(pid) == 5)
		{
			CreateExplosionForPlayer(pid,1153.6097, 2050.0473 + 7, 3182.9807, 7, 50.0);
			CreateExplosionForPlayer(pid,1243.2474, 1994.3996 + 7, 3137.1679, 7, 50.0);
			CreateExplosionForPlayer(pid,1187.343, 1937.0986 + 7, 3136.7268, 7, 50.0);
		}
	}
	return 1;
}
//-----/ Boom_B /---------------------------------------------------------------
public Boom_B()
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerMap(pid) == 5)
		{
			CreateExplosionForPlayer(pid,1394.9089, 3115.4291 + 7, 1961.1811, 7, 50.0);
			CreateExplosionForPlayer(pid,1428.1112, 3148.0593 + 7, 1961.1811, 7, 50.0);
			CreateExplosionForPlayer(pid,1468.9075, 3190.1936 + 7, 1961.2562, 7, 50.0);
			CreateExplosionForPlayer(pid,1521.8742, 3243.8381 + 7, 1961.7272, 7, 50.0);
			CreateExplosionForPlayer(pid,1597.4805, 3319.309 + 7, 1961.7272, 7, 50.0);
			CreateExplosionForPlayer(pid,1708.8378, 3430.9621 + 7, 1961.4768, 7, 50.0);
			CreateExplosionForPlayer(pid,1795.14, 3516.197 + 7, 1961.4705, 7, 50.0);
			CreateExplosionForPlayer(pid,1604.5895, 3097.1943 + 7, 1677.7894, 7, 50.0);
			CreateExplosionForPlayer(pid,1523.6989, 3016.0903 + 7, 1618.869, 7, 50.0);
			CreateExplosionForPlayer(pid,1367.3591, 2859.977 + 7, 1534.1447, 7, 50.0);
			CreateExplosionForPlayer(pid,1174.1372, 2666.6679 + 7, 1485.1425, 7, 50.0);
			CreateExplosionForPlayer(pid,202.0631, 1694.3461 + 7, 901.8842, 7, 50.0);
			CreateExplosionForPlayer(pid,-570.3987, 911.5111 + 7, 315.2955, 7, 50.0);
			CreateExplosionForPlayer(pid,-636.5431, 868.7632 + 7, 275.1624, 7, 50.0);
			CreateExplosionForPlayer(pid,-697.3418, 803.2832 + 7, 228.6757, 7, 50.0);
			CreateExplosionForPlayer(pid,-753.3701, 747.93 + 7, 187.6551, 7, 50.0);
			CreateExplosionForPlayer(pid,-846.2419, 646.2955 + 7, 116.0388, 7, 50.0);
			CreateExplosionForPlayer(pid,-1247.4446, 245.0696 + 7, 13.3366, 7, 50.0);
		}
	}
	return 1;
}
//-----/ Boom_C /---------------------------------------------------------------
public Boom_C()
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerMap(pid) == 5)
		{
			CreateExplosionForPlayer(pid,1860.6881, 3334.385 + 7, 1859.9012, 7, 50.0);
			CreateExplosionForPlayer(pid,1084.0478, 2566.0437 + 7, 1415.4343, 7, 50.0);
			CreateExplosionForPlayer(pid,966.0057, 2477.4843 + 7, 1339.3713, 7, 50.0);
			CreateExplosionForPlayer(pid,926.0116, 2406.9375 + 7, 1298.681, 7, 50.0);
			CreateExplosionForPlayer(pid,837.7041, 2342.0034 + 7, 1242.2685, 7, 50.0);
			CreateExplosionForPlayer(pid,812.4712, 2293.194 + 7, 1215.0217, 7, 50.0);
			CreateExplosionForPlayer(pid,724.1587, 2226.4335 + 7, 1157.9351, 7, 50.0);
			CreateExplosionForPlayer(pid,693.1217, 2177.207 + 7, 1128.3758, 7, 50.0);
			CreateExplosionForPlayer(pid,607.2568, 2112.2521 + 7, 1072.8549, 7, 50.0);
			CreateExplosionForPlayer(pid,349.3647, 1842.4317 + 7, 880.3147, 7, 50.0);
			CreateExplosionForPlayer(pid,70.5563, 1564.1594 + 7, 791.5441, 7, 50.0);
			CreateExplosionForPlayer(pid,-9.405, 1483.4733 + 7, 732.4055, 7, 50.0);
			CreateExplosionForPlayer(pid,-247.6781, 1234.5826 + 7, 553.0449, 7, 50.0);
			CreateExplosionForPlayer(pid,-258.7886, 1244.2344 + 7, 552.5079, 7, 50.0);
			CreateExplosionForPlayer(pid,-551.3786, 922.4043 + 7, 326.2986, 7, 50.0);
			CreateExplosionForPlayer(pid,-596.7079, 896.0567 + 7, 299.9123, 7, 50.0);
			CreateExplosionForPlayer(pid,-653.6797, 827.654 + 7, 253.7205, 7, 50.0);
			CreateExplosionForPlayer(pid,-715.9247, 768.2108 + 7, 208.9237, 7, 50.0);
			CreateExplosionForPlayer(pid,-773.4952, 712.421 + 7, 167.1746, 7, 50.0);
			CreateExplosionForPlayer(pid,-1018.1103, 464.5044 + 7, 13.735, 7, 50.0);
			CreateExplosionForPlayer(pid,-1029.2623, 474.1247 + 7, 13.735, 7, 50.0);
		}
	}
	return 1;
}
