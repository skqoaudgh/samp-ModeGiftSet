/*
 *
 *		[For a better future, Enthusiasm of Acu]
 *
 *			Timer
 *			v1.1.1
 *
 *
 *		First Release:		2014/12/18
 *		Last Update:		2015/12/10
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
  [Usage]
	AddTimer("Test",TIMER_20NS_PLAYER);
	public TimerHandler_Test_20NS_P(playerid)

  [Functions]
	AddTimer(modulename[],type)
	CallTimer(index)
	ExecuteTimer(index)
	PrintTimerMeasure()
*/

//-----/ Pre-Processing /
#if defined _MDPWN_Timer
	#endinput
#endif
#define _MDPWN_Timer



//-----/ Defines /
#define TIMER_20NS				0
#define TIMER_20NS_PLAYER		1
#define TIMER_50NS				2
#define TIMER_50NS_PLAYER		3
#define TIMER_100NS				4
#define TIMER_100NS_PLAYER		5
#define TIMER_250NS				6
#define TIMER_250NS_PLAYER		7
#define TIMER_500NS				8
#define TIMER_500NS_PLAYER		9
#define TIMER_1S				10
#define TIMER_1S_PLAYER			11
#define TIMER_5S				12
#define TIMER_5S_PLAYER			13
#define TIMER_10S				14
#define TIMER_10S_PLAYER		15

#define MAX_TIMER_TYPES			16

#define TIMER_MEASURE_PRINT_TIME		5000 //ms
#define TIMER_MEASURE_THRESHOLD			11.0 //ms
#define TIMER_MEASURE_THRESHOLD_DETAIL	15.0 //ms



//-----/ News /
	//--/ Timer /
new
	TimerList[MAX_TIMER_TYPES][MAX_MODULES][48],
	TimerIndex[MAX_TIMER_TYPES],
	bool:TimerEnabled[MAX_TIMER_TYPES],
	TimerLastTime[MAX_TIMER_TYPES]
;
	//--/ Timer Measure /
new
	TimerMeasure_Time[MAX_TIMER_TYPES][MAX_MODULES],
	TimerMeasure_Count[MAX_TIMER_TYPES]
;



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_Timer();
forward InitHandler_Timer();
forward CommandHandler_Timer(playerid,cmdtext[]);
	//--/ Functions /
forward CallTimer(index);
forward ExecuteTimer(index);
forward PrintTimerMeasure();





//==========/ Callback Functions /==============================================
//-----/ AddHandler_Timer /-----------------------------------------------------
public AddHandler_Timer()
{
	AddHandler("Timer",InitHandler);
	AddHandler("Timer",CommandHandler);
}
//-----/ InitHandler_Timer /----------------------------------------------------
public InitHandler_Timer()
{
	for(new i; i<MAX_TIMER_TYPES; i++)
	{
		TimerEnabled[i] = true;
		TimerLastTime[i] = GetTickCount();
		SetTimerEx("CallTimer",10,1,"i",i);
	}
	SetTimer("PrintTimerMeasure",TIMER_MEASURE_PRINT_TIME,1);
}
//-----/ CommandHandler_Timer /-------------------------------------------------
public CommandHandler_Timer(playerid,cmdtext[])
{
	new
		cmd[256],idx,
		string[128]
	;
	cmd = strtok(cmdtext,idx);

	if(!strcmp("/타이머",cmd))
	{
		cmd = strtok(cmdtext,idx);
		if(!strlen(cmd))
			return SendClientMessage(playerid,COLOR_GREY,"[!] 사용법: /타이머 [번호]");
		if(!strcmp("끄기",cmd))
		{
			for(new i; i<MAX_TIMER_TYPES; i++)
				TimerEnabled[i] = false;
			SendClientMessage(playerid,0xFFFFFFFF,"ALL TIMER: "C_PASTEL_RED"OFF");
		}
		else if(!strcmp("켜기",cmd))
		{
			for(new i; i<MAX_TIMER_TYPES; i++)
				TimerEnabled[i] = true;
			SendClientMessage(playerid,0xFFFFFFFF,"ALL TIMER: "C_PASTEL_GREEN"ON");
		} else {
			new id = strval(cmd);
			if(id < 0 || id >= MAX_TIMER_TYPES)
				return SendClientMessage(playerid,0xFFFFFFFF,"[!] 타이머 번호가 잘못되었습니다.");
			TimerEnabled[id] = TimerEnabled[id] ? false : true;
			switch(id)
			{
				case TIMER_20NS			: strcpy(string,"TIMER_20NS");
				case TIMER_20NS_PLAYER	: strcpy(string,"TIMER_20NS_PLAYER");
				case TIMER_50NS			: strcpy(string,"TIMER_50NS");
				case TIMER_50NS_PLAYER	: strcpy(string,"TIMER_50NS_PLAYER");
				case TIMER_100NS		: strcpy(string,"TIMER_100NS");
				case TIMER_100NS_PLAYER : strcpy(string,"TIMER_100NS_PLAYER");
				case TIMER_250NS		: strcpy(string,"TIMER_250NS");
				case TIMER_250NS_PLAYER : strcpy(string,"TIMER_250NS_PLAYER");
				case TIMER_500NS		: strcpy(string,"TIMER_500NS");
				case TIMER_500NS_PLAYER : strcpy(string,"TIMER_500NS_PLAYER");
				case TIMER_1S			: strcpy(string,"TIMER_1S");
				case TIMER_1S_PLAYER	: strcpy(string,"TIMER_1S_PLAYER");
				case TIMER_5S			: strcpy(string,"TIMER_5S");
				case TIMER_5S_PLAYER	: strcpy(string,"TIMER_5S_PLAYER");
				case TIMER_10S			: strcpy(string,"TIMER_10S");
				case TIMER_10S_PLAYER	: strcpy(string,"TIMER_10S_PLAYER");
			}
			if(TimerEnabled[id])
				strcat(string,": ON");
			else
				strcat(string,": OFF");
			SendClientMessage(playerid,0xFFFFFFFF,string);
		}
		return 1;
	}

	return 0;
}





