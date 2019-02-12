/*
  [Functions]
	SetSelectionInfo_6(playerid)
	ResetVariable_6(playerid)
	ReleaseFromJail()
	SendGangMessage(playerid,text[])
	DestroyGang(gangid)
	ShowPlayerWeaponDialog(playerid)
	ShowPlayerWeaponDialog(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_6_CnR
	#endinput
#endif
#define _MDPWN_6_CnR

//-----/ Defines /
#define DialogID_6_CnR(%1)			10400 + %1
#define MAX_WEAPON                  18

//-----/ News /
	//--/ CnR /
new SkinInfo_6[] = {
265,266,267,280,281,282,283,284,285,286,287,300,301,302,309,306,309,301,165,166, // 경찰
181,21,23,29,33,47,271,98,269,106,107,108,109,102,103,104,121,174,175,173 		 // 도둑
};

new Team_Balance = 0;
new bool:Player_Jailed[MAX_PLAYERS];
new Rescue_Protocol[MAX_PLAYERS];

new Player_Gang_ID[MAX_PLAYERS];
new Player_Gang_Timer[MAX_PLAYERS];
new Player_Gang_Invited[MAX_PLAYERS];

new WeaponInfo[18][3] = {
	{9,200,1}, // Chainsaw
	{16,250,5}, // Grenade
	{17,250,5}, // Molotov Cocktail
	{22,100,102}, // 9mm
	{23,50,102}, // Silenced 9mm
	{24,200,42}, // Deagle
	{25,200,30}, // Shotgun
	{26,300,30}, // Sawnoff Shotgun
	{27,300,42}, // Combat Shotgun
	{28,250,200}, // Micro SMG/Uzi
	{29,200,180}, // MP5
	{30,400,210}, // AK47
	{31,500,250}, // M4
	{32,250,200}, // TEC-9
	{33,200,30}, // Country Rifle
	{34,300,20}, // Sniper Rifle
	{35,350,2}, // RPG
	{36,350,2} // HS Rocket
};
	//--/ Spawn Position /
new Float:Cop_Spawn[4][3] = {
	{ 1545.16, -1676.0311, 13.5598 },
	{ 1576.019, -1620.126, 13.5468 },
	{ 1585.244, -1687.0501, 6.2187 },
	{ 1588.108, -1637.938, 13.4199 }
};

new Float:Robber_Spawn[4][3] = {
	{ 2169.656, -1674.672, 15.0859 },
	{ 2156.998, -1685.0981, 15.0859 },
	{ 2180.1499, -1686.0781, 13.8485 },
	{ 2187.727, -1653.9981, 15.321 }
};

new Float:Jail_Spawn[4][3] = {
	{ 265.4425, 79.1644, 1001.039 },
	{ 265.432, 77.548, 1001.039 },
	{ 263.4187, 76.2712, 1001.039 },
	{ 263.1976, 78.1771, 1001.039 }
};

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_6_CnR();
forward CommandHandler_6_CnR(playerid,cmdtext[]);
forward SpawnHandler_6_CnR(playerid);
forward InitHandler_6_CnR();
forward KeyHandler_6_CnR(playerid,newkeys,oldkeys);
forward UpdateHandler_6_CnR(playerid);
forward DisconnectHandler_6_CnR(playerid,reason);
forward DeathHandler_6_CnR(playerid,killerid,reason);
forward EnterCPHandler_6_CnR(playerid);
forward DialogHandler_6_CnR(playerid,dialogid,response,listitem,inputtext[]);
	//--/ Functions /
forward GangInviteTimeout(playerid);

//==========/ Callback Functions /==============================================
//-----/ AddHandler_6_CnR /-----------------------------------------------------
public AddHandler_6_CnR()
{
	AddHandler("6_CnR",InitHandler);
	AddHandler("6_CnR",SpawnHandler);
	AddHandler("6_CnR",CommandHandler);
	AddHandler("6_CnR",KeyHandler);
	AddHandler("6_CnR",UpdateHandler);
	AddHandler("6_CnR",DeathHandler);
	AddHandler("6_CnR",EnterCPHandler);
	AddHandler("6_CnR",DialogHandler);
}

//-----/ InitHandler_6_CnR /----------------------------------------------------
public InitHandler_6_CnR()
{
	begin = AddStaticVehicle(596, 1535.7749, -1667.3227, 12.5751, 0.2375, 0, 1);
	AddStaticVehicle(596, 1535.8126, -1676.3747, 12.5751, 0.238, 0, 1);
	AddStaticVehicle(427, 1601.7467, -1629.9373, 12.6778, 89.7156, 0, 1);
	AddStaticVehicle(596, 1595.5562, -1710.0564, 5.083, 179.6777, 0, 1);
	AddStaticVehicle(596, 1587.4284, -1710.845, 5.0829, 180.6483, 0, 1);
	AddStaticVehicle(523, 1601.0412, -1700.0781, 5.0829, 269.2224, 0, 1);
	AddStaticVehicle(535, 2162.3024, -1703.0754, 13.9008, 272.3512, 7, 1);
	AddStaticVehicle(560, 2168.0895, -1677.1766, 13.906, 224.3493, 16, 16);
	AddStaticVehicle(535, 2189.8391, -1656.0167, 13.9137, 347.1693, 85, 85);
	AddStaticVehicle(560, 2184.1076, -1681.7242, 12.7093, 347.4096, 7, 7);
	AddStaticVehicle(581, 2178.5195, -1664.6644, 13.7668, 222.3536, 0, 1);
	AddStaticVehicle(400, 2197.6914, -1675.3465, 13.1265, 348.5928, 16, 16);
	AddStaticVehicle(536, 2171.7751, -1726.2933, 13.3349, 271.3572, 18, 1);
	AddStaticVehicle(536, 2170.2844, -1648.7586, 14.7083, 318.5802, 16, 16);
	AddStaticVehicle(567, 2156.5573, -1662.3901, 14.8587, 313.2276, 85, 85);
	AddStaticVehicle(567, 2187.6789, -1623.9759, 14.3546, 160.9718, 7, 1);
	AddStaticVehicle(519, 1425.3901, -2493.5623, 14.5835, 268.7735, 1, 1);
	AddStaticVehicle(519, -1639.306, -148.3752, 15.1726, 315.1575, 1, 1);
	AddStaticVehicle(593, 1944.077, -2642.722, 14.1017, 358.0437, 68, 8);
	AddStaticVehicle(593, 1965.7038, -2643.0013, 14.1075, 0.6567, 2, 1);
	AddStaticVehicle(520, 308.0575, 1801.7359, 18.4638, 0.6013, 0, 0);
	AddStaticVehicle(520, 276.8438, 2024.7451, 18.4638, 269.2513, 0, 0);
	AddStaticVehicle(567, 1998.8455, -2093.7139, 13.5172, 179.3739, 77, 26);
	AddStaticVehicle(567, 2318.6079, -2314.5865, 13.5163, 226.1835, 77, 26);
	AddStaticVehicle(567, 2114.3349, -2161.9876, 13.5186, 358.4043, 77, 26);
	AddStaticVehicle(567, 1793.6252, -2119.9979, 13.4361, 268.4345, 3, 3);
	AddStaticVehicle(567, 1846.5335, -2145.7554, 13.4305, 179.0391, 77, 26);
	AddStaticVehicle(567, 1819.5302, -2020.9955, 13.2662, 180.5588, 77, 26);
	AddStaticVehicle(567, 1886.2353, -2021.8167, 13.2735, 180.2953, 77, 26);
	AddStaticVehicle(439, 803.0838, -1737.444, 13.4287, 179.0346, 77, 26);
	AddStaticVehicle(439, 647.6434, -1656.1121, 14.9319, 0.6496, 32, 8);
	AddStaticVehicle(439, 761.2152, -1660.0455, 4.1995, 86.8627, 32, 8);
	AddStaticVehicle(439, 903.9887, -1455.3766, 13.0525, 270.0151, 77, 26);
	AddStaticVehicle(445, 808.5872, -1464.2021, 13.181, 85.9945, 43, 43);
	AddStaticVehicle(445, 1648.3237, -1136.0062, 23.7212, 359.7817, 0, 0);
	AddStaticVehicle(445, 1590.4649, -1315.3196, 17.3164, 268.8727, 0, 0);
	AddStaticVehicle(445, 1714.2255, -1601.2035, 13.3596, 261.5271, 0, 0);
	AddStaticVehicle(540, 1022.95, -1137.1359, 23.5363, 90.2181, 77, 26);
	AddStaticVehicle(540, 1073.5498, -1103.0308, 24.6883, 267.2265, 77, 26);
	AddStaticVehicle(540, 972.1492, -1091.7345, 24.0813, 90.8632, 77, 26);
	AddStaticVehicle(540, 1077.259, -1772.6647, 13.0223, 89.8721, 6, 25);
	AddStaticVehicle(540, 333.8363, -1520.0607, 35.8621, 322.3912, 32, 8);
	AddStaticVehicle(540, 805.283, -1344.5556, 13.4413, 178.302, 77, 26);
	AddStaticVehicle(581, 2099.7204, -994.3968, 53.7088, 0.4158, 77, 26);
	AddStaticVehicle(581, 2023.2752, -960.7878, 39.4572, 204.7902, 77, 26);
	AddStaticVehicle(581, 2011.2349, -979.0713, 35.4748, 206.7678, 77, 26);
	AddStaticVehicle(581, 2030.8878, -1348.1264, 23.6771, 269.8645, 77, 26);
	AddStaticVehicle(581, 1722.0648, -1278.4799, 13.2438, 178.6602, 77, 26);
	AddStaticVehicle(581, 2227.9191, -1167.0313, 25.4323, 85.5935, 77, 26);
	AddStaticVehicle(487, 1543.9259, -1353.4107, 329.7491, 270.4592, 29, 42);
	AddStaticVehicle(487, -1361.5871, -492.6511, 14.4486, 203.8937, 29, 42);
	AddStaticVehicle(487, 1916.5373, -2319.3125, 13.8243, 270.4679, 29, 42);
	AddStaticVehicle(476, 290.2703, 2543.1269, 17.6296, 177.6405, 7, 6);
	AddStaticVehicle(476, 324.9189, 2538.5368, 17.62, 177.5668, 1, 6);
	AddStaticVehicle(568, -370.4795, 2231.2878, 42.4474, 100.8292, 9, 39);
	AddStaticVehicle(568, -369.8746, 2227.2326, 42.4502, 98.2434, 17, 1);
	AddStaticVehicle(409, 2038.7363, 1008.5133, 10.5718, 359.5103, 1, 1);
	AddStaticVehicle(409, 2176.3696, 1676.9595, 10.7203, 359.7546, 1, 1);
	AddStaticVehicle(523, 1542.0605, -1623.7367, 13.0534, 89.1428, 0, 0);
	AddStaticVehicle(523, 1969.951, -2180.3428, 13.2135, 359.1487, 0, 0);
	AddStaticVehicle(522, 2483.5708, -1654.7432, 12.9817, 89.3684, 6, 25);
	AddStaticVehicle(522, 1907.3941, -1356.0187, 13.1683, 269.8377, 6, 25);
	AddStaticVehicle(522, 2518.5207, -1282.1252, 34.5145, 358.8864, 6, 25);
	AddStaticVehicle(522, 2803.915, -1252.8952, 46.6243, 154.3838, 6, 25);
	AddStaticVehicle(522, -2313.5264, -1629.045, 483.3737, 214.5184, 39, 106);
	AddStaticVehicle(467, 1834.811, -1871.4095, 13.228, 359.8713, 60, 1);
	AddStaticVehicle(467, 2051.6411, -1694.7037, 13.3945, 268.8799, 58, 8);
	AddStaticVehicle(402, 2416.9338, 91.2872, 26.4052, 89.4945, 22, 22);
	AddStaticVehicle(402, 889.2772, -22.1742, 63.2049, 152.7799, 30, 30);
	AddStaticVehicle(490, 1547.1423, -1697.4933, 13.777, 87.4331, 0, 0);
	AddStaticVehicle(490, 1549.2064, -1721.8471, 13.7842, 89.5649, 0, 0);
	AddStaticVehicle(545, 2485.7199, -1556.0071, 23.9628, 179.6562, 85, 1);
	AddStaticVehicle(545, 2416.4418, -1719.5232, 13.6579, 178.888, 85, 1);
	AddStaticVehicle(463, -84.5783, -1188.6464, 1.3904, 70.4356, 84, 84);
	AddStaticVehicle(463, -82.3765, -1184.8461, 1.3943, 69.7823, 84, 84);
	AddStaticVehicle(463, -104.3539, -1194.3816, 2.125, 73.9355, 84, 84);
	AddStaticVehicle(463, -85.7097, -1582.2369, 2.2526, 234.9492, 84, 84);
	AddStaticVehicle(463, -70.0019, -1583.3386, 2.2568, 221.4333, 84, 84);
	AddStaticVehicle(463, -50.3783, -1566.5052, 2.2573, 167.8807, 84, 84);
	AddStaticVehicle(463, -374.2659, -1428.5876, 25.367, 357.5328, 84, 84);
	AddStaticVehicle(463, -369.1096, -1436.5741, 25.3661, 264.5083, 84, 84);
	AddStaticVehicle(463, -383.3793, -1417.5192, 25.3663, 266.746, 84, 84);
	AddStaticVehicle(463, 1731.4658, -1862.0237, 13.24, 268.6878, 0, 0);
	AddStaticVehicle(463, 1142.8435, -1379.4186, 13.4611, 177.2425, 0, 0);
	AddStaticVehicle(463, 592.7366, -1237.7538, 18.0955, 111.2245, 0, 0);
	AddStaticVehicle(463, 2310.3984, -74.8256, 26.1058, 90.7837, 0, 0);
	AddStaticVehicle(470, 1652.4154, -2525.1065, 13.6396, 270.3764, 43, 0);
	AddStaticVehicle(470, 1992.2714, -2351.7525, 13.6389, 0.3736, 43, 0);
	AddStaticVehicle(470, 275.9263, 1948.0249, 17.7401, 299.4493, 43, 0);
	AddStaticVehicle(470, 276.5101, 1963.0881, 17.735, 244.0523, 43, 0);
	AddStaticVehicle(518, 2425.8107, -1223.9208, 25.0668, 177.4548, 9, 39);
	AddStaticVehicle(541, -2026.9419, 124.8322, 28.8287, 358.3098, 58, 8);
	AddStaticVehicle(480, 2055.9375, -1903.9954, 13.4205, 180.7127, 2, 2);
	AddStaticVehicle(539, 810.5427, -1851.5019, 7.8238, 178.4058, 79, 74);
	AddStaticVehicle(563, 265.5409, -1804.9583, 5.1548, 270.1182, 1, 6);
	AddStaticVehicle(500, -17.0364, -2503.7686, 36.8602, 300.9899, 4, 119);
	AddStaticVehicle(505, -1573.6011, -2729.7381, 48.7875, 325.0676, 13, 118);
	AddStaticVehicle(433, 278.4312, 1989.5758, 18.1786, 269.4515, 43, 0);
	AddStaticVehicle(444, 2646.4084, -2003.5474, 13.5659, 270.5392, 0, 0);
	AddStaticVehicle(560, 951.8214, -1369.1241, 13.1485, 179.2388, 17, 1);
	AddStaticVehicle(511, 1315.5675, 1362.8664, 12.2933, 269.4338, 4, 90);
	AddStaticVehicle(461, 2392.7109, -1898.2096, 13.1572, 270.2731, 74, 1);
	AddStaticVehicle(452, 2940.2182, -2043.6281, -0.2897, 269.1659, 1, 5);
	AddStaticVehicle(429, -2746.7317, -280.089, 6.8213, 359.5281, 79, 3);
	AddStaticVehicle(575, -2634.2525, 1377.7271, 6.839, 358.6343, 10, 5);
	AddStaticVehicle(493, -1894.4052, 1400.3046, -0.0589, 92.0589, 36, 13);
	AddStaticVehicle(468, 1260.1345, 289.1567, 19.3233, 339.1774, 103, 103);
	AddStaticVehicle(603, -1445.945, -1577.2728, 101.6998, 269.3623, 0, 0);
	AddStaticVehicle(521, 1968.3383, -2184.6834, 13.2129, 0.637, 75, 13);
	AddStaticVehicle(400, 2505.7255, -1694.169, 13.6523, 0.9891, 16, 0);
	AddStaticVehicle(542, 2075.6843, -1784.4133, 13.3434, 344.0244, 72, 39);
	//AddStaticVehicle(425, 309.4631, 2047.7318, 18.2168, 175.9589, 43, 0);
	AddStaticVehicle(404, 2305.3395, -1634.945, 14.3569, 179.7301, 77, 26);
	AddStaticVehicle(518, 1278.4801, 171.0043, 19.877, 61.1377, 103, 103);
	AddStaticVehicle(500, 1549.2889, -27.3942, 21.0925, 271.019, 103, 103);
	AddStaticVehicle(505, 1930.1468, 172.5841, 37.0499, 68.7444, 103, 103);
	AddStaticVehicle(560, 1389.0529, 265.5415, 19.336, 333.0997, 103, 103);
	AddStaticVehicle(468, 1752.9483, -1036.5905, 23.9567, 178.7866, 77, 26);
	AddStaticVehicle(603, 1567.6072, -1011.5071, 23.9052, 2.4702, 77, 26);
	AddStaticVehicle(521, 1357.9028, -616.3965, 109.1281, 50.2854, 77, 26);
	AddStaticVehicle(400, 1037.2121, -638.3393, 120.1207, 334.2542, 77, 26);
	AddStaticVehicle(542, 723.6323, -994.5109, 52.5397, 145.5513, 77, 26);
	AddStaticVehicle(404, 405.7481, -1152.4518, 77.1057, 148.5489, 77, 26);
	AddStaticVehicle(522, 204.973, -230.4092, 1.7744, 177.8984, 77, 26);
	AddStaticVehicle(521, 313.6477, -55.8182, 1.5743, 181.1273, 77, 26);
	AddStaticVehicle(518, 199.6054, -144.7829, 1.5797, 88.1766, 77, 26);
	AddStaticVehicle(473, 389.7571, -267.124, 0.7564, 226.3941, 77, 26);
	AddStaticVehicle(505, 1045.3934, -306.0377, 73.9888, 179.1813, 77, 26);
	AddStaticVehicle(560, 1223.775, -902.8022, 42.8961, 191.0858, 77, 26);
	AddStaticVehicle(468, 787.7534, -608.4427, 16.2954, 348.4307, 77, 26);
	AddStaticVehicle(603, 667.0645, -461.3056, 16.2937, 90.3768, 77, 26);
	AddStaticVehicle(521, 748.1793, 382.4213, 23.1328, 280.7962, 77, 26);
	AddStaticVehicle(463, 1907.1712, 957.7847, 10.7813, 179.4651, 77, 26);
	AddStaticVehicle(402, 2142.0351, 1012.9923, 10.7761, 88.3526, 77, 26);
	AddStaticVehicle(522, 2039.8908, 1295.4885, 10.6331, 359.1798, 77, 26);
	AddStaticVehicle(445, 2129.7016, 1409.0985, 10.783, 0.8938, 77, 26);
	AddStaticVehicle(480, 1944.7705, 1345.2595, 9.0668, 180.7324, 77, 26);
	AddStaticVehicle(541, 2207.3916, 1788.1927, 10.7798, 359.8085, 77, 26);
	AddStaticVehicle(429, 2186.3342, 1992.1213, 10.7815, 89.458, 77, 26);
	AddStaticVehicle(409, 2483.8332, 2133.0483, 10.6331, 267.6821, 77, 26);
	AddStaticVehicle(402, 2610.301, 2279.4968, 10.7794, 88.8308, 77, 26);
	AddStaticVehicle(522, 2127.8947, 2355.1132, 10.6354, 89.1345, 77, 26);
	AddStaticVehicle(445, 1952.2722, 2290.1689, 10.78, 89.4549, 77, 26);
	AddStaticVehicle(480, 1748.5616, 2213.2133, 10.7814, 89.8264, 37, 37);
	AddStaticVehicle(541, 1544.9561, 2088.9099, 11.3308, 91.0019, 37, 37);
	AddStaticVehicle(429, 1316.0517, 1936.1057, 11.3456, 178.7662, 37, 37);
	AddStaticVehicle(463, 767.4005, 2018.5306, 6.1387, 263.0834, 37, 37);
	AddStaticVehicle(402, 1184.2098, 1254.6003, 9.457, 179.7879, 37, 37);
	AddStaticVehicle(522, 1519.1418, 787.6638, 10.7813, 358.7261, 37, 37);
	AddStaticVehicle(445, 1849.7617, 698.8828, 11.3207, 269.9656, 37, 37);
	AddStaticVehicle(480, 2128.2321, 691.2327, 11.3379, 359.9301, 37, 37);
	AddStaticVehicle(541, 2361.3518, 651.1115, 11.3679, 179.8863, 37, 37);
	AddStaticVehicle(429, 2680.4462, 748.2318, 10.7803, 358.6536, 37, 37);
	AddStaticVehicle(463, -2318.8758, -125.9999, 35.0373, 180.0424, 58, 8);
	AddStaticVehicle(402, -2447.4942, -47.6903, 33.9941, 179.2868, 58, 8);
	AddStaticVehicle(522, -2594.1124, -190.9773, 4.0196, 88.4961, 58, 8);
	AddStaticVehicle(445, -2801.5293, -86.4694, 6.9916, 358.3644, 79, 3);
	AddStaticVehicle(480, -2738.865, 127.7293, 4.28, 182.005, 79, 3);
	AddStaticVehicle(541, -2665.0101, 267.9809, 4.1156, 359.1966, 79, 3);
	AddStaticVehicle(429, -2659.7681, 621.6314, 14.2328, 269.2994, 79, 3);
	AddStaticVehicle(429, -2377.3531, 1121.7296, 55.5062, 159.2433, 79, 3);
	AddStaticVehicle(429, -2048.2393, 1226.7698, 31.4281, 87.8713, 79, 3);
	AddStaticVehicle(429, -2065.5084, 1431.0651, 6.8803, 178.128, 79, 3);
	AddStaticVehicle(463, -1742.1899, 1385.9736, 6.9671, 47.665, 79, 3);
	AddStaticVehicle(402, -1556.0428, 1040.5018, 6.9671, 179.8155, 79, 3);
	AddStaticVehicle(429, -1604.1995, 781.7268, 6.6, 218.1439, 79, 3);
	AddStaticVehicle(522, -1670.3752, 441.6282, 6.9593, 222.8092, 79, 3);
	AddStaticVehicle(445, -1935.2027, 585.0178, 34.9058, 358.7294, 79, 3);
	AddStaticVehicle(480, -1948.6274, 797.2554, 55.5028, 88.9114, 79, 3);
	AddStaticVehicle(541, -2106.4446, 904.2263, 76.1926, 7.3215, 79, 3);
	AddStaticVehicle(463, -1956.6659, 262.4442, 40.7721, 268.8793, 58, 8);
	AddStaticVehicle(541, -2139.4644, 258.341, 35.084, 181.3157, 58, 8);
	AddStaticVehicle(522, -2074.1575, 306.3369, 41.717, 269.6965, 58, 8);
	AddStaticVehicle(402, -2265.3248, 204.2722, 34.8891, 89.477, 58, 8);
	AddStaticVehicle(522, -2415.1016, 330.1029, 34.697, 332.7446, 58, 8);
	AddStaticVehicle(500, -703.5867, -2676.2171, 92.6065, 266.7619, 4, 119);
	AddStaticVehicle(505, -642.4474, -2447.7947, 31.8247, 135.5718, 4, 119);
	AddStaticVehicle(560, -2143.2032, -2447.4607, 30.8728, 141.5773, 13, 118);
	AddStaticVehicle(468, -2239.9073, -2555.2427, 32.1656, 59.5955, 13, 118);
	AddStaticVehicle(468, -2405.2103, -2180.2339, 33.5329, 269.903, 13, 118);
	AddStaticVehicle(444, -1915.8572, -1672.0826, 23.2622, 271.6054, 13, 118);
	AddStaticVehicle(400, -1111.2332, -1621.0282, 76.6127, 269.2383, 13, 118);
	AddStaticVehicle(542, -582.7024, -1065.6852, 23.6459, 236.5289, 13, 118);
	AddStaticVehicle(473, 2098.0598, -106.7644, -0.4413, 221.5903, 0, 0);
	AddStaticVehicle(468, 2686.8588, 221.3811, 58.0735, 257.7325, 22, 22);
	AddStaticVehicle(518, 2339.9645, -654.2596, 128.8297, 186.1914, 22, 22);
	AddStaticVehicle(500, 1543.2188, 15.9257, 24.0685, 282.8633, 30, 30);
	AddStaticVehicle(505, 1005.3814, -71.9734, 21.9518, 111.5432, 30, 30);
	AddStaticVehicle(473, 124.2068, -897.8238, -0.6602, 152.1958, 0, 0);
	AddStaticVehicle(400, 188.9069, -552.7046, 48.8151, 34.4048, 0, 0);
	AddStaticVehicle(468, -2103.4317, -1747.8942, 195.8846, 328.488, 0, 0);
	AddStaticVehicle(522, -44.0174, 1167.5491, 19.6468, 355.0368, 0, 0);
	AddStaticVehicle(480, -30.5105, 996.3748, 19.7856, 175.559, 0, 0);
	AddStaticVehicle(480, 334.0848, -1809.2956, 4.3617, 179.5207, 2, 2);
	AddStaticVehicle(480, 441.6711, -1299.7544, 15.0504, 214.4154, 2, 2);
	AddStaticVehicle(542, 932.0219, -853.3588, 93.3433, 26.9008, 77, 26);
	AddStaticVehicle(447, 1291.4375, -789.1498, 96.7321, 180.2162, 29, 42);
	AddStaticVehicle(487, 1765.5297, -2285.9034, 27.0722, 177.8813, 29, 42);
	AddStaticVehicle(522, 1519.322, -1462.5329, 9.475, 180.5982, 0, 0);
	AddStaticVehicle(480, 451.34, -1492.7171, 30.9202, 15.3908, 0, 0);
	AddStaticVehicle(480, 343.5032, -1350.0289, 14.4828, 119.0693, 0, 0);
	AddStaticVehicle(445, 1128.2558, -1540.4594, 14.8573, 179.1578, 0, 0);
	end = AddStaticVehicle(522, 1338.8746, -1320.0261, 13.3438, 0.2407, 0, 0);
	for(new i=begin; i<=end; i++)
	    SetVehicleVirtualWorld(i, 6);
}
//-----/ SpawnHandler_6_CnR /---------------------------------------------------
public SpawnHandler_6_CnR(playerid)
{
	if(GetPlayerMap(playerid) == 6)
	{
	    ClearChatting(playerid);
	    SetPlayerWorldBounds(playerid,20000.0000, -20000.0000, 20000.0000, -20000.0000);
		if(!PlayerTeam[playerid]) // 팀 선택
		{
		    GameTextForPlayer(playerid,"~h~~b~Cop",90000,6);
		    
		    SelectedTeam[playerid] = 0;
		    SetPlayerTime(playerid, 12, 0);

		    FreezePlayer(playerid);
		    SetPlayerSkin(playerid,265);
		    SetPlayerVirtualWorld(playerid,playerid+13);
		    SetPlayerPos(playerid,1552.5024,-1675.6931,16.1953);
		    SetPlayerFacingAngle(playerid,88.5446);
		    SetPlayerCameraPos(playerid,1547.8622,-1675.7061,19.2707);
		    SetPlayerCameraLookAt(playerid,1552.5024,-1675.6931,16.19531);
		}
	    else
	    {
			if(GetPlayerLanguage(playerid) == 0)
			{
			    SendClientMessage(playerid,COLOR_GREEN,"          경찰과 도둑");
			    SendClientMessage(playerid,COLOR_WHITE,"로스산토스에 경찰과 도둑간의 대 전쟁이 발발했습니다.");
			    SendClientMessage(playerid,COLOR_WHITE,"여러분들은 경찰 혹은 도둑이 되어 자신의 목표를 달성해야 합니다.");
			    SendClientMessage(playerid,COLOR_WHITE,"로스산토스의 운명은 어떻게 될 것인가..?");
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREEN,"          Cops and Robbers");
			    SendClientMessage(playerid,COLOR_WHITE,"A great war broke out between cops and robbers in Los Santos.");
			    SendClientMessage(playerid,COLOR_WHITE,"You have to be a cop or robber and achieve your goals.");
			    SendClientMessage(playerid,COLOR_WHITE,"What will be the fate of Los Santos..?");
			}
			//-----
			new rand = random(4);
	        SetPlayerTime(playerid, 12, 0);
	        SetPlayerWeather(playerid, 0);
		    SetPlayerSkin(playerid,SkinInfo_6[SelectedTeam[playerid]]);
		    SetPlayerVirtualWorld(playerid,6);
			SetPlayerInterior(playerid,0);
			SetPlayerHealth(playerid,100);
			SetPlayerArmour(playerid,100);

			ResetPlayerWeapons(playerid);
			GivePlayerWeapon(playerid, 24, 56);
			GameTextForPlayer(playerid," ", 0, 6);
			if(!Player_Jailed[playerid])
			{
			    switch(SelectedTeam[playerid])
			    {
			        case 0..19: // 경찰
			        {
                        GameTextForPlayer(playerid, "~w~Try and bust all the criminals by killing them and prevent them from rescuing team mates.", 10000, 4);
			            SetPlayerPos(playerid, Cop_Spawn[rand][0], Cop_Spawn[rand][1], Cop_Spawn[rand][2]);
			            SetPlayerColor(playerid, COLOR_TEAM_BODYGUARD);
			            SetPlayerTeam(playerid, 1);
			        }
			        case 20..39: // 도둑
					{
					    GameTextForPlayer(playerid, "~w~Try and survive without all your team mates getting into prison.", 10000, 4);
			            SetPlayerPos(playerid, Robber_Spawn[rand][0], Robber_Spawn[rand][1], Robber_Spawn[rand][2]);
			            SetPlayerColor(playerid, COLOR_TEAM_TERRORIST);
			            SetPlayerTeam(playerid, 2);
			            SetPlayerCheckpoint(playerid, 1546.2869, -1675.637, 13.562, 2.0);
			            Rescue_Protocol[playerid] = 1;
					}
			    }
			}
			else
			{
			    PlayerPlaySound(playerid, 1068, 263.4187, 76.2712, 1001.039);
			    GameTextForPlayer(playerid, "~w~You are in jail, enjoy the music.", 10000, 4);
	            SetPlayerPos(playerid, Jail_Spawn[rand][0], Jail_Spawn[rand][1], Jail_Spawn[rand][2]);
	            SetPlayerFacingAngle(playerid, 270.0);
	            SetPlayerInterior(playerid, 6);
	            ResetPlayerWeapons(playerid);
				SetPlayerArmour(playerid,0);
				SetPlayerColor(playerid,COLOR_GREY);
				
				new criminalplayer, jailedplayer;
				for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
				{
					pid = GetConnectedPlayerID(i);
					if(GetPlayerTeam(playerid) == 2)
					{
						criminalplayer ++;
						if(Player_Jailed[pid]) jailedplayer++;
					}
				}
				if(criminalplayer == jailedplayer)
				{
					for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
					{
						pid = GetConnectedPlayerID(i);
						if(GetPlayerMap(pid) == 6)
						{
							if(GetPlayerLanguage(pid) == 0)
								SendClientMessage(playerid,COLOR_YELLOW, "[!] 모든 도둑이 경찰에게 잡혔습니다. 모든 도둑들이 풀려납니다!");
							else
							    SendClientMessage(playerid,COLOR_YELLOW, "[!] All the robbers were caught by the cop. they will be released!");
						}
					}
					ReleaseFromJail();
				}
			}
	    }
	}
}
//-----/ DisconnectHandler_6_CnR /----------------------------------------------
public DisconnectHandler_6_CnR(playerid,reason)
{
    PlayerTeam[playerid] = false;
    Player_Jailed[playerid] = false;
    Rescue_Protocol[playerid] = 0;
    Player_Gang_ID[playerid] = 0;
    GangInviteTimeout(playerid);
}
//-----/ DeathHandler_6_CnR /---------------------------------------------------
public DeathHandler_6_CnR(playerid,killerid,reason)
{
	if(GetPlayerMap(playerid) == 6)
	{
		if(GetPlayerTeam(playerid) == 2)
		    Player_Jailed[playerid] = true;
	}
}
//-----/ CommandHandler_6_CnR /---------------------------------------------------
public CommandHandler_6_CnR(playerid,cmdtext[]) //return 1: processed
{
	if(GetPlayerMap(playerid) == 6)
	{
		new
			cmd[256],idx,
			string[128]
		;
		cmd = strtok(cmdtext,idx);
		if(!strcmp("/help",cmd) || !strcmp("/?",cmd) || !strcmp("/도움말",cmd))
		{
			if(GetPlayerLanguage(playerid) == 0)
				SendClientMessage(playerid,COLOR_WHITE,"* /갱 /갱채팅 /무기구입");
			else
				SendClientMessage(playerid,COLOR_WHITE,"* /gang /gangchat /buygun");
			return 1;
		}
		if(!strcmp("/release",cmd) || !strcmp("/석방",cmd))
		{
		    if(!IsPlayerAdminEx(playerid))
		    {
			    if(GetPlayerLanguage(playerid) == 0)
			    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 이 관리자 명령어를 사용할 권한이 없습니다.");
				else
				    return SendClientMessage(playerid,COLOR_WHITE,"[!] You do not have permission to use this administrator command.");
			}
			
			for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
			{
				pid = GetConnectedPlayerID(i);
				if(GetPlayerMap(pid) == 6)
				{
					if(GetPlayerLanguage(pid) == 0)
						SendClientMessage(playerid,COLOR_YELLOW, "[!] 관리자가 모든 도둑들을 석방시켰습니다.");
					else
					    SendClientMessage(playerid,COLOR_YELLOW, "[!] The Administrator released all the robbers.");
				}
			}
			
			ReleaseFromJail();
			return 1;
		}
		
		if(!strcmp("/무기구입",cmd) || !strcmp("/buygun",cmd) || !strcmp("/무기구매",cmd) || !strcmp("/gunbuy",cmd))
		{
		    ShowPlayerWeaponDialog(playerid);
		    return 1;
		}
		
		if(!strcmp("/갱",cmd) || !strcmp("/gang",cmd) || !strcmp("/팩션",cmd) || !strcmp("/faction",cmd))
		{
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd))
			{
			    if(GetPlayerLanguage(playerid) == 0)
					return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /갱 [생성/초대/추방/수락/탈퇴]");
				else
				    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /gang [Create/Invite/Kick/Join/Quit]");
			}
			else if(!strcmp("생성",cmd) || !strcmp("create",cmd))
			{
				if(Player_Gang_ID[playerid] > 0)
    			{
    			    if(GetPlayerLanguage(playerid) == 0)
						return SendClientMessage(playerid,COLOR_WHITE,"[!] 이미 소속된 갱이 있습니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You are already in gang.");
				}
				Player_Gang_ID[playerid] = playerid+1;
				SendClientMessage(playerid,COLOR_WHITE,"[!] 갱을 생성하였습니다.");
			}
			else if(!strcmp("수락",cmd) || !strcmp("join",cmd))
			{
				if(Player_Gang_ID[playerid] > 0)
    			{
    			    if(GetPlayerLanguage(playerid) == 0)
						return SendClientMessage(playerid,COLOR_WHITE,"[!] 이미 소속된 갱이 있습니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You are already in gang.");
				}
				if(Player_Gang_Invited[playerid] == 0)
    			{
    			    if(GetPlayerLanguage(playerid) == 0)
						return SendClientMessage(playerid,COLOR_WHITE,"[!] 갱 초대를 받지 않았습니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You are not invited from gang.");
				}
				//-----
				for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
				{
					pid = GetConnectedPlayerID(i);
					if(Player_Gang_ID[playerid] == Player_Gang_ID[pid])
					{
					    if(GetPlayerLanguage(pid) == 0)
							format(string,sizeof(string),"[!] %s(%d)님이 갱에 합류하였습니다.",GetPlayerNameEx(playerid),playerid);
						else
						  	format(string,sizeof(string),"[!] %s(%d) have joined the gang.",GetPlayerNameEx(playerid),playerid);
						SendClientMessage(pid,COLOR_WHITE,string);
					}
				}
			    if(GetPlayerLanguage(playerid) == 0)
					format(string,sizeof(string),"[!] %s(%d)님의 갱에 합류하였습니다.",GetPlayerNameEx(playerid),playerid);
				else
				  	format(string,sizeof(string),"[!] You %s(%d) have joined %s(%d)`s gang",GetPlayerNameEx(playerid),playerid,GetPlayerNameEx(Player_Gang_ID[playerid]-1),Player_Gang_ID[playerid]-1);
				SendClientMessage(playerid,COLOR_WHITE,string);
				//-----
				Player_Gang_ID[playerid] = Player_Gang_Invited[playerid];
				GangInviteTimeout(playerid);
			}
			else if(!strcmp("추방",cmd) || !strcmp("invite",cmd))
			{
				if(Player_Gang_ID[playerid] != playerid+1)
    			{
    			    if(GetPlayerLanguage(playerid) == 0)
						return SendClientMessage(playerid,COLOR_WHITE,"[!] 갱의 리더만 사용할 수 있습니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You are not gang leader.");
				}
                cmd = strtok(cmdtext,idx);
				if(!strlen(cmd))
				{
				    if(GetPlayerLanguage(playerid) == 0)
				    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /갱 추방 [번호]");
					else
					    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /gang kick [playerid]");
				}
				new destid = strval(cmd);
				if(destid == INVALID_PLAYER_ID || GetPlayerMap(playerid) != GetPlayerMap(destid))
				{
				    if(GetPlayerLanguage(playerid) == 0)
				    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 잘못된 유저 정보입니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
				}
				if(Player_Gang_ID[destid] != Player_Gang_ID[playerid])
				{
				    if(GetPlayerLanguage(playerid) == 0)
				    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 그 유저는 같은 갱에 속해있지 않습니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] The player is not in same gang.");
				}
				if(playerid == destid)
				{
				    if(GetPlayerLanguage(playerid) == 0)
				    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 자기 자신을 추방할 순 없습니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You can`t kick yourself.");
				}
				//-----
			    if(GetPlayerLanguage(destid) == 0)
			        SendClientMessage(destid,COLOR_WHITE,"[!] 갱 리더에 의해 갱에서 추방당했습니다.");
				else
				    SendClientMessage(destid,COLOR_WHITE,"[!] You have been kicked by leader from gang.");
				
			    if(GetPlayerLanguage(playerid) == 0)
			        format(string,sizeof(string),"[!] 갱 리더가 %s(%d)님을 갱에서 추방하였습니다.",GetPlayerNameEx(destid),destid);
				else
				    format(string,sizeof(string),"[!] Your gang leader kick %s(%d) from your gang.",GetPlayerNameEx(destid),destid);
				for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
				{
					pid = GetConnectedPlayerID(i);
					if(Player_Gang_ID[playerid] == Player_Gang_ID[pid])
						SendClientMessage(playerid,COLOR_WHITE,string);
				}
				//-----
				Player_Gang_ID[destid] = 0;
				GangInviteTimeout(destid);
			}
			else if(!strcmp("초대",cmd) || !strcmp("invite",cmd))
			{
				if(Player_Gang_ID[playerid] != playerid+1)
    			{
    			    if(GetPlayerLanguage(playerid) == 0)
						return SendClientMessage(playerid,COLOR_WHITE,"[!] 갱의 리더만 사용할 수 있습니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You are not gang leader.");
				}
                cmd = strtok(cmdtext,idx);
				if(!strlen(cmd))
				{
				    if(GetPlayerLanguage(playerid) == 0)
				    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /갱 초대 [번호]");
					else
					    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /gang invite [playerid]");
				}
				new destid = strval(cmd);
				if(destid == INVALID_PLAYER_ID || GetPlayerMap(playerid) != GetPlayerMap(destid))
				{
				    if(GetPlayerLanguage(playerid) == 0)
				    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 잘못된 유저 정보입니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You entered invalid playerid.");
				}
				if(Player_Gang_ID[destid] != 0)
				{
				    if(GetPlayerLanguage(playerid) == 0)
				    	return SendClientMessage(playerid,COLOR_WHITE,"[!] 이미 다른 갱에 속해있는 유저입니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] The player is already in another gang");
				}
				//-----
			    if(GetPlayerLanguage(destid) == 0)
			        format(string,sizeof(string),"[!] %s(%d)님이 갱에 초대하였습니다. 수락하려면 [/갱 수락]을 입력해주세요.",GetPlayerNameEx(playerid),playerid);
				else
				    format(string,sizeof(string),"[!] %s(%d) have invited you to the gang. If you want to join, Enter [/gang join]",GetPlayerNameEx(playerid),playerid);
				SendClientMessage(destid,COLOR_WHITE,string);
				
			    if(GetPlayerLanguage(playerid) == 0)
			        format(string,sizeof(string),"[!] 갱 리더가 %s(%d)님을 갱에 초대하였습니다.",GetPlayerNameEx(destid),destid);
				else
				    format(string,sizeof(string),"[!] Your gang leader have invited %s(%d) to your gang.",GetPlayerNameEx(destid),destid);
				for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
				{
					pid = GetConnectedPlayerID(i);
					if(Player_Gang_ID[playerid] == Player_Gang_ID[pid])
						SendClientMessage(playerid,COLOR_WHITE,string);
				}
				//-----
				Player_Gang_Invited[destid] = playerid+1;
				SetTimerEx("GangInviteTimeout",5000,false,"d",destid);
			}
			else if(!strcmp("탈퇴",cmd) || !strcmp("quit",cmd))
			{
				if(Player_Gang_ID[playerid] == 0)
				{
				    if(GetPlayerLanguage(playerid) == 0)
    					return SendClientMessage(playerid,COLOR_WHITE,"[!] 어느 갱에도 속해있지 않습니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You are not in any gang.");
				}
				if(Player_Gang_ID[playerid] == playerid+1)
					DestroyGang(playerid+1);
				else
				{
					for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
					{
						pid = GetConnectedPlayerID(i);
						if(Player_Gang_ID[playerid] == Player_Gang_ID[pid])
						{
						    if(GetPlayerLanguage(pid) == 0)
								format(string,sizeof(string),"[!] %s(%d)님이 갱에 탈퇴하였습니다.",GetPlayerNameEx(playerid),playerid);
							else
							  	format(string,sizeof(string),"[!] %s(%d) have left the gang.",GetPlayerNameEx(playerid),playerid);
							SendClientMessage(pid,COLOR_WHITE,string);
						}
					}
					//-----
				    Player_Gang_ID[playerid] = 0;
				    GangInviteTimeout(playerid);
				}
			}
			else
			{
			    if(GetPlayerLanguage(playerid) == 0)
					return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /갱 [생성/초대/추방/수락/탈퇴]");
				else
				    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: /gang [Create/Invite/Kick/Join/Quit]");
			}
			return 1;
		}

		if(!strcmp("/gc",cmd,true) || !strcmp("/gangchat",cmd,true) || !strcmp("/갱채팅",cmd,true) || !strcmp("/갱챗",cmd,true) || !strcmp("/갱채",cmd,true))
		{
			if(Player_Gang_ID[playerid] == 0)
			{
			    if(GetPlayerLanguage(playerid) == 0)
					return SendClientMessage(playerid,COLOR_WHITE,"[!] 어느 갱에도 속해있지 않습니다.");
				else
				    return SendClientMessage(playerid,COLOR_WHITE,"[!] You are not in any gang.");
			}
			//-----
			cmd = strtok(cmdtext,idx);
			if(!strlen(cmd))
			{
			    if(GetPlayerLanguage(playerid) == 0)
			    	return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: (/갱)채팅 [내용]");
				else
				    return SendClientMessage(playerid,COLOR_GREY,"[!] Usage: (/g)ang(c)hat [Text]");
			}
			//-----
			strcpy(string,stringslice_c(cmdtext,1));
			SendGangMessage(playerid,string);
			return 1;
		}
	
	}
	return 0;
}
//-----/ EnterCPHandler_6_CnR /-------------------------------------------------
public EnterCPHandler_6_CnR(playerid)
{
	if(GetPlayerMap(playerid) == 6)
	{
		if(GetPlayerTeam(playerid) == 2)
		{
			if(Rescue_Protocol[playerid] == 1)
			{
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, 246.5764, 67.1342, 1003.6409, 2.0);
				Rescue_Protocol[playerid] = 2;
				GameTextForPlayer(playerid, "~r~Find the checkpoint inside the police station to rescue your team mates!", 10000, 4);
			}
			else if(Rescue_Protocol[playerid] == 2)
			{
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, 268.3572, 77.8658, 1001.039, 2.0);
				Rescue_Protocol[playerid] = 3;
			}
			else if(Rescue_Protocol[playerid] == 3)
			{
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, 1546.2869, -1675.637, 13.562, 2.0);
				Rescue_Protocol[playerid] = 1;
				for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
				{
					pid = GetConnectedPlayerID(i);
					if(GetPlayerMap(pid) == 6)
					{
						if(GetPlayerLanguage(pid) == 0)
							SendClientMessage(playerid,COLOR_YELLOW, "[!] 한 도둑이 수감된 도둑들을 풀어주는데 성공했습니다!");
						else
						    SendClientMessage(playerid,COLOR_YELLOW, "[!] A robber succeeded in freeing the freed robbers!");
					}
				}
				ReleaseFromJail();
				GameTextForPlayer(playerid, "~r~You rescued your team mates! ~n~(Money +500, Point +5)", 10000, 4);
	    		GivePlayerPoint(playerid, 5);
				GivePlayerMoneyEx(playerid, 500);
			}
		}
	}
}
//-----/ UpdateHandler_6_CnR /--------------------------------------------------
public UpdateHandler_6_CnR(playerid)
{
	if(GetPlayerMap(playerid) == 6)
	{
		if(!PlayerTeam[playerid])
		{
		    new Keys,ud,lr;
		    GetPlayerKeys(playerid,Keys,ud,lr);
		    if(lr == KEY_LEFT) // 왼쪽으로
		    {
		        SelectedTeam[playerid] --;
		        if(SelectedTeam[playerid] < 0)
		            SelectedTeam[playerid] = 39;
				SetSelectionInfo_6(playerid);
		    }
		    else if(lr == KEY_RIGHT) // 오른쪽으로
		    {
	            SelectedTeam[playerid] ++;
	            SelectedTeam[playerid] %= 40;
	            SetSelectionInfo_6(playerid);
		    }
		}
	}
}
//-----/ KeyHandler_6_CnR /-----------------------------------------------------
public KeyHandler_6_CnR(playerid,newkeys,oldkeys)
{
	if(GetPlayerMap(playerid) == 6)
	{
		if(!PlayerTeam[playerid])
		{
		    if(newkeys == KEY_JUMP || newkeys == KEY_YES) // 선택
		    {
		        PlayerTeam[playerid] = true;
				new len = GetPlayerLanguage(playerid);
		        if(SelectedTeam[playerid] >= 0 && SelectedTeam[playerid] <= 19) // 경찰팀
		        {
		            if(Team_Balance >= 5)
					{
					    if(len == 0)
					    	SendClientMessage(playerid,COLOR_WHITE,"* 팀 밸런스가 적절치 않습니다. 테러리스트 팀을 선택해주세요.");
						else
						    SendClientMessage(playerid,COLOR_WHITE,"* Team balance is not appropriate. Please select a terrorist team.");
					    return 0;
					}

		            Team_Balance ++;
		        }
		        else if(SelectedTeam[playerid] >= 20 && SelectedTeam[playerid] <= 39) // 도둑팀
		        {
		            if(Team_Balance <= -5)
					{
					    if(len == 0)
					    	SendClientMessage(playerid,COLOR_WHITE,"* 팀 밸런스가 적절치 않습니다. 경호 팀을 선택해주세요.");
						else
						    SendClientMessage(playerid,COLOR_WHITE,"* Team balance is not appropriate. Please select a bodyguard team.");
					    return 0;
					}
		            Team_Balance --;
		        }
		        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		        SetCameraBehindPlayer(playerid);
		        UnFreezePlayer(playerid);
		        SpawnPlayer(playerid);
		    }
		}
	}
	return 0;
}
//-----/ DialogHandler_6_CnR /--------------------------------------------------
public DialogHandler_6_CnR(playerid,dialogid,response,listitem,inputtext[])
{
	switch(dialogid)
	{
	    case DialogID_6_CnR(0):
	    {
	        if(response)
	        {
				if(GetPlayerMoney(playerid) < WeaponInfo[listitem][1])
				{
				    if(GetPlayerLanguage(playerid) == 0)
				        return SendClientMessage(playerid,COLOR_WHITE,"[!] 소지금이 부족합니다.");
					else
					    return SendClientMessage(playerid,COLOR_WHITE,"[!] You don`t have enough money.");
				}
				GivePlayerWeapon(playerid,WeaponInfo[listitem][0],WeaponInfo[listitem][2]);
				GivePlayerMoneyEx(playerid,-WeaponInfo[listitem][1]);
				
				if(GetPlayerLanguage(playerid) == 0)
					SendClientMessage(playerid, COLOR_WHITE, "* 선택한 무기를 구입하였습니다.");
				else
				    SendClientMessage(playerid, COLOR_WHITE, "* You bought the weapon that you selected.");
	        }
	    }
	}
	return 0;
}


//==========/ Functions /=======================================================
//-----/ SetSelectionInfo_6 /---------------------------------------------------
stock SetSelectionInfo_6(playerid)
{
	if(SelectedTeam[playerid] >= 0 && SelectedTeam[playerid] <= 19)
	    GameTextForPlayer(playerid,"~h~~b~Cop",90000,6);
	else
	    GameTextForPlayer(playerid,"~h~~r~Robber",90000,6);
	SetPlayerSkin(playerid,SkinInfo_6[SelectedTeam[playerid]]);
}
//-----/ ResetVariable_6 /------------------------------------------------------
stock ResetVariable_6(playerid)
{
    Rescue_Protocol[playerid] = 0;
    Player_Jailed[playerid] = false;
    Player_Gang_ID[playerid] = 0;
    GangInviteTimeout(playerid);
}
//-----/ ReleaseFromJail /------------------------------------------------------
stock ReleaseFromJail()
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(Player_Jailed[pid])
		{
			Player_Jailed[pid] = false;
			SetPlayerColor(pid, COLOR_TEAM_TERRORIST);
			PlayerPlaySound(pid, 1069, 0.0, 0.0, 0.0);
			SetPlayerInterior(pid, 6);
			SetPlayerPos(pid, 268.8174,78.0760,1001.0390);
			SetPlayerFacingAngle(pid, 89.9040);
			SetPlayerTeam(pid,2);
			GivePlayerWeapon(pid, 24, 56);
		}
	}
}
//-----/ SendGangMessage /------------------------------------------------------
stock SendGangMessage(playerid,text[])
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(Player_Gang_ID[playerid] == Player_Gang_ID[pid])
		{
		    new string[312];
		    if(GetPlayerLanguage(playerid) == 0)
		    	format(string,sizeof(string),"[갱채팅] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
			else
			    format(string,sizeof(string),"[GangChat] %s(%d): %s",GetPlayerNameEx(playerid),playerid,text);
		    SendClientMessage(pid,0xC16200FF,string);
		}
	}
}
//-----/ DestroyGang /----------------------------------------------------------
stock DestroyGang(gangid)
{
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(Player_Gang_Invited[pid] == gangid)
		{
		    GangInviteTimeout(pid);
			if(GetPlayerLanguage(pid) == 0)
		    	SendClientMessage(pid,COLOR_WHITE,"[!] 초대 받은 갱이 해체되었습니다.");
			else
			    SendClientMessage(pid,COLOR_WHITE,"[!] The gang invited you has been disbanded.");
		}
		if(Player_Gang_ID[pid] == gangid)
		{
		    Player_Gang_ID[pid] = 0;
		    if(GetPlayerLanguage(pid) == 0)
		    	SendClientMessage(pid,COLOR_WHITE,"[!] 속해있던 갱이 해체되었습니다.");
			else
			    SendClientMessage(pid,COLOR_WHITE,"[!] The gang you belonged to has been disbanded.");
		}
	}
}
//-----/ GangInviteTimeout /----------------------------------------------------
public GangInviteTimeout(playerid)
{
	KillTimer(Player_Gang_Timer[playerid]);
	Player_Gang_Invited[playerid] = 0;
}
//-----/ ShowPlayerWeaponDialog /-----------------------------------------------
stock ShowPlayerWeaponDialog(playerid)
{
	new string[2048];
	new str[128];
	if(GetPlayerLanguage(playerid) == 0)
		strcat(string,""C_PASTEL_YELLOW"이름\t"C_PASTEL_YELLOW"가격\t"C_PASTEL_YELLOW"총알\n");
	else
	    strcat(string,""C_PASTEL_YELLOW"Name\t"C_PASTEL_YELLOW"Price\t"C_PASTEL_YELLOW"Ammo\n");
	    
	for(new i=0; i<MAX_WEAPON; i++)
	{
		new gunname[32];
	    GetWeaponName(WeaponInfo[i][0], gunname, sizeof(gunname));
	    format(str,sizeof(str),""C_WHITE"%s\t"C_WHITE"%d\t"C_WHITE"%d\n",gunname,WeaponInfo[i][1],WeaponInfo[i][2]);
  		strcat(string,str);
	}
		
    if(GetPlayerLanguage(playerid) == 0)
		ShowPlayerDialog(playerid,DialogID_6_CnR(0),DIALOG_STYLE_TABLIST_HEADERS,""C_PASTEL_GREEN"무기 구입"C_WHITE" (일회성 무기입니다. 사망할 시 무기가 사라집니다) ",string,"구입","취소");
	else
	    ShowPlayerDialog(playerid,DialogID_6_CnR(0),DIALOG_STYLE_TABLIST_HEADERS,""C_PASTEL_GREEN"Buy Weapon"C_WHITE" (This weapon is one-off. If you die, you will lose your all weapons) ",string,"Buy","Cancel");
}
