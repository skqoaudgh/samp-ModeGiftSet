/*
 *
 *		[For a better future, enthusiasm of Acu]
 *
 *			MySQL
 *			v1.0.0
 *
 *
 *		First Release:		2018/12/07
 *		Last Update:		2018/12/07
 *
 *
 *
 *		Coded by Acu 2006-2017 @ all rights reserved.
 *      Updated by Cada
 *			acu.pe.kr@gmail.com
 *			http://acu.pe.kr
 *
 *
 */
/*
  [Functions]
	SetMySQLConnectionInfo(ip[],id[],pw[],db[],port=3306)
	MySQL:GetMySQLHandle(type=1)
	CheckMySQLTables()

	mysql_string_escape(input[])
*/

//-----/ Pre-Processing /
#if defined _MDPWN_MySQL
	#endinput
#endif
#define _MDPWN_MySQL



//-----/ Includes /
#include <a_mysql>



//-----/ News /
new
	MySQL:MySQL_Handle_Main,
	MySQL_IP[32],
	MySQL_ID[32],
	MySQL_PW[32],
	MySQL_DB[32],
	MySQL_Port
;



//-----/ Forwards /
	//--/ Handlers /
forward AddHandler_MySQL();
forward InitHandler_MySQL();





//==========/ Callback Functions /==============================================
//-----/ AddHandler_MySQL /-----------------------------------------------------
public AddHandler_MySQL()
{
	AddHandler("MySQL",InitHandler,1);
}
//-----/ InitHandler_MySQL /----------------------------------------------------
public InitHandler_MySQL()
{
	// MySQL 기본 접속 정보 입력
	if(MySQL_Port == 0)
		SetMySQLConnectionInfo("127.0.0.1","root","23468917a!","Gift");
	//-----
	printf("---------------------------------");
	printf("[mysql] Connecting to DB server...");
	//-----
	// MySQL 접속 옵션 설정
	new MySQLOpt:options = mysql_init_options();
	mysql_set_option(options,MULTI_STATEMENTS,true);
	mysql_set_option(options,POOL_SIZE,3);
	mysql_set_option(options,SERVER_PORT,MySQL_Port);
	mysql_set_option(options,SSL_ENABLE,false);
	//-----
	// MySQL 접속
	MySQL_Handle_Main = mysql_connect(MySQL_IP,MySQL_ID,MySQL_PW,MySQL_DB);
	if(mysql_errno() != 0)
	{
		printf("[mysql] Connection failed. (Code: %d)",mysql_errno());
		printf("[mysql] Server will be closed in 3 seconds.");
		Wait(3000),Crash();
	} else {
		printf("[mysql] Connected!");
  		mysql_set_charset("euckr",MySQL_Handle_Main); // pawn 소스가 euc-kr이므로 맞춰준다. (pawn 컴파일러가 utf8 미지원)
		//------
		// 테이블 정보 확인
		CheckMySQLTables();
		//------
		// 모드 정보 출력
		printf("---------------------------------");
		printf("\n");
		printf("---------------------------------");
		printf(" %s %s",MODE_NAME,MODE_VERSION);
		printf("  Coded by Acu");
		printf("  acu.pe.kr@gmail.com");
		printf("---------------------------------\n");
	}
}
//-----/ OnQueryError /---------------------------------------------------------
public OnQueryError(errorid,const error[],const callback[],const query[],MySQL:handle)
{
	printf("[mysql] Error! %s(%d)",error,errorid);
	printf("[mysql]  Callback: '%s'",callback);
	printf("[mysql]  Query: '%s'",query);
}





//==========/ MySQL Functions /=================================================
//-----/ SetMySQLConnectionInfo /-----------------------------------------------
stock SetMySQLConnectionInfo(ip[],id[],pw[],db[],port=3306)
{
	strcpy(MySQL_IP,ip);
	strcpy(MySQL_ID,id);
	strcpy(MySQL_PW,pw);
	strcpy(MySQL_DB,db);
	MySQL_Port = port;
}
//-----/ GetMySQLHandle /-------------------------------------------------------
stock MySQL:GetMySQLHandle(type=1)
{
	switch(type)
	{
		case 1: return MySQL_Handle_Main;
	}
	return MYSQL_INVALID_HANDLE;
}
//-----/ CheckMySQLTables /-----------------------------------------------------
stock CheckMySQLTables()
{
	mysql_query(GetMySQLHandle(),"SHOW TABLES LIKE 'user_data'");
	if(cache_num_rows() == 0)
	{
		printf("[mysql] Tables not exist. Creating...");
		//-----
		mysql_query(GetMySQLHandle(),"\
			CREATE TABLE `user_data` (\
			`ID` smallint(6) NOT NULL AUTO_INCREMENT,\
			`Username` varchar(20) NOT NULL,\
			`Password` text NOT NULL,\
			`IP` int(11) NOT NULL COMMENT 'inet_aton/ntoa',\
			`CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,\
			`LastUpdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',\
			PRIMARY KEY (ID)\
			) ENGINE=InnoDB DEFAULT CHARSET=utf8;\
		");
		//-----
		printf("[mysql] Done.");
	}
}
//-----/ mysql_string_escape /--------------------------------------------------
stock mysql_string_escape(input[])
{
	new string[256];
	mysql_escape_string(input,string,sizeof(string));
	return string;
}
