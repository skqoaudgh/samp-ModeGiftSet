/*
  [Functions]
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Skin
	#endinput
#endif
#define _MDPWN_Skin


//-----/ Defines /


//-----/ News /
	//--/ Textdraw /
new Text:DialogFrame_Textdraw[26];
new Text:Move_Textdraw[2];
new PlayerText:Skin_Textdraw[MAX_PLAYERS][10][2];
new PlayerText:PageIndex_Textdraw[MAX_PLAYERS];
new PlayerText:SkinBox_Textdraw[MAX_PLAYERS][10];
	//--/ Dialog Info /
new bool:Player_In_SkinDialog[MAX_PLAYERS];
new PlayerPage[MAX_PLAYERS];
new PlayerSelectSkin[MAX_PLAYERS];

//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Skin();
forward InitHandler_Skin();
forward CommandHandler_Skin(playerid,cmdtext[]);
forward ConnectHandler_Skin(playerid);
forward ClickTDHandler_Skin(playerid,Text:clickedid);
forward ClickPTDHandler_Skin(playerid,PlayerText:playertextid);
forward DisconnectHandler_Skin(playerid,reason);
	//--/ Functions /


//==========/ Callback Functions /==============================================
//-----/ AddHandler_Skin /------------------------------------------------------
public AddHandler_Skin()
{
	AddHandler("Skin",InitHandler);
	AddHandler("Skin",CommandHandler);
	AddHandler("Skin",ConnectHandler);
	AddHandler("Skin",DisconnectHandler);
	AddHandler("Skin",ClickTDHandler);
	AddHandler("Skin",ClickPTDHandler);
}

public InitHandler_Skin()
{
	DialogFrame_Textdraw[0] = TextDrawCreate(320.000000, 75.000000, "MainFrame");
	TextDrawLetterSize(DialogFrame_Textdraw[0], 0.000000, 28.000000);
	TextDrawTextSize(DialogFrame_Textdraw[0], 0.000000, 335.000000);
	TextDrawAlignment(DialogFrame_Textdraw[0], 2);
	TextDrawColor(DialogFrame_Textdraw[0], -1);
	TextDrawUseBox(DialogFrame_Textdraw[0], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[0], 200);
	TextDrawBackgroundColor(DialogFrame_Textdraw[0], 255);
	TextDrawFont(DialogFrame_Textdraw[0], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[0], 1);

	DialogFrame_Textdraw[1] = TextDrawCreate(320.000000, 75.000000, "TopBar");
	TextDrawLetterSize(DialogFrame_Textdraw[1], 0.000000, 1.500000);
	TextDrawTextSize(DialogFrame_Textdraw[1], 0.000000, 335.000000);
	TextDrawAlignment(DialogFrame_Textdraw[1], 2);
	TextDrawColor(DialogFrame_Textdraw[1], -1);
	TextDrawUseBox(DialogFrame_Textdraw[1], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[1], 255);
	TextDrawBackgroundColor(DialogFrame_Textdraw[1], 255);
	TextDrawFont(DialogFrame_Textdraw[1], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[1], 1);

	DialogFrame_Textdraw[2] = TextDrawCreate(320.000000, 97.000000, "WhiteBound");
	TextDrawLetterSize(DialogFrame_Textdraw[2], 0.000000, 21.500000);
	TextDrawTextSize(DialogFrame_Textdraw[2], 0.000000, 325.000000);
	TextDrawAlignment(DialogFrame_Textdraw[2], 2);
	TextDrawColor(DialogFrame_Textdraw[2], -1);
	TextDrawUseBox(DialogFrame_Textdraw[2], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[2], -1);
	TextDrawBackgroundColor(DialogFrame_Textdraw[2], 255);
	TextDrawFont(DialogFrame_Textdraw[2], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[2], 1);

	DialogFrame_Textdraw[3] = TextDrawCreate(319.866729, 97.755531, "InnerFrame");
	TextDrawLetterSize(DialogFrame_Textdraw[3], 0.000000, 21.299999);
	TextDrawTextSize(DialogFrame_Textdraw[3], 0.000000, 323.000000);
	TextDrawAlignment(DialogFrame_Textdraw[3], 2);
	TextDrawColor(DialogFrame_Textdraw[3], -1);
	TextDrawUseBox(DialogFrame_Textdraw[3], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[3], 255);
	TextDrawBackgroundColor(DialogFrame_Textdraw[3], 255);
	TextDrawFont(DialogFrame_Textdraw[3], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[3], 1);

	DialogFrame_Textdraw[4] = TextDrawCreate(250.000000, 303.000000, "OKwhiteBound");
	TextDrawLetterSize(DialogFrame_Textdraw[4], 0.000000, 1.500000);
	TextDrawTextSize(DialogFrame_Textdraw[4], 0.000000, 60.000000);
	TextDrawAlignment(DialogFrame_Textdraw[4], 2);
	TextDrawColor(DialogFrame_Textdraw[4], -1);
	TextDrawUseBox(DialogFrame_Textdraw[4], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[4], -1);
	TextDrawBackgroundColor(DialogFrame_Textdraw[4], 255);
	TextDrawFont(DialogFrame_Textdraw[4], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[4], 1);

	DialogFrame_Textdraw[5] = TextDrawCreate(322.000000, 303.000000, "CancelwhiteBound");
	TextDrawLetterSize(DialogFrame_Textdraw[5], 0.000000, 1.500000);
	TextDrawTextSize(DialogFrame_Textdraw[5], 0.000000, 60.000000);
	TextDrawAlignment(DialogFrame_Textdraw[5], 2);
	TextDrawColor(DialogFrame_Textdraw[5], -1);
	TextDrawUseBox(DialogFrame_Textdraw[5], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[5], -1);
	TextDrawBackgroundColor(DialogFrame_Textdraw[5], 255);
	TextDrawFont(DialogFrame_Textdraw[5], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[5], 1);

	DialogFrame_Textdraw[6] = TextDrawCreate(249.699005, 303.700042, "OKinner");
	TextDrawLetterSize(DialogFrame_Textdraw[6], 0.000000, 1.299999);
	TextDrawTextSize(DialogFrame_Textdraw[6], 0.000000, 58.000000);
	TextDrawAlignment(DialogFrame_Textdraw[6], 2);
	TextDrawColor(DialogFrame_Textdraw[6], -1);
	TextDrawUseBox(DialogFrame_Textdraw[6], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[6], 255);
	TextDrawBackgroundColor(DialogFrame_Textdraw[6], 255);
	TextDrawFont(DialogFrame_Textdraw[6], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[6], 1);

	DialogFrame_Textdraw[7] = TextDrawCreate(321.996887, 303.700042, "Cancelinner");
	TextDrawLetterSize(DialogFrame_Textdraw[7], 0.000000, 1.299999);
	TextDrawTextSize(DialogFrame_Textdraw[7], 0.000000, 58.000000);
	TextDrawAlignment(DialogFrame_Textdraw[7], 2);
	TextDrawColor(DialogFrame_Textdraw[7], -1);
	TextDrawUseBox(DialogFrame_Textdraw[7], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[7], 255);
	TextDrawBackgroundColor(DialogFrame_Textdraw[7], 255);
	TextDrawFont(DialogFrame_Textdraw[7], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[7], 1);

	DialogFrame_Textdraw[8] = TextDrawCreate(249.632873, 304.043579, "Buy");
	TextDrawLetterSize(DialogFrame_Textdraw[8], 0.300000, 1.200000);
	TextDrawTextSize(DialogFrame_Textdraw[8], 11.000000, 58.000000);
	TextDrawAlignment(DialogFrame_Textdraw[8], 2);
	TextDrawColor(DialogFrame_Textdraw[8], -1);
	TextDrawFont(DialogFrame_Textdraw[8], 2);
	TextDrawSetProportional(DialogFrame_Textdraw[8], 1);
	TextDrawSetSelectable(DialogFrame_Textdraw[8], 1);

	DialogFrame_Textdraw[9] = TextDrawCreate(321.898437, 303.659179, "Cancel");
	TextDrawLetterSize(DialogFrame_Textdraw[9], 0.300000, 1.200000);
	TextDrawTextSize(DialogFrame_Textdraw[9], 11.000000, 58.000000);
	TextDrawAlignment(DialogFrame_Textdraw[9], 2);
	TextDrawColor(DialogFrame_Textdraw[9], -1);
	TextDrawFont(DialogFrame_Textdraw[9], 2);
	TextDrawSetProportional(DialogFrame_Textdraw[9], 1);
	TextDrawSetSelectable(DialogFrame_Textdraw[9], 1);

	DialogFrame_Textdraw[20] = TextDrawCreate(190.000000, 75.925956, "Skin List Dialog");
	TextDrawLetterSize(DialogFrame_Textdraw[20], 0.200000, 1.200000);
	TextDrawTextSize(DialogFrame_Textdraw[20], 0.000000, 200.000000);
	TextDrawAlignment(DialogFrame_Textdraw[20], 2);
	TextDrawColor(DialogFrame_Textdraw[20], -1378294017);
	TextDrawBackgroundColor(DialogFrame_Textdraw[20], 255);
	TextDrawFont(DialogFrame_Textdraw[20], 2);
	TextDrawSetProportional(DialogFrame_Textdraw[20], 1);
	
	DialogFrame_Textdraw[21] = TextDrawCreate(417.933319, 302.014801, ">WhiteBox");
	TextDrawLetterSize(DialogFrame_Textdraw[21], 0.000000, 1.500000);
	TextDrawTextSize(DialogFrame_Textdraw[21], 0.000000, 11.000000);
	TextDrawAlignment(DialogFrame_Textdraw[21], 2);
	TextDrawColor(DialogFrame_Textdraw[21], -1);
	TextDrawUseBox(DialogFrame_Textdraw[21], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[21], -1);
	TextDrawBackgroundColor(DialogFrame_Textdraw[21], 255);
	TextDrawFont(DialogFrame_Textdraw[21], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[21], 1);

	DialogFrame_Textdraw[22] = TextDrawCreate(418.000000, 302.599853, ">InnerBox");
	TextDrawLetterSize(DialogFrame_Textdraw[22], 0.000000, 1.399999);
	TextDrawTextSize(DialogFrame_Textdraw[22], 0.000000, 9.500000);
	TextDrawAlignment(DialogFrame_Textdraw[22], 2);
	TextDrawColor(DialogFrame_Textdraw[22], -1);
	TextDrawUseBox(DialogFrame_Textdraw[22], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[22], 255);
	TextDrawBackgroundColor(DialogFrame_Textdraw[22], 255);
	TextDrawFont(DialogFrame_Textdraw[22], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[22], 1);

	DialogFrame_Textdraw[23] = TextDrawCreate(394.231842, 302.014801, "<WhiteBox");
	TextDrawLetterSize(DialogFrame_Textdraw[23], 0.000000, 1.500000);
	TextDrawTextSize(DialogFrame_Textdraw[23], 0.000000, 11.000000);
	TextDrawAlignment(DialogFrame_Textdraw[23], 2);
	TextDrawColor(DialogFrame_Textdraw[23], -1);
	TextDrawUseBox(DialogFrame_Textdraw[23], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[23], -1);
	TextDrawBackgroundColor(DialogFrame_Textdraw[23], 255);
	TextDrawFont(DialogFrame_Textdraw[23], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[23], 1);

	DialogFrame_Textdraw[24] = TextDrawCreate(394.298553, 302.599853, "<InnerBox");
	TextDrawLetterSize(DialogFrame_Textdraw[24], 0.000000, 1.399999);
	TextDrawTextSize(DialogFrame_Textdraw[24], 0.000000, 9.500000);
	TextDrawAlignment(DialogFrame_Textdraw[24], 2);
	TextDrawColor(DialogFrame_Textdraw[24], -1);
	TextDrawUseBox(DialogFrame_Textdraw[24], 1);
	TextDrawBoxColor(DialogFrame_Textdraw[24], 255);
	TextDrawBackgroundColor(DialogFrame_Textdraw[24], 255);
	TextDrawFont(DialogFrame_Textdraw[24], 1);
	TextDrawSetProportional(DialogFrame_Textdraw[24], 1);

	DialogFrame_Textdraw[25] = TextDrawCreate(477.666625, 75.511108, "/32");
	TextDrawLetterSize(DialogFrame_Textdraw[25], 0.200000, 1.200000);
	TextDrawAlignment(DialogFrame_Textdraw[25], 2);
	TextDrawColor(DialogFrame_Textdraw[25], -1378294017);
	TextDrawBackgroundColor(DialogFrame_Textdraw[25], 255);
	TextDrawFont(DialogFrame_Textdraw[25], 2);
	TextDrawSetProportional(DialogFrame_Textdraw[25], 1);

	Move_Textdraw[0] = TextDrawCreate(394.398864, 302.059234, "<");
	TextDrawLetterSize(Move_Textdraw[0], 0.300000, 1.500000);
	TextDrawTextSize(Move_Textdraw[0], 11.000000, 11.000000);
	TextDrawAlignment(Move_Textdraw[0], 2);
	TextDrawColor(Move_Textdraw[0], -1);
	TextDrawBackgroundColor(Move_Textdraw[0], 255);
	TextDrawFont(Move_Textdraw[0], 2);
	TextDrawSetProportional(Move_Textdraw[0], 1);
	TextDrawSetSelectable(Move_Textdraw[0], 1);

	Move_Textdraw[1] = TextDrawCreate(418.133636, 302.159240, ">");
	TextDrawLetterSize(Move_Textdraw[1], 0.300000, 1.500000);
	TextDrawTextSize(Move_Textdraw[1], 11.000000, 11.000000);
	TextDrawAlignment(Move_Textdraw[1], 2);
	TextDrawColor(Move_Textdraw[1], -1);
	TextDrawBackgroundColor(Move_Textdraw[1], 255);
	TextDrawFont(Move_Textdraw[1], 2);
	TextDrawSetProportional(Move_Textdraw[1], 1);
	TextDrawSetSelectable(Move_Textdraw[1], 1);
}
public ConnectHandler_Skin(playerid)
{
    PlayerPage[playerid] = 1;

	SkinBox_Textdraw[playerid][0] = CreatePlayerTextDraw(playerid,190.700317, 100.629653, "SkinBox1");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][0], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][0], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][0], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][0], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][0], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][0], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][0], 1);

	SkinBox_Textdraw[playerid][1] = CreatePlayerTextDraw(playerid,255.601074, 100.629653, "SkinBox2");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][1], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][1], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][1], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][1], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][1], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][1], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][1], 1);

	SkinBox_Textdraw[playerid][2] = CreatePlayerTextDraw(playerid,320.168151, 100.629653, "SkinBox3");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][2], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][2], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][2], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][2], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][2], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][2], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][2], 1);

	SkinBox_Textdraw[playerid][3] = CreatePlayerTextDraw(playerid,384.935058, 100.629653, "SkinBox4");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][3], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][3], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][3], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][3], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][3], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][3], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][3], 1);

	SkinBox_Textdraw[playerid][4] = CreatePlayerTextDraw(playerid,449.568786, 100.629653, "SkinBox5");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][4], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][4], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][4], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][4], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][4], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][4], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][4], 1);

	SkinBox_Textdraw[playerid][5] = CreatePlayerTextDraw(playerid,190.966644, 196.444198, "SkinBox6");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][5], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][5], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][5], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][5], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][5], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][5], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][5], 1);

	SkinBox_Textdraw[playerid][6] = CreatePlayerTextDraw(playerid,255.466644, 196.444198, "SkinBox7");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][6], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][6], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][6], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][6], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][6], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][6], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][6], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][6], 1);

	SkinBox_Textdraw[playerid][7] = CreatePlayerTextDraw(playerid,320.166748, 196.444198, "SkinBox8");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][7], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][7], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][7], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][7], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][7], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][7], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][7], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][7], 1);

	SkinBox_Textdraw[playerid][8] = CreatePlayerTextDraw(playerid,384.867187, 196.444198, "SkinBox9");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][8], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][8], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][8], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][8], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][8], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][8], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][8], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][8], 1);

	SkinBox_Textdraw[playerid][9] = CreatePlayerTextDraw(playerid,449.367645, 196.444198, "SkinBox10");
	PlayerTextDrawLetterSize(playerid,SkinBox_Textdraw[playerid][9], 0.000000, 10.000000);
	PlayerTextDrawTextSize(playerid,SkinBox_Textdraw[playerid][9], 0.000000, 60.000000);
	PlayerTextDrawAlignment(playerid,SkinBox_Textdraw[playerid][9], 2);
	PlayerTextDrawColor(playerid,SkinBox_Textdraw[playerid][9], -1);
	PlayerTextDrawUseBox(playerid,SkinBox_Textdraw[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][9], -2139062017);
	PlayerTextDrawBackgroundColor(playerid,SkinBox_Textdraw[playerid][9], 255);
	PlayerTextDrawFont(playerid,SkinBox_Textdraw[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid,SkinBox_Textdraw[playerid][9], 1);
	
	Skin_Textdraw[playerid][0][0] = CreatePlayerTextDraw(playerid,159.033798, 99.007339, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][0][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][0][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][0][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][0][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][0][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][0][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][0][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][0][0], 0);
    PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][0][0],1);
    
	Skin_Textdraw[playerid][0][1] = CreatePlayerTextDraw(playerid,190.000015, 181.288879, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][0][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][0][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][0][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][0][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][0][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][0][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][0][1], 1);
    
	Skin_Textdraw[playerid][1][0] = CreatePlayerTextDraw(playerid,224.134399, 99.007339, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][1][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][1][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][1][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][1][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][1][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][1][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][1][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][1][0], 0);
    PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][1][0],1);
    
	Skin_Textdraw[playerid][1][1] = CreatePlayerTextDraw(playerid,255.100616, 181.288879, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][1][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][1][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][1][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][1][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][1][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][1][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][1][1], 1);

	Skin_Textdraw[playerid][2][0] = CreatePlayerTextDraw(playerid,289.235000, 99.007339, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][2][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][2][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][2][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][2][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][2][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][2][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][2][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][2][0], 0);
	PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][2][0],1);

	Skin_Textdraw[playerid][2][1] = CreatePlayerTextDraw(playerid,320.201217, 181.288879, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][2][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][2][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][2][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][2][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][2][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][2][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][2][1], 1);

	Skin_Textdraw[playerid][3][0] = CreatePlayerTextDraw(playerid,354.335601, 99.007339, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][3][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][3][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][3][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][3][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][3][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][3][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][3][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][3][0], 0);
	PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][3][0],1);

	Skin_Textdraw[playerid][3][1] = CreatePlayerTextDraw(playerid,385.301818, 181.288879, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][3][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][3][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][3][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][3][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][3][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][3][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][3][1], 1);

	Skin_Textdraw[playerid][4][0] = CreatePlayerTextDraw(playerid,419.436202, 99.007339, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][4][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][4][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][4][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][4][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][4][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][4][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][4][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][4][0], 0);
	PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][4][0],1);

	Skin_Textdraw[playerid][4][1] = CreatePlayerTextDraw(playerid,450.402419, 181.288879, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][4][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][4][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][4][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][4][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][4][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][4][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][4][1], 1);

	Skin_Textdraw[playerid][5][0] = CreatePlayerTextDraw(playerid,159.033798, 194.811279, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][5][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][5][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][5][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][5][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][5][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][5][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][5][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][5][0], 0);
	PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][5][0],1);

	Skin_Textdraw[playerid][5][1] = CreatePlayerTextDraw(playerid,190.000015, 277.785888, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][5][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][5][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][5][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][5][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][5][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][5][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][5][1], 1);

	Skin_Textdraw[playerid][6][0] = CreatePlayerTextDraw(playerid,224.134399, 193.833496, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][6][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][6][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][6][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][6][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][6][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][6][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][6][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][6][0], 0);
    PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][6][0],1);
    
	Skin_Textdraw[playerid][6][1] = CreatePlayerTextDraw(playerid,255.100616, 277.785888, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][6][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][6][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][6][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][6][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][6][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][6][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][6][1], 1);

	Skin_Textdraw[playerid][7][0] = CreatePlayerTextDraw(playerid,289.235000, 193.833496, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][7][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][7][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][7][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][7][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][7][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][7][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][7][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][7][0], 0);
	PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][7][0],1);

	Skin_Textdraw[playerid][7][1] = CreatePlayerTextDraw(playerid,320.201217, 277.785888, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][7][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][7][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][7][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][7][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][7][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][7][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][7][1], 1);

	Skin_Textdraw[playerid][8][0] = CreatePlayerTextDraw(playerid,354.335601, 193.833496, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][8][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][8][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][8][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][8][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][8][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][8][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][8][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][8][0], 0);
	PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][8][0],1);

	Skin_Textdraw[playerid][8][1] = CreatePlayerTextDraw(playerid,385.301818, 277.785888, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][8][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][8][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][8][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][8][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][8][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][8][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][8][1], 1);

	Skin_Textdraw[playerid][9][0] = CreatePlayerTextDraw(playerid,419.436202, 193.833496, "");
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][9][0], 63.000000, 85.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][9][0], 1);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][9][0], -1);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][9][0], 5);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][9][0], 0);
	PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][9][0], 0);
	PlayerTextDrawSetPreviewRot(playerid,Skin_Textdraw[playerid][9][0], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawBackgroundColor(playerid,Skin_Textdraw[playerid][9][0], 0);
	PlayerTextDrawSetSelectable(playerid,Skin_Textdraw[playerid][9][0],1);

	Skin_Textdraw[playerid][9][1] = CreatePlayerTextDraw(playerid,450.402419, 277.785888, "0");
	PlayerTextDrawLetterSize(playerid,Skin_Textdraw[playerid][9][1], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid,Skin_Textdraw[playerid][9][1], 0.000000, 999.000000);
	PlayerTextDrawAlignment(playerid,Skin_Textdraw[playerid][9][1], 2);
	PlayerTextDrawColor(playerid,Skin_Textdraw[playerid][9][1], -1);
	PlayerTextDrawSetShadow(playerid, Skin_Textdraw[playerid][9][1], 0);
	PlayerTextDrawFont(playerid,Skin_Textdraw[playerid][9][1], 2);
	PlayerTextDrawSetProportional(playerid,Skin_Textdraw[playerid][9][1], 1);
	
	PageIndex_Textdraw[playerid] = CreatePlayerTextDraw(playerid, 469.466308, 75.496276, "1");
	PlayerTextDrawLetterSize(playerid, PageIndex_Textdraw[playerid], 0.200000, 1.200000);
	PlayerTextDrawAlignment(playerid, PageIndex_Textdraw[playerid], 3);
	PlayerTextDrawColor(playerid, PageIndex_Textdraw[playerid], -1378294017);
	PlayerTextDrawSetShadow(playerid, PageIndex_Textdraw[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, PageIndex_Textdraw[playerid], 255);
	PlayerTextDrawFont(playerid, PageIndex_Textdraw[playerid], 2);
	PlayerTextDrawSetProportional(playerid, PageIndex_Textdraw[playerid], 1);
}
//-----/ DisconnectHandler_Skin /-----------------------------------------------
public DisconnectHandler_Skin(playerid,reason)
{
	PlayerPage[playerid] = 1;
	PlayerSelectSkin[playerid] = 0;
	Player_In_SkinDialog[playerid] = false;
	CancelSelectTextDraw(playerid);
}
//-----/ CommandHandler_Skin /--------------------------------------------------
public CommandHandler_Skin(playerid,cmdtext[])
{
	if(!strcmp("/skin",cmdtext) || !strcmp("/스킨",cmdtext) || !strcmp("/옷",cmdtext) || !strcmp("/옷변경",cmdtext) || !strcmp("/스킨변경",cmdtext) || !strcmp("/buyskin",cmdtext) || !strcmp("/changeskin",cmdtext))
	{
	    if(GetPlayerMap(playerid) != 0)
		{
		    if(GetPlayerLanguage(playerid) == 0)
				return SendClientMessage(playerid,COLOR_GREY,"[!] 로비에서만 사용할 수 있습니다.");
			else
			    return SendClientMessage(playerid,COLOR_GREY,"[!] You can use this command in lobby.");
		}
	    SelectTextDraw(playerid, 0xFF0000FF);
	    TogglePlayerSkinDialog(playerid, true);
	    SetPlayerSkinPage(playerid);
		return 1;
	}
 	if(!strcmp("/test2",cmdtext))
	{
		for(new i=0; i<10; i++)
		{
	        PlayerTextDrawHide(playerid,Skin_Textdraw[playerid][i][0]);
	        PlayerTextDrawHide(playerid,Skin_Textdraw[playerid][i][1]);
		}
	    return 1;
 	}
 	if(!strcmp("/test1",cmdtext))
	{
		for(new i=0; i<10; i++)
		{
	        PlayerTextDrawShow(playerid,Skin_Textdraw[playerid][i][0]);
	        PlayerTextDrawShow(playerid,Skin_Textdraw[playerid][i][1]);
		}
	    return 1;
 	}
 	if(!strcmp("/test4",cmdtext))
	{
		for(new i=0; i<10; i++)
		{
	        PlayerTextDrawHide(playerid,SkinBox_Textdraw[playerid][i]);
		}
	    return 1;
 	}
 	if(!strcmp("/test3",cmdtext))
	{
		for(new i=0; i<10; i++)
		{
	        PlayerTextDrawShow(playerid,SkinBox_Textdraw[playerid][i]);
		}
	    return 1;
 	}
	return 0;
}
//-----/ ClickTDHandler_Skin /--------------------------------------------------
public ClickTDHandler_Skin(playerid,Text:clickedid)
{
	if(Player_In_SkinDialog[playerid] && (clickedid == DialogFrame_Textdraw[9] || clickedid == Text:INVALID_TEXT_DRAW))
	{
        TogglePlayerSkinDialog(playerid, false);
		PlayerPage[playerid] = 1;
		PlayerSelectSkin[playerid] = 0;
		return 1;
	}
	else if(clickedid == DialogFrame_Textdraw[8]) // buy
	{
	    if(PlayerSelectSkin[playerid] > 311) return 1;
	    if(GetPlayerMoney(playerid) < 500)
		{
		    if(GetPlayerLanguage(playerid) == 0)
		        return SendClientMessage(playerid,COLOR_WHITE,"[!] 소지금이 부족합니다.");
			else
			    return SendClientMessage(playerid,COLOR_WHITE,"[!] You don`t have enough money.");
		}
	    if(GetPlayerLanguage(playerid) == 0)
   			SendClientMessage(playerid,COLOR_WHITE,"[!] 새로운 스킨을 구입했습니다.");
		else
		    SendClientMessage(playerid,COLOR_WHITE,"[!] You have bought new skin");
		//-----
		TogglePlayerSkinDialog(playerid, false);
		SetPlayerSkin(playerid,PlayerSelectSkin[playerid]);
		SetPVarInt(playerid,"Skin",PlayerSelectSkin[playerid]);
		GivePlayerMoneyEx(playerid, -500);
		SavePlayerData(playerid);
		return 1;
	}
	else if(clickedid == Move_Textdraw[0]) // left
	{
		PlayerPage[playerid] --;
	    if(PlayerPage[playerid] < 1)
            PlayerPage[playerid] = 32;
        PlayerTextDrawSetString(playerid,PageIndex_Textdraw[playerid],PlayerPage[playerid]);
		SetPlayerSkinPage(playerid);
		return 1;
	}
	else if(clickedid == Move_Textdraw[1]) // right
	{
		PlayerPage[playerid] ++;
	    if(PlayerPage[playerid] > 32)
            PlayerPage[playerid] = 1;
		PlayerTextDrawSetString(playerid,PageIndex_Textdraw[playerid],PlayerPage[playerid]);
        SetPlayerSkinPage(playerid);
		return 1;
	}
    return 0;
}
//-----/ ClickPTDHandler_Skin /-------------------------------------------------
public ClickPTDHandler_Skin(playerid,PlayerText:playertextid)
{
	for(new i=0; i<10; i++)
	{
	    if(playertextid == Skin_Textdraw[playerid][i][0])
		{
		    PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][i], -1061109505);
		    PlayerSelectSkin[playerid] = (PlayerPage[playerid]-1)*10 + i;
		}
		else
		    PlayerTextDrawBoxColor(playerid,SkinBox_Textdraw[playerid][i], -2139062017);
		PlayerTextDrawShow(playerid,SkinBox_Textdraw[playerid][i]);
	}
	return 0;
}
// 0~311

//==========/ Skin Functions /==================================================
//-----/ TogglePlayerSkinDialog /-----------------------------------------------
stock TogglePlayerSkinDialog(playerid, bool:toggle)
{
	if(toggle) // show
	{
	    for(new i=0; i<26; i++)
	        TextDrawShowForPlayer(playerid,DialogFrame_Textdraw[i]);
	    for(new i=0; i<2; i++)
	        TextDrawShowForPlayer(playerid,Move_Textdraw[i]);
	    for(new i=0; i<10; i++)
	        PlayerTextDrawShow(playerid,SkinBox_Textdraw[playerid][i]);
	    PlayerTextDrawShow(playerid,PageIndex_Textdraw[playerid]);
	    Player_In_SkinDialog[playerid] = true;
	}
	else // hide
	{
	    for(new i=0; i<26; i++)
	        TextDrawHideForPlayer(playerid,DialogFrame_Textdraw[i]);
	    for(new i=0; i<2; i++)
	        TextDrawHideForPlayer(playerid,Move_Textdraw[i]);
	    for(new i=0; i<10; i++)
	    {
	        PlayerTextDrawHide(playerid,SkinBox_Textdraw[playerid][i]);
	        PlayerTextDrawHide(playerid,Skin_Textdraw[playerid][i][0]);
	        PlayerTextDrawHide(playerid,Skin_Textdraw[playerid][i][1]);
	        
	    }
	    PlayerTextDrawHide(playerid,PageIndex_Textdraw[playerid]);
	    Player_In_SkinDialog[playerid] = false;
	    CancelSelectTextDraw(playerid);
	}
}
//-----/ SetPlayerSkinPage /----------------------------------------------------
stock SetPlayerSkinPage(playerid)
{
	new startIndex = (PlayerPage[playerid]-1)*10;
	for(new i=0; i<10; i++)
	{
	    new SkinID = startIndex + i;
	    new string[5];
	    PlayerTextDrawSetPreviewModel(playerid,Skin_Textdraw[playerid][i][0], SkinID);
		if(SkinID > 311)
		    string = " ";
		else
	    	valstr(string,SkinID);
        PlayerTextDrawSetString(playerid,Skin_Textdraw[playerid][i][1], string);
        valstr(string,PlayerPage[playerid]);
        PlayerTextDrawSetString(playerid,PageIndex_Textdraw[playerid], string);
        PlayerTextDrawShow(playerid,Skin_Textdraw[playerid][i][0]);
        PlayerTextDrawShow(playerid,Skin_Textdraw[playerid][i][1]);
        PlayerTextDrawShow(playerid,PageIndex_Textdraw[playerid]);
	}
}
