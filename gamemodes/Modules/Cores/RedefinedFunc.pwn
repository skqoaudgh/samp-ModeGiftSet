/*
 *
 *		[For a better future, Enthusiasm of Acu]
 *
 *			Redefined Functions
 *			v1.0.0
 *
 *
 *		First Release:		2017/02/08
 *		Last Update:		2017/02/08
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
  [Functions]
	strlen(const string[])
*/

//-----/ Pre-Processing /
#if defined _MDPWN_RedefinedFunc
	#endinput
#endif
#define _MDPWN_RedefinedFunc





//==========/ Redefined Functions /=============================================
//-----/ strlen /---------------------------------------------------------------
stock strlen_n(const string[])
{
	if(!strcmp(string,"/Empty/"))
		return 0;
	return strlen(string);
}
stock strlen_o(const string[])
	return strlen(string);
#define strlen strlen_n
//-----/ GetPlayerMoney /-------------------------------------------------------
stock GetPlayerMoney_n(playerid)
{
	return GetPVarInt(playerid,"Money");
}
stock GetPlayerMoney_o(playerid)
{
	return GetPlayerMoney(playerid);
}
#define GetPlayerMoney GetPlayerMoney_n