//==========/ Timer Functions /=================================================
//-----/ AddTimer /-------------------------------------------------------------
stock AddTimer(modulename[],type)
{
	new string[48];
	if(type % 2 == 0)
		format(string,sizeof(string),"TimerHandler_%s",modulename);
	else
		format(string,sizeof(string),"TimerHandler_%s_P",modulename);
	strcpy(TimerList[type][TimerIndex[type]],string);
	TimerIndex[type]++;
}
//-----/ CallTimer /------------------------------------------------------------
public CallTimer(index)
{
	new time,passed;
	if(TimerEnabled[index])
	{
		switch(index)
		{
			case TIMER_20NS			: time = 20;
			case TIMER_20NS_PLAYER 	: time = 20;
			case TIMER_50NS			: time = 50;
			case TIMER_50NS_PLAYER 	: time = 50;
			case TIMER_100NS		: time = 100;
			case TIMER_100NS_PLAYER : time = 100;
			case TIMER_250NS		: time = 250;
			case TIMER_250NS_PLAYER : time = 250;
			case TIMER_500NS		: time = 500;
			case TIMER_500NS_PLAYER : time = 500;
			case TIMER_1S			: time = 1000;
			case TIMER_1S_PLAYER	: time = 1000;
			case TIMER_5S			: time = 5000;
			case TIMER_5S_PLAYER	: time = 5000;
			case TIMER_10S			: time = 10000;
			case TIMER_10S_PLAYER	: time = 10000;
		}
		passed = GetTickCount() - TimerLastTime[index];
		if(passed > time)
		{
			TimerLastTime[index] = GetTickCount() - (passed - time);
			ExecuteTimer(index);
		}
	}
}
//-----/ ExecuteTimer /---------------------------------------------------------
public ExecuteTimer(index)
{
	new tick;
	TimerMeasure_Count[index]++;
	if(index % 2 == 0)
	{
		for(new i; i<TimerIndex[index]; i++)
		{
			tick = GetTickCount();
			if(CallLocalFunction(TimerList[index][i],"") == 0)
				printf("[timer] Zero-value has returned. [%s]",TimerList[index][i]);
			TimerMeasure_Time[index][i] += GetTickCount() - tick;
		}
	} else {
		for(new i; i<TimerIndex[index]; i++)
		{
			tick = GetTickCount();
			for(new p; p<MAX_PLAYERS; p++)
				if(IsPlayerConnected(p))
					if(CallLocalFunction(TimerList[index][i],"i",p) == 0)
						printf("[timer] Zero-value has been returned. [%s][%d]",TimerList[index][i],p);
			TimerMeasure_Time[index][i] += GetTickCount() - tick;
		}
	}
}
//-----/ PrintTimerMeasure /----------------------------------------------------
public PrintTimerMeasure()
{
	new
		string[256],cnt,
		Float:avg[MAX_TIMER_TYPES][MAX_MODULES],
		Float:avg_total,totaltime
	;
	strcpy(string,"[timer]");
	for(new i; i<MAX_TIMER_TYPES; i++)
	{
		// time calculation
		totaltime = 0;
		for(new j; j<TimerIndex[i]; j++)
		{
			avg[i][j] = floatdiv(TimerMeasure_Time[i][j],TimerMeasure_Count[i]);
			totaltime += TimerMeasure_Time[i][j];
			TimerMeasure_Time[i][j] = 0;
		}
		avg_total = floatdiv(totaltime,TimerMeasure_Count[i]);
		TimerMeasure_Count[i] = 0;
		//-----
		// performance analysis and print
		if(avg_total >= TIMER_MEASURE_THRESHOLD)
		{
			format(string,sizeof(string),"%s [%d:%.1fms]",string,i,avg_total);
			cnt++;
		}
		if(avg_total >= TIMER_MEASURE_THRESHOLD_DETAIL)
		{
			for(new j; j<TimerIndex[i]; j++)
				printf("[timer] [%d] %s: %.2f ms",i,TimerList[i][j],avg[i][j]);
		}
	}
	if(cnt > 0)
		print(string);
}