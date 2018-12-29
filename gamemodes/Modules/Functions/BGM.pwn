/*
  [Functions]
    PlayAudioStreamForPlayerEx(playerid)
    StopAudioStreamForPlayerEx(playerid)
*/

//-----/ Pre-Processing /
#if defined _MDPWN_BGM
	#endinput
#endif
#define _MDPWN_BGM

//-----/ News /
	//--/ BGM /
new BGMtimer[MAX_PLAYERS];
enum bInfo
{
	URL[128],
	Length
}
new BGMInfo[3][bInfo] = {
{"http://pds25.egloos.com/pds/201812/21/67/lobby.mp3",219}, // ·Îºñ
{"http://pds21.egloos.com/pds/201812/21/67/run.mp3",159}, // Run
{"http://pds25.egloos.com/pds/201812/21/67/69.mp3",288} // 69
};

//-----/ Forwards /
	//--/ Functions /
forward PlayAudioStreamForPlayerEx(playerid);


//==========/ Functions /=======================================================
//-----/ PlayAudioStreamForPlayerEx /-------------------------------------------
public PlayAudioStreamForPlayerEx(playerid)
{
	if(GetPVarInt(playerid,"ToggleBGM") == 1)
	{
		new map = GetPlayerMap(playerid);
		StopAudioStreamForPlayerEx(playerid);
		switch(map)
		{
		    case 0:
			{
			    PlayAudioStreamForPlayer(playerid, BGMInfo[0][URL]);
			    BGMtimer[playerid] = SetTimerEx("PlayAudioStreamForPlayerEx",BGMInfo[0][Length]*1000,false,"d",playerid);
			}
		    case 1:
		    {
			    PlayAudioStreamForPlayer(playerid, BGMInfo[1][URL]);
			    BGMtimer[playerid] = SetTimerEx("PlayAudioStreamForPlayerEx",BGMInfo[1][Length]*1000,false,"d",playerid);
			}
		    case 5:
		    {
			    PlayAudioStreamForPlayer(playerid, BGMInfo[2][URL]);
			    BGMtimer[playerid] = SetTimerEx("PlayAudioStreamForPlayerEx",BGMInfo[2][Length]*1000,false,"d",playerid);
			}
			default: { }
		}
	}
}
//-----/ StopAudioStreamForPlayerEx /-------------------------------------------
stock StopAudioStreamForPlayerEx(playerid)
{
	KillTimer(BGMtimer[playerid]);
	StopAudioStreamForPlayer(playerid);
}
