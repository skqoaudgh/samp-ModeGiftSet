/*
  [Functions]
	SetSelectionInfo(playerid)
	GivePlayerWeaponEx(playerid,teamid)
	GetPresidentPlayer()
	SetPresidentPlayer(playerid)
	GetBalance()
	SetBalance(value)
	GetRoundTimer()
	ShowPlayerTeamTD(playerid)
	HidePlayerTeamTD(playerid)
	SetPlayerHasTeam(playerid,bool:value)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_2_President
	#endinput
#endif
#define _MDPWN_2_President

//-----/ Defines /
//#define DialogID_WTF(%1)			10000 + %1
//#define VirtualID_WTF(%1)			10000 + %1
	//--/ Color /
#define COLOR_TEAM_BODYGUARD        0x87CEEBAA
#define COLOR_TEAM_TERRORIST        0xFF0000AA
#define COLOR_TEAM_PRESIDENT        0xFFFF00AA
	//--/ Round Info /
#define ROUND_TIME                  900 // 15분:초단위

//-----/ News /
	//--/ Game Info /
new PresidentPlayer = -1;
new TeamBalance = 3;
new RoundTimer;
new LeftTime = 0;
	//--/ Player Var /
new bool:PlayerTeam[MAX_PLAYERS];
new SelectedTeam[MAX_PLAYERS];
new SkinInfo[] = {280,286,165,147,222,142,221};
	//--/ TextDraw /
new Text:TeamSelectionTD[4];
new Text:TimeTD, TimeTD_string[128];

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_2_President();
forward InitHandler_2_President();
forward SpawnHandler_2_President(playerid);
forward CommandHandler_2_President(playerid,cmdtext[]);
forward StateHandler_2_President(playerid,newstate,oldstate);
forward DisconnectHandler_2_President(playerid,reason);
forward KeyHandler_2_President(playerid,newkeys,oldkeys);
forward DeathHandler_2_President(playerid,killerid,reason);
forward UpdateHandler_2_President(playerid);
	//--/ Functions /
forward Round();
forward EndRound();

//==========/ Callback Functions /==============================================
//-----/ AddHandler_2_President /-----------------------------------------------------
public AddHandler_2_President()
{
	AddHandler("2_President",InitHandler);
	AddHandler("2_President",SpawnHandler);
	AddHandler("2_President",CommandHandler);
	AddHandler("2_President",StateHandler);
	AddHandler("2_President",DisconnectHandler);
	AddHandler("2_President",KeyHandler);
	AddHandler("2_President",DeathHandler);
	AddHandler("2_President",UpdateHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}

//-----/ InitHandler_2_President /----------------------------------------------------
public InitHandler_2_President()
{
	AddStaticVehicle(490, -2776.4350, -281.3627, 7.1575, 356.34, 62, 21);
	AddStaticVehicle(490, -2755.3508, -311.3744, 7.1648, 4.53, 73, 55);
	AddStaticVehicle(490, -2768.2883, -312.7353, 7.1648, 4.03, 23, 12);
	AddStaticVehicle(541, -2759.8747, -295.0179, 6.6958, 358.79, 36, 23);
	AddStaticVehicle(411, -2737.0029, -281.5616, 6.7088, 180.75, 3, 13);
	AddStaticVehicle(411, -2740.5515, -300.4003, 6.6927, 46.43, 28, 43);
	AddStaticVehicle(528, -2767.7084, -296.0242, 7.0056, 179.93, 51, 12);
	AddStaticVehicle(522, -2759.1845, -281.4284, 6.6019, 181.93, 77, 95);
	AddStaticVehicle(522, -2761.8071, -281.5484, 6.6040, 185.57, 37, 27);
	AddStaticVehicle(490, -2726.0468, -312.8877, 7.2278, 313.74, 67, 90);
	AddStaticVehicle(522, -2703.4262, -299.2045, 6.7463, 82.51, 54, 28);
	AddStaticVehicle(522, -2700.0632, -295.8323, 6.7476, 82.81, 1, 49);
	AddStaticVehicle(420, 1718.0474, 1476.6572, 10.4507, 163.48, 61, 93);
	AddStaticVehicle(420, 1715.5766, 1468.6607, 10.4507, 162.45, 76, 27);
	AddStaticVehicle(420, 1713.0773, 1459.6409, 10.4871, 165.57, 64, 24);
	AddStaticVehicle(420, 1709.8343, 1447.9117, 10.4820, 170.20, 87, 2);
	AddStaticVehicle(420, 1708.5598, 1435.7142, 10.3501, 177.91, 12, 14);
	AddStaticVehicle(522, 1700.2799, 1412.7216, 10.2489, 283.86, 98, 63);
	AddStaticVehicle(522, 1700.9353, 1410.4868, 10.2453, 286.84, 93, 93);
	AddStaticVehicle(522, 1701.7784, 1408.0476, 10.2421, 290.60, 22, 70);
	AddStaticVehicle(522, 1697.7899, 1475.0552, 10.3392, 243.05, 56, 73);
	AddStaticVehicle(522, 1698.2825, 1477.4749, 10.3261, 251.12, 35, 87);
	AddStaticVehicle(522, 1698.5640, 1480.0670, 10.3353, 256.20, 64, 88);
	AddStaticVehicle(597, -1582.0169, 674.0720, 6.9579, 179.49, 3, 68);
	AddStaticVehicle(597, -1587.8010, 651.3001, 6.9559, 359.66, 99, 53);
	AddStaticVehicle(597, -1600.0927, 673.7009, 6.9562, 180.05, 17, 43);
	AddStaticVehicle(597, -1616.5621, 651.2788, 6.9563, 358.92, 28, 69);
	AddStaticVehicle(523, -1610.1486, 674.6829, 6.7512, 180.39, 9, 65);
	AddStaticVehicle(523, -1613.5424, 675.3444, 6.7582, 179.85, 13, 92);
	AddStaticVehicle(519, 1624.8182, 1526.8951, 11.7149, 12.47, 19, 80);
	AddStaticVehicle(519, 1609.4786, 1623.6535, 11.7428, 179.78, 80, 26);
	AddStaticVehicle(593, 1354.4339, 1720.1461, 11.2802, 270.31, 39, 96);
	AddStaticVehicle(593, 1352.9456, 1750.6606, 11.2810, 268.64, 7, 70);
	AddStaticVehicle(511, 1580.2843, 1448.8328, 12.2079, 88.45, 7, 71);
	AddStaticVehicle(519, -1337.3643, -275.0786, 15.0689, 338.35, 69, 24);
	AddStaticVehicle(519, -1390.7009, -228.4830, 15.0773, 297.08, 30, 57);
	AddStaticVehicle(522, -1988.2186, 306.4273, 34.7583, 272.56, 52, 34);
	AddStaticVehicle(522, -1987.9393, 303.0509, 34.7422, 271.55, 31, 54);
	AddStaticVehicle(560, -1953.1239, 299.5856, 40.7526, 129.59, 30, 11);
	AddStaticVehicle(562, -1954.7625, 256.8176, 40.7066, 296.03, 2, 15);
	AddStaticVehicle(558, -1954.8785, 263.5628, 40.6771, 298.06, 65, 90);
	AddStaticVehicle(559, -1944.5520, 273.4342, 35.1301, 88.83, 55, 4);
	AddStaticVehicle(560, -1944.6943, 265.9682, 35.1787, 88.84, 33, 20);
	AddStaticVehicle(561, -1944.7930, 259.2049, 35.2817, 90.69, 68, 8);
	AddStaticVehicle(561, -1990.8093, 247.7729, 34.9852, 260.60, 90, 29);
	AddStaticVehicle(541, -1989.1486, 263.5056, 34.8045, 85.25, 95, 59);
	AddStaticVehicle(497, -1495.9201, 2635.9916, 55.8670, 0.56, 34, 1);
	AddStaticVehicle(497, -1480.9593, 2630.9216, 62.7937, 9.31, 3, 10);
	AddStaticVehicle(592, 390.8453, 2515.7390, 17.6947, 37.56, 62, 98);
	AddStaticVehicle(592, 265.9628, 2509.6477, 17.8209, 85.99, 28, 43);
	AddStaticVehicle(522, -2727.1364, -322.3353, 6.7564, 43.16, 33, 93);
	AddStaticVehicle(522, -2729.1765, -323.6483, 6.7596, 37.71, 5, 2);
	AddStaticVehicle(409, -2760.5969, -310.8100, 6.8438, 3.14, 70, 64);
	AddStaticVehicle(409, -2763.1459, -311.9414, 6.9027, 3.99, 17, 84);
	AddStaticVehicle(507, -2781.5124, -281.5681, 6.8632, 181.15, 21, 98);
	AddStaticVehicle(426, -2780.4501, -296.5498, 6.7829, 182.38, 45, 44);
	AddStaticVehicle(497, -2773.5874, -312.0999, 7.2002, 5.23, 39, 38);
	AddStaticVehicle(533, -2770.0249, -296.1479, 6.7719, 178.41, 8, 14);
	AddStaticVehicle(523, -2705.4550, -301.6966, 6.7439, 60.22, 29, 57);
	AddStaticVehicle(523, -2706.8791, -303.1029, 6.7508, 32.93, 93, 83);
	AddStaticVehicle(523, -2707.8437, -304.4132, 6.7442, 63.03, 2, 90);
	AddStaticVehicle(523, -2709.1293, -305.9606, 6.7399, 66.32, 81, 20);
	AddStaticVehicle(523, -2711.5390, -307.9648, 6.7458, 73.37, 61, 7);
	AddStaticVehicle(523, -2713.0183, -310.1951, 6.7449, 52.33, 40, 91);
	AddStaticVehicle(523, -2734.2468, -330.5061, 6.7428, 67.42, 18, 32);
	AddStaticVehicle(523, -2732.4797, -328.8306, 6.7428, 49.09, 24, 68);
	AddStaticVehicle(523, -2730.8159, -325.0205, 6.7509, 70.18, 84, 0);
	AddStaticVehicle(523, -2729.3112, -322.5166, 6.7561, 71.13, 31, 28);
	AddStaticVehicle(523, -2727.1066, -321.7185, 6.7519, 64.95, 18, 30);
	AddStaticVehicle(560, -2757.0158, -294.4128, 6.7597, 0.81, 29, 7);
	AddStaticVehicle(560, 2499.9020, -1663.7576, 13.0747, 88.51, 42, 70);
	AddStaticVehicle(560, 2499.7009, -1667.7602, 13.0864, 93.09, 53, 6);
	AddStaticVehicle(461, 2503.9345, -1649.3085, 13.1967, 158.53, 45, 36);
	AddStaticVehicle(461, 2506.3935, -1650.1168, 13.3093, 149.95, 37, 4);
	AddStaticVehicle(461, 2509.0063, -1652.0954, 13.3066, 140.59, 85, 44);
	AddStaticVehicle(461, 2511.7839, -1654.4720, 13.3739, 130.74, 29, 49);
	AddStaticVehicle(487, 2490.8071, -1667.4025, 13.5201, 89.84, 13, 68);
	AddStaticVehicle(487, 2490.0952, -1677.8472, 13.4650, 74.37, 21, 12);
	AddStaticVehicle(560, 1698.5737, 1471.6334, 10.4905, 269.82, 89, 61);
	AddStaticVehicle(411, 1698.7363, 1468.5541, 10.2510, 273.18, 45, 60);
	AddStaticVehicle(451, 1698.8942, 1465.5113, 10.5122, 273.09, 77, 81);
	AddStaticVehicle(522, 1698.2496, 1476.7030, 10.3380, 262.42, 92, 21);
	AddStaticVehicle(522, 1698.3742, 1478.7752, 10.3402, 264.27, 58, 65);
	AddStaticVehicle(522, 1698.7720, 1481.1389, 10.3326, 256.10, 31, 93);
	AddStaticVehicle(522, 1699.5899, 1482.4368, 10.3343, 245.67, 13, 6);
	AddStaticVehicle(522, 1699.2705, 1483.5217, 10.3435, 258.30, 83, 26);
	AddStaticVehicle(487, 1652.6312, 1531.7313, 10.9969, 248.76, 63, 53);
	AddStaticVehicle(487, 1650.4820, 1524.0661, 10.9779, 237.64, 50, 81);
	AddStaticVehicle(487, 1635.6925, 1597.7629, 10.9917, 289.42, 68, 94);
	AddStaticVehicle(487, 1651.4074, 1603.7207, 11.0335, 280.31, 10, 23);
	AddStaticVehicle(519, 1567.5039, 1644.1813, 12.1356, 173.98, 36, 45);
	AddStaticVehicle(511, 1580.0302, 1428.2366, 11.7564, 89.00, 88, 50);
	AddStaticVehicle(476, 1278.8747, 1324.1782, 11.5408, 270.38, 81, 71);
	AddStaticVehicle(476, 1283.1379, 1359.5197, 11.5305, 253.50, 54, 71);
	AddStaticVehicle(476, 1284.4117, 1385.5450, 11.5236, 270.01, 51, 15);
	AddStaticVehicle(476, 1289.7891, 1398.4291, 11.5270, 269.60, 31, 88);
	AddStaticVehicle(476, 289.7116, 2542.1015, 17.5270, 185.83, 45, 53);
	AddStaticVehicle(476, 322.8392, 2540.8864, 17.5111, 176.83, 35, 99);
	AddStaticVehicle(415, -2752.6457, -295.3818, 6.7829, 0.04, 68, 28);
	AddStaticVehicle(421, -2748.5690, -308.0150, 6.9215, 44.77, 22, 93);
	AddStaticVehicle(427, -2751.9731, -282.7015, 7.1308, 179.14, 21, 11);
	AddStaticVehicle(427, -2744.5373, -282.0448, 7.1711, 182.76, 58, 78);
	AddStaticVehicle(427, -1609.4371, 652.0081, 7.3193, 0.29, 62, 4);
	AddStaticVehicle(427, -1604.3146, 652.0114, 7.3194, 1.73, 32, 14);
	AddStaticVehicle(522, -1604.5747, 674.2871, 6.7558, 177.45, 43, 46);
	AddStaticVehicle(522, -1607.7481, 674.4879, 6.7611, 177.58, 2, 58);
	AddStaticVehicle(597, -1592.4868, 652.4320, 6.9559, 359.01, 98, 40);
	AddStaticVehicle(597, -1588.7244, 673.4744, 6.9591, 177.37, 26, 43);
	AddStaticVehicle(497, -1604.8596, 663.2830, 7.3649, 90.84, 12, 95);
	AddStaticVehicle(601, -1575.6585, 651.9194, 6.9468, 359.57, 69, 51);
	AddStaticVehicle(601, -1576.7469, 672.9780, 6.9489, 180.01, 1, 50);
	AddStaticVehicle(497, -1617.3710, 662.1970, 7.3502, 85.10, 98, 12);
	AddStaticVehicle(519, 1967.9289, -2322.4375, 14.8734, 99.03, 77, 88);
	AddStaticVehicle(519, 1969.5242, -2351.1987, 14.8611, 87.81, 90, 29);
	AddStaticVehicle(476, 1910.1586, -2338.2663, 14.2424, 267.94, 0, 49);
	AddStaticVehicle(476, 1911.3652, -2318.3647, 14.2781, 262.26, 28, 33);
	AddStaticVehicle(447, 1291.0334, -790.4727, 97.0899, 170.68, 48, 92);
	AddStaticVehicle(497, -2729.1596, -282.8352, 7.2231, 179.89, 35, 65);
	AddStaticVehicle(470, -2724.4482, -282.6340, 7.0495, 180.44, 87, 15);
	AddStaticVehicle(470, -2734.3420, -281.8320, 7.0529, 180.61, 26, 77);
	AddStaticVehicle(519, 1806.1065, -2406.8107, 14.4730, 220.19, 18, 78);
	AddStaticVehicle(519, 1851.0872, -2397.0817, 14.4737, 221.07, 30, 97);
	AddStaticVehicle(519, 1881.2902, -2364.6726, 14.4759, 231.69, 3, 81);
	AddStaticVehicle(593, 1990.4940, -2400.4699, 14.0068, 126.83, 78, 96);
	AddStaticVehicle(593, 1991.9356, -2377.5690, 14.0095, 111.98, 28, 76);
	AddStaticVehicle(593, 1994.2282, -2329.9182, 14.0073, 123.69, 74, 75);
	AddStaticVehicle(593, 1993.0358, -2307.1486, 14.0073, 121.48, 93, 24);
	AddStaticVehicle(485, 2005.4028, -2340.4003, 13.2025, 353.87, 66, 46);
	AddStaticVehicle(485, 1944.1884, -2234.3225, 13.2017, 358.49, 65, 66);
	AddStaticVehicle(485, 1893.2838, -2320.5075, 13.2069, 285.23, 57, 24);
	AddStaticVehicle(485, 1882.2479, -2390.3964, 13.2132, 266.74, 16, 56);
	AddStaticVehicle(485, 1915.2465, -2643.3474, 13.2049, 2.24, 21, 0);
	AddStaticVehicle(476, 2124.7380, -2418.2963, 14.2641, 205.46, 65, 84);
	AddStaticVehicle(476, 2142.8671, -2434.3076, 14.2587, 144.21, 65, 76);
	AddStaticVehicle(476, 2107.1398, -2417.1647, 14.2646, 150.97, 82, 73);
	AddStaticVehicle(476, 2083.0217, -2429.4853, 14.2543, 182.99, 43, 84);
	AddStaticVehicle(510, 2081.9865, -2359.7229, 13.1550, 64.14, 81, 4);
	AddStaticVehicle(510, 1866.6114, -2660.4602, 13.1552, 18.61, 67, 6);
	AddStaticVehicle(513, 1881.0273, -2632.3281, 14.0995, 40.95, 44, 73);
	AddStaticVehicle(513, 1891.9824, -2632.7055, 14.1084, 332.56, 54, 10);
	AddStaticVehicle(593, 1840.4315, -2631.8525, 14.0080, 319.20, 54, 78);
	AddStaticVehicle(593, 1822.1689, -2629.8713, 14.0075, 35.69, 53, 79);
	AddStaticVehicle(593, 1806.7132, -2630.3166, 14.0037, 32.04, 88, 87);
	AddStaticVehicle(476, 1752.8642, -2632.2060, 14.2630, 1.48, 51, 92);
	AddStaticVehicle(481, 1698.6531, -2692.0224, 13.0592, 256.19, 28, 70);
	AddStaticVehicle(485, 1707.5415, -2646.3325, 13.2052, 359.68, 64, 70);
	AddStaticVehicle(487, 1716.0422, -2437.5766, 13.7315, 148.78, 61, 15);
	AddStaticVehicle(487, 1737.4826, -2432.7019, 13.7340, 192.03, 42, 85);
	AddStaticVehicle(487, 1752.5585, -2452.2275, 13.7321, 147.20, 77, 33);
	AddStaticVehicle(417, 1636.0141, -2409.7209, 13.6266, 193.23, 84, 98);
	AddStaticVehicle(417, 1655.8718, -2410.4550, 13.6350, 156.94, 37, 57);
	AddStaticVehicle(510, 1600.9696, -2395.0102, 13.2262, 298.20, 71, 60);
	AddStaticVehicle(497, 1575.9306, -2408.7253, 13.7347, 153.20, 2, 3);
	AddStaticVehicle(497, 1554.8206, -2406.4416, 13.7307, 190.66, 56, 29);
	AddStaticVehicle(485, -1644.8494, -593.8190, 13.8044, 244.24, 84, 77);
	AddStaticVehicle(485, -1433.6988, -639.9345, 13.8058, 351.83, 8, 8);
	AddStaticVehicle(485, -1354.3955, -426.7434, 13.8022, 293.62, 95, 87);
	AddStaticVehicle(485, -1284.1955, 60.9789, 13.8073, 96.51, 66, 55);
	AddStaticVehicle(485, -1556.3771, -156.9351, 13.8066, 135.61, 90, 63);
	AddStaticVehicle(592, -1562.6097, -191.8930, 15.3402, 135.33, 89, 55);
	AddStaticVehicle(583, -1467.6940, -68.7158, 13.6890, 135.97, 50, 24);
	AddStaticVehicle(583, -1438.1007, -178.1786, 13.6843, 333.79, 29, 34);
	AddStaticVehicle(583, -1396.8985, -226.8979, 13.6890, 329.79, 23, 41);
	AddStaticVehicle(583, -1634.3321, -377.9814, 13.6890, 335.13, 62, 60);
	AddStaticVehicle(583, -1299.0438, -286.9009, 13.6891, 341.62, 21, 28);
	AddStaticVehicle(525, -1354.0233, -375.1030, 14.0255, 263.60, 88, 58);
	AddStaticVehicle(513, -1285.7554, 24.0492, 14.6992, 121.84, 28, 74);
	AddStaticVehicle(513, -1260.6040, 7.5346, 14.7069, 118.62, 22, 23);
	AddStaticVehicle(511, -1704.6076, -239.2015, 15.5221, 314.28, 2, 66);
	AddStaticVehicle(476, -1367.2608, -485.4558, 14.8787, 209.58, 28, 81);
	AddStaticVehicle(476, -1354.7247, -479.5578, 14.8777, 200.8746, 3, 23);
	AddStaticVehicle(476, -1440.4190, -526.5578, 14.8938, 207.20, 86, 27);
	AddStaticVehicle(519, -1371.1774, -232.3966, 15.0767, 315.62, 7, 73);
	AddStaticVehicle(519, -1341.1079, -254.3786, 15.0773, 321.63, 37, 29);
	AddStaticVehicle(420, -1472.3452, -272.3331, 13.7749, 78.99, 58, 90);
	AddStaticVehicle(420, -1459.8146, -275.6010, 13.8145, 65.62, 40, 15);
	AddStaticVehicle(420, -1439.7111, -284.8562, 13.8130, 58.61, 83, 28);
	AddStaticVehicle(420, -1421.4267, -298.8920, 13.7817, 46.16, 67, 30);
	AddStaticVehicle(519, -1331.5316, -618.3226, 15.0628, 325.71, 88, 64);
	AddStaticVehicle(593, -1384.5904, -625.2683, 14.6114, 321.75, 35, 86);
	AddStaticVehicle(511, -1449.8150, -617.1895, 15.5199, 329.79, 11, 71);
	AddStaticVehicle(593, -1325.9851, -276.6170, 14.6106, 296.54, 6, 84);
	AddStaticVehicle(563, -1598.6352, -615.8721, 14.8536, 276.20, 36, 41);
	AddStaticVehicle(476, -1426.4313, -518.3583, 14.8957, 180.57, 3, 23);
	AddStaticVehicle(513, -1281.6588, -627.3806, 14.6996, 356.90, 28, 20);
	AddStaticVehicle(519, -1299.0974, -353.5505, 15.0715, 278.41, 5, 92);
	AddStaticVehicle(487, -1182.6599, 22.4606, 14.3250, 45.06, 65, 54);
	AddStaticVehicle(417, -1222.6131, -11.1499, 14.2353, 42.98, 41, 60);
	AddStaticVehicle(544, -1258.5738, 68.2614, 14.3863, 43.97, 0, 47);
	AddStaticVehicle(407, -1262.4765, 64.5995, 14.3816, 43.90, 59, 5);
	AddStaticVehicle(519, 1343.1445, 1615.6131, 11.8177, 271.06, 39, 88);
	AddStaticVehicle(519, 1332.0196, 1571.6779, 11.8220, 271.37, 14, 39);
	AddStaticVehicle(577, 1584.3395, 1187.2376, 10.6955, 184.69, 71, 14);
	AddStaticVehicle(445, -1903.5142, -1680.1630, 22.8980, 358.66, 10, 67);
	AddStaticVehicle(445, -1917.7022, -1679.6440, 22.8910, 358.18, 10, 58);
	AddStaticVehicle(445, -1910.5279, -1679.9295, 22.8936, 357.60, 24, 41);
	AddStaticVehicle(445, -1909.0855, -1661.9207, 22.8932, 357.69, 5, 46);
	AddStaticVehicle(430, -2941.9792, 496.8174, 0.2002, 0.37, 72, 58);
	AddStaticVehicle(430, -2953.0727, 493.5563, -0.4765, 0.53, 75, 40);
	AddStaticVehicle(446, -2981.6284, 494.8309, -0.0960, 358.25, 10, 5);
	AddStaticVehicle(493, -2970.3706, 493.0392, 0.2624, 353.86, 45, 22);
	AddStaticVehicle(452, -2230.4025, 2392.2521, -0.5669, 46.54, 23, 73);
	AddStaticVehicle(446, -2262.5368, 2422.8496, -0.5097, 225.18, 81, 19);
	AddStaticVehicle(493, -2241.8425, 2442.8002, -0.1068, 223.60, 34, 48);
	AddStaticVehicle(430, -2209.8750, 2411.0070, -0.0733, 45.78, 34, 1);
	AddStaticVehicle(473, -1440.9467, 1502.2841, -0.7795, 90.97, 18, 66);
	AddStaticVehicle(452, -1509.7183, 1299.5460, -0.0835, 271.85, 0, 68);
	AddStaticVehicle(452, -1571.5935, 1263.1329, -0.7544, 86.01, 75, 12);
	AddStaticVehicle(452, -1466.8321, 1089.8437, -0.5267, 90.41, 27, 67);
	AddStaticVehicle(452, -1460.0322, 1022.7700, -0.2861, 272.64, 92, 99);
	AddStaticVehicle(446, -1476.7279, 696.0518, -0.7075, 181.85, 54, 61);
	AddStaticVehicle(446, -1720.5584, 1435.2844, -0.6543, 182.33, 75, 79);
	AddStaticVehicle(446, -2420.0363, 1524.5966, -0.5230, 90.70, 8, 84);
	AddStaticVehicle(446, -2386.6174, 1564.6219, -0.2822, 273.21, 26, 49);
	AddStaticVehicle(473, -796.9592, 939.7960, -0.1832, 137.73, 4, 9);
	AddStaticVehicle(539, -662.7260, 877.5465, 0.3898, 223.93, 56, 55);
	AddStaticVehicle(595, -1444.5241, 507.5130, 0.2574, 269.92, 49, 67);
	AddStaticVehicle(446, -1759.5201, -193.4234, -0.3371, 273.47, 39, 59);
	AddStaticVehicle(446, -1620.7148, -76.9362, -0.5655, 315.88, 75, 18);
	AddStaticVehicle(446, -1447.6799, 96.1761, -0.7020, 316.50, 21, 58);
	AddStaticVehicle(453, -1418.3837, 285.3324, -0.2964, 267.56, 76, 11);
	AddStaticVehicle(453, -1646.0206, 253.2288, -0.2506, 87.79, 98, 85);
	AddStaticVehicle(454, -1726.3817, 231.6347, 0.0350, 271.44, 85, 88);
	AddStaticVehicle(452, -1113.5433, 329.0928, -0.5723, 139.65, 16, 9);
	AddStaticVehicle(452, -1175.8790, 62.1647, -0.5623, 218.83, 34, 97);
	AddStaticVehicle(452, -1174.4221, 60.1576, -0.3828, 40.63, 40, 71);
	AddStaticVehicle(452, -1076.2003, -206.9223, -0.4469, 206.91, 52, 97);
	AddStaticVehicle(452, -1150.1275, -480.9230, -0.4984, 146.77, 32, 43);
	AddStaticVehicle(452, -1362.2927, -702.5388, -0.5174, 94.16, 13, 3);
	AddStaticVehicle(452, -1605.1538, -702.9691, -0.4018, 88.28, 13, 89);
	AddStaticVehicle(563, 267.7583, -1871.6900, 3.4010, 262.59, 72, 69);
	AddStaticVehicle(452, 2714.9838, -2312.7460, -0.5737, 271.65, 38, 57);
	AddStaticVehicle(452, 2746.7709, -2583.8588, -0.7652, 90.11, 72, 17);
	AddStaticVehicle(452, 2606.4501, -2477.0332, -0.5123, 99.17, 90, 31);
	AddStaticVehicle(452, 2442.8940, -2714.9384, -0.8411, 99.25, 19, 38);
	AddStaticVehicle(452, 2355.5148, -2510.8874, -0.6952, 358.32, 34, 74);
	AddStaticVehicle(452, 2296.5903, -2424.9206, -0.5670, 144.64, 52, 84);
	AddStaticVehicle(452, 2503.3251, -2267.8857, -0.4517, 263.43, 62, 25);
	AddStaticVehicle(452, 719.1992, -1694.6767, -0.5828, 178.86, 43, 14);
	AddStaticVehicle(452, 719.4827, -1630.9708, -0.4469, 176.09, 41, 15);
	AddStaticVehicle(539, 721.6408, -1498.8178, 0.2644, 90.25, 40, 45);
	AddStaticVehicle(446, -807.4146, 2235.0205, 40.1428, 273.73, 76, 66);
	AddStaticVehicle(446, -484.1163, 2188.8049, 40.1217, 181.91, 96, 46);
	AddStaticVehicle(452, -1376.1713, 2115.8986, 40.1265, 228.87, 14, 46);
	AddStaticVehicle(470, 223.7375, 1888.5714, 17.6326, 357.50, 78, 17);
	AddStaticVehicle(470, 205.5155, 1883.4658, 17.6403, 3.70, 1, 99);
	AddStaticVehicle(522, 1923.4062, -2250.7602, 13.1183, 171.53, 92, 28);
	AddStaticVehicle(522, 1922.0972, -2250.5019, 13.1169, 173.65, 31, 76);
	AddStaticVehicle(522, 1920.7244, -2250.1533, 13.1183, 172.15, 39, 73);
	AddStaticVehicle(522, 1919.4029, -2249.8430, 13.1149, 170.47, 64, 59);
	AddStaticVehicle(522, 1918.0793, -2249.4980, 13.1134, 170.41, 21, 54);
	AddStaticVehicle(522, 1916.7403, -2249.2243, 13.1184, 169.57, 20, 17);
	AddStaticVehicle(522, 1915.3557, -2248.9069, 13.1182, 170.56, 54, 62);
	AddStaticVehicle(522, 1914.1285, -2248.6950, 13.1177, 171.60, 95, 58);
	AddStaticVehicle(560, 1926.1280, -2250.5031, 13.2517, 168.34, 56, 84);
	AddStaticVehicle(560, 1929.5018, -2251.0927, 13.2522, 170.78, 61, 85);
	AddStaticVehicle(560, 1932.9676, -2251.5947, 13.2520, 172.50, 1, 96);
	AddStaticVehicle(433, -1372.9479, 460.5909, 7.6388, 358.35, 30, 1);
	AddStaticVehicle(433, -1357.0269, 460.1931, 7.6412, 0.64, 78, 28);
	AddStaticVehicle(499, -1318.4227, 478.2113, 7.1883, 181.75, 38, 7);
	AddStaticVehicle(470, -1426.6788, 456.8244, 7.1771, 358.84, 97, 28);
	AddStaticVehicle(470, -1434.3968, 456.9505, 7.1696, 356.19, 57, 26);
	AddStaticVehicle(470, -1444.9700, 456.2464, 7.2027, 2.08, 53, 78);
	AddStaticVehicle(470, -1451.7384, 456.4074, 7.1895, 359.56, 16, 8);
	AddStaticVehicle(500, -1471.8233, 456.1130, 7.2873, 358.47, 81, 84);
	AddStaticVehicle(500, -1477.4273, 456.6816, 7.2940, 357.42, 76, 18);
	AddStaticVehicle(497, -1416.5671, 509.0083, 18.4008, 268.85, 62, 31);
	AddStaticVehicle(497, -1421.5251, 494.4725, 18.4071, 269.30, 44, 74);
	AddStaticVehicle(497, -1407.9010, 471.7294, 7.3621, 266.89, 48, 19);
	AddStaticVehicle(497, -1377.2869, 472.3009, 7.7500, 268.82, 9, 93);
    AddStaticVehicle(437,-2786.3950,-282.5082,7.1690,179.6868,62,21);
    AddStaticVehicle(437,-1638.6146,649.3281,-5.1072,269.2928,17,43);
    AddStaticVehicle(432,1045.7992,-301.8947,74.0639,180.2495,43,0);
    AddStaticVehicle(548,307.9025,2043.4127,17.8172,179.5691,9,93);
    AddStaticVehicle(539,-2093.8650,-110.1713,34.6803,178.8277,70,86);
    AddStaticVehicle(539,-2091.2258,-110.1631,34.6802,180.5957,75,91);
    AddStaticVehicle(539,-2088.1973,-110.1355,34.6801,178.2542,75,75);
    AddStaticVehicle(539,-2085.1963,-110.0092,34.6803,181.3580,61,98);
    AddStaticVehicle(539,-2082.6567,-110.1236,34.6804,179.1688,96,67);
    AddStaticVehicle(539,-2079.0708,-110.1543,34.6803,178.8087,70,86);
    AddStaticVehicle(539,-2075.6584,-110.0558,34.6870,181.0633,61,98);
    AddStaticVehicle(539,-2072.8159,-110.0952,34.6856,179.0073,96,67);
    AddStaticVehicle(539,-2069.5168,-110.1738,34.6877,179.8176,86,70);
    AddStaticVehicle(539,-2065.7476,-110.0286,34.6887,181.6058,75,91);
    AddStaticVehicle(539,-2063.0525,-109.9404,34.6866,181.7744,79,74);
    AddStaticVehicle(539,-2059.0007,-110.0459,34.6819,176.6468,61,98);
    AddStaticVehicle(544,-2056.2251,93.8116,28.6274,86.1959,3,1);
    AddStaticVehicle(416,-2055.5449,83.7644,28.5439,92.8750,1,3);
    AddStaticVehicle(407,-2053.2808,74.2136,28.6767,94.3861,3,1);
    AddStaticVehicle(510,-2108.0466,-2406.5991,30.9327,317.7599,2,2);
    AddStaticVehicle(510,-2109.2195,-2405.6641,30.9328,328.0299,6,6);
    AddStaticVehicle(510,-2110.8777,-2404.3979,30.9328,326.1581,5,5);
    AddStaticVehicle(510,-2112.1370,-2403.4578,30.9325,321.9764,16,16);
    AddStaticVehicle(510,-2113.1836,-2402.5481,30.9329,326.3436,46,46);
    AddStaticVehicle(510,-2116.6235,-2406.6592,30.9028,322.7471,2,2);
    AddStaticVehicle(510,-2115.3381,-2407.5847,30.9032,324.0439,43,43);
    AddStaticVehicle(510,-2113.9063,-2408.6104,30.9040,321.1828,28,28);
    AddStaticVehicle(510,-2112.5142,-2409.7402,30.9034,320.7068,28,28);
    AddStaticVehicle(510,-2111.2593,-2410.8972,30.9028,319.6296,39,39);
    AddStaticVehicle(510,-2115.4468,-2416.6694,30.8346,320.1550,16,16);
    AddStaticVehicle(510,-2116.8157,-2415.6860,30.8343,322.2556,5,5);
    AddStaticVehicle(510,-2117.9612,-2414.6831,30.8345,317.3947,6,6);
    AddStaticVehicle(510,-2119.6567,-2413.3928,30.8343,327.3878,39,39);
    AddStaticVehicle(510,-2121.1689,-2412.1409,30.8344,321.5261,46,46);
    AddStaticVehicle(497,-2094.5247,-2426.6028,35.0990,229.1125,0,1);
    
	for(new i=702; i<=1006; i++)
	    SetVehicleVirtualWorld(i, 2);
    
 	TeamSelectionTD[0] = TextDrawCreate(320.000213, 15.011039, "BODYGUARD");
	TextDrawLetterSize(TeamSelectionTD[0], 1.058999, 5.038813);
	TextDrawAlignment(TeamSelectionTD[0], 2);
	TextDrawColor(TeamSelectionTD[0], 65535);
	TextDrawSetOutline(TeamSelectionTD[0], 1);
	TextDrawBackgroundColor(TeamSelectionTD[0], 255);
	TextDrawFont(TeamSelectionTD[0], 2);
	TextDrawSetProportional(TeamSelectionTD[0], 1);

	TeamSelectionTD[1] = TextDrawCreate(241.333297, 61.374397, "Desert Eagle");
	TextDrawLetterSize(TeamSelectionTD[1], 0.199666, 1.998220);
	TextDrawTextSize(TeamSelectionTD[1], 0.000000, 90.000000);
	TextDrawAlignment(TeamSelectionTD[1], 2);
	TextDrawColor(TeamSelectionTD[1], 255);
	TextDrawSetOutline(TeamSelectionTD[1], 1);
	TextDrawBackgroundColor(TeamSelectionTD[1], -1);
	TextDrawFont(TeamSelectionTD[1], 1);
	TextDrawSetProportional(TeamSelectionTD[1], 1);

	TeamSelectionTD[2] = TextDrawCreate(403.403045, 61.374397, "MP5");
	TextDrawLetterSize(TeamSelectionTD[2], 0.199666, 1.998220);
	TextDrawTextSize(TeamSelectionTD[2], 0.000000, 90.000000);
	TextDrawAlignment(TeamSelectionTD[2], 2);
	TextDrawColor(TeamSelectionTD[2], 255);
	TextDrawSetOutline(TeamSelectionTD[2], 1);
	TextDrawBackgroundColor(TeamSelectionTD[2], -1);
	TextDrawFont(TeamSelectionTD[2], 1);
	TextDrawSetProportional(TeamSelectionTD[2], 1);

	TeamSelectionTD[3] = TextDrawCreate(322.066741, 61.374397, "Pump Shotgun");
	TextDrawLetterSize(TeamSelectionTD[3], 0.199666, 1.998220);
	TextDrawTextSize(TeamSelectionTD[3], 0.000000, 90.000000);
	TextDrawAlignment(TeamSelectionTD[3], 2);
	TextDrawColor(TeamSelectionTD[3], 255);
	TextDrawSetOutline(TeamSelectionTD[3], 1);
	TextDrawBackgroundColor(TeamSelectionTD[3], -1);
	TextDrawFont(TeamSelectionTD[3], 1);
	TextDrawSetProportional(TeamSelectionTD[3], 1);
	
	format(TimeTD_string, 128, " ");
	TimeTD = TextDrawCreate(480, 420, TimeTD_string);
	TextDrawLetterSize(TimeTD,0.40,1.10);
	TextDrawSetShadow(TimeTD, 0);
	TextDrawSetOutline(TimeTD, 1);
}

//-----/ SpawnHandler_2_President /---------------------------------------------
public SpawnHandler_2_President(playerid)
{
	if(GetPlayerMap(playerid) == 2)
	{
		if(!PlayerTeam[playerid]) // 팀 선택
		{
		    SelectedTeam[playerid] = 0;
		    ShowPlayerTeamTD(playerid);
		    SetPlayerTime(playerid, 12, 0);
		    
		    FreezePlayer(playerid);
		    SetPlayerSkin(playerid,280);
		    SetPlayerVirtualWorld(playerid,10);
		    SetPlayerPos(playerid,1124.4611,-2037.0797,69.8841);
		    SetPlayerFacingAngle(playerid,268.3331);
		    SetPlayerCameraPos(playerid,1133.5934,-2037.3018,72.5078);
		    SetPlayerCameraLookAt(playerid,1124.4611,-2037.0797,69.8841);
		}
		else // 리스폰
		{
		    ClearChatting(playerid);
			if(GetPlayerLanguage(playerid) == 0)
			{
			    SendClientMessage(playerid,COLOR_GREEN,"          대통령 지키기");
			    SendClientMessage(playerid,COLOR_GREEN,"대통령이 테러리스트의 위협을 받고 있습니다.");
			    SendClientMessage(playerid,COLOR_GREEN,"당신은 경호 팀 혹은 테러리스트 팀이 되어 목적을 달성해야 합니다.");
			    SendClientMessage(playerid,COLOR_GREEN,"경호 팀은 대통령이 죽지 않도록 제한 시간을 버텨내야 합니다.");
			    SendClientMessage(playerid,COLOR_GREEN,"테러리스트 팀은 제한 시간 내에 대통령을 죽여야 합니다.");
			    SendClientMessage(playerid,COLOR_GREEN,"보상: Point +10, Money +1000");
			}
			else
			{
			    SendClientMessage(playerid,COLOR_GREEN,"          Protect President");
			    SendClientMessage(playerid,COLOR_GREEN,"The president is threatened by terrorists.");
			    SendClientMessage(playerid,COLOR_GREEN,"You will be a bodyguard or a terrorist team to achieve your goals.");
			    SendClientMessage(playerid,COLOR_GREEN,"Bodyguard team must protect the president from terrorists within the time limit.");
			    SendClientMessage(playerid,COLOR_GREEN,"Terrorist team must kill the president within the time limit.");
			    SendClientMessage(playerid,COLOR_GREEN,"Reward: Point +10, Money +1000");
			}
			//-----
		    switch(SelectedTeam[playerid])
		    {
		        case 0..2: // 경호
		        {
		            SetPlayerPos(playerid, -2787.6155+random(66), -294.2365+random(8), 7.04);
		            SetPlayerColor(playerid, COLOR_TEAM_BODYGUARD);
		            SetPlayerTeam(playerid, 1);
		        }
		        case 3: // 대통령
		        {
		            SetPlayerPos(playerid, -2721.3049,-317.2299,7.8438);
		            SetPlayerFacingAngle(playerid, 45.857);
		            SetPlayerColor(playerid, COLOR_TEAM_PRESIDENT);
		            SetPlayerTeam(playerid, 1);
		        }
		        case 4..6: // 테러리스트
				{
		            SetPlayerPos(playerid, 1672.6182+random(23), 1440.2610+random(15), 10.7791);
		            SetPlayerColor(playerid, COLOR_TEAM_TERRORIST);
		            SetPlayerTeam(playerid, 2);
				}
		    }
		    HidePlayerTeamTD(playerid);
		    SetPlayerSkin(playerid,SkinInfo[SelectedTeam[playerid]]);
		    SetPlayerVirtualWorld(playerid,2);
			SetPlayerInterior(playerid,0);
			SetPlayerHealth(playerid,100);
			SetPlayerArmour(playerid,100);
			GivePlayerWeaponEx(playerid,SelectedTeam[playerid]);
		}
	}
}
//-----/ DisconnectHandler_2_President /-------------------------------------------
public DisconnectHandler_2_President(playerid,reason)
{
    PlayerTeam[playerid] = false;
    if(PresidentPlayer == playerid)
    {
        KillTimer(RoundTimer);
        PresidentPlayer = -1;
		if(GetPlayerLanguage(playerid) == 0)
        	SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] 대통령이 접속을 종료해 게임이 중단됩니다. 대통령이 새롭게 선정되면 게임이 재개됩니다.");
		else
		{
		    SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] The game is paused because the president is disconnected.");
		    SendMessage(playerid, COLOR_PASTEL_YELLOW,"[!] The game will resume when new president is selected.");
		}
    }
}
//-----/ CommandHandler_2_President /-------------------------------------------
public CommandHandler_2_President(playerid,cmdtext[])
{
	if(GetPlayerMap(playerid) == 2)
	{
		new
			cmd[256],idx
			//string[128]
		;
		if(!strcmp("/help",cmd) || !strcmp("/?",cmd) || !strcmp("/도움말",cmd))
		{
			if(GetPlayerLanguage(playerid) == 0)
			{
				SendClientMessage(playerid,COLOR_GREY,"[!] 팀채팅 - (/t)eam");
				SendClientMessage(playerid,COLOR_GREY,"[!] 클래스를 변경하기 위해서는 [/맵]으로 다시 입장해주세요.");
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY,"[!] TeamChatting - (/t)eam");
				SendClientMessage(playerid,COLOR_GREY,"[!] If you want to change your class, entering [/map] and re-join the game.");
			}
			return 1;
		}
	}
	return 0;
}
//-----/ DeathHandler_2_President /---------------------------------------------
public DeathHandler_2_President(playerid,killerid,reason)
{
	if(playerid == PresidentPlayer)
	{
	    if(GetPlayerLanguage(playerid) == 0)
	    {
        	SendMessage(2, COLOR_PASTEL_GREEN, "* 테러리스트 팀이 대통령을 암살해 승리하였습니다! (Point +10, Money +1000)");
        	SendMessage(2, COLOR_PASTEL_GREEN, "* 잠시 후 새로운 라운드가 시작됩니다.");
	    }
		else
		{
        	SendMessage(2, COLOR_PASTEL_GREEN, "* Terrorist team has killed the president, Win the game! (Point +10, Money +1000)");
        	SendMessage(2, COLOR_PASTEL_GREEN, "* Next round will be start soon.");
		}
        KillTimer(RoundTimer);
        SetTimer("EndRound",5000,0);

		for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
		{
			pid = GetConnectedPlayerID(i);
			if(GetPlayerMap(pid) == 2)
			{
			    PlayerPlaySound(i, 139, 0.0, 0.0, 0.0);
				if(SelectedTeam[pid] >= 4 && SelectedTeam[pid] <= 6)
				{
		    		SetPVarInt(pid,"Point",GetPVarInt(pid,"Point")+20);
					SetPVarInt(pid,"Money",GetPVarInt(pid,"Money")+2000);
				}
			}
  		}
	}
	new WeaponName[32], string[128];
    GetWeaponName(reason, WeaponName, sizeof(WeaponName));
	if(killerid != INVALID_PLAYER_ID)
	{
	    if(GetPlayerLanguage(playerid) == 0)
			format(string,sizeof(string),"* %s(%d) 님이 %s(%d) 님을 %s (으)로 죽였습니다 (Point +1, Money +100).",GetPlayerNameEx(killerid),killerid,GetPlayerNameEx(playerid),playerid,WeaponName);
		else
		    format(string,sizeof(string),"* %s(%d) has killed %s(%d) with %s (Point +1, Money +100).",GetPlayerNameEx(killerid),killerid,GetPlayerNameEx(playerid),playerid,WeaponName);
		SendMessage(2, COLOR_RED, string);
		
		SetPVarInt(killerid,"Point",GetPVarInt(killerid,"Point")+1);
		SetPVarInt(killerid,"Money",GetPVarInt(killerid,"Money")+100);
	}
}
//-----/ StateHandler_2_President /---------------------------------------------
public StateHandler_2_President(playerid,newstate,oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
		SetPlayerArmedWeapon(playerid, 0);
	    if(PresidentPlayer == playerid)
		{
	        RemovePlayerFromVehicle(playerid);
	        if(GetPlayerLanguage(playerid) == 0)
	        	SendClientMessage(playerid, COLOR_WHITE, "* 대통령은 운전을 할 수 없습니다!");
			else
			    SendClientMessage(playerid, COLOR_WHITE, "* President can`t drive a vehicle!");
	    }
	}
}
//-----/ UpdateHandler_2_President /--------------------------------------------
public UpdateHandler_2_President(playerid)
{
	if(GetPlayerMap(playerid) == 2)
	{
		if(!PlayerTeam[playerid])
		{
		    new Keys,ud,lr;
		    GetPlayerKeys(playerid,Keys,ud,lr);
		    if(lr == KEY_LEFT) // 왼쪽으로
		    {
		        SelectedTeam[playerid] --;
		        if(SelectedTeam[playerid] < 0)
		            SelectedTeam[playerid] = 6;
				SetSelectionInfo(playerid);
		    }
		    else if(lr == KEY_RIGHT) // 오른쪽으로
		    {
	            SelectedTeam[playerid] ++;
	            SelectedTeam[playerid] %= 7;
	            SetSelectionInfo(playerid);
		    }
		}
	}
}
//-----/ KeyHandler_2_President /-----------------------------------------------
public KeyHandler_2_President(playerid,newkeys,oldkeys)
{
	if(GetPlayerMap(playerid) == 2)
	{
		if(!PlayerTeam[playerid])
		{
		    if(newkeys == KEY_YES) // 선택
		    {
		        PlayerTeam[playerid] = true;
				new len = GetPlayerLanguage(playerid);
		        if(SelectedTeam[playerid] >= 0 && SelectedTeam[playerid] <= 2) // 보디가드 팀 선택
		        {
		            if(TeamBalance >= 5)
					{
					    if(len == 0)
					    	SendClientMessage(playerid,COLOR_WHITE,"* 팀 밸런스가 적절치 않습니다. 테러리스트 팀을 선택해주세요.");
						else
						    SendClientMessage(playerid,COLOR_WHITE,"* Team balance is not appropriate. Please select a terrorist team.");
					    return 0;
					}
					
		            TeamBalance ++;
		        }
		        else if(SelectedTeam[playerid] >= 4 && SelectedTeam[playerid] <= 6) // 테러리스트 팀 선택
		        {
		            if(TeamBalance <= -5)
					{
					    if(len == 0)
					    	SendClientMessage(playerid,COLOR_WHITE,"* 팀 밸런스가 적절치 않습니다. 경호 팀을 선택해주세요.");
						else
						    SendClientMessage(playerid,COLOR_WHITE,"* Team balance is not appropriate. Please select a bodyguard team.");
					    return 0;
					}
		            TeamBalance --;
		        }
		        else // 대통령 선택
				{
					if(PresidentPlayer != -1)
					{
					    if(len == 0)
					    	SendClientMessage(playerid,COLOR_WHITE,"* 이미 대통령이 선택되었습니다. 다른 클래스를 선택해주세요.");
						else
						    SendClientMessage(playerid,COLOR_WHITE,"* The president has already been selected. Please select another class.");
						return 0;
					}
					PresidentPlayer = playerid;
					if(LeftTime <= 0)
						LeftTime = ROUND_TIME;
					RoundTimer = SetTimer("Round",1000,1);
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
//-----/ SetSelectionInfo /-----------------------------------------------------
stock SetSelectionInfo(playerid)
{
    // 스킨
    SetPlayerSkin(playerid,SkinInfo[SelectedTeam[playerid]]);
    PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
    HidePlayerTeamTD(playerid);
	switch(SelectedTeam[playerid])
 	{
		// 텍스트드로우
		case 0:
		{
		    TextDrawSetString(TeamSelectionTD[0],"BODYGUARD");
		    TextDrawSetString(TeamSelectionTD[1],"Desert Eagle");
		    TextDrawSetString(TeamSelectionTD[2],"MP5");
		    TextDrawSetString(TeamSelectionTD[3],"Pump Shotgun");
			
		    TextDrawColor(TeamSelectionTD[0],65535);
		}
		case 1:
		{
		    TextDrawSetString(TeamSelectionTD[0],"BODYGUARD");
		    TextDrawSetString(TeamSelectionTD[1],"Silenced Pistol");
		    TextDrawSetString(TeamSelectionTD[2],"TEC-9");
		    TextDrawSetString(TeamSelectionTD[3],"Combat Shotgun");

		    TextDrawColor(TeamSelectionTD[0],65535);
		}
		case 2:
		{
		    TextDrawSetString(TeamSelectionTD[0],"BODYGUARD");
		    TextDrawSetString(TeamSelectionTD[1],"Desert Eagle");
		    TextDrawSetString(TeamSelectionTD[2],"M4");
		    TextDrawSetString(TeamSelectionTD[3],"Pump Shotgun");

		    TextDrawColor(TeamSelectionTD[0],65535);
		}
		case 3:
		{
		    TextDrawSetString(TeamSelectionTD[0],"PRESIDENT");
		    TextDrawSetString(TeamSelectionTD[1],"Silenced Pistol");
		    TextDrawSetString(TeamSelectionTD[2]," ");
		    TextDrawSetString(TeamSelectionTD[3]," ");

		    TextDrawColor(TeamSelectionTD[0],-65281);
		}
		case 4:
		{
		    TextDrawSetString(TeamSelectionTD[0],"TERRORIST");
		    TextDrawSetString(TeamSelectionTD[1],"Desert Eagle");
		    TextDrawSetString(TeamSelectionTD[2],"AK-47");
		    TextDrawSetString(TeamSelectionTD[3],"Pump Shotgun");

		    TextDrawColor(TeamSelectionTD[0],-16776961);
		}
		case 5:
		{
		    TextDrawSetString(TeamSelectionTD[0],"TERRORIST");
		    TextDrawSetString(TeamSelectionTD[1],"Micro-Uzi");
		    TextDrawSetString(TeamSelectionTD[2],"Combat Shotgun");
		    TextDrawSetString(TeamSelectionTD[3],"Grenade");

		    TextDrawColor(TeamSelectionTD[0],-16776961);
		}
		case 6:
		{
		    TextDrawSetString(TeamSelectionTD[0],"TERRORIST");
		    TextDrawSetString(TeamSelectionTD[1],"MP5");
		    TextDrawSetString(TeamSelectionTD[2],"AK-47");
		    TextDrawSetString(TeamSelectionTD[3],"Molotov Cocktail");

		    TextDrawColor(TeamSelectionTD[0],-16776961);
		}
	}
	ShowPlayerTeamTD(playerid);
}
//-----/ GivePlayerWeaponEx /---------------------------------------------------
stock GivePlayerWeaponEx(playerid,teamid)
{
	printf("%d",teamid);
    ResetPlayerWeapons(playerid);
	switch(teamid)
	{
	    case 0:
	    {
	        GivePlayerWeapon(playerid, 24, 9000);
	        GivePlayerWeapon(playerid, 29, 9000);
	        GivePlayerWeapon(playerid, 23, 9000);
	    }
	    case 1:
	    {
	        GivePlayerWeapon(playerid, 23, 9000);
	        GivePlayerWeapon(playerid, 32, 9000);
	        GivePlayerWeapon(playerid, 27, 9000);
	    }
	    case 2:
	    {
	        GivePlayerWeapon(playerid, 24, 9000);
	        GivePlayerWeapon(playerid, 31, 9000);
	        GivePlayerWeapon(playerid, 25, 9000);
	    }
	    case 3:
	    {
	        GivePlayerWeapon(playerid, 23, 9000);
	    }
	    case 4:
	    {
	        GivePlayerWeapon(playerid, 24, 9000);
	        GivePlayerWeapon(playerid, 30, 9000);
	        GivePlayerWeapon(playerid, 25, 9000);
	    }
	    case 5:
	    {
	        GivePlayerWeapon(playerid, 28, 9000);
	        GivePlayerWeapon(playerid, 27, 9000);
	        GivePlayerWeapon(playerid, 16, 10);
	    }
	    case 6:
	    {
	        GivePlayerWeapon(playerid, 29, 9000);
	        GivePlayerWeapon(playerid, 30, 9000);
	        GivePlayerWeapon(playerid, 18, 10);
	    }
	}
}
//-----/ Round /----------------------------------------------------------------
public Round()
{
	LeftTime --;
	format(TimeTD_string, 128, "~y~Seconds Left: %d", LeftTime);
	TextDrawSetString(TimeTD, TimeTD_string);
	TextDrawShowForAllEx(2,TimeTD);
	if(LeftTime <= 0)
    {
        //ClearChatting();
		for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
		{
			pid = GetConnectedPlayerID(i);
            if(GetPlayerMap(pid) == 2)
            {
		        if(GetPlayerLanguage(pid) == 0)
		        {
			        SendClientMessage(pid, COLOR_PASTEL_GREEN, "* 대통령이 제한시간 동안 생존하여 승리하였습니다! (Point +5, Money +500)");
			        SendClientMessage(pid, COLOR_PASTEL_GREEN, "* 잠시 후 새로운 라운드가 시작됩니다.");
		        }
		        else
		        {
			        SendClientMessage(pid, COLOR_PASTEL_GREEN, "* The president survive during round time, Win the game! (Point +5, Money +500)");
			        SendClientMessage(pid, COLOR_PASTEL_GREEN, "* Next round will be start soon.");
		        }
            }
        }

        KillTimer(RoundTimer);
        SetTimer("EndRound",5000,0);
        
		for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
		{
			pid = GetConnectedPlayerID(i);
			if(GetPlayerMap(pid) == 2)
			{
			    PlayerPlaySound(pid, 139, 0.0, 0.0, 0.0);
				if(SelectedTeam[pid] >= 0 && SelectedTeam[pid] <= 3)
				{
		    		SetPVarInt(pid,"Point",GetPVarInt(pid,"Point")+20);
					SetPVarInt(pid,"Money",GetPVarInt(pid,"Money")+2000);
				}
			}
  		}
    }
}
//-----/ EndRound /-------------------------------------------------------------
public EndRound()
{
	PresidentPlayer = -1;
	TeamBalance = 3;
	LeftTime = 0;
	for(new i,pid,t=GetConnectedPlayers(); i<t; i++)
	{
		pid = GetConnectedPlayerID(i);
		if(GetPlayerMap(pid) == 2)
		{
		    PlayerTeam[pid] = false;
		    PlayerPlaySound(pid, 0, 0.0, 0.0, 0.0);
		    SpawnPlayer(pid);
		}
	}
	for(new i = 1; i < MAX_VEHICLES; i++)
		SetVehicleToRespawn(i);
}
//-----/ ShowPlayerTeamTD /-----------------------------------------------------
stock ShowPlayerTeamTD(playerid)
{
	for(new i=0; i<4; i++)
        TextDrawShowForPlayer(playerid,TeamSelectionTD[i]);
}
//-----/ HidePlayerTeamTD /-----------------------------------------------------
stock HidePlayerTeamTD(playerid)
{
	for(new i=0; i<4; i++)
        TextDrawHideForPlayer(playerid,TeamSelectionTD[i]);
}
//-----/ GetPresidentPlayer /---------------------------------------------------
stock GetPresidentPlayer()
{
	return PresidentPlayer;
}
//-----/ SetPresidentPlayer /---------------------------------------------------
stock SetPresidentPlayer(playerid)
{
	PresidentPlayer = playerid;
}
//-----/ GetBalance /-----------------------------------------------------------
stock GetBalance()
{
    return TeamBalance;
}
//-----/ SetBalance /-----------------------------------------------------------
stock SetBalance(value)
{
	TeamBalance = value;
}
//-----/ GetRoundTimer /--------------------------------------------------------
stock GetRoundTimer()
{
    return RoundTimer;
}
//-----/ SetPlayerHasTeam /-----------------------------------------------------
stock SetPlayerHasTeam(playerid,bool:value)
{
	PlayerTeam[playerid] = value;
}
