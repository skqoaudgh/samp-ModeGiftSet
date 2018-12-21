/*
  [Functions]
	ShowPlayerToggleDialog(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Toggle
	#endinput
#endif
#define _MDPWN_Toggle



//-----/ Includes /



//-----/ Defines /
#define DialogID_Toggle(%1)			10300 + %1



//-----/ News /
	//--/  /



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Toggle();
forward CommandHandler_Toggle(playerid,cmdtext[]);
forward DialogHandler_Toggle(playerid,dialogid,response,listitem,inputtext[]);
	//--/ Functions /





//==========/ Callback Functions /==============================================
//-----/ AddHandler_Toggle /----------------------------------------------------
public AddHandler_Toggle()
{
	AddHandler("Toggle",CommandHandler);
	AddHandler("Toggle",DialogHandler);
	//AddHandler("WTF",InitHandler);
	//AddTimer("WTF",TIMER_1S_PLAYER);
}
//-----/ CommandHandler_Toggle /------------------------------------------------
public CommandHandler_Toggle(playerid,cmdtext[])
{
	if(!strcmp("/ä��",cmdtext) || !strcmp("/����ġ",cmdtext) || !strcmp("/���",cmdtext) || !strcmp("/toggle",cmdtext) || !strcmp("/tog",cmdtext) || !strcmp("/switch",cmdtext))
	{
		ShowPlayerToggleDialog(playerid);
		return 1;
	}
	return 0;
}
//-----/ DialogHandler_Toggle /-------------------------------------------------
public DialogHandler_Toggle(playerid,dialogid,response,listitem,inputtext[])
{
	switch(dialogid)
	{
		case DialogID_Toggle(0):
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(GetPVarInt(playerid,"ToggleGlobal"))
							SetPVarInt(playerid,"ToggleGlobal",0);
						else
							SetPVarInt(playerid,"ToggleGlobal",1);
					}
					case 1:
					{
						if(GetPVarInt(playerid,"TogglePM"))
							SetPVarInt(playerid,"TogglePM",0);
						else
							SetPVarInt(playerid,"TogglePM",1);
					}
				}
				SavePlayerData(playerid);
				ShowPlayerToggleDialog(playerid);
			}
		}
	}
	return 0;
}

//==========/ Dialog Functions /================================================
//-----/ ShowPlayerToggleDialog /-----------------------------------------------
stock ShowPlayerToggleDialog(playerid)
{
	new dialog[1000];

	if(GetPlayerLanguage(playerid) == 0)
	{
		if(GetPVarInt(playerid,"ToggleGlobal"))
			strcat(dialog,"> ��ü ä��\t"C_PASTEL_GREEN"���\n");
		else
			strcat(dialog,"> ��ü ä��\t"C_PASTEL_RED"�ź�\n");

		if(GetPVarInt(playerid,"TogglePM"))
			strcat(dialog,"> �ӼӸ�\t"C_PASTEL_GREEN"���\n");
		else
			strcat(dialog,"> �ӼӸ�\t"C_PASTEL_RED"�ź�\n");
	}
	else
	{
		if(GetPVarInt(playerid,"ToggleGlobal"))
			strcat(dialog,"> Global Chatting\t"C_PASTEL_GREEN"Enabled\n");
		else
			strcat(dialog,"> Global Chatting\t"C_PASTEL_RED"Disabled\n");

		if(GetPVarInt(playerid,"TogglePM"))
			strcat(dialog,"> Private Message\t"C_PASTEL_GREEN"Enabled\n");
		else
			strcat(dialog,"> Private Message\t"C_PASTEL_RED"Disabled\n");
	}

	ShowPlayerDialog(playerid,DialogID_Toggle(0),DIALOG_STYLE_TABLIST,"Chatting Toggle",dialog,"����","�ݱ�");
}
