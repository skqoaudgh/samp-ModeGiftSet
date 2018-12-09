/*
  [Functions]
	GetPlayerNameEx(playerid)
	GetPlayerIP(playerid)
	SetPlayerMoney(playerid,money)
	GetPVarStringEx(playerid,varname[])

	strcpy(dest[],src[])
	strtok(const string[],&index,separator=' ')
	strblank(input[])

	Wait(time)
	Crash()
*/

//-----/ Pre-Processing /
#if defined _MDPWN_ExtendedFunc
	#endinput
#endif
#define _MDPWN_ExtendedFunc





//==========/ Extended Functions /==============================================
//-----/ GetPlayerNameEx /------------------------------------------------------
stock GetPlayerNameEx(playerid)
{
	new name[21];
	GetPlayerName(playerid,name,21);
	return name;
}
//-----/ GetPlayerIP /----------------------------------------------------------
stock GetPlayerIP(playerid)
{
	new ip[16];
	GetPlayerIp(playerid,ip,sizeof(ip));
	return ip;
}
//-----/ SetPlayerMoney /-------------------------------------------------------
stock SetPlayerMoney(playerid,money)
{
	GivePlayerMoney(playerid,money-GetPlayerMoney(playerid));
	return 1;
}
//-----/ GetPVarStringEx /------------------------------------------------------
stock GetPVarStringEx(playerid,varname[])
{
	new string[100];
	GetPVarString(playerid,varname,string,100);
	return string;
}






//==========/ String Functions /================================================
//-----/ strcpy /---------------------------------------------------------------
stock strcpy(dest[],src[],size=sizeof(dest))
{
	dest[0] = '\0';
	return strcat(dest,src,size);
}
//-----/ strtok /---------------------------------------------------------------
stock strtok(const string[],&index,separator=' ')
{
	new length = strlen(string);
	new offset = index;
	new result[256];
	while((index < length) && (string[index] != separator || (index+1 < length && string[index+1] == separator)) && ((index - offset) < (sizeof(result) - 1)))
	{
		if(string[index] == separator)
			result[index - offset] = EOS;
		else
			result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	if((index < length) && (string[index] == separator))
		index++;
	return result;
}
//-----/ strblank /-------------------------------------------------------------
stock strblank(input[])
{
	new string[1024];
	if(strlen(input))
		strcpy(string,input);
	else
		strcpy(string,"/Empty/");
	return string;
}





//==========/ Server-side Functions /===========================================
//-----/ Wait /-----------------------------------------------------------------
stock Wait(time)
{
	new stamp = tickcount();
	while (tickcount() - stamp < time) {}
}
//-----/ Crash /----------------------------------------------------------------
stock Crash()
{
	new File:hFile;
	hFile = fopen("crash/crash.txt",io_append); // 없는 파일을 열어서 널포인터 반환
	fwrite(hFile,"%s"); // 널포인터에 쓰기 시도하면 크래시 발생
	fclose(hFile);
}
