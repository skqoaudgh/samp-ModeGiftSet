/*
  [Functions]
	SetSelectionInfo_6(playerid)
	ResetVariable_6(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_6_CnR
	#endinput
#endif
#define _MDPWN_6_CnR

//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1

//-----/ News /
	//--/ CnR /
new Team_Balance = 0;
new bool:Player_Jailed[MAX_PLAYERS];
new Rescue_Protocol[MAX_PLAYERS];

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

new SkinInfo_6[] = {
265,266,267,280,281,282,283,284,285,286,287,300,301,302,309,306,309,301,165,166, // ����
181,21,23,29,33,47,271,98,269,106,107,108,109,102,103,104,121,174,175,173 		 // ����
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
	//--/ Functions /


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
}

//-----/ InitHandler_6_CnR /----------------------------------------------------
public InitHandler_6_CnR()
{
	begin = AddStaticVehicle(596, 1535.7749, -1667.3227, 12.4751, 0.2375, 0, 1);
	AddStaticVehicle(596, 1535.8126, -1676.3747, 12.4751, 0.238, 0, 1);
	AddStaticVehicle(427, 1601.7467, -1629.9373, 12.5778, 89.7156, 0, 1);
	AddStaticVehicle(596, 1595.5562, -1710.0564, 4.983, 179.6777, 0, 1);
	AddStaticVehicle(596, 1587.4284, -1710.845, 4.9829, 180.6483, 0, 1);
	AddStaticVehicle(523, 1601.0412, -1700.0781, 4.9829, 269.2224, 0, 1);
	AddStaticVehicle(535, 2162.3024, -1703.0754, 13.8008, 272.3512, 7, 1);
	AddStaticVehicle(560, 2168.0895, -1677.1766, 13.806, 224.3493, 16, 16);
	AddStaticVehicle(535, 2189.8391, -1656.0167, 13.8137, 347.1693, 85, 85);
	AddStaticVehicle(560, 2184.1076, -1681.7242, 12.6093, 347.4096, 7, 7);
	AddStaticVehicle(581, 2178.5195, -1664.6644, 13.6668, 222.3536, 0, 1);
	AddStaticVehicle(400, 2197.6914, -1675.3465, 13.0265, 348.5928, 16, 16);
	AddStaticVehicle(536, 2171.7751, -1726.2933, 13.2349, 271.3572, 18, 1);
	AddStaticVehicle(536, 2170.2844, -1648.7586, 14.6083, 318.5802, 16, 16);
	AddStaticVehicle(567, 2156.5573, -1662.3901, 14.7587, 313.2276, 85, 85);
	AddStaticVehicle(567, 2187.6789, -1623.9759, 14.2546, 160.9718, 7, 1);
	AddStaticVehicle(519, 1425.3901, -2493.5623, 14.4835, 268.7735, 1, 1);
	AddStaticVehicle(519, -1639.306, -148.3752, 15.0726, 315.1575, 1, 1);
	AddStaticVehicle(593, 1944.077, -2642.722, 14.0017, 358.0437, 68, 8);
	AddStaticVehicle(593, 1965.7038, -2643.0013, 14.0075, 0.6567, 2, 1);
	AddStaticVehicle(520, 308.0575, 1801.7359, 18.3638, 0.6013, 0, 0);
	AddStaticVehicle(520, 276.8438, 2024.7451, 18.3638, 269.2513, 0, 0);
	AddStaticVehicle(567, 1998.8455, -2093.7139, 13.4172, 179.3739, 77, 26);
	AddStaticVehicle(567, 2318.6079, -2314.5865, 13.4163, 226.1835, 77, 26);
	AddStaticVehicle(567, 2114.3349, -2161.9876, 13.4186, 358.4043, 77, 26);
	AddStaticVehicle(567, 1793.6252, -2119.9979, 13.3361, 268.4345, 3, 3);
	AddStaticVehicle(567, 1846.5335, -2145.7554, 13.3305, 179.0391, 77, 26);
	AddStaticVehicle(567, 1819.5302, -2020.9955, 13.1662, 180.5588, 77, 26);
	AddStaticVehicle(567, 1886.2353, -2021.8167, 13.1735, 180.2953, 77, 26);
	AddStaticVehicle(439, 803.0838, -1737.444, 13.3287, 179.0346, 77, 26);
	AddStaticVehicle(439, 647.6434, -1656.1121, 14.8319, 0.6496, 32, 8);
	AddStaticVehicle(439, 761.2152, -1660.0455, 4.0995, 86.8627, 32, 8);
	AddStaticVehicle(439, 903.9887, -1455.3766, 12.9525, 270.0151, 77, 26);
	AddStaticVehicle(445, 808.5872, -1464.2021, 13.081, 85.9945, 43, 43);
	AddStaticVehicle(445, 1648.3237, -1136.0062, 23.6212, 359.7817, 0, 0);
	AddStaticVehicle(445, 1590.4649, -1315.3196, 17.2164, 268.8727, 0, 0);
	AddStaticVehicle(445, 1714.2255, -1601.2035, 13.2596, 261.5271, 0, 0);
	AddStaticVehicle(540, 1022.95, -1137.1359, 23.4363, 90.2181, 77, 26);
	AddStaticVehicle(540, 1073.5498, -1103.0308, 24.5883, 267.2265, 77, 26);
	AddStaticVehicle(540, 972.1492, -1091.7345, 23.9813, 90.8632, 77, 26);
	AddStaticVehicle(540, 1077.259, -1772.6647, 12.9223, 89.8721, 6, 25);
	AddStaticVehicle(540, 333.8363, -1520.0607, 35.7621, 322.3912, 32, 8);
	AddStaticVehicle(540, 805.283, -1344.5556, 13.3413, 178.302, 77, 26);
	AddStaticVehicle(581, 2099.7204, -994.3968, 53.6088, 0.4158, 77, 26);
	AddStaticVehicle(581, 2023.2752, -960.7878, 39.3572, 204.7902, 77, 26);
	AddStaticVehicle(581, 2011.2349, -979.0713, 35.3748, 206.7678, 77, 26);
	AddStaticVehicle(581, 2030.8878, -1348.1264, 23.5771, 269.8645, 77, 26);
	AddStaticVehicle(581, 1722.0648, -1278.4799, 13.1438, 178.6602, 77, 26);
	AddStaticVehicle(581, 2227.9191, -1167.0313, 25.3323, 85.5935, 77, 26);
	AddStaticVehicle(487, 1543.9259, -1353.4107, 329.6491, 270.4592, 29, 42);
	AddStaticVehicle(487, -1361.5871, -492.6511, 14.3486, 203.8937, 29, 42);
	AddStaticVehicle(487, 1916.5373, -2319.3125, 13.7243, 270.4679, 29, 42);
	AddStaticVehicle(476, 290.2703, 2543.1269, 17.5296, 177.6405, 7, 6);
	AddStaticVehicle(476, 324.9189, 2538.5368, 17.52, 177.5668, 1, 6);
	AddStaticVehicle(568, -370.4795, 2231.2878, 42.3474, 100.8292, 9, 39);
	AddStaticVehicle(568, -369.8746, 2227.2326, 42.3502, 98.2434, 17, 1);
	AddStaticVehicle(409, 2038.7363, 1008.5133, 10.4718, 359.5103, 1, 1);
	AddStaticVehicle(409, 2176.3696, 1676.9595, 10.6203, 359.7546, 1, 1);
	AddStaticVehicle(523, 1542.0605, -1623.7367, 12.9534, 89.1428, 0, 0);
	AddStaticVehicle(523, 1969.951, -2180.3428, 13.1135, 359.1487, 0, 0);
	AddStaticVehicle(522, 2483.5708, -1654.7432, 12.8817, 89.3684, 6, 25);
	AddStaticVehicle(522, 1907.3941, -1356.0187, 13.0683, 269.8377, 6, 25);
	AddStaticVehicle(522, 2518.5207, -1282.1252, 34.4145, 358.8864, 6, 25);
	AddStaticVehicle(522, 2803.915, -1252.8952, 46.5243, 154.3838, 6, 25);
	AddStaticVehicle(522, -2313.5264, -1629.045, 483.2737, 214.5184, 39, 106);
	AddStaticVehicle(467, 1834.811, -1871.4095, 13.128, 359.8713, 60, 1);
	AddStaticVehicle(467, 2051.6411, -1694.7037, 13.2945, 268.8799, 58, 8);
	AddStaticVehicle(402, 2416.9338, 91.2872, 26.3052, 89.4945, 22, 22);
	AddStaticVehicle(402, 889.2772, -22.1742, 63.1049, 152.7799, 30, 30);
	AddStaticVehicle(490, 1547.1423, -1697.4933, 13.677, 87.4331, 0, 0);
	AddStaticVehicle(490, 1549.2064, -1721.8471, 13.6842, 89.5649, 0, 0);
	AddStaticVehicle(545, 2485.7199, -1556.0071, 23.8628, 179.6562, 85, 1);
	AddStaticVehicle(545, 2416.4418, -1719.5232, 13.5579, 178.888, 85, 1);
	AddStaticVehicle(463, -84.5783, -1188.6464, 1.2904, 70.4356, 84, 84);
	AddStaticVehicle(463, -82.3765, -1184.8461, 1.2943, 69.7823, 84, 84);
	AddStaticVehicle(463, -104.3539, -1194.3816, 2.025, 73.9355, 84, 84);
	AddStaticVehicle(463, -85.7097, -1582.2369, 2.1526, 234.9492, 84, 84);
	AddStaticVehicle(463, -70.0019, -1583.3386, 2.1568, 221.4333, 84, 84);
	AddStaticVehicle(463, -50.3783, -1566.5052, 2.1573, 167.8807, 84, 84);
	AddStaticVehicle(463, -374.2659, -1428.5876, 25.267, 357.5328, 84, 84);
	AddStaticVehicle(463, -369.1096, -1436.5741, 25.2661, 264.5083, 84, 84);
	AddStaticVehicle(463, -383.3793, -1417.5192, 25.2663, 266.746, 84, 84);
	AddStaticVehicle(463, 1731.4658, -1862.0237, 13.14, 268.6878, 0, 0);
	AddStaticVehicle(463, 1142.8435, -1379.4186, 13.3611, 177.2425, 0, 0);
	AddStaticVehicle(463, 592.7366, -1237.7538, 17.4955, 111.2245, 0, 0);
	AddStaticVehicle(463, 2310.3984, -74.8256, 26.0058, 90.7837, 0, 0);
	AddStaticVehicle(470, 1652.4154, -2525.1065, 13.5396, 270.3764, 43, 0);
	AddStaticVehicle(470, 1992.2714, -2351.7525, 13.5389, 0.3736, 43, 0);
	AddStaticVehicle(470, 275.9263, 1948.0249, 17.6401, 299.4493, 43, 0);
	AddStaticVehicle(470, 276.5101, 1963.0881, 17.635, 244.0523, 43, 0);
	AddStaticVehicle(518, 2425.8107, -1223.9208, 24.9668, 177.4548, 9, 39);
	AddStaticVehicle(541, -2026.9419, 124.8322, 28.7287, 358.3098, 58, 8);
	AddStaticVehicle(480, 2055.9375, -1903.9954, 13.3205, 180.7127, 2, 2);
	AddStaticVehicle(539, 810.5427, -1851.5019, 7.7238, 178.4058, 79, 74);
	AddStaticVehicle(563, 265.5409, -1804.9583, 5.0548, 270.1182, 1, 6);
	AddStaticVehicle(500, -17.0364, -2503.7686, 36.7602, 300.9899, 4, 119);
	AddStaticVehicle(505, -1573.6011, -2729.7381, 48.6875, 325.0676, 13, 118);
	AddStaticVehicle(433, 278.4312, 1989.5758, 18.0786, 269.4515, 43, 0);
	AddStaticVehicle(444, 2646.4084, -2003.5474, 13.4659, 270.5392, 0, 0);
	AddStaticVehicle(560, 951.8214, -1369.1241, 13.0485, 179.2388, 17, 1);
	AddStaticVehicle(511, 1315.5675, 1362.8664, 12.1933, 269.4338, 4, 90);
	AddStaticVehicle(461, 2392.7109, -1898.2096, 13.0572, 270.2731, 74, 1);
	AddStaticVehicle(452, 2940.2182, -2043.6281, -0.3897, 269.1659, 1, 5);
	AddStaticVehicle(429, -2746.7317, -280.089, 6.7213, 359.5281, 79, 3);
	AddStaticVehicle(575, -2634.2525, 1377.7271, 6.739, 358.6343, 10, 5);
	AddStaticVehicle(493, -1894.4052, 1400.3046, -0.1589, 92.0589, 36, 13);
	AddStaticVehicle(468, 1260.1345, 289.1567, 19.2233, 339.1774, 103, 103);
	AddStaticVehicle(603, -1445.945, -1577.2728, 101.5998, 269.3623, 0, 0);
	AddStaticVehicle(521, 1968.3383, -2184.6834, 13.1129, 0.637, 75, 13);
	AddStaticVehicle(400, 2505.7255, -1694.169, 13.5523, 0.9891, 16, 0);
	AddStaticVehicle(542, 2075.6843, -1784.4133, 13.2434, 344.0244, 72, 39);
	//AddStaticVehicle(425, 309.4631, 2047.7318, 18.2168, 175.9589, 43, 0);
	AddStaticVehicle(404, 2305.3395, -1634.945, 14.2569, 179.7301, 77, 26);
	AddStaticVehicle(518, 1278.4801, 171.0043, 19.777, 61.1377, 103, 103);
	AddStaticVehicle(500, 1549.2889, -27.3942, 20.9925, 271.019, 103, 103);
	AddStaticVehicle(505, 1930.1468, 172.5841, 36.9499, 68.7444, 103, 103);
	AddStaticVehicle(560, 1389.0529, 265.5415, 19.236, 333.0997, 103, 103);
	AddStaticVehicle(468, 1752.9483, -1036.5905, 23.8567, 178.7866, 77, 26);
	AddStaticVehicle(603, 1567.6072, -1011.5071, 23.8052, 2.4702, 77, 26);
	AddStaticVehicle(521, 1357.9028, -616.3965, 109.0281, 50.2854, 77, 26);
	AddStaticVehicle(400, 1037.2121, -638.3393, 120.0207, 334.2542, 77, 26);
	AddStaticVehicle(542, 723.6323, -994.5109, 52.4397, 145.5513, 77, 26);
	AddStaticVehicle(404, 405.7481, -1152.4518, 77.0057, 148.5489, 77, 26);
	AddStaticVehicle(522, 204.973, -230.4092, 1.6744, 177.8984, 77, 26);
	AddStaticVehicle(521, 313.6477, -55.8182, 1.4743, 181.1273, 77, 26);
	AddStaticVehicle(518, 199.6054, -144.7829, 1.4797, 88.1766, 77, 26);
	AddStaticVehicle(473, 389.7571, -267.124, 0.6564, 226.3941, 77, 26);
	AddStaticVehicle(505, 1045.3934, -306.0377, 73.8888, 179.1813, 77, 26);
	AddStaticVehicle(560, 1223.775, -902.8022, 42.7961, 191.0858, 77, 26);
	AddStaticVehicle(468, 787.7534, -608.4427, 16.1954, 348.4307, 77, 26);
	AddStaticVehicle(603, 667.0645, -461.3056, 16.1937, 90.3768, 77, 26);
	AddStaticVehicle(521, 748.1793, 382.4213, 23.0328, 280.7962, 77, 26);
	AddStaticVehicle(463, 1907.1712, 957.7847, 10.6813, 179.4651, 77, 26);
	AddStaticVehicle(402, 2142.0351, 1012.9923, 10.6761, 88.3526, 77, 26);
	AddStaticVehicle(522, 2039.8908, 1295.4885, 10.5331, 359.1798, 77, 26);
	AddStaticVehicle(445, 2129.7016, 1409.0985, 10.683, 0.8938, 77, 26);
	AddStaticVehicle(480, 1944.7705, 1345.2595, 8.9668, 180.7324, 77, 26);
	AddStaticVehicle(541, 2207.3916, 1788.1927, 10.6798, 359.8085, 77, 26);
	AddStaticVehicle(429, 2186.3342, 1992.1213, 10.6815, 89.458, 77, 26);
	AddStaticVehicle(409, 2483.8332, 2133.0483, 10.5331, 267.6821, 77, 26);
	AddStaticVehicle(402, 2610.301, 2279.4968, 10.6794, 88.8308, 77, 26);
	AddStaticVehicle(522, 2127.8947, 2355.1132, 10.5354, 89.1345, 77, 26);
	AddStaticVehicle(445, 1952.2722, 2290.1689, 10.68, 89.4549, 77, 26);
	AddStaticVehicle(480, 1748.5616, 2213.2133, 10.6814, 89.8264, 37, 37);
	AddStaticVehicle(541, 1544.9561, 2088.9099, 11.2308, 91.0019, 37, 37);
	AddStaticVehicle(429, 1316.0517, 1936.1057, 11.2456, 178.7662, 37, 37);
	AddStaticVehicle(463, 767.4005, 2018.5306, 6.0387, 263.0834, 37, 37);
	AddStaticVehicle(402, 1184.2098, 1254.6003, 9.357, 179.7879, 37, 37);
	AddStaticVehicle(522, 1519.1418, 787.6638, 10.6813, 358.7261, 37, 37);
	AddStaticVehicle(445, 1849.7617, 698.8828, 11.2207, 269.9656, 37, 37);
	AddStaticVehicle(480, 2128.2321, 691.2327, 11.2379, 359.9301, 37, 37);
	AddStaticVehicle(541, 2361.3518, 651.1115, 11.2679, 179.8863, 37, 37);
	AddStaticVehicle(429, 2680.4462, 748.2318, 10.6803, 358.6536, 37, 37);
	AddStaticVehicle(463, -2318.8758, -125.9999, 34.9373, 180.0424, 58, 8);
	AddStaticVehicle(402, -2447.4942, -47.6903, 33.8941, 179.2868, 58, 8);
	AddStaticVehicle(522, -2594.1124, -190.9773, 3.9196, 88.4961, 58, 8);
	AddStaticVehicle(445, -2801.5293, -86.4694, 6.8916, 358.3644, 79, 3);
	AddStaticVehicle(480, -2738.865, 127.7293, 4.18, 182.005, 79, 3);
	AddStaticVehicle(541, -2665.0101, 267.9809, 4.0156, 359.1966, 79, 3);
	AddStaticVehicle(429, -2659.7681, 621.6314, 14.1328, 269.2994, 79, 3);
	AddStaticVehicle(429, -2377.3531, 1121.7296, 55.4062, 159.2433, 79, 3);
	AddStaticVehicle(429, -2048.2393, 1226.7698, 31.3281, 87.8713, 79, 3);
	AddStaticVehicle(429, -2065.5084, 1431.0651, 6.7803, 178.128, 79, 3);
	AddStaticVehicle(463, -1742.1899, 1385.9736, 6.8671, 47.665, 79, 3);
	AddStaticVehicle(402, -1556.0428, 1040.5018, 6.8671, 179.8155, 79, 3);
	AddStaticVehicle(429, -1604.1995, 781.7268, 6.5, 218.1439, 79, 3);
	AddStaticVehicle(522, -1670.3752, 441.6282, 6.8593, 222.8092, 79, 3);
	AddStaticVehicle(445, -1935.2027, 585.0178, 34.8058, 358.7294, 79, 3);
	AddStaticVehicle(480, -1948.6274, 797.2554, 55.4028, 88.9114, 79, 3);
	AddStaticVehicle(541, -2106.4446, 904.2263, 76.0926, 7.3215, 79, 3);
	AddStaticVehicle(463, -1956.6659, 262.4442, 40.6721, 268.8793, 58, 8);
	AddStaticVehicle(541, -2139.4644, 258.341, 34.984, 181.3157, 58, 8);
	AddStaticVehicle(522, -2074.1575, 306.3369, 41.617, 269.6965, 58, 8);
	AddStaticVehicle(402, -2265.3248, 204.2722, 34.7891, 89.477, 58, 8);
	AddStaticVehicle(522, -2415.1016, 330.1029, 34.597, 332.7446, 58, 8);
	AddStaticVehicle(500, -703.5867, -2676.2171, 92.5065, 266.7619, 4, 119);
	AddStaticVehicle(505, -642.4474, -2447.7947, 31.7247, 135.5718, 4, 119);
	AddStaticVehicle(560, -2143.2032, -2447.4607, 30.7728, 141.5773, 13, 118);
	AddStaticVehicle(468, -2239.9073, -2555.2427, 32.0656, 59.5955, 13, 118);
	AddStaticVehicle(468, -2405.2103, -2180.2339, 33.4329, 269.903, 13, 118);
	AddStaticVehicle(444, -1915.8572, -1672.0826, 23.1622, 271.6054, 13, 118);
	AddStaticVehicle(400, -1111.2332, -1621.0282, 76.5127, 269.2383, 13, 118);
	AddStaticVehicle(542, -582.7024, -1065.6852, 23.5459, 236.5289, 13, 118);
	AddStaticVehicle(473, 2098.0598, -106.7644, -0.5413, 221.5903, 0, 0);
	AddStaticVehicle(468, 2686.8588, 221.3811, 57.9735, 257.7325, 22, 22);
	AddStaticVehicle(518, 2339.9645, -654.2596, 128.7297, 186.1914, 22, 22);
	AddStaticVehicle(500, 1543.2188, 15.9257, 23.9685, 282.8633, 30, 30);
	AddStaticVehicle(505, 1005.3814, -71.9734, 21.8518, 111.5432, 30, 30);
	AddStaticVehicle(473, 124.2068, -897.8238, -0.5602, 152.1958, 0, 0);
	AddStaticVehicle(400, 188.9069, -552.7046, 48.7151, 34.4048, 0, 0);
	AddStaticVehicle(468, -2103.4317, -1747.8942, 195.7846, 328.488, 0, 0);
	AddStaticVehicle(522, -44.0174, 1167.5491, 19.5468, 355.0368, 0, 0);
	AddStaticVehicle(480, -30.5105, 996.3748, 19.6856, 175.559, 0, 0);
	AddStaticVehicle(480, 334.0848, -1809.2956, 4.2617, 179.5207, 2, 2);
	AddStaticVehicle(480, 441.6711, -1299.7544, 14.9504, 214.4154, 2, 2);
	AddStaticVehicle(542, 932.0219, -853.3588, 93.2433, 26.9008, 77, 26);
	AddStaticVehicle(447, 1291.4375, -789.1498, 96.6321, 180.2162, 29, 42);
	AddStaticVehicle(487, 1765.5297, -2285.9034, 26.9722, 177.8813, 29, 42);
	AddStaticVehicle(522, 1519.322, -1462.5329, 9.375, 180.5982, 0, 0);
	AddStaticVehicle(480, 451.34, -1492.7171, 30.8202, 15.3908, 0, 0);
	AddStaticVehicle(480, 343.5032, -1350.0289, 14.3828, 119.0693, 0, 0);
	AddStaticVehicle(445, 1128.2558, -1540.4594, 14.7573, 179.1578, 0, 0);
	end = AddStaticVehicle(522, 1338.8746, -1320.0261, 13.2438, 0.2407, 0, 0);
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
		if(!PlayerTeam[playerid]) // �� ����
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
			    SendClientMessage(playerid,COLOR_GREEN,"          ������ ����");
			    SendClientMessage(playerid,COLOR_WHITE,"�ν����佺�� ������ ���ϰ��� �� ������ �߹��߽��ϴ�.");
			    SendClientMessage(playerid,COLOR_WHITE,"�����е��� ���� Ȥ�� ������ �Ǿ� �ڽ��� ��ǥ�� �޼��ؾ� �մϴ�.");
			    SendClientMessage(playerid,COLOR_WHITE,"�ν����佺�� ����� ��� �� ���ΰ�..?");
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
			        case 0..19: // ����
			        {
                        GameTextForPlayer(playerid, "~w~Try and bust all the criminals by killing them and prevent them from rescuing team mates.", 10000, 4);
			            SetPlayerPos(playerid, Cop_Spawn[rand][0], Cop_Spawn[rand][1], Cop_Spawn[rand][2]);
			            SetPlayerColor(playerid, COLOR_TEAM_BODYGUARD);
			            SetPlayerTeam(playerid, 1);
			        }
			        case 20..39: // ����
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
					SendMessage(playerid,COLOR_GREY, "[!] ��� ������ �������� �������ϴ�. ��� ���ϵ��� Ǯ�����ϴ�!");
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
}
//-----/ DeathHandler_6_CnR /---------------------------------------------------
public DeathHandler_6_CnR(playerid,killerid,reason)
{
	if(GetPlayerTeam(playerid) == 2)
	    Player_Jailed[playerid] = true;
}
//-----/ CommandHandler_6_CnR /---------------------------------------------------
public CommandHandler_6_CnR(playerid,cmdtext[]) //return 1: processed
{
	if(GetPlayerMap(playerid) == 6)
	{
		new
			cmd[256],idx
			//string[128]
		;
		cmd = strtok(cmdtext,idx);
		if(!strcmp("/help",cmd) || !strcmp("/?",cmd) || !strcmp("/����",cmd))
		{
			if(GetPlayerLanguage(playerid) == 0)
				SendClientMessage(playerid,COLOR_WHITE,"* �� ���� ������ �����ϴ�.");
			else
				SendClientMessage(playerid,COLOR_WHITE,"* This map has no help message.");
			return 1;
		}
	}
	return 0;
}

public EnterCPHandler_6_CnR(playerid)
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
			ReleaseFromJail();
			GameTextForPlayer(playerid, "~r~You rescued your team mates! ~n~(Money +500, Point +5)", 10000, 4);
    		GivePlayerPoint(playerid, 5);
			SetPVarInt(playerid,"Money",GetPVarInt(playerid,"Money")+500);
			
		}
	}
}
//-----/ UpdateHandler_6_CnR /--------------------------------------------
public UpdateHandler_6_CnR(playerid)
{
	if(GetPlayerMap(playerid) == 6)
	{
		if(!PlayerTeam[playerid])
		{
		    new Keys,ud,lr;
		    GetPlayerKeys(playerid,Keys,ud,lr);
		    if(lr == KEY_LEFT) // ��������
		    {
		        SelectedTeam[playerid] --;
		        if(SelectedTeam[playerid] < 0)
		            SelectedTeam[playerid] = 39;
				SetSelectionInfo_6(playerid);
		    }
		    else if(lr == KEY_RIGHT) // ����������
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
		    if(newkeys == KEY_YES) // ����
		    {
		        PlayerTeam[playerid] = true;
				new len = GetPlayerLanguage(playerid);
		        if(SelectedTeam[playerid] >= 0 && SelectedTeam[playerid] <= 19) // ������
		        {
		            if(Team_Balance >= 5)
					{
					    if(len == 0)
					    	SendClientMessage(playerid,COLOR_WHITE,"* �� �뷱���� ����ġ �ʽ��ϴ�. �׷�����Ʈ ���� �������ּ���.");
						else
						    SendClientMessage(playerid,COLOR_WHITE,"* Team balance is not appropriate. Please select a terrorist team.");
					    return 0;
					}

		            Team_Balance ++;
		        }
		        else if(SelectedTeam[playerid] >= 20 && SelectedTeam[playerid] <= 39) // ������
		        {
		            if(Team_Balance <= -5)
					{
					    if(len == 0)
					    	SendClientMessage(playerid,COLOR_WHITE,"* �� �뷱���� ����ġ �ʽ��ϴ�. ��ȣ ���� �������ּ���.");
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
			GivePlayerWeapon(pid, 24, 56);
		}
	}
	SendMapMessage(6,COLOR_YELLOW, "[!] ���ϵ��� ���濡�� Ǯ�������ϴ�!");
}
