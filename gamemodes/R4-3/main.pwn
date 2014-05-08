/*======================================================================*\
|| #################################################################### ||
|| # Project Next Generation Stunting - Release 4-3				      # ||
|| # ---------------------------------------------------------------- # ||
|| # Copyright ©2011-2013 Next Generation Stunting					  # ||
|| # Created by Mellnik | Pawn: 3.2.3664                              # ||
|| # ---------------------------------------------------------------- # ||
|| # http://ng-stunting.net | http://nextgenstunting.com			  # ||
|| #################################################################### ||
\*======================================================================*/

/* TODO LIST:
- no one left race sofort
- toy in textdraw
- anti speed
*/

#pragma dynamic 8000

#define IS_RELEASE_BUILD true

// -
// - Include
// -
#include <a_samp>   	// 0.3x R1-2
#include <YSI\y_iterate>// 27.02.2013
#include <sscanf2>      // 2.8.1
#include <streamer>     // 2.6.1 R84
#include <a_mysql_R16>  // R16
#include <dini>         // 1.6
#include <zcmd>
#include <ngs_maps>
#include <ngs_maps_2>
#include <ngs_map_vehicles>
#include <md-sort>
#include <unixtimetodate>

// -
// - MySQL
// -
#define SQL_HOST   						"127.0.0.1"
#if IS_RELEASE_BUILD == true
#define SQL_USER   						"a8fha80fch"
#define SQL_PASS   						"up4sVIe(dsn$3TqpL9.kUjJ"
#define SQL_DATA   						"samp"
#else
#define SQL_USER   						"devtest"
#define SQL_PASS   						"1996krebsgr"
#define SQL_DATA                        "dev_samp"
#endif
#define TABLE_HOUSE 					"houses"
#define TABLE_PROP  					"props"
#define TABLE_BLACKLIST 				"blacklist"
#define TABLE_ACCOUNT    				"accounts"
#define TABLE_BAN	    				"bans"
#define TABLE_VEHICLE    				"vehicles"
#define TABLE_GANG                      "gangs"
#define TABLE_RACE                      "race_records"
#define TABLE_TOYS                      "toys"

// -
// - DERBY
// -
#define DERBY_WIHLE_CAM_M1				-3948.2632, 951.8198, 78.4012
#define DERBY_WIHLE_CAM_M2          	2953.7620, 486.3492, 44.3681
#define DERBY_WIHLE_CAM_M3          	214.0030, 1637.5992, 369.9997
#define DERBY_WIHLE_CAM_M4              1509.0637, -1790.3726, 77.7660
#define DERBY_WIHLE_CAM_M5              -1923.6121, -859.1075, 86.4540
#define DERBY_WIHLE_CAM_M6              3749.7786, -69.5137, 34.7968
#define DERBY_WIHLE_CAM_M7              658.1914, 2875.1152, 39.6503
#define DERBY_CAMPOS_M1                 -4031.8118, 985.9628, 73.5483
#define DERBY_CAMPOS_M2                 2878.3738, 509.6317, 57.4209
#define DERBY_CAMPOS_M3                 146.2626, 1726.9897, 375.9173
#define DERBY_CAMPOS_M4                 1481.6500, -1713.3242, 58.8331
#define DERBY_CAMPOS_M5                 -1990.0116, -962.2039, 65.3364
#define DERBY_CAMPOS_M6                 3917.3489, -53.3306, 18.7947
#define DERBY_CAMPOS_M7                 658.1914, 2875.1152, 39.6503
#define DERBY_CAMLA_M1                  -4030.9736, 985.4224, 73.2184
#define DERBY_CAMLA_M2                  2879.3184, 509.2916, 56.9258
#define DERBY_CAMLA_M3                  147.0293, 1726.3483, 375.4769
#define DERBY_CAMLA_M4                  1481.6300, -1714.3220, 58.3079
#define DERBY_CAMLA_M5                  -1989.5079, -961.3351, 64.8612
#define DERBY_CAMLA_M6                  3916.3560, -53.4894, 18.5597
#define DERBY_CAMLA_M7                  657.7112, 2875.9885, 39.2752
#define DERBY_FALLOVER_M1     			(20)
#define DERBY_FALLOVER_M2               (1)
#define DERBY_FALLOVER_M3               (327)
#define DERBY_FALLOVER_M4               (27)
#define DERBY_FALLOVER_M5               (36)
#define DERBY_FALLOVER_M6               (1)
#define DERBY_FALLOVER_M7               (1)
#define MAX_DERBY_PLAYERS  				(20)
#define DERBY_WORLD                     (5050)
#define DERBY_TIME      				(180000)
#define DERBY_VOTING_TIME     			(20000)
#define DEFAULT_DERBY_TIME              (180)
#define DERBY_FALLOVER_CHECK_TIME   	(500)

// -
// - Enviroment
// -
#if IS_RELEASE_BUILD == true
#define HOSTNAME 						"     «(—[—|Next Generation Stunting 0.3x|—]—)»"
#else
#define HOSTNAME 						"«(—[—|Next Generation Stunting BETA BUILD|—]—)»"
#endif
#define NGS_SIGN1                       "NGS"
#define NGS_SIGN2                       "NEXT GENERATION STUNTING"
#if IS_RELEASE_BUILD == true
#define CURRENT_VERSION                 "Release 4-3"
#else
#define CURRENT_VERSION                 "Release 4-3 BETA BUILD"
#endif
#define FLOAT_INFINITY 					(Float:0x7F800000)
#define MAX_REPORTS 					(7)
#define MAX_GANG_NAME					(20)
#define MIN_GANG_NAME					(4)
#define GLOB_TDUPDATE_TIME   			(999)
#define house_mark                      "{FFFFFF}[{88EE88}House{FFFFFF}]"
#define business_mark                   "{FFFFFF}[{AAAAFF}Business{FFFFFF}]"
#define derby_sign                      "{FFFFFF}[{AAAAFF}DERBY{FFFFFF}]"
#define race_sign                       "{FFFFFF}[{AAAAFF}RACE{FFFFFF}]"
#define tdm_sign                        "{FFFFFF}[{AAAAFF}TDM{FFFFFF}]"
#define gungame_sign                    "{FFFFFF}[{AAAAFF}GUNGAME{FFFFFF}]"
#define fallout_sign                    "{FFFFFF}[{AAAAFF}FALLOUT{FFFFFF}]"
#define server_sign                     "{FFFFFF}[{6EF83C}SERVER{FFFFFF}]"
#define gang_sign                       "{FFFFFF}[{FFA000}GANG{FFFFFF}]"
#define NO_PERM_ENG                     "{D63034}Info: {F0F0F0}Insufficient permissions"
#define NO_PERM_GER                     "{D63034}Info: {F0F0F0}Unzureichende Berechtigungen"
#define NOT_AVAIL                       "{D63034}Info: {F0F0F0}You can´t use this command now! Use /exit to leave."
#define NOT_AVAIL_G                     "{D63034}Info: {F0F0F0}Du kannst diesen Befehl gerade nicht nutzen! Tippe /exit um zu verlassen."
#define er                              "{D63034}Info: {F0F0F0}"
#define dl                              "{F2F853}• {F0F0F0}"
#define RANDOM_TEXTDRAW_TEXT            (10000)
#define MAX_ADMIN_LEVEL         		(6)
#define MAX_WARNINGS 					(3)
#define MAX_FAIL_LOGINS 				(3)
#define ADMIN_SPEC_TYPE_NONE 			(0)
#define ADMIN_SPEC_TYPE_PLAYER 			(1)
#define ADMIN_SPEC_TYPE_VEHICLE 		(2)
#define ELEVATOR_SPEED      			(5.0)
#define DOORS_SPEED         			(4.0)
#define ELEVATOR_WAIT_TIME  			(5000)
#define X_DOOR_CLOSED       			(1786.627685)
#define X_DOOR_R_OPENED     			(1785.027685)
#define X_DOOR_L_OPENED     			(1788.227685)
#define GROUND_Z_COORD      			(14.511476)
#define ELEVATOR_OFFSET     			(0.059523)
#define ELEVATOR_STATE_IDLE     		(0)
#define ELEVATOR_STATE_WAITING  		(1)
#define ELEVATOR_STATE_MOVING   		(2)
#define INVALID_FLOOR           		(-1)

// -
// - TDM
// -
#define DEFAULT_BG_TIME                 (240)
#define BG_MAP1_WHILECAM                -512.8727, -121.8333, 97.8991
#define BG_MAP2_WHILECAM                623.2424,-2418.4194,9.4857
#define BG_MAP3_WHILECAM                -2156.0381, -233.5269, 51.2263
#define BG_MAP4_WHILECAM                738.9284, -2306.1187, 117.9879
#define BG_MAP5_WHILECAM                1757.4000, -3023.5654, 26.0215
#define BG_MAP1_CAMPOS                  -409.0511, -39.5656, 126.9736
#define BG_MAP2_CAMPOS                  620.6779, -2421.5466, 17.5673
#define BG_MAP3_CAMPOS                  -2134.0254, -191.9131, 57.6586
#define BG_MAP4_CAMPOS                  726.9686, -2300.6931, 118.7531
#define BG_MAP5_CAMPOS                  1784.0186, -2997.1704, 30.8122
#define BG_MAP1_CAMLA                   -409.8650, -40.1510, 126.3882
#define BG_MAP2_CAMLA                   618.8812,-2419.9033,15.4312
#define BG_MAP3_CAMLA                   -2134.6445, -192.7050, 57.1735
#define BG_MAP4_CAMLA                   726.3855, -2301.5107, 118.2781
#define BG_MAP5_CAMLA                   1784.7314, -2997.8691, 30.3122
#define BG_WORLD                        (5048)
#define BG_TEAM1                        (1)
#define BG_TEAM2                        (2)
#define BG_VOTING                       (0)
#define BG_MAP1                         (1)
#define BG_MAP2                         (2)
#define BG_MAP3                         (3)
#define BG_MAP4                         (4)
#define BG_MAP5                         (5)
#define BG_TIME                         (240000)
#define BG_VOTING_TIME                  (20000)

// -
// - Fallout
// -
#define DEFAULT_FALLOUT_TIME            (240)
#define FALLOUT_WORLD                   (121212)

// -
// - Deathmatch
// -
#define DM_WORLD                        (100000)
#define DM_1                            (1)
#define DM_2                            (2)
#define DM_3                            (3)
#define DM_4                            (4)

// -
// - Houses
// -
#define MAX_HOUSES 						(500)
#define MAX_HOUSES_PER_PLAYER 			(1)

// -
// - Propertys
// -
#define MAX_PROPS                       (500)
#define MAX_PROPS_PER_PLAYER 			(1)

// -
// - ELSE
// -
#define REAC_TIME              			(800000)
#define MAX_BANKS    			 		20
#define MAX_AMMUNATIONS    		 		20
#define MAX_BURGERSHOTS    		 		20
#define MAX_CLUCKINBELLS    	 		20
#define MAX_PIZZASTACKS 		 		20
#define MAX_TFS                         20
#define MAX_STORES 						(MAX_BANKS + MAX_AMMUNATIONS + MAX_BURGERSHOTS + MAX_CLUCKINBELLS + MAX_PIZZASTACKS + MAX_TFS)
#define MAX_RACE_CHECKPOINTS_EACH_RACE 	(120)
#define MAX_RACES 						(250)
#define COUNT_DOWN_TILL_RACE_START 		(21)
#define MAX_RACE_TIME 					(300)
#define RACE_CHECKPOINT_SIZE 			(12.0)
#define RACE_MAX_PLAYERS 				(12)
#define OFFSET_VALUE 					(10000)
#define Key(%0) 						((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0))
#define MINIGUN_WORLD                   (68565)
#define SNIPER_WORLD                    (57412)
#define SERVERMSGS_TIME                 (900000)

#define function:%1(%2) \
			forward public %1(%2); \
			public %1(%2)

#define ConvertTime(%0,%1,%2,%3,%4) \
	new \
	    Float:%0 = floatdiv(%1, 60000) \
	;\
	%2 = floatround(%0, floatround_tozero); \
	%3 = floatround(floatmul(%0 - %2, 60), floatround_tozero); \
	%4 = floatround(floatmul(floatmul(%0 - %2, 60) - %3, 1000), floatround_tozero)

// -
// - Colors
// -
#define SEMI_TRANS                      (0x0A0A0A7F)
#define PURPLE                  		(0x7800FF85)
#define GREEN 							(0x87FF00FF)
#define RED        						(0xD63034FF)
#define ORANGE 							(0xFF96008B)
#define BLUE 							(0x3793FAFF)
#define YELLOW 							(0xF2F853FF)
#define WHITE 							(0xFEFEFEFF)
#define PINK 							(0xFF00EB80)
#define LILA 							(0x7800FF85)
#define GREY 							(0x8C8C8CFF)
#define BROWN 							(0xA52A2AAA)
#define BLACK       					(0x0A0A0AFF)
#define ADMIN       					(0xF50000FF)
#define lila                            "{AAAAFF}"
#define vlila                           "{4764EF}"
#define lgreen                          "{88EE88}"
#define vgreen                          "{6EF83C}"
#define purple                          "{7800FF}"
#define green                           "{0BDDC4}"
#define yellow                          "{F2F853}"
#define white                           "{F0F0F0}"
#define blue							"{0087FF}"
#define orange                          "{FFA000}"
#define grey                            "{969696}"
#define red                             "{D63034}"

// -
// - Player
// -
#define COOLDOWN_CHAT                   (5500)
#define COOLDOWN_CMD_BUY                (90000)
#define COOLDOWN_CMD_PBUY               (90000)
#define COOLDOWN_CMD_LOCK               (5000)
#define COOLDOWN_CMD_GOTOMYHOUSE        (5000)
#define COOLDOWN_CMD_GOTOMYPROP         (5000)
#define COOLDOWN_CMD_REPORT             (30000)
#define COOLDOWN_CMD_SELL               (90000)
#define COOLDOWN_CMD_PSELL              (90000)
#define COOLDOWN_CMD_CHANGEPASS         (100000)
#define COOLDOWN_CMD_PM                 (3000)
#define COOLDOWN_CMD_HITMAN             (60000)
#define COOLDOWN_CMD_GINVITE            (200000)
#define COOLDOWN_CMD_GKICK              (8000)
#define COOLDOWN_CMD_GCREATE            (5000)
#define COOLDOWN_DEATH                  (3000)
#define COOLDOWN_CMD                  	(5000)


// ===
// Enums
// ===

// -
// - DIALOGIDS
// -
enum (+= 100)
{
    REGISTER_DIALOG,
    LOGIN_DIALOG,
    TELE_DIALOG,
    WEAPON_DIALOG,
    STREAM_DIALOG,
    LANG_DIALOG,
    ACHS_DIALOG,
    LIFT_DIALOG,
    BANK_DIALOG,
    BAN_DIALOG,
    VEHICLE_DIALOG,
    TOY_DIALOG,
    CARBUY_DIALOG,
    VEHICLEPLATE_DIALOG,
    VMENU_DIALOG,
    PLATE_DIALOG,
    NEON_DIALOG,
    GMENU_DIALOG,
    BGVOTING_DIALOG,
    GANGMEM_DIALOG,
    GANGINFO_DIALOG,
    DERBY_VOTING_DIALOG,
    HELP_DIALOG,
    ANIMS_DIALOG,
    STATS_DIALOG,
    WANTEDS_DIALOG,
    TOPLIST_DIALOG,
    ADMINS_DIALOG,
    CMDS_DIALOG,
    NETSTATS_DIALOG,
    DIALOG_RACE_RACETYPE,
    DIALOG_RACE_RACEVW,
    DIALOG_RACE_RACEVWERR,
    DIALOG_RACE_RACEVEH,
    DIALOG_RACE_RACEVEHERR,
    DIALOG_RACE_RACESTARTPOS,
    DIALOG_RACE_CHECKPOINTS,
    DIALOG_RACE_RACERDY,
    MOST_DEATHS_DIALOG,
	MOST_KILLS_DIALOG,
	FIRST_SPAWN_DIALOG,
	MOST_HRS_DIALOG,
	RICHLIST_DIALOG,
	SCORE_DIALOG
}

// -
// - MySQL
// -
enum
{
	THREAD_ACCOUNT_EXIST,
  	THREAD_IS_BANNED,
  	THREAD_CHECK_IP,
  	THREAD_CREATE_ACCOUNT,
  	THREAD_LOADPLAYER,
  	THREAD_CHECK_PLAYER_PASSWD,
  	THREAD_BUY_VEHICLE,
  	THREAD_LOADPLAYERVEH,
  	THREAD_GANG_EXIST,
  	THREAD_CREATE_GANG,
  	THREAD_CHECK_IF_TOY_EXIST,
  	THREAD_LOAD_TOYS,
  	THREAD_DELETE_VEH,
  	THREAD_LOAD_BAN_STAT,
  	THREAD_FETCH_GANG_MEMBER_NAMES,
  	THREAD_FETCH_GANG_INFO,
  	THREAD_KICK_FROM_GANG,
  	THREAD_KICK_FROM_GANG_2,
  	THREAD_RACE_TOPLIST,
  	THREAD_RACE_FINISH,
  	THREAD_RACE_LATEST,
	THREAD_GOTO_MY_HOUSE,
	THREAD_GOTO_MY_PROP
}

// -
// - player enum
// -
enum e_player_data
{
	bool:IsDead,
	bool:Frozen,
	bool:AllowSpawn,
    bool:Logged,
 	bool:onduty,
	bool:Muted,
 	bool:SpeedBoost,
 	bool:SuperJump,
	bool:AOnline,
 	bool:gInvite,
 	bool:FalloutLost,
	bool:SavedPos,
	bool:bGoTo,
	bool:bHasSpawn,
	ExitType,
	GlobalID,
	Level,
	Kills,
	Deaths,
	Money,
	Score,
	hours,
	mins,
	secs,
	Lang,
	DerbyWins,
	RaceWins,
	FalloutWins,
	GungameWins,
	BGWins,
	PayDay,
	tPayDay,
	tInfo,
	tPlayer,
  	Houses,
	Props,
	PropEarnings,
	tickLastReport,
	tickLastHitman,
	tickLastGInvite,
	tickLastGKick,
	tickLastGCreate,
	tickLastLocked,
  	tickLastBuy,
  	tickLastPBuy,
  	tickLastSell,
  	tickLastPSell,
  	tickLastPW,
  	tickLastGoToMyHouse,
  	tickLastGoToMyProp,
  	tickLastChat,
  	tickPlayerUpdate,
  	tickLastPM,
  	BuyAbleVeh,
	Reaction,
	Bank,
	TotalTime,
	ConnectTime,
	Warnings,
	Wanteds,
	HitmanHit,
	Vehicle,
	PV_Vehicle,
	Text3D:PV_3DLabel,
	ChatWrote,
	FailLogin,
	MuteTimer,
 	IsInGang,
 	GangID,
	Text3D:GangLabel,
	GangKickMem[25],
 	GangName[21],
 	GangTag[5],
 	RegDate,
	Float:sX,
	Float:sY,
	Float:sZ,
	Float:sA,
	SpecID,
	SpecType,
	Float:SpecX,
	Float:SpecY,
	Float:SpecZ,
	Float:SpecA,
	Float:CSpawnX,
	Float:CSpawnY,
	Float:CSpawnZ,
	Float:CSpawnA,
	tTimerHP,
	toy_selected,
	iCoolDownCommand,
	iCoolDownDeath
}

// -
// - top stats
// -
enum e_top_wanteds
{
	E_playerid,
	E_wanteds
}

enum e_top_richlist
{
	E_playerid,
	E_money
}

enum e_top_score
{
	E_playerid,
	E_pscore
}

enum e_top_kills
{
	E_playerid,
	E_kills
}

enum e_top_deaths
{
	E_playerid,
	E_deaths
}

enum e_top_hrs
{
	E_playerid,
	E_hrs
}

// -
// - player toy data
// -
enum e_toy_data
{
	toy_model,
	toy_bone,
	Float:toy_x,
	Float:toy_y,
	Float:toy_z,
	Float:toy_rx,
	Float:toy_ry,
	Float:toy_rz,
	Float:toy_sx,
	Float:toy_sy,
	Float:toy_sz
}

// -
// - player vehicle enum
// -
enum e_player_veh_data
{
	Model,
	Price,
	PaintJob,
	Color1,
	Color2,
	Plate[13],
	Mod1,
	Mod2,
	Mod3,
	Mod4,
	Mod5,
	Mod6,
	Mod7,
	Mod8,
	Mod9,
	Mod10,
	Mod11,
	Mod12,
	Mod13,
	Mod14,
	Mod15,
	Mod16,
	Mod17,
	Neon1,
	Neon2
}

// -
// - house enum
// -
enum e_house_data
{
	iID,
	Owner[25],
	Float:E_x,
	Float:E_y,
	Float:E_z,
	interior,
	price,
	E_score,
	Text3D:label,
	sold,
	locked,
	pickid,
	iconid,
	date
}

// -
// - property enum
// -
enum e_property_data
{
	iID,
	Owner[25],
	Float:E_x,
	Float:E_y,
	Float:E_z,
	price,
	E_score,
	Text3D:label,
	sold,
	earnings,
	pickid,
	iconid,
	date
}

// -
// - house type enum
// -
enum e_house_type
{
	interior,
	Float:house_x,
	Float:house_y,
	Float:house_z,
	intname[32]
}

// -
// - derby data
// -
enum e_derby_map1_data
{
	Float:m1sX,
	Float:m1sY,
	Float:m1sZ,
	Float:m1sA,
	bool:m1sUsed
}
enum e_derby_map2_data
{
	Float:m2sX,
	Float:m2sY,
	Float:m2sZ,
	Float:m2sA,
	bool:m2sUsed
}
enum e_derby_map3_data
{
	Float:m3sX,
	Float:m3sY,
	Float:m3sZ,
	Float:m3sA,
	bool:m3sUsed
}
enum e_derby_map4_data
{
	Float:m4sX,
	Float:m4sY,
	Float:m4sZ,
	Float:m4sA,
	bool:m4sUsed
}
enum e_derby_map5_data
{
	Float:m5sX,
	Float:m5sY,
	Float:m5sZ,
	Float:m5sA,
	bool:m5sUsed
}
enum e_derby_map6_data
{
	Float:m6sX,
	Float:m6sY,
	Float:m6sZ,
	Float:m6sA,
	bool:m6sUsed
}

// -
// - fallout data
// -
enum e_fallout_data
{
	I_iShaketimer[101],
	I_iNumberout[101],
	I_iObject[101],
	I_iShake[101],
	I_iTimer[2],
	I_iCount,
	I_iJoin,
	I_tLoseGame
}
enum
{
	e_Fallout_Inactive,
	e_Fallout_Startup,
	e_Fallout_Running,
	e_Fallout_Finish
}

// -
// - gTeam data
// -
enum
{
	NORMAL,
	DERBY,
 	RACE,
	gBG_TEAM1,
	gBG_TEAM2,
	MINIGUN,
	SNIPER,
	BG,
	DM,
	HOUSE,
	BUYCAR,
	gBG_VOTING,
	GUNGAME,
	FALLOUT,
	BUILDRACE,
	STORE
}

// -
// - GunGame data
// -
enum e_gungame_data
{
	level,
	bool:dead,
	bool:pw
}
enum e_GunGame
{
	GG_iPlayer,
	GG_iLevel
}

// -
// - race data
// -
enum e_race_position
{
	RP_iPlayer,
	RP_iValue
}
enum
{
	RaceStatus_Inactive,
	RaceStatus_StandBy,
	RaceStatus_StartUp,
	RaceStatus_Active
}


// ===
// global
// ===

new const ServerMSGS[8][] =
{
	"» Visit our site: ng-stunting.net",
	"» Join Minigames for money and score - /help",
	"» Join Minigames to earn money and score - /help",
	"» If you have suggestions, post them in our forum! (forum.ng-stunting.net)",
	"» Use /report to report a player to the admins",
	"» Add NGS to your favlist! samp.ng-stunting.net:7777",
	"» NG-Stunting opened on 11th January 2013",
	"» User Control Panel is available under ng-stunting.net"
};

new Derby_Map1Spawns[MAX_DERBY_PLAYERS][e_derby_map1_data] =
{
	{-3957.3640, 969.7915, 65.6281, 235.3673, false},
	{-3942.8943, 938.6829, 65.6085, 359.7384, false},
	{-3905.7332, 922.6584, 52.5285, 268.2442, false},
	{-3878.5010, 922.4542, 52.5285, 91.23260, false},
	{-3862.9128, 927.0121, 52.5081, 323.7048, false},
	{-3846.5625, 931.5337, 52.5081, 36.39880, false},
	{-3847.0959, 946.5208, 52.5281, 71.17910, false},
	{-3862.3210, 960.0160, 52.5281, 244.1173, false},
	{-3845.7188, 989.4063, 52.5285, 272.0277, false},
	{-3886.8899, 989.3755, 52.5285, 89.35270, false},
	{-3890.9119, 969.2299, 52.5285, 177.0868, false},
	{-3893.9905, 949.9914, 52.5285, 131.3398, false},
	{-3912.6133, 948.6409, 52.5285, 91.54600, false},
	{-3934.2073, 961.6917, 52.5085, 1.931900, false},
	{-3929.2332, 975.3268, 40.8805, 268.2678, false},
	{-3941.8633, 957.9515, 36.3281, 39.84560, false},
	{-3974.4358, 959.5692, 36.3285, 118.8063, false},
	{-4013.4832, 925.3674, 52.5285, 356.6052, false},
	{-4011.8496, 954.6926, 52.5285, 268.5577, false},
	{-3993.0066, 978.3261, 52.5085, 107.5262, false}
};

new Derby_Map2Spawns[MAX_DERBY_PLAYERS][e_derby_map2_data] =
{
	{3067.4111, 556.9147, 40.7377, 147.9308, false},
	{3050.3350, 531.4977, 40.7381, 147.9308, false},
	{3047.3203, 557.5518, 40.6794, 144.7741, false},
	{3073.9629, 533.7264, 40.9304, 326.5092, false},
	{3030.9526, 501.8501, 40.8286, 145.4242, false},
	{2982.2078, 465.6787, 10.7985, 89.65030, false},
	{2951.7710, 465.3126, 10.7985, 89.65030, false},
	{2943.5374, 454.8485, 10.7985, 181.7712, false},
	{2928.1584, 445.1630, 13.0385, 145.1108, false},
	{2916.7087, 429.5787, 13.0385, 150.1242, false},
	{2930.4187, 408.3071, 17.5582, 234.4117, false},
	{3011.3757, 448.3677, 16.2772, 265.1187, false},
	{3032.5698, 434.8050, 21.3385, 359.4096, false},
	{2991.1526, 439.6288, 39.2401, 358.7829, false},
	{3036.7063, 510.8661, 4.36850, 177.0712, false},
	{3036.4888, 484.0915, 4.36850, 177.0712, false},
	{3009.2834, 478.9747, 4.38850, 90.27710, false},
	{2952.6309, 501.4793, 22.0385, 90.27710, false},
	{2920.8032, 516.9267, 22.0285, 355.9628, false},
	{2946.0103, 526.7934, 22.0185, 86.80700, false}
};

new Derby_Map3Spawns[MAX_DERBY_PLAYERS][e_derby_map3_data] =
{
	{246.3290, 1714.4462, 352.5285, 178.5039, false},
	{222.8298, 1714.9265, 352.5285, 90.14300, false},
	{185.5551, 1714.3876, 343.5285, 181.9506, false},
	{186.1509, 1696.8904, 343.5285, 181.9506, false},
	{186.4787, 1669.7019, 343.5285, 7.445600, false},
	{208.2734, 1657.8409, 352.5285, 178.1905, false},
	{194.5793, 1636.9927, 354.3859, 89.51640, false},
	{186.6167, 1663.1619, 343.5285, 356.8490, false},
	{172.9417, 1637.2440, 357.0097, 180.6972, false},
	{173.0500, 1618.4937, 357.0097, 279.0848, false},
	{210.4522, 1618.9490, 361.8463, 83.32920, false},
	{241.8557, 1617.7828, 363.6497, 300.1908, false},
	{246.1263, 1631.1395, 363.6497, 357.5313, false},
	{246.6167, 1674.6024, 352.5485, 357.5313, false},
	{233.8339, 1689.3091, 352.5285, 89.96550, false},
	{208.1478, 1680.4999, 352.5085, 176.8159, false},
	{226.0559, 1666.7491, 355.5157, 178.3825, false},
	{226.4928, 1635.9159, 361.0836, 357.6671, false},
	{229.3643, 1715.0703, 352.5285, 90.70460, false},
	{170.1862, 1689.3947, 352.5285, 273.0662, false}
};

new Derby_Map4Spawns[MAX_DERBY_PLAYERS][e_derby_map4_data] =
{
	{1487.6512, -1755.2731, 33.4297, 262.8351, false},
	{1506.7178, -1760.9492, 33.4297, 268.7939, false},
	{1511.1926, -1771.6134, 33.4297, 267.3918, false},
	{1532.4257, -1764.9232, 33.4297, 179.4124, false},
	{1542.7130, -1779.0228, 33.4297, 179.0619, false},
	{1532.5718, -1792.3685, 33.4297, 169.9484, false},
	{1519.6860, -1817.5404, 33.4243, 87.9278, false},
	{1489.2483, -1816.4391, 33.4243, 87.9278, false},
	{1470.1770, -1812.2526, 33.4243, 87.9278, false},
	{1456.9327, -1818.6555, 33.4243, 87.9278, false},
	{1441.1545, -1811.5428, 33.4243, 67.5979, false},
	{1425.7040, -1812.7531, 33.4297, 1.3505, false},
	{1418.1497, -1796.1854, 33.4297, 353.2886, false},
	{1429.6094, -1786.4208, 33.4297, 347.6803, false},
	{1425.8998, -1764.4401, 33.4297, 275.1236, false},
	{1444.4971, -1767.0941, 33.4297, 275.1236, false},
	{1459.3033, -1758.2831, 33.4297, 288.0927, false},
	{1478.1750, -1755.6753, 33.4297, 275.4741, false},
	{1457.6566, -1805.7548, 33.4243, 88.9793, false},
	{1502.2307, -1805.2515, 33.4243, 86.8763, false}
};

new Derby_Map5Spawns[MAX_DERBY_PLAYERS][e_derby_map5_data] =
{
	{-1951.3622, -924.9825, 41.5739, 0.4935, false},
	{-1951.3545, -907.4986, 41.3420, 0.8532, false},
	{-1951.3573, -861.6216, 41.4833, 0.8344, false},
	{-1950.2805, -823.5054, 41.1760, 1.0857, false},
	{-1950.8802, -802.3750, 41.2701, 2.0072, false},
	{-1950.5498, -782.8512, 41.2198, 358.4045, false},
	{-1950.5662, -770.9384, 41.2223, 2.5244, false},
	{-1950.4987, -752.6329, 41.2115, 359.5575, false},
	{-1961.9818, -754.6239, 40.4814, 180.7448, false},
	{-1961.7175, -763.6168, 40.5629, 182.1786, false},
	{-1968.2728, -768.7271, 39.3264, 90.9983, false},
	{-1960.7704, -791.6741, 41.5325, 177.1483, false},
	{-1960.9248, -820.2233, 40.7711, 179.9023, false},
	{-1968.1675, -827.4709, 39.3269, 90.9073, false},
	{-1960.7595, -858.5953, 41.5654, 179.5008, false},
	{-1960.5577, -878.2072, 40.8663, 182.2004, false},
	{-1960.8175, -897.6044, 40.7994, 179.1699, false},
	{-1968.1946, -902.1904, 39.3299, 83.8091, false},
	{-1959.5391, -928.6652, 41.3451, 177.8511, false},
	{-1960.3411, -951.4661, 40.9212, 180.5387, false}
};

new Derby_Map6Spawns[MAX_DERBY_PLAYERS][e_derby_map6_data] =
{
	{3873.0828,-75.0219,2.3334,84.3515, false},
	{3872.4290,-55.6568,2.3383,112.0350, false},
	{3867.7134,-42.0787,2.3380,138.8138, false},
	{3853.3616,-29.6537,2.3480,154.4953, false},
	{3843.4478,-21.2739,2.3483,145.6348, false},
	{3825.0579,-17.4116,2.3482,188.3425, false},
	{3798.9045,-36.7079,2.3488,239.5291, false},
	{3782.3035,-51.6286,2.3867,257.4987, false},
	{3782.2983,-66.7195,2.3882,267.7532, false},
	{3782.0959,-91.3813,2.3687,296.6480, false},
	{3794.5774,-106.9509,2.3785,222.5016, false},
	{3811.3721,-116.6408,2.3781,249.0273, false},
	{3825.9817,-130.9541,2.3697,1.4488, false},
	{3844.4924,-124.6570,2.3294,29.5070, false},
	{3856.8303,-123.1470,2.3281,42.7229, false},
	{3875.8503,-97.7704,2.3264,61.1305, false},
	{3880.7490,-84.9508,2.3166,39.3552, false},
	{3850.8860,-74.6005,2.3381,77.7126, false},
	{3822.9360,-91.4808,2.3782,123.4223, false},
	{3812.7500,-73.1342,2.3881,0.9317, false}
};

new const HouseIntTypes[][e_house_type] =
{
    {1, 244.411987,  305.032989,   999.148437, "Barrack"}, //0 			// 7, klein billig aber gut
    {2, 225.756989,  1240.000000,  1082.149902, "Standard"}, //1 				// 1, billig haus
    {1, 223.043991,  1289.259888,  1082.199951, "Advanced Standard"}, //2			// 2, klein aber fein
    {2, 2454.717041, -1700.871582, 1013.515197, "Ryders House"}, //3				// 13, normal wohnung pic 443
    {8, 2807.619873, -1171.899902, 1025.570312, "Bunker House"}, //4			// 9, muss raus // jetzt ist Colonel Furhberger's drinne
    {4, 302.180999,  300.722991,   999.148437, "Underground"}, 	//5			// 10, nette bude
    {2, 271.884979,  306.631988,   999.148437, "Nice Small Hotel Room"},//6 			// 8, nice one /white
	{3, 2496.049804, -1695.238159, 1014.742187, "CJs House"}, //7			// 4, muss raus exec // jetzt ist CJ drinne
	{3, 235.508994,  1189.169897,  1080.339966, "Luxus House"}, //8			// 0,  schönes haus mit roten boden pic 429
	{2, 1204.809936, -11.586799,   1000.921875, "Strip Club"}, //9			// 6, mus raus exec // jetzt ist strip club drinne
	{15,2215.454833, -1147.475585, 1025.796875, "Entire Motel"}, //10					// 12, muss raus // jetzt ist jeff motel drinne
	{12,2324.419921, -1145.568359, 1050.710083, "Small Villa"}, 	//11			// 11, muss raus // jetzt ist small villa drinne
	{7, 225.630997,  1022.479980,  1084.069946, "Big Villa"}, //12			// 3, big villa
	{5, 1267.663208, -781.323242,  1091.906250, "Madd Doggs Mansion"} 	//13		// 5, muss raus exec // jetzt ist maddog drinne
};

new Iterator:RaceJoins<12>,
	g_asIP[MAX_PLAYERS][16],
	ServerTime[2],
    PlayerToys[MAX_PLAYERS][5][e_toy_data],
	StartTime,
  	Info[e_fallout_data],
  	g_FalloutStatus,
  	loginsoundlink[255],
 	GunGame_Player[MAX_PLAYERS][e_gungame_data],
  	PlayerText3D:DerbyVehLabel[MAX_PLAYERS],
  	bool:LabelActive[MAX_PLAYERS],
  	bool:PlayerHit[MAX_PLAYERS],
 	Float:OldHealth[MAX_PLAYERS],
  	Float:OldDamage[MAX_PLAYERS],
 	Float:CDamage[MAX_PLAYERS],
  	DerbyMapVotes[6],
  	CurrentDerbyMap,
  	BGGameTime = DEFAULT_BG_TIME,
  	FalloutGameTime = DEFAULT_FALLOUT_TIME,
  	DerbyGameTime = DEFAULT_DERBY_TIME,
  	tDerbyTimer = -1,
  	tDerbyVoting = -1,
  	tDerbyFallOver = -1,
 	tGlobTDUpdate = -1,
  	pDerbyCar[MAX_PLAYERS],
  	bool:bDerbyAFK[MAX_PLAYERS],
  	DerbyPlayers = 0,
  	bool:IsDerbyRunning,
  	bool:DerbyWinner[MAX_PLAYERS],
  	Reports[MAX_REPORTS][144],
  	tBGTimer = -1,
  	tBGVoting = -1,
  	BGMapVotes[5],
  	BGTeam1Players,
  	BGTeam2Players,
	BGTeam1Kills,
  	BGTeam2Kills,
  	CurrentBGMap,
  	GunGamePlayers,
  	dm1pickup,
  	dm2pickup,
  	PreviewTmpVeh[MAX_PLAYERS],
  	gTeam[MAX_PLAYERS],
  	vehiclebuy,
 	aussenrein,
 	innenraus,
  	g_SQL_handle,
  	houseid,
  	propid,
  	Text3D:Label_Elevator,
  	Text3D:Label_Floors[21],
  	PlayerText:TXTWanteds[MAX_PLAYERS],
  	PlayerText:TXTGunGameInfo[MAX_PLAYERS],
  	PlayerText:TXTPlayerInfo[MAX_PLAYERS],
  	Text:NGSLOGO[3],
  	Text:TXTGunGameSign,
  	Text:TXTGunGameBox,
  	Text:TXTFooterP1,
  	Text:TXTFooterP2,
  	Text:TXTYellowStripP1,
  	Text:TXTYellowStripP2,
  	Text:TXTBlackScreenP1,
  	Text:TXTBlackScreenP2,
  	Text:TXTLogonStars,
  	Text:TXTLoading,
  	Text:TXTInfo,
  	Text:TXTLocalSignP1,
  	Text:TXTLocalSignP2,
  	Text:TXTKeyInfo,
  	Text:TXTRaceBox,
  	Text:TXTRaceSign,
  	Text:TXTDerbyBox,
  	Text:TXTDerbyBoxSign,
  	Text:TXTDerbyInfo,
  	Text:TXTBGSign,
  	Text:TXTBGBox,
 	Text:TXTBGInfo,
 	Text:TXTFalloutSign,
	Text:TXTFalloutBox,
	Text:TXTFalloutInfo,
	Text:TXTToyBox,
	Text:TXTToyInfo,
  	BankPickOut[MAX_BANKS],
  	BankPickInt[MAX_BANKS],
  	BankPickMenu[MAX_BANKS],
  	AmmunationPickOut[MAX_AMMUNATIONS],
  	AmmunationPickInt[MAX_AMMUNATIONS],
  	BurgerPickOut[MAX_BURGERSHOTS],
  	BurgerPickInt[MAX_BURGERSHOTS],
  	CluckinBellPickOut[MAX_CLUCKINBELLS],
  	CluckinBellPickInt[MAX_CLUCKINBELLS],
  	PizzaPickOut[MAX_PIZZASTACKS],
  	PizzaPickInt[MAX_PIZZASTACKS],
  	TFSPickOut[MAX_TFS],
  	TFSPickInt[MAX_TFS],
  	Text3D:StoreLabel[MAX_STORES],
  	BankMIcon[MAX_BANKS],
  	CluckinBellMIcon[MAX_CLUCKINBELLS],
  	BurgerMIcon[MAX_BURGERSHOTS],
  	AmmunationMIcon[MAX_AMMUNATIONS],
  	PizzaMIcon[MAX_PIZZASTACKS],
  	TFSMIcon[MAX_TFS],
  	bool:ReactionOn,
  	tRandomTXTInfo,
  	Text3D:AdminDutyLabel[MAX_PLAYERS],
  	AdminLC,
  	AdminLC2,
  	gLastMap[MAX_PLAYERS],
  	PlayerInfo[MAX_PLAYERS][e_player_data],
  	PlayerInfoVeh[MAX_PLAYERS][e_player_veh_data],
  	HouseInfo[MAX_HOUSES][e_house_data],
  	PropInfo[MAX_PROPS][e_property_data],
  	pick_chainsaw,
  	pick_life[13],
  	Obj_Elevator,
  	Obj_ElevatorDoors[2],
  	Obj_FloorDoors[21][2],
  	ElevatorState,
  	ElevatorFloor,
  	ElevatorQueue[21],
  	FloorRequestedBy[21],
  	ElevatorBoostTimer,
  	bool:GlobalMain = false,
  	xChars[16] = "",
  	tReactionTimer = -1,
	xCash,
  	xScore,
  	bool:xTestBusy,
  	CurrentFalloutPlayers = 0,
  	CurrentDerbyPlayers = 0,
	BuildRace,
	BuildRaceType,
	BuildVehicle = -1,
	BuildModeVID,
	BuildVirtualWorld,
	BuildName[30],
	bool:BuildTakeVehPos,
	BuildVehPosCount,
	bool:BuildTakeCheckpoints,
	BuildCheckPointCount,
	RaceName[30],
	RaceVehicle,
	RaceType,
	RaceVirtualWorld,
	TotalRaceCP,
	Float:RaceVehCoords[RACE_MAX_PLAYERS][4],
	Float:CPCoords[MAX_RACE_CHECKPOINTS_EACH_RACE][4],
	PlayerRaceVehicle[MAX_PLAYERS],
	tRaceCount = -1,
	tRacePosition = -1,
	RaceCountAmount,
	RaceTick,
	CPProgess[MAX_PLAYERS],
	rPosition,
	RaceFinishCount = 0,
	RaceJoinCount = 0,
	RaceSpawnCount,
	trCounter = -1,
	iRaceEnd,
	RaceTime,
	PlayerText:RaceInfo[MAX_PLAYERS],
	RacePosition[MAX_PLAYERS],
	RaceNames[MAX_RACES][128],
 	TotalRaces,
 	RaceStatus;

new Float:FloorZOffsets[21] =
{
    0.0,
    8.5479,
    13.99945,
    19.45100,
    24.90255,
    30.35410,
    35.80565,
    41.25720,
    46.70875,
    52.16030,
    57.61185,
    63.06340,
    68.51495,
    73.96650,
    79.41805,
    84.86960,
    90.32115,
    95.77270,
    101.22425,
    106.67580,
    112.12735
};

new const FloorNames[21][] =
{
	"Ground Floor",
	"First Floor",
	"Second Floor",
	"Third Floor",
	"Fourth Floor",
	"Fifth Floor",
	"Sixth Floor",
	"Seventh Floor",
	"Eighth Floor",
	"Ninth Floor",
	"Tenth Floor",
	"Eleventh Floor",
	"Twelfth Floor",
	"Thirteenth Floor",
	"Fourteenth Floor",
	"Fifteenth Floor",
	"Sixteenth Floor",
	"Seventeenth Floor",
	"Eighteenth Floor",
	"Admin Headquarter O.o",
	"Penthouse (not really)"
};

new const xCharacters[][] =
{
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
	"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
	"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
    "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
};

new GunGame_Weapons[] =
{
	23,	22, 27, 26, 29, 32, 30, 31, 38, 33, 34, 35, 36, 24
};

new Float:Minigun_Spawns[11][4] =
{
	{38.1505, 1564.5778, 12.7500, 132.2755},
	{8.7437, 1549.5354, 12.7560, 55.1620},
	{-33.0755, 1519.6864, 12.7560, 287.5538},
	{-38.9135, 1488.4835, 12.7500, 315.2241},
	{-16.4189, 1478.1693, 12.7500, 307.5128},
	{4.4626, 1506.1968, 16.5952, 347.8221},
	{28.7336, 1517.8481, 12.7560, 121.7190},
	{9.5176, 1560.8956, 12.7500, 217.7807},
	{16.0684, 1552.2834, 28.2681, 151.2032},
	{-4.4292, 1508.5903, 20.0397, 338.7700},
	{-3.7889, 1534.5502, 30.8132, 241.6056}
};
new Float:Sniper_Spawns[14][4] =
{
	{-1528.3020, -330.2366, 267.8116, 182.4561},
	{-1503.6364, -340.5645, 265.9578, 205.9406},
	{-1496.8945, -396.1531, 265.9578, 15.2601},
	{-1526.2155, -444.1110, 265.9578, 5.7962},
	{-1545.0111, -405.7469, 265.9578, 270.0850},
	{-1550.2539, -390.3828, 273.7288, 91.6521},
	{-1607.9478, -392.2644, 267.1663, 74.1264},
	{-1644.1897, -394.3685, 273.4054, 269.7141},
	{-1613.9907, -381.9904, 273.4054, 3.3222},
	{-1619.4110, -397.6560, 273.4254, 272.8892},
	{-1565.0505, -304.0998, 271.3497, 85.3634},
	{-1571.2914, -301.3372, 271.3497, 265.8995},
	{-1550.1138, -307.6401, 270.5767, 52.7860},
	{-1560.4999, -317.0979, 285.0981, 163.2189}
};
new Float:GunGame_Spawns[9][4] =
{
	{128.0054, 2053.1135, 67.9859, 10.3063},
	{112.5390, 2049.1602, 64.5685, 178.2033},
	{108.4070, 2048.8506, 64.1481, 330.6981},
	{109.2825, 2078.1917, 63.7337, 246.9249},
	{150.1040, 2084.5938, 63.9333, 159.6259},
	{157.0200, 2063.7603, 67.4000, 81.7909},
	{152.1180, 2053.0212, 65.3972, 49.5435},
	{128.5013, 2079.5000, 70.9250, 1.8734},
	{128.1444, 2049.5649, 88.4781, 2.2650}
};
new Float:BG_M1_T1_Spawns[4][4] =
{
	{-455.7792, -58.5108, 59.8029, 139.7756},
	{-435.4336, -56.8861, 58.8833, 97.0126},
	{-440.3568, -77.4319, 59.0455, 116.2910},
	{-455.1911, -70.1563, 59.7096, 136.2704}
};
new Float:BG_M1_T2_Spawns[4][4] =
{
	{-578.6148, -180.4718, 78.7617, 320.9920},
	{-583.2191, -170.5733, 79.2114, 320.99205},
	{-571.3069, -183.6573, 78.4063, 251.5899},
	{-557.7114, -181.2337, 78.4047, 339.2187}
};
new Float:BG_M2_T1_Spawns[4][4] =
{
	{566.4445, -2441.1155, 3.2606, 90.0},
	{557.8643, -2439.3618, 3.2606, 90.0},
	{558.2055, -2431.5737, 3.2606, 90.0},
	{566.3401, -2428.1511, 3.2606, 90.0}
};
new Float:BG_M2_T2_Spawns[4][4] =
{
	{692.2197, -2430.2900, 3.2606, 90.0},
	{683.4767, -2429.1997, 3.2606, 90.0},
	{685.1592, -2439.1643, 3.2606, 90.0},
	{691.5789, -2437.9065, 3.2606, 90.0}
};
new Float:BG_M3_T1_Spawns[4][4] =
{
	{-2180.0020, -266.4913, 36.5156, 277.7783},
	{-2180.3604, -260.0984, 36.5156, 281.6340},
	{-2183.8555, -265.5697, 36.5156, 281.6340},
	{-2183.7983, -262.1465, 40.7195, 266.1907}
};
new Float:BG_M3_T2_Spawns[4][4] =
{
	{-2187.3665, -209.5552, 36.5156, 182.4175},
	{-2183.3145, -214.3069, 36.5156, 182.4175},
	{-2188.1506, -223.1832, 36.5156, 182.4175},
	{-2183.5532, -223.9128, 36.5156, 87.0773}
};
new Float:BG_M4_T1_Spawns[4][4] =
{
	{673.8533, -2399.7190, 107.1669, 270.3580},
	{685.6569, -2407.2200, 107.1804, 356.2215},
	{712.4095, -2400.4097, 106.9510, 83.4871},
	{663.0553, -2398.7061, 111.9654, 269.9614}
};
new Float:BG_M4_T2_Spawns[4][4] =
{
	{722.7262, -2304.8560, 107.9041, 130.8066},
	{721.2896, -2319.1465, 107.6767, 84.8891},
	{709.2130, -2304.4978, 107.8904, 194.9510},
	{708.6271, -2315.9961, 107.7215, 160.2499}
};
new Float:BG_M5_T1_Spawns[4][4] =
{
	{1804.2432, -2994.2014, 6.1094, 177.3439},
	{1807.2275, -2998.5554, 6.1044, 133.5295},
	{1794.2000, -2997.5786, 8.7994, 221.8594},
	{1788.9626, -2984.6211, 6.9992, 227.8387}
};
new Float:BG_M5_T2_Spawns[4][4] =
{
	{1844.8651, -3067.3420, 19.2294, 18.9314},
	{1843.7288, -3058.2097, 14.0106, 26.2922},
	{1852.3188, -3045.4287, 6.0944, 34.0036},
	{1826.1392, -3048.5820, 6.1044, 41.0139}
};
new Float:WorldSpawns[4][4] =
{
	{341.8535, -1852.6327, 8.2618, 90.2136}, //beach
	{-1196.3280, -17.4523, 15.8281, 42.5799}, //sfa
	{1458.9336, 1854.9144, 54.7362, 143.3116}, // LVA
	{680.2595, -1361.8927, 2552.2214, 90.0} //speed
};
new Float:DM_MAP_1[2][4] =
{
	{1309.0240, 2110.4265, 11.0156, 316.7284},
	{1383.8239, 2185.6218, 11.0234, 137.8134}
};
new Float:DM_MAP_2[2][4] =
{
	{1144.1377, 1529.8433, 52.4003, 87.1090},
	{1049.4922, 1529.3169, 52.4077, 271.6640}
};
new Float:DM_MAP_3[2][4] =
{
	{1050.2189, 1024.4153, 11.0000, 327.1479},
	{1114.4515, 1097.1134, 10.2734, 141.6762}
};
new const Float:DM_MAP_4[2][4] =
{
	{2609.7583, 2831.2527, 10.8203, 97.2059},
	{2553.1912, 2824.4099, 10.8203, 283.9544}
};

new PlayerColors[511] =
{
	0x000022FF, 0x000044FF, 0x000066FF, 0x000088FF, 0x0000AAFF, 0x0000CCFF, 0x0000EEFF,
	0x002200FF, 0x002222FF, 0x002244FF, 0x002266FF, 0x002288FF, 0x0022AAFF, 0x0022CCFF, 0x0022EEFF,
	0x004400FF, 0x004422FF, 0x004444FF, 0x004466FF, 0x004488FF, 0x0044AAFF, 0x0044CCFF, 0x0044EEFF,
	0x006600FF, 0x006622FF, 0x006644FF, 0x006666FF, 0x006688FF, 0x0066AAFF, 0x0066CCFF, 0x0066EEFF,
	0x008800FF, 0x008822FF, 0x008844FF, 0x008866FF, 0x008888FF, 0x0088AAFF, 0x0088CCFF, 0x0088EEFF,
	0x00AA00FF, 0x00AA22FF, 0x00AA44FF, 0x00AA66FF, 0x00AA88FF, 0x00AAAAFF, 0x00AACCFF, 0x00AAEEFF,
	0x00CC00FF, 0x00CC22FF, 0x00CC44FF, 0x00CC66FF, 0x00CC88FF, 0x00CCAAFF, 0x00CCCCFF, 0x00CCEEFF,
	0x00EE00FF, 0x00EE22FF, 0x00EE44FF, 0x00EE66FF, 0x00EE88FF, 0x00EEAAFF, 0x00EECCFF, 0x00EEEEFF,
	0x220000FF, 0x220022FF, 0x220044FF, 0x220066FF, 0x220088FF, 0x2200AAFF, 0x2200CCFF, 0x2200FFFF,
	0x222200FF, 0x222222FF, 0x222244FF, 0x222266FF, 0x222288FF, 0x2222AAFF, 0x2222CCFF, 0x2222EEFF,
	0x224400FF, 0x224422FF, 0x224444FF, 0x224466FF, 0x224488FF, 0x2244AAFF, 0x2244CCFF, 0x2244EEFF,
	0x226600FF, 0x226622FF, 0x226644FF, 0x226666FF, 0x226688FF, 0x2266AAFF, 0x2266CCFF, 0x2266EEFF,
	0x228800FF, 0x228822FF, 0x228844FF, 0x228866FF, 0x228888FF, 0x2288AAFF, 0x2288CCFF, 0x2288EEFF,
	0x22AA00FF, 0x22AA22FF, 0x22AA44FF, 0x22AA66FF, 0x22AA88FF, 0x22AAAAFF, 0x22AACCFF, 0x22AAEEFF,
	0x22CC00FF, 0x22CC22FF, 0x22CC44FF, 0x22CC66FF, 0x22CC88FF, 0x22CCAAFF, 0x22CCCCFF, 0x22CCEEFF,
	0x22EE00FF, 0x22EE22FF, 0x22EE44FF, 0x22EE66FF, 0x22EE88FF, 0x22EEAAFF, 0x22EECCFF, 0x22EEEEFF,
	0x440000FF, 0x440022FF, 0x440044FF, 0x440066FF, 0x440088FF, 0x4400AAFF, 0x4400CCFF, 0x4400FFFF,
	0x442200FF, 0x442222FF, 0x442244FF, 0x442266FF, 0x442288FF, 0x4422AAFF, 0x4422CCFF, 0x4422EEFF,
	0x444400FF, 0x444422FF, 0x444444FF, 0x444466FF, 0x444488FF, 0x4444AAFF, 0x4444CCFF, 0x4444EEFF,
	0x446600FF, 0x446622FF, 0x446644FF, 0x446666FF, 0x446688FF, 0x4466AAFF, 0x4466CCFF, 0x4466EEFF,
	0x448800FF, 0x448822FF, 0x448844FF, 0x448866FF, 0x448888FF, 0x4488AAFF, 0x4488CCFF, 0x4488EEFF,
	0x44AA00FF, 0x44AA22FF, 0x44AA44FF, 0x44AA66FF, 0x44AA88FF, 0x44AAAAFF, 0x44AACCFF, 0x44AAEEFF,
	0x44CC00FF, 0x44CC22FF, 0x44CC44FF, 0x44CC66FF, 0x44CC88FF, 0x44CCAAFF, 0x44CCCCFF, 0x44CCEEFF,
	0x44EE00FF, 0x44EE22FF, 0x44EE44FF, 0x44EE66FF, 0x44EE88FF, 0x44EEAAFF, 0x44EECCFF, 0x44EEEEFF,
	0x660000FF, 0x660022FF, 0x660044FF, 0x660066FF, 0x660088FF, 0x6600AAFF, 0x6600CCFF, 0x6600FFFF,
	0x662200FF, 0x662222FF, 0x662244FF, 0x662266FF, 0x662288FF, 0x6622AAFF, 0x6622CCFF, 0x6622EEFF,
	0x664400FF, 0x664422FF, 0x664444FF, 0x664466FF, 0x664488FF, 0x6644AAFF, 0x6644CCFF, 0x6644EEFF,
	0x666600FF, 0x666622FF, 0x666644FF, 0x666666FF, 0x666688FF, 0x6666AAFF, 0x6666CCFF, 0x6666EEFF,
	0x668800FF, 0x668822FF, 0x668844FF, 0x668866FF, 0x668888FF, 0x6688AAFF, 0x6688CCFF, 0x6688EEFF,
	0x66AA00FF, 0x66AA22FF, 0x66AA44FF, 0x66AA66FF, 0x66AA88FF, 0x66AAAAFF, 0x66AACCFF, 0x66AAEEFF,
	0x66CC00FF, 0x66CC22FF, 0x66CC44FF, 0x66CC66FF, 0x66CC88FF, 0x66CCAAFF, 0x66CCCCFF, 0x66CCEEFF,
	0x66EE00FF, 0x66EE22FF, 0x66EE44FF, 0x66EE66FF, 0x66EE88FF, 0x66EEAAFF, 0x66EECCFF, 0x66EEEEFF,
	0x880000FF, 0x880022FF, 0x880044FF, 0x880066FF, 0x880088FF, 0x8800AAFF, 0x8800CCFF, 0x8800FFFF,
	0x882200FF, 0x882222FF, 0x882244FF, 0x882266FF, 0x882288FF, 0x8822AAFF, 0x8822CCFF, 0x8822EEFF,
	0x884400FF, 0x884422FF, 0x884444FF, 0x884466FF, 0x884488FF, 0x8844AAFF, 0x8844CCFF, 0x8844EEFF,
	0x886600FF, 0x886622FF, 0x886644FF, 0x886666FF, 0x886688FF, 0x8866AAFF, 0x8866CCFF, 0x8866EEFF,
	0x888800FF, 0x888822FF, 0x888844FF, 0x888866FF, 0x888888FF, 0x8888AAFF, 0x8888CCFF, 0x8888EEFF,
	0x88AA00FF, 0x88AA22FF, 0x88AA44FF, 0x88AA66FF, 0x88AA88FF, 0x88AAAAFF, 0x88AACCFF, 0x88AAEEFF,
	0x88CC00FF, 0x88CC22FF, 0x88CC44FF, 0x88CC66FF, 0x88CC88FF, 0x88CCAAFF, 0x88CCCCFF, 0x88CCEEFF,
	0x88EE00FF, 0x88EE22FF, 0x88EE44FF, 0x88EE66FF, 0x88EE88FF, 0x88EEAAFF, 0x88EECCFF, 0x88EEEEFF,
	0xAA0000FF, 0xAA0022FF, 0xAA0044FF, 0xAA0066FF, 0xAA0088FF, 0xAA00AAFF, 0xAA00CCFF, 0xAA00FFFF,
	0xAA2200FF, 0xAA2222FF, 0xAA2244FF, 0xAA2266FF, 0xAA2288FF, 0xAA22AAFF, 0xAA22CCFF, 0xAA22EEFF,
	0xAA4400FF, 0xAA4422FF, 0xAA4444FF, 0xAA4466FF, 0xAA4488FF, 0xAA44AAFF, 0xAA44CCFF, 0xAA44EEFF,
	0xAA6600FF, 0xAA6622FF, 0xAA6644FF, 0xAA6666FF, 0xAA6688FF, 0xAA66AAFF, 0xAA66CCFF, 0xAA66EEFF,
	0xAA8800FF, 0xAA8822FF, 0xAA8844FF, 0xAA8866FF, 0xAA8888FF, 0xAA88AAFF, 0xAA88CCFF, 0xAA88EEFF,
	0xAAAA00FF, 0xAAAA22FF, 0xAAAA44FF, 0xAAAA66FF, 0xAAAA88FF, 0xAAAAAAFF, 0xAAAACCFF, 0xAAAAEEFF,
	0xAACC00FF, 0xAACC22FF, 0xAACC44FF, 0xAACC66FF, 0xAACC88FF, 0xAACCAAFF, 0xAACCCCFF, 0xAACCEEFF,
	0xAAEE00FF, 0xAAEE22FF, 0xAAEE44FF, 0xAAEE66FF, 0xAAEE88FF, 0xAAEEAAFF, 0xAAEECCFF, 0xAAEEEEFF,
	0xCC0000FF, 0xCC0022FF, 0xCC0044FF, 0xCC0066FF, 0xCC0088FF, 0xCC00AAFF, 0xCC00CCFF, 0xCC00FFFF,
	0xCC2200FF, 0xCC2222FF, 0xCC2244FF, 0xCC2266FF, 0xCC2288FF, 0xCC22AAFF, 0xCC22CCFF, 0xCC22EEFF,
	0xCC4400FF, 0xCC4422FF, 0xCC4444FF, 0xCC4466FF, 0xCC4488FF, 0xCC44AAFF, 0xCC44CCFF, 0xCC44EEFF,
	0xCC6600FF, 0xCC6622FF, 0xCC6644FF, 0xCC6666FF, 0xCC6688FF, 0xCC66AAFF, 0xCC66CCFF, 0xCC66EEFF,
	0xCC8800FF, 0xCC8822FF, 0xCC8844FF, 0xCC8866FF, 0xCC8888FF, 0xCC88AAFF, 0xCC88CCFF, 0xCC88EEFF,
	0xCCAA00FF, 0xCCAA22FF, 0xCCAA44FF, 0xCCAA66FF, 0xCCAA88FF, 0xCCAAAAFF, 0xCCAACCFF, 0xCCAAEEFF,
	0xCCCC00FF, 0xCCCC22FF, 0xCCCC44FF, 0xCCCC66FF, 0xCCCC88FF, 0xCCCCAAFF, 0xCCCCCCFF, 0xCCCCEEFF,
	0xCCEE00FF, 0xCCEE22FF, 0xCCEE44FF, 0xCCEE66FF, 0xCCEE88FF, 0xCCEEAAFF, 0xCCEECCFF, 0xCCEEEEFF,
	0xEE0000FF, 0xEE0022FF, 0xEE0044FF, 0xEE0066FF, 0xEE0088FF, 0xEE00AAFF, 0xEE00CCFF, 0xEE00FFFF,
	0xEE2200FF, 0xEE2222FF, 0xEE2244FF, 0xEE2266FF, 0xEE2288FF, 0xEE22AAFF, 0xEE22CCFF, 0xEE22EEFF,
	0xEE4400FF, 0xEE4422FF, 0xEE4444FF, 0xEE4466FF, 0xEE4488FF, 0xEE44AAFF, 0xEE44CCFF, 0xEE44EEFF,
	0xEE6600FF, 0xEE6622FF, 0xEE6644FF, 0xEE6666FF, 0xEE6688FF, 0xEE66AAFF, 0xEE66CCFF, 0xEE66EEFF,
	0xEE8800FF, 0xEE8822FF, 0xEE8844FF, 0xEE8866FF, 0xEE8888FF, 0xEE88AAFF, 0xEE88CCFF, 0xEE88EEFF,
	0xEEAA00FF, 0xEEAA22FF, 0xEEAA44FF, 0xEEAA66FF, 0xEEAA88FF, 0xEEAAAAFF, 0xEEAACCFF, 0xEEAAEEFF,
	0xEECC00FF, 0xEECC22FF, 0xEECC44FF, 0xEECC66FF, 0xEECC88FF, 0xEECCAAFF, 0xEECCCCFF, 0xEECCEEFF,
	0xEEEE00FF, 0xEEEE22FF, 0xEEEE44FF, 0xEEEE66FF, 0xEEEE88FF, 0xEEEEAAFF, 0xEEEECCFF, 0xEEEEEEFF
};

new const VehicleNames[212][] =
{
	{"Landstalker"},{"Bravura"},{"Buffalo"},{"Linerunner"},{"Perrenial"},{"Sentinel"},{"Dumper"},{"Firetruck"},{"Trashmaster"},{"Stretch"},
	{"Manana"},{"Infernus"},{"Voodoo"},{"Pony"},{"Mule"},{"Cheetah"},{"Ambulance"},{"Leviathan"},{"Moonbeam"},{"Esperanto"},{"Taxi"},
	{"Washington"},{"Bobcat"},{"Mr Whoopee"},{"BF Injection"},{"Ohdude"},{"Premier"},{"Enforcer"},{"Securicar"},{"Banshee"},{"Predator"},{"Bus"},
	{"faggot"},{"Barracks"},{"Hotknife"},{"Trailer 1"},{"Previon"},{"Coach"},{"Cabbie"},{"Stallion"},{"Rumpo"},{"RC Bandit"},{"Romero"},{"Packer"},
	{"Monster"},{"Admiral"},{"Squalo"},{"Seasparrow"},{"Pizzaboy"},{"Tram"},{"Trailer 2"},{"Turismo"},{"Speeder"},{"Reefer"},{"Tropic"},{"Flatbed"},
	{"Yankee"},{"Caddy"},{"Solair"},{"Berkley's RC Van"},{"Skimmer"},{"PCJ-600"},{"Faggio"},{"Freeway"},{"RC Baron"},{"RC Raider"},{"Glendale"},{"Oceanic"},
	{"Sanchez"},{"Sparrow"},{"Patriot"},{"Quad"},{"Coastguard"},{"Dinghy"},{"Hermes"},{"Sabre"},{"Rustler"},{"ZR-350"},{"Walton"},{"Regina"},{"Comet"},
	{"BMX"},{"Burrito"},{"Camper"},{"Marquis"},{"Baggage"},{"Dozer"},{"Maverick"},{"News Chopper"},{"Rancher"},{"FBI Rancher"},{"Virgo"},{"Greenwood"},
	{"Jetmax"},{"Hotring"},{"Sandking"},{"Blista Compact"},{"Police Maverick"},{"Boxville"},{"Benson"},{"Mesa"},{"RC Goblin"},{"Hotring Racer A"},
	{"Hotring Racer B"},{"Bloodring Banger"},{"Rancher"},{"Super GT"},{"Elegant"},{"Journey"},{"Bike"},{"Mountain Bike"},{"Beagle"},{"Cropdust"},{"Stunt"},
	{"Tanker"},{"Roadtrain"},{"Nebula"},{"Majestic"},{"Buccaneer"},{"Shamal"},{"Jumpjet"},{"FCR-900"},{"NRG-500"},{"HPV1000"},{"Cement Truck"},{"Tow Truck"},
	{"Fortune"},{"Cadrona"},{"FBI Truck"},{"Willard"},{"Forklift"},{"Tractor"},{"Combine"},{"Feltzer"},{"Remington"},{"Slamvan"},{"Blade"},{"Freight"},
	{"Brownstreak"},{"Vortex"},{"Vincent"},{"Bullet"},{"Clover"},{"Sadler"},{"Firetruck LA"},{"Hustler"},{"Intruder"},{"Primo"},{"Cargobob"},{"Tampa"},{"Sunrise"},{"Merit"},
	{"Utility"},{"Nevada"},{"Yosemite"},{"Windsor"},{"Monster A"},{"Monster B"},{"Uranus"},{"Jester"},{"Sultan"},{"Stratum"},{"Elegy"},{"Raindance"},{"RC Tiger"},
	{"Flash"},{"Tahoma"},{"Savanna"},{"Bandito"},{"Freight Flat"},{"Streak Carriage"},{"Kart"},{"Mower"},{"Duneride"},{"Sweeper"},{"Broadway"},{"Tornado"},{"AT-400"},
	{"DFT-30"},{"Huntley"},{"Stafford"},{"BF-400"},{"Newsvan"},{"Tug"},{"Trailer 3"},{"Emperor"},{"Wayfarer"},{"Euros"},{"Hotdog"},{"Club"},{"Freight Carriage"},
	{"Trailer 3"},{"Andromada"},{"Dodo"},{"RC Cam"},{"Launch"},{"Police Car (LSPD)"},{"Police Car (SFPD)"},{"Police Car (LVPD)"},{"Police Ranger"},{"Picador"},{"S.W.A.T. Van"},
	{"Alpha"},{"Phoenix"},{"Glendale"},{"Sadler"},{"Luggage Trailer A"},{"Luggage Trailer B"},{"Stair Trailer"},{"Boxville"},{"Farm Plow"},{"Utility Trailer"}
};

new pv_spoiler[20][0] =
{
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new pv_nitro[3][0] =
{
    {1008},
    {1009},
    {1010}
};

new pv_fbumper[23][0] =
{
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1167},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1192},
    {1193}
};

new pv_rbumper[22][0] =
{
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1166},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1190},
    {1191}
};

new pv_exhaust[28][0] =
{
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};

new pv_bventr[2][0] =
{
    {1142},
    {1144}
};

new pv_bventl[2][0] =
{
    {1143},
    {1145}
};

new pv_bscoop[4][0] =
{
	{1004},
	{1005},
	{1011},
	{1012}
};

new pv_roof[17][0] =
{
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091},
    {1103},
    {1128},
    {1130},
    {1131}
};

new pv_lskirt[21][0] =
{
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};

new pv_rskirt[21][0] =
{
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};

new pv_hydraulics[1][0] =
{
    {1087}
};

new pv_base[1][0] =
{
    {1086}
};

new pv_rbbars[4][0] =
{
    {1109},
    {1110},
    {1123},
    {1125}
};

new pv_fbbars[2][0] =
{
    {1115},
    {1116}
};

new pv_wheels[17][0] =
{
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};

new pv_lights[2][0] =
{
	{1013},
	{1024}
};

main() { }

// ===
// callbacks
// ===

public OnGameModeInit()
{
	print("=====================Next Geneartion Stunting=====================");
	
	mysql_debug(1);
	enable_mutex(true);
    MySQL_Connect();
    MySQL_ClearLoggedPlayers();

    BuildServerMap();
    BuildServerMap2();

	//For teh npcs
	AddStaticVehicle(537, 1462.0745, 2630.8787, 10.8203, 0.0, -1, -1);
	AddStaticVehicle(538, -2006.5000, 144.8758, 28.8756, 180.0000, -1, -1);
	//npcs end
	
	ResetElevatorQueue();
	Elevator_Initialize();
	LoadStores();
	LoadHouses();
	LoadProps();
	LoadServerStaticMeshes();
	LoadVisualStaticMeshes();
	CreateTextdraws();
	LoadExObjects();
    ExecGlobTDUpdateTimer();
    ExecDerbyVotingTimer();
    ExecBGVotingTimer();
    LoadRaceNames();

	SetTimer("DelayAutoRace", 40307, false);
	SetTimer("RandomSvrMsg", SERVERMSGS_TIME, true);

	RaceStatus = RaceStatus_Inactive;
    DerbyPlayers = 0;
    CurrentDerbyPlayers = 0;
    CurrentBGMap = BG_VOTING;
	IsDerbyRunning = false;
	StartTime = gettime();
	ClearDerbyVotes();
	CurrentDerbyMap = 1;

	tRandomTXTInfo = SetTimer("RandomTextDrawText", RANDOM_TEXTDRAW_TEXT, true);
	tReactionTimer = SetTimer("xReactionTest", REAC_TIME, true);
    SetTimer("TimePulse", 1000, true);
    
    SollIchDirMaEtWatSagen();

	for(new i = 1; i < MAX_REPORTS; i++) Reports[i] = "<none>";

	ConnectNPC("[NGS]Floatround", "bot0");
	ConnectNPC("[NGS]Inyaface", "bot1");
	ConnectNPC("[NGS]SS_FatGuy", "bot2");
	ConnectNPC("[NGS]TrainRider", "train_lv");
	ConnectNPC("[NGS]CrazyLilMan", "at400_ls");

    LoadServerVehicles();

	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		SetVehicleNumberPlate(i, "{3399ff}S{FFFFFF}tun{F81414}T");
		SetVehicleToRespawn(i);
		AddVehicleComponent(i, 1010);
	}

	print("=====================Next Geneartion Stunting=====================");
	return 1;
}

public OnGameModeExit()
{
	print("Unloading GameMode...");
    new stats[255];
	mysql_stat(stats, g_SQL_handle);
	print(stats);

	KillTimer(tReactionTimer);
	KillTimer(tRandomTXTInfo);
	KillTimer(tBGVoting);
	KillTimer(tBGTimer);
  	KillTimer(tDerbyTimer);
    KillTimer(tDerbyFallOver);
  	KillTimer(tGlobTDUpdate);
  	KillTimer(tDerbyVoting);
	KillTimer(trCounter);
	KillTimer(tRaceCount);

	DestroyTextdraws();
	DestroyStores();
	DestroyElevator();

	DestroyAllDynamicObjects();
	DestroyAllDynamicCPs();
	DestroyAllDynamicRaceCPs();
	DestroyAllDynamicMapIcons();
	DestroyAllDynamic3DTextLabels();
	DestroyAllDynamicPickups();

 	mysql_close(g_SQL_handle);
	print("...GameMode unloaded!");
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(GlobalMain) return 1;

    if(IsPlayerNPC(playerid))
	{
		if(!strcmp(__GetName(playerid), "[NGS]TrainRider", true))
 		{
	        SetSpawnInfo(playerid, NO_TEAM, 255, 1462.0745, 2630.8787, 10.8203, 0.0, -1, -1, -1, -1, -1, -1);
		}
 	 	else if(!strcmp(__GetName(playerid), "[NGS]CrazyLilMan", true))
 		{
	        SetSpawnInfo(playerid, NO_TEAM, 4, -2006.5000, 144.8758, 28.8756, 180.0000, -1, -1, -1, -1, -1, -1);
		}
		return 1;
	}

	TogglePlayerControllable(playerid, true);
    TextDrawHideForPlayer(playerid, TXTBlackScreenP1);
	TextDrawHideForPlayer(playerid, TXTBlackScreenP2);
	TextDrawHideForPlayer(playerid,	TXTYellowStripP1);
	TextDrawHideForPlayer(playerid,	TXTYellowStripP2);
	
	TextDrawShowForPlayer(playerid, NGSLOGO[0]);
	TextDrawShowForPlayer(playerid, NGSLOGO[1]);
	TextDrawShowForPlayer(playerid, NGSLOGO[2]);

	HidePlayerDerbyTextdraws(playerid);
	HidePlayerBGTextdraws(playerid);
	HidePlayerFalloutTextdraws(playerid);

	TextDrawHideForPlayer(playerid, TXTLocalSignP1);
	TextDrawHideForPlayer(playerid, TXTLocalSignP2);
 	TextDrawHideForPlayer(playerid, TXTLogonStars);
	TextDrawShowForPlayer(playerid, TXTFooterP1);
	TextDrawShowForPlayer(playerid, TXTFooterP2);

	ShowPlayerMeshTXT(playerid);

	ShowPlayerInfoTextdraws(playerid);

	SetPlayerPos(playerid, 387.5766, -1811.7660, 17.2455);
	SetPlayerFacingAngle(playerid, 301.7893);
	SetPVarInt(playerid, "1stSpawn", 1);

	switch(random(4))
	{
		case 0: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
		case 1: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		case 2: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		case 3: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE4);
	}
	new string[32];
	format(string, sizeof(string), "~w~~h~Wanteds: ~b~~h~%i", PlayerInfo[playerid][Wanteds]);
    PlayerTextDrawSetString(playerid, TXTWanteds[playerid], string);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(!PlayerInfo[playerid][AllowSpawn])
	{
	    SendClientMessage(playerid, -1, ""er" You are not logged in!");
	    return 0;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid))
    {
        new botname[MAX_PLAYER_NAME], string[128];
        GetPlayerName(playerid, botname, sizeof(botname));
        SetPlayerColor(playerid, PlayerColors[random(sizeof(PlayerColors))]);

        if(!strcmp(botname, "[NGS]Floatround", true))
		{
		    format(string, sizeof(string), ""vgreen"MC public urination\n\n[NGS]Floatround\nID: %i", playerid);
		    new Text3D:labelbot = Create3DTextLabel(string, -1, 30.0, 40.0, 10.0, 40.0, 0);
		    Attach3DTextLabelToPlayer(labelbot, playerid, 0.0, 0.0, 0.0);
			SetPlayerSkin(playerid, 2);
		}
        else if(!strcmp(botname, "[NGS]Inyaface", true))
		{
		    format(string, sizeof(string), ""vgreen"MC uses time machines irresponsibly\n\n[NGS]Inyaface\nID: %i", playerid);
		    new Text3D:labelbot = Create3DTextLabel(string, -1, 30.0, 40.0, 10.0, 40.0, 0);
		    Attach3DTextLabelToPlayer(labelbot, playerid, 0.0, 0.0, 0.0);
			SetPlayerSkin(playerid, 3);
		}
        else if(!strcmp(botname, "[NGS]SS_FatGuy", true))
		{
		 	format(string, sizeof(string), ""vgreen"MC ate to many burgers\n\n[NGS]SS_FatGuy\nID: %i", playerid);
		    new Text3D:labelbot = Create3DTextLabel(string, -1, 30.0, 40.0, 10.0, 40.0, 0);
		    Attach3DTextLabelToPlayer(labelbot, playerid, 0.0, 0.0, 0.0);
			SetPlayerSkin(playerid, 5);
		}
		else if(!strcmp(botname, "[NGS]TrainRider", true))
		{
		    format(string, sizeof(string), ""vgreen"MC no MC\n\n[NGS]TrainRider\nID: %i", playerid);
		    new Text3D:labelbot = Create3DTextLabel(string, -1, 30.0, 40.0, 10.0, 40.0, 0);
		    Attach3DTextLabelToPlayer(labelbot, playerid, 0.0, 0.0, 0.0);
	        PutPlayerInVehicle(playerid, 1, 0);
	 	}
  		else if(!strcmp(botname, "[NGS]CrazyLilMan", true))
		{
		    format(string, sizeof(string), ""vgreen"MC whose father is a traindriver\n\n[NGS]CrazyLilMan\nID: %i", playerid);
		    new Text3D:labelbot = Create3DTextLabel(string, -1, 30.0, 40.0, 10.0, 40.0, 0);
		    Attach3DTextLabelToPlayer(labelbot, playerid, 0.0, 0.0, 0.0);
	        PutPlayerInVehicle(playerid, 2, 0);
	 	}
		return 1;
    }

    AttachPlayerToys(playerid);

    if(GetPVarInt(playerid, "1stSpawn") == 1)
    {
        TogglePlayerClock(playerid, 1);
  		SetPVarInt(playerid, "1stSpawn", 0);
		StopAudioStreamForPlayer(playerid);
		ResetPlayerWorld(playerid);
		PlayerInfo[playerid][ExitType] = 0;
		PlayerInfo[playerid][Logged] = true;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		TogglePlayerSpectating(playerid, false);
		SetPlayerHealth(playerid, 100.0);
		SetCameraBehindPlayer(playerid);
		PlayerInfo[playerid][tickLastChat] = 0;
		StopAudioStreamForPlayer(playerid);
		SendFirstSpawnMSG(playerid);
		RandomSpawn(playerid);
		RandomWeapon(playerid);
    }
    else switch(gTeam[playerid])
    {
        case NORMAL:
        {
			RandomWeapon(playerid);
			SetCameraBehindPlayer(playerid);
		}
		case DERBY:
		{
		    SetPlayerDerbyStaticMeshes(playerid);
		}
		case DM:
		{
		    SetPlayerHealth(playerid, 100.0);
		    new rand = random(2);
			switch(gLastMap[playerid])
			{
			    case DM_1:
			    {
				  	GivePlayerWeapon(playerid, 24, 99999);
					GivePlayerWeapon(playerid, 26, 99999);
					SetPlayerPos(playerid, DM_MAP_1[rand][0], DM_MAP_1[rand][1], DM_MAP_1[rand][2]);
					SetPlayerFacingAngle(playerid, DM_MAP_1[rand][3]);
			    }
			    case DM_2:
			    {
				  	GivePlayerWeapon(playerid, 34, 99999);
					GivePlayerWeapon(playerid, 33, 99999);
					SetPlayerPos(playerid, DM_MAP_2[rand][0], DM_MAP_2[rand][1], DM_MAP_2[rand][2]);
					SetPlayerFacingAngle(playerid, DM_MAP_2[rand][3]);
			    }
				case DM_3:
			    {
				   	GivePlayerWeapon(playerid, 16, 99999);
					GivePlayerWeapon(playerid, 9, 99999);
					SetPlayerPos(playerid, DM_MAP_3[rand][0], DM_MAP_3[rand][1], DM_MAP_3[rand][2]);
					SetPlayerFacingAngle(playerid, DM_MAP_3[rand][3]);
			    }
				case DM_4:
			    {
		    		GivePlayerWeapon(playerid, 31, 99999);
					GivePlayerWeapon(playerid, 27, 99999);
					GivePlayerWeapon(playerid, 37, 99999);
					SetPlayerPos(playerid, DM_MAP_4[rand][0], DM_MAP_4[rand][1], DM_MAP_4[rand][2]);
					SetPlayerFacingAngle(playerid, DM_MAP_4[rand][3]);
			    }
			}
		}
		case gBG_VOTING:
		{
		    SetPlayerBGStaticMeshes(playerid);
		}
		case gBG_TEAM1:
		{
		    SetPlayerBGTeam1(playerid);

		    SetCameraBehindPlayer(playerid);
		    RandomBGSpawn(playerid, CurrentBGMap, BG_TEAM1);
		    SetPlayerHealth(playerid, 100.0);
		}
		case gBG_TEAM2:
		{
            SetPlayerBGTeam2(playerid);

		    SetCameraBehindPlayer(playerid);
		    RandomBGSpawn(playerid, CurrentBGMap, BG_TEAM2);
		    SetPlayerHealth(playerid, 100.0);
		}
		case SNIPER:
		{
  			ResetPlayerWeapons(playerid);
			SetPlayerVirtualWorld(playerid, SNIPER_WORLD);
			GivePlayerWeapon(playerid, 34, 99999);
			SetPlayerInterior(playerid, 0);

			new rand = random(14);

			SetPlayerPosEx(playerid, Sniper_Spawns[rand][0], Sniper_Spawns[rand][1], floatadd(Sniper_Spawns[rand][2], 2.5));
			SetPlayerFacingAngle(playerid, Sniper_Spawns[rand][3]);
		}
		case MINIGUN:
		{
	        ResetPlayerWeapons(playerid);
	        GivePlayerWeapon(playerid, 38, 99999);
	        SetPlayerVirtualWorld(playerid, MINIGUN_WORLD);
			SetPlayerInterior(playerid, 0);

			new rand = random(11);

			SetPlayerPosEx(playerid, Minigun_Spawns[rand][0], Minigun_Spawns[rand][1], floatadd(Minigun_Spawns[rand][2], 0.5));
			SetPlayerFacingAngle(playerid, Minigun_Spawns[rand][3]);
		}
		case HOUSE:
		{
			RandomSpawn(playerid);
			RandomWeapon(playerid);
			ResetPlayerWorld(playerid);
			gTeam[playerid] = NORMAL;
		}
		case GUNGAME :
		{
			new rand = random(9);
			ResetPlayerWeapons(playerid);

			SetPlayerPosEx(playerid, GunGame_Spawns[rand][0], GunGame_Spawns[rand][1], floatadd(GunGame_Spawns[rand][2], 8.0));
			SetPlayerFacingAngle(playerid, GunGame_Spawns[rand][3]);
			SetCameraBehindPlayer(playerid);

			GivePlayerWeapon(playerid, 4, 1);
			GivePlayerWeapon(playerid, GunGame_Weapons[GunGame_Player[playerid][level]], 65535);

			GunGame_Player[playerid][dead] = false;
			GunGame_Player[playerid][pw] = true;
			if(GunGamePlayers >= 16) SetPlayerHealth(playerid, 100.0);
			else SetPlayerHealth(playerid, ((25) + (5 * GunGamePlayers)));
		}
		default:
		{
		    gTeam[playerid] = NORMAL;
		    RandomSpawn(playerid);
		    RandomWeapon(playerid);
		}
    }
    PlayerInfo[playerid][IsDead] = false;
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	
	gTeam[playerid] = NORMAL;
	
    PlayAudioStreamForPlayer(playerid, loginsoundlink);
	for(new i = 0; i < 130; i++)
	{
		SendClientMessage(playerid, GREY, " ");
	}

	PlayerInfo[playerid][Level] = 0;
    LabelActive[playerid] = false;
    PlayerHit[playerid] = false;
    PlayerInfo[playerid][tTimerHP] = -1;
	PlayerInfo[playerid][ExitType] = 1;
	PlayerInfo[playerid][Logged] = false;
	PlayerInfo[playerid][AllowSpawn] = false;
	PlayerInfo[playerid][bGoTo] = true;
	PlayerInfo[playerid][AOnline] = true;
	bDerbyAFK[playerid] = false;
	PlayerInfo[playerid][ConnectTime] = 0;
	PlayerInfo[playerid][Lang] = 0;
	PlayerInfo[playerid][iCoolDownCommand] = 0;
	PlayerInfo[playerid][iCoolDownDeath] = 0;
	DisablePlayerRaceCheckpoint(playerid);

    PlayerInfoVeh[playerid][Model] = -1;
    PlayerInfoVeh[playerid][Price] = -1;
    PlayerInfoVeh[playerid][PaintJob] = -1;
    PlayerInfoVeh[playerid][Color1] = 0;
    PlayerInfoVeh[playerid][Color2] = 0;
    PlayerInfoVeh[playerid][Mod1] = 0;
    PlayerInfoVeh[playerid][Mod2] = 0;
    PlayerInfoVeh[playerid][Mod3] = 0;
    PlayerInfoVeh[playerid][Mod4] = 0;
    PlayerInfoVeh[playerid][Mod5] = 0;
    PlayerInfoVeh[playerid][Mod6] = 0;
    PlayerInfoVeh[playerid][Mod7] = 0;
    PlayerInfoVeh[playerid][Mod8] = 0;
    PlayerInfoVeh[playerid][Mod9] = 0;
    PlayerInfoVeh[playerid][Mod10] = 0;
    PlayerInfoVeh[playerid][Mod11] = 0;
    PlayerInfoVeh[playerid][Mod12] = 0;
    PlayerInfoVeh[playerid][Mod13] = 0;
    PlayerInfoVeh[playerid][Mod14] = 0;
    PlayerInfoVeh[playerid][Mod15] = 0;
    PlayerInfoVeh[playerid][Mod16] = 0;
    PlayerInfoVeh[playerid][Mod17] = 0;
    PlayerInfoVeh[playerid][Neon1] = -1;
    PlayerInfoVeh[playerid][Neon2] = -1;

	PlayerInfo[playerid][IsInGang] = 0;
	PlayerInfo[playerid][GangID] = 0;

	strmid(PlayerInfoVeh[playerid][Plate], "---", 0, 13, 13);
    strmid(PlayerInfo[playerid][GangName], "---", 0, 21, 21);
    strmid(PlayerInfo[playerid][GangTag], "---", 0, 5, 5);
    strmid(PlayerInfo[playerid][GangKickMem], "", 0, 25, 25);

 	GunGame_Player[playerid][level] = 0;
	GunGame_Player[playerid][dead] = true;
	GunGame_Player[playerid][pw] = true;

	SetPVarInt(playerid, "LastID", -1);
	PlayerInfo[playerid][SpeedBoost] = true;
	PlayerInfo[playerid][SuperJump] = false;
	PlayerInfo[playerid][Frozen] = false;
	PlayerInfo[playerid][SavedPos] = false;
	PlayerInfo[playerid][BuyAbleVeh] = 0;
	PlayerInfo[playerid][HitmanHit] = 0;
	PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][RaceWins] = 0;
	PlayerInfo[playerid][FalloutWins] = 0;
	PlayerInfo[playerid][GungameWins] = 0;
	PlayerInfo[playerid][DerbyWins] = 0;
	PlayerInfo[playerid][PayDay] = 60;
	PlayerInfo[playerid][BGWins] = 0;
	PlayerInfo[playerid][Reaction] = 0;
	PlayerInfo[playerid][Money] = 0;
	PlayerInfo[playerid][Score] = 0;
	PlayerInfo[playerid][Bank] = 0;
	PlayerInfo[playerid][hours] = 0;
	PlayerInfo[playerid][mins] = 0;
	PlayerInfo[playerid][secs] = 0;
	PlayerInfo[playerid][Warnings] = 0;
	PlayerInfo[playerid][Houses] = 0;
	PlayerInfo[playerid][Props] = 0;
	PlayerInfo[playerid][Wanteds] = 0;
	PlayerInfo[playerid][Vehicle] = -1;
	PlayerInfo[playerid][PV_Vehicle] = -1;
	PlayerInfo[playerid][FailLogin] = 0;
 	PlayerInfo[playerid][TotalTime] = 0;
	PlayerInfo[playerid][Muted] = false;
	PlayerInfo[playerid][MuteTimer] = -1;
	PlayerInfo[playerid][Frozen] = false;
	PlayerInfo[playerid][onduty] = false;
	PlayerInfo[playerid][gInvite] = false;
	PlayerInfo[playerid][FalloutLost] = true;
    PlayerInfo[playerid][bHasSpawn] = false;
	PlayerInfo[playerid][ChatWrote] = 0;
	PlayerInfo[playerid][RegDate] = 0;
	PlayerInfo[playerid][PropEarnings] = 0;
	PlayerInfo[playerid][tickLastHitman] = 0;
	PlayerInfo[playerid][tickLastGInvite] = 0;
	PlayerInfo[playerid][tickLastGKick] = 0;
	PlayerInfo[playerid][tickLastGCreate] = 0;
	PlayerInfo[playerid][tickLastPBuy] = 0;
	PlayerInfo[playerid][tickLastBuy] = 0;
	PlayerInfo[playerid][tickLastSell] = 0;
	PlayerInfo[playerid][tickLastPSell] = 0;
    PlayerInfo[playerid][tickLastPW] = 0;
    PlayerInfo[playerid][tickLastGoToMyProp] = 0;
    PlayerInfo[playerid][tickLastGoToMyHouse] = 0;
   	PlayerInfo[playerid][tickLastChat] = 0;
   	PlayerInfo[playerid][tickLastReport] = 0;
   	PlayerInfo[playerid][tickLastPM] = 0;
   	
    PlayerInfo[playerid][toy_selected] = 0;

    PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_NONE;
    PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;

    PlayerRaceVehicle[playerid] = -1;
    pDerbyCar[playerid] = -1;
    PreviewTmpVeh[playerid] = -1;
    
	SetPlayerScore(playerid, 0);
	SetPlayerTeam(playerid, NO_TEAM);

	new ip[16],
		count = 1;
		
	GetPlayerIp(playerid, ip, sizeof(ip));
    strcat(g_asIP[playerid], ip, 16);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i)) continue;
	    if(IsPlayerNPC(i)) continue;
	    if(i == playerid) continue;
	    if(isnull(g_asIP[i])) continue;
	    if(!strcmp(ip, "37.4.0.73")) continue;
		if(!strcmp(ip, g_asIP[i]))
		{
		    count++;
		}
	}
	if(count > 2)
	{
  		return KickEx(playerid);
	}

	HidePlayerFalloutTextdraws(playerid);
	HidePlayerDerbyTextdraws(playerid);
	HidePlayerBGTextdraws(playerid);
	HidePlayerInfoTextdraws(playerid);
	TextDrawHideForPlayer(playerid, TXTFooterP1);
	TextDrawHideForPlayer(playerid, TXTFooterP2);
	TextDrawHideForPlayer(playerid, TXTKeyInfo);
	HidePlayerRaceTextdraws(playerid);

	if(GlobalMain)
	{
	    SendClientMessage(playerid, RED, "Server is in going in maintenance mode, please try again later.");
  		KickEx(playerid);
	}
	else
	{
	    TextDrawShowForPlayer(playerid, TXTLoading);
		TextDrawShowForPlayer(playerid, TXTBlackScreenP1);
		TextDrawShowForPlayer(playerid, TXTBlackScreenP2);
		TextDrawShowForPlayer(playerid, TXTLogonStars);
		TextDrawShowForPlayer(playerid, TXTLocalSignP1);
   		TextDrawShowForPlayer(playerid, TXTLocalSignP2);
		TextDrawShowForPlayer(playerid, TXTYellowStripP1);
		TextDrawShowForPlayer(playerid, TXTYellowStripP2);
		TogglePlayerSpectating(playerid, true);

        InitSession(playerid);

		MySQL_IsAccountBanned(playerid);
 	}
 	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(IsPlayerNPC(playerid)) return 1;
    g_asIP[playerid][0] = '\0';

	KillTimer(PlayerInfo[playerid][tPayDay]);
	KillTimer(PlayerInfo[playerid][tPlayer]);
	if(BuildRace == playerid + 1) BuildRace = 0;
    StopAudioStreamForPlayer(playerid);
    
   	if(PlayerInfo[playerid][ExitType] == 0)
	{
		MySQL_SavePlayer(playerid);
		
        MySQL_SavePlayerToys(playerid);
        
        if(PlayerInfo[playerid][BuyAbleVeh] == 1)
		{
			MySQL_SavePlayerVeh(playerid);
		}
        
        MySQL_LogPlayerOut(playerid);

        DeletePVar(playerid, "1stSpawn");

		switch(gTeam[playerid])
		{
		    case gBG_TEAM1 :
		    {
			    BGTeam1Players--;
		    }
		    case gBG_TEAM2 :
		    {
			    BGTeam2Players--;
		    }
			case FALLOUT :
			{
                PlayerInfo[playerid][FalloutLost] = true;
				gTeam[playerid] = NORMAL;
				CurrentFalloutPlayers--;
			    new count;
				for(new i; i<MAX_PLAYERS; i++)
				{
				    if(!IsPlayerAvail(i)) continue;
				    if(gTeam[i] == FALLOUT) count++;
				}

				if(count < 2)
				{
				    KillTimer(Info[I_iTimer][1]);
				    
					for(new i = 0; i < MAX_PLAYERS; i++)
					{
					    if(gTeam[i] == FALLOUT)
					    {
					    	TogglePlayerControllable(i, true);
						    RandomSpawn(i);
						    RandomWeapon(i);
						    HidePlayerFalloutTextdraws(i);
						    ResetPlayerWorld(i);
						    FalloutMSG("Fallout has been canceled!", "Fallout wurde wegen zu wenigen Spielern abgebrochen!");
						    gTeam[i] = NORMAL;
					    }
					}
					Fallout_Cancel();
				}
			}
			case RACE :
			{
				RaceJoinCount--;
				gTeam[playerid] = NORMAL;
 				if(PlayerRaceVehicle[playerid] != -1)
				{
					DestroyVehicle(PlayerRaceVehicle[playerid]);
					PlayerRaceVehicle[playerid] = -1;
				}
				DisablePlayerRaceCheckpoint(playerid);
				CPProgess[playerid] = 0;
				SetPlayerVirtualWorld(playerid, 0);
				new string[64], gstring[64];
				format(string, sizeof(string), "%s has disconnected from the game", __GetName(playerid));
				format(gstring, sizeof(gstring), "%s hat das Rennen verlassen", __GetName(playerid));
				RaceMSG(string, gstring);
			}
			case DERBY :
			{
			    //OPDisc
			    DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);
			    
			    if(!bDerbyAFK[playerid])
				{
				    CurrentDerbyPlayers--;
                    gTeam[playerid] = NORMAL;
			 		if(!IsDerbyRunning)
				    {
						if(CurrentDerbyPlayers < 2)
						{
							ExecDerbyVotingTimer();
							ClearDerbyVotes();
						}
					}
					else if(IsDerbyRunning && DerbyWinner[playerid])
					{
					    if(pDerbyCar[playerid] != -1)
					    {
					    	DestroyVehicle(pDerbyCar[playerid]);
					    	pDerbyCar[playerid] = -1;
						}
					    DerbyWinner[playerid] = false;
	        			DerbyPlayers--;
					    if(DerbyPlayers == 1) Derby();
					}
			    }
			}
			case GUNGAME:
			{
			    GunGamePlayers--;
			}
		}

        if(PlayerInfo[playerid][Muted]) KillTimer(PlayerInfo[playerid][MuteTimer]);

		if(PlayerInfo[playerid][onduty])
		{
		    RemovePlayerAttachedObject(playerid, 9);
        	Delete3DTextLabel(AdminDutyLabel[playerid]);
        	PlayerInfo[playerid][onduty] = false;
		}

		if(PlayerInfo[playerid][IsInGang] != 0) DestroyDynamic3DTextLabel(PlayerInfo[playerid][GangLabel]);

        for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
        {
			if(IsPlayerAttachedObjectSlotUsed(playerid, i))
			{
				RemovePlayerAttachedObject(playerid, i);
			}
		}

		if(PlayerInfo[playerid][Vehicle] != -1)
		{
			DestroyVehicle(PlayerInfo[playerid][Vehicle]);
			PlayerInfo[playerid][Vehicle] = -1;
		}
		if(PlayerInfoVeh[playerid][Neon1] != -1)
		{
			DestroyDynamicObject(PlayerInfoVeh[playerid][Neon1]);
			PlayerInfoVeh[playerid][Neon1] = -1;
		}
		if(PlayerInfoVeh[playerid][Neon2] != -1)
		{
			DestroyDynamicObject(PlayerInfoVeh[playerid][Neon2]);
			PlayerInfoVeh[playerid][Neon2] = -1;
		}
		if(PlayerInfo[playerid][PV_Vehicle] != -1)
		{
		    DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
			DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
			PlayerInfo[playerid][PV_Vehicle] = -1;
		}

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
	    	if(GetPlayerState(i) == PLAYER_STATE_SPECTATING && PlayerInfo[i][SpecID] == playerid)
	    	{
	   			StopSpectate(i);
				SendInfo(i, "~r~~h~Player disconnected!", 2500);
			}
		}
	}

	gTeam[playerid] = NORMAL;
	
	PlayerInfo[playerid][Level] = 0;
    LabelActive[playerid] = false;
    PlayerInfo[playerid][tTimerHP] = -1;
	PlayerInfo[playerid][ExitType] = 1;
	PlayerInfo[playerid][Logged] = false;
	bDerbyAFK[playerid] = false;
	PlayerInfo[playerid][AllowSpawn] = false;
	PlayerInfo[playerid][AOnline] = true;
	PlayerInfo[playerid][ConnectTime] = 0;
	PlayerInfo[playerid][Lang] = 0;
	PlayerInfo[playerid][iCoolDownCommand] = 0;
	PlayerInfo[playerid][iCoolDownDeath] = 0;
	DisablePlayerRaceCheckpoint(playerid);

    PlayerInfoVeh[playerid][Model] = -1;
    PlayerInfoVeh[playerid][Price] = -1;
    PlayerInfoVeh[playerid][PaintJob] = -1;
    PlayerInfoVeh[playerid][Color1] = 0;
    PlayerInfoVeh[playerid][Color2] = 0;
    PlayerInfoVeh[playerid][Mod1] = 0;
    PlayerInfoVeh[playerid][Mod2] = 0;
    PlayerInfoVeh[playerid][Mod3] = 0;
    PlayerInfoVeh[playerid][Mod4] = 0;
    PlayerInfoVeh[playerid][Mod5] = 0;
    PlayerInfoVeh[playerid][Mod6] = 0;
    PlayerInfoVeh[playerid][Mod7] = 0;
    PlayerInfoVeh[playerid][Mod8] = 0;
    PlayerInfoVeh[playerid][Mod9] = 0;
    PlayerInfoVeh[playerid][Mod10] = 0;
    PlayerInfoVeh[playerid][Mod11] = 0;
    PlayerInfoVeh[playerid][Mod12] = 0;
    PlayerInfoVeh[playerid][Mod13] = 0;
    PlayerInfoVeh[playerid][Mod14] = 0;
    PlayerInfoVeh[playerid][Mod15] = 0;
    PlayerInfoVeh[playerid][Mod16] = 0;
    PlayerInfoVeh[playerid][Mod17] = 0;
    PlayerInfoVeh[playerid][Neon1] = -1;
    PlayerInfoVeh[playerid][Neon2] = -1;

	PlayerInfo[playerid][IsInGang] = 0;
	PlayerInfo[playerid][GangID] = 0;
	
	strmid(PlayerInfoVeh[playerid][Plate], "---", 0, 13, 13);
    strmid(PlayerInfo[playerid][GangName], "---", 0, 21, 21);
    strmid(PlayerInfo[playerid][GangTag], "---", 0, 5, 5);
    strmid(PlayerInfo[playerid][GangKickMem], "", 0, 25, 25);
    
 	GunGame_Player[playerid][level] = 0;
	GunGame_Player[playerid][dead] = true;
	GunGame_Player[playerid][pw] = true;

	SetPVarInt(playerid, "LastID", -1);
	PlayerInfo[playerid][SpeedBoost] = true;
	PlayerInfo[playerid][SuperJump] = false;
	PlayerInfo[playerid][Frozen] = false;
	PlayerInfo[playerid][SavedPos] = false;
	PlayerInfo[playerid][BuyAbleVeh] = 0;
	PlayerInfo[playerid][HitmanHit] = 0;
	PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][RaceWins] = 0;
	PlayerInfo[playerid][FalloutWins] = 0;
	PlayerInfo[playerid][GungameWins] = 0;
	PlayerInfo[playerid][DerbyWins] = 0;
	PlayerInfo[playerid][PayDay] = 60;
	PlayerInfo[playerid][BGWins] = 0;
	PlayerInfo[playerid][Reaction] = 0;
	PlayerInfo[playerid][Money] = 0;
	PlayerInfo[playerid][Score] = 0;
	PlayerInfo[playerid][Bank] = 0;
	PlayerInfo[playerid][hours] = 0;
	PlayerInfo[playerid][mins] = 0;
	PlayerInfo[playerid][secs] = 0;
	PlayerInfo[playerid][Warnings] = 0;
	PlayerInfo[playerid][Houses] = 0;
	PlayerInfo[playerid][Props] = 0;
	PlayerInfo[playerid][Wanteds] = 0;
	PlayerInfo[playerid][Vehicle] = -1;
	PlayerInfo[playerid][PV_Vehicle] = -1;
	PlayerInfo[playerid][FailLogin] = 0;
 	PlayerInfo[playerid][TotalTime] = 0;
	PlayerInfo[playerid][Muted] = false;
	PlayerInfo[playerid][MuteTimer] = -1;
	PlayerInfo[playerid][Frozen] = false;
	PlayerInfo[playerid][onduty] = false;
	PlayerInfo[playerid][gInvite] = false;
	PlayerInfo[playerid][FalloutLost] = true;
 	PlayerInfo[playerid][bHasSpawn] = false;
	PlayerInfo[playerid][ChatWrote] = 0;
	PlayerInfo[playerid][RegDate] = 0;
	PlayerInfo[playerid][PropEarnings] = 0;
	PlayerInfo[playerid][tickLastHitman] = 0;
	PlayerInfo[playerid][tickLastGInvite] = 0;
	PlayerInfo[playerid][tickLastGKick] = 0;
	PlayerInfo[playerid][tickLastGCreate] = 0;
	PlayerInfo[playerid][tickLastPBuy] = 0;
	PlayerInfo[playerid][tickLastBuy] = 0;
	PlayerInfo[playerid][tickLastSell] = 0;
	PlayerInfo[playerid][tickLastPSell] = 0;
    PlayerInfo[playerid][tickLastPW] = 0;
    PlayerInfo[playerid][tickLastGoToMyProp] = 0;
    PlayerInfo[playerid][tickLastGoToMyHouse] = 0;

    PlayerInfo[playerid][toy_selected] = 0;

    PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_NONE;
    PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;

	SetPlayerScore(playerid, 0);
	SetPlayerTeam(playerid, NO_TEAM);
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(PlayerInfo[playerid][IsDead])
	{
	    SendClientMessage(playerid, -1, ""er"You can´t use commands while being dead!");
	    return 0;
	}
	if(!PlayerInfo[playerid][Logged])
	{
	    SendClientMessage(playerid, -1, ""er"You need to spawn to use commands!");
	    return 0;
	}
	if(PlayerInfo[playerid][Frozen])
	{
	    LangMSG(playerid, -1, ""er"You can´t use commands now!", ""er"Du kannst im moment keine Befehle nutzen!");
	    return 0;
	}
	// Closing open dialogs in order to avoid some exploits.
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    new File:lFile = fopen("Logs/cmdlog.txt", io_append),
     	logData[255],
        time[3];

    gettime(time[0], time[1], time[2]);

    format(logData, sizeof(logData), "[%02d:%02d:%02d] %s(%i) USED %s SUCCESS: %i\r\n", time[0], time[1], time[2], __GetName(playerid), playerid, cmdtext, success);
    fwrite(lFile, logData);
    fclose(lFile);

	PlayerInfo[playerid][iCoolDownCommand]++;
	SetTimerEx("CoolDownCommand", COOLDOWN_CMD, false, "i", playerid);
	if(PlayerInfo[playerid][iCoolDownCommand] >= 10 && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
	    new string[128];
		format(string, sizeof(string), "Command-Spam detected! %s(%i) has been kicked!", __GetName(playerid), playerid);
		AdminMSG(RED, string);
		PlayerInfo[playerid][iCoolDownCommand] = 0;
		return Kick(playerid);
	}

	if(!success)
	{
	    SendInfo(playerid, "~r~~h~Unknown command!~n~~n~~w~These commands may help you~n~~g~~h~/help /cmds /tele /rules", 4000);
	}
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	if(PlayerInfo[playerid][BuyAbleVeh] == 1)
	{
		if(vehicleid == PlayerInfo[playerid][PV_Vehicle])
		{
			SaveVehComponets(playerid, componentid);
		}
	}
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	if(PlayerInfo[playerid][BuyAbleVeh] == 1)
	{
	    if(vehicleid == PlayerInfo[playerid][PV_Vehicle])
	    {
			PlayerInfoVeh[playerid][PaintJob] = paintjobid;
		}
	}
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	if(PlayerInfo[playerid][BuyAbleVeh] == 1)
	{
	    if(vehicleid == PlayerInfo[playerid][PV_Vehicle])
	    {
	        PlayerInfoVeh[playerid][Color1] = color1;
	        PlayerInfoVeh[playerid][Color2] = color2;
		}
	}
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    if(!PlayerHit[damagedid])
    {
	    PlayerHit[damagedid] = true;
	    SetPlayerAttachedObject(damagedid,8,1240,2,0.440999,0.000000,0.023000,-1.799999,84.099983,0.000000,1.000000,1.000000,1.000000);
	    SetTimerEx("remove_health_obj", 800, false, "i", damagedid);
	}
	return 1;
}

public OnQueryFinish(query[], resultid, extraid, connectionHandle)
{
    switch(resultid)
	{
	    case THREAD_LOAD_TOYS :
	    {
	        new rows, fields;
	        cache_get_data(rows, fields, g_SQL_handle);
	        
	        if(rows > 0)
	        {
	            // Toy slot 1
	            PlayerToys[extraid][0][toy_model] = cache_get_row_int(0, 2, g_SQL_handle);
	            PlayerToys[extraid][0][toy_bone] = 	cache_get_row_int(0, 3, g_SQL_handle);
	            PlayerToys[extraid][0][toy_x] =     cache_get_row_float(0, 4, g_SQL_handle);
	            PlayerToys[extraid][0][toy_y] =     cache_get_row_float(0, 5, g_SQL_handle);
	            PlayerToys[extraid][0][toy_z] =     cache_get_row_float(0, 6, g_SQL_handle);
	            PlayerToys[extraid][0][toy_rx] =    cache_get_row_float(0, 7, g_SQL_handle);
	            PlayerToys[extraid][0][toy_ry] =    cache_get_row_float(0, 8, g_SQL_handle);
	            PlayerToys[extraid][0][toy_rz] =    cache_get_row_float(0, 9, g_SQL_handle);
	            PlayerToys[extraid][0][toy_sx] =    cache_get_row_float(0, 10, g_SQL_handle);
	            PlayerToys[extraid][0][toy_sy] =    cache_get_row_float(0, 11, g_SQL_handle);
	            PlayerToys[extraid][0][toy_sz] =    cache_get_row_float(0, 12, g_SQL_handle);
	            
	            // Toy slot 2
 	            PlayerToys[extraid][1][toy_model] = cache_get_row_int(0, 13, g_SQL_handle);
	            PlayerToys[extraid][1][toy_bone] = 	cache_get_row_int(0, 14, g_SQL_handle);
	            PlayerToys[extraid][1][toy_x] =     cache_get_row_float(0, 15, g_SQL_handle);
	            PlayerToys[extraid][1][toy_y] =     cache_get_row_float(0, 16, g_SQL_handle);
	            PlayerToys[extraid][1][toy_z] =     cache_get_row_float(0, 17, g_SQL_handle);
	            PlayerToys[extraid][1][toy_rx] =    cache_get_row_float(0, 18, g_SQL_handle);
	            PlayerToys[extraid][1][toy_ry] =    cache_get_row_float(0, 19, g_SQL_handle);
	            PlayerToys[extraid][1][toy_rz] =    cache_get_row_float(0, 20, g_SQL_handle);
	            PlayerToys[extraid][1][toy_sx] =    cache_get_row_float(0, 21, g_SQL_handle);
	            PlayerToys[extraid][1][toy_sy] =    cache_get_row_float(0, 22, g_SQL_handle);
	            PlayerToys[extraid][1][toy_sz] =    cache_get_row_float(0, 23, g_SQL_handle);
	            
	            // Toy slot 3
 	            PlayerToys[extraid][2][toy_model] = cache_get_row_int(0, 24, g_SQL_handle);
	            PlayerToys[extraid][2][toy_bone] = 	cache_get_row_int(0, 25, g_SQL_handle);
	            PlayerToys[extraid][2][toy_x] =     cache_get_row_float(0, 26, g_SQL_handle);
	            PlayerToys[extraid][2][toy_y] =     cache_get_row_float(0, 27, g_SQL_handle);
	            PlayerToys[extraid][2][toy_z] =     cache_get_row_float(0, 28, g_SQL_handle);
	            PlayerToys[extraid][2][toy_rx] =    cache_get_row_float(0, 29, g_SQL_handle);
	            PlayerToys[extraid][2][toy_ry] =    cache_get_row_float(0, 30, g_SQL_handle);
	            PlayerToys[extraid][2][toy_rz] =    cache_get_row_float(0, 31, g_SQL_handle);
	            PlayerToys[extraid][2][toy_sx] =    cache_get_row_float(0, 32, g_SQL_handle);
	            PlayerToys[extraid][2][toy_sy] =    cache_get_row_float(0, 33, g_SQL_handle);
	            PlayerToys[extraid][2][toy_sz] =    cache_get_row_float(0, 34, g_SQL_handle);
	            
	            // Toy slot 4
 	            PlayerToys[extraid][3][toy_model] = cache_get_row_int(0, 35, g_SQL_handle);
	            PlayerToys[extraid][3][toy_bone] = 	cache_get_row_int(0, 36, g_SQL_handle);
	            PlayerToys[extraid][3][toy_x] =     cache_get_row_float(0, 37, g_SQL_handle);
	            PlayerToys[extraid][3][toy_y] =     cache_get_row_float(0, 38, g_SQL_handle);
	            PlayerToys[extraid][3][toy_z] =     cache_get_row_float(0, 39, g_SQL_handle);
	            PlayerToys[extraid][3][toy_rx] =    cache_get_row_float(0, 40, g_SQL_handle);
	            PlayerToys[extraid][3][toy_ry] =    cache_get_row_float(0, 41, g_SQL_handle);
	            PlayerToys[extraid][3][toy_rz] =    cache_get_row_float(0, 42, g_SQL_handle);
	            PlayerToys[extraid][3][toy_sx] =    cache_get_row_float(0, 43, g_SQL_handle);
	            PlayerToys[extraid][3][toy_sy] =    cache_get_row_float(0, 44, g_SQL_handle);
	            PlayerToys[extraid][3][toy_sz] =    cache_get_row_float(0, 45, g_SQL_handle);

	            // Toy slot 5
 	            PlayerToys[extraid][4][toy_model] = cache_get_row_int(0, 46, g_SQL_handle);
	            PlayerToys[extraid][4][toy_bone] = 	cache_get_row_int(0, 47, g_SQL_handle);
	            PlayerToys[extraid][4][toy_x] =     cache_get_row_float(0, 48, g_SQL_handle);
	            PlayerToys[extraid][4][toy_y] =     cache_get_row_float(0, 49, g_SQL_handle);
	            PlayerToys[extraid][4][toy_z] =     cache_get_row_float(0, 50, g_SQL_handle);
	            PlayerToys[extraid][4][toy_rx] =    cache_get_row_float(0, 51, g_SQL_handle);
	            PlayerToys[extraid][4][toy_ry] =    cache_get_row_float(0, 52, g_SQL_handle);
	            PlayerToys[extraid][4][toy_rz] =    cache_get_row_float(0, 53, g_SQL_handle);
	            PlayerToys[extraid][4][toy_sx] =    cache_get_row_float(0, 54, g_SQL_handle);
	            PlayerToys[extraid][4][toy_sy] =    cache_get_row_float(0, 55, g_SQL_handle);
	            PlayerToys[extraid][4][toy_sz] =    cache_get_row_float(0, 56, g_SQL_handle);
	        }
	    }
        case THREAD_CHECK_IF_TOY_EXIST :
        {
            new rows, fields;
            cache_get_data(rows, fields, g_SQL_handle);
            
            if(rows == 0)
            {
                MySQL_CreatePlayerToy(extraid);
            }
            else
            {
            	new squery[128];
                format(squery, sizeof(squery), "SELECT * FROM `"#TABLE_TOYS"` WHERE `Name` = '%s' LIMIT 1;", __GetName(extraid));
                mysql_function_query(g_SQL_handle, squery, true, "OnQueryFinish", "siii", squery, THREAD_LOAD_TOYS, extraid, g_SQL_handle);
            }
        }
        case THREAD_GOTO_MY_HOUSE :
        {
            new rows, fields;
            cache_get_data(rows, fields, g_SQL_handle);
            
            if(rows > 0)
            {
                new Float:fPOS[3];
                fPOS[0] = cache_get_row_float(0, 0, g_SQL_handle);
                fPOS[1] = cache_get_row_float(0, 1, g_SQL_handle);
                fPOS[2] = cache_get_row_float(0, 2, g_SQL_handle);
                
                SetPlayerPos(extraid, fPOS[0], fPOS[1], floatadd(fPOS[2], 1.0));
                PlayerPlaySound(extraid, 1057, 0.0, 0.0, 0.0);
            }
            else
            {
                LangMSG(extraid, -1, ""er"Invalid houseid!", ""er"Unbekannte houseid!");
            }
        }
        case THREAD_GOTO_MY_PROP :
		{
            new rows, fields;
            cache_get_data(rows, fields, g_SQL_handle);

            if(rows > 0)
            {
                new Float:fPOS[3];
                fPOS[0] = cache_get_row_float(0, 0, g_SQL_handle);
                fPOS[1] = cache_get_row_float(0, 1, g_SQL_handle);
                fPOS[2] = cache_get_row_float(0, 2, g_SQL_handle);

                SetPlayerPos(extraid, fPOS[0], fPOS[1], floatadd(fPOS[2], 1.0));
                PlayerPlaySound(extraid, 1057, 0.0, 0.0, 0.0);
            }
			else
			{
				LangMSG(extraid, -1, ""er"Invalid business id!", ""er"Unbekannte Business id!");
			}
		}
        case THREAD_FETCH_GANG_MEMBER_NAMES:
        {
            new rows, fields;
            cache_get_data(rows, fields, g_SQL_handle);

			if(rows > 0)
			{
			    new tmpstring[2048],
			        count = 0,
			        finstring[sizeof(tmpstring) + 300];
            
				for(new i = 0; i < rows; i++)
				{
					new result[MAX_PLAYER_NAME],
					    tmp[MAX_PLAYER_NAME + 20];
					    
					cache_get_row(i, 0, result, g_SQL_handle, sizeof(result));
					
					format(tmp, sizeof(tmp), "\n%i. %s", count + 1, result);
					strcat(tmpstring, tmp);
					count++;
				}
				format(finstring, sizeof(finstring), "There are "yellow"%i"white" members in this gang\n"green"All Members:"white"", count);
				strcat(finstring, tmpstring);

				ShowPlayerDialog(extraid, GANGMEM_DIALOG, DIALOG_STYLE_LIST, ""orange"Gang Members", finstring, "OK", "");
            }
        }
		case THREAD_FETCH_GANG_INFO:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);
		    
		    if(rows > 0)
			{
			    new gangname[MAX_GANG_NAME],
	    			gangtag[4],
					leader[MAX_PLAYER_NAME],
					score,
					udate,
					count = 0,
					members[1536],
					string[2048];

				cache_get_row(0, 1, gangname, g_SQL_handle, sizeof(gangname));
				cache_get_row(0, 2, gangtag, g_SQL_handle, sizeof(gangtag));
				cache_get_row(0, 3, leader, g_SQL_handle, sizeof(leader));
				score = cache_get_row_int(0, 4, g_SQL_handle);
				udate = cache_get_row_int(0, 5, g_SQL_handle);
				
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    if(IsPlayerNPC(i) || !IsPlayerConnected(i)) continue;
				    if(PlayerInfo[i][IsInGang] == 0) continue;
				    if(PlayerInfo[i][GangID] != PlayerInfo[extraid][GangID]) continue;
				    if(count <= 20)
				    {
				        new tmp[MAX_PLAYER_NAME + 16];
				        format(tmp, sizeof(tmp), "\n{%06x}%s(%i)", GetPlayerColor(i) >>> 8, __GetName(i), i);
				        strcat(members, tmp);
				    }
				    count++;
				}

				if(count > 20)
				{
					format(string, sizeof(string),
					""white"Gang name:\t"orange"%s\n"white"Gang tag:\t"orange"%s\n"white"Gang leader:\t"orange"%s\n"white"Gang created:\t"orange"%s\n"white"Gang score:\t"orange"%i\n"white"Users online:\t"orange"%i\n\n"white"Online:%s\n"white"[... to many online]", gangname, gangtag, leader, UnixTimeToDate(udate), score, count, members);
				}
				else
				{
				    format(string, sizeof(string),
					""white"Gang name:\t"orange"%s\n"white"Gang tag:\t"orange"%s\n"white"Gang leader:\t"orange"%s\n"white"Gang created:\t"orange"%s\n"white"Gang score:\t"orange"%i\n"white"Users online:\t"orange"%i\n\n"white"Online:%s", gangname, gangtag, leader, UnixTimeToDate(udate), score, count, members);
				}

				ShowPlayerDialog(extraid, GANGINFO_DIALOG, DIALOG_STYLE_MSGBOX, " ", string, "OK", "");
		    }
		}
        case THREAD_CHECK_IP:
        {
            new rows, fields;
            cache_get_data(rows, fields, g_SQL_handle);
            
            if(rows == 0)
            {
                MySQL_ExistAccount(extraid);
            }
            else
			{
	 		   	SendClientMessage(extraid, -1, ""server_sign" You have been banned.");
	 		   	PlayerPlaySound(extraid, 1184, 0.0, 0.0, 0.0);
	 		   	TextDrawHideForPlayer(extraid, TXTLoading);
       			KickEx(extraid);
			}
		}
		case THREAD_DELETE_VEH:
		{
			PlayerInfo[extraid][BuyAbleVeh] = 0;
			if(PlayerInfoVeh[extraid][Neon1] != -1)
			{
				DestroyDynamicObject(PlayerInfoVeh[extraid][Neon1]);
				PlayerInfoVeh[extraid][Neon1] = -1;
			}
			if(PlayerInfoVeh[extraid][Neon2] != -1)
			{
				DestroyDynamicObject(PlayerInfoVeh[extraid][Neon2]);
				PlayerInfoVeh[extraid][Neon2] = -1;
			}
			if(PlayerInfo[extraid][PV_Vehicle] != -1)
			{
			    DestroyDynamic3DTextLabel(PlayerInfo[extraid][PV_3DLabel]);
				DestroyVehicle(PlayerInfo[extraid][PV_Vehicle]);
				PlayerInfo[extraid][PV_Vehicle] = -1;
			}
		    PlayerInfoVeh[extraid][Model] = -1;
	        PlayerInfoVeh[extraid][PaintJob] = -1;
	        PlayerInfoVeh[extraid][Color1] = 0;
	        PlayerInfoVeh[extraid][Color2] = 0;
	        strmid(PlayerInfoVeh[extraid][Plate], "---", 0, 13, 13);
		    PlayerInfoVeh[extraid][Mod1] = 0;
		    PlayerInfoVeh[extraid][Mod2] = 0;
		    PlayerInfoVeh[extraid][Mod3] = 0;
		    PlayerInfoVeh[extraid][Mod4] = 0;
		    PlayerInfoVeh[extraid][Mod5] = 0;
		    PlayerInfoVeh[extraid][Mod6] = 0;
		    PlayerInfoVeh[extraid][Mod7] = 0;
		    PlayerInfoVeh[extraid][Mod8] = 0;
		    PlayerInfoVeh[extraid][Mod9] = 0;
		    PlayerInfoVeh[extraid][Mod10] = 0;
		    PlayerInfoVeh[extraid][Mod11] = 0;
		    PlayerInfoVeh[extraid][Mod12] = 0;
		    PlayerInfoVeh[extraid][Mod13] = 0;
		    PlayerInfoVeh[extraid][Mod14] = 0;
		    PlayerInfoVeh[extraid][Mod15] = 0;
		    PlayerInfoVeh[extraid][Mod16] = 0;
		    PlayerInfoVeh[extraid][Mod17] = 0;
	        PlayerInfoVeh[extraid][Neon1] = -1;
	        PlayerInfoVeh[extraid][Neon2] = -1;
			GivePlayerCash(extraid, floatround(PlayerInfoVeh[extraid][Price] / 4));
			PlayerInfoVeh[extraid][Price] = -1;
			MySQL_SavePlayer(extraid);
			SendInfo(extraid, "~r~~h~You sold your vehicle!", 4000);
		}
		case THREAD_BUY_VEHICLE :
		{
		    PlayerInfo[extraid][BuyAbleVeh] = 1;
		    MySQL_SavePlayer(extraid);
		    MySQL_SavePlayerVeh(extraid);
		}
		case THREAD_CREATE_GANG:
		{
			PlayerInfo[extraid][IsInGang] = 2;
			PlayerInfo[extraid][GangID] = mysql_insert_id();

            GivePlayerCash(extraid, -1000000);

            MySQL_SavePlayer(extraid);

			new
				string[128],
				gstring[128];

			format(string, sizeof(string), ""orange"* "white"%s has created a new gang: '"orange"%s"white"'", __GetName(extraid), PlayerInfo[extraid][GangName]);
			format(gstring, sizeof(gstring), ""orange"* "white"%s hat soeben eine neue Gang erstellt: '"orange"%s"white"'", __GetName(extraid), PlayerInfo[extraid][GangName]);
            LangMSGToAll(-1, string, gstring);

            ShowPlayerDialog(extraid, 5004, DIALOG_STYLE_MSGBOX, ""white"Gang created!", ""white"You can now use following commands:\n\n/gmenu\n/ginvite\n/gkick\n/gclose", "OK", "");

			format(string, sizeof(string), ""orange"Gang:"white" %s", PlayerInfo[extraid][GangName]);
			PlayerInfo[extraid][GangLabel] = CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, extraid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
		}
        case THREAD_IS_BANNED:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);
		    
		    if(rows > 0)
		    {
		        MySQL_LoadBanStats(extraid);
		    }
		    else
		    {
	    		SetPlayerColor(extraid, PlayerColors[random(sizeof(PlayerColors))]);
                MySQL_CheckPlayerIP(extraid);
		    }
		}
		case THREAD_LOAD_BAN_STAT:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);
		    
		    if(rows > 0)
		    {
		        new string[512],
		            adminname[MAX_PLAYER_NAME],
		            reason[128],
		            udate;
		            
				cache_get_row(0, 0, adminname, g_SQL_handle, sizeof(adminname));
				cache_get_row(0, 1, reason, g_SQL_handle, sizeof(reason));
				udate = cache_get_row_int(0, 2, g_SQL_handle);
				
				TextDrawHideForPlayer(extraid, TXTLoading);
				
		        format(string, sizeof(string), ""red"You have been banned!"white"\n\nAdmin: \t\t%s\nYour name: \t%s\nReason: \t%s\nDate: \t\t%s\n\nIf you think that you have been banned wrongly,\nwrite a ban appeal on forum.ng-stunting.net", adminname, __GetName(extraid), reason, UnixTimeToDate(udate));
				ShowPlayerDialog(extraid, BAN_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"Notice", string, "OK", "");
				PlayerPlaySound(extraid, 1184, 0.0, 0.0, 0.0);
				KickEx(extraid);
		    }
		}
	 	case THREAD_ACCOUNT_EXIST:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);
		    
		    if(rows == 0)
		    {
		    	SetTimerEx("LangSel", 2500, false, "i", extraid);
		    }
		    else
		    {
				SetTimerEx("loginDIALOG", 2500, false, "i", extraid);
				SetTimerEx("loginCAM", 2500, false, "i", extraid);
		    }
		}
		case THREAD_LOADPLAYER:
		{
		    mysql_store_result();
		    if(mysql_num_rows(g_SQL_handle) > 0)
			{
			    new
					resultline[2048],
					money,
					score,
					itmp,
					itmp2,
					string0[40],
					string1[40],
					string2[30];

				mysql_fetch_row_format(resultline);

                mysql_free_result();

			    sscanf(resultline, "p<|>is[25]is[33]s[17]iiiiiiiiiiiiiiiiis[21]s[5]iiiiiiiii",
				    PlayerInfo[extraid][GlobalID],
				    string0,
				    itmp,
				    string1,
				    string2,
					PlayerInfo[extraid][Lang],
	                PlayerInfo[extraid][Level],
	                score,
	                money,
	                PlayerInfo[extraid][Bank],
	                PlayerInfo[extraid][Kills],
	                PlayerInfo[extraid][Deaths],
	                PlayerInfo[extraid][hours],
	                PlayerInfo[extraid][mins],
	                PlayerInfo[extraid][secs],
	                PlayerInfo[extraid][Reaction],
	                PlayerInfo[extraid][PayDay],
	                PlayerInfo[extraid][Houses],
	                PlayerInfo[extraid][Props],
	                PlayerInfo[extraid][PropEarnings],
	                PlayerInfo[extraid][IsInGang],
  	              	PlayerInfo[extraid][GangID],
	                PlayerInfo[extraid][GangName],
	                PlayerInfo[extraid][GangTag],
	                PlayerInfo[extraid][BuyAbleVeh],
	                itmp2,
	                PlayerInfo[extraid][DerbyWins],
	                PlayerInfo[extraid][RaceWins],
	                PlayerInfo[extraid][BGWins],
	                PlayerInfo[extraid][FalloutWins],
	                PlayerInfo[extraid][GungameWins],
	                PlayerInfo[extraid][Wanteds],
					PlayerInfo[extraid][RegDate]);

			 	_SetPlayerScore(extraid, score);
			 	GivePlayerCash(extraid, money);

			 	PlayerInfo[extraid][tPayDay] = SetTimerEx("payday", 60000, true, "i", extraid);
			 	PlayerInfo[extraid][ConnectTime] = gettime();
			 	PlayerInfo[extraid][tPlayer] = SetTimerEx("PlayerUpdate", 1000, true, "i", extraid);
			 	
			 	SendWelcomeMSG(extraid);

				if(PlayerInfo[extraid][BuyAbleVeh] == 1)
				{
					MySQL_LoadPlayerVeh(extraid);
				}
				if(PlayerInfo[extraid][IsInGang] != 0)
				{
				    format(resultline, sizeof(resultline), ""orange"Gang:"white" %s", PlayerInfo[extraid][GangName]);
    				PlayerInfo[extraid][GangLabel] = CreateDynamic3DTextLabel(resultline, -1, 0.0, 0.0, 0.5, 20.0, extraid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
				}
				if(PlayerInfo[extraid][Level] > 0)
				{
					format(resultline, sizeof(resultline), ""server_sign" Successfully logged in. (Adminlevel %i)", PlayerInfo[extraid][Level]);
					SendClientMessage(extraid, -1, resultline);
		   		}
		   		else LangMSG(extraid, -1, ""server_sign" Successfully logged in!", ""server_sign" Erfolgreich eingeloggt!");
		   		
		   		if(PlayerInfo[extraid][RegDate] < 1200000000) // falls sscanf verrückt .....
		   		{
					LangMSG(extraid, RED, "Error while loading your account!!!", "Fehler beim Laden deines Accounts!!!");
					PlayerInfo[extraid][ExitType] = 1;
					KickEx(extraid);
		   		}
    		}
    		else
			{
	    		mysql_free_result();
    		}
		}
		case THREAD_KICK_FROM_GANG:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);

	  		if(rows > 0)
		    {
		        MySQL_FinalGangKick(extraid);
			}
			else
			{
				LangMSG(extraid, -1, ""er"This player is not in your gang!", ""er"Spieler nicht in deiner Gang");
				strmid(PlayerInfo[extraid][GangKickMem], "", 0, 25, 25);
			}
		}
		case THREAD_KICK_FROM_GANG_2:
		{
		    new string[128],
				gstring[128];

		    format(string, sizeof(string), ""gang_sign" %s has been kicked from the gang", PlayerInfo[extraid][GangKickMem]);
		    format(gstring, sizeof(gstring), ""gang_sign" %s wurde aus der Gang gekickt", PlayerInfo[extraid][GangKickMem]);
			GangMSG(PlayerInfo[extraid][GangID], string, gstring);

			strmid(PlayerInfo[extraid][GangKickMem], "", 0, 25, 25);
		}
		case THREAD_CHECK_PLAYER_PASSWD:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);
		
	  		if(rows > 0)
		    {
		        MySQL_LoadPlayer(extraid);
		        MySQL_LogPlayerIn(extraid);
		        MySQL_LoadPlayerToys(extraid);
		        PlayerInfo[extraid][AllowSpawn] = true;
                PlayerInfo[extraid][ExitType] = 2;
	  			TogglePlayerSpectating(extraid, false);
				InterpolateCameraPos(extraid, 352.937377, -1813.479492, 39.280658, 390.257812, -1808.886718, 18.014354, 800, CAMERA_MOVE);
				InterpolateCameraLookAt(extraid, 351.274230, -1816.356323, 37.054042, 386.991821, -1811.187500, 17.814441, 800, CAMERA_MOVE);
			}
			else
			{
		    	SendClientMessage(extraid, -1, ""er"Login failed! Incorrect password");
		    	PlayerInfo[extraid][FailLogin]++;
				if(PlayerInfo[extraid][FailLogin] == MAX_FAIL_LOGINS)
				{
					Kick(extraid);
				}
				else
				{
				    return LoginFailDialog(extraid);
				}
			}
		}
		case THREAD_CREATE_ACCOUNT:
		{
		    SendWelcomeMSG(extraid);
		    GameTextForPlayer(extraid, "Welcome", 3000, 4);
		    MySQL_CreatePlayerToy(extraid);
		    PlayerInfo[extraid][AllowSpawn] = true;
			TogglePlayerSpectating(extraid, false);
			PlayerInfo[extraid][ExitType] = 2;
			PlayerInfo[extraid][PayDay] = 60;
			PlayerInfo[extraid][tPayDay] = SetTimerEx("payday", 60000, true, "i", extraid);
			PlayerInfo[extraid][tPlayer] = SetTimerEx("PlayerUpdate", 1000, true, "i", extraid);
			PlayerInfo[extraid][ConnectTime] = gettime();
	  		GivePlayerCash(extraid, 5000);
	    	GameTextForPlayer(extraid, "+$5,000~n~Startcash", 3000, 1);
			LangMSG(extraid, -1, ""server_sign" You are now registered, and have been logged in!", ""server_sign" Du hast dich registriert und wurdest eingeloggt!");
			InterpolateCameraPos(extraid, 352.937377, -1813.479492, 39.280658, 390.257812, -1808.886718, 18.014354, 800, CAMERA_MOVE);
			InterpolateCameraLookAt(extraid, 351.274230, -1816.356323, 37.054042, 386.991821, -1811.187500, 17.814441, 800, CAMERA_MOVE);
			PlayerPlaySound(extraid, 1057, 0.0, 0.0, 0.0);
			MySQL_SavePlayer(extraid);
			MySQL_LogPlayerIn(extraid);
		}
		case THREAD_LOADPLAYERVEH:
		{
		    mysql_store_result();
		    if(mysql_num_rows(g_SQL_handle) > 0)
			{
			    new
					resultline[512],
					itmp,
					stringtmp[30];

				mysql_fetch_row_format(resultline);
                mysql_free_result();
			    sscanf(resultline, "p<|>is[25]iiiiis[13]iiiiiiiiiiiiiiiii",
			        itmp,
			        stringtmp,
				    PlayerInfoVeh[extraid][Model],
	                PlayerInfoVeh[extraid][Price],
	                PlayerInfoVeh[extraid][PaintJob],
	                PlayerInfoVeh[extraid][Color1],
	                PlayerInfoVeh[extraid][Color2],
	                PlayerInfoVeh[extraid][Plate],
	                PlayerInfoVeh[extraid][Mod1],
	                PlayerInfoVeh[extraid][Mod2],
	                PlayerInfoVeh[extraid][Mod3],
	                PlayerInfoVeh[extraid][Mod4],
	                PlayerInfoVeh[extraid][Mod5],
	                PlayerInfoVeh[extraid][Mod6],
	                PlayerInfoVeh[extraid][Mod7],
	                PlayerInfoVeh[extraid][Mod8],
	                PlayerInfoVeh[extraid][Mod9],
	                PlayerInfoVeh[extraid][Mod10],
	                PlayerInfoVeh[extraid][Mod11],
	                PlayerInfoVeh[extraid][Mod12],
	                PlayerInfoVeh[extraid][Mod13],
	                PlayerInfoVeh[extraid][Mod14],
	                PlayerInfoVeh[extraid][Mod15],
	                PlayerInfoVeh[extraid][Mod16],
	                PlayerInfoVeh[extraid][Mod17]);
			}
			else
			{
			    mysql_free_result();
			}
	 	}
	 	case THREAD_GANG_EXIST:
	 	{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);
		    
			if(rows == 0)
	 		{
				MySQL_CreateGang(extraid);
			}
			else
			{
			    CancelGangCreation(extraid);
			    LangMSG(extraid, -1, ""er"This Gang already exist, please choose another gangname", ""er"Der Gangname existiert schon bitte wähle einen anderen");
			}
		}
		case THREAD_RACE_TOPLIST:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);
		    
		    if(rows > 0)
		    {
			    new minute,
					sec,
					msec,
					name[25],
					time,
					string[128];
					
				for(new i = 0; i < rows; i++)
				{
					cache_get_row(i, 0, name, g_SQL_handle, sizeof(name));
					time = cache_get_row_int(i, 1, g_SQL_handle);
					ConvertTime(var, time, minute, sec, msec);
					format(string, sizeof(string), ""orange"%i. "green"%s "orange"- "white"%02i:%02i.%03i", i + 1, name, minute, sec, msec);
					SendClientMessage(extraid, -1, string);
				}
		    }
		    else
		    {
		        LangMSG(extraid, -1, ""vgreen"» No race records available", ""vgreen"» Keine Race-Rekorde vorhanden");
		    }
		}
		case THREAD_RACE_FINISH:
		{
			new maxid,
				string[200];
			maxid = mysql_insert_id();
			format(string, sizeof(string), "SELECT `name`, `time`, `id` FROM `"#TABLE_RACE"` WHERE `track` = '%s' ORDER BY `time` ASC LIMIT 6;", RaceName); // 6 , da vllt Platz 5 belegt und somit 6 verdrängt // versteh ich nicht
			mysql_function_query(g_SQL_handle, string, false, "OnQueryFinish", "siii", string, THREAD_RACE_LATEST, maxid, g_SQL_handle);
		}
		case THREAD_RACE_LATEST:
		{
		    new order,
		        resultline[200],
		        id,
		        name[25],
		        minute,
		        sec,
		        msec,
		        time;

	 	    mysql_store_result();

	 	    while(mysql_fetch_row_format(resultline))
	 		{
		 	    sscanf(resultline, "p<|>s[25]ii", name, time, id);
	 	        ++order;
		 	    if(extraid == id)
			 	{
			 	    new str[144];
					ConvertTime(var, time, minute, sec, msec);
		 	        if(order == 1)
				 	{
				 	    format(str, sizeof(str), ""race_sign" %s hit a new record on %s with %02i:%02i.%03i", name, RaceName, minute, sec, msec);
			 	        format(resultline, sizeof(resultline), ""race_sign" %s hat einen neuen Streckenrekord auf %s mit %02i:%02i.%03i aufgestellt", name, RaceName, minute, sec, msec);
						LangMSGToAll(-1, str, resultline);
						
						if(mysql_fetch_row_format(resultline))
						{
						    new record_sec,
						        record_msec,
						        record_minute,
						        oldtime;

					 	    sscanf(resultline, "p<|>s[25]ii", name, oldtime, id);
					 	    ConvertTime(var0, oldtime, minute, sec, msec);
					 	    oldtime -= time;
					 	    ConvertTime(var1, oldtime, record_minute, record_sec, record_msec);
					 	    
					 	    format(str, sizeof(str), ""race_sign" The old record by %s with %02i:%02i.%03i has been improved by %02i:%02i.%03i", name, minute, sec, msec, record_minute, record_sec, record_msec);
							format(resultline, sizeof(resultline), ""race_sign" Der alte Rekord von %s mit %02i:%02i.%03i wurde um %02i:%02i.%03i verbessert", name, minute, sec, msec, record_minute, record_sec, record_msec);
							LangMSGToAll(-1, str, resultline);
						}
						break;
		 	        }
		 	        else
				 	{
				 	    format(str, sizeof(str), ""race_sign" %s reached on %s place %i with %02i:%02i.%03i", name, RaceName, order, minute, sec, msec);
			 	        format(resultline, sizeof(resultline), ""race_sign" %s hat sich auf %s in die Toplist auf Platz %i gefahren mit %02i:%02i.%03i", name, RaceName, order, minute, sec, msec);
						LangMSGToAll(-1, str, resultline);
						
						if(mysql_fetch_row_format(resultline))
						{
						    new record_sec,
						        record_msec,
						        record_minute,
						        oldtime;

					 	    sscanf(resultline, "p<|>s[25]ii", name, oldtime, id);
					 	    ConvertTime(unused0, oldtime, minute, sec, msec);
					 	    oldtime -= time;
					 	    ConvertTime(unused1, oldtime, record_minute, record_sec, record_msec);
					 	    
					 	    format(str, sizeof(str), ""race_sign" The old record by %s with %02i:%02i.%03i has been improved by %02i:%02i.%03i", name, minute, sec, msec, record_minute, record_sec, record_msec);
							format(resultline, sizeof(resultline), ""race_sign" Der alte Rekord von %s mit %02i:%02i.%03i wurde um %02i:%02i.%03i verbessert", name, minute, sec, msec, record_minute, record_sec, record_msec);
							LangMSGToAll(-1, str, resultline);
						}
		 	            break;
		 	        }
		 	    }
	 	    }
			mysql_free_result();
		}
	}
	return 1;
}

public OnQueryError(errorid, error[], callback[], query[], connectionHandle)
{
	printf("[MYSQL ERROR]: %i, %s, %s, %s, %i", errorid, error, callback, query, connectionHandle);
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) &&	GetPlayerState(i) == PLAYER_STATE_SPECTATING && PlayerInfo[i][SpecID] == playerid)
   		{
   		    SetPlayerInterior(i, newinteriorid);
		}
	}
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

	if(pickupid == pick_chainsaw)
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
		GivePlayerWeapon(playerid, 9, 1);
	}
	else if(pickupid == pick_life[0])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[1])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[2])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[3])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[4])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[5])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[6])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[7])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[8])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[9])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[10])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[11])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
		SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == pick_life[12])
	{
	    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
	    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
	    SetPlayerHealth(playerid, 100.0);
	}
	else if(pickupid == AdminLC2)
	{
		SetPlayerPos(playerid, 1803.2450,-1303.0396,120.2659);
		SetPlayerInterior(playerid, 0);
	}
	else if(pickupid == AdminLC)
	{
	    SetPlayerPos(playerid,-791.0734,497.6924,1376.1953);
	    SetPlayerInterior(playerid, 1);
	}
	else if(pickupid == aussenrein)
	{
	    SetPlayerInterior(playerid, 15);
	    SetPlayerPosEx(playerid, -1405.5538, 989.1526, floatadd(1049.0078, 3.0));
		ResetPlayerWeapons(playerid);
		gTeam[playerid] = BUYCAR;
	}
	else if(pickupid == innenraus)
	{
		SetPlayerInterior(playerid, 0);
	    SetPlayerPosEx(playerid, 1798.0952, -1410.8192, floatadd(13.5458, 3.0));
	    RandomWeapon(playerid);
		gTeam[playerid] = NORMAL;
	}
	else if(pickupid == vehiclebuy)
	{
		if(PlayerInfo[playerid][BuyAbleVeh] == 1)
		{
			return LangMSG(playerid, RED, ""er"You already own a vehicle", ""er"Du besitzt bereits ein Fahrzeug");
		}
		StopAudioStreamForPlayer(playerid);
		SetPlayerVirtualWorld(playerid, playerid + 101);
		SetPlayerCameraPos(playerid,-1407.6005,1021.9415,1051.4486);
		SetPlayerCameraLookAt(playerid, -1407.9410,1022.4058,1051.1681);
		SetPlayerPos(playerid, -1409.6410, 1032.6376, 1049.0288);
		TogglePlayerControllable(playerid, false);
		ShowDialog(playerid, CARBUY_DIALOG);
	}
	else if(pickupid == dm1pickup)
	{
		new currentveh, Float:angle;
	  	currentveh = GetPlayerVehicleID(playerid);
	  	SetVehiclePos(currentveh, -3945.3562,963.2668,36.3281);
		GetVehicleZAngle(currentveh, angle);
		SetVehicleZAngle(currentveh, angle);
	}
	else if(pickupid == dm2pickup)
	{
		new currentveh, Float:angle;
	  	currentveh = GetPlayerVehicleID(playerid);
	  	SetVehiclePos(currentveh, -3951.6909,968.0073,65.6281);
		GetVehicleZAngle(currentveh, angle);
		SetVehicleZAngle(currentveh, angle);
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	if(!success)
 	{
  		printf(">> FAILED RCON LOGIN BY IP %s USING PASSWORD %s", ip, password);
  		new pip[16];

		for(new i = 0; i < MAX_PLAYERS; i++)
    	{
     		GetPlayerIp(i, pip, sizeof(pip));
       		if(!strcmp(ip, pip, true))
         	{
         	    new string[128];
				format(string, sizeof(string), "*** %s(%i) tried to login to RCON with password %s  IP: %s", __GetName(i), i, password, ip);
				AdminMSG(RED, string);
				break;
			}
   		}
   	}
    return 1;
}

public OnPlayerUpdate(playerid)
{
    PlayerInfo[playerid][tickPlayerUpdate] = GetTickCount() + 3600000;

    if(gTeam[playerid] == DERBY)
    {
        UpdateHP(playerid);
    }
    else if(gTeam[playerid] == GUNGAME)
    {
		if(!GunGame_Player[playerid][dead])
		{
			if(!GetPlayerWeapon(playerid))
			{
				if(GunGame_Player[playerid][pw])
				{
					SetPlayerArmedWeapon(playerid, 4);
					GunGame_Player[playerid][pw] = false;
				}
				else
				{
				    SetPlayerArmedWeapon(playerid, GunGame_Weapons[GunGame_Player[playerid][level]]);
					GunGame_Player[playerid][pw] = true;
				}
			}
			else GunGame_Player[playerid][pw] = GetPlayerWeapon(playerid) == 4 ? false : true;
		}
    }
    else if(gTeam[playerid] == NORMAL)
    {
        new weap = GetPlayerWeapon(playerid);
        if(weap == 38 || weap == 36 || weap == 35)
        {
            ResetPlayerWeapons(playerid);
        }
    }
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(gTeam[playerid] == DERBY)
	{
		cmd_exit(playerid, "");
	}
	else if(gTeam[playerid] == RACE)
	{
	    cmd_exit(playerid, "");
	}

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
    	if(GetPlayerState(i) == PLAYER_STATE_SPECTATING && PlayerInfo[i][SpecID] == playerid)
		{
        	TogglePlayerSpectating(i, true);
	        PlayerSpectatePlayer(i, playerid);
    	    PlayerInfo[i][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(!PlayerInfo[playerid][Logged])
	{
	    SendClientMessage(playerid, GREY, ""er"You need to spawn to use the chat!");
	    return 0;
	}

	if(GlobalMain)
	{
	    SendClientMessage(playerid, GREY, ""er"Please log out now!");
	    return 0;
	}

    new File:lFile = fopen("Logs/chatlog.txt", io_append),
     	logData[255],
        time[3];

    gettime(time[0], time[1], time[2]);

    format(logData, sizeof(logData), "[%02d:%02d:%02d] %s(%i): %s \r\n", time[0], time[1], time[2], __GetName(playerid), playerid, text);
    fwrite(lFile, logData);
    fclose(lFile);

	new
		is1 = 0,
		r = 0,
		strR[255];

 	while(strlen(text[is1]))
 	{
  		if('0' <= text[is1] <= '9')
  		{
 			new is2 = is1 + 1, p=0;

			while(p == 0)
  			{
   				if('0' <= text[is2] <= '9' && strlen(text[is2]))
		   		{
				   is2++;
				}
 				else
  				{
				   	strmid(strR[r], text, is1, is2, sizeof(strR));
				   	if(strval(strR[r]) < sizeof(strR)) r++;
				    is1 = is2;
				    p = 1;
				}
			}
		}
 		is1++;
 	}
	if(r >= 4)
	{
		new string[255];
	  	format(string, sizeof(string), ""yellow"** "red"Suspicion advertising | Player: %s(%i) Advertised IP: %s - PlayerIP: %s", __GetName(playerid), playerid, text, __GetIP(playerid));
		AdminMSG(RED, string);

        SendClientMessage(playerid, RED, "Advertising is not allowed!");
        return 0;
	}

	if(xTestBusy)
	{
		if(!strcmp(xChars, text, false) && ReactionOn)
		{
            ReactionOn = false;

		    new
		        string[128],
		        gstring[128];

			format(string, sizeof(string), "["vlila"REACTION"white"]: %s has won the reaction test!", __GetName(playerid));
			format(gstring, sizeof(gstring), "["vlila"REACTION"white"]: %s hat den Reaktionstest gewonnen!", __GetName(playerid));
		    LangMSGToAll(WHITE, string, gstring);

		    format(string, sizeof(string), "» You have earned $%i + %i score.", xCash, xScore);
		    format(gstring, sizeof(gstring), "» Du hast $%i und %i Score gewonnen.", xCash, xScore);
		    LangMSG(playerid, GREEN, string, gstring);

			GivePlayerCash(playerid, xCash);

		    PlayerInfo[playerid][Reaction]++;
			_GivePlayerScore(playerid, xScore);
			tReactionTimer = SetTimer("xReactionTest", REAC_TIME, true);
		    xTestBusy = false;
		    return 0;
		}
		else if(text[0] == '7')
		{
			LangMSG(playerid, ORANGE, "Whoops... type it again...", "Hoppla... schreibs nocheinmal...");
	  		return 0;
		}
	}

	if(PlayerInfo[playerid][Muted])
	{
	    LangMSG(playerid, RED, "You hvae been muted! Please wait until the time is over!", "Du wurdest gemuted bitte warte bis die Zeit um ist");
	    return 0;
	}
	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][onduty] && text[0] == '#')
	{
	    new msgstring[144];
		format(msgstring, sizeof(msgstring), ""white"["red"ADMIN CHAT"white"] {%06x}%s"white"(%i): %s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, text[1]);
		AdminMSG(GREEN, msgstring);
	    return 0;
	}
	if(text[0] == '#' && PlayerInfo[playerid][Level] >= 1)
	{
	    new msgstring[144];
		format(msgstring, sizeof(msgstring), ""white"["red"ADMIN CHAT"white"] {%06x}%s"white"(%i): %s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, text[1]);
		AdminMSG(GREEN, msgstring);
		return 0;
	}

    new
		tick = GetTickCount() + 3600000;

	if((PlayerInfo[playerid][ChatWrote] >= 2) && ((PlayerInfo[playerid][tickLastChat] + COOLDOWN_CHAT) >= tick))
	{
		LangMSG(playerid, RED, ""er"Wait a bit before chatting again", ""er"Du musst noch etwas warten bis du wieder chatten kannst");
	    return 0;
	}
	else if((PlayerInfo[playerid][ChatWrote] >= 2) && ((PlayerInfo[playerid][tickLastChat] + COOLDOWN_CHAT) <= tick))
	{
        PlayerInfo[playerid][ChatWrote] = 0;
        PlayerInfo[playerid][tickLastChat] = tick;
	}
	else
	{
	    PlayerInfo[playerid][ChatWrote]++;
	}

	if(text[0] == '7' && !ReactionOn)
	{
		LangMSG(playerid, ORANGE, "Whoops... type it again...", "Hoppla... schreibs nocheinmal...");
  		return 0;
	}

	if(text[0] == '!' && PlayerInfo[playerid][IsInGang] != 0)
	{
	    new gstring[144];
		format(gstring, sizeof(gstring), ""white"["orange"GANG CHAT"white"] {%06x}%s"white"(%i): %s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, text[1]);
		GangMSG(PlayerInfo[playerid][GangID], gstring, gstring);
		return 0;
	}
	if(PlayerInfo[playerid][IsInGang] != 0)
	{
		new gtagMSG[255];
		format(gtagMSG, sizeof(gtagMSG), ""grey"%i {%06x}[%s] %s:"white" %s", playerid, GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][GangTag], __GetName(playerid), text);
		SendClientMessageToAll(-1, gtagMSG);

		new cbMSG[150];
		format(cbMSG, sizeof(cbMSG), "%s", text);
		SetPlayerChatBubble(playerid, cbMSG, WHITE, 50.0, 7000);
		return 0;
	}

	new idMSG[144];
	format(idMSG, sizeof(idMSG), ""grey"%i {%06x}%s:"white" %s", playerid, GetPlayerColor(playerid) >>> 8, __GetName(playerid), text);
	SendClientMessageToAll(-1, idMSG);

	new cbMSG[150];
	format(cbMSG, sizeof(cbMSG), "%s", text);
	SetPlayerChatBubble(playerid, cbMSG, WHITE, 50.0, 7000);
	return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerInfo[playerid][IsDead] = true;
	PlayerInfo[playerid][iCoolDownDeath]++;
	SetTimerEx("CoolDownDeath", COOLDOWN_DEATH, false, "i", playerid);
	if(PlayerInfo[playerid][iCoolDownDeath] >= 3)
	{
		return Kick(playerid);
	}
	
	if(PlayerInfo[playerid][Deaths] == 100)
	{
	    GivePlayerCash(playerid, 20000);
	    GameTextForPlayer(playerid, "+$20,000", 3000, 1);
	    SendClientMessage(playerid, YELLOW, "Info: "white"Achievement unlocked! (Die 100 times)");
	}

    SendDeathMessage(killerid, playerid, reason);
	PlayerInfo[playerid][Deaths]++;
	if(BuildRace == playerid + 1) BuildRace = 0;

	if(reason <= 46 && gTeam[killerid] == NORMAL && IsPlayerConnected(killerid) && PlayerInfo[playerid][HitmanHit] > 0)
	{
		new string[128], gstring[128];
		format(string, sizeof(string), "%s(%i) killed %s(%i) and received $%i for a completed hit!", __GetName(killerid), killerid, __GetName(playerid), playerid, PlayerInfo[playerid][HitmanHit]);
		format(gstring, sizeof(gstring), "%s(%i) tötet %s(%i) und erhält $%i dafür!", __GetName(killerid), killerid, __GetName(playerid), playerid, PlayerInfo[playerid][HitmanHit]);
		LangMSGToAll(YELLOW, string, gstring);
		GivePlayerCash(killerid, PlayerInfo[playerid][HitmanHit]);
		PlayerInfo[playerid][HitmanHit] = 0;
	}

	if(IsPlayerAvail(killerid))
	{
		if(PlayerInfo[killerid][Kills] == 100)
		{
		    GivePlayerCash(killerid, 20000);
		    GameTextForPlayer(killerid, "+$20,000", 3000, 1);
		    SendClientMessage(killerid, YELLOW, "Info: "white"Achievement unlocked! (Get 100 kills)");
		}
		PlayerInfo[killerid][Kills]++;
 		GivePlayerCash(playerid, -500);
		GameTextForPlayer(playerid, "~r~-$500", 2000, 1);
	}

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
 		if(GetPlayerState(i) == PLAYER_STATE_SPECTATING && PlayerInfo[i][SpecID] == playerid)
	    {
     		StopSpectate(i);
       		SendInfo(i, "~r~~h~Player died!", 2500);
		}
	}

	switch(gTeam[playerid])
	{
	    case NORMAL :
	    {
	        if(PlayerInfo[playerid][bHasSpawn])
            {
                SetSpawnInfo(playerid, NO_TEAM, GetPlayerSkin(playerid), PlayerInfo[playerid][CSpawnX], PlayerInfo[playerid][CSpawnY], PlayerInfo[playerid][CSpawnZ], PlayerInfo[playerid][CSpawnA], -1, -1, -1, -1, -1, -1);
			}
			else
			{
				new rand = random(4);
				SetSpawnInfo(playerid, NO_TEAM, GetPlayerSkin(playerid), WorldSpawns[rand][0], WorldSpawns[rand][1], floatadd(WorldSpawns[rand][2], 3.0), WorldSpawns[rand][3], -1, -1, -1, -1, -1, -1);
			}
			
	        if(IsPlayerAvail(killerid) && (playerid != killerid) && gTeam[killerid] == NORMAL)
     		{
			    PlayerInfo[killerid][Wanteds]++;

				new
					wstring[64];

				format(wstring, sizeof(wstring), "~w~~h~Wanteds: ~b~~h~%i", PlayerInfo[killerid][Wanteds]);
				PlayerTextDrawSetString(killerid, TXTWanteds[killerid], wstring);

				if(PlayerInfo[playerid][Wanteds] > 2)
				{
					new
						money,
						score,
						string[32];

					money = floatround((1500 * PlayerInfo[playerid][Wanteds]) / 2.5);
					score = floatround((2 * PlayerInfo[playerid][Wanteds]) / 2.5);

					_GivePlayerScore(killerid, score);
					GivePlayerCash(killerid, money);

					format(string, sizeof(string), "+1 Kill~n~+%i Score~n~+$%i", score, money);
					GameTextForPlayer(killerid, string, 2000, 1);
				}
				else
				{
					_GivePlayerScore(killerid, 1);
					GivePlayerCash(killerid, 1100);
					GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,100", 2000, 1);
				}

				PlayerInfo[playerid][Wanteds] = 0;
			  	PlayerTextDrawSetString(playerid, TXTWanteds[playerid], "~w~~h~Wanteds: ~b~~h~0");

			  	// Nur Kills bei NORMAL werten für GangScore
			 	if(PlayerInfo[killerid][IsInGang])
				{
				  	MySQL_UpdateGangScore(PlayerInfo[killerid][GangID], 1);
			 	}
	        }
	    }
		case DERBY :
		{
		    // OPDeath
		    if(bDerbyAFK[playerid])
			{
		        return 1;
		    }
		    
		    if(IsDerbyRunning && DerbyWinner[playerid])
		    {
			    new
					string[64],
					gstring[64];

		    	format(string, sizeof(string), "%s's vehicle has been destroyed!", __GetName(playerid));
		    	format(gstring, sizeof(gstring), "%s's Fahrzeug wurde zerstört!", __GetName(playerid));
				DerbyMSG(string, gstring);

		    	DerbyPlayers--;
		    	DerbyWinner[playerid] = false;
			    if(pDerbyCar[playerid] != -1)
			    {
			    	DestroyVehicle(pDerbyCar[playerid]);
			    	pDerbyCar[playerid] = -1;
				}
		    	DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);
                SetPlayerDerbyStaticMeshes(playerid);
                
		    	if(DerbyPlayers == 1) Derby();
			}
			else
			{
				cmd_exit(playerid, "");
			}
		}
		case RACE :
		{
		    new
				string[64],
				gstring[64];

	    	format(string, sizeof(string), "%s has died!", __GetName(playerid));
	    	format(gstring, sizeof(gstring), "%s ist gestorben!", __GetName(playerid));
			RaceMSG(string, gstring);

			RaceJoinCount--;
			gTeam[playerid] = NORMAL;
			if(PlayerRaceVehicle[playerid] != -1)
			{
				DestroyVehicle(PlayerRaceVehicle[playerid]);
				PlayerRaceVehicle[playerid] = -1;
			}
			DisablePlayerRaceCheckpoint(playerid);
			HidePlayerRaceTextdraws(playerid);
			CPProgess[playerid] = 0;
			ResetPlayerWorld(playerid);
		}
		case FALLOUT :
		{
			new string[100], gstring[100];
			format(string, sizeof(string), "%s died!", __GetName(playerid));
			format(gstring, sizeof(gstring), "%s ist gestorben!", __GetName(playerid));
			FalloutMSG(string, gstring);

		    TogglePlayerControllable(playerid, true);
		    RandomSpawn(playerid);
		    RandomWeapon(playerid);
		    HidePlayerFalloutTextdraws(playerid);
		    ResetPlayerWorld(playerid);
		    CurrentFalloutPlayers--;
            PlayerInfo[playerid][FalloutLost] = true;
            GameTextForPlayer(playerid, "~p~You lost the Fallout!", 3000, 1);
            gTeam[playerid] = NORMAL;

		    new count;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(!IsPlayerAvail(i)) continue;
			    if(gTeam[i] == FALLOUT) count++;
			}

			if(count < 2)
			{
			    KillTimer(Info[I_iTimer][1]);

				for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    if(gTeam[i] == FALLOUT)
				    {
				    	TogglePlayerControllable(i, true);
					    RandomSpawn(i);
					    RandomWeapon(i);
					    HidePlayerFalloutTextdraws(i);
					    ResetPlayerWorld(i);
					    FalloutMSG("Fallout has been canceled!", "Fallout wurde wegen zu wenigen Spielern abgebrochen!");
						gTeam[i] = NORMAL;
				    }
				}
				Fallout_Cancel();
			}
			return true;
	  	}
		case MINIGUN :
		{
		    if(IsPlayerAvail(killerid))
		    {
				_GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1000);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,000", 2000, 1);
		    }
		}
		case SNIPER :
		{
		    if(IsPlayerAvail(killerid))
		    {
				_GivePlayerScore(killerid, 2);
				GivePlayerCash(killerid, 1500);
				GameTextForPlayer(killerid, "+1 Kill~n~+2 Score~n~+$1,500", 2000, 1);
		    }
		}
		case gBG_TEAM1 :
		{
  		    if(IsPlayerAvail(killerid))
		    {
		        BGTeam2Kills++;
		        _GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1500);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,500", 2000, 1);
		    }
		}
		case gBG_TEAM2 :
		{
  		    if(IsPlayerAvail(killerid))
		    {
		        BGTeam1Kills++;
		        _GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1500);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,500", 2000, 1);
		    }
		}
		case DM :
		{
  		    if(IsPlayerAvail(killerid))
		    {
		        _GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1500);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,500", 2000, 1);
		    }
		}
		case GUNGAME :
		{
			GunGame_Player[playerid][dead] = true;

			if(IsPlayerAvail(killerid))
			{
		        _GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1000);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,000", 2000, 1);
			}

			if(killerid == INVALID_PLAYER_ID)
			{
				SetPlayerCameraPos(playerid, 179.2239, 2097.3289, 93.4786);
				SetPlayerCameraLookAt(playerid, 178.3643, 2096.8113, 92.8986);
			}
			else
			{
				if(reason == 4)
				{
					if(GunGame_Player[playerid][level] != 0)
					{
						GunGame_Player[playerid][level]--;
     				    GameTextForPlayer(killerid, "~p~Humiliation!~n~~w~Demoted the player by one rank!", 1850, 6);
						GameTextForPlayer(playerid, "~p~Humiliated~n~~w~You got demoted!", 1850, 6);
					}
				}
			    else
				{
				    GameTextForPlayer(killerid, "~p~Player killed!~n~~w~Advanced to the next tier!", 1850, 6);
				}

				GunGame_Player[killerid][level]++;

				if(GunGame_Player[killerid][level] == 14)
				{
					new
						c,
						g_WinnerName[3][MAX_PLAYER_NAME],
						g_Data[MAX_PLAYERS][e_GunGame];

					for(new i; i < MAX_PLAYERS; i++)
					{
					    g_Data[i][GG_iPlayer] = i;
						if(IsPlayerAvail(i) && gTeam[i] == GUNGAME)
						{
							g_Data[i][GG_iLevel] = GunGame_Player[i][level];
			    		}
						else
						{
						    g_Data[i][GG_iLevel] = -1;
						}
					}
					SortDeepArray(g_Data, GG_iLevel, .order = SORT_DESC);
					for(new i; i < 3 ; i++)
					{
					    if(g_Data[i][GG_iLevel] == -1)
						{
							g_WinnerName[i] = "----";
					    }
					    else
						{
					        c++;
						    GetPlayerName(g_Data[i][GG_iPlayer], g_WinnerName[i], MAX_PLAYER_NAME);
					    }
					}
					
					new gWinners[3];
					for(new i = 0; i < 3; i++)
					{
					    gWinners[i] = __GetPlayerID(g_WinnerName[i]);
					}
					
					if(gWinners[0] < 500)
					{
					    PlayerInfo[gWinners[0]][GungameWins]++;
					    
						if(PlayerInfo[gWinners[0]][GungameWins] == 10)
						{
						    GivePlayerCash(gWinners[0], 20000);
						    GameTextForPlayer(gWinners[0], "+$20,000", 3000, 1);
						    SendClientMessage(gWinners[0], YELLOW, "Info: "white"Achievement unlocked! (Win 10 Gungames)");
						}
					    
						_GivePlayerScore(gWinners[0], 7);
						GivePlayerCash(gWinners[0], 7000);
						GameTextForPlayer(gWinners[0], "+$7,000~n~+7 Score~n~+1 Gungame win", 3000, 1);
					}
					if(gWinners[1] < 500)
					{
						_GivePlayerScore(gWinners[1], 5);
						GivePlayerCash(gWinners[1], 5000);
						GameTextForPlayer(gWinners[1], "+$5,000~n~+5 Score", 3000, 1);
					}
					if(gWinners[2] < 500)
					{
						_GivePlayerScore(gWinners[2], 3);
						GivePlayerCash(gWinners[2], 3000);
						GameTextForPlayer(gWinners[2], "+$3,000~n~+3 Score", 3000, 1);
					}

					new string[144];
     				format(string, sizeof(string), "~p~The match ended!~n~~g~1. %02i - %s~n~~y~2. %02i - %s~n~~w~3. %02i - %s",
	 					g_Data[0][GG_iLevel],
						g_WinnerName[0],
						g_Data[1][GG_iLevel],
						g_WinnerName[1],
						g_Data[2][GG_iLevel],
						g_WinnerName[2]);


					for(new i; i < MAX_PLAYERS; i++)
				    {
						if(IsPlayerAvail(i) && gTeam[i] == GUNGAME)
						{
							GunGame_Player[i][level] = 0;
							ResetPlayerWeapons(i);
							
							if(i != playerid)
							{
								if(GunGamePlayers >= 16) SetPlayerHealth(i, 100.0);
								else SetPlayerHealth(i, ((25) + (5 * GunGamePlayers)));
								GivePlayerWeapon(i, 4, 1);
								GivePlayerWeapon(i, GunGame_Weapons[GunGame_Player[i][level]], 65535);
								GunGame_Player[i][pw] = true;
							}
							
							GameTextForPlayer(i, string, 4500, 3);
						}
					}
	    	    }
		        else
				{
				    ResetPlayerWeapons(killerid);
				    GivePlayerWeapon(killerid, 4, 1);
					GivePlayerWeapon(killerid, GunGame_Weapons[GunGame_Player[killerid][level]], 65535);
					
					if(GunGame_Player[killerid][level] == 13)
					{
						new string[144];
						format(string, sizeof string, "%s reached the last level!", __GetName(killerid));
     				    for(new i; i < MAX_PLAYERS; i++)
					    {
							if(IsPlayerAvail(i) && gTeam[i] == GUNGAME)
							{
		                		GameTextForPlayer(i, string, 2500, 3);
							}
						}
					}
				}
			}
		}
	}
    return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return 1;
	
	if(gTeam[playerid] == RACE)
	{
		if(CPProgess[playerid] == TotalRaceCP - 1)
		{
			new TimeStamp,
			    TotalRaceTime,
			    string[255],
			    pName[MAX_PLAYER_NAME],
				rTime[3],
				Prize[2];

			rPosition++;
			GetPlayerName(playerid, pName, sizeof(pName));
			TimeStamp = GetTickCount() + 3600000;
			TotalRaceTime = TimeStamp - RaceTick;
			ConvertTime(var, TotalRaceTime, rTime[0], rTime[1], rTime[2]);
			switch(rPosition)
			{
			    case 1:
				{
					Prize[0] = (random(random(5000)) + 8000), Prize[1] = 10;
					PlayerInfo[playerid][RaceWins]++;
		
					if(PlayerInfo[playerid][RaceWins] == 10)
					{
					    GivePlayerCash(playerid, 20000);
					    GameTextForPlayer(playerid, "+$20,000", 3000, 1);
					    SendClientMessage(playerid, YELLOW, "Info: "white"Achievement unlocked! (Win 10 Races)");
					}
				}
			    case 2: Prize[0] = (random(random(4000)) + 8000) - 1000, Prize[1] = 9;
			    case 3: Prize[0] = (random(random(3500)) + 7000) - 1000, Prize[1] = 8;
			    case 4: Prize[0] = (random(random(3000)) + 6000) - 1000, Prize[1] = 7;
			    case 5: Prize[0] = (random(random(2500)) + 5000) - 1000, Prize[1] = 6;
			    case 6: Prize[0] = (random(random(2000)) + 4000) - 1000, Prize[1] = 5;
			    case 7: Prize[0] = (random(random(1500)) + 3000) - 1000, Prize[1] = 4;
			    case 8: Prize[0] = (random(random(1000)) + 2000) - 1000, Prize[1] = 3;
			    case 9: Prize[0] = (random(random(500)) + 1000) - 1000, Prize[1] = 2;
			    default: Prize[0] = random(random(250)), Prize[1] = 1;
			}
			format(string, sizeof(string), "» %s has finished the race %i. in %02i:%02i.%03i", pName, rPosition, rTime[0], rTime[1], rTime[2]);
			SendClientMessageToAll(YELLOW, string);
	    	GivePlayerCash(playerid, Prize[0]);
	    	format(string, sizeof(string), "+$%i~n~+%i Score", Prize[0], Prize[1]);
	    	_GivePlayerScore(playerid, Prize[1]);
	    	GameTextForPlayer(playerid, string, 3000, 1);

			if(RaceFinishCount <= 5)
			{
			    // Wenn eh nicht unter den TOP 5,wird seine Zeit eh nicht relevant sein.
			    format(string, sizeof(string), "INSERT INTO `"#TABLE_RACE"` VALUES (NULL, '%s', '%s', %i);", RaceName, pName, TotalRaceTime);
				mysql_query(string, THREAD_RACE_FINISH, playerid, g_SQL_handle);
			}

			RaceFinishCount++;
			GivePlayerCash(playerid, Prize[0]);
			_GivePlayerScore(playerid, Prize[1]);
			DisablePlayerRaceCheckpoint(playerid);
			CPProgess[playerid]++;
			
			if(RaceJoinCount <= 2)
			{ // Kleiner gleich 2 Fahrer
   				StopRace();
			}
			else
			{ // Mehr als 2 Fahrer
				SetTimerEx("TogglePlayerControllableEx", 373, false, "ii", playerid, 0);
				if(rPosition == 1)
				{
				    iRaceEnd = 30 + 1;
				    SetTimer("Race_End", 1000, false);
				}
				else
				{
					if(RaceFinishCount >= RaceJoinCount) return SetTimer("StopRace", 503, false);
				}
			}
	    }
		else
		{
			CPProgess[playerid]++;
			CPCoords[CPProgess[playerid]][3]++;
		    SetCP(playerid, CPProgess[playerid], CPProgess[playerid] + 1, TotalRaceCP, RaceType);
		    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
		}
	}
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
    
 	if(!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
	    new file[50];
   		for(new b = 0; b < MAX_BANKS; b++)
   		{
   		    format(file, sizeof(file), "/Store/Banks/%i.ini", b);
  			if(pickupid == BankPickInt[b])
			{
				gTeam[playerid] = NORMAL;
				SetPlayerPos(playerid, dini_Float(file, "SpawnOutX"), dini_Float(file, "SpawnOutY"), dini_Float(file, "SpawnOutZ"));
		        SetPlayerFacingAngle(playerid, dini_Float(file, "SpawnOutAngle"));
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
			}
		}
 		for(new a = 0; a < MAX_AMMUNATIONS; a++)
		{
		    format(file, sizeof(file), "/Store/Ammunations/%i.ini", a);
			if(pickupid == AmmunationPickInt[a])
			{
			    gTeam[playerid] = NORMAL;
				SetPlayerPos(playerid, dini_Float(file, "SpawnOutX"), dini_Float(file, "SpawnOutY"), dini_Float(file, "SpawnOutZ"));
		        SetPlayerFacingAngle(playerid, dini_Float(file, "SpawnOutAngle"));
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
			}
		}
		for(new bs = 0; bs < MAX_BURGERSHOTS; bs++)
		{
		    format(file, sizeof(file), "/Store/BurgerShots/%i.ini", bs);
			if(pickupid == BurgerPickInt[bs])
			{
			    gTeam[playerid] = NORMAL;
				SetPlayerPos(playerid, dini_Float(file, "SpawnOutX"), dini_Float(file, "SpawnOutY"), dini_Float(file, "SpawnOutZ"));
		        SetPlayerFacingAngle(playerid, dini_Float(file, "SpawnOutAngle"));
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
			}
		}
		for(new cb = 0; cb < MAX_CLUCKINBELLS; cb++)
		{
		    format(file, sizeof(file), "/Store/CluckinBells/%i.ini", cb);
			if(pickupid == CluckinBellPickInt[cb])
			{
			    gTeam[playerid] = NORMAL;
				SetPlayerPos(playerid, dini_Float(file, "SpawnOutX"), dini_Float(file, "SpawnOutY"), dini_Float(file, "SpawnOutZ"));
		        SetPlayerFacingAngle(playerid, dini_Float(file, "SpawnOutAngle"));
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
			}
		}
		for(new ps = 0; ps < MAX_PIZZASTACKS; ps++)
		{
		    format(file, sizeof(file), "/Store/WellStackedPizzas/%i.ini", ps);
			if(pickupid == PizzaPickInt[ps])
			{
			    gTeam[playerid] = NORMAL;
				SetPlayerPos(playerid, dini_Float(file, "SpawnOutX"), dini_Float(file, "SpawnOutY"), dini_Float(file, "SpawnOutZ"));
		        SetPlayerFacingAngle(playerid, dini_Float(file, "SpawnOutAngle"));
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
			}
		}
 		for(new tfs = 0; tfs < MAX_TFS; tfs++)
		{
		    format(file, sizeof(file), "/Store/TwentyFourSeven/%i.ini", tfs);
			if(pickupid == TFSPickInt[tfs])
			{
			    gTeam[playerid] = NORMAL;
				SetPlayerPos(playerid, dini_Float(file, "SpawnOutX"), dini_Float(file, "SpawnOutY"), dini_Float(file, "SpawnOutZ"));
		        SetPlayerFacingAngle(playerid, dini_Float(file, "SpawnOutAngle"));
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, 0);
			}
		}

	    // aout

		for(new bo = 0; bo < MAX_BANKS; bo++)
		{
		    if(pickupid == BankPickOut[bo])
		    {
		        gTeam[playerid] = STORE;
		        SetPlayerPos(playerid, 2307.8840, -15.4403, 26.7496);
				SetPlayerFacingAngle(playerid, 272.2517);
		        SetPlayerInterior(playerid, 0);
		        SetPlayerVirtualWorld(playerid, (bo + 1000));
                return 1;
			}
		}
		for(new ao = 0; ao < MAX_AMMUNATIONS; ao++)
		{
  			if(pickupid == AmmunationPickOut[ao])
		    {
		    	gTeam[playerid] = STORE;
		        SetPlayerPos(playerid, 315.4236, -140.6816, 999.6016);
				SetPlayerFacingAngle(playerid, 1.2109);
		        SetPlayerInterior(playerid, 7);
		        SetPlayerVirtualWorld(playerid, (ao + 1000));
		        return 1;
			}
		}
		for(new bso = 0; bso < MAX_BURGERSHOTS; bso++)
		{
  			if(pickupid == BurgerPickOut[bso])
		    {
		    	gTeam[playerid] = STORE;
		        SetPlayerPos(playerid, 365.3955, -73.8744, 1001.5078);
				SetPlayerFacingAngle(playerid, 304.0766);
		        SetPlayerInterior(playerid, 10);
		        SetPlayerVirtualWorld(playerid, (bso + 1000));
		        SetPlayerShopName(playerid, "FDBURG");
		        return 1;
			}

		}
		for(new cbo = 0; cbo < MAX_CLUCKINBELLS; cbo++)
		{
  			if(pickupid == CluckinBellPickOut[cbo])
			{
				gTeam[playerid] = STORE;
		        SetPlayerPos(playerid, 365.0724, -8.9202, 1001.8516);
				SetPlayerFacingAngle(playerid, 358.4327);
		        SetPlayerInterior(playerid, 9);
		        SetPlayerVirtualWorld(playerid, (cbo + 1000));
		        SetPlayerShopName(playerid, "FDCHICK");
		        return 1;
			}
		}
		for(new pso = 0; pso < MAX_PIZZASTACKS; pso++)
		{
  			if(pickupid == PizzaPickOut[pso])
		    {
		    	gTeam[playerid] = STORE;
		        SetPlayerPos(playerid, 370.6657, -129.9993, 1001.4922);
				SetPlayerFacingAngle(playerid, 358.0357);
		        SetPlayerInterior(playerid, 5);
		        SetPlayerVirtualWorld(playerid, (pso + 1000));
		        SetPlayerShopName(playerid, "FDPIZA");
		        return 1;
			}
		}
		for(new tfso = 0; tfso < MAX_TFS; tfso++)
		{
  			if(pickupid == TFSPickOut[tfso])
		    {
		    	gTeam[playerid] = STORE;
		        SetPlayerPos(playerid, -22.3658, -185.1534, 1003.5469);
				SetPlayerFacingAngle(playerid, 311.6577);
		        SetPlayerInterior(playerid, 17);
		        SetPlayerVirtualWorld(playerid, (tfso + 1000));
		        return 1;
			}
		}
	}
	return 1;
}

public OnObjectMoved(objectid)
{
    new Float:x, Float:y, Float:z;
	for(new i; i < sizeof(Obj_FloorDoors); i ++)
	{
		if(objectid == Obj_FloorDoors[i][0])
		{
		    GetObjectPos(Obj_FloorDoors[i][0], x, y, z);

		    if(x < X_DOOR_L_OPENED - 0.5)
		    {
				Elevator_MoveToFloor(ElevatorQueue[0]);
				RemoveFirstQueueFloor();
			}
		}
	}

	if(objectid == Obj_Elevator)
	{
	    KillTimer(ElevatorBoostTimer);

	    FloorRequestedBy[ElevatorFloor] = INVALID_PLAYER_ID;

	    Elevator_OpenDoors();
	    Floor_OpenDoors(ElevatorFloor);

	    GetObjectPos(Obj_Elevator, x, y, z);
	    Label_Elevator = Create3DTextLabel("Press 'F' to use elevator", LILA, 1784.9822, -1302.0426, z - 0.9, 4.0, 0, 1);

	    ElevatorState = ELEVATOR_STATE_WAITING;
	    SetTimer("Elevator_TurnToIdle", ELEVATOR_WAIT_TIME, false);
	}

	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	new string[16];
	format(string, sizeof(string), "%i", clickedplayerid);
	cmd_stats(playerid, string);
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	if(gTeam[playerid] == NORMAL)
	{
    	SetVehicleHealth(vehicleid, 99999.0);
		RepairVehicle(vehicleid);
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(GetPlayerState(i) == PLAYER_STATE_SPECTATING && PlayerInfo[i][SpecID] == playerid)
		{
	        TogglePlayerSpectating(i, true);
	        PlayerSpectateVehicle(i, vehicleid);
	        PlayerInfo[i][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
		}
	}
	if(gTeam[playerid] == NORMAL && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
	    new string[18];
    	format(string, sizeof(string), "~w~%s", GetVehicleNameById(vehicleid));
    	GameTextForPlayer(playerid, string, 1000, 1);
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(gTeam[playerid] == DERBY)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
			DerbyVehLabel[playerid] = CreatePlayer3DTextLabel(playerid, " ", -1, 0, 0, 0.9, 10.0, INVALID_PLAYER_ID, GetPlayerVehicleID(playerid), 1);
			UpdateBar(playerid);
		}
		else DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);
	}
	return 1;
}

Float:GetElevatorZCoordForFloor(floorid)
{
    return (GROUND_Z_COORD + FloorZOffsets[floorid] + ELEVATOR_OFFSET); // A small offset for the elevator object itself.
}

Float:GetDoorsZCoordForFloor(floorid)
{
	return (GROUND_Z_COORD + FloorZOffsets[floorid]);
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(Key(KEY_SPRINT) && IsPlayerInRangeOfPoint(playerid, 2.2, 2311.63, -3.89, 26.74) && gTeam[playerid] == STORE)
	{
	    ShowDialog(playerid, BANK_DIALOG);
	}
		
	if(gTeam[playerid] == NORMAL)
	{
	    if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
	    {
			if(Key(KEY_SUBMISSION))
			{
		 		new currentveh, Float:angle;
			    currentveh = GetPlayerVehicleID(playerid);
			    GetVehicleZAngle(currentveh, angle);
			    SetVehicleZAngle(currentveh, angle);
			    return 1;
			}

		    if(PlayerInfo[playerid][SpeedBoost])
		    {
				if(Key(KEY_FIRE))
				{
					new Float:POS[3];
					GetVehicleVelocity(GetPlayerVehicleID(playerid), POS[0], POS[1], POS[2]);
					if(POS[0] < 20.0 || POS[1] < 20.0 || POS[2] < 40.0)
					{
						SetVehicleVelocity(GetPlayerVehicleID(playerid), POS[0] + (POS[0] / 2.4), POS[1] + (POS[1] / 2.4), POS[2] + (POS[2] / 2.4));
					}
					return 1;
		   		}

				if(Key(KEY_CROUCH))
				{
					JumpVeh(GetPlayerVehicleID(playerid));
					return 1;
				}
			}
		}
		
		if(PlayerInfo[playerid][SuperJump] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && Key(KEY_JUMP))
		{
			new Float:POS[3];
			GetPlayerVelocity(playerid, POS[0], POS[1], POS[2]);
			SetPlayerVelocity(playerid, POS[0], POS[1], floatadd(POS[2], 5.0));
			return 1;
		}

		if(!IsPlayerInAnyVehicle(playerid) && Key(KEY_SECONDARY_ATTACK))
		{
		    new Float:POS[3];
		    GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
		    if(POS[1] < -1301.4 && POS[1] > -1303.2417 && POS[0] < 1786.2131 && POS[0] > 1784.1555)
		    {
		        ShowElevatorDialog(playerid);
			}
			else
			{
			    if(POS[1] > -1301.4 && POS[1] < -1299.1447 && POS[0] < 1785.6147 && POS[0] > 1781.9902)
			    {
					new i = 20;
					while(POS[2] < GetDoorsZCoordForFloor(i) + 3.5 && i > 0)
					{
					    i--;
					}

					if(i == 0 && POS[2] < GetDoorsZCoordForFloor(0) + 2.0)
					{
					    i = -1;
					}

					if(i <= 19)
					{
						CallElevator(playerid, i + 1);
						GameTextForPlayer(playerid, "~r~Elevator called", 3500, 4);
					}
			    }
			}
		}
	}
	else if(BuildRace == playerid + 1 && gTeam[playerid] == BUILDRACE)
	{
		new
	 		string[255],
	 		rNameFile[255],
	   		rFile[255],
	     	Float:vPos[4];

	    if(Key(KEY_FIRE))
	    {
		    if(BuildTakeVehPos)
		    {
		    	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, RED, ">> You need to be in a vehicle");
				format(rFile, sizeof(rFile), "/Race/%s.race", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				GetVehicleZAngle(GetPlayerVehicleID(playerid), vPos[3]);
		        dini_Create(rFile);
				dini_IntSet(rFile, "vModel", BuildModeVID);
				dini_IntSet(rFile, "rType", BuildRaceType);
				dini_IntSet(rFile, "rVirtualworld", BuildVirtualWorld);
		        format(string, sizeof(string), "vPosX_%i", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[0]);
		        format(string, sizeof(string), "vPosY_%i", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[1]);
		        format(string, sizeof(string), "vPosZ_%i", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[2]);
		        format(string, sizeof(string), "vAngle_%i", BuildVehPosCount), dini_FloatSet(rFile, string, vPos[3]);
		        format(string, sizeof(string), ">> Vehicle Pos '%i' has been taken.", BuildVehPosCount+1);
		        SendClientMessage(playerid, YELLOW, string);
				BuildVehPosCount++;
			}
   			if(BuildVehPosCount >= RACE_MAX_PLAYERS)
		    {
		        BuildVehPosCount = 0;
		        BuildTakeVehPos = false;
		        ShowDialog(playerid, DIALOG_RACE_CHECKPOINTS);
		    }
			if(BuildTakeCheckpoints)
			{
			    if(BuildCheckPointCount > MAX_RACE_CHECKPOINTS_EACH_RACE) return SendClientMessage(playerid, RED, ">> You reached the maximum amount of checkpoints!");
			    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, RED, ">> You need to be in a vehicle");
				format(rFile, sizeof(rFile), "/Race/%s.race", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				format(string, sizeof(string), "CP_%i_PosX", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[0]);
				format(string, sizeof(string), "CP_%i_PosY", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[1]);
				format(string, sizeof(string), "CP_%i_PosZ", BuildCheckPointCount), dini_FloatSet(rFile, string, vPos[2]);
    			format(string, sizeof(string), ">> Checkpoint '%i' has been setted!", BuildCheckPointCount+1);
		        SendClientMessage(playerid, YELLOW, string);
				BuildCheckPointCount++;
			}
		}
		if(Key(KEY_SECONDARY_ATTACK))
		{
		    if(BuildTakeCheckpoints)
		    {
		        ShowDialog(playerid, DIALOG_RACE_RACERDY);
				format(rNameFile, sizeof(rNameFile), "/Race/Index/Index.ini");
				TotalRaces = dini_Int(rNameFile, "TotalRaces");
				TotalRaces++;
				dini_IntSet(rNameFile, "TotalRaces", TotalRaces);
				format(string, sizeof(string), "Race_%i", TotalRaces-1);
				format(rFile, sizeof(rFile), "/Race/%s.race", BuildName);
				dini_Set(rNameFile, string, BuildName);
				dini_IntSet(rFile, "TotalRaceCP", BuildCheckPointCount);
				gTeam[playerid] = NORMAL;
		    }
		}
	}
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    HidePlayerToyTextdraws(playerid);
    if(response)
    {
        SendInfo(playerid, "~h~~g~New Toy position saved!", 2500);

        PlayerToys[playerid][index][toy_x] = fOffsetX;
        PlayerToys[playerid][index][toy_y] = fOffsetY;
        PlayerToys[playerid][index][toy_z] = fOffsetZ;
        PlayerToys[playerid][index][toy_rx] = fRotX;
        PlayerToys[playerid][index][toy_ry] = fRotY;
        PlayerToys[playerid][index][toy_rz] = fRotZ;
        PlayerToys[playerid][index][toy_sx] = fScaleX;
        PlayerToys[playerid][index][toy_sy] = fScaleY;
        PlayerToys[playerid][index][toy_sz] = fScaleZ;
    }
    else
    {
        SendInfo(playerid, "~h~~r~Toy edition canceld!", 2500);

        new i = index;
        SetPlayerAttachedObject(playerid,
			index,
			modelid,
			boneid,
			PlayerToys[playerid][i][toy_x],
			PlayerToys[playerid][i][toy_y],
			PlayerToys[playerid][i][toy_z],
			PlayerToys[playerid][i][toy_rx],
			PlayerToys[playerid][i][toy_ry],
			PlayerToys[playerid][i][toy_rz],
			PlayerToys[playerid][i][toy_sx],
			PlayerToys[playerid][i][toy_sy],
			PlayerToys[playerid][i][toy_sz]);
    }
    return 1;
}


// ===
// commands
// ===

COMMAND:beach(playerid, params[])
{
    PortPlayerMap(playerid, 341.8535, -1852.6327, 8.2618, 90.2136, "Los Santos Beach", "beach");
    return 1;
}
COMMAND:chiliad(playerid, params[])
{
	cmd_mc(playerid, "");
	return 1;
}
COMMAND:mc(playerid, params[])
{
    PortPlayerMapVeh(playerid, -2335.2832, -1644.9913, 486.0481, 279.2750, -2308.8811, -1614.4382, 483.8531, 197.2544, "Mount Chiliad", "mc");
    return 1;
}
COMMAND:sf(playerid, params[])
{
    PortPlayerMapVeh(playerid, -1990.6650, 136.9297, 27.3110, 0.6588, -1990.6650, 136.9297, 27.3110, 0.6588, "San Fierro", "sf");
    return 1;
}
COMMAND:sfa(playerid, params[])
{
    PortPlayerMapVeh(playerid, -1196.3280, -17.4523, 15.8281, 42.5799, -1205.9094, 15.8533, 13.9217, 137.6498, "San Fierro Airport", "sfa");
    return 1;
}
COMMAND:lsa(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2003.1035,-2455.4905,15.8403,125.4882,2000.9854,-2493.9919,13.3126,89.7651, "Los Santos Airport", "lsa");
    return 1;
}
COMMAND:ls(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2494.7476, -1666.6097, 13.3438, 88.1632, 2494.7476, -1666.6097, 13.3438, 88.1632, "Los Santos", "ls");
    return 1;
}
COMMAND:lspd(playerid, params[])
{
    PortPlayerMap(playerid, 1542.5554, -1674.7850, 13.5547, 92.8351, "Los Santos Police Department", "lspd");
    return 1;
}
COMMAND:lvpd(playerid, params[])
{
    PortPlayerMap(playerid, 2290.5759,2421.3708,10.8203,178.5880, "Las Venturas Police Department", "lvpd");
    return 1;
}
COMMAND:sfpd(playerid, params[])
{
    PortPlayerMap(playerid, -1624.2128,674.2734,6.9573,219.9653, "San Fierro Police Department", "sfpd");
    return 1;
}
COMMAND:skyroad(playerid, params[])
{
    PortPlayerMapVeh(playerid, 587.9016,1400.4779,1228.1453,3.2243,587.9016,1400.4779,1228.1453,3.2243, "Skyroad", "skyroad");
    return 1;
}
COMMAND:skyroad2(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2912.3618,-792.8673,10.7623,264.6945,2912.3618,-792.8673,10.7623,264.6945, "Skyroad 2", "skyroad2");
    return 1;
}
COMMAND:skyroad3(playerid, params[])
{
    PortPlayerMapVeh(playerid, 205.0412,2481.6416,16.5166,148.2003,205.0412,2481.6416,16.5166,148.2003, "Skyroad 3", "skyroad3");
    return 1;
}
COMMAND:wj(playerid, params[])
{
    PortPlayerMapVeh(playerid, 341.6029,2008.7330,571.1588,174.7883,341.6029,2008.7330,571.1588,174.7883, "Water Jump", "wj");
    return 1;
}
COMMAND:snow(playerid, params[])
{
    PortPlayerMapVeh(playerid, -719.7679,1723.9852,7.0400,255.2436,-719.7679,1723.9852,7.0400,255.2436, "Snow Market", "snow");
    return 1;
}
COMMAND:sd(playerid, params[])
{
    PortPlayerMapVeh(playerid, -793.2972,2230.8733,45.0103,180.8382,-790.9946,2197.6873,42.4100,271.6217, "Sherman Dam", "sd");
    return 1;
}
COMMAND:aa(playerid, params[])
{
    PortPlayerMapVeh(playerid, 383.5131,2537.2727,18.8503,179.3657,385.7370,2513.5242,16.6766,89.6337, "Abandoned Airport", "aa");
    return 1;
}
COMMAND:area51(playerid, params[])
{
	cmd_a51(playerid, "");
	return 1;
}
COMMAND:a51(playerid, params[])
{
    PortPlayerMapVeh(playerid, 307.2482,2050.7505,17.6406,180.8353,307.2482,2050.7505,17.6406,180.8353, "Area 51", "a51");
    return 1;
}
COMMAND:trans(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1034.5165,-1039.7190,31.6651,272.5891,1034.5165,-1039.7190,31.6651,272.5891, "Transfender", "trans");
    return 1;
}
COMMAND:trans2(playerid, params[])
{
    PortPlayerMapVeh(playerid, -1932.7380,228.3443,34.1563,88.9975,-1932.7380,228.3443,34.1563,88.9975, "Transfender 2", "trans2");
    return 1;
}
COMMAND:trans3(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2386.2788,1021.7114,10.8203,356.2733,2386.2788,1021.7114,10.8203,356.2733, "Transfender 3", "trans3");
    return 1;
}
COMMAND:lw(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2645.5457,-2004.5851,13.3828,173.3082,2645.5457,-2004.5851,13.3828,173.3082, "Loco Low", "lw");
    return 1;
}
COMMAND:arch(playerid, params[])
{
    PortPlayerMapVeh(playerid, -2689.1001,217.8290,3.9509,92.1955,-2689.1001,217.8290,3.9509,92.1955, "Arch Wheel Angels", "arch");
    return 1;
}
COMMAND:ee(playerid, params[])
{
    PortPlayerMap(playerid, -2678.2119,1594.8811,217.2739,269.7218, "Easter Egg", "ee");
    return 1;
}
COMMAND:eej(playerid, params[])
{
    PortPlayerMap(playerid, -2662.6877,1595.1354,225.7578,92.7102, "Easter Egg Jump", "eej");
    return 1;
}
COMMAND:qp(playerid, params[])
{
    PortPlayerMap(playerid, 2121.9146,2397.7786,51.2586,272.0792, "Quad Parkour", "qp");
    return 1;
}
COMMAND:plane(playerid, params[])
{
    PortPlayerMap(playerid, 1841.8307,-1398.3483,117.0471,66.2874, "Plane", "plane");
    return 1;
}
COMMAND:et(playerid, params[])
{
    PortPlayerMap(playerid, 956.2977,2441.0171,205.7626,183.3917, "Eiffel Tower", "et");
    return 1;
}
COMMAND:lv(playerid, params[])
{
    PortPlayerMapVeh(playerid,2039.8860,1546.1112,10.4450,180.4970,2039.8860,1546.1112,10.4450,180.4970, "Las Ventuars", "lv");
    return 1;
}
COMMAND:lva(playerid, params[])
{
    PortPlayerMapVeh(playerid,1320.6082,1268.7208,13.5903,2.6780,1338.3005,1275.2460,11.8100,358.8224, "Las Ventuars Airport", "lva");
    return 1;
}
COMMAND:bsn(playerid, params[])
{
	cmd_bs(playerid, "");
	return 1;
}
COMMAND:bs(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1207.7231,-920.2217,43.0507,204.3588,1215.8248,-937.2825,42.4353,97.1190, "Burger Shot", "bs");
    return 1;
}
COMMAND:bs2(playerid, params[])
{
    PortPlayerMapVeh(playerid, 810.2364,-1632.6433,13.3906,247.2854,810.2364,-1632.6433,13.3906,247.2854, "Burger Shot 2", "bs2");
    return 1;
}
COMMAND:bs3(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2447.1104,2024.7499,10.8203,5.7265,2447.1104,2024.7499,10.8203,5.7265, "Burger Shot 3", "bs3");
    return 1;
}
COMMAND:bs4(playerid, params[])
{
    PortPlayerMapVeh(playerid, -2314.1365,-143.7879,35.3203,178.6881,-2314.1365,-143.7879,35.3203,178.6881, "Burger Shot 4", "bs4");
    return 1;
}
COMMAND:bs5(playerid, params[])
{
    PortPlayerMap(playerid, -1907.5175,834.4271,35.0156,140.9912, "Burger Shot 5", "bs5");
    return 1;
}
COMMAND:film(playerid, params[])
{
    PortPlayerMapVeh(playerid, 909.7761,-1221.2274,16.9766,271.1224,909.7761,-1221.2274,16.9766,271.1224, "Film Studios", "film");
    return 1;
}
COMMAND:bmx(playerid, params[])
{
    cmd_park(playerid, "");
    return 1;
}
COMMAND:park(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1968.4741,-1440.0867,13.5475,66.2239,1968.4741,-1440.0867,13.5475,66.2239, "BMX Park", "Park");
    return 1;
}
COMMAND:glen(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1892.7002,-1165.8480,24.0390,226.6521,1892.7002,-1165.8480,24.0390,226.6521, "Glen Park", "glen");
    return 1;
}
COMMAND:sky(playerid, params[])
{
    PortPlayerMap(playerid, 1544.1896,-1352.2094,329.4762,182.8083, "Sky", "sky");
    return 1;
}
COMMAND:sftj(playerid, params[])
{
    PortPlayerMap(playerid, -1753.6401,884.9623,295.8750,358.5666, "San Fierro Tower Jump", "sftj");
    return 1;
}
COMMAND:quarry(playerid, params[])
{
    PortPlayerMapVeh(playerid, 833.0357,851.8098,12.0047,109.5170,833.0357,851.8098,12.0047,109.5170, "Quarry", "quarry");
    return 1;
}
COMMAND:bordel(playerid, params[])
{
    PortPlayerMapVeh(playerid, -2628.8484,1367.2144,6.9035,317.5401,-2628.8484,1367.2144,6.9035,317.5401, "Bordel", "bordel");
    return 1;
}
COMMAND:vs(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1859.3052,-1463.4524,13.5301,49.9672,1859.3052,-1463.4524,13.5301,49.9672, "Vehicle Shop", "vs");
    return 1;
}
COMMAND:ms(playerid, params[])
{
    PortPlayerMapVeh(playerid, 800.6712,-1330.6608,13.1061,226.2979,800.6712,-1330.6608,13.1061,226.2979, "Market Station", "ms");
    return 1;
}
COMMAND:speed(playerid, params[])
{
    PortPlayerMapVeh(playerid, 680.2595, -1361.8927, 2552.2214,90.0,680.2595, -1361.8927, 2552.2214,90.0, "Speed Map", "speed");
    return 1;
}
COMMAND:dd(playerid, params[])
{
    PortPlayerMapVeh(playerid, 4546.4175,655.6476,13.4803,0.0375,4546.4175,655.6476,13.4803,0.0375, "Dawn Derby", "dd");
    return 1;
}
COMMAND:glory(playerid, params[])
{
    PortPlayerMap(playerid, 2354.1689, -2067.3284, 22.3832, 90.0, "Glory", "glory");
    return 1;
}
COMMAND:maze(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2330.3174, 535.1375, 2.9512, 252.0903, 2330.3174, 535.1375, 2.9512, 252.0903, "Maze", "maze");
    return 1;
}
COMMAND:maze2(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1458.9336, 1854.9144, 54.7362, 143.3116,1458.9336, 1854.9144, 54.7362, 143.3116, "Maze 2", "maze2");
    return 1;
}
COMMAND:maze3(playerid, params[])
{
    PortPlayerMapVeh(playerid, 836.5298,-2048.2273,12.8672,181.5937,836.5298,-2048.2273,12.8672,181.5937, "Maze 3", "maze3");
    return 1;
}
COMMAND:maze4(playerid, params[])
{
    PortPlayerMapVeh(playerid, 983.0536,2691.7898,10.6925,206.9207,983.0536,2691.7898,10.6925,206.9207, "Maze 4", "maze4");
    return 1;
}
COMMAND:loop(playerid, params[])
{
    PortPlayerMapVeh(playerid, 494.7604,4.7474,704.3844,88.7656,494.7604,4.7474,704.3844,88.7656, "Loop", "loop");
    return 1;
}
COMMAND:rect(playerid, params[])
{
    PortPlayerMapVeh(playerid, 742.8961,533.1397,461.9956,270.0180,742.8961,533.1397,461.9956,270.0180, "RectAngle", "rect");
    return 1;
}
COMMAND:nrg(playerid, params[])
{
    PortPlayerMapVeh(playerid, 442.4455, 816.6687, 9.6865, 90.0, 442.4455, 816.6687, 9.6865, 90.0, "NRG Parkour", "nrg");
    return 1;
}
COMMAND:jujump(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1387.8517,-2425.5776,525.6338,266.3386,1387.8517,-2425.5776,525.6338,266.3386, "Jubber Jump", "jujump");
    return 1;
}
COMMAND:da(playerid, params[])
{
    PortPlayerMapVeh(playerid, 788.3009,-471.4969,20.5428,52.6863,788.3009,-471.4969,20.5428,52.6863, "Dilimore Airport", "da");
    return 1;
}
COMMAND:drag(playerid, params[])
{
    PortPlayerMapVeh(playerid, -557.0079,-3575.5906,7.0870,30.2946,-557.0079,-3575.5906,7.0870,30.2946, "Drag", "drag");
    return 1;
}
COMMAND:drift(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2333.8508,1405.8370,42.5904,358.0404,2333.8508,1405.8370,42.5904,358.0404, "Drift Map", "drift");
    return 1;
}
COMMAND:balloon(playerid, params[])
{
    PortPlayerMap(playerid, 295.4890,-1813.5734,52.0518,4.9753, "balloon", "balloon");
    return 1;
}
COMMAND:lsp(playerid, params[])
{
    PortPlayerMap(playerid, 2505.2646,-1694.4974,17.9575,182.0808, "Los Santos Parkour", "lsp");
    return 1;
}
COMMAND:parkour(playerid, params[])
{
    ShowPlayerDialog(playerid, 5004, DIALOG_STYLE_MSGBOX, ""white"Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    PortPlayerMap(playerid, 2586.5618,-1346.5614,232.2472,0.0, "Parkour 1", "parkour");
    return 1;
}
COMMAND:parkour1(playerid, params[])
{
	cmd_parkour(playerid, "");
    return 1;
}
COMMAND:parkour2(playerid, params[])
{
    ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""white"Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    PortPlayerMap(playerid, -787.3710,-2766.3005,2660.3042,0.0, "Parkour 2", "parkour2");
    return 1;
}
COMMAND:parkour3(playerid, params[])
{
    ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""white"Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    PortPlayerMap(playerid, -783.9699, -3662.0358, 137.3758,0.0, "Parkour 3", "parkour3");
    return 1;
}
COMMAND:parkour4(playerid, params[])
{
    ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""white"Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    PortPlayerMap(playerid, -2929.4922,-1876.4229,8.3901, 344.1002, "Parkour 4", "parkour4");
    return 1;
}
COMMAND:parkour5(playerid, params[])
{
    ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""white"Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    PortPlayerMap(playerid, 1441.3851318359, -1700.8812255859, 915.390625, 344.1002, "Parkour 5", "parkour5");
    return 1;
}
COMMAND:parkour6(playerid, params[])
{
    ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""white"Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    PortPlayerMap(playerid, 2768.4343261719,-2743.7131347656,2460.0815429688, 0.0, "Parkour 6", "parkour6");
    return 1;
}
COMMAND:parkour7(playerid, params[])
{
    ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""white"Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    PortPlayerMap(playerid, 3018.1736,-1879.4410,599.0370,178.1489, "Parkour 7", "parkour7");
    return 1;
}
COMMAND:kk(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2521.0232, -1504.3864, 25.5929, 180.0, 2521.0232, -1504.3864, 25.5929, 180.0, "Krusty Krab", "kk");
    return 1;
}
COMMAND:globe(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1954.7849,1915.3772,144.7200,268.1410,1954.7849,1915.3772,144.7200,268.1410, "Globe", "globe1");
    return 1;
}
COMMAND:krustykrab(playerid, params[])
{
	cmd_kk(playerid, "");
    return 1;
}
COMMAND:farm(playerid, params[])
{
    PortPlayerMapVeh(playerid,-1206.7996,-1056.9430,128.3646,310.2706,-1206.7996,-1056.9430,128.3646,310.2706, "Farm", "farm");
    return 1;
}
COMMAND:bowl(playerid, params[])
{
    PortPlayerMapVeh(playerid,-576.6021,421.7149,75.2376,84.2204,-576.6021,421.7149,75.2376,84.2204, "Bowl", "bowl");
    return 1;
}
COMMAND:villa(playerid, params[])
{
    PortPlayerMapVeh(playerid,-2006.7003,2434.1331,34.6573,2.1006,-2006.7003,2434.1331,34.6573,2.1006, "Villa", "villa");
    return 1;
}
COMMAND:palominocreek(playerid, params[])
{
    PortPlayerMapVeh(playerid,2343.0247,91.6131,26.3281,179.4676,2343.0247,91.6131,26.3281,179.4676, "Palomino Creek", "palominocreek");
    return 1;
}

COMMAND:skin(playerid, params[])
{
	cmd_myskin(playerid, params);
	return 1;
}

COMMAND:setskin(playerid, params[])
{
	cmd_myskin(playerid, params);
	return 1;
}

COMMAND:mynetstats(playerid, params[])
{
	new stats[423];
    GetPlayerNetworkStats(playerid, stats, sizeof(stats));
    ShowPlayerDialog(playerid, NETSTATS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- My NetworkStats", stats, "OK", "");
	return 1;
}

COMMAND:netstats(playerid, params[])
{
	new stats[423];
    GetNetworkStats(stats, sizeof(stats));
    ShowPlayerDialog(playerid, NETSTATS_DIALOG + 1, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Server Network Stats", stats, "OK", "");
	return 1;
}

COMMAND:myskin(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	extract params -> new skin; else
	{
 		return SendClientMessage(playerid, ORANGE, "Usage: /myskin <skin id>");
	}
	if(!IsValidSkin(skin)) return LangMSG(playerid, RED, ""er"Invaild Skin ID", ""er" Diesen Skin gibts nicht!");
	SetSpawnInfo(playerid, NO_TEAM, skin, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);
    SetPlayerSkin(playerid, skin);
	return 1;
}

COMMAND:fallout(playerid, params[])
{
    if(gTeam[playerid] == FALLOUT) return cmd_exit(playerid, "");
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	if(g_FalloutStatus == e_Fallout_Inactive)
	{
	    ResetFalloutGameTime();
	    Fallout_BuildMap();
	    Fallout_StartGame();
		gTeam[playerid] = FALLOUT;
		g_FalloutStatus = e_Fallout_Startup;
		Fallout_SetPlayer(playerid);
        LangMSGToAll(BLUE, ""fallout_sign" Type /fallout to participate", ""fallout_sign" Tippe /fallout um Fallout beizutreten");
        CurrentFalloutPlayers++;
        NewMinigameJoin(playerid, "Fallout", "fallout");
        SetPlayerInterior(playerid, 0);
	}
	else if(g_FalloutStatus == e_Fallout_Startup)
	{
		gTeam[playerid] = FALLOUT;
		new string[100], gstring[100];
		format(string, sizeof(string), "%s joined Fallout!", __GetName(playerid));
		format(string, sizeof(string), "%s ist dem Fallout beigetreten!", __GetName(playerid));
		FalloutMSG(string, gstring);
		Fallout_SetPlayer(playerid);
		CurrentFalloutPlayers++;
        NewMinigameJoin(playerid, "Fallout", "fallout");
        SetPlayerInterior(playerid, 0);
	}
	else if(g_FalloutStatus == e_Fallout_Running)
	{
	    LangMSG(playerid, BLUE, ""er"Fallout already started!", ""er"Fallout wurde schon gestartet!");
	}
	return 1;
}

COMMAND:derby(playerid, params[])
{
	if(gTeam[playerid] == DERBY) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(CurrentDerbyPlayers == MAX_DERBY_PLAYERS) return LangMSG(playerid, RED, ""er"Derby reached it's max Players!", ""er"Das Derby ist momentan voll!");

    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
    gTeam[playerid] = DERBY;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	ClearAnimations(playerid);
	
	if(IsDerbyRunning)
	{
        ShowPlayerDerbyTextdraws(playerid);
        LangMSG(playerid, RED, ""er"Derby already started, please wait till next round!", ""er"Das Derby wurde schon gestartet, bitte warte nun bis zur nächsten Runde!");
	}
	else
	{
		ShowDialog(playerid, DERBY_VOTING_DIALOG);
        LangMSG(playerid, RED, "You joined Derby. Please vote for a map!", "Du bist dem Derby beigetreten, vote nun für eine Map!");
	}
	
	SetPlayerDerbyStaticMeshes(playerid);
	ShowPlayerDerbyTextdraws(playerid);
	CurrentDerbyPlayers++;
	SetPlayerVirtualWorld(playerid, DERBY_WORLD);
	SetPlayerInterior(playerid, 0);

	NewMinigameJoin(playerid, "Derby", "derby");
	return 1;
}

COMMAND:dm(playerid, params[])
{
	if(gTeam[playerid] == DM && gLastMap[playerid] == DM_1) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
    SetPlayerHealth(playerid, 100.0);
	SetPlayerVirtualWorld(playerid, DM_WORLD);
	ResetPlayerWeapons(playerid);
	ShowPlayerDMTextdraws(playerid);
	new rand = random(2);
	gTeam[playerid] = DM;
	gLastMap[playerid] = DM_1;

	GivePlayerWeapon(playerid, 24, 99999);
	GivePlayerWeapon(playerid, 26, 99999);

	SetPlayerPos(playerid, DM_MAP_1[rand][0], DM_MAP_1[rand][1], DM_MAP_1[rand][2]+2);
	SetPlayerFacingAngle(playerid, DM_MAP_1[rand][3]);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0);
	NewMinigameJoin(playerid, "Deathmatch", "dm");
	return 1;
}
COMMAND:dm1(playerid, params[])
{
	cmd_dm(playerid, params);
	return 1;
}

COMMAND:dm2(playerid, params[])
{
	if(gTeam[playerid] == DM && gLastMap[playerid] == DM_2) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	SetPlayerHealth(playerid, 100.0);
	SetPlayerVirtualWorld(playerid, DM_WORLD+1);
	ResetPlayerWeapons(playerid);
	ShowPlayerDMTextdraws(playerid);
	new rand = random(2);
	gTeam[playerid] = DM;
	gLastMap[playerid] = DM_2;

	GivePlayerWeapon(playerid, 34, 99999);
	GivePlayerWeapon(playerid, 33, 99999);

	SetPlayerPos(playerid, DM_MAP_2[rand][0], DM_MAP_2[rand][1], DM_MAP_2[rand][2]+2);
	SetPlayerFacingAngle(playerid, DM_MAP_2[rand][3]);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0);
	NewMinigameJoin(playerid, "Deathmatch 2", "dm2");
	return 1;
}

COMMAND:dm3(playerid, params[])
{
	if(gTeam[playerid] == DM && gLastMap[playerid] == DM_3) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
    SetPlayerHealth(playerid, 100.0);
	SetPlayerVirtualWorld(playerid, DM_WORLD+2);
	ResetPlayerWeapons(playerid);
	ShowPlayerDMTextdraws(playerid);
	new rand = random(2);
	gTeam[playerid] = DM;
	gLastMap[playerid] = DM_3;

	GivePlayerWeapon(playerid, 16, 99999);
	GivePlayerWeapon(playerid, 9, 99999);

	SetPlayerPos(playerid, DM_MAP_3[rand][0], DM_MAP_3[rand][1], DM_MAP_3[rand][2]+2);
	SetPlayerFacingAngle(playerid, DM_MAP_3[rand][3]);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0);
	NewMinigameJoin(playerid, "Deathmatch 3", "dm3");
	return 1;
}

COMMAND:dm4(playerid, params[])
{
	if(gTeam[playerid] == DM && gLastMap[playerid] == DM_4) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	SetPlayerHealth(playerid, 100.0);
	SetPlayerVirtualWorld(playerid, DM_WORLD+3);
	ResetPlayerWeapons(playerid);
	ShowPlayerDMTextdraws(playerid);
	new rand = random(2);
	gTeam[playerid] = DM;
	gLastMap[playerid] = DM_4;

	GivePlayerWeapon(playerid, 31, 99999);
	GivePlayerWeapon(playerid, 27, 99999);
	GivePlayerWeapon(playerid, 37, 99999);

	SetPlayerPos(playerid, DM_MAP_4[rand][0], DM_MAP_4[rand][1], DM_MAP_4[rand][2]+2);
	SetPlayerFacingAngle(playerid, DM_MAP_4[rand][3]);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0);
	NewMinigameJoin(playerid, "Deathmatch 4", "dm4");
	return 1;
}

COMMAND:hidefooter(playerid, params[])
{
	cmd_hidef(playerid, params);
	return 1;
}

COMMAND:showfooter(playerid, params[])
{
	cmd_showf(playerid, params);
	return 1;
}

HidePlayerMeshTXT(playerid)
{
	TextDrawHideForPlayer(playerid, TXTKeyInfo);
	TextDrawHideForPlayer(playerid, TXTInfo);
    PlayerTextDrawHide(playerid, TXTWanteds[playerid]);
	return 1;
}

ShowPlayerMeshTXT(playerid)
{
	TextDrawShowForPlayer(playerid, TXTKeyInfo);
	TextDrawShowForPlayer(playerid, TXTInfo);
	PlayerTextDrawShow(playerid, TXTWanteds[playerid]);
	return 1;
}

COMMAND:hidef(playerid, params[])
{
	TextDrawHideForPlayer(playerid, TXTFooterP1);
	TextDrawHideForPlayer(playerid, TXTFooterP2);
	TextDrawHideForPlayer(playerid, TXTKeyInfo);
	TextDrawHideForPlayer(playerid, TXTInfo);
    PlayerTextDrawHide(playerid, TXTWanteds[playerid]);
	return 1;
}

COMMAND:showf(playerid, params[])
{
	TextDrawShowForPlayer(playerid, TXTFooterP1);
	TextDrawShowForPlayer(playerid, TXTFooterP2);
	TextDrawShowForPlayer(playerid, TXTKeyInfo);
	TextDrawShowForPlayer(playerid, TXTInfo);
	PlayerTextDrawShow(playerid, TXTWanteds[playerid]);
	return 1;
}

COMMAND:flip(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	new currentveh, Float:angle;
  	currentveh = GetPlayerVehicleID(playerid);
	GetVehicleZAngle(currentveh, angle);
	SetVehicleZAngle(currentveh, angle);
	LangMSG(playerid, ORANGE, "You can also press '2' to flip you vehicle", "Du kannst auch '2' drücken um dein Fahrzeug zu flippen");
	return 1;
}

COMMAND:sp(playerid, params[])
{
	cmd_s(playerid, params);
	return 1;
}

COMMAND:s(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(IsPlayerInAnyVehicle(playerid))
	{
		GetVehiclePos(GetPlayerVehicleID(playerid), PlayerInfo[playerid][sX], PlayerInfo[playerid][sY], PlayerInfo[playerid][sZ]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), PlayerInfo[playerid][sA]);
	}
	else
	{
	   GetPlayerPos(playerid, PlayerInfo[playerid][sX], PlayerInfo[playerid][sY], PlayerInfo[playerid][sZ]);
	   GetPlayerFacingAngle(playerid, PlayerInfo[playerid][sA]);
	}
	PlayerInfo[playerid][SavedPos] = true;
	PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
	LangMSG(playerid, -1, ""vgreen"Position saved! Load Position with "white"/l", ""vgreen"Postition gespeichert! Lade die die Position mit "white"/l");
	return 1;
}

COMMAND:spos(playerid, params[])
{
	cmd_s(playerid, params);
	return 1;
}

COMMAND:lpos(playerid, params[])
{
	cmd_l(playerid, params);
}

COMMAND:l(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	
	if(!PlayerInfo[playerid][SavedPos])
	{
		LangMSG(playerid, WHITE, "No position saved. Use /s first.", "Es wurde noch keine Position gespeuchert. Tippe /s");
		return 1;
	}
	SetCameraBehindPlayer(playerid);
	if(IsPlayerInAnyVehicle(playerid))
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), PlayerInfo[playerid][sX], PlayerInfo[playerid][sY], PlayerInfo[playerid][sZ]+2);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), PlayerInfo[playerid][sA]);
	}
	else
	{
  		SetPlayerPos(playerid, PlayerInfo[playerid][sX], PlayerInfo[playerid][sY], PlayerInfo[playerid][sZ]+2);
		SetPlayerFacingAngle(playerid, PlayerInfo[playerid][sA]);
	}
	LangMSG(playerid, WHITE, ""vgreen"Saved position loaded", ""vgreen"Gespeicherte Postiton geladen");
	PlayerPlaySound(playerid, 1057,0.0,0.0,0.0);
	return 1;
}

COMMAND:lp(playerid, params[])
{
	cmd_l(playerid, params);
	return 1;
}

COMMAND:maps(playerid, params[])
{
	cmd_tele(playerid, params);
	return 1;
}

COMMAND:map(playerid, params[])
{
	cmd_tele(playerid, params);
	return 1;
}

COMMAND:teles(playerid, params[])
{
	cmd_tele(playerid, params);
	return 1;
}

COMMAND:tele(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
 	ShowDialog(playerid, TELE_DIALOG);
	return 1;
}

COMMAND:t(playerid, params[])
{
	cmd_tele(playerid, params);
	return 1;
}

COMMAND:teleport(playerid, params[])
{
	cmd_tele(playerid, params);
	return 1;
}

COMMAND:parch(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
 	GivePlayerWeapon(playerid,46,1);
	return 1;
}

COMMAND:para(playerid, params[])
{
	cmd_parch(playerid, "");
	return 1;
}

COMMAND:pc(playerid, params[])
{
	cmd_parch(playerid, "");
	return 1;
}

COMMAND:colors(playerid, params[])
{
	SendClientMessage(playerid, BLUE, "Colors: /blue /orange /red /yellow /grey /pink /green - /random for a random color");
	return 1;
}

COMMAND:random(playerid, params[])
{
	new rand = random(sizeof(PlayerColors)), string[144];
	SetPlayerColor(playerid, PlayerColors[rand]);
	format(string, sizeof(string), "Color set! Your new color: {%06x}Color", GetPlayerColor(playerid) >>> 8);
	SendClientMessage(playerid, BLUE, string);
	return 1;
}

COMMAND:red(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	SetPlayerColor(playerid, RED);
	LangMSG(playerid, BLUE, "Color set!", "Farbe geändert!");
	return 1;
}

COMMAND:yellow(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	SetPlayerColor(playerid, YELLOW);
	LangMSG(playerid, BLUE, "Color set!", "Farbe geändert!");
	return 1;
}

COMMAND:grey(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	SetPlayerColor(playerid, GREY);
	LangMSG(playerid, BLUE, "Color set!", "Farbe geändert!");
	return 1;
}

COMMAND:pink(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	SetPlayerColor(playerid, PINK);
	LangMSG(playerid, BLUE, "Color set!", "Farbe geändert!");
	return 1;
}

COMMAND:blue(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	SetPlayerColor(playerid, BLUE);
	LangMSG(playerid, BLUE, "Color set!", "Farbe geändert!");
	return 1;
}

COMMAND:green(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	SetPlayerColor(playerid, GREEN);
	LangMSG(playerid, BLUE, "Color set!", "Farbe geändert!");
	return 1;
}

COMMAND:orange(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	SetPlayerColor(playerid, ORANGE);
	LangMSG(playerid, BLUE, "Color set!", "Farbe geändert!");
	return 1;
}

COMMAND:spawn(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
 	SetPlayerHealth(playerid, 0.0);
	SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);
    TogglePlayerSpectating(playerid, false);
	ResetPlayerWorld(playerid);
	ResetPlayerWorldBounds(playerid);
	return 1;
}

COMMAND:fs(playerid, params[])
{
	SendClientMessage(playerid, BLUE, "Fight Styles: /boxing /kungfu /kneehead /grabkick /elbow /normal");
	return 1;
}

COMMAND:fightsytles(playerid, params[])
{
	SendClientMessage(playerid, BLUE, "Fight Styles: /boxing /kungfu /kneehead /grabkick /elbow /normal");
	return 1;
}

COMMAND:normal(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_NORMAL);
	LangMSG(playerid, BLUE, "You have changed your fighting style to normal!", "Kampfstil zu Normal gewechselt.");
	return 1;
}

COMMAND:boxing(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_BOXING);
	LangMSG(playerid, BLUE, "You have changed your fighting style to boxing!", "Kampfstil zu Boxing gewechselt.");
	return 1;
}

COMMAND:kungfu(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_KUNGFU);
	LangMSG(playerid, BLUE, "You have changed your fighting style to kungfu!", "Kampfstil zu Kungfu gewechselt.");
	return 1;
}

COMMAND:kneehead(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_KNEEHEAD);
	LangMSG(playerid, BLUE, "You have changed your fighting style to kneehead!", "Kampfstil zu Kneehead gewechselt.");
	return 1;
}

COMMAND:grabkick(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_GRABKICK);
	LangMSG(playerid, BLUE, "You have changed your fighting style to grabkick", "Kampfstil zu Grabkick gewechselt.");
	return 1;
}

COMMAND:elbow(playerid, params[])
{
	SetPlayerFightingStyle (playerid, FIGHT_STYLE_ELBOW);
	LangMSG(playerid, BLUE, "You have changed your fighting style to elbow", "Kampfstil zu Elbow gewechselt.");
	return 1;
}

COMMAND:autofix(playerid, params[])
{
	cmd_sb(playerid, "");
	return 1;
}

COMMAND:speedboost(playerid, params[])
{
	cmd_sb(playerid, "");
	return 1;
}

COMMAND:superjump(playerid, params[])
{
	cmd_sj(playerid, "");
	return 1;
}

COMMAND:sb(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(PlayerInfo[playerid][SpeedBoost])
    {
     	LangMSG(playerid, YELLOW, "SpeedBoost has been disabled!", "Speedboost wurde ausgeschaltet!");
	}
	else
	{
	    LangMSG(playerid, YELLOW, "SpeedBoost has been enabled!", "Speedboost wurde angeschaltet!");
	}
	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	PlayerInfo[playerid][SpeedBoost] = !PlayerInfo[playerid][SpeedBoost];
	return 1;
}

COMMAND:sj(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(PlayerInfo[playerid][SuperJump])
    {
     	LangMSG(playerid, YELLOW, "SuperJump has been disabled!", "SuperJump wurde ausgeschaltet!");
	}
	else
	{
	    LangMSG(playerid, YELLOW, "SuperJump has been enabled!", "SuperJump wurde angeschaltet!");
	}
	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	PlayerInfo[playerid][SuperJump] = !PlayerInfo[playerid][SuperJump];
	return 1;
}

COMMAND:enter(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

    new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
	    found = true;
	    if(HouseInfo[i][locked])
		{
			LangMSG(playerid, RED, ""er"This house is locked", ""er"Dieses Haus ist verschlossen");
			break;
		}
	    SetPlayerInterior(playerid, HouseIntTypes[HouseInfo[i][interior]][interior]);
		SetPlayerVirtualWorld(playerid, HouseInfo[i][iID] + 1000);
  		SetPlayerPos(playerid, HouseIntTypes[HouseInfo[i][interior]][house_x], HouseIntTypes[HouseInfo[i][interior]][house_y], HouseIntTypes[HouseInfo[i][interior]][house_z]);
		gTeam[playerid] = HOUSE;
		SendInfo(playerid, "~h~~y~House entered!", 3000);
	}
	if(!found) SendClientMessage(playerid, RED, ""er"You aren´t near of any house!");
	return 1;
}

COMMAND:bbuy(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastPBuy] + COOLDOWN_CMD_PBUY) >= tick)
	{
    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
	}

	new bool:found = false;

	for(new i = 0; i < propid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z])) continue;
	    found = true;

	    if(PropInfo[i][sold])
		{
			LangMSG(playerid, RED, ""er"Business is not for sale", ""er"Dieses Business steht nicht zum verkauf");
			break;
		}
		if(PlayerInfo[playerid][Props] >= MAX_PROPS_PER_PLAYER)
		{
			LangMSG(playerid, RED, ""er"You already own a business!", ""er"Du besitzt schon ein Business");
			break;
		}
	    if(_GetPlayerScore(playerid) < PropInfo[i][E_score])
		{
			LangMSG(playerid, RED, ""er"You need more score for this business!", ""er"Du brauchst mehr Score um dir das Business leisten zu können");
			break;
		}
		if(GetPlayerCash(playerid) < PropInfo[i][price])
		{
			LangMSG(playerid, RED, ""er"You need more money to buy this business!", ""er"Du brauchst mehr Geld um dir das Business leisten zu können");
			break;
		}
		strmid(PropInfo[i][Owner], __GetName(playerid), 0, 25, 25);
	    PropInfo[i][sold] = 1;
	    new	nlabel[128],
			string[128];
	    format(nlabel, sizeof(nlabel), ""business_mark"\nOwner: %s\nID: %i\nEarnings: $%i", __GetName(playerid), PropInfo[i][iID], PropInfo[i][earnings]);
	    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, nlabel);
	    DestroyDynamicMapIcon(PropInfo[i][iconid]);
	    PropInfo[i][iconid] = CreateDynamicMapIcon(PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z], 36, 1, -1, -1, -1, 100.0);
	    GivePlayerCash(playerid, -PropInfo[i][price]);
	    PlayerInfo[playerid][PropEarnings] = PropInfo[i][earnings];
	    PropInfo[i][date] = gettime();
	    PlayerInfo[playerid][Props]++;
	    SendInfo(playerid, "~h~~y~Business purchased!", 3500);
	    MySQL_SaveProp(i);
	    MySQL_SavePlayer(playerid);
	    PlayerInfo[playerid][tickLastPBuy] = tick;
	    PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
	    format(nlabel, sizeof(nlabel), ""orange"* "white"%s bought the business %i!", __GetName(playerid), PropInfo[i][iID]);
	    format(string, sizeof(string), ""orange"* "white"%s hat sich das Business %i gekauft!", __GetName(playerid), PropInfo[i][iID]);
	    LangMSGToAll(GREEN, nlabel, string);
	    break;
	}
	if(!found) SendClientMessage(playerid, RED, ""er"You aren´t near of any business!");
	return 1;
}

COMMAND:pbuy(playerid, params[])
{
	cmd_bbuy(playerid, "");
    return 1;
}

COMMAND:buy(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastBuy] + COOLDOWN_CMD_BUY) >= tick)
	{
    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
	}

	new bool:found = false;

	for(new i = 0; i < houseid; i++)
	{
	    if(HouseInfo[i][interior] == 0) continue;

	    if(IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z]))
	    {
	        found = true;
		    if(HouseInfo[i][sold])
			{
				LangMSG(playerid, RED, ""er"House is not buyable", ""er"Dieses Haus kannst du nicht kaufen");
				break;
			}
			if(PlayerInfo[playerid][Houses] >= MAX_HOUSES_PER_PLAYER)
			{
				LangMSG(playerid, RED, ""er"You already own a House!", ""er"Du besitzt schon ein Haus");
				break;
			}
		    if(_GetPlayerScore(playerid) < HouseInfo[i][E_score])
			{
				LangMSG(playerid, RED, ""er"You need more score for this House!", ""er"Du brauchst mehr Score um dir das Haus leisten zu können");
				break;
			}
			if(GetPlayerCash(playerid) < HouseInfo[i][price])
			{
				LangMSG(playerid, RED, ""er"You need more money to buy this House!", ""er"Du brauchst mehr Geld um dir das Haus leisten zu können");
				break;
			}

			strmid(HouseInfo[i][Owner], __GetName(playerid), 0, 25, 25);
		    HouseInfo[i][sold] = 1;

		    new nlabel[128],
				string[128];

		    format(nlabel, sizeof(nlabel), ""house_mark"\nOwner: %s\nID: %i\nInterior: %s", __GetName(playerid), HouseInfo[i][iID], HouseIntTypes[HouseInfo[i][interior]][intname]);
		    UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, nlabel);
		    DestroyDynamicMapIcon(HouseInfo[i][iconid]);
		    DestroyDynamicPickup(HouseInfo[i][pickid]);
		    HouseInfo[i][iconid] = CreateDynamicMapIcon(HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], 32, 1, -1, -1, -1, 100.0);
		    HouseInfo[i][pickid] = CreateDynamicPickup(1272, 1, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], -1, -1, -1, 30.0);
		    GivePlayerCash(playerid, -HouseInfo[i][price]);
		    HouseInfo[i][date] = gettime();
		    PlayerInfo[playerid][Houses]++;
		    SendInfo(playerid, "~h~~y~House bought!", 3500);
		    MySQL_SaveHouse(i);
		    MySQL_SavePlayer(playerid);
		    PlayerInfo[playerid][tickLastBuy] = tick;
		    PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
		    format(nlabel, sizeof(nlabel), ""orange"* "white"%s bought the house %i!", __GetName(playerid), PropInfo[i][iID]);
		    format(string, sizeof(string), ""orange"* "white"%s hat sich das Haus %i gekauft!", __GetName(playerid), PropInfo[i][iID]);
		    LangMSGToAll(GREEN, nlabel, string);
		    break;
		}
		else
		{
		    continue;
		}
	}
	if(!found) SendClientMessage(playerid, RED, ""er"You aren´t near of any house!");
	return 1;
}

COMMAND:bsell(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastPSell] + COOLDOWN_CMD_PSELL) >= tick)
	{
    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
	}

	new bool:found = false;

	for(new i = 0; i < propid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z])) continue;
	    found = true;

	    if(!PropInfo[i][sold])
		{
			LangMSG(playerid, -1, ""er"Business can´t be sold!", ""er"Das Business kann nicht verkauft werden!");
			break;
		}
		if(strcmp(PropInfo[i][Owner], __GetName(playerid)))
		{
			LangMSG(playerid, -1, ""er"You don´t own this Business!", ""er"Dieses Business gehört dir nicht!");
			break;
		}
	    strmid(PropInfo[i][Owner], "ForSale", 0, 25, 25);
	    PropInfo[i][sold] = 0;

	    new nlabel[128],
			string[128];

	    format(nlabel, sizeof(nlabel), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%i\nScore: %i\nEarnings: $%i", PropInfo[i][iID], PropInfo[i][price], PropInfo[i][E_score], PropInfo[i][earnings]);
	    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, nlabel);
	    DestroyDynamicMapIcon(PropInfo[i][iconid]);
	    PropInfo[i][iconid] = CreateDynamicMapIcon(PropInfo[i][E_x],PropInfo[i][E_y],PropInfo[i][E_z], 52, 1, -1, -1, -1, 100.0);
	    PlayerInfo[playerid][PropEarnings] = 0;
	    PlayerInfo[playerid][Props]--;
	    PropInfo[i][date] = 0;
	    GivePlayerCash(playerid, floatround(PropInfo[i][price] / 4));
	    SendInfo(playerid, "~h~~y~Business sold!", 3500);
	    MySQL_SaveProp(i);
	    MySQL_SavePlayer(playerid);
	    PlayerInfo[playerid][tickLastPSell] = tick;
	    PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
	    format(nlabel, sizeof(nlabel), ""orange"* "white"%s sold the business %i!", __GetName(playerid), PropInfo[i][iID]);
	    format(string, sizeof(string), ""orange"* "white"%s hat das Business %i verkauft!", __GetName(playerid), PropInfo[i][iID]);
	    LangMSGToAll(GREEN, nlabel, string);
	    break;
	}
	if(!found) SendClientMessage(playerid, RED, ""er"You aren´t near of any business!");
	return 1;
}

COMMAND:psell(playerid, params[])
{
	cmd_bsell(playerid, "");
	return 1;
}

COMMAND:sell(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastSell] + COOLDOWN_CMD_SELL) >= tick)
	{
    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
	}

    new bool:found = false;

	for(new i = 0; i < houseid; i++)
	{
	    if(HouseInfo[i][interior] == 0) continue;

	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
	    found = true;

	    if(!HouseInfo[i][sold])
		{
			LangMSG(playerid, RED, ""er"House cannot be sold!", ""er"Das Haus kann nicht verkauft werden!");
			break;
		}
	    if(strcmp(HouseInfo[i][Owner], __GetName(playerid)))
		{
			LangMSG(playerid, RED, ""er"You don´t own this house!", ""er"Dieses Haus gehört dir nicht");
			break;
		}
	    strmid(HouseInfo[i][Owner], "ForSale", 0, 25, 25);
	    HouseInfo[i][sold] = 0;
	    HouseInfo[i][locked] = 1;

	    new nlabel[128],
			string[128];

	    format(nlabel, sizeof(nlabel), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%i\nScore: %i\nInterior: %s", HouseInfo[i][iID], HouseInfo[i][price], HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
	    UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, nlabel);
	    DestroyDynamicMapIcon(HouseInfo[i][iconid]);
	    DestroyDynamicPickup(HouseInfo[i][pickid]);
	    HouseInfo[i][iconid] = CreateDynamicMapIcon(HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], 31, 1, -1, -1, -1, 100.0);
	    HouseInfo[i][pickid] = CreateDynamicPickup(1273, 1, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], -1, -1, -1, 30.0);
	    PlayerInfo[playerid][Houses]--;
	    HouseInfo[i][date] = 0;
	    GivePlayerCash(playerid, floatround(HouseInfo[i][price] / 4));
	    SendInfo(playerid, "~h~~y~House sold!", 3500);
	    MySQL_SaveHouse(i);
	    MySQL_SavePlayer(playerid);
	    PlayerInfo[playerid][tickLastSell] = tick;
	    PlayerPlaySound(playerid, 1149, 0.0, 0.0, 0.0);
	    format(nlabel, sizeof(nlabel), ""orange"* "white"%s sold the house %i!", __GetName(playerid), PropInfo[i][iID]);
	    format(string, sizeof(string), ""orange"* "white"%s hat das Haus %i verkauft!", __GetName(playerid), PropInfo[i][iID]);
	    LangMSGToAll(GREEN, nlabel, string);
	    break;
	}
	if(!found) SendClientMessage(playerid, RED, ""er"You aren´t near of any house!");
	return 1;
}

COMMAND:unlock(playerid, params[])
{
    if(gTeam[playerid] == NORMAL)
    {
		if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER || GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		    if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][PV_Vehicle])
		    {
      			for(new i = 0; i < MAX_PLAYERS; i++)
			    {
			        if(i == playerid) continue;
			        SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid), i, 0, 0);
			        PlayerPlaySound(playerid, 1027, 0.0, 0.0, 0.0);
			    }
			    return SendInfo(playerid, "~h~~r~Unlocked!", 2000);
		    }
		    else LangMSG(playerid, -1, ""er"You are not in your vehicle", ""er"Du bist nicht in deinem Fahrzeug");
		}
    }
    else LangMSG(playerid, -1, NOT_AVAIL, NOT_AVAIL_G);

    return 1;
}

COMMAND:lock(playerid, params[])
{
    if(gTeam[playerid] == NORMAL)
    {
		if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER || GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
		    if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][PV_Vehicle])
		    {
      			for(new i = 0; i < MAX_PLAYERS; i++)
			    {
			        if(i == playerid) continue;
			        SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid), i, 0, 1);
			        PlayerPlaySound(playerid, 1027, 0.0, 0.0, 0.0);
			    }
			    return SendInfo(playerid, "~h~~g~Locked!", 2000);
		    }
		}
    }

	if(gTeam[playerid] == NORMAL || gTeam[playerid] == HOUSE)
	{
		new tick = GetTickCount() + 3600000;

		if((PlayerInfo[playerid][tickLastLocked] + COOLDOWN_CMD_LOCK) >= tick)
		{
	    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
		}

	    new bool:found = false;
		for(new i = 0; i < houseid; i++)
		{
			if(HouseInfo[i][interior] == 0) continue;

			if(IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z]))
			{
				found = true;
				if(strcmp(HouseInfo[i][Owner], __GetName(playerid)))
				{
					LangMSG(playerid, RED, ""er"This isn´t your House!", ""er"Dieses Haus gehört dir nicht!");
					break;
				}
				if(!HouseInfo[i][locked])
				{
					GameTextForPlayer(playerid, "~b~House ~r~locked", 2000, 3);
				}
				else GameTextForPlayer(playerid, "~b~House ~g~unlocked", 2000, 3);

	   			HouseInfo[i][locked] = (HouseInfo[i][locked]) ? (0) : (1);
	            PlayerPlaySound(playerid, 1027, 0.0, 0.0, 0.0);
	            MySQL_SaveHouse(i);
			}
			else if(IsPlayerInRangeOfPoint(playerid, 50.0, HouseIntTypes[HouseInfo[i][interior]][house_x], HouseIntTypes[HouseInfo[i][interior]][house_y], HouseIntTypes[HouseInfo[i][interior]][house_z]) && GetPlayerInterior(playerid) == HouseIntTypes[HouseInfo[i][interior]][interior] && GetPlayerVirtualWorld(playerid) == (HouseInfo[i][iID] + 1000))
			{
				found = true;
				if(strcmp(HouseInfo[i][Owner], __GetName(playerid)))
				{
					LangMSG(playerid, RED, ""er"This isn´t your House!", ""er"Dieses Haus gehört dir nicht!");
					break;
				}
				if(!HouseInfo[i][locked])
				{
					GameTextForPlayer(playerid, "~b~House ~r~locked", 2000, 3);
				}
				else GameTextForPlayer(playerid, "~b~House ~g~unlocked", 2000, 3);

	            HouseInfo[i][locked] = (HouseInfo[i][locked]) ? (0) : (1);
	            PlayerPlaySound(playerid, 1027, 0.0, 0.0, 0.0);
	            MySQL_SaveHouse(i);
			}
			else continue;
		}
		PlayerInfo[playerid][tickLastLocked] = tick;
		if(!found) SendClientMessage(playerid, RED, ""er"You aren´t near of any house!");
	}
	else LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	return 1;
}

COMMAND:bg(playerid, params[])
{
    cmd_tdm(playerid,params);
	return 1;
}

COMMAND:gg(playerid, params[])
{
	cmd_gungame(playerid, "");
	return 1;
}

COMMAND:gungame(playerid, params[])
{
	if(gTeam[playerid] == GUNGAME) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	GunGamePlayers++;
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 1338);
	
	GunGame_Player[playerid][level] = 0;
	GunGame_Player[playerid][dead] = true;
	GunGame_Player[playerid][pw] = true;
	
	gTeam[playerid] = GUNGAME;
	
	new rand = random(9);
	ResetPlayerWeapons(playerid);

	SetPlayerPosEx(playerid, GunGame_Spawns[rand][0], GunGame_Spawns[rand][1], floatadd(GunGame_Spawns[rand][2], 8.0));
	SetPlayerFacingAngle(playerid, GunGame_Spawns[rand][3]);
	SetCameraBehindPlayer(playerid);

	GivePlayerWeapon(playerid, 4, 1);
	GivePlayerWeapon(playerid, GunGame_Weapons[GunGame_Player[playerid][level]], 65535);

	GunGame_Player[playerid][dead] = false;
	GunGame_Player[playerid][pw] = true;
	
	if(GunGamePlayers >= 16) SetPlayerHealth(playerid, 100.0);
	else SetPlayerHealth(playerid, ((20) + (5 * GunGamePlayers)));
	
	ShowPlayerGunGameTextdraws(playerid);
	NewMinigameJoin(playerid, "Gungame", "gungame");
	return 1;
}

COMMAND:tdm(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(gTeam[playerid] == gBG_VOTING || gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return cmd_exit(playerid, "");

    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	SetPlayerVirtualWorld(playerid, BG_WORLD);
	SetPlayerInterior(playerid, 0);
	ResetPlayerWeapons(playerid);

	if(CurrentBGMap == BG_VOTING)
	{
	    SetPlayerBGStaticMeshes(playerid);
		gTeam[playerid] = gBG_VOTING;
		ShowDialog(playerid, BGVOTING_DIALOG);
		ShowPlayerBGTextdraws(playerid);
	}
	else if(CurrentBGMap == BG_MAP1)
	{
		ShowPlayerBGTextdraws(playerid);

	    if(BGTeam1Players > BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP1, BG_TEAM2);
	    	BGTeam2Players++;
	    	SetPlayerBGTeam2(playerid);
	    	gTeam[playerid] = gBG_TEAM2;
		}
		else if(BGTeam1Players < BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP1, BG_TEAM1);
	    	BGTeam1Players++;
	    	SetPlayerBGTeam1(playerid);
	    	gTeam[playerid] = gBG_TEAM1;
		}
		else
		{
		    RandomBGSpawn(playerid, BG_MAP1, BG_TEAM1);
		    BGTeam1Players++;
		    SetPlayerBGTeam1(playerid);
		    gTeam[playerid] = gBG_TEAM1;
		}
	}
	else if(CurrentBGMap == BG_MAP2)
	{
	    SetPlayerVirtualWorld(playerid, BG_WORLD);
	    SetPlayerInterior(playerid, 0);

		ShowPlayerBGTextdraws(playerid);
	    ResetPlayerWeapons(playerid);

	    if(BGTeam1Players > BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP2, BG_TEAM2);
	    	BGTeam2Players++;
	    	SetPlayerBGTeam2(playerid);
	    	gTeam[playerid] = gBG_TEAM2;
		}
		else if(BGTeam1Players < BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP2, BG_TEAM1);
	    	BGTeam1Players++;
	    	SetPlayerBGTeam1(playerid);
	    	gTeam[playerid] = gBG_TEAM1;
		}
		else
		{
		    RandomBGSpawn(playerid, BG_MAP2, BG_TEAM1);
		    BGTeam1Players++;
		    SetPlayerBGTeam1(playerid);
		    gTeam[playerid] = gBG_TEAM1;
		}
	}
	else if(CurrentBGMap == BG_MAP3)
	{
	    SetPlayerVirtualWorld(playerid, BG_WORLD);
	    SetPlayerInterior(playerid, 0);

		ShowPlayerBGTextdraws(playerid);
	    ResetPlayerWeapons(playerid);

	    if(BGTeam1Players > BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP3, BG_TEAM2);
	    	BGTeam2Players++;
	    	SetPlayerBGTeam2(playerid);
	    	gTeam[playerid] = gBG_TEAM2;
		}
		else if(BGTeam1Players < BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP3, BG_TEAM1);
	    	BGTeam1Players++;
	    	SetPlayerBGTeam1(playerid);
	    	gTeam[playerid] = gBG_TEAM1;
		}
		else
		{
		    RandomBGSpawn(playerid, BG_MAP3, BG_TEAM1);
		    BGTeam1Players++;
		    SetPlayerBGTeam1(playerid);
		    gTeam[playerid] = gBG_TEAM1;
		}
	}
	else if(CurrentBGMap == BG_MAP4)
	{
	    SetPlayerVirtualWorld(playerid, BG_WORLD);
	    SetPlayerInterior(playerid, 0);

		ShowPlayerBGTextdraws(playerid);
	    ResetPlayerWeapons(playerid);

	    if(BGTeam1Players > BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP4, BG_TEAM2);
	    	BGTeam2Players++;
	    	SetPlayerBGTeam2(playerid);
	    	gTeam[playerid] = gBG_TEAM2;
		}
		else if(BGTeam1Players < BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP4, BG_TEAM1);
	    	BGTeam1Players++;
	    	SetPlayerBGTeam1(playerid);
	    	gTeam[playerid] = gBG_TEAM1;
		}
		else
		{
		    RandomBGSpawn(playerid, BG_MAP4, BG_TEAM1);
		    BGTeam1Players++;
		    SetPlayerBGTeam1(playerid);
		    gTeam[playerid] = gBG_TEAM1;
		}
	}
	else if(CurrentBGMap == BG_MAP5)
	{
	    SetPlayerVirtualWorld(playerid, BG_WORLD);
	    SetPlayerInterior(playerid, 0);

		ShowPlayerBGTextdraws(playerid);
	    ResetPlayerWeapons(playerid);

	    if(BGTeam1Players > BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP5, BG_TEAM2);
	    	BGTeam2Players++;
	    	SetPlayerBGTeam2(playerid);
	    	gTeam[playerid] = gBG_TEAM2;
		}
		else if(BGTeam1Players < BGTeam2Players)
	    {
	    	RandomBGSpawn(playerid, BG_MAP5, BG_TEAM1);
	    	BGTeam1Players++;
	    	SetPlayerBGTeam1(playerid);
	    	gTeam[playerid] = gBG_TEAM1;
		}
		else
		{
		    RandomBGSpawn(playerid, BG_MAP5, BG_TEAM1);
		    BGTeam1Players++;
		    SetPlayerBGTeam1(playerid);
		    gTeam[playerid] = gBG_TEAM1;
		}
	}
	NewMinigameJoin(playerid, "TDM", "tdm");
	return 1;
}

COMMAND:ahelp(playerid, params[])
{
	cmd_adminhelp(playerid, "");
	return 1;
}

COMMAND:adminhelp(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
		SendClientMessage(playerid, RED, ""red"Level 1: "yellow"/warn /slap /reports /spec /specoff /id");
		SendClientMessage(playerid, RED, ""red"Level 2: "yellow"/online /offline /onduty /offduty /asay /kick /mute /unmute /move");
		SendClientMessage(playerid, RED, ""red"Level 3: "yellow"/freeze /unfreeze /eject /go /ban /burn");
		SendClientMessage(playerid, RED, ""red"Level 4: "yellow"/sethealth /get /ip /clearchat /healall /armorall /setallweather /cashfall /scorefall");
		SendClientMessage(playerid, RED, ""red"Level 5: "yellow"/setcash /setscore /announce");
	}
  	else
	{
  		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:minigun(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    if(gTeam[playerid] == MINIGUN) return cmd_exit(playerid, "");
    
    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	gTeam[playerid] = MINIGUN;

	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 38, 99999);

   	SetPlayerVirtualWorld(playerid, MINIGUN_WORLD);
	SetPlayerInterior(playerid, 0);

	HidePlayerMeshTXT(playerid);

	new rand = random(11);

	SetPlayerPos(playerid, Minigun_Spawns[rand][0], Minigun_Spawns[rand][1], Minigun_Spawns[rand][2]);
	SetPlayerFacingAngle(playerid, Minigun_Spawns[rand][3]);

    NewMinigameJoin(playerid, "Minigun", "minigun");
    return 1;
}

COMMAND:sniper(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(gTeam[playerid] == SNIPER) return cmd_exit(playerid, "");

    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	gTeam[playerid] = SNIPER;
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 34, 99999);
	SetPlayerVirtualWorld(playerid, SNIPER_WORLD);
	SetPlayerInterior(playerid, 0);

	new rand = random(7);
	SetPlayerPosEx(playerid, Sniper_Spawns[rand][0], Sniper_Spawns[rand][1], Sniper_Spawns[rand][2]+2.5);
	SetPlayerFacingAngle(playerid, Sniper_Spawns[rand][3]);

	HidePlayerMeshTXT(playerid);

	NewMinigameJoin(playerid, "Sniper", "sniper");
   	return 1;
}

COMMAND:bounties(playerid, params[])
{
	new count1 = 0;
	LangMSG(playerid, WHITE, "================Current bounties================", "================Kopfgelder================");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerAvail(i) && PlayerInfo[i][HitmanHit] > 0)
		{
			new bstring[100], gstring[100];
			format(bstring, sizeof(bstring), "Hit on %s(%i) for $%i", __GetName(i), i, PlayerInfo[i][HitmanHit]);
			format(gstring, sizeof(bstring), "Kopfgeld auf %s(%i) für $%i", __GetName(i), i, PlayerInfo[i][HitmanHit]);
			LangMSG(playerid, GREY, bstring, gstring);
			count1++;
		}
	}
	if(count1 == 0)
	{
		LangMSG(playerid, RED, "No bounties at the moment", "Keine Kopfgelder derzeit!");
	}
	SendClientMessage(playerid, WHITE, "================================================");
	return 1;
}

COMMAND:ff(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	new Float:POS[3];
	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
	SetPlayerPos(playerid, POS[0], POS[1], floatadd(POS[2], 700.0));
	return cmd_parch(playerid, "");
}

COMMAND:leave(playerid, params[])
{
	cmd_exit(playerid, params);
	return 1;
}

COMMAND:exit(playerid, params[])
{
	switch(gTeam[playerid])
	{
	    case NORMAL:
	    {
	        LangMSG(playerid, RED, ""er"You can´t use this command now!", ""er"Du kannst diesen Befehl gerade nicht nutzen!");
	        return true;
	    }
	    case BUYCAR :
	    {
			SetPlayerInterior(playerid, 0);
		    SetPlayerPosEx(playerid, 1798.0952, -1410.8192, floatadd(13.5458, 4.5));
		    RandomWeapon(playerid);
			gTeam[playerid] = NORMAL;
			return true;
	    }
	    case STORE :
	    {
	        LangMSG(playerid, RED, ""er"Leave the store by entering the pickup", ""er"Geh in das Pickup um den Store zu verlassen");
	        return true;
	    }
	    case MINIGUN, SNIPER :
	    {
			gTeam[playerid] = NORMAL;
			ResetPlayerWeapons(playerid);
			RandomWeapon(playerid);
			RandomSpawn(playerid);
			ResetPlayerWorld(playerid);
			ShowPlayerMeshTXT(playerid);
			return true;
	    }
		case HOUSE:
		{
		    new bool:found = false;
			for(new i = 0; i < houseid; i++)
			{
		    	if(IsPlayerInRangeOfPoint(playerid, 10000.0, HouseIntTypes[HouseInfo[i][interior]][house_x], HouseIntTypes[HouseInfo[i][interior]][house_y], HouseIntTypes[HouseInfo[i][interior]][house_z]) && GetPlayerInterior(playerid) == HouseIntTypes[HouseInfo[i][interior]][interior] && GetPlayerVirtualWorld(playerid) == (HouseInfo[i][iID] + 1000))
				{
				    found = true;
			    	SetPlayerPos(playerid, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z]);
			    	SetPlayerInterior(playerid, 0);
			    	SetPlayerVirtualWorld(playerid, 0);
			    	gTeam[playerid] = NORMAL;
			    	return true;
		    	}
		    	else continue;
			}
			if(!found) return LangMSG(playerid, RED, "Go to the house door to exit!", "Du musst bei der Haustür sein um zu verlassen!");
		}
		case gBG_VOTING:
		{
		    HidePlayerBGTextdraws(playerid);
		    SetPlayerColor(playerid, PlayerColors[random(sizeof(PlayerColors))]);
		    SetPlayerTeam(playerid, NO_TEAM);
		    gTeam[playerid] = NORMAL;
			SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, true);
			RandomSpawn(playerid);
			RandomWeapon(playerid);
			ResetPlayerWorld(playerid);
			SetPlayerHealth(playerid, 100.0);
			return true;
		}
		case gBG_TEAM1:
		{
		    HidePlayerBGTextdraws(playerid);
		    SetPlayerColor(playerid, PlayerColors[random(sizeof(PlayerColors))]);
			SetPlayerTeam(playerid, NO_TEAM);
		    BGTeam1Players--;
		    gTeam[playerid] = NORMAL;
			RandomSpawn(playerid);
			RandomWeapon(playerid);
			ResetPlayerWorld(playerid);
			SetPlayerHealth(playerid, 100.0);
			return true;
		}
		case gBG_TEAM2:
		{
		    HidePlayerBGTextdraws(playerid);
		    SetPlayerColor(playerid, PlayerColors[random(sizeof(PlayerColors))]);
		    SetPlayerTeam(playerid, NO_TEAM);
		    BGTeam2Players--;
		    gTeam[playerid] = NORMAL;
			RandomSpawn(playerid);
			RandomWeapon(playerid);
			ResetPlayerWorld(playerid);
			SetPlayerHealth(playerid, 100.0);
			return true;
		}
		case DM:
		{
			gTeam[playerid] = NORMAL;
			RandomWeapon(playerid);
			RandomSpawn(playerid);
			ResetPlayerWorld(playerid);
			HidePlayerDMTextdraws(playerid);
			return true;
		}
		case DERBY:
		{
		    //exit
            
		    HidePlayerDerbyTextdraws(playerid);
		    SetPlayerVirtualWorld(playerid, 0);
		    SetPlayerHealth(playerid, 100.0);
		    SetCameraBehindPlayer(playerid);
			TogglePlayerControllable(playerid, true);
			RandomSpawn(playerid);
			RandomWeapon(playerid);
		    gTeam[playerid] = NORMAL;

            DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);

		    if(bDerbyAFK[playerid])
			{
		        return 1;
		    }
		    
		    CurrentDerbyPlayers--;

			if(!IsDerbyRunning)
			{
				if(CurrentDerbyPlayers < 2)
				{
				    ClearDerbyVotes();
					ExecDerbyVotingTimer();
				}
				return 1;
			}
			else if(IsDerbyRunning && DerbyWinner[playerid])
			{
			    if(pDerbyCar[playerid] != -1)
			    {
			    	DestroyVehicle(pDerbyCar[playerid]);
			    	pDerbyCar[playerid] = -1;
				}
				DerbyPlayers--;
				DerbyWinner[playerid] = false;
				if(DerbyPlayers == 1) Derby();
			}
			return true;
		}
		case FALLOUT :
		{
			gTeam[playerid] = NORMAL;
			
		    TogglePlayerControllable(playerid, true);
		    RandomSpawn(playerid);
		    RandomWeapon(playerid);
		    HidePlayerFalloutTextdraws(playerid);
		    ResetPlayerWorld(playerid);
		    CurrentFalloutPlayers--;
            PlayerInfo[playerid][FalloutLost] = true;
		    new count;
			for(new i; i<MAX_PLAYERS; i++)
			{
			    if(!IsPlayerAvail(i)) continue;
			    if(gTeam[i] == FALLOUT) count++;
			}

			if(count < 2)
			{
			    KillTimer(Info[I_iTimer][1]);
			    
				for(new i; i < MAX_PLAYERS; i++)
				{
				    if(gTeam[i] == FALLOUT)
				    {
				    	TogglePlayerControllable(i, true);
					    RandomSpawn(i);
					    RandomWeapon(i);
					    HidePlayerFalloutTextdraws(i);
					    ResetPlayerWorld(i);
					    FalloutMSG("Fallout has been canceled!", "Fallout wurde wegen zu wenigen Spielern abgebrochen!");
						gTeam[i] = NORMAL;
				    }
				}
				Fallout_Cancel();
			}
			return true;
		}
		case GUNGAME :
		{
		    ResetPlayerWorld(playerid);
  			gTeam[playerid] = NORMAL;

	    	RandomSpawn(playerid);
	    	RandomWeapon(playerid);
	    	SetCameraBehindPlayer(playerid);
	    	GunGamePlayers--;
	    	HidePlayerGunGameTextdraws(playerid);
	    	return true;
		}
		case RACE :
		{
			RaceJoinCount--;
			gTeam[playerid] = NORMAL;
			if(PlayerRaceVehicle[playerid] != -1)
			{
				DestroyVehicle(PlayerRaceVehicle[playerid]);
				PlayerRaceVehicle[playerid] = -1;
			}
	    	DisablePlayerRaceCheckpoint(playerid);
			CPProgess[playerid] = 0;
			TogglePlayerControllable(playerid, true);
			SetCameraBehindPlayer(playerid);
			ResetPlayerWorld(playerid);
			RandomWeapon(playerid);
			RandomSpawn(playerid);
			HidePlayerRaceTextdraws(playerid);
			return true;
		}
		default:
		{
			gTeam[playerid] = NORMAL;
			RandomWeapon(playerid);
			RandomSpawn(playerid);
			ResetPlayerWorld(playerid);
			ShowPlayerMeshTXT(playerid);
			return true;
		}
	}
	return 1;
}

COMMAND:setspawn(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, GREY, NOT_AVAIL, NOT_AVAIL_G);
    if(GetPlayerInterior(playerid) != 0) return LangMSG(playerid, GREY, ""er"Wrong interior", ""er"Falscher Interior");
    
    GetPlayerPos(playerid, PlayerInfo[playerid][CSpawnX], PlayerInfo[playerid][CSpawnY], PlayerInfo[playerid][CSpawnZ]);
    GetPlayerFacingAngle(playerid, PlayerInfo[playerid][CSpawnA]);
    PlayerInfo[playerid][bHasSpawn] = true;
    
	LangMSG(playerid, YELLOW, "You will now spawn here!", "Du wirst hier nun gespawnt werden!");
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	return 1;
}

COMMAND:eng(playerid, params[])
{
	PlayerInfo[playerid][Lang] = 0;
	SendClientMessage(playerid, YELLOW, "You have set your language to English.");
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	return 1;
}

COMMAND:ger(playerid, params[])
{
	PlayerInfo[playerid][Lang] = 1;
	SendClientMessage(playerid, YELLOW, "Du hast deine Sprache auf Deutsch umgestellt.");
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	return 1;
}

COMMAND:radio(playerid, params[])
{
    ShowDialog(playerid, STREAM_DIALOG);
    return 1;
}

COMMAND:streams(playerid, params[])
{
    ShowDialog(playerid, STREAM_DIALOG);
    return 1;
}

COMMAND:stopstreams(playerid, params[])
{
    StopAudioStreamForPlayer(playerid);
    return 1;
}

COMMAND:stopstream(playerid, params[])
{
    StopAudioStreamForPlayer(playerid);
    return 1;
}

COMMAND:hitman(playerid, params[])
{
	new amount, player;
	if(sscanf(params, "ri", player, amount))
	{
		return SendClientMessage(playerid, ORANGE, "Usage: /hitman <playerid> <amount>");
	}
	
	if(amount < 5000 || amount > 1000000)
	{
	    return SendClientMessage(playerid, RED, ""er"$5,000 - $1,000,000!");
	}
	
	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastHitman] + COOLDOWN_CMD_HITMAN) >= tick) return LangMSG(playerid, RED, ""er"You have to wait a bit before using it again!", ""er"Du musst ein wenig warten bevor du den Befehl wieder nutzen kannst!");

	if(IsPlayerAvail(player) && player != playerid)
	{
		if(GetPlayerCash(playerid) >= amount)
		{
		    new string[128], gstring[128];
		    
		    if(PlayerInfo[player][HitmanHit] == 0)
		    {
		        PlayerInfo[player][HitmanHit] = PlayerInfo[player][HitmanHit] += amount;
				format(string, sizeof(string), "» %s(%i) has placed a bounty on %s(%i) for $%i get him!", __GetName(playerid), playerid, __GetName(player), player, amount);
				format(gstring, sizeof(gstring), "» Kopfgeld wurde von %s(%i) auf %s(%i) für $%i gesetzt!", __GetName(playerid), playerid, __GetName(player), player, amount);
				LangMSGToAll(YELLOW, string, gstring);
				format(string, sizeof(string), "You´ve placed a bounty on %s(%i) for $%i", __GetName(player), player, amount);
                format(gstring, sizeof(gstring), "Kopfgeld gesetzt auf %s(%i) für $%i", __GetName(player), player, amount);
				LangMSG(playerid, YELLOW, string, gstring);
		    }
		    else if(PlayerInfo[player][HitmanHit] != 0)
		    {
		        PlayerInfo[player][HitmanHit] += amount;
				format(string, sizeof(string), "» %s(%i) has placed another bounty on %s(%i) for $%i Total: "red"%i", __GetName(playerid), playerid, __GetName(player), player, amount, PlayerInfo[player][HitmanHit]);
				format(gstring, sizeof(gstring), "» %s(%i) hat noch mehr Kopfgeld auf %s(%i) gesetzt $%i Insgesamt: "red"%i", __GetName(playerid), playerid, __GetName(player), player, amount, PlayerInfo[player][HitmanHit]);
				LangMSGToAll(YELLOW, string, gstring);
				format(string, sizeof(string), "You´ve placed a bounty on %s(%i) for $%i", __GetName(player), player, amount);
				format(gstring, sizeof(gstring), "Kopfgeld ausgesetzt %s(%i) for $%i", __GetName(player), player, amount);
				LangMSG(playerid, YELLOW, string, gstring);
		    }
			PlayerInfo[playerid][tickLastHitman] = tick;
			GivePlayerCash(playerid, -amount);
			format(string, sizeof(string), "~r~-$%i", amount);
			GameTextForPlayer(playerid, string, 2000, 1);
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"You do not have enough money!");
		}
	}
	else
	{
		SendClientMessage(playerid, RED, ""er"That player is not connected or yourself");
	}
	return 1;
}

COMMAND:sethealth(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
	    new player, Float:amount;
	    if(sscanf(params, "rf", player, amount))
	    {
	        SendClientMessage(playerid, ORANGE, "Usage: /sethealth <playerid> <health>");
	        return 1;
	    }
	    if(amount > 100) return SendClientMessage(playerid, -1, ""er"Do not set it higher than 100");
 		if(IsPlayerAvail(player))
		{
			new string[128];
			if(player != playerid)
			{
				format(string, sizeof(string), "Admin %s has set your health to %f.", __GetName(playerid), amount);
				SendClientMessage(player, YELLOW, string);
				format(string, sizeof(string), "You have set %s's health to %f.", __GetName(player), amount);
				SendClientMessage(playerid, YELLOW, string);
			}
			else
			{
				format(string, sizeof(string), "You have set your health to %f.", amount);
				SendClientMessage(playerid, YELLOW, string);
			}
			SetPlayerHealth(player, amount);
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:setcash(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 5)
	{
	    new player, amount;
	    if(sscanf(params, "ri", player, amount))
	    {
	        SendClientMessage(playerid, ORANGE, "Usage: /setcash <playerid> <amount>");
	        return 1;
	    }
	    
    	if(amount < 100 || amount > 10000000)
		{
			SendClientMessage(playerid, YELLOW, "Info: $100 - $10,000,000");
			return 1;
		}

		if(IsPlayerAvail(player))
		{
			new string[128];
			if(player != playerid)
			{
				format(string, sizeof(string), "Admin %s has set your cash to $%i.", __GetName(playerid), amount);
				SendClientMessage(player, YELLOW, string);
				format(string, sizeof(string), "You have set %s's cash to $%i.", __GetName(player), amount);
				SendClientMessage(playerid, YELLOW, string);
			}
			else
			{
				format(string, sizeof(string), "You have set your cash to $%i.", amount);
				SendClientMessage(playerid, YELLOW, string);
			}
			SetPlayerCash(player, amount);
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:setscore(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 5)
	{
	    new player, amount;
	    if(sscanf(params, "ri", player, amount))
	    {
	        SendClientMessage(playerid, ORANGE, "Usage: /setscore <playerid> <score>");
	        return 1;
	    }

		if(IsPlayerAvail(player))
		{
			new string[128];
			if(player != playerid)
			{
				format(string, sizeof(string), "Admin %s has set your score to %i.", __GetName(playerid), amount);
				SendClientMessage(player, YELLOW, string);
				format(string, sizeof(string), "You set %s's score to %i.", __GetName(player), amount);
				SendClientMessage(playerid, YELLOW, string);
			}
			else
			{
				format(string, sizeof(string), "You have set your score to %i.", amount);
				SendClientMessage(playerid, YELLOW, string);
			}
			_SetPlayerScore(player, amount);
		}
	 	else
	 	{
		 	SendClientMessage(playerid, RED, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:online(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    SendInfo(playerid, "~h~~g~You will be shown in the list", 2500);
		PlayerInfo[playerid][AOnline] = true;
 	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:offline(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    SendInfo(playerid, "~h~~r~You won't be shown in the list", 2500);
		PlayerInfo[playerid][AOnline] = false;
 	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:onduty(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(PlayerInfo[playerid][Level] >= 2)
	{
		if(!PlayerInfo[playerid][onduty])
		{
			PlayerInfo[playerid][onduty] = true;
			SetPlayerColor(playerid, RED);
			AdminDutyLabel[playerid] = Create3DTextLabel("ADMIN ON DUTY", ADMIN, 0, 0, 0, 70.5, 1);
			Attach3DTextLabelToPlayer(AdminDutyLabel[playerid], playerid, 0.0, 0.0, 0.35);
  			new aonduty[64];
	        format(aonduty, sizeof(aonduty), ""yellow"** "red"Admin %s is now onduty!", __GetName(playerid));
	        SendClientMessageToAll(RED, aonduty);
        	SetPlayerHealth(playerid, 99999.0);
			SetPlayerAttachedObject(playerid, 9, 18646, 2, 0.200000, 0.000000, 0.000000, -0.000000, 90.000000, 0.000000, 0.799999, 0.899999, 1.000000);
		}
		else if(PlayerInfo[playerid][onduty])
		{
			SendClientMessage(playerid, -1, ""er"You are already onduty!");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:offduty(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2)
	{
    	if(PlayerInfo[playerid][onduty])
		{
		    PlayerInfo[playerid][onduty] = false;
        	new offduty[64];
        	Delete3DTextLabel(AdminDutyLabel[playerid]);
        	format(offduty, sizeof(offduty), ""yellow"** "red"Admin %s is now offduty!", __GetName(playerid));
        	SendClientMessageToAll(GREEN, offduty);
        	SetPlayerHealth(playerid, 100.0);
        	RemovePlayerAttachedObject(playerid, 9);
		}
		else if(!PlayerInfo[playerid][onduty])
		{
			SendClientMessage(playerid, -1, ""er"You are not onduty!");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:eject(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /eject <playerid>");
		    return 1;
	  	}
	  	
	  	if(player > 499 || player < 0) return SendClientMessage(playerid, RED, ""er"Invalid player!");
	  	
		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			SendClientMessage(playerid, RED, ""er"You cannot use this command on this admin");
			return 1;
		}

        if(IsPlayerAvail(player) && gTeam[player] == NORMAL)
		{
			if(IsPlayerInAnyVehicle(player))
			{
			    new
					string[128],
					Float:POS[3];

				if(player != playerid)
				{
					format(string, sizeof(string), "Admin %s has ejected you from your vehicle", __GetName(playerid));
					SendClientMessage(player, BLUE, string);
				}
				format(string, sizeof(string), "You have ejected %s from their vehicle", __GetName(player));
				SendClientMessage(playerid, BLUE, string);
    		   	GetPlayerPos(player, POS[0], POS[1], POS[2]);
    		   	SetPlayerPos(player, POS[0], POS[1], POS[2] + 3);
			}
			else
			{
				SendClientMessage(playerid, RED, ""er"Player is not in a vehicle");
			}
	    }
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:burn(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /burn <playerid>");
		    return 1;
	  	}
	  	
	  	if(player > 499 || player < 0) return SendClientMessage(playerid, RED, ""er"Invalid player!");
	  	
		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			SendClientMessage(playerid, -1, ""er" You cannot use this command on this admin");
			return 1;
		}
        if(IsPlayerAvail(player))
		{
		    new string[128],
				Float:POS[3];

			format(string, sizeof(string), "You have burnt %s ", __GetName(player));
			SendClientMessage(playerid, BLUE, string);
			GetPlayerPos(player, POS[0], POS[1], POS[2]);
			CreateExplosion(POS[0], POS[1], POS[2] + 3, 1, 10);
	    }
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:ip(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /ip <playerid>");
		    return 1;
	  	}
	  	
	  	if(player > 499 || player < 0) return SendClientMessage(playerid, RED, ""er"Invalid player!");
	  	
		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			SendClientMessage(playerid, -1, ""er" You cannot use this command on this admin");
			return 1;
		}
        if(IsPlayerAvail(player))
		{
			new string[64];
			format(string, sizeof(string), "%s's ip is '%s'", __GetName(player), __GetIP(player));
			SendClientMessage(playerid, BLUE, string);
	    }
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:kill(playerid, params[])
{
	cmd_spawn(playerid, params);
	return 1;
}

COMMAND:time(playerid, params[])
{
	new string[64], hour, minuite, second;
	gettime(hour, minuite, second);
	format(string, sizeof(string), "~g~|~w~%02i:%02i~g~|", hour, minuite);
	GameTextForPlayer(playerid, string, 3000, 1);
	return 1;
}

COMMAND:car(playerid, params[])
{
	if(gTeam[playerid] == NORMAL)
	{
		if(PlayerInfo[playerid][Vehicle] != -1)
		{
			DestroyVehicle(PlayerInfo[playerid][Vehicle]);
			PlayerInfo[playerid][Vehicle] = -1;
		}

		CarSpawner(playerid, 415);
	}
	else
	{
 		LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	}
	return 1;
}

COMMAND:id(playerid, params[])
{
	if(!strlen(params))
	{
		SendClientMessage(playerid, ORANGE, "Usage: /id <nick/part of nick>");
		return 1;
	}
	new found, string[128], playername[MAX_PLAYER_NAME];
	format(string, sizeof(string), "Searched for: %s ", params);
	SendClientMessage(playerid, GREEN, string);
	for(new i = 0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerAvail(i))
		{
	  		GetPlayerName(i, playername, MAX_PLAYER_NAME);
			new namelen = strlen(playername);
			new bool:searched = false;
	    	for(new pos = 0; pos <= namelen; pos++)
			{
				if(!searched)
				{
					if(strfind(playername, params, true) == pos)
					{
		                found++;
						format(string, sizeof(string), "%i. %s (ID %i)", found, playername, i);
						SendClientMessage(playerid, GREEN, string);
						searched = true;
					}
				}
			}
		}
	}
	if(found == 0) LangMSG(playerid, BLUE, ""er"No players have this in their nick", ""er"Keinen Spieler gefunden");
	return 1;
}

COMMAND:asay(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    extract params -> new string:text[144]; else
	    {
	        return SendClientMessage(playerid, ORANGE, "Usage: /asay <message>");
	    }

		new string:string[144];
		format(string, sizeof(string), ""yellow"** "red"Admin %s: %s", __GetName(playerid), text);
		SendClientMessageToAll(RED, string);
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:announce(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid))
	{
	    extract params -> new string:text[128]; else
	    {
	        return SendClientMessage(playerid, ORANGE, "Usage: /announce <message>");
	    }

		GameTextForAll(text, 4000, 3);
    }
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:jetpack(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	SendClientMessage(playerid, BLUE, "Jetpack spawned!");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}

COMMAND:gotomyhouse(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    if(PlayerInfo[playerid][Houses] == 0) return  LangMSG(playerid, RED, ""er"You got no house!", ""er"Du hast kein Haus!");
    
	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastGoToMyHouse] + COOLDOWN_CMD_GOTOMYHOUSE) >= tick)
	{
    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
	}
    
    PlayerInfo[playerid][tickLastGoToMyHouse] = tick;
    
    new query[200];
    format(query, sizeof(query), "SELECT `x`, `y`, `z` FROM `"#TABLE_HOUSE"` WHERE `Owner` = '%s' LIMIT 1;", __GetName(playerid));
    mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_GOTO_MY_HOUSE, playerid, g_SQL_handle);
	return 1;
}

COMMAND:gotomybusiness(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    if(PlayerInfo[playerid][Props] == 0) return  LangMSG(playerid, RED, ""er"You got no business!", ""er"Du hast kein Business!");

	new tick = GetTickCount() + 3600000;

	if((PlayerInfo[playerid][tickLastGoToMyProp] + COOLDOWN_CMD_GOTOMYPROP) >= tick)
	{
    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
	}

    PlayerInfo[playerid][tickLastGoToMyProp] = tick;

    new query[200];
    format(query, sizeof(query), "SELECT `x`, `y`, `z` FROM `"#TABLE_PROP"` WHERE `Owner` = '%s' LIMIT 1;", __GetName(playerid));
    mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_GOTO_MY_PROP, playerid, g_SQL_handle);
	return 1;
}

COMMAND:gotomybizz(playerid, params[])
{
	cmd_gotomybusiness(playerid, "");
	return 1;
}

COMMAND:gotomyprop(playerid, params[])
{
	cmd_gotomybusiness(playerid, "");
	return 1;
}

COMMAND:tgoto(playerid, params[])
{
	cmd_tgo(playerid, "");
	return 1;
}

COMMAND:tgo(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(PlayerInfo[playerid][bGoTo])
    {
     	LangMSG(playerid, YELLOW, "No player can goto you now!", "Kein Spieler kann sich zu dir porten!");
	}
	else
	{
	    LangMSG(playerid, YELLOW, "Players can goto you now!", "Spieler können sich nun zu dir porten!");
	}
	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	PlayerInfo[playerid][bGoTo] = !PlayerInfo[playerid][bGoTo];
	return 1;
}

COMMAND:goto(playerid, params[])
{
	cmd_go(playerid, params);
	return 1;
}

COMMAND:go(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
    
	if((PlayerInfo[playerid][Level] == 0))
	{
	    if(gTeam[playerid] == NORMAL)
	    {
		    new player;
		 	if(sscanf(params, "u", player))
			{
				SendClientMessage(playerid, ORANGE, "Usage: /go <playerid>");
			    return 1;
		  	}
            if(player > 499 || player < 0) return SendClientMessage(playerid, -1, ""er"Invalid player!");
            if(!PlayerInfo[player][bGoTo]) return LangMSG(playerid, -1, ""er"Player disabled goto!", ""er"Spieler hat goto abgeschalten!");
			if(!IsPlayerNPC(player))
			{
				if(!IsPlayerAvail(player)) return LangMSG(playerid, -1, ""er"Player is not avialable", ""er"Spieler ist nicht verfügbar");
			}
			if(player == playerid) return LangMSG(playerid, -1, ""er"This will not work", ""er"Das geht nicht");
			if(gTeam[player] != NORMAL) return LangMSG(playerid, -1, ""er"Player is in a minigame", ""er"Der Spieler ist in einem Minigame");
			if(PlayerInfo[player][Wanteds] != 0) return LangMSG(playerid, -1, ""er"This player has wanteds", ""er"Dieser Spieler hat Wanteds");
			if(PlayerInfo[player][Level] != 0) return LangMSG(playerid, -1, ""er"You can´t teleport to admins", ""er"Du kannst dich nicht zu admins porten");

			new Float:POS[3],
				string[128],
				gstring[128];

			GetPlayerPos(player, POS[0], POS[1], POS[2]);
			SetPlayerInterior(playerid, GetPlayerInterior(player));
	        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(player));
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				SetVehiclePos(GetPlayerVehicleID(playerid), floatadd(POS[0], 3), POS[1], POS[2]);
				LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(player));
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(player));
			}
			else
			{
				SetPlayerPos(playerid, floatadd(POS[0], 2), POS[1], POS[2]);
			}
			format(string, sizeof(string), "You have teleported to %s!", __GetName(player));
			format(gstring, sizeof(gstring), "Du hast dich zu %s teleportiert!", __GetName(player));
			LangMSG(playerid, BLUE, string, gstring);
			format(string, sizeof(string), "%s has teleported to you!", __GetName(playerid));
			format(gstring, sizeof(gstring), "%s hat sich zu dir geportet!", __GetName(playerid));
			LangMSG(player, BLUE, string, gstring);
			return 1;
		}
		else
		{
		    LangMSG(playerid, RED, "You need to be in normal world", "Das geht jetzt nicht");
		}
	}
	else if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid))
	{
	    new player;
	 	if(sscanf(params, "u", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /go <playerid>");
		    return 1;
	  	}
	  	if(player > 499 || player < 0) return SendClientMessage(playerid, -1, ""er"Invalid player!");
		if(!IsPlayerNPC(player))
		{
			if(!IsPlayerAvail(player)) return LangMSG(playerid, -1, ""er"Player is not avialable", ""er"Spieler ist nicht verfügbar");
		}
		if(gTeam[player] != NORMAL) return LangMSG(playerid, -1, ""er"Player is in a minigame", ""er"Der Spieler ist in einem Minigame");
	 	if(player != INVALID_PLAYER_ID && player != playerid)
	 	{
			new
				Float:POS[3],
				string[128];

			GetPlayerPos(player, POS[0], POS[1], POS[2]);
			SetPlayerInterior(playerid, GetPlayerInterior(player));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(player));
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				SetVehiclePos(GetPlayerVehicleID(playerid), floatadd(POS[0], 2), POS[1], POS[2]);
				LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(player));
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(player));
			}
			else
			{
				SetPlayerPos(playerid, floatadd(POS[0], 2), POS[1], POS[2]);
			}
			format(string, sizeof(string), "You have teleported to %s", __GetName(player));
			SendClientMessage(playerid, BLUE, string);
			return 1;
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or is yourself");
		}
	}
	return 1;
}

COMMAND:get(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /get <playerid>");
		    return 1;
	  	}
	  	if(player > 499 || player < 0) return SendClientMessage(playerid, RED, ""er"Invalid player!");
	  	if(!IsPlayerConnected(player)) return SendClientMessage(playerid, RED, ""er"Player is not connected!");
    	new string[128];
		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			SendClientMessage(playerid, RED, ""er"You cannot use this command on this admin");
			return 1;
		}
	 	if(IsPlayerAvail(player) && player != playerid && gTeam[player] == NORMAL)
	 	{
			new
			    Float:POS[3];

			GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
			SetPlayerInterior(player, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player, GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player) == 2)
			{
			    new VehicleID = GetPlayerVehicleID(player);
				SetVehiclePos(VehicleID, floatadd(POS[0], 2), POS[1], POS[2]);
				LinkVehicleToInterior(VehicleID, GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player), GetPlayerVirtualWorld(playerid));
			}
			else
			{
				SetPlayerPos(player, floatadd(POS[0], 2), POS[1], POS[2]);
			}
			format(string, sizeof(string), "You have been teleported to Admin %s's location", __GetName(playerid));
			SendClientMessage(player, BLUE, string);
			format(string, sizeof(string), "You have teleported %s to your location", __GetName(player));
			SendClientMessage(playerid, BLUE, string);
			return 1;
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or is yourself");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:warn(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1)
	{
 		new player, reason[128];
		if(sscanf(params, "rs[128]", player, reason))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /warn <playerid> <reason>");
		    return 1;
		}

		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL)
		{
			SendClientMessage(playerid, RED, ""er"You cannot use this command on this admin");
			return 1;
		}
	 	if(IsPlayerAvail(player) && player != playerid)
	 	{
	 	    new string[128];
			PlayerInfo[player][Warnings]++;
			if(PlayerInfo[player][Warnings] == MAX_WARNINGS)
			{
				format(string, sizeof(string), ""yellow"** "red"%s has been kicked by console. [Reason: %s] [Warning: %i/%i]", __GetName(player), reason, PlayerInfo[player][Warnings], MAX_WARNINGS);
				SendClientMessageToAll(GREY, string);
				print(string);
				Kick(player);
			}
			else
			{
				format(string, sizeof(string), ""yellow"** "red"Admin %s has given %s a kick warning. [Reason: %s] [Warning: %i/%i]", __GetName(playerid), __GetName(player), reason, PlayerInfo[player][Warnings], MAX_WARNINGS);
				SendClientMessageToAll(YELLOW, string);
			}
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or invalid");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:kick(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2)
	{
 		new player, reason[128];
		if(sscanf(params, "rs[128]", player, reason))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /kick <playerid> <reason>");
		    return 1;
		}
		if(isnull(reason)) return SendClientMessage(playerid, ORANGE, "Usage: /kick <playerid> <reason>");
		if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
		{
		    new string[128];
			format(string, sizeof(string), ""yellow"** "red"%s has been kicked by Admin %s [Reason: %s]", __GetName(player), __GetName(playerid), reason);
			SendClientMessageToAll(YELLOW, string);
			print(string);
			Kick(player);
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or is yourself or is the highest level admin");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:mute(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2)
	{
 		new player, time, reason[128];
		if(sscanf(params, "rds[128]", player, time, reason))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /mute <playerid> <seconds> <reason>");
		    return 1;
		}
		if(PlayerInfo[player][Muted])
		{
			SendClientMessage(playerid, RED, ""er"This player is already muted");
		    return 1;
		}
		if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
		{
		    new string[128], gstring[128];
  			PlayerInfo[player][Muted] = true;
	    	format(string, sizeof(string), ""yellow"** "red"%s has been muted by Admin %s for %i seconds [Reason: %s]", __GetName(player), __GetName(playerid), time, reason);
		    format(gstring, sizeof(gstring), ""yellow"** "red"%s hat von Admin %s für %i Sekunden ein Chat Verbot erhalten [Grund: %s]", __GetName(player), __GetName(playerid), time, reason);
            LangMSGToAll(YELLOW, string, gstring);
			PlayerInfo[player][MuteTimer] = SetTimerEx("unmute", time * 1000, false, "i", player);
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or is yourself or is the highest level admin");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:unmute(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2)
	{
 		new player;
		if(sscanf(params, "r", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /unmute <playerid>");
		    return 1;
		}

		if(!PlayerInfo[player][Muted])
		{
			SendClientMessage(playerid, RED, ""er"This player is not muted");
		    return 1;
		}
		if(IsPlayerAvail(player) && player != playerid)
		{
			PlayerInfo[player][Muted] = false;
			KillTimer(PlayerInfo[player][MuteTimer]);
			LangMSG(player, GREEN, "You have been unmuted!", "Du darfst den Chat wieder benutzen!");
			SendClientMessage(playerid, RED, "Player has been unmuted.");
			new string[128];
			format(string, sizeof(string), ""yellow"** "red"%s has been unmuted by Admin %s", __GetName(player), __GetName(playerid));
			SendClientMessageToAll(RED, string);
		}
		else
		{
            SendClientMessage(playerid, RED, ""er"Player isn´t connected or invalid!");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:updateloginsound(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
		return LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	
	if(fexist("Other/loginsound.txt"))
	{
		new File:sound = fopen("Other/loginsound.txt");
		fread(sound, loginsoundlink);
		fclose(sound);
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	}
	else
	{
	    strmid(loginsoundlink, "http://mellnik.bplaced.net/nfewufcghveqg/gfsioghfas/nasduigbfavzfe/agfsufdasdgehauebdqedwabe.mp3", 0, 255, 255);
	    PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0);
	}
	return 1;
}

COMMAND:gcreate(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastGCreate] + COOLDOWN_CMD_GCREATE) >= tick)
	{
		return LangMSG(playerid, -1, ""er"Please wait a bit before using this command again!", ""er"Warte ein wenig bevor den Befehl wieder nutzt!");
	}

	if(PlayerInfo[playerid][IsInGang] != 0) return LangMSG(playerid, RED, ""er"You are already in a gang", ""er"Du bist schon in einer Gang");
	if(GetPlayerCash(playerid) < 1000000) return LangMSG(playerid, RED, ""er"You need at least "orange"$1,000,000 "white"for creating a gang!", ""er"Du brauchs mindestens "orange"$1,000,000 "white"um eine Gang erstellen zu können!");
 	if(_GetPlayerScore(playerid) < 1000) return LangMSG(playerid, RED, ""er"You need at least "orange"1,000 Score "white"for creating a gang!", ""er"Du brauchs mindestens "orange"1,000 Score "white"um eine Gang erstellen zu können!");

	new ntmp[144],
	    ttmp[144];

	if(sscanf(params, "s[144]s[144]", ntmp, ttmp))
	{
	    return SendClientMessage(playerid, ORANGE, "Usage: /gcreate <gang-name> <gang-tag>");
	}
	if(strlen(ntmp) > MAX_GANG_NAME || strlen(ntmp) < MIN_GANG_NAME || isnull(ntmp))
	{
	    CancelGangCreation(playerid);
	    return LangMSG(playerid, -1, ""er"Gang name length: 4 - 20 characters", ""er"Gang Name Länge: 4 - 20 Zeichen");
	}
	if(strlen(ttmp) > 4 || strlen(ttmp) < 2 || isnull(ttmp))
	{
	    CancelGangCreation(playerid);
	    return LangMSG(playerid, -1, ""er"Gang tag length: 2 - 4 characters", ""er"Gang Tag Länge: 2 - 4 Zeichen");
	}
	
	
	if(!strcmp(__GetName(playerid), ntmp, true))
	{
	    CancelGangCreation(playerid);
	    return LangMSG(playerid, -1, ""er"Dont name your gang as your nick", ""er"Deine Gang darf nicht so heißen wie du");
	}
    if(strfind(ntmp, " ", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"Spaces are not allowed", ""er"Keine Leerzeichen erlaubt");
	}
    if(strfind(ntmp, "-", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"- ist not allowed", ""er"- ist nicht erlaubt");
	}
    if(strfind(ntmp, "|", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"| ist not allowed", ""er"| ist nicht erlaubt");
	}
    if(strfind(ntmp, "@", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"@ ist not allowed", ""er"@ ist nicht erlaubt");
	}
    if(strfind(ntmp, "*", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"* ist not allowed", ""er"* ist nicht erlaubt");
	}
    if(strfind(ntmp, "'", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"' ist not allowed", ""er"' ist nicht erlaubt");
	}
    if((strfind(ntmp, "`", false) != -1) || (strfind(ntmp, "´", false) != -1))
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"`´ ist not allowed", ""er"`´ ist nicht erlaubt");
	}
    if(strfind(ntmp, "admin", false) != -1)
	{
	    CancelGangCreation(playerid);
		return LangMSG(playerid, -1, ""er"Not possible", ""er"Nicht möglich");
	}
	mysql_real_escape_string(ntmp, PlayerInfo[playerid][GangName], g_SQL_handle, 21);
	/*
	GANG NAME IS OK
	*/

	if(!strcmp(__GetName(playerid), ttmp, true))
	{
	    CancelGangCreation(playerid);
	    return LangMSG(playerid, -1, ""er"Dont tag your gang as your nick", ""er"Dein Gang Tag darf nicht so heißen wie du");
	}
    if(strfind(ttmp, " ", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"Spaces are not allowed", ""er"Keine Leerzeichen erlaubt");
	}
    if(strfind(ttmp, "-", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"- ist not allowed", ""er"- ist nicht erlaubt");
	}
    if(strfind(ttmp, "*", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"* ist not allowed", ""er"* ist nicht erlaubt");
	}
    if(strfind(ttmp, "|", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"| ist not allowed", ""er"| ist nicht erlaubt");
	}
    if(strfind(ttmp, "@", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"@ ist not allowed", ""er"@ ist nicht erlaubt");
	}
    if(strfind(ttmp, "'", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"' ist not allowed", ""er"' ist nicht erlaubt");
	}
    if(strfind(ttmp, "`", false) != -1 || strfind(ttmp, "´", false) != -1)
	{
        CancelGangCreation(playerid);
        return LangMSG(playerid, -1, ""er"`´ ist not allowed", ""er"`´ ist nicht erlaubt");
	}
    if(strfind(ttmp, "admin", false) != -1)
	{
	    CancelGangCreation(playerid);
		return LangMSG(playerid, -1, ""er"Not possible", ""er"Nicht möglich");
	}
	if((strfind(ttmp, "[", true) != -1) || (strfind(ttmp, "]", true) != -1))
	{
	 	CancelGangCreation(playerid);
		return LangMSG(playerid, RED, ""er"Do not add [ or ]", ""er"[ ] wird automatisch hinzugefügt");
	}
	mysql_real_escape_string(ttmp, PlayerInfo[playerid][GangTag], g_SQL_handle, 5);
	/*
	GANG TAG IS OK
	*/

    PlayerInfo[playerid][tickLastGCreate] = tick;
    MySQL_ExistGang(playerid);
	return 1;
}

COMMAND:ginvite(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	new
		tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastGInvite] + COOLDOWN_CMD_GINVITE) >= tick) return LangMSG(playerid, -1, ""er"Please wait a bit before inviting again!", ""er"Warte ein wenig bevor du wieder einlädst!");

	if(PlayerInfo[playerid][IsInGang] != 2)	return LangMSG(playerid, -1, ""er"You have to be the gang leader to invite players", ""er"Du musst Ganganführer sein um Spieler einzuladen");

	new player;
	if(sscanf(params, "r", player))
	{
        return SendClientMessage(playerid, ORANGE, "Usage: /ginvite <playerid>");
	}
	
	new Float:pPOS[3];
	GetPlayerPos(player, pPOS[0], pPOS[1], pPOS[2]);
	if(!IsPlayerInRangeOfPoint(playerid, 4.5, pPOS[0], pPOS[1], pPOS[2]))
	{
	    return LangMSG(playerid, -1, ""er"You need to be near that player!", ""er"Du bist nicht nah genug an dem Spieler dran");
	}

    if(player == playerid) return LangMSG(playerid, RED, ""er"You can´t invite yourself", ""er"Du kannst dich nicht slebst einladen");
	if(IsPlayerNPC(player)) return LangMSG(playerid, -1, ""er"You can´t invite NPCS", ""er"NPCS können nicht invited werden");
    if(PlayerInfo[player][IsInGang] != 0) return LangMSG(playerid, -1, ""er"Player is already in a gang", ""er"Spieler ist schon in einer Gang");

    if(PlayerInfo[player][gInvite]) return LangMSG(playerid, RED, ""er"Player has been already invited by someone else!", ""er"Der Spieler wurde schon von wem anderen eingeladen!");
    if(!IsPlayerAvail(player)) return LangMSG(playerid, RED, ""er"Player is not available!", ""er"Der Spieler ist nicht erreichbar!");
    if(PlayerInfo[player][Level] > 0 && PlayerInfo[playerid][Level] == 0) return LangMSG(playerid, RED, ""er"You can´t invite Admins!", ""er"Du kannst keine Admin einladen!");

    PlayerInfo[player][GangID] = PlayerInfo[playerid][GangID];
	strmid(PlayerInfo[player][GangName], PlayerInfo[playerid][GangName], 0, 21, 21);
	strmid(PlayerInfo[player][GangTag], PlayerInfo[playerid][GangTag], 0, 5, 5);
    PlayerInfo[player][gInvite] = true;

  	new string[255],
	  	gstring[255];

	format(string, sizeof(string), ""gang_sign" %s(%i) invited you to: %s", __GetName(playerid), playerid, PlayerInfo[playerid][GangName]);
	format(gstring, sizeof(gstring), ""gang_sign" %s(%i) hat dich zu seiner Gang eingeladen: %s", __GetName(playerid), playerid, PlayerInfo[playerid][GangName]);
	LangMSG(player, GREY, string, gstring);

	format(string, sizeof(string), ""white"» Invitation has been sent to "yellow"%s(%i)", __GetName(player), player);
	format(gstring, sizeof(gstring), ""white"» Einladung wurde and "yellow"%s(%i) "white"verschickt", __GetName(player), player);
	LangMSG(playerid, GREEN, string, gstring);

	PlayerInfo[playerid][tickLastGInvite] = tick;
	return 1;
}

COMMAND:gdeny(playerid, params[])
{
    if(PlayerInfo[playerid][IsInGang] != 0) return LangMSG(playerid, -1, ""er"You are already in a gang!", ""er"Du bist schon in einer Gang!");
    if(!PlayerInfo[playerid][gInvite]) return LangMSG(playerid, -1, ""er"You haven´t been invited!", ""er"Du wurdest nocht nicht eingeladen!");
    PlayerInfo[playerid][GangID] = 0;
	strmid(PlayerInfo[playerid][GangName], "---", 0, 21, 21);
	strmid(PlayerInfo[playerid][GangTag], "---", 0, 5, 5);
    PlayerInfo[playerid][gInvite] = false;
    LangMSG(playerid, GREEN, "The invitation has been rejected", "Die Einladung wurde abgelehnt");
	return 1;
}

COMMAND:gclose(playerid, params[])
{
    if(PlayerInfo[playerid][IsInGang] == 0) return LangMSG(playerid, -1, ""er"You aren´t in any gang!", ""er"Du bist in keiner gang!");
    if(PlayerInfo[playerid][IsInGang] != 2) return LangMSG(playerid, -1, ""er"You have to be the gang leader!", ""er"Du musst der Gang Leader sein!");

    new query[255];
	format(query, sizeof(query),
	"UPDATE `"#TABLE_ACCOUNT"` SET `IsInGang` = 0, `GangID` = 0, `GangName` = '---', `GangTag` = '---' WHERE `GangID` = %i AND `GangName` = '%s';", PlayerInfo[playerid][GangID], PlayerInfo[playerid][GangName]);
	mysql_function_query(g_SQL_handle, query, false, "", "");

	format(query, sizeof(query),
	"DELETE FROM `"#TABLE_GANG"` WHERE `ID` = %i LIMIT 1;", PlayerInfo[playerid][GangID]);
	mysql_function_query(g_SQL_handle, query, false, "", "");

	GangMSG(PlayerInfo[playerid][GangID], ""gang_sign" The gang has been closed by it's Leader", ""gang_sign" Die Gang wurde vom Leader geschlossen");

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i) && i != playerid)
	    {
	        if(PlayerInfo[i][GangID] != PlayerInfo[playerid][GangID]) continue;
	        PlayerInfo[i][gInvite] = false;
	        PlayerInfo[i][GangID] = 0;
	        PlayerInfo[i][IsInGang] = 0;
			strmid(PlayerInfo[i][GangName], "---", 0, 21, 21);
			strmid(PlayerInfo[i][GangTag], "---", 0, 5, 5);
			DestroyDynamic3DTextLabel(PlayerInfo[i][GangLabel]);
			MySQL_SavePlayer(i);
	    }
	}

    PlayerInfo[playerid][GangID] = 0;
    PlayerInfo[playerid][IsInGang] = 0;
	strmid(PlayerInfo[playerid][GangName], "---", 0, 21, 21);
	strmid(PlayerInfo[playerid][GangTag], "---", 0, 5, 5);
	DestroyDynamic3DTextLabel(PlayerInfo[playerid][GangLabel]);
	MySQL_SavePlayer(playerid);
	LangMSG(playerid, -1, ""gang_sign" The gang has been closed!", ""gang_sign" Die Gang wurde geschlossen");
	return 1;
}

COMMAND:gjoin(playerid, params[])
{
    if(PlayerInfo[playerid][IsInGang] != 0) return LangMSG(playerid, -1, ""er"You are already in a gang!", ""er"Du bist schon in einer Gang!");
    if(!PlayerInfo[playerid][gInvite]) return LangMSG(playerid, -1, ""er"You did not get any invitations!", ""er"Du wurdest nicht eingeladen!");

	new
		string[128],
		gstring[128];

	PlayerInfo[playerid][gInvite] = false;
	PlayerInfo[playerid][IsInGang] = 1;

	format(string, sizeof(string), ""gang_sign" You joined the gang ("yellow"%s"white")!", PlayerInfo[playerid][GangName]);
	format(gstring, sizeof(gstring), ""gang_sign" Du bist der Gang ("yellow"%s"white") beigetreten!", PlayerInfo[playerid][GangName]);
	LangMSG(playerid, -1, string, gstring);

	format(string, sizeof(string), ""gang_sign" %s has joined the gang!", __GetName(playerid));
	format(gstring, sizeof(gstring), ""gang_sign" %s ist der Gang beigetreten!", __GetName(playerid));
	GangMSG(PlayerInfo[playerid][GangID], string, gstring);

	format(string, sizeof(string), ""orange"Gang:"white" %s", PlayerInfo[playerid][GangName]);
	PlayerInfo[playerid][GangLabel] = CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);

	MySQL_SavePlayer(playerid);
 	return 1;
}

COMMAND:gmenu(playerid, params[])
{
    if(PlayerInfo[playerid][IsInGang] == 0) return LangMSG(playerid, -1, ""er"You aren´t in any gang!", ""er"Du bist in keiner Gang!");

	ShowDialog(playerid, GMENU_DIALOG);
	return 1;
}

COMMAND:gleave(playerid, params[])
{
    if(PlayerInfo[playerid][IsInGang] == 0) return LangMSG(playerid, -1, ""er"You aren´t in any gang", ""er"Du bist in keiner Gang");
    if(PlayerInfo[playerid][IsInGang] == 2) return LangMSG(playerid, -1, ""er"You cant leave your own gang as leader", ""er"Du kannst sie als Gangleader nicht verlassen");

	strmid(PlayerInfo[playerid][GangName], "---", 0, 21, 21);
	strmid(PlayerInfo[playerid][GangTag], "---", 0, 5, 5);
    PlayerInfo[playerid][IsInGang] = 0;

    new string[128], gstring[128];
	format(string, sizeof(string), ""gang_sign" %s(%i) has left the gang", __GetName(playerid), playerid);
	format(gstring, sizeof(gstring), ""gang_sign" %s(%i) hat die Gang verlassen", __GetName(playerid), playerid);
    GangMSG(PlayerInfo[playerid][GangID], string, gstring);
    LangMSG(playerid, -1, ""gang_sign" You've left your gang!", ""gang_sign" Du hast deine Gang verlassen!");

    PlayerInfo[playerid][GangID] = 0;
    DestroyDynamic3DTextLabel(PlayerInfo[playerid][GangLabel]);

    MySQL_SavePlayer(playerid);
	return 1;
}

COMMAND:gkick(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	new
		tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastGKick] + COOLDOWN_CMD_GKICK) >= tick) return LangMSG(playerid, -1, ""er"Please wait a bit before kicking again!", ""er"Warte ein wenig bevor du wieder kickst!");

    if(PlayerInfo[playerid][IsInGang] == 0) return LangMSG(playerid, -1, ""er"You aren´t in any gang", ""er"Du bist in keiner Gang");
	if(PlayerInfo[playerid][IsInGang] != 2) return LangMSG(playerid, -1, ""er"You have to be the gang leader to uninvite players", ""er"Du musst Ganganführer sein");

	if(strlen(params) > MAX_PLAYER_NAME) return LangMSG(playerid, ORANGE, "Usage: /gkick <EXACT PLAYER NAME>", "Usage: /gkick <EXAKTER SPIELERNAME>");
 	if(sscanf(params, "s[25]", PlayerInfo[playerid][GangKickMem])) return LangMSG(playerid, ORANGE, "Usage: /gkick <EXACT PLAYER NAME>", "Usage: /gkick <EXAKTER SPIELERNAME>");

    if(!strcmp(__GetName(playerid), PlayerInfo[playerid][GangKickMem], true))
    {
        return LangMSG(playerid, -1, ""er"You can't kick yourself", ""er"Du kannst dich nicht selbst kicken!");
    }

  	new
  		ID = __GetPlayerID(PlayerInfo[playerid][GangKickMem]);

  	if(ID != INVALID_PLAYER_ID)
  	{
		if(!IsPlayerAvail(ID)) return LangMSG(playerid, -1, ""er"Spieler ist not available", ""er"Spieler ist nicht verfügbar");
		if(IsPlayerNPC(ID)) return LangMSG(playerid, -1, ""er"Spieler ist not available", ""er"Spieler ist nicht verfügbar");
        if(PlayerInfo[ID][GangID] != PlayerInfo[playerid][GangID]) return LangMSG(playerid, RED, ""er"This player is not in your gang!", ""er"Dieser Spieler ist nicht in deiner Gang!");

		strmid(PlayerInfo[ID][GangName], "---", 0, 21, 21);
		strmid(PlayerInfo[ID][GangTag], "---", 0, 5, 5);
		PlayerInfo[ID][GangID] = 0;
  		PlayerInfo[ID][IsInGang] = 0;
    	DestroyDynamic3DTextLabel(PlayerInfo[ID][GangLabel]);

		new
			string[128],
			gstring[128];

   		format(string, sizeof(string), ""gang_sign" %s has been kicked from the gang", PlayerInfo[playerid][GangKickMem]);
   		format(gstring, sizeof(gstring), ""gang_sign" %s wurde aus der Gang gekickt", PlayerInfo[playerid][GangKickMem]);
        GangMSG(PlayerInfo[playerid][GangID], string, gstring);
        LangMSG(ID, -1, ""gang_sign" You have been kicked out of your gang!", ""gang_sign" Du wurdest aus deiner Gang gekickt!");

		MySQL_SavePlayer(ID);
  	}
  	else
  	{
		MySQL_KickFromGangIfExist(playerid);
	}

	PlayerInfo[playerid][tickLastGKick] = tick;
	return 1;
}

COMMAND:ban(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3)
	{
	    new player, reason[80];
	    if(sscanf(params, "rs[80]", player, reason))
	    {
	        return SendClientMessage(playerid, ORANGE, "Usage: /ban <playerid> <reason>");
	    }
        if(player > 499 || player < 0) return SendClientMessage(playerid, RED, ""er"Invalid player!");
	  	if(isnull(reason) || strlen(reason) < 2) return SendClientMessage(playerid, ORANGE, "Usage: /ban <playerid> <reason>");
	  	if(IsPlayerNPC(player)) return SendClientMessage(playerid, RED, ""er"Invalid player!");

	  	if(PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
	  	{
		 	if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
			{
				new string[255];

	   			MySQL_CreateBan(__GetName(player), __GetName(playerid), reason);
	   			MySQL_BanIP(__GetIP(player));
                
				format(string, sizeof(string), ""yellow"** "red"%s has been banned by Admin %s [Reason: %s]", __GetName(player), __GetName(playerid), reason);
				SendClientMessageToAll(YELLOW, string);
				print(string);

	    		format(string, sizeof(string), ""red"You have been banned!"white"\n\nAdmin: \t\t%s\nReason: \t\t%s\n\nIf you think that you have been banned wrongly,\nwrite a ban appeal on forum.ng-stunting.net", __GetName(playerid), reason);
	    		ShowPlayerDialog(player, BAN_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"Notice", string, "OK", "");
	    		Kick(player);
	    		PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0);
				return 1;
			}
			else
			{
				SendClientMessage(playerid, RED, ""er"Player is not connected or is yourself or is the highest level admin");
			}
		}
		else
		{
		    new warnstring[128];
		    format(warnstring, sizeof(warnstring), "OMGLOL: %s just tried to ban you with reason: %s", __GetName(playerid), reason);
		    SendClientMessage(player, RED, warnstring);
		    SendClientMessage(playerid, RED, "I hope that was a joke");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:main(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 6 && IsPlayerAdmin(playerid))
	{
	    SetTimer("mainmode", 120000, false);
	    GlobalMain = true;
	    for(new i = 0; i < 50; i++) SendClientMessageToAll(GREEN, " ");
	    SendClientMessageToAll(RED, "The server is going down in 2 minutes. Please logout before that time.");
	    ShowPlayerDialog(playerid, 8469, DIALOG_STYLE_MSGBOX, ""orange"Notice", ""white"_______________________________________________________________________\n\nThe Server is going down in 2 minutes. Please logout before that time.\n_______________________________________________________________________", "OK", "");
 	}
	return 1;
}

COMMAND:slap(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /slap <playerid>");
		    return 1;
	  	}

		if(IsPlayerAvail(player) && (PlayerInfo[player][Level] != MAX_ADMIN_LEVEL) && (gTeam[player] == NORMAL || gTeam[player] == DM || gTeam[player] == MINIGUN || gTeam[player] == SNIPER))
		{
  			new
			  	Float:Health,
			  	Float:POS[3],
			  	string[128];
			  	
  			GetPlayerHealth(player, Health);
			SetPlayerHealth(player, floatsub(Health, 25.0));
			GetPlayerPos(player, POS[0], POS[1], POS[2]);
			SetPlayerPos(player, POS[0], POS[1], floatadd(POS[2], 10.0));
			format(string, sizeof(string), "You have slapped %s", __GetName(player));
			SendClientMessage(playerid, BLUE, string);
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or is the highest level admin or in a minigame");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:admin(playerid, params[])
{
	cmd_admins(playerid, "");
	return 1;
}

COMMAND:admins(playerid, params[])
{
	new tempstring[128], finstring[1024], count = 0;
	format(finstring, sizeof(finstring), ""yellow"ID:\t\tLevel:\t\tName:\n");

	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerAvail(i)) continue;
	    if(PlayerInfo[i][Level] >= 1 && PlayerInfo[i][AOnline])
	    {
			format(tempstring, sizeof(tempstring), ""white"%i\t\t%i\t\t"green"%s\n", i, PlayerInfo[i][Level], __GetName(i));
	        strcat(finstring, tempstring);
			count++;
	    }
	}
	if(count == 0)
	{
	    SendInfo(playerid, "~h~~y~No admins online!", 2100);
	}
	else
	{
	    format(tempstring, sizeof(tempstring), "\n\n"white"Total of "yellow"%i "white"admins online!", count);
	    strcat(finstring, tempstring);
		ShowPlayerDialog(playerid, ADMINS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Admins", finstring, "OK", "");
	}

	return 1;
}

COMMAND:adminhq(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

	if(PlayerInfo[playerid][Level] >= 1)
	{
		new string[128];
		SetPlayerPos(playerid, 1797.4270,-1300.9581,120.2656);
		format(string, sizeof(string), "Admin %s teleported to Admin´s Headquarter! (/adminhq)", __GetName(playerid));
		SendClientMessageToAll(WHITE, string);
	 	SetPlayerInterior(playerid,0);
	}
	else
	{
	    new string[128];
	    SetPlayerPos(playerid, 1786.5049,-1298.0465,120.2656);
		format(string, sizeof(string), "Player %s teleported to Admin´s Headquarter! (/adminhq)", __GetName(playerid));
		SendClientMessageToAll(WHITE, string);
		SetPlayerInterior(playerid,0);
	}
	return 1;
}

COMMAND:setadminlevel(playerid, params[])
{
	if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL || IsPlayerAdmin(playerid))
	{
	    new player, alevel;
	 	if(sscanf(params, "ri", player, alevel))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /setadminlevel <playerid> <level>");
		    return 1;
	  	}

		if(IsPlayerAvail(player))
		{
			if(alevel > MAX_ADMIN_LEVEL)
			{
				SendClientMessage(playerid, RED, ""er"Incorrect Level");
				return 1;
			}
			if(alevel == PlayerInfo[player][Level])
			{
				SendClientMessage(playerid, -1, ""er" Player is already this level");
				return 1;
			}
  			new hour, minute, second, string[128];
   			gettime(hour, minute, second);

			if(alevel > 0)
			{
				format(string, sizeof(string), "Admin %s has set you to Admin Status [level %i]", __GetName(playerid), alevel);
			}
			else
			{
				format(string, sizeof(string), "Admin %s has set you to Player Status [level %i]", __GetName(playerid), alevel);
			}
			SendClientMessage(player, BLUE, string);

			if(alevel > PlayerInfo[player][Level])
			{
				GameTextForPlayer(player, "Promoted", 5000, 3);
			}
			else
			{
				GameTextForPlayer(player, "Demoted", 5000, 3);
			}
			format(string, sizeof(string), "You have made %s Level %i at %i:%i:%i", __GetName(player), alevel, hour, minute, second);
			SendClientMessage(playerid, BLUE, string);
			format(string, sizeof(string), "Admin %s has made %s Level %i at %i:%i:%i", __GetName(playerid), __GetName(player), alevel, hour, minute, second);
            SendClientMessage(player, BLUE, string);
            
			PlayerInfo[player][Level] = alevel;
		}
		else
		{
			SendClientMessage(playerid, -1, ""er" Cannot assign permissions");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:report(playerid, params[])
{
	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastReport] + COOLDOWN_CMD_REPORT) >= tick)
	{
    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
	}

	new	player,
		reason[144];

	if(sscanf(params, "rs[144]", player, reason)) return SendClientMessage(playerid, ORANGE, "Usage: /report <playerid> <reason>");

 	if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] == 0)
	{
		if(strlen(reason) < 4) return SendClientMessage(playerid, RED, ""er"Please write more");

		new time[3],
			string[144];

		gettime(time[0], time[1], time[2]);

		format(string, sizeof(string), "Report(%02i:%02i:%02i) %s(%i) -> %s(%i) -> %s", time[0], time[1], time[2], __GetName(playerid), playerid, __GetName(player), player, reason);
		for(new i = 1; i < MAX_REPORTS - 1; i++) Reports[i] = Reports[i + 1];
		Reports[MAX_REPORTS - 1] = string;
		
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(PlayerInfo[i][Level] > 0)
		    {
		        SendInfo(i, "~h~~r~>> New Report! << [/reports]", 5000);
		    }
		}
		
		LangMSG(playerid, YELLOW, "Your report has been sent to online Admins", "Dein Report wurde an alle online Admins gesendet");
		PlayerInfo[playerid][tickLastReport] = tick;
	}
	else
	{
		SendClientMessage(playerid, RED, ""er"You cannot report this player!");
	}
	return 1;
}

COMMAND:reports(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1)
	{
        new ReportCount;
		for(new i = 1; i < MAX_REPORTS; i++)
		{
			if(strcmp(Reports[i], "<none>", true) != 0)
			{
				ReportCount++;
				SendClientMessage(playerid, WHITE, Reports[i]);
			}
		}
		if(ReportCount == 0)
		{
			SendClientMessage(playerid, WHITE, "There have been no reports");
		}
    }
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:race(playerid, params[])
{
    if(gTeam[playerid] == RACE) return cmd_exit(playerid, "");
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	if(RaceJoinCount > 12) return LangMSG(playerid, -1, ""er"Race reached it's max players", ""er"Das Race ist momentan voll");

	if(RaceStatus == RaceStatus_StandBy)
	{
	    Iter_Clear(RaceJoins);
	    RaceStatus = RaceStatus_StartUp;
		tRaceCount = SetTimer("CountTillRace", 999, true);
		new string[128], gstring[128];
		format(string, sizeof(string), ""race_sign" Still 20 seconds till %s named race starts [/race]", RaceName);
		format(gstring, sizeof(gstring), ""race_sign" Noch 20 Sekunden bis %s Race startet [/race]", RaceName);
		LangMSGToAll(-1, string, gstring);
	}
	else if(RaceStatus == RaceStatus_Inactive)
	{
		// Wait till cooldown expires.
		LangMSG(playerid, -1, ""er"No Race active!", ""er"Kein Race aktiv!");
	}
	else if(RaceStatus == RaceStatus_Active)
	{
		// Too late!
		LangMSG(playerid, -1, ""er"Sorry, race already started", ""er"Ups, du bist leider zu spät! Das Rennen läuft bereits");
	}

	if(RaceStatus == RaceStatus_StartUp)
	{
		if(Iter_Contains(RaceJoins, playerid))
		{
			LangMSG(playerid, -1, ""er"You already joined this race round!", ""er"Du bist in dieser Runde schon begetreten!");
		}
		else
		{
			Iter_Add(RaceJoins, playerid);
		 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			ClearAnimations(playerid);
			ResetPlayerWeapons(playerid);
			NewMinigameJoin(playerid, "Race", "race");
			SetupRaceForPlayer(playerid);
			ShowPlayerRaceTextdraws(playerid);
			gTeam[playerid] = RACE;
		}
	}
	return 1;
}

COMMAND:createrace(playerid, params[])
{
	if(IsPlayerAdmin(playerid) && PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL)
	{
		if(BuildRace != 0) return SendClientMessage(playerid, -1, ""er"There's already someone building a race!");
		if(RaceStatus == RaceStatus_Active) return SendClientMessage(playerid, -1, ""er"Wait first till race ends!");
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ""er"Please leave your vehicle first!");
		BuildRace = playerid + 1;
		ShowDialog(playerid, DIALOG_RACE_RACETYPE);
		gTeam[playerid] = BUILDRACE;
	}
	else
	{
	    LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:createprop(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
		return LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}

	extract params -> new p_price, p_score, p_earnings; else
	{
		return SendClientMessage(playerid, ORANGE, "Usage: /createprop <price> <score> <earnings>");
	}

  	new
  		Float:POS[3],
  		pslotid = propSlot();
	new
		pfullid = (pslotid == -1) ? (propid) : (pslotid);

  	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
 	PropInfo[pfullid][E_x] = POS[0];
	PropInfo[pfullid][E_y] = POS[1];
	PropInfo[pfullid][E_z] = POS[2];
	PropInfo[pfullid][E_score] = p_score;
	PropInfo[pfullid][price] = p_price;
	PropInfo[pfullid][earnings] = p_earnings;
	PropInfo[pfullid][sold] = 0;

	strmid(PropInfo[pfullid][Owner], "ForSale", 0, 25, 25);

	new query[356];
	format(query, sizeof(query), "INSERT INTO `"#TABLE_PROP"` VALUES (NULL, '%s', %.2f, %.2f, %.2f, %i, %i, %i, 0, 0);",
		PropInfo[pfullid][Owner],
		PropInfo[pfullid][E_x],
	 	PropInfo[pfullid][E_y],
		PropInfo[pfullid][E_z],
		PropInfo[pfullid][price],
		PropInfo[pfullid][earnings],
		PropInfo[pfullid][E_score]);

    mysql_function_query(g_SQL_handle, query, false, "", "");
    mysql_function_query(g_SQL_handle, "SELECT * FROM `"#TABLE_PROP"` ORDER BY `ID` DESC LIMIT 1;", false, "OnPropLoadEx", "i", pfullid);
	    
    if(pslotid == -1) propid++;
    return 1;
}

COMMAND:createhouse(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
		return LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}

	extract params -> new h_price, h_score, h_int; else
	{
	    return SendClientMessage(playerid, ORANGE, "Usage: /createhouse <price> <score> <int id>");
	}

	new Float:POS[3],
		slotid = initSlot();
	new fullid = (slotid == -1) ? (houseid) : (slotid);

	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);

	HouseInfo[fullid][E_x] = POS[0];
	HouseInfo[fullid][E_y] = POS[1];
	HouseInfo[fullid][E_z] = POS[2];
	HouseInfo[fullid][E_score] = h_score;
	HouseInfo[fullid][price] = h_price;
	HouseInfo[fullid][interior] = h_int;
	HouseInfo[fullid][locked] = 1;
	HouseInfo[fullid][sold] = 0;

	strmid(HouseInfo[fullid][Owner], "ForSale", 0, 25, 25);

	new query[255];

	format(query, sizeof(query), "INSERT INTO `"#TABLE_HOUSE"` \
		VALUES (NULL, '%s', %.2f, %.2f, %.2f, %i, %i, %i, %i, %i, 0);",
		    HouseInfo[fullid][Owner],
		    HouseInfo[fullid][E_x],
		    HouseInfo[fullid][E_y],
		    HouseInfo[fullid][E_z],
		    HouseInfo[fullid][interior],
		    HouseInfo[fullid][price],
		    HouseInfo[fullid][E_score],
		    HouseInfo[fullid][sold],
		    HouseInfo[fullid][locked]);

    mysql_function_query(g_SQL_handle, query, false, "", "");
    mysql_function_query(g_SQL_handle, "SELECT * FROM `"#TABLE_HOUSE"` ORDER BY `ID` DESC LIMIT 1;", false, "OnHouseLoadEx", "i", fullid);
	    
    if(slotid == -1) houseid++;
    return 1;
}

COMMAND:createstore(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
		return LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	
	new
		string[80],
		file[50],
		labeltext[50],
		Float:POS[4];

	extract params -> new string:store[15]; else
	{
	    return SendClientMessage(playerid, ORANGE, "Usage: /createstore (bank/ammunation/burger/cluckinbell/pizza/247)");
	}

	if(strlen(store) < 3 || strlen(store) > 11)
	{
		return SendClientMessage(playerid, ORANGE, "Usage: /createstore (bank/ammunation/burger/cluckinbell/pizza/247)");
	}

    if(strcmp(store, "bank", true) && strcmp(store, "ammunation", true) && strcmp(store, "burger", true) && strcmp(store, "cluckinbell", true) && strcmp(store, "pizza", true) && strcmp(store, "247", true))
	{
		return SendClientMessage(playerid, ORANGE, "Usage: /createstore (bank/ammunation/burger/cluckinbell/pizza/247)");
	}
	else
	{
		dini_Create("/Store/Index.ini");
	    GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
		GetPlayerFacingAngle(playerid, POS[3]);
		dini_IntSet("/Store/Index.ini", "TotalStores", (dini_Int("/Store/Index.ini", "TotalStores") + 1));
		
	    if(!strcmp(store, "bank", false))
	    {
	        new bankid = dini_Int("/Store/Index.ini", "CurrentBankID");
	        if(bankid >= MAX_BANKS)
			{
				return SendClientMessage(playerid, RED, ""er"Unable to create more banks. There are already "#MAX_BANKS" created");
			}
	        else
	        {
		        format(string, sizeof(string), "Bank ID %i created.", bankid);
		        format(labeltext, sizeof(labeltext), "Bank");
		    	format(file, sizeof(file), "/Store/Banks/%i.ini", bankid);
 				if(dini_Create(file))
 				{
			    	dini_IntSet("/Store/Index.ini", "CurrentBankID", (bankid + 1));
			    	dini_IntSet("/Store/Index.ini", "CurrentBankWorld", (bankid + 1000));
			    	BankPickOut[bankid] = CreateDynamicPickup(1559, 1, POS[0], POS[1], POS[2], 0, 0, -1, 30.0);
		   			BankPickInt[bankid] = CreateDynamicPickup(1559, 1, 2304.69, -16.19, 26.74, (bankid + 1000), -1, -1, 50.0);
					BankPickMenu[bankid] = CreateDynamicPickup(1559, 1, 2311.63, -3.89, 26.74, (bankid + 1000), -1, -1, 50.0);
				    BankMIcon[bankid] = CreateDynamicMapIcon(POS[0], POS[1], POS[2], 25, -1, 0, 0, -1, 200.0);
				}
		    }
	    }
	    if(!strcmp(store, "ammunation", false))
	    {
	        new ammunationid = dini_Int("/Store/Index.ini", "CurrentAmmunationID");
	        if(ammunationid >= MAX_AMMUNATIONS)
			{
				return SendClientMessage(playerid, RED, ""er"Unable to create more banks. There are already "#MAX_AMMUNATIONS" created");
			}
			else
			{
		        format(string, sizeof(string), "Ammunation ID %i Created.", ammunationid);
		        format(labeltext, sizeof(labeltext), "Ammunation");
		    	format(file, sizeof(file), "/Store/Ammunations/%i.ini", ammunationid);
		    	if(dini_Create(file))
				{
			    	dini_IntSet("/Store/Index.ini", "CurrentAmmunationID", (ammunationid + 1));
	    			dini_IntSet("/Store/Index.ini", "CurrentAmmunationWorld", (ammunationid + 1000));
			    	AmmunationPickOut[ammunationid] = CreateDynamicPickup(1559, 1, POS[0], POS[1], POS[2], 0, 0, -1, 50.0);
					AmmunationPickInt[ammunationid] = CreateDynamicPickup(1559, 1, 315.81, -143.65, 999.60, (ammunationid + 1000), 7, -1, 50.0);
					AmmunationMIcon[ammunationid] = CreateDynamicMapIcon(POS[0], POS[1], POS[2], 6, -1, 0, 0, -1, 200.0);
				}
			}
	    }
	    if(!strcmp(store, "burger", false))
	    {
	        new burgerid = dini_Int("/Store/Index.ini", "CurrentBurgerID");
	        if(burgerid >= MAX_BURGERSHOTS)
			{
				return SendClientMessage(playerid, RED, ""er"There are already "#MAX_BURGERSHOTS" created");
			}
            else
			{
			    format(string, sizeof(string), "Burger Shot ID %i Created.", burgerid);
		        format(labeltext, sizeof(labeltext), "Burger Shot");
		    	format(file, sizeof(file), "/Store/BurgerShots/%i.ini", burgerid);
		    	if(dini_Create(file))
				{
			    	dini_IntSet("/Store/Index.ini", "CurrentBurgerID", (burgerid + 1));
			    	dini_IntSet("/Store/Index.ini", "CurrentBurgerWorld", (burgerid + 1000));
					BurgerPickOut[burgerid] = CreateDynamicPickup(1559, 1, POS[0], POS[1], POS[2], 0, 0, -1, 50.0);
					BurgerPickInt[burgerid] = CreateDynamicPickup(1559, 1, 362.87, -75.17, 1001.50, (burgerid + 1000), 10, -1, 50.0);
					BurgerMIcon[burgerid] = CreateDynamicMapIcon(POS[0], POS[1], POS[2], 10, -1, 0, 0, -1, 200.0);
				}
			}
	    }
	    if(!strcmp(store, "cluckinbell", false))
	    {
	        new cluckinbellid = dini_Int("/Store/Index.ini", "CurrentCluckinBellID");
	        if(cluckinbellid >= MAX_CLUCKINBELLS)
			{
				return SendClientMessage(playerid, RED, ""er"There are already "#MAX_CLUCKINBELLS" created");
			}
            else
			{
				format(string, sizeof(string), "Cluckin Bell ID %i Created", cluckinbellid);
		        format(labeltext, sizeof(labeltext), "Cluckin' Bell");
		    	format(file, sizeof(file), "/Store/CluckinBells/%i.ini", cluckinbellid);
		    	if(dini_Create(file))
				{
			    	dini_IntSet("/Store/Index.ini", "CurrentCluckinBellID", (cluckinbellid + 1));
			    	dini_IntSet("/Store/Index.ini", "CurrentCluckinBellWorld", (cluckinbellid + 1000));
					CluckinBellPickOut[cluckinbellid] = CreateDynamicPickup(1559, 1, POS[0], POS[1], POS[2], 0, 0, -1, 50.0);
					CluckinBellPickInt[cluckinbellid] = CreateDynamicPickup(1559, 1, 364.87, -11.74, 1001.85, (cluckinbellid + 1000), 9, -1, 50.0);
					CluckinBellMIcon[cluckinbellid] = CreateDynamicMapIcon(POS[0], POS[1], POS[2], 14, -1, 0, 0, -1, 200.0);
				}
			}
	    }
	    if(!strcmp(store, "pizza", false))
	    {
	        new pizzaid = dini_Int("/Store/Index.ini", "CurrentPizzaID");
	        if(pizzaid >= MAX_PIZZASTACKS)
			{
				return SendClientMessage(playerid, RED, ""er"There are already "#MAX_PIZZASTACKS" created");
			}
			else
			{
				format(string, sizeof(string), "Well Stacked Pizza & Co. ID %i Created.", pizzaid);
		        format(labeltext, sizeof(labeltext), "Well Stacked Pizza & Co.");
		    	format(file, sizeof(file), "/Store/WellStackedPizzas/%i.ini", pizzaid);
		    	if(dini_Create(file))
				{
	   		    	dini_IntSet("/Store/Index.ini", "CurrentPizzaID", (pizzaid + 1));
			    	dini_IntSet("/Store/Index.ini", "CurrentPizzaWorld", (pizzaid + 1000));
					PizzaPickOut[pizzaid] = CreateDynamicPickup(1559, 1, POS[0], POS[1], POS[2], 0, 0, -1, 50.0);
					PizzaPickInt[pizzaid] = CreateDynamicPickup(1559, 1, 372.36, -133.50, 1001.49, (pizzaid + 1000), 5, -1, 50.0);
					PizzaMIcon[pizzaid] = CreateDynamicMapIcon(POS[0], POS[1], POS[2], 29, -1, 0, 0, -1, 200.0);
				}
			}
	    }
	    if(!strcmp(store, "247", false))
	    {
	        new tfs = dini_Int("/Store/Index.ini", "CurrentTFSID");
	        if(tfs >= MAX_TFS)
			{
				return SendClientMessage(playerid, RED, ""er"There are already "#MAX_TFS" created");
			}
			else
			{
				format(string, sizeof(string), "24/7 ID %i Created.", tfs);
		        format(labeltext, sizeof(labeltext), "24/7");
		    	format(file, sizeof(file), "/Store/TwentyFourSeven/%i.ini", tfs);
		    	if(dini_Create(file))
				{
			    	dini_IntSet("/Store/Index.ini", "CurrentTFSID", (tfs + 1));
			    	dini_IntSet("/Store/Index.ini", "CurrentTFSWorld", (tfs + 1000));
					TFSPickOut[tfs] = CreateDynamicPickup(1559, 1, POS[0], POS[1], POS[2], 0, 0, -1, 50.0);
					TFSPickInt[tfs] = CreateDynamicPickup(1559, 1,  -25.884, -185.868, 1003.546, (tfs + 1000), 17, -1, 50.0);
					TFSMIcon[tfs] = CreateDynamicMapIcon(POS[0], POS[1], POS[2], 17, -1, 0, 0, -1, 200.0);
				}
			}
	    }
	    new lstring[128];
	    format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", labeltext);
		StoreLabel[dini_Int(file, "StoreID")] = Create3DTextLabel(lstring, YELLOW, POS[0], POS[1], floatadd(POS[2], 0.7), 25, 0, 1);
		dini_Set(file, "StoreName", labeltext);
		dini_FloatSet(file, "PickOutX", POS[0]);
		dini_FloatSet(file, "PickOutY", POS[1]);
		dini_FloatSet(file, "PickOutZ", POS[2]);
		GetPosInFrontOfPlayer(playerid, POS[0], POS[1], -2.5);
		dini_FloatSet(file, "SpawnOutX", POS[0]);
		dini_FloatSet(file, "SpawnOutY", POS[1]);
		dini_FloatSet(file, "SpawnOutZ", POS[2]);
		dini_FloatSet(file, "SpawnOutAngle", floatround((floatadd(180.0, POS[3])), floatround_ceil));
		dini_IntSet(file, "StoreID", dini_Int("/Store/Index.ini", "TotalStores"));
		SendClientMessage(playerid, YELLOW, string);
	}
    return 1;
}

COMMAND:rules(playerid, params[])
{
    ShowPlayerDialog(playerid, 5002, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Rules", ""white"- No cheating of any kind\n- No mods that affect other player's gameplay\n- No insult\n- No advertising\n- No spamming\n- No abusing bugs/glitches\n- No spawn killing\n- No AFK in minigames", "OK", "");
	return 1;
}

COMMAND:rule(playerid, params[])
{
	cmd_rules(playerid, "");
	return 1;
}

COMMAND:kills(playerid, params[])
{
	new
	    kills[MAX_PLAYERS][e_top_kills],
		finstring[2048],
		tmpstring[68];
		
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
	        kills[i][E_playerid] = i;
	        kills[i][E_kills] = PlayerInfo[i][Kills];
	    }
	    else
	    {
	        kills[i][E_playerid] = -1;
	        kills[i][E_kills] = -1;
	    }
	}

	SortDeepArray(kills, E_kills, .order = SORT_DESC);

	for(new i = 0; i < 30; i++)
	{
	    if(kills[i][E_kills] != -1)
	    {
		    format(tmpstring, sizeof(tmpstring), "{%06x}%i - %s(%i) - Kills: %i\n", (GetPlayerColor(kills[i][E_playerid]) >>> 8), i + 1, __GetName(kills[i][E_playerid]), kills[i][E_playerid], kills[i][E_kills]);
		    strcat(finstring, tmpstring);
		}
		else
		{
		    format(tmpstring, sizeof(tmpstring), ""white"%i - ---\n", i + 1);
		    strcat(finstring, tmpstring);
		}
	}

    ShowPlayerDialog(playerid, MOST_KILLS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Most Kills", finstring, "OK", "");
	return 1;
}

COMMAND:deaths(playerid, params[])
{
	new
	    deaths[MAX_PLAYERS][e_top_deaths],
		finstring[2048],
		tmpstring[68];

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
	        deaths[i][E_playerid] = i;
	        deaths[i][E_deaths] = PlayerInfo[i][Deaths];
	    }
	    else
	    {
	        deaths[i][E_playerid] = -1;
	        deaths[i][E_deaths] = -1;
	    }
	}

	SortDeepArray(deaths, E_deaths, .order = SORT_DESC);

	for(new i = 0; i < 30; i++)
	{
	    if(deaths[i][E_deaths] != -1)
	    {
		    format(tmpstring, sizeof(tmpstring), "{%06x}%i - %s(%i) - Deaths: %i\n", (GetPlayerColor(deaths[i][E_playerid]) >>> 8), i + 1, __GetName(deaths[i][E_playerid]), deaths[i][E_playerid], deaths[i][E_deaths]);
		    strcat(finstring, tmpstring);
		}
		else
		{
		    format(tmpstring, sizeof(tmpstring), ""white"%i - ---\n", i + 1);
		    strcat(finstring, tmpstring);
		}
	}

    ShowPlayerDialog(playerid, MOST_DEATHS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Most Deaths", finstring, "OK", "");
	return 1;
}

COMMAND:hrs(playerid, params[])
{
	new hrs[MAX_PLAYERS][e_top_hrs],
		finstring[2048],
		tmpstring[68],
		time[3];

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
	        hrs[i][E_playerid] = i;
	        TotalGameTime(i, time[0], time[1], time[2]);
	        hrs[i][E_hrs] = time[0];
	    }
	    else
	    {
	        hrs[i][E_playerid] = -1;
	        hrs[i][E_hrs] = -1;
	    }
	}

	SortDeepArray(hrs, E_hrs, .order = SORT_DESC);

	for(new i = 0; i < 30; i++)
	{
	    if(hrs[i][E_hrs] != -1)
	    {
		    format(tmpstring, sizeof(tmpstring), "{%06x}%i - %s(%i) - Hours: %i\n", (GetPlayerColor(hrs[i][E_playerid]) >>> 8), i + 1, __GetName(hrs[i][E_playerid]), hrs[i][E_playerid], hrs[i][E_hrs]);
		    strcat(finstring, tmpstring);
		}
		else
		{
		    format(tmpstring, sizeof(tmpstring), ""white"%i - ---\n", i + 1);
		    strcat(finstring, tmpstring);
		}
	}

    ShowPlayerDialog(playerid, MOST_HRS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Most Hours", finstring, "OK", "");
	return 1;
}

COMMAND:richlist(playerid, params[])
{
	new richlist[MAX_PLAYERS][e_top_richlist],
		finstring[2048],
		tmpstring[68];
	
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
	        richlist[i][E_playerid] = i;
	        richlist[i][E_money] = PlayerInfo[i][Money] + PlayerInfo[i][Bank];
	    }
	    else
	    {
	        richlist[i][E_playerid] = -1;
	        richlist[i][E_money] = -1;
	    }
	}
	
	SortDeepArray(richlist, E_money, .order = SORT_DESC);
	
	for(new i = 0; i < 30; i++)
	{
	    if(richlist[i][E_money] != -1)
	    {
		    format(tmpstring, sizeof(tmpstring), "{%06x}%i - %s(%i) - Money: $%i\n", (GetPlayerColor(richlist[i][E_playerid]) >>> 8), i + 1, __GetName(richlist[i][E_playerid]), richlist[i][E_playerid], richlist[i][E_money]);
		    strcat(finstring, tmpstring);
		}
		else
		{
		    format(tmpstring, sizeof(tmpstring), ""white"%i - ---\n", i + 1);
		    strcat(finstring, tmpstring);
		}
	}

    ShowPlayerDialog(playerid, RICHLIST_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Richlist", finstring, "OK", "");
	return 1;
}

COMMAND:wanted(playerid, params[])
{
	cmd_wanteds(playerid, "");
	return 1;
}

COMMAND:wanteds(playerid, params[])
{
	new wanteds[MAX_PLAYERS][e_top_wanteds],
		finstring[2048],
		tmpstring[68];

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
	        wanteds[i][E_playerid] = i;
	        wanteds[i][E_wanteds] = PlayerInfo[i][Wanteds];
	    }
	    else
	    {
	        wanteds[i][E_playerid] = -1;
	        wanteds[i][E_wanteds] = -1;
	    }
	}

	SortDeepArray(wanteds, E_wanteds, .order = SORT_DESC);

	for(new i = 0; i < 30; i++)
	{
	    if(wanteds[i][E_wanteds] != -1)
	    {
		    format(tmpstring, sizeof(tmpstring), "{%06x}%i - %s(%i) - Wanteds: %i\n", (GetPlayerColor(wanteds[i][E_playerid]) >>> 8), i + 1, __GetName(wanteds[i][E_playerid]), wanteds[i][E_playerid], wanteds[i][E_wanteds]);
		    strcat(finstring, tmpstring);
		}
		else
		{
		    format(tmpstring, sizeof(tmpstring), ""white"%i - ---\n", i + 1);
		    strcat(finstring, tmpstring);
		}
	}
	ShowPlayerDialog(playerid, WANTEDS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Most wanteds", finstring, "OK", "");
	return 1;
}

COMMAND:score(playerid, params[])
{
	new score[MAX_PLAYERS][e_top_score],
		finstring[2048],
		tmpstring[68];

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
	        score[i][E_playerid] = i;
	        score[i][E_pscore] = _GetPlayerScore(i);
	    }
	    else
	    {
	        score[i][E_playerid] = -1;
	        score[i][E_pscore] = -1;
	    }
	}

	SortDeepArray(score, E_pscore, .order = SORT_DESC);

	for(new i = 0; i < 30; i++)
	{
	    if(score[i][E_pscore] != -1)
	    {
		    format(tmpstring, sizeof(tmpstring), "{%06x}%i - %s(%i) - Score: %i\n", (GetPlayerColor(score[i][E_playerid]) >>> 8), i + 1, __GetName(score[i][E_playerid]), score[i][E_playerid], score[i][E_pscore]);
		    strcat(finstring, tmpstring);
		}
		else
		{
		    format(tmpstring, sizeof(tmpstring), ""white"%i - ---\n", i + 1);
		    strcat(finstring, tmpstring);
		}
	}
	ShowPlayerDialog(playerid, SCORE_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Score", finstring, "OK", "");
	return 1;
}

COMMAND:top5(playerid, params[])
{
	cmd_top(playerid, "");
	return 1;
}

COMMAND:top10(playerid, params[])
{
	cmd_top(playerid, "");
	return 1;
}

COMMAND:top(playerid, params[])
{
	ShowPlayerDialog(playerid, TOPLIST_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Toplists", ""white"Richlist (/richlist)\nMost Wanteds (/wanteds)\nScore (/score)\nMost Kills (/kills)\nMost Deaths (/deaths)\nMost Hours (/hrs)", "Select", "");
	return 1;
}

COMMAND:pvmenu(playerid, params[])
{
	cmd_vmenu(playerid, "");
	return 1;
}

COMMAND:pv(playerid, params[])
{
	cmd_vmenu(playerid, "");
	return 1;
}

COMMAND:vmenu(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);

    if(PlayerInfo[playerid][BuyAbleVeh] == 1)
    {
    	ShowDialog(playerid, VMENU_DIALOG);
	}
	else
	{
	    LangMSG(playerid, RED, ""er"You dont have a private vehcile!", ""er"Du besitzt kein privates Fahrzeug!");
	}
	return 1;
}

COMMAND:spec(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid))
	{
	    new player;
	 	if(sscanf(params, "u", player))
		{
			return SendClientMessage(playerid, ORANGE, "Usage: /spec <playerid>");
	  	}
	  	
	  	if(player > 499 || player < 0) return SendClientMessage(playerid, RED, ""er"Invalid player!");
	  	
		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			return SendClientMessage(playerid, RED, ""er"You cannot use this command on this admin");
		}
	  	
		if(gTeam[playerid] != NORMAL)
		{
			cmd_exit(playerid, "");
		}
		
        if(IsPlayerAvail(player) && player != playerid)
		{
			if(GetPlayerState(player) == PLAYER_STATE_SPECTATING && PlayerInfo[player][SpecID] != INVALID_PLAYER_ID)
			{
				return SendClientMessage(playerid, RED, ""er"Player spectating someone else");
			}
			if(PlayerInfo[player][IsDead])
			{
				return SendClientMessage(playerid, RED, ""er"Player is dead");
			}
			
			StartSpectate(playerid, player);
			GetPlayerPos(playerid, PlayerInfo[playerid][SpecX], PlayerInfo[playerid][SpecY], PlayerInfo[playerid][SpecZ]);
			GetPlayerFacingAngle(playerid, PlayerInfo[playerid][SpecA]);
			SendInfo(playerid, "~y~~h~Now spectating!", 2500);
		}
		else
		{
			SendClientMessage(playerid, RED, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:specoff(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid))
	{
        if(PlayerInfo[playerid][SpecType] != ADMIN_SPEC_TYPE_NONE)
		{
			StopSpectate(playerid);
			SendInfo(playerid, "~y~~h~No longer spectating!", 2500);
		}
		else
		{
			SendInfo(playerid, "~r~~h~You are not spectating!", 2500);
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:freeze(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3)
	{
		new player;
		if(sscanf(params, "r", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /freeze <playerid>");
			return 1;
	 	}
		if(IsPlayerAvail(player))
		{
		 	if(gTeam[player] != NORMAL)
	 		{
	 		    cmd_exit(player, "");
			}

			LangMSG(player, RED, "You have been freezed by an admin", "Du wurdest von einem Admin gefrezzt");
			TogglePlayerControllable(player, false);
			PlayerInfo[player][Frozen] = true;
		}
		else
		{
		    SendClientMessage(playerid, RED, ""er"Invalid player");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:unfreeze(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3)
	{
		new player;
		if(sscanf(params, "r", player))
		{
			SendClientMessage(playerid, ORANGE, "Usage: /unfreeze <playerid>");
			return 1;
	 	}
	 	if(PlayerInfo[player][Frozen])
 		{
			TogglePlayerControllable(player, true);
			PlayerInfo[player][Frozen] = false;
			LangMSG(player, GREEN, "You have been unfreezed by an admin", "Du wurdest von einem Admin ungefrezzt");
		}
		else
		{
		    SendClientMessage(playerid, RED, ""er"Not possible to unfreeze him now");
		}
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:clearchat(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3)
	{
		for(new i = 0; i < 129; i++)
		{
			SendClientMessageToAll(GREEN, " ");
		}
 	}
 	else
 	{
	 	LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:move(playerid, params[])
{
	if(gTeam[playerid] == NORMAL)
	{
		if(PlayerInfo[playerid][Level] >= 2)
		{
		    if(!strlen(params))
			{
				SendClientMessage(playerid, ORANGE, "Usage: /move [up / down / +x / -x / +y / -y / off]");
				return 1;
			}
			new Float:POS[3];
			if(strcmp(params, "up", true) == 0)
			{
				TogglePlayerControllable(playerid, false);
				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				SetPlayerPos(playerid, POS[0], POS[1], POS[2]+5);
				SetCameraBehindPlayer(playerid);
			}
			else if(strcmp(params, "down", true) == 0)
			{
				TogglePlayerControllable(playerid, false);
				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				SetPlayerPos(playerid, POS[0], POS[1], POS[2]-5);
				SetCameraBehindPlayer(playerid);
				}
			else if(strcmp(params, "+x", true) == 0)
			{
				TogglePlayerControllable(playerid, false);
				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				SetPlayerPos(playerid, POS[0]+5, POS[1], POS[2]);
			}
			else if(strcmp(params, "-x", true) == 0)
			{
				TogglePlayerControllable(playerid, false);
				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				SetPlayerPos(playerid, POS[0]-5, POS[1], POS[2]);
			}
			else if(strcmp(params, "+y", true) == 0)
			{
				TogglePlayerControllable(playerid, false);
				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				SetPlayerPos(playerid, POS[0], POS[1]+5, POS[2]);
			}
			else if(strcmp(params, "-y", true) == 0)
			{
				TogglePlayerControllable(playerid, false);
				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				SetPlayerPos(playerid, POS[0], POS[1]-5, POS[2]);
			}
		    else if(strcmp(params, "off", true) == 0)
			{
				TogglePlayerControllable(playerid, true);
			}
			else
			{
				SendClientMessage(playerid, ORANGE, "Usage: /move [up / down / +x / -x / +y / -y / off]");
			}
		}
		else
		{
			LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
		}
	}
	else
	{
	    LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	}
	return 1;
}

COMMAND:changepassword(playerid, params[])
{
	cmd_changepass(playerid, "");
	return 1;
}

COMMAND:changepass(playerid, params[])
{
    new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastPW] + COOLDOWN_CMD_CHANGEPASS) >= tick)
	{
    	return LangMSG(playerid, -1, ""er"Please wait a bit before using this cmd again!", ""er"Warte ein wenig bevor du wieder diesen Befehl nutzt!");
	}

	new pass[128];
	if(sscanf(params, "s[128]", pass))
	{
		SendClientMessage(playerid, ORANGE, "Usage: /changepass <new pass>");
	    return 1;
	}
	if(strlen(pass) < 4 || strlen(pass) > 32)
	{
		SendClientMessage(playerid, -1, ""er" Incorrect password length. (4 - 32)");
		return 1;
	}
	new string[128];
    MySQL_UpdatePlayerPass(playerid, pass);
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
    format(string, sizeof(string), ""server_sign" You have successfully changed your password to %s", pass);
	SendClientMessage(playerid, -1, string);
	PlayerInfo[playerid][tickLastPW] = tick;
	return 1;
}


COMMAND:stats(playerid, params[])
{
	new
		player1,
		player;

	if(sscanf(params, "r", player))
	{
		player1 = playerid;
	}
	else
	{
		player1 = player;
	}

	if(IsPlayerAvail(player1))
	{
		new
		    gangnam[50],
		    houseyn[7],
			propyn[7],
			string1[255],
			string2[300],
			string3[255],
			pDeaths,
			time[3],
			finstring[sizeof(string1) + sizeof(string2) + sizeof(string3)],
			achcount = 0;

		TotalGameTime(player1, time[0], time[1], time[2]);
 		if(PlayerInfo[player1][Deaths] == 0)
	 	{
	 		pDeaths = 1;
	 	}
	 	else
	 	{
	 		pDeaths = PlayerInfo[player1][Deaths];
	 	}

		if(PlayerInfo[player1][IsInGang] == 0)
		{
			strcat(gangnam, "- None -");
		}
		else strcat(gangnam, PlayerInfo[player1][GangName]);
		
		if(PlayerInfo[player1][Houses] == 0)
		{
			strcat(houseyn, "No");
		}
		else strcat(houseyn, "Yes");
		
		if(PlayerInfo[player1][Props] == 0)
		{
			strcat(propyn, "No");
		}
		else strcat(propyn, "Yes");

		if(PlayerInfo[playerid][Kills] >= 100)
		{
			achcount++;
		}
		if(PlayerInfo[playerid][Deaths] >= 100)
		{
			achcount++;
		}
		if(PlayerInfo[playerid][DerbyWins] >= 10)
		{
			achcount++;
		}
		if(PlayerInfo[playerid][RaceWins] >= 10)
		{
			achcount++;
		}
 		if(PlayerInfo[playerid][FalloutWins] >= 20)
		{
			achcount++;
		}
  		if(PlayerInfo[playerid][GungameWins] >= 10)
		{
			achcount++;
		}

 		format(string1, sizeof(string1),
	 	"\n"orange"Stats of the Player: "white"%s\n\n\
	 	Kills:\t\t\t %i\nDeaths:\t\t\t %i \nK/D:\t\t\t %0.2f \nScore:\t\t\t %i\nCash:\t\t\t $%i\nBank Cash:\t\t $%i\n",
   			__GetName(player1),
	 		PlayerInfo[player1][Kills],
        	PlayerInfo[player1][Deaths],
        	Float:PlayerInfo[player1][Kills] / Float:pDeaths,
        	_GetPlayerScore(player1),
        	GetPlayerCash(player1),
        	PlayerInfo[player1][Bank]);

		format(string2, sizeof(string2),
	   	"Race wins:\t\t %i\nDerby wins:\t\t %i\nReaction wins:\t\t %i\nTDM wins:\t\t %i\nFallout wins:\t\t %i\nGungame wins:\t\t %i\nTime until PayDay:\t %i minutes\n",
	   		PlayerInfo[player1][RaceWins],
	   		PlayerInfo[player1][DerbyWins],
	   		PlayerInfo[player1][Reaction],
	   		PlayerInfo[player1][BGWins],
	   		PlayerInfo[player1][FalloutWins],
	   		PlayerInfo[player1][GungameWins],
	   		PlayerInfo[player1][PayDay]);

        format(string3, sizeof(string3), "\
        Playing Time:\t\t %ih %im %is\nGang:\t\t\t %s\nAchs unlocked:\t\t %i\nHouse:\t\t\t %s\nBusiness:\t\t %s\nWanteds:\t\t %i\nRegister Date:\t\t %s",
            time[0],
			time[1],
			time[2],
			gangnam,
			achcount,
			houseyn,
			propyn,
			PlayerInfo[player1][Wanteds],
			UnixTimeToDate(PlayerInfo[player1][RegDate]));

		strcat(finstring, string1);
		strcat(finstring, string2);
		strcat(finstring, string3);

		ShowPlayerDialog(playerid, STATS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Player Statistics", finstring, "OK", "");
	}
	else
	{
		LangMSG(playerid, RED, ""er"Player is not connected!", ""er"Spieler ist nicht verbunden oder ein NPC");
	}
	return 1;
}

COMMAND:healall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
	   	for(new i = 0; i < MAX_PLAYERS; i++)
 		{
			if((IsPlayerAvail(i)) && (i != playerid) && (i != MAX_ADMIN_LEVEL) && (gTeam[i] == NORMAL))
			{
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				SetPlayerHealth(i, 100.0);
			}
		}
		new string[64];
		format(string, sizeof(string), "Admin %s healed all players", __GetName(playerid));
		SendClientMessageToAll(BLUE, string);
		GameTextForAll("Health for all!", 3000, 3);
		SetPlayerHealth(playerid, 100.0);
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:armorall(playerid, params[])
{
	cmd_armourall(playerid, "");
	return 1;
}

COMMAND:armourall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
	   	for(new i = 0; i < MAX_PLAYERS; i++)
 		{
			if((IsPlayerAvail(i)) && (i != playerid) && (i != MAX_ADMIN_LEVEL) && (gTeam[i] == NORMAL))
			{
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				SetPlayerArmour(i, 100.0);
			}
		}
		new string[64];
		format(string, sizeof(string), "Admin %s restored all players armour", __GetName(playerid));
		SendClientMessageToAll(BLUE, string);
		GameTextForAll("Armour for all!", 3000, 3);
		SetPlayerArmour(playerid, 100.0);
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:givecash(playerid, params[])
{
	cmd_pay(playerid, params);
	return 1;
}

COMMAND:givemoney(playerid, params[])
{
	cmd_pay(playerid, params);
	return 1;
}

COMMAND:cash(playerid, params[])
{
	cmd_pay(playerid, params);
	return 1;
}

COMMAND:pay(playerid, params[])
{
	new player, cash;
	if(sscanf(params, "ri", player, cash))
	{
		return SendClientMessage(playerid, ORANGE, "Usage: /pay <playerid> <money>");
	}
	if(IsPlayerAvail(player))
	{
    	if(GetPlayerCash(playerid) < cash)
		{
			return LangMSG(playerid, RED, "You don't have that much!", "Du hast nicht so viel Geld!");
		}
    	if(cash < 1000 || cash > 1000000)
		{
			return SendClientMessage(playerid, YELLOW, "Info: $1,000 - $1,000,000");
		}
    	if(player == playerid)
		{
			return LangMSG(playerid, RED, "You really want to pay yourself?... lol", "Machts wirklich Sinn sich selbst zu bezahlen?... lol");
		}
		new string[128], gstring[128];
      	GivePlayerCash(playerid, -cash);
      	GivePlayerCash(player, cash);
        format(string, sizeof(string), "Info: %s paid you $%i", __GetName(playerid), cash);
        format(gstring, sizeof(gstring), "Info: %s hat dir $%i gezahlt", __GetName(playerid), cash);
        LangMSG(player, YELLOW, string, gstring);
        LangMSG(playerid, YELLOW, "Successfully paid the money!", "Geld erfolgreich gezahlt!");
    }
    else
    {
        LangMSG(playerid, YELLOW, ""er"Player is not connected", ""er"Der Spieler ist nicht verbunden");
    }
	return 1;
}

COMMAND:pornos(playerid, params[])
{
    SendClientMessage(playerid, RED, "Du kannst mir mal fett ein kauen, kein Godfather.");
	return 1;
}

COMMAND:mellnik(playerid, params[])
{
	if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL)
	{
		SetPlayerSkin(playerid, 295);
	    SetPlayerAttachedObject(playerid, 9, 358, 1, 0.2, -0.125, -0.1, 0.0, 25.0, 180.0, 1, 1, 1);
	    SetSpawnInfo(playerid, NO_TEAM, 295, 1958.33, 1343.12, 15.36, 269.15, 0, 0, 0, 0, 0, 0);
  	}
	else
	{
	    LangMSG(playerid, ORANGE, "Nope", "Nein");
	}
	return 1;
}

COMMAND:setallweather(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
		extract params -> new weather; else
		{
			return SendClientMessage(playerid, ORANGE, "Usage: /setallweather <weather id>");
		}

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerAvail(i))
			{
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				SetPlayerWeather(i, weather);
			}
		}
		new string[128];
		format(string, sizeof(string), "Admin %s has set all players weather to '%i'", __GetName(playerid), weather);
		SendClientMessageToAll(BLUE, string);
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:cashfall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
		new string[128];
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerAvail(i))
			{
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				GivePlayerCash(i, 10000);
			}
		}
		GameTextForAll("~y~$10,000 ~w~for all!", 5000, 0);
		format(string, sizeof(string), "Admin %s has given all players $10,000", __GetName(playerid));
		SendClientMessageToAll(BLUE, string);
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:scorefall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
		new string[128];
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerAvail(i))
			{
				PlayerPlaySound(i, 1057,0.0,0.0,0.0);
				_GivePlayerScore(i, 25);
			}
		}
		GameTextForAll("~y~25 ~w~Score for all!", 5000, 0);
		format(string, sizeof(string), "Admin %s has given all players 25 score", __GetName(playerid));
		SendClientMessageToAll(BLUE, string);
	}
	else
	{
		LangMSG(playerid, RED, NO_PERM_ENG, NO_PERM_GER);
	}
	return 1;
}

COMMAND:pn(playerid, params[])
{
	cmd_pm(playerid, params);
	return 1;
}

COMMAND:pm(playerid, params[])
{
	new player, msg[128], finmsg[144];
	if(sscanf(params, "rs[128]", player, msg))
	{
		return SendClientMessage(playerid, ORANGE, "Usage: /pm <playerid> <message>");
	}
	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastPM] + COOLDOWN_CMD_PM) >= tick)
	{
	    return LangMSG(playerid, RED, "Please wait before sending a message again", "Bitte warte einen Augenblick bevor du wieder Nachrichten schreibst");
	}
    PlayerInfo[playerid][tickLastPM] = tick;

	if(!IsPlayerAvail(player))
	{
		return LangMSG(playerid, -1, ""er"Player is not connected!", ""er"Spieler nicht verbunden!");
	}
	if(player == playerid)
	{
	    return LangMSG(playerid, RED, "You can´t pm yourself", "Du kannst dir selbst keine Nachricht schicken");
	}
	format(finmsg, sizeof(finmsg), "***[PM] from %s(%i): %s", __GetName(playerid), playerid, msg);
    SendClientMessage(player, YELLOW, finmsg);
	format(finmsg, sizeof(finmsg), ">>>[PM] to %s(%i): %s", __GetName(player), player, msg);
	SendClientMessage(playerid, YELLOW, finmsg);
	SetPVarInt(player, "LastID", playerid);

	format(finmsg, sizeof(finmsg), ""grey"[PM] from %s(%i) to %s(%i): %s", __GetName(playerid), playerid, __GetName(player), player, msg);
	AdminMSG(GREY, finmsg);
	return 1;
}

COMMAND:r(playerid, params[])
{
    if(GetPVarInt(playerid, "LastID") == -1)
	{
		return LangMSG(playerid, -1, ""er"Noone has send you a message yet", ""er"Niemand hat die bis jetzt eine PM geschickt");
	}
	
	extract params -> new string:msg[128]; else
	{
	    return SendClientMessage(playerid, ORANGE, "Usage: /r <message>");
	}
	new finmsg[144];
	
	new lID = GetPVarInt(playerid, "LastID");
	if(!IsPlayerAvail(lID))
	{
		return LangMSG(playerid, -1, ""er"Player is not connected!", ""er"Spieler nicht verbunden!");
	}
	format(finmsg, sizeof(finmsg), "***[PM] from %s(%i): %s", __GetName(playerid), playerid, msg);
    SendClientMessage(lID, YELLOW, finmsg);
	format(finmsg, sizeof(finmsg), ">>>[PM] to %s(%i): %s", __GetName(lID), lID, msg);
	SendClientMessage(playerid, YELLOW, finmsg);
	SetPVarInt(lID, "LastID", playerid);

	format(finmsg, sizeof(finmsg), ""grey"[PM] from %s(%i) to %s(%i): %s", __GetName(playerid), playerid, __GetName(lID), lID, msg);
	AdminMSG(GREY, finmsg);
	return 1;
}

COMMAND:toy(playerid, params[])
{
	cmd_toys(playerid, "");
	return 1;
}

COMMAND:hod(playerid, params[])
{
	cmd_toys(playerid, "");
	return 1;
}

COMMAND:hods(playerid, params[])
{
	cmd_toys(playerid, "");
	return 1;
}

COMMAND:attachments(playerid, params[])
{
	cmd_toys(playerid, "");
	return 1;
}

COMMAND:attachment(playerid, params[])
{
	cmd_toys(playerid, "");
	return 1;
}

COMMAND:o(playerid, params[])
{
	cmd_toys(playerid, "");
	return 1;
}

COMMAND:toys(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, ""er"GTFO of your vehicle first, sir");
	
	new string[255];
	
	if(PlayerToys[playerid][0][toy_model] == 0)
	{
	    strcat(string, ""dl"Slot 1\n");
	}
	else strcat(string, ""dl"Slot 1 (Used)\n");
	
	if(PlayerToys[playerid][1][toy_model] == 0)
	{
	    strcat(string, ""dl"Slot 2\n");
	}
	else strcat(string, ""dl"Slot 2 (Used)\n");
	
	if(PlayerToys[playerid][2][toy_model] == 0)
	{
	    strcat(string, ""dl"Slot 3\n");
	}
	else strcat(string, ""dl"Slot 3 (Used)\n");
	
	if(PlayerToys[playerid][3][toy_model] == 0)
	{
	    strcat(string, ""dl"Slot 4\n");
	}
	else strcat(string, ""dl"Slot 4 (Used)\n");
	
	if(PlayerToys[playerid][4][toy_model] == 0)
	{
	    strcat(string, ""dl"Slot 5\n");
	}
	else strcat(string, ""dl"Slot 5 (Used)\n");
	
	ShowPlayerDialog(playerid, TOY_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", string, "Select", "Cancel");
	return 1;
}

COMMAND:achievements(playerid, params[])
{
	cmd_achs(playerid, "");
	return 1;
}

COMMAND:erfolge(playerid, params[])
{
	cmd_achs(playerid, "");
	return 1;
}
	
COMMAND:achs(playerid, params[])
{
	new
		tmpstring[255],
		finstring[2048];

	if(PlayerInfo[playerid][Kills] >= 100)
	{
		format(tmpstring, sizeof(tmpstring), ""yellow"Get 100 kills:\t "green"DONE\n");
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""yellow"Get 100 kills:\t "grey"%i/100\n", PlayerInfo[playerid][Kills]);
	}
	strcat(finstring, tmpstring);
	
	if(PlayerInfo[playerid][Deaths] >= 100)
	{
		format(tmpstring, sizeof(tmpstring), ""yellow"Die 100 times:\t "green"DONE\n");
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""yellow"Die 100 times:\t "grey"%i/100\n", PlayerInfo[playerid][Deaths]);
	}
	strcat(finstring, tmpstring);
	
	if(PlayerInfo[playerid][DerbyWins] >= 10)
	{
		format(tmpstring, sizeof(tmpstring), ""yellow"Win 10 Derbys:\t "green"DONE\n");
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""yellow"Win 10 Derbys:\t "grey"%i/10\n", PlayerInfo[playerid][DerbyWins]);
	}
	strcat(finstring, tmpstring);
	
	if(PlayerInfo[playerid][RaceWins] >= 10)
	{
		format(tmpstring, sizeof(tmpstring), ""yellow"Win 10 Races:\t "green"DONE\n");
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""yellow"Win 10 Races:\t "grey"%i/10\n", PlayerInfo[playerid][RaceWins]);
	}
    strcat(finstring, tmpstring);
    
 	if(PlayerInfo[playerid][FalloutWins] >= 20)
	{
		format(tmpstring, sizeof(tmpstring), ""yellow"Win 20 Fallout:\t "green"DONE\n");
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""yellow"Win 20 Fallout:\t "grey"%i/20\n", PlayerInfo[playerid][FalloutWins]);
	}
    strcat(finstring, tmpstring);
    
  	if(PlayerInfo[playerid][GungameWins] >= 10)
	{
		format(tmpstring, sizeof(tmpstring), ""yellow"Win 10 GGs:\t "green"DONE\n");
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""yellow"Win 10 GGs:\t "grey"%i/10\n", PlayerInfo[playerid][GungameWins]);
	}
    strcat(finstring, tmpstring);
    
	ShowPlayerDialog(playerid, ACHS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Achievements", finstring, "OK", "");
	return 1;
}

COMMAND:c(playerid, params[])
{
	cmd_cmds(playerid, "");
	return 1;
}

COMMAND:hilfe(playerid, params[])
{
	cmd_help(playerid, "");
	return 1;
}

COMMAND:hilf(playerid, params[])
{
	cmd_help(playerid, "");
	return 1;
}

COMMAND:commands(playerid, params[])
{
	cmd_cmds(playerid, "");
	return 1;
}

COMMAND:command(playerid, params[])
{
	cmd_cmds(playerid, "");
	return 1;
}

COMMAND:cmd(playerid, params[])
{
	cmd_cmds(playerid, "");
	return 1;
}

COMMAND:cmds(playerid, params[])
{
	new cstring[2048];
	strcat(cstring, ""yellow"/help "white"- A small usefull explanations\n");
	strcat(cstring, ""yellow"/stats "white"- stats of a player also /stats <playerid>\n");
	strcat(cstring, ""yellow"/pm "white"- write a personal message to a player\n");
	strcat(cstring, ""yellow"/r "white"- reply to your last pm\n");
	strcat(cstring, ""yellow"/t "white"- list of all teleport\n");
	strcat(cstring, ""yellow"/w "white"- free weapons\n");
	strcat(cstring, ""yellow"/para "white"- free weapons\n");
	strcat(cstring, ""yellow"/pay "white"- give some cash to a person\n");
	strcat(cstring, ""yellow"/vmenu "white"- private vehicle control\n");
	strcat(cstring, ""yellow"/hitman "white"- set a bounty on someones head\n");
	strcat(cstring, ""yellow"/bounties "white"- see current bounties\n");
	strcat(cstring, ""yellow"/s "white"- save your current position\n");
	strcat(cstring, ""yellow"/l "white"- lave your current position\n");
	strcat(cstring, ""yellow"/v "white"- list of all vehicles also /v <vehicle name>\n");
	strcat(cstring, ""yellow"/id "white"- get the id of a player\n");
	strcat(cstring, ""yellow"/go "white"- goto a desired player\n");
	strcat(cstring, ""yellow"/tgo "white"- set if player can goto you\n");
	strcat(cstring, ""yellow"/admins "white"- a list of all online admins\n");
	strcat(cstring, ""yellow"/car "white"- quick spawn a car\n");
	strcat(cstring, ""yellow"/anims "white"- a lsit of all animations\n");
	strcat(cstring, ""yellow"/skin "white"- change your current skin\n");
	strcat(cstring, ""yellow"/report "white"- report a player\n");
	strcat(cstring, ""yellow"/uptime "white"- see the uptime of the server\n");
	strcat(cstring, ""yellow"/hidef "white"- hide the footer\n");
	strcat(cstring, ""yellow"/showf "white"- show the footer\n");
	strcat(cstring, ""yellow"/jetpack "white"- get a free jetpack\n");
	strcat(cstring, ""yellow"/top "white"- top list selection\n");
	strcat(cstring, ""yellow"/gotomyhouse "white"- goto your house\n");
	strcat(cstring, ""yellow"/gotomybizz "white"- goto your business\n");

	ShowPlayerDialog(playerid, CMDS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Commands", cstring, "Next", "Cancel");
	return 1;
}

COMMAND:uptime(playerid, params[])
{
	SendClientMessage(playerid, GREY, GetUptime());
	return 1;
}

COMMAND:help(playerid, params[])
{
	new
		cstring[2048];

	if(PlayerInfo[playerid][Lang] == 1)
	{
		strcat(cstring, ""red"» "orange"Commands:\n");
		strcat(cstring, ""white"Es gibt viele verschiedene Befehle. Um einen Überblick zu erhalten nutze den Befehl "yellow"/cmds\n\n");

		strcat(cstring, ""red"» "orange"Minispiele\n");
		strcat(cstring, ""white"Ein beliebter Zeitvertreib sind Minispiele welchen du einfach per Befehl beitreten kannst:\n");
		strcat(cstring, ""yellow"/derby /race /gungame /fallout /tdm /minigun /dm /sniper\n\n");

		strcat(cstring, ""red"» "orange"Admins\n");
		strcat(cstring, ""white"Ein Admin sorgt für Ordung mit speziellen Rechten.\n");
		strcat(cstring, ""yellow"/admins "white"zeigt dir eine Liste aller admins welche online sind.\n\n");

		strcat(cstring, ""red"» "orange"Gangs\n");
		strcat(cstring, ""white"Gangs sind Gruppen welche von Spielern erstellt wurden.\n\n");

		strcat(cstring, ""red"» "orange"Häuser/Geschäfte\n");
		strcat(cstring, ""white"Häuser und Geschäfte können in ganz San Andreas erworben werden. Siehe "yellow"/cmds "white"für mehr Infos.");
	}
	else
	{
		strcat(cstring, ""red"» "orange"Commands:\n");
		strcat(cstring, ""white"There are many commands, to get an overview use "yellow"/cmds\n\n");

		strcat(cstring, ""red"» "orange"Minigames\n");
		strcat(cstring, ""white"Available minigames:\n");
		strcat(cstring, ""yellow"/derby /race /gungame /fallout /tdm /minigun /sniper /dm[1-4]\n\n");

		strcat(cstring, ""red"» "orange"Admins\n");
		strcat(cstring, ""white"Admins are here to help, use "yellow"/report "white"if you want to report a player or if you have a question\n\n");

		strcat(cstring, ""red"» "orange"Gangs\n");
		strcat(cstring, ""white"Gangs are groups which have been created by players\n\n");

		strcat(cstring, ""red"» "orange"Houses/Business\n");
		strcat(cstring, ""white"Houses and business are for sale around San Andreas. Use "yellow"/cmds "white"for more infos");
	}
	ShowPlayerDialog(playerid, HELP_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"Help "white"- "orange"ServerIP: 176.28.51.84:7777", cstring, "OK", "CMDS");
    return 1;
}

COMMAND:anims(playerid, params[])
{
    new cstring[1024];
    strcat(cstring, ""orange"All animations are listed below:\n");
    strcat(cstring, ""white"\n/piss - /wank - /dance [1-3] /vomit\n/drunk - /sit - /wave - /lay - /smoke\n/rob - /cigar - /laugh - /handsup - /fucku\n\n");
	strcat(cstring, ""orange"To stop an animation:");
	strcat(cstring, "\n"white"You can press: [SHIFT], [ENTER], [LMB].");

	ShowPlayerDialog(playerid, ANIMS_DIALOG, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Animations", cstring, "OK", "");
	return 1;
}

COMMAND:sit(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "PED", "SEAT_down",3,0,1,1,1,1,1);
	return 1;
}

COMMAND:handsup(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}

COMMAND:cigar(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	return 1;
}

COMMAND:piss(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "PAULNMAC", "Piss_loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:wank(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "PAULNMAC", "wank_loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:dance(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    
    extract params -> new dance; else
    {
        return SendClientMessage(playerid, ORANGE, "Usage: /dance <1-3>");
    }

  	if(dance == 1)
  	{
  	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE1);
  	}
  	else if(dance == 2)
  	{
  	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
  	}
  	else if(dance == 3)
  	{
  	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
  	}
  	else
  	{
  	    SendClientMessage(playerid, ORANGE, "Usage: /dance <1-3>");
  	}

	return 1;
}

COMMAND:vomit(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:drunk(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "PED", "WALK_DRUNK",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:wave(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:lay(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "BEACH", "Lay_Bac_Loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:smoke(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "SHOP", "Smoke_RYD",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:rob(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "SHOP", "ROB_Loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:laugh(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "RAPPING", "Laugh_01",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:fucku(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE) return LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
    ApplyAnimation(playerid, "PED", "fucku",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:weps(playerid, params[])
{
	cmd_w(playerid, params);
	return 1;
}

COMMAND:weapon(playerid, params[])
{
	cmd_w(playerid, params);
	return 1;
}

COMMAND:weapons(playerid, params[])
{
	cmd_w(playerid, params);
	return 1;
}

COMMAND:guns(playerid, params[])
{
	cmd_w(playerid, params);
	return 1;
}

COMMAND:gun(playerid, params[])
{
	cmd_w(playerid, params);
	return 1;
}

COMMAND:waffen(playerid, params[])
{
	cmd_w(playerid, params);
	return 1;
}

COMMAND:w(playerid, params[])
{
	if(gTeam[playerid] == NORMAL)
	{
		ShowDialog(playerid, WEAPON_DIALOG);
	}
	else
	{
		LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	}
	return 1;
}

COMMAND:nos(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && gTeam[playerid] == NORMAL)
    {
        if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][PV_Vehicle])
        {
            return LangMSG(playerid, -1, ""er"Not useable in private vehicles", ""er"Nicht in privatn Fahrzeugen möglich");
        }
        else
        {
	        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
			AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
		}
	}
	else LangMSG(playerid, GREY, NOT_AVAIL, NOT_AVAIL_G);
	return 1;
}

COMMAND:veh(playerid, params[])
{
	return cmd_v(playerid, params);
}

COMMAND:vehs(playerid, params[])
{
	return cmd_v(playerid, params);
}

COMMAND:vehicles(playerid, params[])
{
	return cmd_v(playerid, params);
}

COMMAND:vehicle(playerid, params[])
{
	return cmd_v(playerid, params);
}

COMMAND:cars(playerid, params[])
{
	return cmd_v(playerid, params);
}

COMMAND:v(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 65.0, 1797.3141, -1302.0978, 120.2659) && PlayerInfo[playerid][Level] < 1) return LangMSG(playerid, RED, ""er"Can´t spawn vehicle at this place!", ""er"Hier kann kein Fahrzeug gespawnt werden!");
	if(strlen(params) > 29) return LangMSG(playerid, RED, "I don´t know that vehicle...", "Dieses Fahrzeug ist mir unbekannt...");

	if(gTeam[playerid] == NORMAL)
	{
	    if(IsNumeric(params))
	    {
			if(!IsValidVehicle(strval(params)))
			{
				return LangMSG(playerid, RED, "I don´t know that vehicle...", "Dieses Fahrzeug ist mir unbekannt...");
			}
			if(PlayerInfo[playerid][Vehicle] != -1)
			{
				DestroyVehicle(PlayerInfo[playerid][Vehicle]);
				PlayerInfo[playerid][Vehicle] = -1;
			}
	        CarSpawner(playerid, strval(params));
	    }
	    else
	    {
		    new VehicleS[20];
			if(!sscanf(params, "s[20]", VehicleS))
			{
				new veh = GetVehicleModelID(VehicleS);
				if(!IsValidVehicle(veh))
				{
					return LangMSG(playerid, RED, "I don´t know that vehicle...", "Dieses Fahrzeug ist mir unbekannt...");
				}
				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
		        CarSpawner(playerid, veh);
			}
			else
			{
				ShowDialog(playerid, VEHICLE_DIALOG);
			}
		}
	}
	else
	{
		LangMSG(playerid, RED, NOT_AVAIL, NOT_AVAIL_G);
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS ; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][PV_Vehicle] == vehicleid)
			{
				ModVehicleColor(i);
				ModVehiclePaintJob(i);
				ModVehicleComponents(i);
				break;
		    }
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(response)
	{
		PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0); //1054

	    switch(dialogid)
	    {
	        case TOPLIST_DIALOG :
	        {
	            switch(listitem)
	            {
	                case 0 : cmd_richlist(playerid, "");
	                case 1 : cmd_wanteds(playerid, "");
	                case 2 : cmd_score(playerid, "");
	                case 3 : cmd_kills(playerid, "");
	                case 4 : cmd_deaths(playerid, "");
	                case 5 : cmd_hrs(playerid, "");
	            }
	            return true;
	        }
	 	    case DIALOG_RACE_RACETYPE :
		    {
		        switch(listitem)
		        {
		        	case 0: BuildRaceType = 0;
		        	case 1: BuildRaceType = 3;
				}
				ShowDialog(playerid, DIALOG_RACE_RACEVW);
				return true;
		    }
    	    case DIALOG_RACE_RACEVW, DIALOG_RACE_RACEVWERR:
		    {
		        if(!strlen(inputtext)) return ShowDialog(playerid, DIALOG_RACE_RACEVWERR);
		        if(strval(inputtext) <= 0) return ShowDialog(playerid, DIALOG_RACE_RACEVWERR);
		        BuildVirtualWorld = strval(inputtext);
		        format(BuildName, sizeof(BuildName), GetNextFreeRace());
		        ShowDialog(playerid, DIALOG_RACE_RACEVEH);
				return true;
		    }
	 	    case DIALOG_RACE_RACEVEH, DIALOG_RACE_RACEVEHERR :
		    {
		        if(!strlen(inputtext)) return ShowDialog(playerid, DIALOG_RACE_RACEVEHERR);
		        if(IsNumeric(inputtext))
		        {
		            if(!IsValidVehicle(strval(inputtext))) return ShowDialog(playerid, DIALOG_RACE_RACEVEHERR);
					new
	    				Float:POS[4];
					GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
					GetPlayerFacingAngle(playerid, POS[3]);
					BuildModeVID = strval(inputtext);
					if(BuildVehicle != -1)
					{
					    DestroyVehicle(BuildVehicle);
					    BuildVehicle = -1;
					}
		            BuildVehicle = CreateVehicle(strval(inputtext), POS[0], POS[1], POS[2], POS[3], (random(128) + 127), (random(128) + 127), -1);
		            PutPlayerInVehicle(playerid, BuildVehicle, 0);
					ShowDialog(playerid, DIALOG_RACE_RACESTARTPOS);
				}
		        else
		        {
		            if(!IsValidVehicle(GetVehicleModelID(inputtext))) return ShowDialog(playerid, DIALOG_RACE_RACEVEHERR);
					new
	    				Float:POS[4];
					GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
					GetPlayerFacingAngle(playerid, POS[3]);
					BuildModeVID = GetVehicleModelID(inputtext);
					if(BuildVehicle != -1)
					{
					    DestroyVehicle(BuildVehicle);
					    BuildVehicle = -1;
					}
		            BuildVehicle = CreateVehicle(GetVehicleModelID(inputtext), POS[0], POS[1], POS[2], POS[3], (random(128) + 127), (random(128) + 127), -1);
		            PutPlayerInVehicle(playerid, BuildVehicle, 0);
					ShowDialog(playerid, DIALOG_RACE_RACESTARTPOS);
		        }
		        return true;
		    }
		    case DIALOG_RACE_RACESTARTPOS :
		    {
				SendClientMessage(playerid, GREEN, ">> Go to the start line on the left road and press 'KEY_FIRE' and do the same with the right road block.");
				SendClientMessage(playerid, GREEN, ">> When this is done, you will see a dialog to continue.");
				BuildVehPosCount = 0;
		        BuildTakeVehPos = true;
		        return true;
		    }
    	    case DIALOG_RACE_CHECKPOINTS:
		    {
		        SendClientMessage(playerid, GREEN, ">> Start taking checkpoints now by clicking 'KEY_FIRE'.");
		        SendClientMessage(playerid, GREEN, ">> IMPORTANT: Press 'ENTER' when you're done with the checkpoints! If it doesn't react press again and again.");
		        BuildCheckPointCount = 0;
		        BuildTakeCheckpoints = true;
				return true;
		    }
		    case DIALOG_RACE_RACERDY:
		    {
		        BuildRace = 0;
		        BuildCheckPointCount = 0;
		        BuildVehPosCount = 0;
		        BuildTakeCheckpoints = false;
		        BuildTakeVehPos = false;
				if(BuildVehicle != -1)
				{
				    DestroyVehicle(BuildVehicle);
				    BuildVehicle = -1;
				}
				return true;
		    }
		    case TELE_DIALOG :
		    {
		        switch(listitem)
		        {
		            case 0 : // Parkours
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 1, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Teleports",
						"Parkour 1 (/parkour)\nParkour 2 (/parkour2)\nParkour 3 (/parkour3)\nParkour 4 (/parkour4)\nParkour 5 (/parkour5)\nParkour 6 (/parkour6)\nParkour 7 (/parkour7)\nNRG Parkour (/nrg)\nQuad Parkour (/qp)\nSKY Parkour (/sky)\nLos Santos Parkour (/lsp) [for noobs]", "Select", "Back");
		            }
		            case 1 : // Stunting Teles
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 2, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Teleports",
						"Jubber Jump (/jujump)\nSherman Dam (/sd)\nRectAngle (/rect)\nAbandoned Airport (/aa)\nMaze (/maze)\nMaze2 (/maze2)\nMaze3 (/maze3)\nMaze4 (/maze4)\nSpeed Jump (/speed)\nDawn Derby (/dd)\nSan Fierro Airport (/sfa)\nLos Santos Airport (/lsa)\nLas Venturas Airport (/lva)", "Select", "Back");
					}
		            case 2 : // basejump
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 3, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Teleports",
						"Eiffel Tower (/et)\nEaster Egg(/ee)\nSF Tower Jump (/sftj)\nSKY Jump (/sky)\nPlane Jump (/plane)", "Select", "Back");
					}
		            case 3 : // vehicle jumps
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 4, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Teleports",
						"Skyroad (/skyroad)\nSkyroad 2 (/skyroad2)\nSkyroad 3 (/skyroad3)\nWater Jump (/wj)\nRectAngle (/rect)\nLOOP (/loop)\nGlobe (/globe)\nDawn Derby (/dd)\nSF Airport (/sfa)\nLS Airport (/lsa)\nLV Airport (/lva)\nDrag (/drag)\nPARK (/park)", "Select", "Back");
					}
		            case 4 : // other fun maps
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 5, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Teleports",
						"Krusty Krab (/kk)\nSnow (/snow)\nArea51 (/a51)\nBowl (/bowl)\nEeaster Egg (/ee)\nBordel (/bordel)\nFarm (/farm)\nBeach (/beach)\nGlory (/glory)\nLS Police Department (/lspd)\nLV Police Department (/lvpd)\nSF Police Department (/sfpd)", "Select", "Back");
					}
		            case 5 : // specials
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 6, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Teleports",
						"Dilimore Airport (/da)\nLas Venturas (/lv)\nBurger Shot (/bs)\nBurger Shot 2 (/bs2)\nBurger Shot 3 (/bs3)\nBurger Shot 4 (/bs4)\nBurger Shot 5 (/bs5)\nFilm (/film)\nGlen Park (/glen)\nQuarry (/quarry)\nVehicle Shop (/vs)\nMarket Station (/ms)\nTF (/trans)\nTF (/trans2)\nTF (/trans3)\nLoco Low (/lw)", "Select", "Back");
					}
		        }
		    }
		    case TELE_DIALOG +1 : // parkours
		    {
		        switch(listitem)
		        {
		            case 0: cmd_parkour(playerid, "");
		            case 1: cmd_parkour2(playerid, "");
		            case 2: cmd_parkour3(playerid, "");
		            case 3: cmd_parkour4(playerid, "");
		            case 4: cmd_parkour5(playerid, "");
		            case 5: cmd_parkour6(playerid, "");
		            case 6: cmd_parkour7(playerid, "");
		            case 7: cmd_nrg(playerid, "");
		            case 8: cmd_qp(playerid, "");
		            case 9: cmd_sky(playerid, "");
		            case 10: cmd_lsp(playerid, "");
		        }
		    }
		    case TELE_DIALOG +2 : // Stunting
		    {
		        switch(listitem)
		        {
		            case 0: cmd_jujump(playerid, "");
                    case 1: cmd_sd(playerid, "");
                    case 2: cmd_rect(playerid, "");
                    case 3: cmd_aa(playerid, "");
                    case 4: cmd_maze(playerid, "");
                    case 5: cmd_maze2(playerid, "");
                    case 6: cmd_maze3(playerid, "");
                    case 7: cmd_maze4(playerid, "");
                    case 8: cmd_speed(playerid, "");
                    case 9: cmd_dd(playerid, "");
                    case 10: cmd_sfa(playerid, "");
                    case 11: cmd_lsa(playerid, "");
                    case 12: cmd_lva(playerid, "");
		        }
		    }
		    case TELE_DIALOG +3 : //base jumps
		    {
		        switch(listitem)
		        {
                    case 0: cmd_et(playerid, "");
                    case 1: cmd_ee(playerid, "");
                    case 2: cmd_sftj(playerid, "");
                    case 3: cmd_sky(playerid, "");
                    case 4: cmd_plane(playerid, "");
		        }
		    }
		    case TELE_DIALOG +4 : // vehicle jumps
		    {
		        switch(listitem)
		        {
                    case 0: cmd_skyroad(playerid, "");
                    case 1: cmd_skyroad2(playerid, "");
                    case 2: cmd_skyroad3(playerid, "");
                    case 3: cmd_wj(playerid, "");
                    case 4: cmd_rect(playerid, "");
                    case 5: cmd_loop(playerid, "");
                    case 6: cmd_globe(playerid, "");
                    case 7: cmd_dd(playerid, "");
                    case 8: cmd_sfa(playerid, "");
                    case 9: cmd_lsa(playerid, "");
                    case 10: cmd_lva(playerid, "");
                    case 11: cmd_drag(playerid, "");
                    case 12: cmd_park(playerid, "");
		        }
		    }
		    case TELE_DIALOG +5 : // other fun maps
		    {
		        switch(listitem)
		        {
		            case 0: cmd_kk(playerid, "");
                    case 1: cmd_snow(playerid, "");
                    case 2: cmd_a51(playerid, "");
                    case 3: cmd_bowl(playerid, "");
                    case 4: cmd_ee(playerid, "");
                    case 5: cmd_bordel(playerid, "");
                    case 6: cmd_farm(playerid, "");
                    case 7: cmd_beach(playerid, "");
                    case 8: cmd_glory(playerid, "");
                    case 9: cmd_lspd(playerid, "");
                    case 10: cmd_lvpd(playerid, "");
                    case 11: cmd_sfpd(playerid, "");
		        }
		    }
		    case TELE_DIALOG +6 : // specials
		    {
		        switch(listitem)
		        {
		            case 0: cmd_da(playerid, "");
                    case 1: cmd_lv(playerid, "");
                    case 2: cmd_bs(playerid, "");
                    case 3: cmd_bs2(playerid, "");
                    case 4: cmd_bs3(playerid, "");
                    case 5: cmd_bs4(playerid, "");
                    case 6: cmd_bs5(playerid, "");
                    case 7: cmd_film(playerid, "");
                    case 8: cmd_glen(playerid, "");
                    case 9: cmd_quarry(playerid, "");
                    case 10: cmd_vs(playerid, "");
                    case 11: cmd_ms(playerid, "");
                    case 12: cmd_trans(playerid, "");
                    case 13: cmd_trans2(playerid, "");
                    case 14: cmd_trans3(playerid, "");
                    case 15: cmd_lw(playerid, "");
		        }
		    }
		    case CMDS_DIALOG :
		    {
		        new cstring[2048];
		        strcat(cstring, ""yellow"/streams "white"- listen to audio streams\n");
		        strcat(cstring, ""yellow"/wanteds "white"- a list of wanteded players\n");
		        strcat(cstring, ""yellow"/richlist "white"- the richlist\n");
		        strcat(cstring, ""yellow"/score "white"- top score players\n");
				strcat(cstring, ""yellow"/sb "white"- toggle speedboost\n");
				strcat(cstring, ""yellow"/sj "white"- toggle superjump\n");
				strcat(cstring, ""yellow"/enter "white"- enter a unlocked house\n");
				strcat(cstring, ""yellow"/buy "white"- buy a house\n");
				strcat(cstring, ""yellow"/sell "white"- sell your house\n");
				strcat(cstring, ""yellow"/lock "white"- lock your house or vehicle\n");
				strcat(cstring, ""yellow"/bbuy "white"- buy a business\n");
				strcat(cstring, ""yellow"/bsell "white"- sell your business\n");
				strcat(cstring, ""yellow"/gcreate "white"- create a gang\n");
				strcat(cstring, ""yellow"/ginvite "white"- invite someone to your gang\n");
				strcat(cstring, ""yellow"/gkick "white"- kick someone off your gang\n");
				strcat(cstring, ""yellow"/gjoin "white"- join a gang\n");
				strcat(cstring, ""yellow"/gleave "white"- leave the gang you are in\n");
				strcat(cstring, ""yellow"/gclose "white"- destroy your gang\n");
				strcat(cstring, ""yellow"/gdeny "white"- deny an invitation\n");
				strcat(cstring, ""yellow"/gmenu "white"- gangmenu\n");
                strcat(cstring, ""yellow"/fs "white"- fightstyles\n");
                strcat(cstring, ""yellow"/achs "white"- achievements\n");
    			strcat(cstring, ""yellow"/ger "white"- set your language to german\n");
				strcat(cstring, ""yellow"/eng "white"- set your language to english\n");
				strcat(cstring, ""yellow"/g "white"- german chat\n");
				strcat(cstring, ""yellow"/tgerchat "white"- toggle german chat only useable when \nyour language is set to german\n");

				ShowPlayerDialog(playerid, CMDS_DIALOG + 1, DIALOG_STYLE_MSGBOX, ""orange"NG-Stunting "white"- Commands", cstring, "OK", "");
		    }
	        case GMENU_DIALOG :
	        {
		        switch(listitem)
		        {
		            case 0:
		            {
						MySQL_FetchGangInfo(playerid, PlayerInfo[playerid][GangID]);
		            }
		            case 1:
		            {
		                MySQL_FetchGangMemberNames(playerid, PlayerInfo[playerid][GangID]);
		            }
		        }
		        return true;
	        }
	        case DERBY_VOTING_DIALOG :
	        {
				if(!IsDerbyRunning)
				{
				    new
						string[100],
						gstring[100]
					;

				    switch(listitem)
				    {
				        case 0:
						{
						    format(string, sizeof(string), "%s has voted for Map 'Lighthouse'", __GetName(playerid));
						    format(gstring, sizeof(gstring), "%s hat für die Map 'Lighthouse' gevotet", __GetName(playerid));
							DerbyMapVotes[0]++;
							DerbyMSG(string, gstring);
						}
						case 1:
						{
						    format(string, sizeof(string), "%s has voted for Map 'Truncat'", __GetName(playerid));
						    format(gstring, sizeof(gstring), "%s hat für die Map 'Truncat' gevotet", __GetName(playerid));
							DerbyMapVotes[1]++;
							DerbyMSG(string, gstring);
						}
						case 2:
						{
						    format(string, sizeof(string), "%s has voted for Map 'Sky Skiing'", __GetName(playerid));
						    format(gstring, sizeof(gstring), "%s hat für die Map 'Sky Skiing' gevotet", __GetName(playerid));
							DerbyMapVotes[2]++;
							DerbyMSG(string, gstring);
						}
						case 3:
						{
						    format(string, sizeof(string), "%s has voted for Map 'Townhall'", __GetName(playerid));
						    format(gstring, sizeof(gstring), "%s hat für die Map 'Townhall' gevotet", __GetName(playerid));
							DerbyMapVotes[3]++;
							DerbyMSG(string, gstring);
						}
						case 4:
						{
						    format(string, sizeof(string), "%s has voted for Map 'Glazz'", __GetName(playerid));
						    format(gstring, sizeof(gstring), "%s hat für die Map 'Glazz' gevotet", __GetName(playerid));
							DerbyMapVotes[4]++;
							DerbyMSG(string, gstring);
						}
						case 5:
						{
						    format(string, sizeof(string), "%s has voted for Map 'Rambo'", __GetName(playerid));
						    format(gstring, sizeof(gstring), "%s hat für die Map 'Rambo' gevotet", __GetName(playerid));
							DerbyMapVotes[5]++;
							DerbyMSG(string, gstring);
						}
					}
				}
				else
				{
					SendClientMessage(playerid, BLUE, "No voting time now!");
				}
				return true;
			}
			case BANK_DIALOG :
			{
			    switch(listitem)
			    {
				    case 0: // Deposit
				    {
				        new string[130];
				        format(string, sizeof(string), ""white"» You have "yellow"$%i"white" in your bank account.\n\nType in the amount you want to deposit below:", PlayerInfo[playerid][Bank]);
				        ShowPlayerDialog(playerid, BANK_DIALOG+1, DIALOG_STYLE_INPUT, " ", string, "Deposit", "Cancel");
				    }
				    case 1: // Withdraw
				    {
				        new string[130];
				        format(string, sizeof(string), ""white"» You have "yellow"$%i"white" in your bank account.\n\nType in the amount you want to withdraw below:", PlayerInfo[playerid][Bank]);
				        ShowPlayerDialog(playerid, BANK_DIALOG+2, DIALOG_STYLE_INPUT, " ", string, "Withdraw", "Cancel");
				    }
				    case 2: // Check Balance
				    {
				        new string[130];
				        format(string, sizeof(string), ""white"» You have "yellow"$%i"white" in your bank account.", PlayerInfo[playerid][Bank]);
				        ShowPlayerDialog(playerid, 11231, DIALOG_STYLE_MSGBOX, " ", string, "OK", "");
				    }
			    }
			    return true;
			}
			case BANK_DIALOG + 1 :
			{
			    new string[100],
					gstring[100];
					
				extract inputtext -> new inamount; else
				{
				    return LangMSG(playerid, WHITE, ""er"Invalid amount.", ""er"Falscher Betrag!");
				}

				if(inamount > GetPlayerCash(playerid))
				{
					LangMSG(playerid, WHITE, ""er"You don't have that much money!", ""er"Nicht genügend Geld!");
				}
				else if(inamount < 1)
				{
					LangMSG(playerid, WHITE, ""er"Invalid amount.", ""er"Falscher Betrag!");
				}
				else
				{
					GivePlayerCash(playerid, -inamount);
					PlayerInfo[playerid][Bank] += inamount;
					format(string, sizeof(string), "» You have deposited {FF7800}$%i"white" into your bank account", inamount);
					format(gstring, sizeof(gstring), "» Du hast {FF7800}$%i"white" eingezahlt", inamount);
					LangMSG(playerid, WHITE, string, gstring);
				}
				return true;
			}
			case BANK_DIALOG+2 :
			{
			    new string[100],
					gstring[100];
					
				extract inputtext -> new outamount; else
				{
				    return LangMSG(playerid, WHITE, ""er"Invalid amount.", ""er"Falscher Betrag!");
				}
				
				if(outamount > PlayerInfo[playerid][Bank])
				{
					LangMSG(playerid, WHITE, ""er"You do not have that much money in your bank account!", ""er"So viel Geld hast du nicht auf der Bank!");
				}
				else if(outamount < 1)
				{
					LangMSG(playerid, WHITE, ""er"Invalid amount!", ""er"Falscher Betrag!");
				}
				else
				{
					GivePlayerCash(playerid, outamount);
					PlayerInfo[playerid][Bank] -= outamount;
					format(string, sizeof(string), "» You have withdrawn {FF7800}$%i"white" from your bank account", outamount);
					format(gstring, sizeof(gstring), "» Du hast {FF7800}$%i"white" abgehoben", outamount);
					LangMSG(playerid, WHITE, string, gstring);
				}
				return true;
			}
			case LIFT_DIALOG :
			{
		        if(FloorRequestedBy[listitem] != INVALID_PLAYER_ID || IsFloorInQueue(listitem))
		        {
		            GameTextForPlayer(playerid, "~r~The floor is already in queue", 3500, 4);
				}
				else if(DidPlayerRequestElevator(playerid))
				{
				    GameTextForPlayer(playerid, "~r~You already requested the elevator", 3500, 4);
				}
				else
				{
			        CallElevator(playerid, listitem);
				}
				return true;
			}
			case LANG_DIALOG :
			{
			    PlayerInfo[playerid][Lang] = 0;
			    registerDIALOG(playerid);
				SendClientMessage(playerid, GREEN, ""blue"Your language is English.");
				return true;
			}
			case LOGIN_DIALOG :
			{
				if(strlen(inputtext) < 4 || strlen(inputtext) > 32)
				{
					SendClientMessage(playerid, -1, ""er" Length 4 - 32");
					return loginDIALOG(playerid);
				}
				if(isnull(inputtext)) return loginDIALOG(playerid);
				if(strfind(inputtext, " ", false) != -1)
				{
				    SendClientMessage(playerid, -1, ""er" No spaces allowed");
					return loginDIALOG(playerid);
				}
				extract inputtext -> new string:password[33]; else // früher war das auch ohne dem makro
				{
					loginDIALOG(playerid);
					return SendClientMessage(playerid, -1, ""er" Length 4 - 32");
				}
		   		MySQL_CheckPlayerPassword(playerid, password);
			    return true;
			}
			case REGISTER_DIALOG :
			{
			    if(strlen(inputtext) < 4 || strlen(inputtext) > 32)
				{
					LangMSG(playerid, -1, ""er" Password length: 4 - 32 characters", ""er" Passwortlänge: 4 - 32 Zeichen");
					return registerDIALOG(playerid);
				}
				if(isnull(inputtext)) return registerDIALOG(playerid);
				if(strfind(inputtext, " ", true) != -1)
				{
				    SendClientMessage(playerid, -1, ""er" No spaces allowed");
					return registerDIALOG(playerid);
				}
				extract inputtext -> new string:password[33]; else // früher war das auch ohne dem makro // overflow nachdem jemand poiuytrewqasdfghjklmnbvcxz67890 eingegeben hat
				{
					registerDIALOG(playerid);
					return SendClientMessage(playerid, -1, ""er" Length 4 - 32");
				}
			    MySQL_CreateAccount(playerid, password);
			    return true;
			}
			case STREAM_DIALOG :
			{
				switch(listitem)
		    	{
	      			case 0: ShowPlayerDialog(playerid, STREAM_DIALOG+1, DIALOG_STYLE_LIST, ""orange"Electronic", ""dl"TechnoBase.FM\n"dl"#MUSIK.CLUB - WWW.RAUTEMUSIK.FM", "Select", "Back");
					case 1: ShowPlayerDialog(playerid, STREAM_DIALOG+2, DIALOG_STYLE_LIST, ""orange"Metal", ""dl"#MUSIK.ROCK (EXTREME)\n"dl"RockRadio1.Com - Classic hardrock", "Select", "Back");
					case 2: ShowPlayerDialog(playerid, STREAM_DIALOG+3, DIALOG_STYLE_LIST, ""orange"Pop", ""dl"idobi Radio: New. Music.\n"dl"DEFJAY.DE - 100% R&B!", "Select", "Back");
					case 3: ShowPlayerDialog(playerid, STREAM_DIALOG+4, DIALOG_STYLE_LIST, ""orange"Hip Hop", ""dl"HOT 108 JAMZ - #1 FOR HIP HOP\n"dl"HIT104 - Your Top 40 Channel", "Select", "Back");
					case 4: ShowPlayerDialog(playerid, STREAM_DIALOG+5, DIALOG_STYLE_LIST, ""orange"Rap", ""dl"POWERHITZ.COM - #1 FOR HITZ\n"dl"RADIOUP.COM - THE HITLIST", "Select", "Back");
					case 5: ShowPlayerDialog(playerid, STREAM_DIALOG+6, DIALOG_STYLE_LIST, ""orange"Rock", ""dl"Radio Paradise - DJ-mixed modern\n"dl"181.FM - Kickin' Country", "Select", "Back");
					case 6: ShowPlayerDialog(playerid, STREAM_DIALOG+7, DIALOG_STYLE_LIST, ""orange"Oldies", ""dl"#MUSIK.GOLDIES - WWW.RAUTEMUSIK.FM\n"dl"Oldies104 (Powered by Star104.net)", "Select", "Back");
					case 7: ShowPlayerDialog(playerid, STREAM_DIALOG+8, DIALOG_STYLE_INPUT, ""orange"Your own stream", ""white"Please enter the audio stream you want to listen to", "Play", "Back");
				}
				return true;
			}
			case STREAM_DIALOG+1 :
			{
				switch(listitem)
		    	{
		        	case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377200");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1275319");
    			}
				return true;
			}
			case STREAM_DIALOG+2 :
			{
				switch(listitem)
		    	{
		       		case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=117229");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1105299");
				}
				return true;
			}
			case STREAM_DIALOG+3 :
			{
				switch(listitem)
		    	{
		        	case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=21585");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=65456");
				}
				return true;
			}
			case STREAM_DIALOG+4 :
			{
	  			switch(listitem)
		    	{
		        	case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1281016");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=663859");
				}
				return true;
			}
			case STREAM_DIALOG+5 :
			{
				switch(listitem)
			    {
			        case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283516");
			        case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1282490");
				}
				return true;
			}
			case STREAM_DIALOG+6 :
			{
				switch(listitem)
			    {
			        case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1354805");
			        case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283687");
				}
				return true;
			}
			case STREAM_DIALOG+7 :
			{
				switch(listitem)
		    	{
		        	case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1268157");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1271826");
				}
				return true;
			}
			case STREAM_DIALOG+8 :
			{
			    extract inputtext -> new string:link[128]; else
			    {
					return ShowPlayerDialog(playerid, STREAM_DIALOG+8, DIALOG_STYLE_INPUT, ""orange"Your own stream", ""white"Please enter the audio stream you want to listen to", "Play", "Back");
			    }
				PlayAudioStreamForPlayer(playerid, link);
				return true;
			}
			case TOY_DIALOG :
			{
			    switch(listitem)
			    {
			        case 0 : //slot 1
			        {
						PlayerInfo[playerid][toy_selected] = 0;
						if(PlayerToys[playerid][0][toy_model] == 0)
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", GetToysAvail(), "Select", "Cancel");
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 2, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
			        }
			        case 1 : //slot 2
			        {
			        	PlayerInfo[playerid][toy_selected] = 1;
						if(PlayerToys[playerid][1][toy_model] == 0)
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", GetToysAvail(), "Select", "Cancel");
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 2, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
			        }
			        case 2 : //slot 3
			        {
			            PlayerInfo[playerid][toy_selected] = 2;
						if(PlayerToys[playerid][2][toy_model] == 0)
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", GetToysAvail(), "Select", "Cancel");
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 2, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
					}
			        case 3 : //slot 4
			        {
			            PlayerInfo[playerid][toy_selected] = 3;
						if(PlayerToys[playerid][3][toy_model] == 0)
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", GetToysAvail(), "Select", "Cancel");
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 2, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
					}
			        case 4 : //slot 5
			        {
			            PlayerInfo[playerid][toy_selected] = 4;
						if(PlayerToys[playerid][4][toy_model] == 0)
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", GetToysAvail(), "Select", "Cancel");
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 2, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
					}
			    }
				return true;
			}
			case TOY_DIALOG + 1 :
			{
			    if(listitem == 0)
			    {
			    	return ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", GetToysAvail(), "Select", "Cancel");
			    }

			    if(GetPlayerCash(playerid) < 25000)
			    {
					LangMSG(playerid, RED, ""er"You can´t afford the toy", ""er"Du kannst dir das Toy nicht leitsten");
					return true;
			    }
			    GivePlayerCash(playerid, -25000);
			    GameTextForPlayer(playerid, "~r~-$25,000", 2000, 1);

			    switch(listitem)
			    {
			        case 0 :
			        {
			    		ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", GetToysAvail(), "Select", "Cancel");
						return true;
					}
			        case 1 : // top hat
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19352;
			        }
			        case 2 : // turtle
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 1609;
			        }
			        case 3 : // minigun
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 362;
			        }
			        case 4 : // LP
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 18643;
			        }
			        case 5 : // PS
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 18637;
			        }
			        case 6 : // parrot
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19078;
			        }
			        case 7 : // dildosaw
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19086;
			        }
			        case 8 : // burger hat
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19094;
			        }
			        case 9 : // police glasses
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19138;
			        }
			        case 10 : // police hat
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19099;
			        }
			        case 11 : // SantaHat3
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19066;
			        }
			        case 12 : // Gasmask
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19472;
			        }
			        case 13 : // Little Bambi
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19315;
			        }
			        case 14 : // Pumpkin
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19320;
			        }
			        case 15 : // Bassguitar
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19317;
			        }
			        case 16 : // Taxi Sign
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 19308;
			        }
			        case 17 : // money bag
			        {
			            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 1550;
			        }
			    }

	            SetPlayerAttachedObject(playerid, PlayerInfo[playerid][toy_selected], PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model], 1);
			    MySQL_SavePlayerToys(playerid);
			    
		        EditAttachedObject(playerid, PlayerInfo[playerid][toy_selected]);
		        ShowPlayerToyTextdraws(playerid);
		        LangMSG(playerid, GREEN, "Successfully bought the toy!", "Toy wurde erfolgreich gekauft!");
			    return true;
			}
			case TOY_DIALOG + 2 :
			{
				switch(listitem)
				{
				    case 0 : // edit
				    {
				        EditAttachedObject(playerid, PlayerInfo[playerid][toy_selected]);
				        ShowPlayerToyTextdraws(playerid);
				        LangMSG(playerid, YELLOW, "You are now editing the toy", "Du editierst nun das Toy");
				    }
				    case 1 : // change bone
					{
					    new finstring[750];

					    strcat(finstring, ""dl"Spine\n"dl"Head\n"dl"Left upper arm\n"dl"Right upper arm\n"dl"Left hand\n"dl"Right hand\n"dl"Left thigh\n"dl"Right tigh\n"dl"Left foot\n"dl"Right foot");
					    strcat(finstring, "\n"dl"Right calf\n"dl"Left calf\n"dl"Left forearm\n"dl"Right forearm\n"dl"Left clavicle\n"dl"Right clavicle\n"dl"Neck\n"dl"Jaw");

					    ShowPlayerDialog(playerid, TOY_DIALOG + 3, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Player Toys", finstring, "Select", "Cancel");
					}
					case 2 : // remove toy
					{
					    if(IsPlayerAttachedObjectSlotUsed(playerid, PlayerInfo[playerid][toy_selected]))
						{
							RemovePlayerAttachedObject(playerid, PlayerInfo[playerid][toy_selected]);
						}
						PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = 0;
						SendInfo(playerid, "~h~~y~Toy removed!", 3500);
					}
				}
			    return true;
			}
			case TOY_DIALOG + 3 : //change bone
			{
			    listitem++;
			    PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_bone] = listitem;

			    if(IsPlayerAttachedObjectSlotUsed(playerid, PlayerInfo[playerid][toy_selected])) RemovePlayerAttachedObject(playerid, PlayerInfo[playerid][toy_selected]);

			    listitem = PlayerInfo[playerid][toy_selected];

	            SetPlayerAttachedObject(playerid,
	                listitem,
	                PlayerToys[playerid][listitem][toy_model],
	                PlayerToys[playerid][listitem][toy_bone],
	                PlayerToys[playerid][listitem][toy_x],
	                PlayerToys[playerid][listitem][toy_y],
	                PlayerToys[playerid][listitem][toy_z],
	                PlayerToys[playerid][listitem][toy_rx],
	                PlayerToys[playerid][listitem][toy_ry],
	                PlayerToys[playerid][listitem][toy_rz],
	                PlayerToys[playerid][listitem][toy_sx],
	                PlayerToys[playerid][listitem][toy_sy],
	                PlayerToys[playerid][listitem][toy_sz]);

			    LangMSG(playerid, GREEN, "Bone changed", "Knochen geändert");

			    return true;
			}
			case VEHICLE_DIALOG :
			{
			   	switch(listitem)
				{
					case 0 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+1, DIALOG_STYLE_LIST, ""orange"Airplanes", "Andromada\nAT-400\nBeagle\nCropduster\nDodo\nNevada\nRustler\nShamal\nSkimmer\nStuntplane", "Select", "Back");
					case 1 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+2, DIALOG_STYLE_LIST, ""orange"Helicopters", "Cargobob\nLeviathan\nMaverick\nNews Maverick\nPolice Maverick\nRaindance\nSeasparrow\nSparrow", "Select", "Back");
					case 2 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+3, DIALOG_STYLE_LIST, ""orange"Bikes", "BF-400\nBike\nBMX\nFaggio\nFCR-900\nFreeway\nMountain Bike\nNRG-500\nPCJ-600\nPizzaboy\nQuad\nSanchez\nWayfarer", "Select", "Back");
					case 3 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+4, DIALOG_STYLE_LIST, ""orange"Convertibles", "Comet\nFeltzer\nStallion\nWindsor", "Select", "Back");
					case 4 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+5, DIALOG_STYLE_LIST, ""orange"Industrial", "Benson\nBobcat\nBurrito\nBoxville\nBoxburg\nCement Truck\nDFT-30\nFlatbed\nLinerunner\nMule\nNewsvan\nPacker\nPetrol Tanker\nPony\nRoadtrain\nRumpo\nSadler\nSadler Shit\nTopfun\nTractor\nTrashmaster\nUtility Van\nWalton\nYankee\nYosemite", "Select", "Back");
					case 5 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+6, DIALOG_STYLE_LIST, ""orange"Lowriders", "Blade\nBroadway\nRemington\nSavanna\nSlamvan\nTahoma\nTornado\nVoodoo", "Select", "Back");
					case 6 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+7, DIALOG_STYLE_LIST, ""orange"Off Road", "Bandito\nBF Injection\nDune\nHuntley\nLandstalker\nMesa\nMonster\nMonster A\nMonster B\nPatriot\nRancher A\nRancher B\nSandking", "Select", "Back");
					case 7 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+8, DIALOG_STYLE_LIST, ""orange"Public Service Vehicles", "Ambulance\nBarracks\nBus\nCabbie\nCoach\nCop Bike (HPV-1000)\nEnforcer\nFBI Rancher\nFBI Truck\nFiretruck\nFiretruck LA\nPolice Car (LSPD)\nPolice Car (LVPD)\nPolice Car (SFPD)\nRanger\nRhino\nS.W.A.T\nTaxi", "Select", "Back");
					case 8 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+9, DIALOG_STYLE_LIST, ""orange"Saloons", "Admiral\nBloodring Banger\nBravura\nBuccaneer\nCadrona\nClover\nElegant\nElegy\nEmperor\nEsperanto\nFortune\nGlendale Shit\nGlendale\nGreenwood\nHermes\nIntruder\nMajestic\nManana\nMerit\nNebula\nOceanic\nPicador\nPremier\nPrevion\nPrimo\nSentinel\nStafford\nSultan\nSunrise\nTampa\nVincent\nVirgo\nWillard\nWashington", "Select", "Back");
					case 9 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+10, DIALOG_STYLE_LIST, ""orange"Sport Vehicles", "Alpha\nBanshee\nBlista Compact\nBuffalo\nBullet\nCheetah\nClub\nEuros\nFlash\nHotring Racer\nHotring Racer A\nHotring Racer B\nInfernus\nJester\nPhoenix\nSabre\nSuper GT\nTurismo\nUranus\nZR-350", "Select", "Back");
					case 10 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+11, DIALOG_STYLE_LIST, ""orange"Station Wagons", "Moonbeam\nPerenniel\nRegina\nSolair\nStratum", "Select", "Back");
					case 11 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+12, DIALOG_STYLE_LIST, ""orange"Boats", "Coastguard\nDinghy\nJetmax\nLaunch\nMarquis\nPredator\nReefer\nSpeeder\nSquallo\nTropic", "Select", "Back");
					case 12 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+13, DIALOG_STYLE_LIST, ""orange"Trailers", "Article Trailer\nArticle Trailer 2\nArticle Trailer 3\nBaggage Trailer A\nBaggage Trailer B\nFarm Trailer\nPetrol Trailer\nStairs Trailer\nUtility Trailer", "Select", "Back");
					case 13 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+14, DIALOG_STYLE_LIST, ""orange"Unique Vehicles", "Baggage\nBrownstreak (Train)\nCaddy\nCamper\nCamper A\nCombine Harvester\nDozer\nDumper\nForklift\nFreight (Train)\nHotknife\nHustler\nHotdog\nKart\nMower\nMr Whoopee\nRomero\nSecuricar\nStretch\nSweeper\nTram\nTowtruck\nTug\nVortex", "Select", "Back");
					case 14 : ShowPlayerDialog(playerid, VEHICLE_DIALOG+15, DIALOG_STYLE_LIST, ""orange"RC Vehicles", "RC Bandit\nRC Baron\nRC Raider\nRC Goblin\nRC Tiger\nRC Cam", "Select", "Back");
				}
				return true;
			}
			case VEHICLE_DIALOG+1 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
	   			new model_array[] = {592, 577, 511, 512, 593, 553, 476, 519, 460, 513};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+2 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
			    new model_array[] = {548, 417, 487, 488, 497, 563, 447, 469};
	            CarSpawner(playerid, model_array[listitem]);
			    return true;
			}
			case VEHICLE_DIALOG+3 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
				new	model_array[] = {581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 471, 468, 586};
    			CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+4 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
	   			new	model_array[] = {480, 533, 439, 555};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+5 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
				new model_array[] = {499, 422, 482, 498, 609, 524, 578, 455, 403, 414, 582, 443, 514, 413, 515, 440, 543, 605, 459, 531, 408, 552, 478, 456, 554};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+6 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
			    new model_array[] = { 536, 575, 534, 567, 535, 566, 576, 412 };
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+7 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
	    		new model_array[] = {568, 424, 573, 579, 400, 500, 444, 556, 557, 470, 489, 505, 495};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+8 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
				new model_array[] = {416, 433, 431, 438, 437, 523, 427, 490, 528, 407, 544, 596, 598, 597, 599, 432, 601, 420};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+9 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
			    new model_array[] = {445, 504, 401, 518, 527, 542, 507, 562, 585, 419, 526, 604, 466, 492, 474, 546, 517, 410, 551, 516, 467, 600, 426, 436, 547, 405, 580, 560, 550, 549, 540, 491, 529, 421};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
   			}
			case VEHICLE_DIALOG+10 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
	    		new model_array[] = {602, 429, 496, 402, 541, 415, 589, 587, 565, 494, 502, 503, 411, 559, 603, 475, 506, 451, 558, 477};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+11 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
				new model_array[] = {418, 404, 479, 458, 561};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+12 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
		        new model_array[] = {472, 473, 493, 595, 484, 430, 453, 452, 446, 454};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+13 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
			    new model_array[] = {435, 450, 591, 606, 607, 610, 584, 608, 611};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+14 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
		        new model_array[] = {485, 537, 457, 483, 508, 532, 486, 406, 530, 538, 434, 545, 588, 571, 572, 423, 442, 428, 409, 574, 449, 525, 583, 539};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+15 :
			{
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
		        new model_array[] = {441, 464, 465, 501, 564, 594};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case WEAPON_DIALOG :
			{
	  			switch(listitem)
		    	{
					case 0:{ShowPlayerDialog(playerid, WEAPON_DIALOG+1, DIALOG_STYLE_LIST, ""orange"Rifles", ""dl"AK-47\n"dl"M4\n"dl"Country Rifle\n"dl"Sniper Rifle", "Select", "Back");}
					case 1:{ShowPlayerDialog(playerid, WEAPON_DIALOG+2, DIALOG_STYLE_LIST, ""orange"Submachine Guns", ""dl"MP 5\n"dl"UZI\n"dl"TEC-9", "Select", "Back");}
					case 2:{ShowPlayerDialog(playerid, WEAPON_DIALOG+3, DIALOG_STYLE_LIST, ""orange"Shot Guns", ""dl"Pump Gun\n"dl"Spawn-Off\n"dl"Combat Shotgun", "Select", "Back");}
					case 3:{ShowPlayerDialog(playerid, WEAPON_DIALOG+4, DIALOG_STYLE_LIST, ""orange"Hand Guns", ""dl"9mm\n"dl"Silenced 9mm\n"dl"Desert Eagle", "Select", "Back");}
	   				case 4:{ShowPlayerDialog(playerid, WEAPON_DIALOG+5, DIALOG_STYLE_LIST, ""orange"Melee Weapons", ""dl"Golf Club\n"dl"Nightstick\n"dl"Knife\n"dl"Shovel\n"dl"Katana\n"dl"Chainsaw\n"dl"Double-ended Dildo\n"dl"Silver Vibrator\n"dl"Flowers", "Select", "Back");}
	   				case 5:{ShowPlayerDialog(playerid, WEAPON_DIALOG+6, DIALOG_STYLE_LIST, ""orange"Special Weapons", ""dl"Tear Gas\n"dl"Molotov Cocktail\n"dl"Flamethrower\n"dl"Spraycan\n"dl"Fire Extinguisher", "Select", "Back");}
				}
				return true;
			}
			case WEAPON_DIALOG+1 :
			{
				switch(listitem)
				{
			    	case 0:{GivePlayerWeapon(playerid,30,99999);}
			 		case 1:{GivePlayerWeapon(playerid,31,99999);}
					case 2:{GivePlayerWeapon(playerid,33,99999);}
					case 3:{GivePlayerWeapon(playerid,34,99999);}
				}
				return true;
			}
			case WEAPON_DIALOG+2 :
			{
				switch(listitem)
				{
			    	case 0:{GivePlayerWeapon(playerid,29,99999);}
					case 1:{GivePlayerWeapon(playerid,28,99999);}
					case 2:{GivePlayerWeapon(playerid,32,99999);}
				}
				return true;
			}
			case WEAPON_DIALOG+3 :
			{
	  			switch(listitem)
				{
			    	case 0:{GivePlayerWeapon(playerid,25,99999);}
            		case 1:{GivePlayerWeapon(playerid,26,99999);}
					case 2:{GivePlayerWeapon(playerid,27,99999);}
				}
			    return true;
			}
			case WEAPON_DIALOG+4 :
			{
				switch(listitem)
				{
			    	case 0:{GivePlayerWeapon(playerid,22,99999);}
					case 1:{GivePlayerWeapon(playerid,23,99999);}
			    	case 2:{GivePlayerWeapon(playerid,24,99999);}
				}
			    return true;
			}
			case WEAPON_DIALOG+5 :
			{
	  			switch(listitem)
				{
					case 0:{GivePlayerWeapon(playerid,2,1);}
            		case 1:{GivePlayerWeapon(playerid,3,1);}
					case 2:{GivePlayerWeapon(playerid,4,1);}
					case 3:{GivePlayerWeapon(playerid,6,1);}
					case 4:{GivePlayerWeapon(playerid,8,1);}
					case 5:{GivePlayerWeapon(playerid,9,1);}
					case 6:{GivePlayerWeapon(playerid,10,1);}
					case 7:{GivePlayerWeapon(playerid,13,1);}
					case 8:{GivePlayerWeapon(playerid,14,1);}
				}
			    return true;
			}
			case WEAPON_DIALOG+6 :
			{
				switch(listitem)
				{
			    	case 0:{GivePlayerWeapon(playerid,17,99999);}
					case 1:{GivePlayerWeapon(playerid,18,5);}
			    	case 2:{GivePlayerWeapon(playerid,37,25);}
					case 3:{GivePlayerWeapon(playerid,41,25);}
			    	case 4:{GivePlayerWeapon(playerid,42,25);}
				}
				return true;
			}
			case VMENU_DIALOG :
			{
   				switch(listitem)
			    {
			        case 0:
			        {
			            if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][PV_Vehicle]) return LangMSG(playerid, -1, ""er"You are alread in your car!", ""er"Du bist schon in deinem Fahrzeug!");

						if(PlayerInfo[playerid][PV_Vehicle] != 1)
						{
						    DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
							DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
							PlayerInfo[playerid][PV_Vehicle] = -1;
						}
						if(PlayerInfo[playerid][Vehicle] != -1)
						{
							DestroyVehicle(PlayerInfo[playerid][Vehicle]);
							PlayerInfo[playerid][Vehicle] = -1;
						}

						new Float:POS[4],
						    vlabel[128];

                        format(vlabel, sizeof(vlabel), ""blue"%s´s \n"white"private vehicle", __GetName(playerid));

						GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
						GetPlayerFacingAngle(playerid, POS[3]);

						PlayerInfo[playerid][PV_Vehicle] = CreateVehicle(PlayerInfoVeh[playerid][Model], POS[0], POS[1], POS[2], POS[3], 0, 0, -1);
						PlayerInfo[playerid][PV_3DLabel] = CreateDynamic3DTextLabel(vlabel, GREY, 0.0, 0.0, 0.0, 30.0, INVALID_PLAYER_ID, PlayerInfo[playerid][PV_Vehicle], 0, -1, -1, -1, 30.0);

						SetVehicleVirtualWorld(PlayerInfo[playerid][PV_Vehicle], GetPlayerVirtualWorld(playerid));
						LinkVehicleToInterior(PlayerInfo[playerid][PV_Vehicle], GetPlayerInterior(playerid));
						SetVehicleNumberPlate(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Plate]);
						SetVehicleToRespawn(PlayerInfo[playerid][PV_Vehicle]);

						PutPlayerInVehicle(playerid, PlayerInfo[playerid][PV_Vehicle], 0);
						
						SendInfo(playerid, "~h~~y~Private Vehicle Spawned", 2500);
					}
					case 1:
					{
						ShowDialog(playerid, NEON_DIALOG);
					}
					case 2:
					{
						ShowDialog(playerid, PLATE_DIALOG);
					}
					case 3:
					{
						MySQL_DeletePlayerVehiclePerm(playerid);
					}
				}
				return true;
			}
			case CARBUY_DIALOG :
			{
			    new string[2048];
   				switch(listitem)
		    	{
		        	case 0:
		        	{
						strcat(string, ""dl"Blade "green"$595,000\n"dl"Broadway "green"$390,000\n"dl"Remington "green"$500,000\n"dl"Savanna "green"$530,000\n"dl"Slamvan "green"$390,000\n"dl"Tahoma "green"$300,000\n"dl"Tornado "green"$399,000\n"dl"Voodoo "green"$500,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+1, DIALOG_STYLE_LIST, ""orange"Lowriders", string, "Select", "Back");
					}
		        	case 1:
					{
					    strcat(string, ""dl"Alpha "green"$305,000\n"dl"Banshee "green"$600,000\n"dl"Buffalo "green"$450,000\n"dl"Bullet "green"$960,000\n"dl"Cheetah "green"$498,000\n"dl"Club "green"$300,000\n"dl"Euros "green"$310,000\n"dl"Infernus "green"$1,350,000\n");
						strcat(string, ""dl"Jester "green"$1,400,000\n"dl"Phoenix "green"$1,000,000\n"dl"Sabre "green"$500,000\n"dl"Super GT "green"$600,000\n"dl"Turismo "green"$999,000\n"dl"Uranus "green"$250,000\n"dl"ZR-350 "green"$450,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+2, DIALOG_STYLE_LIST, ""orange"Sport Vehicles", string, "Select", "Back");
					}
					case 2:
					{
					    strcat(string, ""dl"Bravura "green"$200,000\n"dl"Sentinel "green"$350,000\n"dl"Manana "green"$200,000\n"dl"Esperanto "green"$200,000\n"dl"Washington "green"$350,000\n"dl"Premier "green"$400,000\n"dl"Admiral "green"$300,000\n"dl"Glendale "green"$300,000\n"dl"Oceanic "green"$300,000");
					    strcat(string, "\n"dl"Hermes "green"$300,000\n"dl"Greenwood "green"$350,000\n"dl"Elegant "green"$400,000\n"dl"Fortune "green"$500,000\n"dl"Clover "green"$400,000\n"dl"Tampa "green"$250,000\n"dl"Sunrise "green"$450,000\n"dl"Sultan "green"$550,000\n"dl"Merit "green"$400,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+3, DIALOG_STYLE_LIST, ""orange"Saloons", string, "Select", "Back");
					}
					case 3:
					{
					    strcat(string, ""dl"BF-400 "green"$500,000\n"dl"Wayfarer "green"$250,000\n"dl"PCJ-600 "green"$340,000\n"dl"Faggio "green"$100,000\n"dl"Freeway "green"$500,000\n"dl"Sanchez "green"$400,000\n"dl"FCR-900 "green"$300,000\n"dl"NRG-500 "green"$780,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+4, DIALOG_STYLE_LIST, ""orange"Bikes", string, "Select", "Back");
					}
					case 4:
					{
					    strcat(string, ""dl"Stallion "green"$200,000\n"dl"Comet "green"$400,000\n"dl"Feltzer "green"$700,000\n"dl"Windsor "green"$500,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+5, DIALOG_STYLE_LIST, ""orange"Convertibles", string, "Select", "Back");
					}
					case 5:
					{
					    strcat(string, ""dl"Landstalker "green"$300,000\n"dl"BF Injection "green"$650,000\n"dl"Monster "green"$700,000\n"dl"Patriot "green"$455,000\n"dl"Rancher "green"$300,000\n"dl"Sandking "green"$500,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+6, DIALOG_STYLE_LIST, ""orange"Off Road", string, "Select", "Back");
					}
				}
			    return true;
			}
			case CARBUY_DIALOG+1 :
			{
   				switch(listitem)
		    	{
			        case 0: PlayerBuyVehicle(playerid, 595000, 536);
			        case 1: PlayerBuyVehicle(playerid, 390000, 575);
			        case 2: PlayerBuyVehicle(playerid, 500000, 534);
			        case 3: PlayerBuyVehicle(playerid, 350000, 567);
			        case 4: PlayerBuyVehicle(playerid, 390000, 535);
			        case 5: PlayerBuyVehicle(playerid, 300000, 566);
			        case 6: PlayerBuyVehicle(playerid, 399000, 576);
			        case 7: PlayerBuyVehicle(playerid, 500000, 412);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
				}
			    return true;
			}
			case CARBUY_DIALOG+2 :
			{
   				switch(listitem)
		    	{
			        case 0: PlayerBuyVehicle(playerid, 305000, 602);
			        case 1: PlayerBuyVehicle(playerid, 600000, 429);
			        case 2: PlayerBuyVehicle(playerid, 450000, 402);
			        case 3: PlayerBuyVehicle(playerid, 960000, 541);
			        case 4: PlayerBuyVehicle(playerid, 498000, 415);
			        case 5: PlayerBuyVehicle(playerid, 300000, 589);
			        case 6: PlayerBuyVehicle(playerid, 310000, 587);
			        case 7: PlayerBuyVehicle(playerid, 1350000, 411);
					case 8: PlayerBuyVehicle(playerid, 1400000, 559);
			        case 9: PlayerBuyVehicle(playerid, 1000000, 603);
			        case 10: PlayerBuyVehicle(playerid, 500000, 475);
			        case 11: PlayerBuyVehicle(playerid, 600000, 506);
			        case 12: PlayerBuyVehicle(playerid, 999000, 451);
			        case 13: PlayerBuyVehicle(playerid, 250000, 558);
			        case 14: PlayerBuyVehicle(playerid, 450000, 477);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
				}
			    return true;
			}//401, 405, 410, 419, 421, 426, 445, 466, 467, 474, 492, 507, 526, 542, 549, 550, 560, 551
			case CARBUY_DIALOG+3 :
			{
   				switch(listitem)
		    	{
			        case 0: PlayerBuyVehicle(playerid, 200000, 401);
			        case 1: PlayerBuyVehicle(playerid, 350000, 405);
			        case 2: PlayerBuyVehicle(playerid, 200000, 410);
			        case 3: PlayerBuyVehicle(playerid, 200000, 419);
			        case 4: PlayerBuyVehicle(playerid, 350000, 421);
			        case 5: PlayerBuyVehicle(playerid, 400000, 426);
			        case 6: PlayerBuyVehicle(playerid, 300000, 445);
			        case 7: PlayerBuyVehicle(playerid, 300000, 466);
					case 8: PlayerBuyVehicle(playerid, 300000, 467);
			        case 9: PlayerBuyVehicle(playerid, 300000, 474);
			        case 10: PlayerBuyVehicle(playerid, 350000, 492);
			        case 11: PlayerBuyVehicle(playerid, 400000, 507);
			        case 12: PlayerBuyVehicle(playerid, 500000, 526);
			        case 13: PlayerBuyVehicle(playerid, 400000, 542);
			        case 14: PlayerBuyVehicle(playerid, 250000, 549);
			        case 15: PlayerBuyVehicle(playerid, 450000, 550);
			        case 16: PlayerBuyVehicle(playerid, 550000, 560);
			        case 17: PlayerBuyVehicle(playerid, 400000, 551);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
				}
			    return true;
			}
			case CARBUY_DIALOG+4 :
			{
   				switch(listitem) // 581, 586, 461, 462, 463, 468, 521, 522
		    	{
			        case 0: PlayerBuyVehicle(playerid, 500000, 581);
			        case 1: PlayerBuyVehicle(playerid, 250000, 586);
			        case 2: PlayerBuyVehicle(playerid, 340000, 461);
			        case 3: PlayerBuyVehicle(playerid, 100000, 462);
			        case 4: PlayerBuyVehicle(playerid, 500000, 463);
			        case 5: PlayerBuyVehicle(playerid, 400000, 468);
			        case 6: PlayerBuyVehicle(playerid, 300000, 521);
			        case 7: PlayerBuyVehicle(playerid, 780000, 522);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
				}
			    return true;
			}
			case CARBUY_DIALOG+5 :
			{
   				switch(listitem) // 439, 480, 533, 555
		    	{
			        case 0: PlayerBuyVehicle(playerid, 200000, 439);
			        case 1: PlayerBuyVehicle(playerid, 400000, 480);
			        case 2: PlayerBuyVehicle(playerid, 700000, 533);
			        case 3: PlayerBuyVehicle(playerid, 500000, 555);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
				}
			    return true;
			}
			case CARBUY_DIALOG+6 :
			{
   				switch(listitem) //400, 424, 444, 470, 489, 495
		    	{
			        case 0: PlayerBuyVehicle(playerid, 300000, 400);
			        case 1: PlayerBuyVehicle(playerid, 650000, 424);
			        case 2: PlayerBuyVehicle(playerid, 700000, 444);
			        case 3: PlayerBuyVehicle(playerid, 455000, 470);
			        case 4: PlayerBuyVehicle(playerid, 300000, 489);
			        case 5: PlayerBuyVehicle(playerid, 500000, 495);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
				}
			    return true;
			}
			case NEON_DIALOG :
			{
	            if(PlayerInfoVeh[playerid][Neon1] != -1)
				{
					DestroyDynamicObject(PlayerInfoVeh[playerid][Neon1]);
					PlayerInfoVeh[playerid][Neon1] = -1;
				}
	            if(PlayerInfoVeh[playerid][Neon2] != -1)
				{
					DestroyDynamicObject(PlayerInfoVeh[playerid][Neon2]);
					PlayerInfoVeh[playerid][Neon2] = -1;
				}
				if(PlayerInfo[playerid][PV_Vehicle] != 1)
				{
				    DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
					DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
					PlayerInfo[playerid][PV_Vehicle] = -1;
				}
				
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}

				new Float:POS[4],
				    vlabel[128];

                format(vlabel, sizeof(vlabel), ""blue"%s´s \n"white"private vehicle", __GetName(playerid));

				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				GetPlayerFacingAngle(playerid, POS[3]);

				PlayerInfo[playerid][PV_Vehicle] = CreateVehicle(PlayerInfoVeh[playerid][Model], POS[0], POS[1], POS[2], POS[3], 0, 0, -1);
				PlayerInfo[playerid][PV_3DLabel] = CreateDynamic3DTextLabel(vlabel, GREY, 0.0, 0.0, 0.0, 30.0, INVALID_PLAYER_ID, PlayerInfo[playerid][PV_Vehicle], 0, -1, -1, -1, 30.0);

				SetVehicleVirtualWorld(PlayerInfo[playerid][PV_Vehicle], GetPlayerVirtualWorld(playerid));
				LinkVehicleToInterior(PlayerInfo[playerid][PV_Vehicle], GetPlayerInterior(playerid));
				SetVehicleNumberPlate(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Plate]);
				SetVehicleToRespawn(PlayerInfo[playerid][PV_Vehicle]);

				PutPlayerInVehicle(playerid, PlayerInfo[playerid][PV_Vehicle], 0);

			    //Red\nGreen\nBlue\nYellow\nWhite\Remove Neon
			    switch(listitem)
			    {
			        case 0:
			        {
						PlayerInfoVeh[playerid][Neon1] = CreateDynamicObject(18647, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        PlayerInfoVeh[playerid][Neon2] = CreateDynamicObject(18647, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon1], PlayerInfo[playerid][PV_Vehicle], -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon2], PlayerInfo[playerid][PV_Vehicle],  0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        SendInfo(playerid, "~h~~y~Neon attached", 2500);
	     			}
				    case 1:
				    {
				        PlayerInfoVeh[playerid][Neon1] = CreateDynamicObject(18649, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        PlayerInfoVeh[playerid][Neon2] = CreateDynamicObject(18649, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon1], PlayerInfo[playerid][PV_Vehicle], -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon2], PlayerInfo[playerid][PV_Vehicle],  0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        SendInfo(playerid, "~h~~y~Neon attached", 2500);
					}
	    			case 2:
				    {
				        PlayerInfoVeh[playerid][Neon1] = CreateDynamicObject(18648, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        PlayerInfoVeh[playerid][Neon2] = CreateDynamicObject(18648, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon1], PlayerInfo[playerid][PV_Vehicle], -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon2], PlayerInfo[playerid][PV_Vehicle],  0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        SendInfo(playerid, "~h~~y~Neon attached", 2500);
				    }
				    case 3:
				    {
	           		    PlayerInfoVeh[playerid][Neon1] = CreateDynamicObject(18650, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        PlayerInfoVeh[playerid][Neon2] = CreateDynamicObject(18650, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon1], PlayerInfo[playerid][PV_Vehicle], -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon2], PlayerInfo[playerid][PV_Vehicle],  0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        SendInfo(playerid, "~h~~y~Neon attached", 2500);
					}
	    			case 4:
				    {
	           		    PlayerInfoVeh[playerid][Neon1] = CreateDynamicObject(18652, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        PlayerInfoVeh[playerid][Neon2] = CreateDynamicObject(18652, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1, -1, -1);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon1], PlayerInfo[playerid][PV_Vehicle], -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        AttachDynamicObjectToVehicle(PlayerInfoVeh[playerid][Neon2], PlayerInfo[playerid][PV_Vehicle],  0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				        SendInfo(playerid, "~h~~y~Neon attached", 2500);
	       			}
				    case 5:
				    {
						SendInfo(playerid, "~h~~y~Neon removed", 2500);
				   	}
				}
			    return true;
			}
			case VEHICLEPLATE_DIALOG :
			{
   				if(strlen(inputtext) < 2 || strlen(inputtext) > 12 || isnull(inputtext))
		    	{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
			 		ShowDialog(playerid, VEHICLEPLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, " ", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
			 		ShowDialog(playerid, VEHICLEPLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, "|", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
			 		ShowDialog(playerid, VEHICLEPLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, "'", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
			 		ShowDialog(playerid, VEHICLEPLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "@", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
			 		ShowDialog(playerid, VEHICLEPLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "`", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
			 		ShowDialog(playerid, VEHICLEPLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "´", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
			 		ShowDialog(playerid, VEHICLEPLATE_DIALOG);
					return 1;
				}
				if(sscanf(inputtext, "s[13]", PlayerInfoVeh[playerid][Plate]))
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
			 		ShowDialog(playerid, VEHICLEPLATE_DIALOG);
					return 1;
				}
				mysql_real_escape_string(PlayerInfoVeh[playerid][Plate], PlayerInfoVeh[playerid][Plate], g_SQL_handle, 13);
				CreateFinalCar(playerid);
				return true;
			}
			case PLATE_DIALOG :
			{
   				if(strlen(inputtext) < 2 || strlen(inputtext) > 12 || isnull(inputtext))
		    	{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
				 	ShowDialog(playerid, PLATE_DIALOG);
				 	return 1;
				}
    			if(strfind(inputtext, "|", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
				 	ShowDialog(playerid, PLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, " ", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
				 	ShowDialog(playerid, PLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, "'", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
				 	ShowDialog(playerid, PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "@", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
				 	ShowDialog(playerid, PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "`", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
				 	ShowDialog(playerid, PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "´", false) != -1)
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
				 	ShowDialog(playerid, PLATE_DIALOG);
					return 1;
				}
				if(sscanf(inputtext, "s[13]", PlayerInfoVeh[playerid][Plate]))
				{
					LangMSG(playerid, RED, "Number plate length: 2 - 12 characters", "Nummernschild Länge: 2 - 12 Zeichen");
				 	ShowDialog(playerid, PLATE_DIALOG);
				 	return 1;
				}

                mysql_real_escape_string(PlayerInfoVeh[playerid][Plate], PlayerInfoVeh[playerid][Plate], g_SQL_handle, 13);

				if(PlayerInfo[playerid][PV_Vehicle] != 1)
				{
				    DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
					DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
					PlayerInfo[playerid][PV_Vehicle] = -1;
				}
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}

				new Float:POS[4],
				    vlabel[128];

                format(vlabel, sizeof(vlabel), ""blue"%s´s \n"white"private vehicle", __GetName(playerid));

				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				GetPlayerFacingAngle(playerid, POS[3]);

				PlayerInfo[playerid][PV_Vehicle] = CreateVehicle(PlayerInfoVeh[playerid][Model], POS[0], POS[1], POS[2], POS[3], 0, 0, -1);
				PlayerInfo[playerid][PV_3DLabel] = CreateDynamic3DTextLabel(vlabel, GREY, 0.0, 0.0, 0.0, 30.0, INVALID_PLAYER_ID, PlayerInfo[playerid][PV_Vehicle], 0, -1, -1, -1, 30.0);

				SetVehicleVirtualWorld(PlayerInfo[playerid][PV_Vehicle], GetPlayerVirtualWorld(playerid));
				LinkVehicleToInterior(PlayerInfo[playerid][PV_Vehicle], GetPlayerInterior(playerid));
				SetVehicleNumberPlate(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Plate]);
				SetVehicleToRespawn(PlayerInfo[playerid][PV_Vehicle]);

				PutPlayerInVehicle(playerid, PlayerInfo[playerid][PV_Vehicle], 0);
				
				SendInfo(playerid, "~h~~y~Plate changed!", 2500);
			    return true;
			}
			case BGVOTING_DIALOG :
			{
   				if(CurrentBGMap == BG_VOTING)
				{
	 				switch(listitem)
					{
						case 0:
						{
						   	new string[100], gstring[100];
						   	format(string, sizeof(string), "%s voted for map 'Forest'", __GetName(playerid));
						   	format(gstring, sizeof(gstring), "%s hat für die Map 'Forest' gevotet", __GetName(playerid));
							BGMSG(string, gstring);
							BGMapVotes[0]++;
						}
						case 1:
						{
						   	new string[100], gstring[100];
						   	format(string, sizeof(string), "%s voted for map 'Quarters'", __GetName(playerid));
						   	format(gstring, sizeof(gstring), "%s hat für die Map 'Quarters' gevotet", __GetName(playerid));
							BGMSG(string, gstring);
						   	BGMapVotes[1]++;
						}
						case 2:
						{
						   	new string[100], gstring[100];
						   	format(string, sizeof(string), "%s voted for map 'Rust'", __GetName(playerid));
						   	format(gstring, sizeof(gstring), "%s hat für die Map 'Rust' gevotet", __GetName(playerid));
							BGMSG(string, gstring);
						   	BGMapVotes[2]++;
						}
						case 3:
						{
						   	new string[100], gstring[100];
						   	format(string, sizeof(string), "%s voted for map 'Italy'", __GetName(playerid));
						   	format(gstring, sizeof(gstring), "%s hat für die Map 'Italy' gevotet", __GetName(playerid));
							BGMSG(string, gstring);
						   	BGMapVotes[3]++;
						}
						case 4:
						{
						   	new string[100], gstring[100];
						   	format(string, sizeof(string), "%s voted for map 'Medieval'", __GetName(playerid));
						   	format(gstring, sizeof(gstring), "%s hat für die Map 'Medieval' gevotet", __GetName(playerid));
							BGMSG(string, gstring);
						   	BGMapVotes[4]++;
						}
					}
				}
				else
				{
				    LangMSG(playerid, RED, ""derby_sign" No voting time at the momment!", ""derby_sign" Keine Votingzeit im Moment!");
				}
			    return true;
			}
		}
	}
	else if(!response)
	{
		PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0); //1055

 		switch(dialogid)
 		{
 		    case TELE_DIALOG + 1, TELE_DIALOG + 2, TELE_DIALOG +3, TELE_DIALOG + 4, TELE_DIALOG + 5, TELE_DIALOG + 6 :
 		    {
 		        ShowDialog(playerid, TELE_DIALOG);
 		        return true;
 		    }
			case DIALOG_RACE_RACETYPE :
			{
			    BuildRace = 0;
			    return true;
			}
    	    case DIALOG_RACE_RACEVW, DIALOG_RACE_RACEVWERR :
		    {
		        ShowDialog(playerid, DIALOG_RACE_RACETYPE);
		        return true;
		    }
	 	    case DIALOG_RACE_RACEVEH, DIALOG_RACE_RACEVEHERR :
		    {
		        ShowDialog(playerid, DIALOG_RACE_RACEVW);
		        return true;
		    }
		    case DIALOG_RACE_RACESTARTPOS :
			{
			    ShowDialog(playerid, DIALOG_RACE_RACEVEH);
			    return true;
			}
		    case DIALOG_RACE_CHECKPOINTS :
			{
			    ShowDialog(playerid, DIALOG_RACE_RACESTARTPOS);
			    return true;
			}
		    case DIALOG_RACE_RACERDY :
			{
			    ShowDialog(playerid, DIALOG_RACE_RACERDY);
			    return true;
			}
 		    case HELP_DIALOG :
 		    {
 		        cmd_cmds(playerid, "");
 		        return true;
 		    }
 		    case DERBY_VOTING_DIALOG :
 		    {
 		        ShowDialog(playerid, DERBY_VOTING_DIALOG);
 		        return true;
 		    }
 		    case LANG_DIALOG :
 		    {
			    PlayerInfo[playerid][Lang] = 1;
		        registerDIALOG(playerid);
	        	SendClientMessage(playerid, GREEN, ""blue"Deine Sprache ist Deutsch.");
	        	return true;
 		    }
 		    case LOGIN_DIALOG :
 		    {
 		        loginDIALOG(playerid);
 		        return true;
 		    }
 		    case REGISTER_DIALOG :
 		    {
 		        registerDIALOG(playerid);
 		        return true;
 		    }
 		    case STREAM_DIALOG :
 		    {
 		        StopAudioStreamForPlayer(playerid);
 		        return true;
			}
			case STREAM_DIALOG+1 : {ShowDialog(playerid, STREAM_DIALOG); return true;}
			case STREAM_DIALOG+2 : {ShowDialog(playerid, STREAM_DIALOG); return true;}
			case STREAM_DIALOG+3 : {ShowDialog(playerid, STREAM_DIALOG); return true;}
			case STREAM_DIALOG+4 : {ShowDialog(playerid, STREAM_DIALOG); return true;}
			case STREAM_DIALOG+5 : {ShowDialog(playerid, STREAM_DIALOG); return true;}
			case STREAM_DIALOG+6 : {ShowDialog(playerid, STREAM_DIALOG); return true;}
			case STREAM_DIALOG+7 : {ShowDialog(playerid, STREAM_DIALOG); return true;}
			case STREAM_DIALOG+8 : {ShowDialog(playerid, STREAM_DIALOG); return true;}
			case VEHICLE_DIALOG+1: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+2: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+3: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+4: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+5: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+6: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+7: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+8: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+9: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+10: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+11: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+12: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+13: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+14: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case VEHICLE_DIALOG+15: {ShowDialog(playerid, VEHICLE_DIALOG);return true;}
			case WEAPON_DIALOG+1: {ShowDialog(playerid, WEAPON_DIALOG);return true;}
			case WEAPON_DIALOG+2: {ShowDialog(playerid, WEAPON_DIALOG);return true;}
			case WEAPON_DIALOG+3: {ShowDialog(playerid, WEAPON_DIALOG);return true;}
			case WEAPON_DIALOG+4: {ShowDialog(playerid, WEAPON_DIALOG);return true;}
			case WEAPON_DIALOG+5: {ShowDialog(playerid, WEAPON_DIALOG);return true;}
			case WEAPON_DIALOG+6: {ShowDialog(playerid, WEAPON_DIALOG);return true;}
			case VEHICLEPLATE_DIALOG :
			{
			    if(PreviewTmpVeh[playerid] != -1)
			    {
		    		DestroyVehicle(PreviewTmpVeh[playerid]);
		    		PreviewTmpVeh[playerid] = -1;
				}
   				PlayerInfoVeh[playerid][Model] = -1;
				PlayerInfoVeh[playerid][Price] = -1;
				ShowDialog(playerid, CARBUY_DIALOG);
				return true;
			}
			case CARBUY_DIALOG :
			{
   				SetCameraBehindPlayer(playerid);
		    	SetPlayerVirtualWorld(playerid, 0);
		    	TogglePlayerControllable(playerid, true);
		    	return true;
			}
			case CARBUY_DIALOG+1 : {ShowDialog(playerid, CARBUY_DIALOG); return true;}
			case CARBUY_DIALOG+2 : {ShowDialog(playerid, CARBUY_DIALOG); return true;}
			case CARBUY_DIALOG+3 : {ShowDialog(playerid, CARBUY_DIALOG); return true;}
			case CARBUY_DIALOG+4 : {ShowDialog(playerid, CARBUY_DIALOG); return true;}
			case CARBUY_DIALOG+5 : {ShowDialog(playerid, CARBUY_DIALOG); return true;}
			case CARBUY_DIALOG+6 : {ShowDialog(playerid, CARBUY_DIALOG); return true;}
			case BGVOTING_DIALOG :
			{
		 		ShowDialog(playerid, BGVOTING_DIALOG);
		 		return true;
			}
		}
	}
	return 0;
}

function:CancelGangCreation(playerid)
{
	PlayerInfo[playerid][IsInGang] = 0;
	PlayerInfo[playerid][GangID] = 0;
 	strmid(PlayerInfo[playerid][GangName], "---", 0, 21, 21);
 	strmid(PlayerInfo[playerid][GangTag], "---", 0, 5, 5);
 	return 1;
}

function:OnHouseLoadEx(index)
{
	new
		line[150],
		resultline[400];

    mysql_store_result();

	while(mysql_fetch_row_format(resultline))
	{
		sscanf(resultline, "p<|>is[25]fffiiiiii",
			HouseInfo[index][iID],
			HouseInfo[index][Owner],
			HouseInfo[index][E_x],
			HouseInfo[index][E_y],
			HouseInfo[index][E_z],
			HouseInfo[index][interior],
			HouseInfo[index][price],
			HouseInfo[index][E_score],
			HouseInfo[index][sold],
			HouseInfo[index][locked],
			HouseInfo[index][date]);

		format(line, sizeof(line), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%i\nScore: %i\nInterior: %s", HouseInfo[index][iID], HouseInfo[index][price], HouseInfo[index][E_score], HouseIntTypes[HouseInfo[index][interior]][intname]);

		HouseInfo[index][label] = CreateDynamic3DTextLabel(line, (HouseInfo[index][sold]) ? (0xFF0000FF) : (0x00FF00FF), HouseInfo[index][E_x], HouseInfo[index][E_y], floatadd(HouseInfo[index][E_z], 0.3), 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 30.0);
		HouseInfo[index][pickid] = CreateDynamicPickup((HouseInfo[index][sold]) ? (1272) : (1273), 1, HouseInfo[index][E_x], HouseInfo[index][E_y], HouseInfo[index][E_z], -1, -1, -1, 30.0);
		HouseInfo[index][iconid] = CreateDynamicMapIcon(HouseInfo[index][E_x], HouseInfo[index][E_y], HouseInfo[index][E_z],(HouseInfo[index][sold]) ? (32) : (31), 1, -1, -1, -1, 100.0);
		index++;
	}
	mysql_free_result();
	return 1;
}

function:OnHouseLoad()
{
	new
		line[150],
		resultline[400];

    mysql_store_result();

	while(mysql_fetch_row_format(resultline))
	{
		sscanf(resultline, "p<|>is[25]fffiiiiii",
			HouseInfo[houseid][iID],
			HouseInfo[houseid][Owner],
			HouseInfo[houseid][E_x],
			HouseInfo[houseid][E_y],
			HouseInfo[houseid][E_z],
			HouseInfo[houseid][interior],
			HouseInfo[houseid][price],
			HouseInfo[houseid][E_score],
			HouseInfo[houseid][sold],
			HouseInfo[houseid][locked],
			HouseInfo[houseid][date]);

		if(!HouseInfo[houseid][sold])
		{
		    format(line, sizeof(line), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%i\nScore: %i\nInterior: %s", HouseInfo[houseid][iID], HouseInfo[houseid][price], HouseInfo[houseid][E_score], HouseIntTypes[HouseInfo[houseid][interior]][intname]);
		}
		else
		{
		    format(line, sizeof(line), ""house_mark"\nOwner: %s\nID: %i\nInterior: %s", HouseInfo[houseid][Owner], HouseInfo[houseid][iID], HouseIntTypes[HouseInfo[houseid][interior]][intname]);
		}

		HouseInfo[houseid][label] = CreateDynamic3DTextLabel(line, (HouseInfo[houseid][sold]) ? (0xFF0000FF) : (0x00FF00FF), HouseInfo[houseid][E_x], HouseInfo[houseid][E_y], floatadd(HouseInfo[houseid][E_z], 0.3), 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 30.0);
		HouseInfo[houseid][pickid] = CreateDynamicPickup((HouseInfo[houseid][sold]) ? (1272) : (1273), 1, HouseInfo[houseid][E_x], HouseInfo[houseid][E_y], HouseInfo[houseid][E_z], -1, -1, -1, 30.0);
		HouseInfo[houseid][iconid] = CreateDynamicMapIcon(HouseInfo[houseid][E_x], HouseInfo[houseid][E_y], HouseInfo[houseid][E_z], (HouseInfo[houseid][sold]) ? (32) : (31), 1, -1, -1, -1, 100.0);
		houseid++;
	}
	mysql_free_result();
	
	printf(">> Loaded %i House(s)", houseid);
	return 1;
}

function:OnPropLoadEx(pindex)
{
	new
		line[150],
		resultline[300];
		
    mysql_store_result();

	while(mysql_fetch_row_format(resultline))
	{
		sscanf(resultline, "p<|>is[25]fffiiiii",
			PropInfo[pindex][iID],
			PropInfo[pindex][Owner],
			PropInfo[pindex][E_x],
			PropInfo[pindex][E_y],
			PropInfo[pindex][E_z],
			PropInfo[pindex][price],
			PropInfo[pindex][earnings],
			PropInfo[pindex][E_score],
			PropInfo[pindex][sold],
			PropInfo[pindex][date]);

		format(line, sizeof(line), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%i\nScore: %i\nEarnings: $%i", PropInfo[pindex][iID], PropInfo[pindex][price], PropInfo[pindex][E_score], PropInfo[pindex][earnings]);

		PropInfo[pindex][label] = CreateDynamic3DTextLabel(line, WHITE, PropInfo[pindex][E_x], PropInfo[pindex][E_y], floatadd(PropInfo[pindex][E_z], 0.3), 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 30.0);
		PropInfo[pindex][pickid] = CreateDynamicPickup(1274, 1, PropInfo[pindex][E_x], PropInfo[pindex][E_y], PropInfo[pindex][E_z], -1, -1, -1, 30.0);
		PropInfo[pindex][iconid] = CreateDynamicMapIcon(PropInfo[pindex][E_x], PropInfo[pindex][E_y], PropInfo[pindex][E_z], 52, 1, -1, -1, -1, 100.0);
		pindex++;
	}
	mysql_free_result();
	return 1;
}

function:OnPropLoad()
{
	new
		line[150],
		resultline[300];

	mysql_store_result();
	
	while(mysql_fetch_row_format(resultline))
	{
		sscanf(resultline, "p<|>is[25]fffiiiii",
			PropInfo[propid][iID],
			PropInfo[propid][Owner],
			PropInfo[propid][E_x],
			PropInfo[propid][E_y],
			PropInfo[propid][E_z],
			PropInfo[propid][price],
			PropInfo[propid][earnings],
			PropInfo[propid][E_score],
			PropInfo[propid][sold],
			PropInfo[propid][date]);

		if(!PropInfo[propid][sold])
		{
			format(line, sizeof(line), ""business_mark"\nOwner: ---\n"white"ID: %i\nPrice: $%i\nScore: %i\nEarnings: $%i", PropInfo[propid][iID], PropInfo[propid][price], PropInfo[propid][E_score], PropInfo[propid][earnings]);
		}
        else
		{
			format(line, sizeof(line), ""business_mark"\nOwner: %s\n"white"ID: %i\nEarnings: $%i", PropInfo[propid][Owner], PropInfo[propid][iID], PropInfo[propid][earnings]);
		}
		PropInfo[propid][label] = CreateDynamic3DTextLabel(line, WHITE, PropInfo[propid][E_x], PropInfo[propid][E_y], floatadd(PropInfo[propid][E_z], 0.3), 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 30.0);
		PropInfo[propid][pickid] = CreateDynamicPickup(1274, 1, PropInfo[propid][E_x], PropInfo[propid][E_y], PropInfo[propid][E_z], -1, -1, -1, 30.0);
		PropInfo[propid][iconid] = CreateDynamicMapIcon(PropInfo[propid][E_x], PropInfo[propid][E_y], PropInfo[propid][E_z], (PropInfo[propid][sold]) ? (36) : (52), 1, -1, -1, -1, 100.0);
		propid++;
	}
	mysql_free_result();
	
	printf(">> Loaded %i business(s)", propid);
	return 1;
}

function:LoadHouses()
{
	mysql_function_query(g_SQL_handle, "SELECT * FROM `"#TABLE_HOUSE"`;", false, "OnHouseLoad", "");
	return 1;
}

function:LoadProps()
{
	mysql_function_query(g_SQL_handle, "SELECT * FROM `"#TABLE_PROP"`;", false, "OnPropLoad", "");
	return 1;
}

function:TimePulse()
{
	if(ServerTime[1] < 60)
	{
        if(ServerTime[0] > 20 || ServerTime[0] < 5)
        {
            ServerTime[1] += 3;
        }
        else ServerTime[1]++;
	}
	else
	{
	    if(ServerTime[0] == 23)
	    {
	        ServerTime[0] = 0;
	    }
	    else
		{
	    	ServerTime[0]++;
		}
		ServerTime[1] = 0;
	}

    SetWorldTime(ServerTime[0]);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i))
	    {
	        SetPlayerTime(i, ServerTime[0], ServerTime[1]);
	    }
	}

	return 1;
}

JumpVeh(vid, Float:dis = 0.3)
{
	new Float:POS[3];
	GetVehicleVelocity(vid, POS[0], POS[1], POS[2]);
	SetVehicleVelocity(vid, POS[0], POS[1], floatadd(POS[2], dis));
	SetVehicleHealth(vid, 99999.0);
}

IsPlayerOnDesktop(playerid, afktimems = 5000)
{
	if((PlayerInfo[playerid][tickPlayerUpdate] + afktimems) < (GetTickCount() + 3600000)) return 1;
	return 0;
}

function:BGVoting()
{
	new iTotalVotes = BGMapVotes[0] + BGMapVotes[1] + BGMapVotes[2] + BGMapVotes[3] + BGMapVotes[4];

	if(iTotalVotes == 0)
	{
	    BGMSG("There were no votes! New Voting starting", "Keine Votes! Neues Voting startet!");
	    ExecBGVotingTimer();
		ClearBGVotes();
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == gBG_VOTING)
   			{
				ShowDialog(i, BGVOTING_DIALOG);
			}
		}
		return 1;
	}

	new highestmapvotes = -1;
	new draw = 0;

	for(new i = 0; i < sizeof(BGMapVotes); i++)
	{
 		if(BGMapVotes[i] > highestmapvotes && draw == 0)
		{
  			highestmapvotes = BGMapVotes[i];
		}
		else if(BGMapVotes[i] > highestmapvotes && draw != 0)
		{
		    highestmapvotes = BGMapVotes[i];
		    draw = 0;
		}
		else if(BGMapVotes[i] == highestmapvotes)
		{
			draw++;
		}
	}

	if(draw >= 1)
	{
	    BGMSG("Voting was not clear! New Voting starting!", "Map Votes waren unentschieden! Neues Voting startet!");
	    ExecBGVotingTimer();
		ClearBGVotes();
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == gBG_VOTING)
   			{
				ShowDialog(i, BGVOTING_DIALOG);
			}
		}
		return 1;
	}

	if(highestmapvotes == BGMapVotes[0])
	{
	    BGMSG("Map 'Forest' won! Let´s start!", "Map 'Forest' hat gewonnen! Lasst uns starten!");
		CurrentBGMap = BG_MAP1;
		ClearBGVotes();
		ExecBGTimer();

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == gBG_VOTING)
		    {
		        SetCameraBehindPlayer(i);
		        TogglePlayerControllable(i, true);
		        SetPlayerVirtualWorld(i, BG_WORLD);
		        ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

		    	if(BGTeam1Players > BGTeam2Players)
				{
					RandomBGSpawn(i, BG_MAP1, BG_TEAM2);
				    BGTeam2Players++;
				    SetPlayerBGTeam2(i);
				    gTeam[i] = gBG_TEAM2;
				}
				else if(BGTeam1Players < BGTeam2Players)
				{
				  	RandomBGSpawn(i, BG_MAP1, BG_TEAM1);
				   	BGTeam1Players++;
				   	SetPlayerBGTeam1(i);
				   	gTeam[i] = gBG_TEAM1;
				}
				else
				{
			        switch(random(2))
			        {
			            case 0:
			            {
			                SetPlayerBGTeam1(i);
							RandomBGSpawn(i, BG_MAP1, BG_TEAM1);
							BGTeam1Players++;
							gTeam[i] = gBG_TEAM1;
						}
						case 1:
						{
						    SetPlayerBGTeam2(i);
							RandomBGSpawn(i, BG_MAP1, BG_TEAM2);
							BGTeam2Players++;
							gTeam[i] = gBG_TEAM2;
						}
					}
				}
			}
		}
	}
	else if(highestmapvotes == BGMapVotes[1])
	{
	    BGMSG("Map 'Quaters' won! Let´s start!", "Map 'Quaters' hat gewonnen! Lasst uns starten!");
	    CurrentBGMap = BG_MAP2;
	    ClearBGVotes();
	    ExecBGTimer();

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == gBG_VOTING)
		    {
		        SetCameraBehindPlayer(i);
		        TogglePlayerControllable(i, true);
		        SetPlayerVirtualWorld(i, BG_WORLD);
		        ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

		    	if(BGTeam1Players > BGTeam2Players)
				{
					RandomBGSpawn(i, BG_MAP2, BG_TEAM2);
				    BGTeam2Players++;
				    SetPlayerBGTeam2(i);
				    gTeam[i] = gBG_TEAM2;
				}
				else if(BGTeam1Players < BGTeam2Players)
				{
				  	RandomBGSpawn(i, BG_MAP2, BG_TEAM1);
				   	BGTeam1Players++;
				   	SetPlayerBGTeam1(i);
				   	gTeam[i] = gBG_TEAM1;
				}
				else
				{
			        switch(random(2))
			        {
			            case 0:
			            {
			                SetPlayerBGTeam1(i);
							RandomBGSpawn(i, BG_MAP2, BG_TEAM1);
							BGTeam1Players++;
							gTeam[i] = gBG_TEAM1;
						}
						case 1:
						{
						    SetPlayerBGTeam2(i);
							RandomBGSpawn(i, BG_MAP2, BG_TEAM2);
							BGTeam2Players++;
							gTeam[i] = gBG_TEAM2;
						}
					}
				}
			}
		}
	}
	else if(highestmapvotes == BGMapVotes[2])
	{
	    BGMSG("Map 'Rust' won! Let´s start!", "Map 'Rust' hat gewonnen! Lasst uns starten!");
	    CurrentBGMap = BG_MAP3;
	    ClearBGVotes();
	    ExecBGTimer();

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == gBG_VOTING)
		    {
		        SetCameraBehindPlayer(i);
		        TogglePlayerControllable(i, true);
		        SetPlayerVirtualWorld(i, BG_WORLD);
		        ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

		    	if(BGTeam1Players > BGTeam2Players)
				{
					RandomBGSpawn(i, BG_MAP3, BG_TEAM2);
				    BGTeam2Players++;
				    SetPlayerBGTeam2(i);
				    gTeam[i] = gBG_TEAM2;
				}
				else if(BGTeam1Players < BGTeam2Players)
				{
				  	RandomBGSpawn(i, BG_MAP3, BG_TEAM1);
				   	BGTeam1Players++;
				   	SetPlayerBGTeam1(i);
				   	gTeam[i] = gBG_TEAM1;
				}
				else
				{
			        switch(random(2))
			        {
			            case 0:
			            {
			                SetPlayerBGTeam1(i);
							RandomBGSpawn(i, BG_MAP3, BG_TEAM1);
							BGTeam1Players++;
							gTeam[i] = gBG_TEAM1;
						}
						case 1:
						{
						    SetPlayerBGTeam2(i);
							RandomBGSpawn(i, BG_MAP3, BG_TEAM2);
							BGTeam2Players++;
							gTeam[i] = gBG_TEAM2;
						}
					}
				}
			}
		}
	}
	else if(highestmapvotes == BGMapVotes[3])
	{
	    BGMSG("Map 'Italy' won! Let´s start!", "Map 'Italy' hat gewonnen! Lasst uns starten!");
	    CurrentBGMap = BG_MAP4;
	    ClearBGVotes();
	    ExecBGTimer();

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == gBG_VOTING)
		    {
		        SetCameraBehindPlayer(i);
		        TogglePlayerControllable(i, true);
		        SetPlayerVirtualWorld(i, BG_WORLD);
		        ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

		    	if(BGTeam1Players > BGTeam2Players)
				{
					RandomBGSpawn(i, BG_MAP4, BG_TEAM2);
				    BGTeam2Players++;
				    SetPlayerBGTeam2(i);
				    gTeam[i] = gBG_TEAM2;
				}
				else if(BGTeam1Players < BGTeam2Players)
				{
				  	RandomBGSpawn(i, BG_MAP4, BG_TEAM1);
				   	BGTeam1Players++;
				   	SetPlayerBGTeam1(i);
				   	gTeam[i] = gBG_TEAM1;
				}
				else
				{
			        switch(random(2))
			        {
			            case 0:
			            {
			                SetPlayerBGTeam1(i);
							RandomBGSpawn(i, BG_MAP4, BG_TEAM1);
							BGTeam1Players++;
							gTeam[i] = gBG_TEAM1;
						}
						case 1:
						{
						    SetPlayerBGTeam2(i);
							RandomBGSpawn(i, BG_MAP4, BG_TEAM2);
							BGTeam2Players++;
							gTeam[i] = gBG_TEAM2;
						}
					}
				}
			}
		}
	}
	else if(highestmapvotes == BGMapVotes[4])
	{
	    BGMSG("Map 'Medieval' won! Let´s start!", "Map 'Medieval' hat gewonnen! Lasst uns starten!");
	    CurrentBGMap = BG_MAP5;
	    ClearBGVotes();
	    ExecBGTimer();

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == gBG_VOTING)
		    {
		        SetCameraBehindPlayer(i);
		        TogglePlayerControllable(i, true);
		        SetPlayerVirtualWorld(i, BG_WORLD);
		        ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

		    	if(BGTeam1Players > BGTeam2Players)
				{
					RandomBGSpawn(i, BG_MAP5, BG_TEAM2);
				    BGTeam2Players++;
				    SetPlayerBGTeam2(i);
				    gTeam[i] = gBG_TEAM2;
				}
				else if(BGTeam1Players < BGTeam2Players)
				{
				  	RandomBGSpawn(i, BG_MAP5, BG_TEAM1);
				   	BGTeam1Players++;
				   	SetPlayerBGTeam1(i);
				   	gTeam[i] = gBG_TEAM1;
				}
				else
				{
			        switch(random(2))
			        {
			            case 0:
			            {
			                SetPlayerBGTeam1(i);
							RandomBGSpawn(i, BG_MAP5, BG_TEAM1);
							BGTeam1Players++;
							gTeam[i] = gBG_TEAM1;
						}
						case 1:
						{
						    SetPlayerBGTeam2(i);
							RandomBGSpawn(i, BG_MAP5, BG_TEAM2);
							BGTeam2Players++;
							gTeam[i] = gBG_TEAM2;
						}
					}
				}
			}
		}
	}
	return 1;
}

function:BattleGround()
{
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == gBG_TEAM1 || gTeam[i] == gBG_TEAM2 || gTeam[i] == gBG_VOTING)
	    {
	        SetPlayerBGStaticMeshes(i);
	    }
	}
	
	CurrentBGMap = BG_VOTING;
	ExecBGVotingTimer();
	
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == gBG_TEAM1 || gTeam[i] == gBG_TEAM2 || gTeam[i] == gBG_VOTING)
	    {
			ShowDialog(i, BGVOTING_DIALOG);
	    }
	}

	ResetBGGameTime();

    BGTeam1Players = 0;
    BGTeam2Players = 0;

	new
		string[128],
		gstring[128],
		money;

	if(BGTeam1Kills == BGTeam2Kills)
	{
	    format(string, sizeof(string), "Standoff! Rangers kills: %i Spetsnaz kills: %i", BGTeam1Kills, BGTeam2Kills);
	    format(gstring, sizeof(gstring), "Unentschieden! Rangers kills: %i Spetsnaz kills: %i", BGTeam1Kills, BGTeam2Kills);
		BGMSG(string, gstring);
		BGMSG("New Voting starting!", "Neues Voting startet!");
		BGTeam1Kills = 0;
		BGTeam2Kills = 0;
	}
	else if(BGTeam1Kills > BGTeam2Kills)
	{
	    format(string, sizeof(string), "Rangers won! Rangers kills: %i Spetsnaz kills: %i", BGTeam1Kills, BGTeam2Kills);
	    format(gstring, sizeof(gstring), "Rangers haben gewonnen! Rangers kills: %i Spetsnaz kills: %i", BGTeam1Kills, BGTeam2Kills);
		BGMSG(string, gstring);
		BGMSG("New Voting starting!", "Neues Voting startet!");
		BGTeam1Kills = 0;
		BGTeam2Kills = 0;

		money = (800 * BGTeam1Players) + (100 * BGTeam2Players);
 		format(string, sizeof(string), "+$%i~n~+5 Score~n~+1 BG win", money);

	 	for(new i; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == gBG_TEAM1)
		    {
		        GivePlayerCash(i, money);
		        _GivePlayerScore(i, 5);
		        PlayerInfo[i][BGWins]++;
		    }
		}
	}
	else if(BGTeam1Kills < BGTeam2Kills)
	{
	    format(string, sizeof(string), "Spetsnaz won! Rangers kills: %i Spetsnaz kills: %i", BGTeam1Kills, BGTeam2Kills);
     	format(gstring, sizeof(gstring), "Spetsnaz haben gewonnen! Rangers kills: %i Spetsnaz kills: %i", BGTeam1Kills, BGTeam2Kills);
		BGMSG(string, gstring);
		BGMSG("New Voting starting!", "Neues Voting startet!");
		BGTeam1Kills = 0;
		BGTeam2Kills = 0;

		money = (800 * BGTeam1Players) + (100 * BGTeam2Players);
 		format(string, sizeof(string), "+$%i~n~+5 Score~n~+1 BG win", money);

	 	for(new i; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == gBG_TEAM2)
		    {
		        GivePlayerCash(i, money);
		        _GivePlayerScore(i, 5);
		        PlayerInfo[i][BGWins]++;
		    }
		}
	}

	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == gBG_TEAM1 || gTeam[i] == gBG_TEAM2 || gTeam[i] == gBG_VOTING)
	    {
			gTeam[i] = gBG_VOTING;
	    }
	}
	return 1;
}

ExecBGTimer()
{
	KillTimer(tBGTimer);
	tBGTimer = SetTimer("BattleGround", BG_TIME, false);
	return 1;
}

ExecBGVotingTimer()
{
	KillTimer(tBGVoting);
	tBGVoting = SetTimer("BGVoting", BG_VOTING_TIME, false);
	return 1;
}

ClearBGVotes()
{
	BGMapVotes[0] = 0;
	BGMapVotes[1] = 0;
	BGMapVotes[2] = 0;
	BGMapVotes[3] = 0;
	BGMapVotes[4] = 0;
	return 1;
}

function:LangSel(playerid)
{
    TextDrawHideForPlayer(playerid, TXTLoading);
    loginCAM(playerid);
	ShowPlayerDialog(playerid, LANG_DIALOG, DIALOG_STYLE_MSGBOX, " ", ""white"Welcome, please choose your language!", "English", "Deutsch");
	return 1;
}

function:registerDIALOG(playerid)
{
	new newtext1[1024], newtext2[128];
    format(newtext2, sizeof(newtext2), ""orange"Registration - %s", __GetName(playerid));

    if(PlayerInfo[playerid][Lang] == 0)
	{
    	format(newtext1, sizeof(newtext1), ""white"Welcome to "red"Next "blue"Generation "grey"Stunting"white"! \nHow are you, %s?\n\nDesired name: \t%s\nYour IP: \t%s\n\nIt seems that you don´t have an account, please enter a password below:", __GetName(playerid), __GetName(playerid), __GetIP(playerid));
	}
	else
	{
		format(newtext1, sizeof(newtext1), ""white"Willkommen auf "red"Next "blue"Generation "grey"Stunting"white"! \nWie geht es dir, %s?\n\nGewünster Name: \t%s\nDeine IP: \t\t%s\n\nDieser Name ist nicht registriert, also gibt bitte ein Passwort ein:", __GetName(playerid), __GetName(playerid), __GetIP(playerid));
	}
	ShowPlayerDialog(playerid, REGISTER_DIALOG, DIALOG_STYLE_PASSWORD, newtext2, newtext1, "Register", "");
	return 1;
}

function:loginCAM(playerid)
{
	InterpolateCameraPos(playerid, 546.127258, -1789.304077, 43.170913, 353.325012, -1818.477539, 39.799224, 11337, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 542.160339, -1789.496826, 42.694873, 351.647918, -1820.904907, 37.098251, 11337, CAMERA_MOVE);
    return 1;
}

function:loginDIALOG(playerid)
{
	new newtext[1024], newtext2[128];
    TextDrawHideForPlayer(playerid, TXTLoading);
    format(newtext2, sizeof(newtext2), ""orange"Login - %s", __GetName(playerid));
    format(newtext, sizeof(newtext), ""white"Welcome to "red"Next "blue"Generation "grey"Stunting"white"! \nHow are you, %s?\n\nAccount: \t%s\nYour IP: \t%s\n\nThe name that you are using is registered! Please enter the password:",  __GetName(playerid), __GetName(playerid), __GetIP(playerid));
	ShowPlayerDialog(playerid, LOGIN_DIALOG, DIALOG_STYLE_PASSWORD, newtext2, newtext, "Login", "");
    return 1;
}

function:LoginFailDialog(playerid)
{
   	TextDrawHideForPlayer(playerid, TXTLoading);
	new newtext[1024], newtext2[128];
    format(newtext2, sizeof(newtext2), ""orange"Login - %s", __GetName(playerid));
    format(newtext, sizeof(newtext), ""white"Welcome to "red"Next "blue"Generation "grey"Stunting"white"!\n"red"Wrong Password! Tries left: %i"white"\n\nAccount: \t%s\nYour IP: \t%s\n\nThe name that you are using is registered! Please enter the password:", (3 - PlayerInfo[playerid][FailLogin]), __GetName(playerid), __GetIP(playerid));
	ShowPlayerDialog(playerid, LOGIN_DIALOG, DIALOG_STYLE_PASSWORD, newtext2, newtext, "Login", "");
    return 1;
}

TotalGameTime(playerid, &h=0, &m=0, &s=0)
{
    PlayerInfo[playerid][TotalTime] = ((gettime() - PlayerInfo[playerid][ConnectTime]) + (PlayerInfo[playerid][hours]*60*60) + (PlayerInfo[playerid][mins]*60) + (PlayerInfo[playerid][secs]));

    h = floatround(PlayerInfo[playerid][TotalTime] / 3600, floatround_floor);
    m = floatround(PlayerInfo[playerid][TotalTime] / 60,   floatround_floor) % 60;
    s = floatround(PlayerInfo[playerid][TotalTime] % 60,   floatround_floor);

    return PlayerInfo[playerid][TotalTime];
}

CarSpawner(playerid, model)
{
	if(model == 432 || model == 520 || model == 425 || model == 447)
	{
	    if(PlayerInfo[playerid][Level] <= 3)
	    {
            return LangMSG(playerid, -1, ""er"Only admins can spawn this", ""er"Nur Admins können das spawnen");
		}
	}
	
	if(PlayerInfoVeh[playerid][Neon1] != -1)
	{
		DestroyDynamicObject(PlayerInfoVeh[playerid][Neon1]);
		PlayerInfoVeh[playerid][Neon1] = -1;
	}
	if(PlayerInfoVeh[playerid][Neon2] != -1)
	{
		DestroyDynamicObject(PlayerInfoVeh[playerid][Neon2]);
		PlayerInfoVeh[playerid][Neon2] = -1;
	}
	if(PlayerInfo[playerid][PV_Vehicle] != -1)
	{
	    DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
		DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
		PlayerInfo[playerid][PV_Vehicle] = -1;
	}

	new
		Float:POS[4],
		string[18],
		color1 = (random(128) + 127),
		color2 = (random(128) + 127);

	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
	GetPlayerFacingAngle(playerid, POS[3]);
	if(model == 538 || model == 537 || model == 449)
	{
		return LangMSG(playerid, -1, ""er"Cannot spawn it at the moment", ""er"Das geht im Moment nicht");
	}
	else
	{
		PlayerInfo[playerid][Vehicle] = CreateVehicle(model, POS[0], POS[1], POS[2], POS[3], color1, color2, -1);
	}
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	ClearAnimations(playerid);
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	SetVehicleVirtualWorld(PlayerInfo[playerid][Vehicle], GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(PlayerInfo[playerid][Vehicle], GetPlayerInterior(playerid));
	SetVehicleNumberPlate(PlayerInfo[playerid][Vehicle], "{3399ff}S{FFFFFF}tun{F81414}T");
	SetVehicleToRespawn(PlayerInfo[playerid][Vehicle]);
	AddVehicleComponent(PlayerInfo[playerid][Vehicle], 1010);
	PutPlayerInVehicle(playerid, PlayerInfo[playerid][Vehicle], 0);
    format(string, sizeof(string), "~w~%s", GetVehicleNameById(PlayerInfo[playerid][Vehicle]));
    GameTextForPlayer(playerid, string, 1100, 1);
 	new string2[255];
	format(string2, sizeof(string2), "Vehicle Spawned!~n~~b~~h~Name: ~w~%s~n~~b~~h~Model: ~w~%i~n~~b~~h~Colors: ~w~%i, %i", GetVehicleNameById(PlayerInfo[playerid][Vehicle]), GetVehicleModel(PlayerInfo[playerid][Vehicle]), color1, color2);
	SendInfo(playerid, string2, 2500);
	return 1;
}

function:ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
		case DIALOG_RACE_RACETYPE :
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, ""orange"Race Creation "white"- (Step 1/5)", ""white"Normal Race\nAir Race", "Next", "Exit");
		}
	    case DIALOG_RACE_RACEVW :
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, ""orange"Race Creation "white"- (Step 2/5)", ""white"virtual world:", "Next", "Back");
		}
	    case DIALOG_RACE_RACEVWERR :
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, ""orange"Race Creation "white"- (Step 2/5)", ""er"Wrong virtualworld (min. 1 - max. 2147483647)\n\nvirtual world:", "Next", "Back");
		}
		case DIALOG_RACE_RACEVEH :
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, ""orange"Race Creation "white"- (Step 3/5)", ""white"vehicle:", "Next", "Back");
		}
		case DIALOG_RACE_RACEVEHERR :
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, ""orange"Race Creation "white"- (Step 3/5)", ""er"Invalid Vehilce ID/Name\n\nvehicle:", "Next", "Back");
		}
		case DIALOG_RACE_RACESTARTPOS :
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, ""orange"Race Creation "white"- (Step 4/5)", ""white"Set start postions 'KEY_FIRE'", "GO", "Back");
		}
		case DIALOG_RACE_CHECKPOINTS :
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, ""orange"Race Creation "white"- (Step 5/5)", ""white"Checkpoints", "GO", "Back");
		}
		case DIALOG_RACE_RACERDY :
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, ""orange"Race Creation "white"- (DONE)", ""white"Race has been created - ready to use", "Finish", "Exit");
		}
		case STREAM_DIALOG :
		{
			ShowPlayerDialog(playerid, STREAM_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Audio Streams", ""dl"Electro\n"dl"Metal\n"dl"Pop\n"dl"Hip Hop\n"dl"Rap\n"dl"Rock\n"dl"Oldies\n"dl""grey"Your own stream", "Select", "Stop stream");
		}
		case VEHICLEPLATE_DIALOG :
  		{
			ShowPlayerDialog(playerid, VEHICLEPLATE_DIALOG, DIALOG_STYLE_INPUT, ""orange"NG-Stunting "white"- private vehicle shop", ""white"Please enter something for your number plate:\nYou can change it later.\nLength: 2 - 12 characters", "Next", "Back");
  		}
		case NEON_DIALOG :
		{
		    ShowPlayerDialog(playerid, NEON_DIALOG, DIALOG_STYLE_LIST, ""orange"Private Vehicle Neon settings", ""dl"Red\n"dl"Green\n"dl"Blue\n"dl"Yellow\n"dl"White\n"dl""grey"Remove", "OK", "Cancel");
		}
		case PLATE_DIALOG :
		{
		    ShowPlayerDialog(playerid, PLATE_DIALOG, DIALOG_STYLE_INPUT, ""orange"Vehicle Settings", ""white"Please enter something for your number plate:\nLength: 2 - 12 characters", "Change", "Cancel");
		}
		case VEHICLE_DIALOG :
		{
			new
				string[512],
				finstring[1024];

			format(finstring, sizeof(finstring), ""dl"Airplanes\n"dl"Helicopters\n"dl"Bikes\n"dl"Convertibles\n"dl"Industrial\n"dl"Lowriders\n"dl"Off Road\n"dl"Public Service Vehicles\n"dl"Saloons\n");
			format(string, sizeof(string), ""dl"Sport Vehicles\n"dl"Station Wagons\n"dl"Boats\n"dl"Trailers\n"dl"Unique Vehicles\n"dl"RC Vehicles");
			strcat(finstring, string, sizeof(string));
			ShowPlayerDialog(playerid, VEHICLE_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Vehicle Menu", finstring, "Select", "Cancel");
		}
		case TELE_DIALOG :
		{
			ShowPlayerDialog(playerid, TELE_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Teleports",
			""dl"Parkours\n"dl"Stunting Teleports\n"dl"BaseJump Teleports\n"dl"Vehicle Jumps/Maps\n"dl"Other Fun Maps\n"dl"Specials", "Select", "Cancel");
		}
		case VMENU_DIALOG :
		{
			ShowPlayerDialog(playerid, VMENU_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting - "white"Private Vehicle Menu", ""dl"Spawn Vehicle\n"dl"Attach Neon\n"dl"Change Number Plate\n"dl""grey"Sell vehicle", "Select", "Cancel");
		}
		case WEAPON_DIALOG :
		{
			ShowPlayerDialog(playerid, WEAPON_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting - "white"Weapons", ""dl"Rifles\n"dl"Submachine Guns\n"dl"Shot Guns\n"dl"Hand Guns\n"dl"Melee Weapons\n"dl"Special Weapons", "Select", "Cancel");
		}
		case CARBUY_DIALOG :
		{
			ShowPlayerDialog(playerid, CARBUY_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting - "white"private vehicle shop", ""dl"Lowriders\n"dl"Sport Vehicles\n"dl"Saloons\n"dl"Bikes\n"dl"Convertibles\n"dl"Off Road", "Select", "Cancel");
		}
		case GMENU_DIALOG :
		{
		    ShowPlayerDialog(playerid, GMENU_DIALOG, DIALOG_STYLE_LIST, ""orange"Gang Menu", ""dl"Gang Info\n"dl"Show all gang members", "Select", "Cancel");
		}
		case BGVOTING_DIALOG :
		{
		    ShowPlayerDialog(playerid, BGVOTING_DIALOG, DIALOG_STYLE_LIST, ""orange"TDM Map Voting", ""dl"Forest\n"dl"Quarters\n"dl"Rust\n"dl"Italy\n"dl"Medieval", "Vote", "");
		}
		case DERBY_VOTING_DIALOG :
		{
            ShowPlayerDialog(playerid, DERBY_VOTING_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Derby Map Voting", ""dl"Lighthouse\n"dl"Truncat\n"dl"Sky Skiing\n"dl"Townhall\n"dl"Glazz\n"dl"Rambo", "Vote", "");
		}
		case BANK_DIALOG :
		{
		    ShowPlayerDialog(playerid, BANK_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white"- Bank Menu", ""dl"Deposit\n"dl"Withdraw\n"dl"Check Balance", "Select", "Cancel");
		}
	}
	return 1;
}

ResetPlayerWorld(playerid)
{
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
}

// --
// -- Messages
// --
function:GunGameMSG(const string[], const gstring[])
{
	new finstring[200], gfinstring[200];
	format(finstring, sizeof(finstring), ""gungame_sign" %s", string);
	format(gfinstring, sizeof(gfinstring), ""gungame_sign" %s", gstring);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (gTeam[i] == GUNGAME))
		{
			if(PlayerInfo[i][Lang] == 0)
			{
				SendClientMessage(i, GREY, finstring);
			}
			else SendClientMessage(i, GREY, gfinstring);
		}
	}
	return 1;
}

function:FalloutMSG(const string[], const gstring[])
{
	new finstring[200], gfinstring[200];
	format(finstring, sizeof(finstring), ""fallout_sign" %s", string);
	format(gfinstring, sizeof(gfinstring), ""fallout_sign" %s", gstring);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (gTeam[i] == FALLOUT))
		{
			if(PlayerInfo[i][Lang] == 0)
			{
				SendClientMessage(i, GREY, finstring);
			}
			else SendClientMessage(i, GREY, gfinstring);
		}
	}
	return 1;
}

function:DerbyMSG(const string[], const gstring[])
{
	new finstring[200], gfinstring[200];
	format(finstring, sizeof(finstring), ""derby_sign" %s", string);
	format(gfinstring, sizeof(gfinstring), ""derby_sign" %s", gstring);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (gTeam[i] == DERBY))
		{
		    if(PlayerInfo[i][Lang] == 0)
			{
				SendClientMessage(i, GREY, finstring);
			}
			else SendClientMessage(i, GREY, gfinstring);
		}
	}
	return 1;
}

function:BGMSG(const string[], const gstring[])
{
	new finstring[200], gfinstring[200];
	format(finstring, sizeof(finstring), ""tdm_sign" %s", string);
	format(gfinstring, sizeof(gfinstring), ""tdm_sign" %s", gstring);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerAvail(i) && (gTeam[i] == gBG_TEAM1 || gTeam[i] == gBG_VOTING || gTeam[i] == gBG_TEAM2))
		{
			if(PlayerInfo[i][Lang] == 0)
			{
				SendClientMessage(i, GREY, finstring);
			}
			else SendClientMessage(i, GREY, gfinstring);
		}
	}
	return 1;
}

function:RaceMSG(const string[], const gstring[])
{
	new finstring[200], gfinstring[200];
	format(finstring, sizeof(finstring), ""race_sign" %s", string);
	format(gfinstring, sizeof(gfinstring), ""race_sign" %s", gstring);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (gTeam[i] == RACE))
		{
			if(PlayerInfo[i][Lang] == 0)
			{
				SendClientMessage(i, GREY, finstring);
			}
			else SendClientMessage(i, GREY, gfinstring);
		}
	}
	return 1;
}

function:LangMSG(playerid, color, const string[], const gstring[])
{
	if(PlayerInfo[playerid][Lang] == 0)
	{
		SendClientMessage(playerid, color, string);
	}
	else
	{
		SendClientMessage(playerid, color, gstring);
	}
	return 1;
}

function:LangMSGToAll(color, const string[], const gstring[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i)) continue;

		if(PlayerInfo[i][Lang] == 0)
		{
			SendClientMessage(i, color, string);
		}
		else SendClientMessage(i, color, gstring);
	}
	return 1;
}

function:GangMSG(gGangID, const string[], const gstring[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
			if(PlayerInfo[i][GangID] == gGangID && PlayerInfo[i][IsInGang] != 0)
			{
			 	if(PlayerInfo[i][Lang] == 0)
				{
		 			SendClientMessage(i, RED, string);
				}
				else SendClientMessage(i, RED, gstring);
			}
		}
	}
	return 1;
}

function:AdminMSG(color, const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (PlayerInfo[i][Level] >= 1))
		{
			SendClientMessage(i, color, string);
		}
	}
	return 1;
}

MySQL_LoadBanStats(playerid)
{
	new query[150];
	format(query, sizeof(query), "SELECT `AdminName`, `Reason`, `Date` FROM `"#TABLE_BAN"` WHERE `PlayerName` = '%s';", __GetName(playerid));
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_LOAD_BAN_STAT, playerid, g_SQL_handle);
}

MySQL_FetchGangInfo(playerid, gGangID)
{
	new query[150];
	format(query, sizeof(query), "SELECT * FROM `"#TABLE_GANG"` WHERE `ID` = %i;", gGangID);
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_FETCH_GANG_INFO, playerid, g_SQL_handle);
}

MySQL_UpdateGangScore(gGangID, value)
{
	new query[150];
	format(query, sizeof(query), "UPDATE `"#TABLE_GANG"` SET `GangScore` = `GangScore` + %i WHERE `ID` = %i LIMIT 1;", value, gGangID);
	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_LoadPlayer(playerid)
{
	new query[200];
	format(query, sizeof(query), "SELECT * FROM `"#TABLE_ACCOUNT"` WHERE `Name` = '%s';", __GetName(playerid));
	mysql_query(query, THREAD_LOADPLAYER, playerid, g_SQL_handle);
}

MySQL_LoadPlayerVeh(playerid)
{
	new query[150];
	format(query, sizeof(query), "SELECT * FROM `"#TABLE_VEHICLE"` WHERE `Owner` = '%s';", __GetName(playerid));
    mysql_query(query, THREAD_LOADPLAYERVEH, playerid, g_SQL_handle);
}

MySQL_KickFromGangIfExist(playerid)
{
	new query[180];
	mysql_real_escape_string(PlayerInfo[playerid][GangKickMem], PlayerInfo[playerid][GangKickMem], g_SQL_handle, 25);
  	format(query, sizeof(query), "SELECT `ID` FROM `"#TABLE_ACCOUNT"` WHERE `GangName` = '%s' AND `Name` = '%s';", PlayerInfo[playerid][GangName], PlayerInfo[playerid][GangKickMem]);
  	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_KICK_FROM_GANG, playerid, g_SQL_handle);
}

MySQL_SavePlayer(playerid)
{
	new query[1024],
	 	query2[255],
		h,
		m,
		s,
		p_gangnam[21],
		p_gangtag[5],
		p_gangid = 0;


	if(PlayerInfo[playerid][IsInGang] == 0 && PlayerInfo[playerid][gInvite])
	{
	    strmid(p_gangnam, "---", 0, 21, 21);
	    strmid(p_gangtag, "---", 0, 5, 5);
	    p_gangid = 0;
	}
	else if(PlayerInfo[playerid][IsInGang] == 0 && !PlayerInfo[playerid][gInvite])
	{
 		strmid(PlayerInfo[playerid][GangName], "---", 0, 21, 21);
	    strmid(PlayerInfo[playerid][GangTag], "---", 0, 5, 5);
	    PlayerInfo[playerid][GangID] = 0;
 	    strmid(p_gangnam, "---", 0, 21, 21);
	    strmid(p_gangtag, "---", 0, 5, 5);
	    p_gangid = 0;
	}
	else
	{
 	    strmid(p_gangnam, PlayerInfo[playerid][GangName], 0, 21, 21);
	    strmid(p_gangtag, PlayerInfo[playerid][GangTag], 0, 5, 5);
    	p_gangid = PlayerInfo[playerid][GangID];
    }

	TotalGameTime(playerid, h, m, s);

	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET \
	`Lang` = %i, `Level` = %i, `Score` = %i, `Money` = %i, `Bank` = %i, `Kills` = %i, `Deaths` = %i, `Hours` = %i, `Minutes` = %i, `Seconds` = %i, \
	`Reaction` = %i, `PayDay` = %i, `Houses` = %i, `Props` = %i, `PropEarnings` = %i, `IsInGang` = %i, `GangID` = %i, `GangName` = '%s', `GangTag` = '%s', `Vehicle` = %i, \
	`DerbyWins` = %i",
	    PlayerInfo[playerid][Lang],
		PlayerInfo[playerid][Level],
		_GetPlayerScore(playerid),
	    GetPlayerCash(playerid),
	    PlayerInfo[playerid][Bank],
	    PlayerInfo[playerid][Kills],
	    PlayerInfo[playerid][Deaths],
	    h,
	  	m,
	    s,
	    PlayerInfo[playerid][Reaction],
	    PlayerInfo[playerid][PayDay],
	    PlayerInfo[playerid][Houses],
	    PlayerInfo[playerid][Props],
		PlayerInfo[playerid][PropEarnings],
		PlayerInfo[playerid][IsInGang],
		p_gangid,
		p_gangnam,
		p_gangtag,
		PlayerInfo[playerid][BuyAbleVeh],
	    PlayerInfo[playerid][DerbyWins]);

    format(query2, sizeof(query2), ", `Skin` = %i, `GungameWins` = %i, `RaceWins` = %i, `BGWins` = %i, `FalloutWins` = %i, `Wanteds` = %i WHERE `Name` = '%s' LIMIT 1;",
		GetPlayerSkin(playerid),
        PlayerInfo[playerid][GungameWins],
    	PlayerInfo[playerid][RaceWins],
	    PlayerInfo[playerid][BGWins],
		PlayerInfo[playerid][FalloutWins],
	    PlayerInfo[playerid][Wanteds],
		__GetName(playerid));

	strcat(query, query2);

	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_UpdatePlayerPass(playerid, hash[])
{
	new query[128], escape[33];
	mysql_real_escape_string(hash, escape, g_SQL_handle, 33);
	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `hash` = MD5('%s') WHERE `Name` = '%s' LIMIT 1;", escape, __GetName(playerid));
 	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_SavePlayerVeh(playerid)
{
	new query[750];
	format(query, sizeof(query), "UPDATE `"#TABLE_VEHICLE"` SET `Model` = %i, `Price` = %i, `PaintJob` = %i, `Color1` = %i, `Color2` = %i, `Plate` = '%s', \
	`Mod1` = %i, `Mod2` = %i, `Mod3` = %i, `Mod4` = %i, `Mod5` = %i, `Mod6` = %i, `Mod7` = %i, `Mod8` = %i, `Mod9` = %i, `Mod10` = %i, `Mod11` = %i, `Mod12` = %i, `Mod13` = %i, `Mod14` = %i, `Mod15` = %i, `Mod16` = %i, `Mod17` = %i \
	WHERE `Owner` = '%s' LIMIT 1;",
		PlayerInfoVeh[playerid][Model],
		PlayerInfoVeh[playerid][Price],
		PlayerInfoVeh[playerid][PaintJob],
		PlayerInfoVeh[playerid][Color1],
		PlayerInfoVeh[playerid][Color2],
		PlayerInfoVeh[playerid][Plate],
		PlayerInfoVeh[playerid][Mod1],
		PlayerInfoVeh[playerid][Mod2],
		PlayerInfoVeh[playerid][Mod3],
		PlayerInfoVeh[playerid][Mod4],
		PlayerInfoVeh[playerid][Mod5],
		PlayerInfoVeh[playerid][Mod6],
		PlayerInfoVeh[playerid][Mod7],
		PlayerInfoVeh[playerid][Mod8],
		PlayerInfoVeh[playerid][Mod9],
		PlayerInfoVeh[playerid][Mod10],
		PlayerInfoVeh[playerid][Mod11],
		PlayerInfoVeh[playerid][Mod12],
		PlayerInfoVeh[playerid][Mod13],
		PlayerInfoVeh[playerid][Mod14],
		PlayerInfoVeh[playerid][Mod15],
		PlayerInfoVeh[playerid][Mod16],
		PlayerInfoVeh[playerid][Mod17],
		__GetName(playerid));

    mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_DeletePlayerVehiclePerm(playerid)
{
    new query[128];
    format(query, sizeof(query), "DELETE FROM `"#TABLE_VEHICLE"` WHERE `Owner` = '%s' LIMIT 1;", __GetName(playerid));
	mysql_query(query, THREAD_DELETE_VEH, playerid, g_SQL_handle);
}

MySQL_FetchGangMemberNames(playerid, gGangID)
{
	new query[128];
	format(query, sizeof(query), "SELECT `Name` FROM `"#TABLE_ACCOUNT"` WHERE `GangID` = %i;", gGangID);
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_FETCH_GANG_MEMBER_NAMES, playerid, g_SQL_handle);
}

MySQL_BanIP(const ip[])
{
	new query[100];
 	format(query, sizeof(query), "INSERT INTO `"#TABLE_BLACKLIST"` VALUES (NULL, '%s');", ip);
 	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_ExistAccount(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT `ID` FROM `"#TABLE_ACCOUNT"` WHERE `Name` = '%s';", __GetName(playerid));
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_ACCOUNT_EXIST, playerid, g_SQL_handle);
}

MySQL_ExistGang(playerid)
{
	new query[150];
	format(query, sizeof(query), "SELECT `ID` FROM `"#TABLE_GANG"` WHERE `GangName` = '%s';", PlayerInfo[playerid][GangName]);
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_GANG_EXIST, playerid, g_SQL_handle);
}

MySQL_IsAccountBanned(playerid)
{
	new query[100];
	format(query, sizeof(query), "SELECT * FROM `"#TABLE_BAN"` WHERE `PlayerName` = '%s';", __GetName(playerid));
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_IS_BANNED, playerid, g_SQL_handle);
}

MySQL_CheckPlayerIP(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT `ID` FROM `"#TABLE_BLACKLIST"` WHERE `IP` = '%s';", __GetIP(playerid));
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_CHECK_IP, playerid, g_SQL_handle);
}

MySQL_CreateGang(playerid)
{
    new query[200];
    format(query, sizeof(query), "INSERT INTO `"#TABLE_GANG"` VALUES (NULL, '%s', '%s', '%s', 0, %i);", PlayerInfo[playerid][GangName], PlayerInfo[playerid][GangTag], __GetName(playerid), gettime());
    mysql_function_query(g_SQL_handle, query, false, "OnQueryFinish", "siii", query, THREAD_CREATE_GANG, playerid, g_SQL_handle);
}

MySQL_CheckPlayerPassword(playerid, password[])
{
    new query[180], escape[33];
	mysql_real_escape_string(password, escape, g_SQL_handle, 33);
    format(query, sizeof(query), "SELECT `Hash` FROM `"#TABLE_ACCOUNT"` WHERE `Name` = '%s' AND `Hash` = MD5('%s');", __GetName(playerid), escape);
    mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_CHECK_PLAYER_PASSWD, playerid, g_SQL_handle);
}

MySQL_CreateAccount(playerid, password[])
{
    new query[350], escape[33];
	mysql_real_escape_string(password, escape, g_SQL_handle, 33);
    format(query, sizeof(query), "INSERT INTO `"#TABLE_ACCOUNT"` (`Name`, `Logged`, `Hash`, `IP`, `IsInGang`, `GangID`, `GangName`, `GangTag`, `RegDate`) VALUES ('%s', 1, MD5('%s'), '%s', 0, 0, '---', '---', %i);", __GetName(playerid), escape, __GetIP(playerid), gettime());
	mysql_query(query, THREAD_CREATE_ACCOUNT, playerid, g_SQL_handle);
	PlayerInfo[playerid][RegDate] = gettime();
}

MySQL_LogPlayerIn(playerid)
{
    new query[150];
    format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `Logged` = 1, `IP` = '%s' WHERE `Name` = '%s' LIMIT 1", __GetIP(playerid), __GetName(playerid));
    mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_LogPlayerOut(playerid)
{
    new query[150];
    format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `Logged` = 0 WHERE `Name` = '%s' LIMIT 1", __GetName(playerid));
    mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_CreateBan(PlayerName[], AdminName[], Reason[])
{
	new query[300], rescape[129], aescape[25], pescape[25];
	mysql_real_escape_string(Reason, rescape, g_SQL_handle, 129);
	mysql_real_escape_string(AdminName, aescape, g_SQL_handle, 25);
	mysql_real_escape_string(PlayerName, pescape, g_SQL_handle, 25);
    format(query, sizeof(query), "INSERT INTO `"#TABLE_BAN"` VALUES (NULL, '%s', '%s', '%s', %i);", pescape, aescape, rescape, gettime());
    mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_CreateBuyVehicle(playerid)
{
    new query[150];
    format(query, sizeof(query), "INSERT INTO `"#TABLE_VEHICLE"` (`Owner`, `Price`, `Model`, `Plate`) VALUES ('%s', %i, %i, '%s')", __GetName(playerid), PlayerInfoVeh[playerid][Price], PlayerInfoVeh[playerid][Model], PlayerInfoVeh[playerid][Plate]);
	mysql_query(query, THREAD_BUY_VEHICLE, playerid, g_SQL_handle);
}

MySQL_SaveHouse(house)
{
    new query[400];
    format(query, sizeof(query), "UPDATE `"#TABLE_HOUSE"` \
	SET `Owner` = '%s', `x` = %.2f, `y` = %.2f, `z` = %.2f, `interior` = %i, `price` = %i, `score` = %i, `sold` = %i, `locked` = %i, `Date` = %i \
	WHERE `ID` = %i LIMIT 1;",
		HouseInfo[house][Owner],
		HouseInfo[house][E_x],
		HouseInfo[house][E_y],
		HouseInfo[house][E_z],
		HouseInfo[house][interior],
		HouseInfo[house][price],
		HouseInfo[house][E_score],
		HouseInfo[house][sold],
		HouseInfo[house][locked],
		HouseInfo[house][date],
		HouseInfo[house][iID]);

 	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_SaveProp(propertyid)
{
    new query[300];
    format(query, sizeof(query), "UPDATE `"#TABLE_PROP"` SET `Owner` = '%s', `x` = %.2f, `y` = %.2f, `z` = %.2f, `price` = %i, `earnings` = %i, `score` = %i, `sold` = %i, `Date` = %i WHERE `ID` = %i LIMIT 1;",
		PropInfo[propertyid][Owner],
		PropInfo[propertyid][E_x],
		PropInfo[propertyid][E_y],
		PropInfo[propertyid][E_z],
		PropInfo[propertyid][price],
		PropInfo[propertyid][earnings],
		PropInfo[propertyid][E_score],
		PropInfo[propertyid][sold],
		PropInfo[propertyid][date],
		PropInfo[propertyid][iID]);

	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_FinalGangKick(playerid)
{
	new query[255];
	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `GangID` = 0, `GangName` = '---', `GangTag` = '---', `IsInGang` = 0  WHERE `Name` = '%s' LIMIT 1;", PlayerInfo[playerid][GangKickMem]);
	mysql_function_query(g_SQL_handle, query, false, "OnQueryFinish", "siii", query, THREAD_KICK_FROM_GANG_2, playerid, g_SQL_handle);
}

MySQL_ClearLoggedPlayers()
{
	new query[100];
	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `Logged` = 0;");
	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_Connect()
{
    g_SQL_handle = mysql_connect(SQL_HOST, SQL_USER, SQL_DATA, SQL_PASS);
    if(mysql_ping(g_SQL_handle))
    {
        printf("#Successfully connected to MySQL Server @ %s", SQL_HOST);
    }
    else
    {
        print("#Database connection error. Second try...");
        g_SQL_handle = mysql_connect(SQL_HOST, SQL_USER, SQL_DATA, SQL_PASS);
        if(mysql_ping(g_SQL_handle))
        {
            printf("#Successfully connected to MySQL Server with second try @ %s", SQL_HOST);
        }
        else
        {
            printf("#Failed to connect to %s Aborting...", SQL_HOST);
            print("=====================Next Geneartion Stunting=====================");
            SendRconCommand("exit");
        }
    }
}

LoadStores()
{
	new
		file[50],
		count = GetTickCount() + 3600000,
		lstring[128];

	for(new b = 0; b < MAX_BANKS; b++)
	{
	    format(file, sizeof(file), "/Store/Banks/%i.ini", b);
		if(dini_Exists(file))
		{
			BankPickOut[b] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		BankPickInt[b] = CreateDynamicPickup(1559, 1, 2304.69, -16.19, 26.74, (b + 1000), -1, -1, 50.0);
	  		BankPickMenu[b] = CreateDynamicPickup(1559, 1, 2311.63, -3.89, 26.74, (b + 1000), -1, -1, 50.0);
	  		BankMIcon[b] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 25, -1, 0, 0, -1, 200.0);
	  		format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		StoreLabel[dini_Int(file, "StoreID")] = Create3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25, 0, 1);
		}
	}
    for(new a = 0; a < MAX_AMMUNATIONS; a++)
	{
	    format(file, sizeof(file), "/Store/Ammunations/%i.ini", a);
		if(dini_Exists(file))
		{
			AmmunationPickOut[a] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		AmmunationPickInt[a] = CreateDynamicPickup(1559, 1, 315.81, -143.65, 999.60, (a + 1000), 7, -1, 50.0);
			AmmunationMIcon[a] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 6, -1, 0, 0, -1, 200.0);
			format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
			StoreLabel[dini_Int(file, "StoreID")] = Create3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25, 0, 1);
		}
	}
	for(new bs = 0; bs < MAX_BURGERSHOTS; bs++)
	{
	    format(file, sizeof(file), "/Store/BurgerShots/%i.ini", bs);
		if(dini_Exists(file))
		{
			BurgerPickOut[bs] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		BurgerPickInt[bs] = CreateDynamicPickup(1559, 1, 362.87, -75.17, 1001.50, (bs + 1000), 10, -1, 50.0);
		   	BurgerMIcon[bs] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 10, -1, 0, 0, -1, 200.0);
		   	format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		StoreLabel[dini_Int(file, "StoreID")] = Create3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25, 0, 1);
		}
	}
	for(new cb = 0; cb < MAX_CLUCKINBELLS; cb++)
	{
	    format(file, sizeof(file), "/Store/CluckinBells/%i.ini", cb);
		if(dini_Exists(file))
		{
			CluckinBellPickOut[cb] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		CluckinBellPickInt[cb] = CreateDynamicPickup(1559, 1, 364.87, -11.74, 1001.85, (cb + 1000), 9, -1, 50.0);
			CluckinBellMIcon[cb] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 14, -1, 0, 0, -1, 200.0);
			format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		StoreLabel[dini_Int(file, "StoreID")] = Create3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25, 0, 1);
		}
	}
	for(new ps = 0; ps < MAX_PIZZASTACKS; ps++)
	{
	    format(file, sizeof(file), "/Store/WellStackedPizzas/%i.ini", ps);
		if(dini_Exists(file))
		{
			PizzaPickOut[ps] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		PizzaPickInt[ps] = CreateDynamicPickup(1559, 1, 372.36, -133.50, 1001.49, (ps + 1000), 5, -1, 50.0);
			PizzaMIcon[ps] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 29, -1, 0, 0, -1, 200.0);
			format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		StoreLabel[dini_Int(file, "StoreID")] = Create3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25, 0, 1);
		}
	}
	for(new tfs = 0; tfs < MAX_TFS; tfs++)
	{
	    format(file, sizeof(file), "/Store/TwentyFourSeven/%i.ini", tfs);
		if(dini_Exists(file))
		{
			TFSPickOut[tfs] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		TFSPickInt[tfs] = CreateDynamicPickup(1559, 1, -25.884, -185.868, 1003.546, (tfs + 1000), 17, -1, 50.0);
			TFSMIcon[tfs] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 17, -1, 0, 0, -1, 200.0);
			format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		StoreLabel[dini_Int(file, "StoreID")] = Create3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25, 0, 1);
		}
	}
 	printf("#Stores loaded in %i ms", (GetTickCount() + 3600000) - count);
 	return 1;
}

DestroyStores()
{
	for(new b = 0; b < MAX_BANKS; b++)
	{
	    DestroyDynamicPickup(BankPickOut[b]);
		DestroyDynamicPickup(BankPickInt[b]);
		DestroyDynamicPickup(BankPickMenu[b]);
		DestroyDynamicMapIcon(BankMIcon[b]);
	}
    for(new a = 0; a < MAX_AMMUNATIONS; a++)
	{
	    DestroyDynamicPickup(AmmunationPickOut[a]);
		DestroyDynamicPickup(AmmunationPickInt[a]);
		DestroyDynamicMapIcon(AmmunationMIcon[a]);
	}
	for(new bs = 0; bs < MAX_BURGERSHOTS; bs++)
	{
	    DestroyDynamicPickup(BurgerPickOut[bs]);
		DestroyDynamicPickup(BurgerPickInt[bs]);
		DestroyDynamicMapIcon(BurgerMIcon[bs]);
	}
	for(new cb = 0; cb < MAX_CLUCKINBELLS; cb++)
	{
	    DestroyDynamicPickup(CluckinBellPickOut[cb]);
		DestroyDynamicPickup(CluckinBellPickInt[cb]);
		DestroyDynamicMapIcon(CluckinBellMIcon[cb]);
	}
	for(new ps = 0; ps < MAX_PIZZASTACKS; ps++)
	{
	    DestroyDynamicPickup(PizzaPickOut[ps]);
		DestroyDynamicPickup(PizzaPickInt[ps]);
		DestroyDynamicMapIcon(PizzaMIcon[ps]);
	}
	for(new tfs = 0; tfs < MAX_TFS; tfs++)
	{
	    DestroyDynamicPickup(TFSPickOut[tfs]);
		DestroyDynamicPickup(TFSPickInt[tfs]);
		DestroyDynamicMapIcon(TFSMIcon[tfs]);
	}
	for(new s = 0; s < MAX_STORES; s++)
	{
	    Delete3DTextLabel(StoreLabel[s]);
	}
	return 1;
}

LoadExObjects()
{
	CreateDynamicObject(1634, 393.77, -2166.32, 76.07,   0.00, 0.00, 223.94);
	CreateDynamicObject(1634, 390.98, -2168.66, 76.07,   0.00, 0.00, 215.94);
	CreateDynamicObject(1634, 387.93, -2170.59, 76.07,   0.00, 0.00, 207.94);
	CreateDynamicObject(1634, 384.71, -2172.00, 76.07,   0.00, 0.00, 199.93);
	CreateDynamicObject(1634, 381.35, -2172.96, 76.07,   0.00, 0.00, 191.93);
	CreateDynamicObject(1634, 377.74, -2173.45, 76.07,   0.00, 0.00, 183.93);
	CreateDynamicObject(1634, 374.16, -2173.44, 76.07,   0.00, 0.00, 175.92);
	CreateDynamicObject(1634, 370.59, -2172.92, 76.07,   0.00, 0.00, 167.92);
	CreateDynamicObject(1634, 367.21, -2171.95, 76.07,   0.00, 0.00, 159.92);
	CreateDynamicObject(1634, 363.93, -2170.48, 76.07,   0.00, 0.00, 151.91);
	CreateDynamicObject(1634, 360.99, -2168.63, 76.07,   0.00, 0.00, 143.91);
	CreateDynamicObject(1634, 358.34, -2166.43, 76.07,   0.00, 0.00, 135.90);
	CreateDynamicObject(1634, 355.97, -2163.77, 76.07,   0.00, 0.00, 127.90);
	CreateDynamicObject(1634, 353.97, -2160.81, 76.07,   0.00, 0.00, 119.89);
	CreateDynamicObject(1634, 352.42, -2157.63, 76.07,   0.00, 0.00, 111.89);
	CreateDynamicObject(1634, 351.35, -2154.26, 76.07,   0.00, 0.00, 103.89);
	CreateDynamicObject(1634, 350.73, -2150.70, 76.07,   0.00, 0.00, 95.89);
	CreateDynamicObject(1634, 350.59, -2147.16, 76.07,   0.00, 0.00, 87.88);
	CreateDynamicObject(17310, 224.74, -2053.79, 74.50,   0.00, 180.00, 90.00);
	CreateDynamicObject(17310, 236.52, -2053.79, 74.50,   0.00, 180.00, 90.00);
	CreateDynamicObject(17310, 248.29, -2053.79, 74.50,   0.00, 180.00, 90.00);
	CreateDynamicObject(17310, 259.97, -2053.79, 74.50,   0.00, 180.00, 90.00);
	CreateDynamicObject(17310, 271.62, -2053.79, 74.50,   0.00, 180.00, 90.00);
	CreateDynamicObject(17310, 271.71, -2081.59, 90.57,   0.00, 240.00, 90.00);
	CreateDynamicObject(17310, 260.09, -2081.59, 90.57,   0.00, 240.00, 90.00);
	CreateDynamicObject(17310, 248.47, -2081.59, 90.57,   0.00, 240.00, 90.00);
	CreateDynamicObject(17310, 236.79, -2081.59, 90.57,   0.00, 240.00, 90.00);
	CreateDynamicObject(17310, 225.06, -2081.59, 90.57,   0.00, 240.00, 90.00);
	CreateDynamicObject(17310, 225.06, -2025.97, 90.57,   0.00, 120.00, 90.00);
	CreateDynamicObject(17310, 271.71, -2025.97, 90.57,   0.00, 120.00, 90.00);
	CreateDynamicObject(17310, 260.09, -2025.97, 90.57,   0.00, 120.00, 90.00);
	CreateDynamicObject(17310, 248.47, -2025.97, 90.57,   0.00, 120.00, 90.00);
	CreateDynamicObject(17310, 236.79, -2025.97, 90.57,   0.00, 120.00, 90.00);
	CreateDynamicObject(13647, 221.00, -2134.82, 74.99,   0.00, 0.00, 90.00);
	CreateDynamicObject(13647, 230.00, -2134.82, 74.99,   0.00, 0.00, 90.00);
	CreateDynamicObject(13647, 239.00, -2137.06, 74.99,   0.00, 0.00, 270.00);
	CreateDynamicObject(13647, 248.00, -2137.06, 74.99,   0.00, 0.00, 270.00);
	CreateDynamicObject(13592, 303.06, -2158.10, 84.94,   0.00, 0.00, 12.00);
	CreateDynamicObject(13592, 305.52, -2149.75, 84.94,   0.00, 0.00, 12.00);
	CreateDynamicObject(13592, 300.68, -2166.44, 84.94,   0.00, 0.00, 12.00);
	CreateDynamicObject(8375, 343.18, -2043.70, 76.89,   0.00, 0.00, 90.00);
	CreateDynamicObject(1632, 322.70, -2093.54, 76.07,   0.00, 0.00, 90.00);
	CreateDynamicObject(1632, 316.29, -2093.57, 76.07,   0.00, 0.00, 270.00);
	CreateDynamicObject(1632, 319.54, -2098.86, 76.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(1632, 319.47, -2088.30, 76.07,   0.00, 0.00, 180.00);
	CreateDynamicObject(4874, 1210.00, -977.80, 55.70,   0.00, 0.00, 0.00);
	CreateDynamicObject(3928, 1196.30, -902.00, 47.10,   0.00, 0.00, 0.00);
	CreateDynamicObject(5816, 1191.07, -946.17, 49.82,   0.00, 0.00, 0.00);
	CreateDynamicObject(4100, 1145.90, -894.80, 43.50,   0.00, 0.00, 62.00);
	CreateDynamicObject(4726, 1199.90, -903.60, 49.00,   0.00, 0.00, 8.00);
	CreateDynamicObject(18066, 1219.30, -925.00, 46.10,   0.00, 0.00, 8.00);
	CreateDynamicObject(6188, 1284.50, -857.50, 71.10,   0.00, 0.00, 359.99);
	CreateDynamicObject(16502, 1188.08, -953.75, 52.42,   0.00, 0.00, 270.00);
	CreateDynamicObject(737, 1211.40, -924.50, 41.90,   0.00, 0.00, 0.00);
	CreateDynamicObject(737, 1226.70, -922.90, 41.90,   0.00, 0.00, 0.00);
	CreateDynamicObject(739, 1222.20, -955.20, 41.90,   0.00, 0.00, 0.00);
	CreateDynamicObject(7313, 1201.30, -919.20, 45.80,   0.00, 0.00, 6.00);
	CreateDynamicObject(7313, 1201.30, -919.20, 46.60,   0.00, 0.00, 3.99);
	CreateDynamicObject(7231, 1181.40, -925.70, 64.00,   0.00, 0.00, 22.00);
	CreateDynamicObject(3818, 1176.30, -945.80, 47.20,   0.00, 0.00, 96.00);
	CreateDynamicObject(2783, 1189.20, -916.00, 43.60,   0.00, 0.00, 8.00);
	CreateDynamicObject(2785, 1208.60, -924.00, 43.00,   0.00, 0.00, 190.00);
	CreateDynamicObject(6948, 1202.26, -1017.80, 56.48,   0.00, 0.00, 270.00);
	CreateDynamicObject(1685, 1299.51, -796.55, 1084.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(1685, 1298.26, -796.57, 1084.05,   0.00, 0.00, 0.00);
	CreateDynamicObject(1685, 1298.26, -796.57, 1084.96,   0.00, 0.00, 0.00);
	CreateDynamicObject(1685, 1299.51, -796.55, 1084.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(1685, 1261.15, -784.84, 1091.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1685, 1261.17, -786.19, 1091.60,   0.00, 0.00, 0.00);
	CreateDynamicObject(1685, 1261.17, -786.19, 1092.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(1685, 1261.15, -784.84, 1092.83,   0.00, 0.00, 0.00);
	CreateDynamicObject(18450, 471.08, -2179.94, 101.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(1634, 431.76, -2179.71, 102.49,   0.00, 0.00, 90.00);
	CreateDynamicObject(18450, 470.63, -2146.19, 72.00,   0.00, 48.00, 90.00);
	CreateDynamicObject(1634, 471.09, -2175.11, 100.23,   0.00, 0.00, 0.00);
	CreateDynamicObject(18985, 319.92, -2746.05, 2.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(18813, -2236.73, -1652.46, 454.72,   0.00, 0.00, 0.00);
	CreateDynamicObject(18809, -2179.34, -1650.87, 400.00,   88.00, 0.00, 90.00);
	CreateDynamicObject(18822, -2229.00, 1775.00, -1650.00,   4.00, 0.00, -25.00);
	CreateDynamicObject(18822, -2225.00, 5076.00, -1630.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(18824, -2224.13, -1651.50, 410.54,   3.00, -47.00, 0.00);
	CreateDynamicObject(18809, -2129.85, -1650.89, 401.72,   88.00, 0.00, 90.00);
	CreateDynamicObject(18809, -2081.25, -1650.88, 403.30,   88.00, 0.00, 90.00);
	CreateDynamicObject(18809, -2031.70, -1650.90, 405.02,   88.00, 0.00, 90.00);
	CreateDynamicObject(18809, -1981.94, -1651.05, 406.76,   88.00, 0.00, 90.00);
	CreateDynamicObject(18841, 7962.72, -1703.21, 680.29,   0.00, 0.00, 0.00);
	CreateDynamicObject(18841, -1946.79, -1650.04, 393.52,   3.00, 171.00, 1.00);
	CreateDynamicObject(18815, -1970.39, -1649.86, 350.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(18985, -1970.31, -1649.76, 277.00,   90.00, 0.00, 0.00);
	CreateDynamicObject(18824, -1958.65, -1650.26, 207.24,   -1.00, -44.00, 0.00);
	CreateDynamicObject(18809, -1914.77, -1650.36, 192.36,   0.00, -84.00, 0.00);
	CreateDynamicObject(18985, -1841.92, -1652.08, 190.84,   179.00, 28.00, 88.00);
	CreateDynamicObject(18985, -1742.03, -1655.60, 192.56,   179.00, 28.00, 88.00);
	CreateDynamicObject(18990, -1681.73, -1658.65, 188.00,   6.00, 42.00, -184.00);
	CreateDynamicObject(18813, -1671.41, -1660.14, 90.00,   -1.00, -1.00, 4.00);
	CreateDynamicObject(18824, -1658.51, -1657.27, 45.47,   -2.00, -47.00, 18.00);
	CreateDynamicObject(18822, -1616.51, -1645.20, 41.04,   18.00, -113.00, 21.00);
	CreateDynamicObject(4101, 1779.19, -1375.00, 29.68,   0.00, 0.00, 180.00);
	CreateDynamicObject(5459, 1796.04, -1399.17, 13.62,   0.00, 0.00, 0.00);
	CreateDynamicObject(4003, 1794.43, -1313.87, 128.00,   0.00, 0.00, -180.00);
	CreateDynamicObject(3509, 1812.59, -1384.15, 12.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(3509, 1812.30, -1398.43, 12.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(3509, 1789.37, -1426.03, 12.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(3509, 1772.67, -1429.56, 11.98,   0.00, 0.00, 0.00);
	CreateDynamicObject(3509, 1742.90, -1429.16, 12.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, 1841.88, -1359.66, 7.44,   -90.00, 90.00, 0.00);
	CreateDynamicObject(12814, 1749.37, -1416.20, 12.54,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, 1735.32, -1376.22, 12.54,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, 1738.55, -1331.83, 12.52,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, 1766.16, -1329.99, 12.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, 1785.56, -1304.36, 12.51,   0.00, 0.00, -62.00);
	CreateDynamicObject(12814, 1821.96, -1295.72, 12.53,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, 1808.71, -1301.69, 12.53,   0.00, 0.00, 33.00);
	CreateDynamicObject(12814, 1806.09, -1320.29, 12.55,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, 1814.04, -1435.93, 2.78,   -23.00, 0.00, 90.00);
	CreateDynamicObject(12814, 1814.05, -1406.06, 2.78,   -23.00, 0.00, 90.00);
	CreateDynamicObject(12814, 1761.22, -1447.50, 12.45,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, 1800.67, -1440.36, 8.84,   0.00, 14.00, 0.00);
	CreateDynamicObject(4013, 1815.30, -1347.65, 28.58,   0.00, 0.00, -90.00);
	CreateDynamicObject(4013, 1790.32, -1331.56, 28.58,   0.00, 0.00, 0.00);
	CreateDynamicObject(4003, 1752.64, -1421.60, 30.00,   0.00, 0.00, -180.00);
	CreateDynamicObject(12814, 1837.47, -1418.10, -11.24,   -90.00, 0.00, -91.00);
	CreateDynamicObject(19379, -1415.32, 1012.08, 1048.02,   0.00, -90.00, 0.00);
	CreateDynamicObject(19379, -1411.42, 1026.52, 1048.02,   0.00, -90.00, 0.00);
	CreateDynamicObject(19379, -1388.88, 1030.55, 1048.02,   0.00, -90.00, 0.00);
	CreateDynamicObject(19379, -1387.29, 1011.04, 1048.02,   0.00, -90.00, 0.00);
	CreateDynamicObject(19379, -1415.09, 1043.01, 1048.02,   0.00, -90.00, 0.00);
	CreateDynamicObject(1617, -1382.37, 1004.29, 1055.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1382.41, 1020.66, 1035.00,   0.00, -90.00, 0.00);
	CreateDynamicObject(2614, -1382.45, 1021.19, 1053.00,   0.00, 0.00, -90.00);
	CreateDynamicObject(925, -1383.86, 1021.12, 1049.02,   0.00, 0.00, -180.00);
	CreateDynamicObject(925, -1383.25, 1023.85, 1049.02,   0.00, 0.00, -90.00);
	CreateDynamicObject(16641, -1384.52, 1054.23, 1049.40,   0.00, 0.00, -90.00);
	CreateDynamicObject(6959, -1382.43, 1060.36, 1035.00,   0.00, -90.00, 0.00);
	CreateDynamicObject(14826, -1413.52, 1019.86, 1048.70,   0.00, 0.00, -164.00);
	CreateDynamicObject(930, -1418.30, 1005.72, 1048.48,   0.00, 0.00, 135.00);
	CreateDynamicObject(11391, -1421.09, 1010.78, 1049.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(2775, -1407.97, 1033.44, 1050.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(11393, -1386.61, 1035.91, 1049.46,   0.00, 0.00, 0.00);
	CreateDynamicObject(2893, -1391.84, 1024.56, 1048.18,   -16.00, -15.00, 22.00);
	CreateDynamicObject(11391, -1421.11, 1040.76, 1049.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(930, -1386.83, 1022.06, 1048.48,   0.00, 0.00, 18.00);
	CreateDynamicObject(17940, -1384.26, 1033.51, 1057.00,   0.00, 0.00, 91.00);
	CreateDynamicObject(1634, 174.23, -1824.84, 4.23,   0.00, 0.00, 90.00);
	CreateDynamicObject(1634, 169.53, -1824.85, 7.71,   20.00, 0.00, 90.00);
	CreateDynamicObject(1634, 166.35, -1824.86, 12.01,   35.00, 0.00, 90.00);
	CreateDynamicObject(1634, 164.32, -1824.85, 17.14,   50.00, 0.00, 90.00);
	CreateDynamicObject(1634, 163.71, -1824.86, 22.54,   65.00, 0.00, 90.00);
	CreateDynamicObject(1634, 164.51, -1824.85, 27.87,   80.00, 0.00, 90.00);
	CreateDynamicObject(1634, 166.67, -1824.85, 33.26,   95.00, 0.00, 90.00);
	CreateDynamicObject(4867, 317.05, -2104.38, 74.99,   0.00, 0.00, 0.00);
	CreateDynamicObject(18450, 212.29, -1824.85, 28.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(5005, 211.56, -2098.14, 78.47,   0.00, 0.00, 90.00);
	CreateDynamicObject(5005, 293.92, -2014.27, 78.47,   0.00, 0.00, 180.00);
	CreateDynamicObject(5005, 423.21, -2112.77, 78.47,   0.00, 0.00, 270.00);
	CreateDynamicObject(5005, 339.46, -2195.45, 78.55,   0.00, 0.00, 0.00);
	CreateDynamicObject(1634, 385.03, -2121.69, 76.07,   0.00, 0.00, 343.99);
	CreateDynamicObject(1634, 387.98, -2122.87, 76.07,   0.00, 0.00, 331.99);
	CreateDynamicObject(1634, 390.75, -2124.65, 76.07,   0.00, 0.00, 321.99);
	CreateDynamicObject(1634, 393.29, -2127.04, 76.07,   0.00, 0.00, 311.98);
	CreateDynamicObject(1634, 395.54, -2129.91, 76.07,   0.00, 0.00, 303.98);
	CreateDynamicObject(1634, 397.34, -2133.01, 76.07,   0.00, 0.00, 295.98);
	CreateDynamicObject(1634, 399.07, -2136.57, 76.07,   0.00, 0.00, 295.97);
	CreateDynamicObject(1634, 400.39, -2139.82, 76.07,   0.00, 0.00, 287.97);
	CreateDynamicObject(1634, 401.22, -2143.25, 76.07,   0.00, 0.00, 279.97);
	CreateDynamicObject(1634, 401.62, -2146.80, 76.07,   0.00, 0.00, 271.96);
	CreateDynamicObject(1634, 401.52, -2150.42, 76.07,   0.00, 0.00, 263.96);
	CreateDynamicObject(1634, 400.89, -2154.01, 76.07,   0.00, 0.00, 255.96);
	CreateDynamicObject(1634, 399.75, -2157.49, 76.07,   0.00, 0.00, 247.95);
	CreateDynamicObject(1634, 398.18, -2160.67, 76.07,   0.00, 0.00, 239.95);
	CreateDynamicObject(1634, 396.16, -2163.66, 76.07,   0.00, 0.00, 231.95);
	CreateDynamicObject(1634, 350.96, -2143.54, 76.07,   0.00, 0.00, 79.88);
	CreateDynamicObject(1634, 351.82, -2140.08, 76.07,   0.00, 0.00, 71.88);
	CreateDynamicObject(1634, 353.21, -2136.70, 76.07,   0.00, 0.00, 63.87);
	CreateDynamicObject(1634, 355.02, -2133.56, 76.07,   0.00, 0.00, 55.87);
	CreateDynamicObject(1634, 357.24, -2130.74, 76.07,   0.00, 0.00, 47.87);
	CreateDynamicObject(1634, 359.80, -2128.32, 76.07,   0.00, 0.00, 39.86);
	CreateDynamicObject(1634, 362.68, -2126.27, 76.07,   0.00, 0.00, 31.86);
	CreateDynamicObject(1634, 365.85, -2124.61, 76.07,   0.00, 0.00, 23.85);
	CreateDynamicObject(13641, 217.40, -2198.53, 76.67,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 217.53, -2215.43, 81.91,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 217.62, -2232.53, 87.19,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 217.88, -2249.61, 92.51,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 218.01, -2266.72, 97.84,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 218.07, -2283.73, 103.09,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 218.25, -2300.93, 108.36,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 218.50, -2317.92, 113.74,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 218.51, -2335.04, 119.14,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 218.50, -2352.08, 124.51,   0.00, 0.00, 268.99);
	CreateDynamicObject(13641, 218.68, -2368.99, 129.91,   0.00, 0.00, 268.99);
	CreateDynamicObject(18450, 470.64, -2093.97, 14.00,   0.00, 48.00, 90.00);
	CreateDynamicObject(1634, 470.88, -2088.47, 10.89,   325.00, 0.00, 0.00);
	CreateDynamicObject(1634, 470.88, -2084.77, 10.99,   340.00, 0.00, 0.00);
	CreateDynamicObject(1634, 470.88, -2079.23, 12.64,   0.00, 0.00, 0.00);
	CreateDynamicObject(1634, 470.88, -2076.30, 15.19,   20.00, 0.00, 0.00);
	CreateDynamicObject(1634, 470.88, -2073.10, 19.52,   35.00, 0.00, 0.00);
	CreateDynamicObject(18450, 240.85, -2233.30, 88.29,   0.00, 20.00, 90.00);
	CreateDynamicObject(18450, 240.85, -2308.46, 115.64,   0.00, 20.00, 90.00);
	CreateDynamicObject(18450, 219.00, -2421.70, 133.36,   0.00, 0.00, 90.00);
	CreateDynamicObject(18450, 251.01, -2469.24, 133.36,   0.00, 0.00, 0.00);
	CreateDynamicObject(18450, 366.43, -2469.24, 114.75,   0.00, 20.00, 0.00);
	CreateDynamicObject(19005, 370.67, -1760.62, 12.80,   0.00, 0.00, 0.00);
	CreateDynamicObject(19005, 370.46, -1741.47, 12.76,   0.00, 0.00, -180.00);
	CreateDynamicObject(19005, 327.83, -2467.99, 127.78,   3.00, 0.00, 91.00);
	CreateDynamicObject(19005, 285.37, -2469.12, 133.00,   -5.00, 0.00, -90.00);
	CreateDynamicObject(1634, 470.91, -2170.49, 98.90,   32.00, 0.00, -180.00);
	CreateDynamicObject(12814, -1404.65, 1004.43, 1048.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1401.29, 1060.17, 1048.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1401.29, 1020.46, 1048.06,   0.00, 0.00, 0.00);
	CreateDynamicObject(977, -1407.54, 979.60, 1049.60,   0.00, 0.00, 12.00);
	CreateDynamicObject(977, -1403.63, 979.60, 1049.60,   0.00, 0.00, 190.00);
	CreateDynamicObject(977, -1403.84, 979.57, 1049.60,   0.00, 0.00, 12.00);
	CreateDynamicObject(977, -1399.92, 979.61, 1049.60,   0.00, 0.00, 190.00);
	CreateDynamicObject(977, -1407.38, 979.62, 1049.60,   0.00, 0.00, 190.00);
	CreateDynamicObject(977, -1411.28, 979.62, 1049.60,   0.00, 0.00, 12.00);
	CreateDynamicObject(12814, -1391.11, 975.63, 1038.00,   0.00, 90.00, 178.00);
	CreateDynamicObject(4828, 1766.05, -1379.28, 36.00,   0.00, 0.00, 24.00);
	CreateDynamicObject(9953, 1778.98, -1380.14, 25.54,   0.00, 0.00, -87.00);
	CreateDynamicObject(4013, 1748.67, -1341.65, 28.58,   0.00, 0.00, 90.00);
	CreateDynamicObject(12814, 1822.44, -1345.39, 12.53,   0.00, 0.00, 180.00);
	CreateDynamicObject(12814, 1781.56, -1420.93, 12.44,   0.00, 0.00, 0.00);
	CreateDynamicObject(12814, 1794.99, -1421.16, 2.78,   -23.00, 0.00, -19.00);
	CreateDynamicObject(12814, 1837.70, -1388.71, -11.18,   -90.00, 0.00, -90.00);
	CreateDynamicObject(17936, -1419.01, 1046.40, 1057.00,   0.00, 0.00, -90.00);
	CreateDynamicObject(4882, -1400.65, 1084.47, 1044.74,   0.00, 0.00, 0.00);
	CreateDynamicObject(2692, -1393.97, 1007.19, 1048.76,   0.00, 0.00, -47.00);
	CreateDynamicObject(3281, -1410.28, 1034.69, 1055.40,   0.00, -180.00, 0.00);
	CreateDynamicObject(2659, -1397.32, 1019.16, 1055.40,   0.00, 0.00, 178.00);
	CreateDynamicObject(2660, -1405.56, 1025.51, 1048.40,   0.00, 0.00, 0.00);
	CreateDynamicObject(6959, -1421.95, 1020.44, 1035.00,   0.00, -90.00, 0.00);
	CreateDynamicObject(6959, -1422.00, 1060.45, 1035.00,   0.00, -90.00, 0.00);
	CreateDynamicObject(18999, 95.13, -1745.35, 84.49,   56.16, -90.72, -0.66);
	CreateDynamicObject(18828, -65.40, -1599.83, 156.54,   0.00, 0.00, -85.44);
	CreateDynamicObject(18817, -27.19, -1751.20, 83.97,   85.92, -177.96, 359.27);
	CreateDynamicObject(18990, -22.59, -1779.24, 84.76,   91.56, -1.38, 45.12);
	CreateDynamicObject(18985, 38.34, -1784.68, 84.47,   0.00, 0.00, -90.54);
	CreateDynamicObject(19130, 273.42, -2069.16, 8.19,   0.00, 84.00, -61.02);
	CreateDynamicObject(19130, 270.04, -2061.73, 8.21,   0.00, 84.00, -61.80);
	CreateDynamicObject(19130, 268.24, -2056.76, 8.14,   0.00, 84.00, -105.96);
	CreateDynamicObject(19130, 272.16, -2052.10, 8.19,   0.00, 84.00, -105.96);
	CreateDynamicObject(1217, 407.47, -2133.33, -0.51,   -20.16, -88.08, 0.00);
	CreateDynamicObject(19130, 745.36, -2118.28, 15.97,   -177.30, 88.56, 87.60);
	CreateDynamicObject(19130, 744.24, -2122.46, 17.64,   -177.30, 88.56, 180.67);
	CreateDynamicObject(18985, 135.14, -1786.96, 86.02,   1.74, 29.10, -91.68);
	CreateDynamicObject(18828, -61.63, -1590.32, 300.32,   -175.32, 7.62, -85.44);
	CreateDynamicObject(18828, -80.43, -1580.50, 468.47,   0.00, 0.00, -85.44);
	CreateDynamicObject(18843, -169.83, -1624.81, 546.06,   4.08, -89.28, 0.00);
	CreateDynamicObject(18809, -96.62, -1624.81, 545.08,   -6.00, -88.68, 0.00);
	CreateDynamicObject(18843, -267.94, -1624.99, 549.02,   4.08, -87.30, 0.00);
	CreateDynamicObject(18855, 198.37, -1819.82, 14.64,   -106.00, 176.00, 179.00);
	CreateDynamicObject(18450, 443.99, -2469.24, 101.07,   0.00, 0.00, 0.00);
	CreateDynamicObject(18450, 470.88, -2421.31, 101.07,   0.00, 0.00, 90.00);
	CreateDynamicObject(18450, 470.88, -2227.52, 101.07,   0.00, 0.00, 90.00);
	CreateDynamicObject(18450, 470.88, -2341.39, 101.07,   0.00, 0.00, 90.00);
	CreateDynamicObject(1634, 470.88, -2190.38, 100.23,   0.00, 0.00, 0.00);
	CreateDynamicObject(1634, 470.84, -2183.96, 100.23,   0.00, 0.00, 180.00);
	CreateDynamicObject(1634, 470.88, -2297.08, 102.48,   0.00, 0.00, 0.00);
	CreateDynamicObject(1634, 470.88, -2268.14, 102.48,   0.00, 0.00, 180.00);
	CreateDynamicObject(1634, 470.88, -2464.54, 100.23,   0.00, 0.00, 0.00);
	CreateDynamicObject(1634, 470.84, -2458.12, 100.23,   0.00, 0.00, 180.00);
	CreateDynamicObject(1633, 403.19, -2469.24, 101.62,   0.00, 0.00, 90.00);
	CreateDynamicObject(1634, 219.00, -2458.71, 132.52,   0.00, 0.00, 180.00);
	CreateDynamicObject(18450, 240.85, -2421.70, 133.36,   0.00, 0.00, 90.00);
	CreateDynamicObject(1634, 240.85, -2458.71, 132.52,   0.00, 0.00, 179.99);
	CreateDynamicObject(3818, 1248.16, -933.73, 46.36,   0.00, 0.00, 96.00);
	CreateDynamicObject(4550, 153.61, -1949.40, -111.44,   0.00, 0.00, 0.00);
	CreateDynamicObject(4726, 153.48, -1949.64, 98.33,   0.00, 0.00, 0.00);
	CreateDynamicObject(4727, 153.53, -1949.90, 98.40,   0.00, 0.00, 0.00);
	CreateDynamicObject(3036, 159.85, -1968.63, 7.86,   86.58, -81.06, 0.00);
	CreateDynamicObject(3036, 155.67, -1968.87, 9.51,   86.58, -81.06, 0.00);
	CreateDynamicObject(3036, 150.72, -1968.80, 10.90,   86.58, -81.06, 0.00);
	CreateDynamicObject(3036, 155.59, -1968.83, 13.42,   92.28, -83.82, 359.87);
	CreateDynamicObject(3036, 151.89, -1969.48, 26.55,   86.58, -81.06, 359.87);
	CreateDynamicObject(3036, 155.98, -1968.70, 28.70,   86.58, -81.06, 359.87);
	CreateDynamicObject(3036, 160.65, -1967.71, 30.55,   86.58, -81.06, 359.87);
	CreateDynamicObject(3036, 155.46, -1968.74, 32.54,   86.58, -81.06, 359.75);
	CreateDynamicObject(3036, 155.62, -1968.75, 36.21,   86.58, -81.06, 359.75);
	CreateDynamicObject(3036, 150.60, -1969.04, 34.19,   86.58, -81.06, 359.75);
	CreateDynamicObject(8853, 150.88, -1969.65, 57.61,   -24.36, -3.36, -81.84);
	CreateDynamicObject(8853, 135.12, -1966.72, 65.15,   -24.36, -3.36, -118.02);
	CreateDynamicObject(8853, 126.87, -1954.12, 72.53,   -24.36, -3.36, -178.26);
	CreateDynamicObject(3615, 174.04, -1967.11, 1.76,   356.86, 0.00, 86.60);
	CreateDynamicObject(8853, 130.93, -1937.08, 80.55,   -24.36, -3.36, -208.74);
	CreateDynamicObject(8853, 143.39, -1926.50, 88.45,   -24.36, -3.36, 108.99);
	CreateDynamicObject(8853, 160.50, -1926.28, 96.70,   -24.36, -3.36, 71.67);
	CreateDynamicObject(8853, 153.55, -1931.75, 88.45,   -24.36, -3.36, 190.71);
	CreateDynamicObject(2974, 164.21, -1932.58, 95.06,   0.00, 0.00, 51.36);
	CreateDynamicObject(2974, 166.15, -1934.11, 95.06,   0.00, 0.00, 51.36);
	CreateDynamicObject(2974, 168.14, -1935.65, 95.06,   0.00, 0.00, 51.36);
	CreateDynamicObject(2974, 170.04, -1937.15, 95.06,   0.00, 0.00, 51.36);
	CreateDynamicObject(2974, 158.92, -1969.90, 35.67,   0.00, 0.00, 7.20);
	CreateDynamicObject(2974, 160.43, -1969.61, 36.70,   0.00, 0.00, 7.20);
	CreateDynamicObject(2974, 161.90, -1969.43, 37.56,   0.00, 0.00, 7.20);
	CreateDynamicObject(3939, 164.98, -1967.20, 39.90,   0.00, 0.00, 106.86);
	CreateDynamicObject(3036, 168.23, -1965.46, 43.20,   86.58, -81.06, 5.90);
	CreateDynamicObject(3036, 164.50, -1966.55, 45.43,   86.58, -81.06, 5.90);
	CreateDynamicObject(3036, 168.51, -1964.49, 46.87,   86.58, -81.06, 5.90);
	CreateDynamicObject(3036, 164.63, -1966.50, 49.00,   86.58, -81.06, 6.97);
	CreateDynamicObject(3036, 168.09, -1964.89, 51.37,   86.58, -81.06, 6.97);
	CreateDynamicObject(11544, 165.69, -1970.31, 14.43,   0.00, 0.00, -84.42);
	CreateDynamicObject(11544, 164.22, -1980.00, 16.77,   0.00, 0.00, 186.77);
	CreateDynamicObject(11544, 154.65, -1978.61, 18.94,   0.00, 0.00, 99.23);
	CreateDynamicObject(11544, 147.85, -1979.80, 21.75,   0.00, 0.00, 99.23);
	CreateDynamicObject(11544, 147.85, -1979.80, 21.75,   0.00, 0.00, 99.23);
	CreateDynamicObject(11544, 147.85, -1979.80, 21.75,   0.00, 0.00, 99.23);
	CreateDynamicObject(18990, -2244.08, -1567.22, 422.00,   0.00, -40.00, -4.00);
	CreateDynamicObject(18985, -2185.10, -1554.95, 416.52,   0.00, 0.00, 105.00);
	CreateDynamicObject(18985, -2091.66, -1522.46, 416.52,   0.00, 0.00, 113.00);
	CreateDynamicObject(18985, -2000.44, -1483.78, 416.52,   0.00, 0.00, 113.00);
	CreateDynamicObject(18985, -1910.10, -1445.51, 416.52,   0.00, 0.00, 113.00);
	CreateDynamicObject(18985, -1818.92, -1406.77, 416.52,   0.00, 0.00, 113.00);
	CreateDynamicObject(18985, -1729.06, -1368.69, 416.52,   0.00, 0.00, 113.00);
	CreateDynamicObject(18985, -1638.40, -1330.18, 416.52,   0.00, 0.00, 113.00);
	CreateDynamicObject(18990, -1583.25, -1305.10, 412.22,   0.00, 47.00, -149.00);
	CreateDynamicObject(18813, -1578.87, -1302.50, 333.00,   0.00, 0.00, 0.00);
	CreateDynamicObject(18985, -1578.12, -1302.70, 258.00,   -91.00, 4.00, 84.00);
	CreateDynamicObject(18841, -1575.89, -1318.18, 197.00,   3.00, -93.00, 98.00);
	CreateDynamicObject(18841, -1570.26, -1351.27, 216.00,   3.00, 84.00, 98.00);
	CreateDynamicObject(18841, -1567.21, -1381.18, 195.00,   3.00, -93.00, 98.00);
	CreateDynamicObject(6948, 1201.95, -1017.38, 55.98,   0.00, 180.00, 270.00);

	CreateObject(1634, 240.88, -2465.14, 132.52,   0.00, 0.00, 0.00);
	CreateObject(1634, 240.85, -2378.17, 134.77,   0.00, 0.00, 0.00);
	CreateObject(1634, 240.85, -2349.60, 132.10,   20.00, 0.00, 180.00);
	CreateObject(1634, 235.64, -1873.22, 2.59,   0.00, 0.00, 270.00);
	CreateObject(1634, 255.42, -1873.22, 2.26,   0.00, 0.00, 90.00);
	CreateObject(1634, 279.59, -1873.22, 2.59,   0.00, 0.00, 270.00);
	CreateObject(7979, 577.91, -1855.15, 5.44,   0.00, 0.00, 90.00);
	CreateObject(10771, 224.30, -2004.00, 4.10,   0.00, 0.00, 220.00);
	CreateObject(11145, 274.20, -1962.30, 3.20,   0.00, 0.00, 220.00);
	CreateObject(10770, 217.70, -1999.60, 37.30,   0.00, 0.00, 220.00);
	CreateObject(11237, 217.10, -1999.30, 37.10,   0.00, 0.00, 220.00);
	CreateObject(3114, 288.70, -1926.80, 15.40,   0.00, 0.00, 40.00);
	CreateObject(3115, 300.30, -1940.40, 15.60,   0.00, 0.00, 40.00);
	CreateObject(11095, 318.00, -1898.48, 12.30,   0.00, 0.00, 332.00);
	CreateObject(11302, 292.30, -1917.20, 4.70,   0.00, 0.00, 348.00);
	CreateObject(18450, 359.90, -1921.90, 0.10,   0.00, 0.00, 92.00);
	CreateObject(4726, 338.60, -1853.16, 5.92,   0.00, 0.00, 270.00);
	CreateObject(16778, 1201.00, -918.10, 50.30,   0.00, 0.00, 88.00);
	CreateObject(16778, 332.90, -1867.30, 15.80,   0.00, 0.00, 199.99);
	CreateObject(16782, 334.89, -1866.12, 10.10,   0.00, 0.00, 64.00);
	CreateObject(16782, 1203.40, -919.30, 43.30,   0.00, 0.00, 275.99);
	CreateObject(3586, 1191.10, -925.40, 46.40,   0.00, 0.00, 188.00);
	CreateObject(10309, 352.10, -1944.60, 0.00,   0.00, 0.00, 224.00);
	CreateObject(9958, 275.20, -1911.40, 7.20,   0.00, 0.00, 90.00);
	CreateObject(13593, 1192.20, -933.40, 42.50,   0.00, 0.00, 6.00);
	CreateObject(8556, 57.70, -1532.40, 8.70,   0.00, 0.00, 82.00);
	CreateObject(7096, 326.80, -1835.90, 8.30,   0.00, 0.00, 268.00);
	CreateObject(18449, 119.40, -2097.90, 15.30,   0.00, 0.00, 40.00);
	CreateObject(6189, 1284.70, -985.60, 68.80,   0.00, 0.00, 0.00);
	CreateObject(6189, 1284.50, -1111.90, 69.00,   0.00, 0.00, 0.00);
	CreateObject(1856, -0.02, 0.04, -0.20,   0.00, 0.00, 0.00);
	CreateObject(18750, 276.46, -1855.13, 56.00,   92.00, -244.00, 4.00);
	CreateObject(18985, 321.00, 2627.00, -2065.00,   0.00, 0.00, 0.00);
	CreateObject(18985, 319.94, -2055.37, 2.00,   0.00, 0.00, 0.00);
	CreateObject(18985, 319.90, -2154.64, 2.00,   0.00, 0.00, 0.00);
	CreateObject(18985, 319.93, -2254.32, 2.00,   0.00, 0.00, 0.00);
	CreateObject(18985, 319.90, -2347.57, 2.00,   0.00, 0.00, 0.00);
	CreateObject(18985, 319.90, -2447.32, 2.00,   0.00, 0.00, 0.00);
	CreateObject(18985, 319.89, -2547.27, 2.00,   0.00, 0.00, 0.00);
	CreateObject(18985, 319.90, -2646.85, 2.00,   0.00, 0.00, 0.00);
	CreateObject(18780, 211.42, -1782.86, 15.02,   0.00, 0.00, -178.00);
	CreateObject(18822, 289.02, -1863.30, 10.72,   -9.00, -105.00, 0.00);
	CreateObject(18822, 332.87, -1861.40, 29.72,   0.00, 69.00, 2.00);
	CreateObject(18778, -2278.37, -1653.98, 481.98,   -18.00, 1.00, -98.00);
	CreateObject(18778, -2276.08, -1638.38, 482.22,   -18.00, 1.00, -98.00);
	CreateObject(18778, -2272.66, -1678.17, 479.98,   -20.00, 3.00, -53.00);
	CreateObject(18778, -2280.22, -1668.10, 481.36,   -18.00, 1.00, -91.00);
	CreateObject(18750, -2207.40, -1649.17, 520.00,   91.00, 0.00, -91.00);
	CreateObject(19335, -2266.99, -1668.64, 500.00,   0.00, 0.00, 0.00);
	CreateObject(6959, -2285.01, -1587.19, 482.00,   0.00, 0.00, 33.00);
	CreateObject(1232, 391.77, -1807.43, 17.00,   0.00, 0.00, 0.00);
	CreateObject(19335, 295.35, -1813.17, 22.00,   0.00, 0.00, 0.00);
	CreateObject(13562, 374.79, -1841.44, 13.19,   0.00, 0.00, 0.00);
	CreateObject(18816, -2247.84, -1567.06, 456.92,   0.00, 0.00, 0.00);
	CreateObject(18847, 63.63, -1828.78, 24.00,   0.00, 0.00, 0.00);
	CreateObject(18784, 194.98, -1848.84, 4.76,   0.00, -2.00, -178.00);
	CreateObject(18784, 194.28, -1828.81, 4.76,   0.00, -2.00, -178.00);
	CreateObject(18784, 193.65, -1808.77, 4.76,   0.00, -2.00, -178.00);
	CreateObject(18784, 174.26, -1821.73, 4.76,   0.00, -2.00, 2.00);
	CreateObject(18784, 174.96, -1841.66, 4.76,   0.00, -2.00, 2.00);
	CreateObject(16613, 158.29, -1912.39, -25.00,   141.00, 120.00, -11.00);
	CreateObject(13592, 283.60, -2016.70, 6.00,   0.00, 0.00, 34.00);
	CreateObject(18749, 2113.11, -2459.13, 15.05,   0.00, 0.00, 0.00);
	CreateObject(18749, 2121.68, -2451.99, 15.05,   0.00, 0.00, 0.00);
	CreateObject(18749, 2225.79, -2458.53, 41.11,   0.00, 0.00, 0.00);
	CreateObject(18824, 374.36, -1873.11, 40.88,   127.00, 55.00, 164.00);
	CreateObject(18809, 386.20, -1911.96, 62.80,   -120.00, -18.00, -18.00);
	CreateObject(18809, 387.22, -1960.17, 77.50,   -96.00, -18.00, -18.00);
	CreateObject(18809, 387.32, -2010.03, 79.58,   -89.00, -18.00, -18.00);
	CreateObject(712, 311.84, -1819.53, 11.00,   0.00, 0.00, 0.00);
	CreateObject(712, 350.94, -1842.71, 11.00,   0.00, 0.00, 0.00);
	CreateObject(712, 323.93, -1847.59, 11.00,   0.00, 0.00, 0.00);
	CreateObject(712, 340.90, -1835.57, 11.00,   0.00, 0.00, 0.00);
	CreateObject(9314, -1394.33, 1078.37, 1049.74,   0.00, 0.00, -90.00);
	CreateObject(5402, -1293.61, 980.90, 1029.90,   0.00, 0.00, -142.00);
	CreateObject(12814, -1417.84, 975.54, 1038.00,   0.00, 90.00, 2.00);
	CreateObject(12814, -1408.52, 979.65, 1038.00,   0.00, 90.00, 90.00);
	CreateObject(2614, -1421.77, 1024.45, 1053.00,   0.00, 0.00, 91.00);
	CreateObject(4003, 1825.88, -1373.77, 30.00,   0.00, 0.00, -180.00);
	CreateObject(12814, -1406.64, 985.67, 1053.00,   0.00, 180.00, 90.00);
	CreateObject(12814, -1365.28, 1000.62, 1038.00,   0.00, 90.00, 90.00);
	CreateObject(12814, -1443.71, 1000.50, 1038.00,   0.00, 90.00, 90.00);
	CreateObject(1617, -1421.90, 1035.43, 1055.00,   0.00, 0.00, 180.00);
	CreateObject(3458, 1244.63, -984.98, 53.59,   0.00, 0.00, 91.00);
	CreateObject(11544, 149.29, -1970.25, 25.00,   0.00, 0.00, 6.47);
	CreateObject(16303, 128.06, -1847.88, -3.77,   0.00, 0.00, 14.82);
	CreateObject(16303, 128.06, -1847.88, -3.02,   0.00, 0.00, 14.82);
	CreateObject(18855, 259.72, -1787.98, 55.84,   0.00, 0.00, 179.42);
	CreateObject(18819, 208.89, -1787.97, 87.61,   91.62, -0.54, 181.69);
	CreateObject(18990, 204.08, -1752.27, 85.85,   94.56, -0.24, 223.67);
	CreateObject(712, 353.24, -1865.05, 11.00,   0.00, 0.00, 0.00);
	CreateObject(4867, 317.05, -2104.38, 74.97,   0.00, 180.00, 0.00);
	CreateObject(712, 322.26, -1860.23, 11.00,   0.00, 0.00, 0.00);
	CreateObject(2785, 1204.47, -924.73, 43.00,   0.00, 0.00, 190.00);
	CreateObject(6948, 1201.96, -1017.37, 54.14,   0.00, -180.00, 270.00);
	CreateObject(19005, 1276.57, -1170.39, 86.18,   0.00, 0.00, -180.00);
	CreateObject(19005, 1288.75, -1170.51, 86.18,   0.00, 0.00, -180.00);
	CreateObject(4726, 338.66, -1853.21, 5.20,   0.00, -180.00, 270.20);
	CreateObject(1225, 330.25, -1858.89, 4.90,   0.00, 0.00, 0.00);
	CreateObject(1225, 328.47, -1858.90, 4.90,   0.00, 0.00, 0.00);
	return 1;
}

RemoveFirstQueueFloor()
{
	for(new i; i < sizeof(ElevatorQueue) - 1; i ++)
	    ElevatorQueue[i] = ElevatorQueue[i + 1];

	ElevatorQueue[sizeof(ElevatorQueue) - 1] = INVALID_FLOOR;
	return 1;
}

AddFloorToQueue(floorid)
{
	new slot = -1;
	for(new i; i < sizeof(ElevatorQueue); i ++)
	{
	    if(ElevatorQueue[i] == INVALID_FLOOR)
	    {
	        slot = i;
	        break;
	    }
	}

	if(slot != -1)
	{
	    ElevatorQueue[slot] = floorid;

	    if(ElevatorState == ELEVATOR_STATE_IDLE)
	        ReadNextFloorInQueue();

	    return 1;
	}
	return 0;
}

ResetElevatorQueue()
{
	for(new i; i < sizeof(ElevatorQueue); i ++)
	{
	    ElevatorQueue[i] 	= INVALID_FLOOR;
	    FloorRequestedBy[i] = INVALID_PLAYER_ID;
	}
	return 1;
}

IsFloorInQueue(floorid)
{
	for(new i; i < sizeof(ElevatorQueue); i ++)
	    if(ElevatorQueue[i] == floorid)
	        return 1;

	return 0;
}

ReadNextFloorInQueue()
{
	if(ElevatorState != ELEVATOR_STATE_IDLE || ElevatorQueue[0] == INVALID_FLOOR)
	    return 0;

	Elevator_CloseDoors();
	Floor_CloseDoors(ElevatorFloor);
	return 1;
}

DidPlayerRequestElevator(playerid)
{
	for(new i; i < sizeof(FloorRequestedBy); i ++)
	    if(FloorRequestedBy[i] == playerid)
	        return 1;

	return 0;
}

ShowElevatorDialog(playerid)
{
	new string[512];
	for(new i; i < sizeof(ElevatorQueue); i ++)
	{
	    if(FloorRequestedBy[i] != INVALID_PLAYER_ID)
	        strcat(string, "{FF0000}");

	    strcat(string, FloorNames[i]);
	    strcat(string, "\n");
	}

	ShowPlayerDialog(playerid, LIFT_DIALOG, DIALOG_STYLE_LIST, ""orange"NG-Stunting "white" - Admin Elevator", string, "Accept", "Cancel");
	return 1;
}

CallElevator(playerid, floorid)
{
	if(FloorRequestedBy[floorid] != INVALID_PLAYER_ID || IsFloorInQueue(floorid))
	    return 0;

	FloorRequestedBy[floorid] = playerid;
	AddFloorToQueue(floorid);
	return 1;
}

Elevator_Initialize()
{
	Obj_Elevator = CreateObject(18755, 1786.678100, -1303.459472, GROUND_Z_COORD + ELEVATOR_OFFSET, 0.000000, 0.000000, 270.000000);
	Obj_ElevatorDoors[0] = CreateObject(18757, X_DOOR_CLOSED, -1303.459472, GROUND_Z_COORD, 0.000000, 0.000000, 270.000000);
	Obj_ElevatorDoors[1] = CreateObject(18756, X_DOOR_CLOSED, -1303.459472, GROUND_Z_COORD, 0.000000, 0.000000, 270.000000);

	Label_Elevator = Create3DTextLabel("Press 'F' to use elevator", ORANGE, 1784.9822, -1302.0426, 13.6491, 4.0, 0, 1);

	new string[128],
		Float:z;

	for(new i; i < sizeof(Obj_FloorDoors); i ++)
	{
	    Obj_FloorDoors[i][0] = CreateObject(18757, X_DOOR_CLOSED, -1303.171142, GetDoorsZCoordForFloor(i), 0.000000, 0.000000, 270.000000);
		Obj_FloorDoors[i][1] = CreateObject(18756, X_DOOR_CLOSED, -1303.171142, GetDoorsZCoordForFloor(i), 0.000000, 0.000000, 270.000000);

		format(string, sizeof(string), "%s\nPress 'F' to call Elevator", FloorNames[i]);

		z = (i == 0) ? (13.4713) : (13.4713 + 8.7396 + ((i-1) * 5.45155));

		Label_Floors[i] = Create3DTextLabel(string, RED, 1783.9799, -1300.7660, z, 10.5, 0, 1);
	}

	Floor_OpenDoors(0);
	Elevator_OpenDoors();
	return 1;
}

DestroyElevator()
{
	DestroyObject(Obj_Elevator);
	DestroyObject(Obj_ElevatorDoors[0]);
	DestroyObject(Obj_ElevatorDoors[1]);
	Delete3DTextLabel(Label_Elevator);

	for(new i; i < sizeof(Obj_FloorDoors); i ++)
	{
	    DestroyObject(Obj_FloorDoors[i][0]);
		DestroyObject(Obj_FloorDoors[i][1]);
		Delete3DTextLabel(Label_Floors[i]);
	}
	return 1;
}

Elevator_OpenDoors()
{
	new Float:POS[3];
	GetObjectPos(Obj_ElevatorDoors[0], POS[0], POS[1], POS[2]);
	MoveObject(Obj_ElevatorDoors[0], X_DOOR_L_OPENED, POS[1], POS[2], DOORS_SPEED);
	MoveObject(Obj_ElevatorDoors[1], X_DOOR_R_OPENED, POS[1], POS[2], DOORS_SPEED);
	return 1;
}

Elevator_CloseDoors()
{
    if(ElevatorState == ELEVATOR_STATE_MOVING)
    	return 0;
    new Float:POS[3];
	GetObjectPos(Obj_ElevatorDoors[0], POS[0], POS[1], POS[2]);
	MoveObject(Obj_ElevatorDoors[0], X_DOOR_CLOSED, POS[1], POS[2], DOORS_SPEED);
	MoveObject(Obj_ElevatorDoors[1], X_DOOR_CLOSED, POS[1], POS[2], DOORS_SPEED);
	return 1;
}

Floor_OpenDoors(floorid)
{
    MoveObject(Obj_FloorDoors[floorid][0], X_DOOR_L_OPENED, -1303.171142, GetDoorsZCoordForFloor(floorid), DOORS_SPEED);
	MoveObject(Obj_FloorDoors[floorid][1], X_DOOR_R_OPENED, -1303.171142, GetDoorsZCoordForFloor(floorid), DOORS_SPEED);
	return 1;
}

Floor_CloseDoors(floorid)
{
    MoveObject(Obj_FloorDoors[floorid][0], X_DOOR_CLOSED, -1303.171142, GetDoorsZCoordForFloor(floorid), DOORS_SPEED);
	MoveObject(Obj_FloorDoors[floorid][1], X_DOOR_CLOSED, -1303.171142, GetDoorsZCoordForFloor(floorid), DOORS_SPEED);
	return 1;
}

Elevator_MoveToFloor(floorid)
{
	ElevatorState = ELEVATOR_STATE_MOVING;
	ElevatorFloor = floorid;

	MoveObject(Obj_Elevator, 1786.678100, -1303.459472, GetElevatorZCoordForFloor(floorid), 0.5);
    MoveObject(Obj_ElevatorDoors[0], X_DOOR_CLOSED, -1303.459472, GetDoorsZCoordForFloor(floorid), 0.5);
    MoveObject(Obj_ElevatorDoors[1], X_DOOR_CLOSED, -1303.459472, GetDoorsZCoordForFloor(floorid), 0.5);
    Delete3DTextLabel(Label_Elevator);

	ElevatorBoostTimer = SetTimerEx("Elevator_Boost", 2000, false, "i", floorid);

	return 1;
}

GetPosInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	if(IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

GetVehicleModelID(vehiclename[])
{
	for(new i = 0; i < 211; i++)
	{
		if(strfind(VehicleNames[i], vehiclename, true) != -1)
		return i + 400;
	}
	return INVALID_VEHICLE_ID;
}

RandomSpawn(playerid)
{
	new rand = random(4);
	SetPlayerPosEx(playerid, WorldSpawns[rand][0], WorldSpawns[rand][1], floatadd(WorldSpawns[rand][2], 4.5));
	SetPlayerFacingAngle(playerid, WorldSpawns[rand][3]);
	SetCameraBehindPlayer(playerid);
	return 1;
}

RandomBGSpawn(playerid, Map, Team)
{
	SetPlayerHealth(playerid, 100.0);
	switch(Map)
	{
	    case BG_MAP1:
	    {
	        switch(Team)
	        {
	            case BG_TEAM1:
	            {
			        new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M1_T1_Spawns[BGSpawn][0], BG_M1_T1_Spawns[BGSpawn][1], floatadd(BG_M1_T1_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M1_T1_Spawns[BGSpawn][3]);
				}
	            case BG_TEAM2:
	            {
    				new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M1_T2_Spawns[BGSpawn][0], BG_M1_T2_Spawns[BGSpawn][1], floatadd(BG_M1_T2_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M1_T2_Spawns[BGSpawn][3]);
	            }
			}
	    }
	    case BG_MAP2:
	    {
	        switch(Team)
	        {
	            case BG_TEAM1:
	            {
			        new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M2_T1_Spawns[BGSpawn][0], BG_M2_T1_Spawns[BGSpawn][1], floatadd(BG_M2_T1_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M2_T1_Spawns[BGSpawn][3]);
				}
	            case BG_TEAM2:
	            {
    				new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M2_T2_Spawns[BGSpawn][0], BG_M2_T2_Spawns[BGSpawn][1], floatadd(BG_M2_T2_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M2_T2_Spawns[BGSpawn][3]);
	            }
			}
	    }
	    case BG_MAP3:
	    {
	        switch(Team)
	        {
	            case BG_TEAM1:
	            {
			        new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M3_T1_Spawns[BGSpawn][0], BG_M3_T1_Spawns[BGSpawn][1], floatadd(BG_M3_T1_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M3_T1_Spawns[BGSpawn][3]);
				}
	            case BG_TEAM2:
	            {
    				new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M3_T2_Spawns[BGSpawn][0], BG_M3_T2_Spawns[BGSpawn][1], floatadd(BG_M3_T2_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M3_T2_Spawns[BGSpawn][3]);
	            }
			}
	    }
   	    case BG_MAP4:
	    {
	        switch(Team)
	        {
	            case BG_TEAM1:
	            {
			        new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M4_T1_Spawns[BGSpawn][0], BG_M4_T1_Spawns[BGSpawn][1], floatadd(BG_M4_T1_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M4_T1_Spawns[BGSpawn][3]);
				}
	            case BG_TEAM2:
	            {
    				new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M4_T2_Spawns[BGSpawn][0], BG_M4_T2_Spawns[BGSpawn][1], floatadd(BG_M4_T2_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M4_T2_Spawns[BGSpawn][3]);
	            }
			}
	    }
	    case BG_MAP5:
	    {
	        switch(Team)
	        {
	            case BG_TEAM1:
	            {
			        new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M5_T1_Spawns[BGSpawn][0], BG_M5_T1_Spawns[BGSpawn][1], floatadd(BG_M5_T1_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M5_T1_Spawns[BGSpawn][3]);
				}
	            case BG_TEAM2:
	            {
    				new BGSpawn = random(4);
					SetPlayerPosEx(playerid, BG_M5_T2_Spawns[BGSpawn][0], BG_M5_T2_Spawns[BGSpawn][1], floatadd(BG_M5_T2_Spawns[BGSpawn][2], 4.5));
					SetPlayerFacingAngle(playerid, BG_M5_T2_Spawns[BGSpawn][3]);
	            }
			}
	    }
	}
	return 1;
}

IsNumeric(string[])
{
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		if(string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

RandomWeapon(playerid)
{
	ResetPlayerWeapons(playerid);

	switch(random(8)) // melee
	{
	    case 0: GivePlayerWeapon(playerid, 2, 1);
	    case 1: GivePlayerWeapon(playerid, 3, 1);
	    case 2: GivePlayerWeapon(playerid, 4, 1);
	    case 3: GivePlayerWeapon(playerid, 5, 1);
	    case 4: GivePlayerWeapon(playerid, 6, 1);
	    case 5: GivePlayerWeapon(playerid, 7, 1);
	    case 6: GivePlayerWeapon(playerid, 8, 1);
	    case 7: GivePlayerWeapon(playerid, 9, 1);
	}

	switch(random(3)) // pistol
	{
	    case 0: GivePlayerWeapon(playerid, 22, 99999);
	    case 1: GivePlayerWeapon(playerid, 23, 99999);
	    case 2: GivePlayerWeapon(playerid, 24, 99999);
	}

	switch(random(3)) // shotgun
	{
	    case 0: GivePlayerWeapon(playerid, 25, 99999);
	    case 1: GivePlayerWeapon(playerid, 26, 99999);
	    case 2: GivePlayerWeapon(playerid, 27, 99999);
	}

	switch(random(3)) // mp
	{
	    case 0: GivePlayerWeapon(playerid, 28, 99999);
	    case 1: GivePlayerWeapon(playerid, 29, 99999);
	    case 2: GivePlayerWeapon(playerid, 32, 99999);
	}

	switch(random(2)) //assault
	{
	    case 0: GivePlayerWeapon(playerid, 30, 99999);
	    case 1: GivePlayerWeapon(playerid, 31, 99999);
	}

	switch(random(2)) // rifle
	{
	    case 0: GivePlayerWeapon(playerid, 33, 99999);
	    case 1: GivePlayerWeapon(playerid, 34, 99999);
	}

	switch(random(6)) // heavy
	{
	    case 2: GivePlayerWeapon(playerid, 37, 99999);
	}

	switch(random(3)) // nade
	{
	    case 2: GivePlayerWeapon(playerid, 16, 5);
	}

	switch(random(5))
	{
	    case 1: GivePlayerWeapon(playerid, 41, 50);
	    case 2: GivePlayerWeapon(playerid, 42, 50);
	    case 3: GivePlayerWeapon(playerid, 43, 1);
	}
    return 1;
}

StartSpectate(playerid, specplayerid)
{
	SetPlayerInterior(playerid, GetPlayerInterior(specplayerid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(specplayerid));
	TogglePlayerSpectating(playerid, true);

	if(IsPlayerInAnyVehicle(specplayerid))
	{
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
	}
	else
	{
		PlayerSpectatePlayer(playerid, specplayerid);
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
	}
	new string[100],
		Float:hp,
		Float:ar;
	GetPlayerHealth(specplayerid, hp);
	GetPlayerArmour(specplayerid, ar);
	format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s - id:%i~n~hp:%0.1f ar:%0.1f $%i", __GetName(specplayerid), specplayerid, hp, ar, GetPlayerCash(specplayerid) + PlayerInfo[specplayerid][Bank]);
	GameTextForPlayer(playerid, string, 30000, 3);
}

StopSpectate(playerid)
{
	TogglePlayerSpectating(playerid, false);
	ResetPlayerWorld(playerid);
	SetPlayerPos(playerid, PlayerInfo[playerid][SpecX], PlayerInfo[playerid][SpecY], PlayerInfo[playerid][SpecZ]);
	SetPlayerFacingAngle(playerid, PlayerInfo[playerid][SpecA]);
	PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_NONE;
	GameTextForPlayer(playerid, "~n~~n~~n~~w~Spectate mode ended", 1000, 3);
	return 1;
}

CreateTextdraws()
{
    new count = GetTickCount() + 3600000;
	TXTLoading = TextDrawCreate(319.000000, 208.000000, "Loading...");
	TXTInfo = TextDrawCreate(245.000000, 419.000000, "~w~~h~Player ~b~~h~~h~Mellnik(6) ~w~~h~teleported to ~p~~h~Los Santos [/~w~~h~LS~p~~h~]");
	TXTFooterP1 = TextDrawCreate(1.000000, 437.000000, "         ~h~ng-stunting.net  -  ~y~~h~/cmds ~w~~h~for a list of commands  -  ~y~~h~/v ~w~~h~vehicle spawn  -  ~y~~h~/w ~w~~h~free weapons  -  ~y~~h~/tele ~w~~h~teleport list");
	TXTFooterP2 = TextDrawCreate(510.000000, 437.000000, "  -  ~y~~h~/toys ~w~~h~attachments");
	TXTKeyInfo = TextDrawCreate(500.000000, 425.000000, "~b~~h~LMB ~w~~h~Speedboost");
	TXTBlackScreenP1 = TextDrawCreate(731.000000, -59.000000, "                   ");
	TXTBlackScreenP2 = TextDrawCreate(731.000000, 342.000000, "                   ");
	TXTLogonStars = TextDrawCreate(245.000000, 75.000000, "[][][][][][][][][][]");
	TXTLocalSignP1 = TextDrawCreate(291.000000, 12.000000, NGS_SIGN1);
	TXTLocalSignP2 = TextDrawCreate(262.000000, 55.000000, NGS_SIGN2);
	TXTYellowStripP1 = TextDrawCreate(663.000000, 103.000000, "n");
    TXTYellowStripP2 = TextDrawCreate(663.000000, 340.000000, "n");
    TXTGunGameBox = TextDrawCreate(92.000000, 249.000000, "       ");
	TXTGunGameSign = TextDrawCreate(92.000000, 242.000000, "~y~GunGame");
	TXTRaceSign = TextDrawCreate(92.000000, 249.000000, "      ");
    TXTRaceBox = TextDrawCreate(92.000000, 242.000000, "~y~Race");
  	TXTToyBox = TextDrawCreate(822.000000, 335.000000, "      ");
  	TXTToyInfo = TextDrawCreate(431.000000, 341.000000, "hold ~r~space ~w~to rotate your view~n~press ~r~escape ~w~to cancel~n~once you are finished click on the ~r~save ~w~icon");
	TXTDerbyBox = TextDrawCreate(92.000000, 249.000000, "       ");
	TXTDerbyBoxSign = TextDrawCreate(92.000000, 242.000000, "~y~Derby");
	TXTDerbyInfo = TextDrawCreate(89.000000, 256.000000, "timeleft: ~r~--:--~n~~w~players:~b~ 0/20~n~~w~Map:~n~~g~Voting");
	TXTBGBox = TextDrawCreate(92.000000, 249.000000, "         ");
	TXTBGInfo = TextDrawCreate(89.000000, 256.000000, "timelft: ~r~--:--~n~~w~players:~b~ --/20~n~~w~Map: ~g~Voting~n~~w~Rangers Kills:~n~~y~---~n~~w~Spetsnaz Kills:~n~~y~---");
	TXTBGSign = TextDrawCreate(92.000000, 242.000000, "~y~TDM");
	TXTFalloutBox = TextDrawCreate(92.000000, 249.000000, "       ");
    TXTFalloutInfo = TextDrawCreate(89.000000, 256.000000, "timeleft: ~r~--:--~n~~w~players:~b~ 0~n~~w~status:~n~~g~waiting");
    TXTFalloutSign = TextDrawCreate(92.000000, 242.000000, "~y~Fallout");
 	NGSLOGO[0] = TextDrawCreate(10.000000, 318.000000, "~r~~h~N~w~~h~ext ~g~~h~G~w~~h~eneration ~b~~h~S~w~~h~tunting");
 	NGSLOGO[1] = TextDrawCreate(31.000000, 324.000000, "-");
 	NGSLOGO[2] = TextDrawCreate(36.000000, 330.000000, "        "CURRENT_VERSION"");
 	
	TextDrawBackgroundColor(NGSLOGO[0], 51);
	TextDrawFont(NGSLOGO[0], 3);
	TextDrawLetterSize(NGSLOGO[0], 0.340000, 1.000000);
	TextDrawColor(NGSLOGO[0], -1);
	TextDrawSetOutline(NGSLOGO[0], 1);
	TextDrawSetProportional(NGSLOGO[0], 1);

	TextDrawBackgroundColor(NGSLOGO[1], 51);
	TextDrawFont(NGSLOGO[1], 1);
	TextDrawLetterSize(NGSLOGO[1], 8.039995, 1.000000);
	TextDrawColor(NGSLOGO[1], 0xF97804FF);
	TextDrawSetOutline(NGSLOGO[1], 1);
	TextDrawSetProportional(NGSLOGO[1], 1);

	TextDrawBackgroundColor(NGSLOGO[2], 51);
	TextDrawFont(NGSLOGO[2], 2);
	TextDrawLetterSize(NGSLOGO[2], 0.230000, 0.799999);
	TextDrawColor(NGSLOGO[2], -1);
	TextDrawSetOutline(NGSLOGO[2], 1);
	TextDrawSetProportional(NGSLOGO[2], 1);

	TextDrawBackgroundColor(TXTToyInfo, 255);
	TextDrawFont(TXTToyInfo, 0);
	TextDrawLetterSize(TXTToyInfo, 0.400000, 1.200000);
	TextDrawColor(TXTToyInfo, -1);
	TextDrawSetOutline(TXTToyInfo, 1);
	TextDrawSetProportional(TXTToyInfo, 1);

	TextDrawAlignment(TXTToyBox, 2);
	TextDrawBackgroundColor(TXTToyBox, 255);
	TextDrawFont(TXTToyBox, 1);
	TextDrawLetterSize(TXTToyBox, 0.500000, 1.000000);
	TextDrawColor(TXTToyBox, -1);
	TextDrawSetOutline(TXTToyBox, 0);
	TextDrawSetProportional(TXTToyBox, 1);
	TextDrawSetShadow(TXTToyBox, 1);
	TextDrawUseBox(TXTToyBox, 1);
	TextDrawBoxColor(TXTToyBox, 168430207);
	TextDrawTextSize(TXTToyBox, 1.000000, -804.000000);

	TextDrawAlignment(TXTRaceSign, 2);
	TextDrawBackgroundColor(TXTRaceSign, 255);
	TextDrawFont(TXTRaceSign, 2);
	TextDrawLetterSize(TXTRaceSign, 0.239997, 1.399997);
	TextDrawColor(TXTRaceSign, -1);
	TextDrawSetOutline(TXTRaceSign, 1);
	TextDrawSetProportional(TXTRaceSign, 1);
	TextDrawUseBox(TXTRaceSign, 1);
	TextDrawBoxColor(TXTRaceSign, 168430207);
	TextDrawTextSize(TXTRaceSign, 28.000000, -150.000000);

	TextDrawAlignment(TXTRaceBox, 2);
	TextDrawBackgroundColor(TXTRaceBox, 255);
	TextDrawFont(TXTRaceBox, 0);
	TextDrawLetterSize(TXTRaceBox, 0.500000, 0.899999);
	TextDrawColor(TXTRaceBox, -1);
	TextDrawSetOutline(TXTRaceBox, 0);
	TextDrawSetProportional(TXTRaceBox, 1);
	TextDrawSetShadow(TXTRaceBox, 1);
	TextDrawUseBox(TXTRaceBox, 1);
	TextDrawBoxColor(TXTRaceBox, 255);
	TextDrawTextSize(TXTRaceBox, 20.000000, -150.000000);

	TextDrawAlignment(TXTGunGameBox, 2);
	TextDrawBackgroundColor(TXTGunGameBox, 255);
	TextDrawFont(TXTGunGameBox, 2);
	TextDrawLetterSize(TXTGunGameBox, 0.239999, 0.999998);
	TextDrawColor(TXTGunGameBox, -1);
	TextDrawSetOutline(TXTGunGameBox, 1);
	TextDrawSetProportional(TXTGunGameBox, 1);
	TextDrawUseBox(TXTGunGameBox, 1);
	TextDrawBoxColor(TXTGunGameBox, 168430207);
	TextDrawTextSize(TXTGunGameBox, 28.000000, -150.000000);

	TextDrawAlignment(TXTGunGameSign, 2);
	TextDrawBackgroundColor(TXTGunGameSign, 255);
	TextDrawFont(TXTGunGameSign, 0);
	TextDrawLetterSize(TXTGunGameSign, 0.500000, 0.899999);
	TextDrawColor(TXTGunGameSign, -1);
	TextDrawSetOutline(TXTGunGameSign, 0);
	TextDrawSetProportional(TXTGunGameSign, 1);
	TextDrawSetShadow(TXTGunGameSign, 1);
	TextDrawUseBox(TXTGunGameSign, 1);
	TextDrawBoxColor(TXTGunGameSign, 255);
	TextDrawTextSize(TXTGunGameSign, 20.000000, -150.000000);

	TextDrawBackgroundColor(TXTInfo, 50);
	TextDrawFont(TXTInfo, 1);
	TextDrawLetterSize(TXTInfo, 0.180000, 0.699998);
	TextDrawColor(TXTInfo, -1);
	TextDrawSetOutline(TXTInfo, 1);
	TextDrawSetProportional(TXTInfo, 1);

	TextDrawAlignment(TXTFalloutBox, 2);
	TextDrawBackgroundColor(TXTFalloutBox, 255);
	TextDrawFont(TXTFalloutBox, 2);
	TextDrawLetterSize(TXTFalloutBox, 0.239999, 0.899998);
	TextDrawColor(TXTFalloutBox, -1);
	TextDrawSetOutline(TXTFalloutBox, 1);
	TextDrawSetProportional(TXTFalloutBox, 1);
	TextDrawUseBox(TXTFalloutBox, 1);
	TextDrawBoxColor(TXTFalloutBox, 168430207);
	TextDrawTextSize(TXTFalloutBox, 28.000000, -150.000000);

	TextDrawAlignment(TXTFalloutInfo, 2);
	TextDrawBackgroundColor(TXTFalloutInfo, 255);
	TextDrawFont(TXTFalloutInfo, 2);
	TextDrawLetterSize(TXTFalloutInfo, 0.340000, 1.000000);
	TextDrawColor(TXTFalloutInfo, -1);
	TextDrawSetOutline(TXTFalloutInfo, 1);
	TextDrawSetProportional(TXTFalloutInfo, 1);

	TextDrawAlignment(TXTFalloutSign, 2);
	TextDrawBackgroundColor(TXTFalloutSign, 255);
	TextDrawFont(TXTFalloutSign, 0);
	TextDrawLetterSize(TXTFalloutSign, 0.500000, 0.899999);
	TextDrawColor(TXTFalloutSign, -1);
	TextDrawSetOutline(TXTFalloutSign, 0);
	TextDrawSetProportional(TXTFalloutSign, 1);
	TextDrawSetShadow(TXTFalloutSign, 1);
	TextDrawUseBox(TXTFalloutSign, 1);
	TextDrawBoxColor(TXTFalloutSign, 255);
	TextDrawTextSize(TXTFalloutSign, 20.000000, -150.000000);

	TextDrawAlignment(TXTBGBox, 2);
	TextDrawBackgroundColor(TXTBGBox, 255);
	TextDrawFont(TXTBGBox, 2);
	TextDrawLetterSize(TXTBGBox, 0.239999, 0.999998);
	TextDrawColor(TXTBGBox, -1);
	TextDrawSetOutline(TXTBGBox, 1);
	TextDrawSetProportional(TXTBGBox, 1);
	TextDrawUseBox(TXTBGBox, 1);
	TextDrawBoxColor(TXTBGBox, 168430207);
	TextDrawTextSize(TXTBGBox, 28.000000, -150.000000);

	TextDrawAlignment(TXTBGSign, 2);
	TextDrawBackgroundColor(TXTBGSign, 255);
	TextDrawFont(TXTBGSign, 0);
	TextDrawLetterSize(TXTBGSign, 0.500000, 0.899999);
	TextDrawColor(TXTBGSign, -1);
	TextDrawSetOutline(TXTBGSign, 0);
	TextDrawSetProportional(TXTBGSign, 1);
	TextDrawSetShadow(TXTBGSign, 1);
	TextDrawUseBox(TXTBGSign, 1);
	TextDrawBoxColor(TXTBGSign, 255);
	TextDrawTextSize(TXTBGSign, 20.000000, -150.000000);

	TextDrawAlignment(TXTBGInfo, 2);
	TextDrawBackgroundColor(TXTBGInfo, 255);
	TextDrawFont(TXTBGInfo, 2);
	TextDrawLetterSize(TXTBGInfo, 0.310000, 0.799999);
	TextDrawColor(TXTBGInfo, -1);
	TextDrawSetOutline(TXTBGInfo, 1);
	TextDrawSetProportional(TXTBGInfo, 1);

	TextDrawAlignment(TXTDerbyBox, 2);
	TextDrawBackgroundColor(TXTDerbyBox, 255);
	TextDrawFont(TXTDerbyBox, 2);
	TextDrawLetterSize(TXTDerbyBox, 0.239999, 0.999998);
	TextDrawColor(TXTDerbyBox, -1);
	TextDrawSetOutline(TXTDerbyBox, 1);
	TextDrawSetProportional(TXTDerbyBox, 1);
	TextDrawUseBox(TXTDerbyBox, 1);
	TextDrawBoxColor(TXTDerbyBox, 168430207);
	TextDrawTextSize(TXTDerbyBox, 28.000000, -150.000000);

	TextDrawAlignment(TXTDerbyBoxSign, 2);
	TextDrawBackgroundColor(TXTDerbyBoxSign, 255);
	TextDrawFont(TXTDerbyBoxSign, 0);
	TextDrawLetterSize(TXTDerbyBoxSign, 0.500000, 0.899999);
	TextDrawColor(TXTDerbyBoxSign, -1);
	TextDrawSetOutline(TXTDerbyBoxSign, 0);
	TextDrawSetProportional(TXTDerbyBoxSign, 1);
	TextDrawSetShadow(TXTDerbyBoxSign, 1);
	TextDrawUseBox(TXTDerbyBoxSign, 1);
	TextDrawBoxColor(TXTDerbyBoxSign, 255);
	TextDrawTextSize(TXTDerbyBoxSign, 20.000000, -150.000000);

	TextDrawAlignment(TXTDerbyInfo, 2);
	TextDrawBackgroundColor(TXTDerbyInfo, 255);
	TextDrawFont(TXTDerbyInfo, 2);
	TextDrawLetterSize(TXTDerbyInfo, 0.340000, 1.000000);
	TextDrawColor(TXTDerbyInfo, -1);
	TextDrawSetOutline(TXTDerbyInfo, 1);
	TextDrawSetProportional(TXTDerbyInfo, 1);

	TextDrawAlignment(TXTLoading, 2);
	TextDrawBackgroundColor(TXTLoading, 255);
	TextDrawFont(TXTLoading, 2);
	TextDrawLetterSize(TXTLoading, 0.469998, 2.099998);
	TextDrawColor(TXTLoading, -1);
	TextDrawSetOutline(TXTLoading, 1);
	TextDrawSetProportional(TXTLoading, 1);
	TextDrawUseBox(TXTLoading, 1);
	TextDrawBoxColor(TXTLoading, 170);
	TextDrawTextSize(TXTLoading, -9.000000, -152.000000);

	TextDrawBackgroundColor(TXTFooterP1, 255);
	TextDrawFont(TXTFooterP1, 2);
	TextDrawLetterSize(TXTFooterP1, 0.189999, 1.000000);
	TextDrawColor(TXTFooterP1, -1);
	TextDrawSetOutline(TXTFooterP1, 1);
	TextDrawSetProportional(TXTFooterP1, 1);
	TextDrawUseBox(TXTFooterP1, 1);
	TextDrawBoxColor(TXTFooterP1, 168430207);
	TextDrawTextSize(TXTFooterP1, 715.000000, 0.000000);

	TextDrawBackgroundColor(TXTFooterP2, 255);
	TextDrawFont(TXTFooterP2, 2);
	TextDrawLetterSize(TXTFooterP2, 0.189999, 1.000000);
	TextDrawColor(TXTFooterP2, -1);
	TextDrawSetOutline(TXTFooterP2, 1);
	TextDrawSetProportional(TXTFooterP2, 1);

	TextDrawBackgroundColor(TXTKeyInfo, 255);
	TextDrawFont(TXTKeyInfo, 2);
	TextDrawLetterSize(TXTKeyInfo, 0.289999, 1.000000);
	TextDrawColor(TXTKeyInfo, 16777215);
	TextDrawSetOutline(TXTKeyInfo, 1);
	TextDrawSetProportional(TXTKeyInfo, 1);
	TextDrawUseBox(TXTKeyInfo, 1);
	TextDrawBoxColor(TXTKeyInfo, 168430207);
	TextDrawTextSize(TXTKeyInfo, 650.000000, 0.000000);

	TextDrawBackgroundColor(TXTBlackScreenP1, 255);
	TextDrawFont(TXTBlackScreenP1, 1);
	TextDrawLetterSize(TXTBlackScreenP1, 0.500000, 1.000000);
	TextDrawColor(TXTBlackScreenP1, -1);
	TextDrawSetOutline(TXTBlackScreenP1, 0);
	TextDrawSetProportional(TXTBlackScreenP1, 1);
	TextDrawSetShadow(TXTBlackScreenP1, 1);
	TextDrawUseBox(TXTBlackScreenP1, 1);
	TextDrawBoxColor(TXTBlackScreenP1, 255);
	TextDrawTextSize(TXTBlackScreenP1, -350.000000, -31.000000);

	TextDrawBackgroundColor(TXTBlackScreenP2, 255);
	TextDrawFont(TXTBlackScreenP2, 1);
	TextDrawLetterSize(TXTBlackScreenP2, 0.500000, 1.000000);
	TextDrawColor(TXTBlackScreenP2, -1);
	TextDrawSetOutline(TXTBlackScreenP2, 0);
	TextDrawSetProportional(TXTBlackScreenP2, 1);
	TextDrawSetShadow(TXTBlackScreenP2, 1);
	TextDrawUseBox(TXTBlackScreenP2, 1);
	TextDrawBoxColor(TXTBlackScreenP2, 255);
	TextDrawTextSize(TXTBlackScreenP2, -350.000000, -31.000000);

	TextDrawBackgroundColor(TXTLogonStars, 255);
	TextDrawFont(TXTLogonStars, 2);
	TextDrawLetterSize(TXTLogonStars, 0.230000, 1.299999);
	TextDrawColor(TXTLogonStars, 0xF97804FF);
	TextDrawSetOutline(TXTLogonStars, 1);
	TextDrawSetProportional(TXTLogonStars, 1);

	TextDrawBackgroundColor(TXTLocalSignP1, 255);
	TextDrawFont(TXTLocalSignP1, 2);
	TextDrawLetterSize(TXTLocalSignP1, 0.659999, 4.199998);
	TextDrawColor(TXTLocalSignP1, -1);
	TextDrawSetOutline(TXTLocalSignP1, 1);
	TextDrawSetProportional(TXTLocalSignP1, 1);

	TextDrawBackgroundColor(TXTLocalSignP2, 255);
	TextDrawFont(TXTLocalSignP2, 2);
	TextDrawLetterSize(TXTLocalSignP2, 0.200000, 1.100000);
	TextDrawColor(TXTLocalSignP2, -1);
	TextDrawSetOutline(TXTLocalSignP2, 1);
	TextDrawSetProportional(TXTLocalSignP2, 1);

	TextDrawBackgroundColor(TXTYellowStripP1, 255);
	TextDrawFont(TXTYellowStripP1, 1);
	TextDrawLetterSize(TXTYellowStripP1, 0.500000, 0.099999);
	TextDrawColor(TXTYellowStripP1, -65281);
	TextDrawSetOutline(TXTYellowStripP1, 0);
	TextDrawSetProportional(TXTYellowStripP1, 1);
	TextDrawSetShadow(TXTYellowStripP1, 1);
	TextDrawUseBox(TXTYellowStripP1, 1);
	TextDrawBoxColor(TXTYellowStripP1, 0xF97804FF);
	TextDrawTextSize(TXTYellowStripP1, -160.000000, -70.000000);

	TextDrawBackgroundColor(TXTYellowStripP2, 255);
	TextDrawFont(TXTYellowStripP2, 1);
	TextDrawLetterSize(TXTYellowStripP2, 0.500000, 0.099999);
	TextDrawColor(TXTYellowStripP2, 6946815);
	TextDrawSetOutline(TXTYellowStripP2, 0);
	TextDrawSetProportional(TXTYellowStripP2, 1);
	TextDrawSetShadow(TXTYellowStripP2, 1);
	TextDrawUseBox(TXTYellowStripP2, 1);
	TextDrawBoxColor(TXTYellowStripP2, 0xF97804FF);
	TextDrawTextSize(TXTYellowStripP2, -160.000000, -70.000000);

	printf("#TextDraws loaded in %i ms", (GetTickCount() + 3600000) - count);
	return 1;
}

DestroyTextdraws()
{
	TextDrawHideForAll(TXTLoading);
	TextDrawHideForAll(TXTFooterP1);
	TextDrawHideForAll(TXTFooterP2);
	TextDrawHideForAll(TXTKeyInfo);
	TextDrawHideForAll(TXTBlackScreenP1);
	TextDrawHideForAll(TXTBlackScreenP2);
	TextDrawHideForAll(TXTLogonStars);
	TextDrawHideForAll(TXTLocalSignP1);
	TextDrawHideForAll(TXTLocalSignP2);
	TextDrawHideForAll(TXTYellowStripP1);
	TextDrawHideForAll(TXTYellowStripP2);

	TextDrawDestroy(TXTLoading);
	TextDrawDestroy(TXTFooterP1);
	TextDrawDestroy(TXTFooterP2);
	TextDrawDestroy(TXTKeyInfo);
	TextDrawDestroy(TXTBlackScreenP1);
	TextDrawDestroy(TXTBlackScreenP2);
	TextDrawDestroy(TXTLogonStars);
	TextDrawDestroy(TXTLocalSignP1);
	TextDrawDestroy(TXTLocalSignP2);
	TextDrawDestroy(TXTYellowStripP1);
	TextDrawDestroy(TXTYellowStripP2);
	return 1;
}

function:xReactionProgress()
{
    if(xTestBusy)
	{
        tReactionTimer = SetTimer("xReactionTest", REAC_TIME, true);
        ReactionOn = false;
	}
	return 1;
}

function:xReactionTest()
{
    ReactionOn = true;
	new
		xLength = (random(10) + 3),
		string[144],
		gstring[144],
		count = 0;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i)) count++;
	}

	xCash = 250 * count;
	xScore = (random(7) + 2);
	format(xChars, sizeof(xChars), "");
	for(new i = 0; i < xLength; i++)
	{
		format(xChars, sizeof(xChars), "%s%s", xChars, xCharacters[random(sizeof(xCharacters))][0]);
	}
	format(string, sizeof(string), "["vlila"REACTION"white"]: The first who types '"vlila"%s"white"' wins $%i + %i score", xChars, xCash, xScore);
	format(gstring, sizeof(gstring), "["vlila"REACTION"white"]: Der erste der '"vlila"%s"white"' schreibt gewinnt $%i und %i score", xChars, xCash, xScore);
	LangMSGToAll(WHITE, string, gstring);
	KillTimer(tReactionTimer);
	xTestBusy = true;
	SetTimer("xReactionProgress", 60000, false);
	return 1;
}

function:RandomTextDrawText()
{
    switch(random(3))
    {
        case 0: TextDrawSetString(TXTKeyInfo, "~b~2 ~w~Flip Vehicle");
        case 1: TextDrawSetString(TXTKeyInfo, "~b~H ~w~Vehicle Jump");
        case 2: TextDrawSetString(TXTKeyInfo, "~b~LMB ~w~Speedboost");
	}
	return 1;
}

function:payday(playerid)
{
	if(2 < PlayerInfo[playerid][PayDay] <= 60)
	{
	    PlayerInfo[playerid][PayDay]--;
	    return 1;
	}
	else if(PlayerInfo[playerid][PayDay] <= 2)
	{
	    new
			string0[50],
			string1[50],
			string2[50],
			string3[50],
			interest = floatround(floatmul(floatdiv(PlayerInfo[playerid][Bank], 2000.0), 8.0), floatround_round);

		GameTextForPlayer(playerid, "~y~PayDay~n~~w~Paycheck", 6000, 1);

		format(string0, sizeof(string0), "Bank Balance before PayDay: "green"$%i", PlayerInfo[playerid][Bank]);
		format(string1, sizeof(string1), "Bank Interest Gained: "green"$%i", interest);

		if(PlayerInfo[playerid][Props] >= 1)
		{
		    format(string3, sizeof(string3), "Business earnings: "green"$%i", PlayerInfo[playerid][PropEarnings]);
		}
		else format(string3, sizeof(string3), "Business earnings: "red"---", PlayerInfo[playerid][PropEarnings]);

		PlayerInfo[playerid][Bank] = PlayerInfo[playerid][Bank] + interest + PlayerInfo[playerid][PropEarnings];

		format(string2, sizeof(string2), "Bank Balance after PayDay: "green"$%i", PlayerInfo[playerid][Bank]);

		SendClientMessage(playerid, 0xFFAA00FF, ""green"|--------------------"yellow"PAY-DAY"green"-------------------|");
		SendClientMessage(playerid, WHITE, string0);
		SendClientMessage(playerid, WHITE, string1);
		SendClientMessage(playerid, WHITE, string3);
		SendClientMessage(playerid, WHITE, string2);
		SendClientMessage(playerid, 0xFFAA00FF, ""green"|--------------------------------------------------|");
     	PlayerInfo[playerid][PayDay] = 60;
	}
	return 1;
}

function:Elevator_Boost(floorid)
{
	MoveObject(Obj_Elevator, 1786.678100, -1303.459472, GetElevatorZCoordForFloor(floorid), ELEVATOR_SPEED);
    MoveObject(Obj_ElevatorDoors[0], X_DOOR_CLOSED, -1303.459472, GetDoorsZCoordForFloor(floorid), ELEVATOR_SPEED);
    MoveObject(Obj_ElevatorDoors[1], X_DOOR_CLOSED, -1303.459472, GetDoorsZCoordForFloor(floorid), ELEVATOR_SPEED);
	return 1;
}

function:Elevator_TurnToIdle()
{
	ElevatorState = ELEVATOR_STATE_IDLE;
	ReadNextFloorInQueue();
	return 1;
}

function:mainmode()
{
    SendClientMessageToAll(-1, ""server_sign" Maintenance initiated...");

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerNPC(i) || PlayerInfo[i][Level] > 0) continue;
	    if(IsPlayerConnected(i))
	    {
			LangMSG(i, RED, "Your account has been saved and you have been disconnected", "Dein Account wurde gespeichert und du wurdest getrennt");
			KickEx(i);
		}
	}
	return 1;
}

function:initSlot()
{
	new foundx = -1;
	for(new i = 0; i < houseid; i++)
	{
	    if(HouseInfo[i][Owner] == '\0')
		{
			foundx = i;
			break;
		}
	}
	return foundx;
}

function:propSlot()
{
	new pfoundx = -1;
	for(new i = 0; i < propid; i++)
	{
	    if(PropInfo[i][Owner] == '\0')
		{
			pfoundx = i;
			break;
		}
	}
	return pfoundx;
}

LoadServerStaticMeshes()
{
	new string[100], count = GetTickCount() + 3600000;
	format(string, sizeof(string), "hostname %s", HOSTNAME);

	SendRconCommand(string);
	SendRconCommand("weburl ng-stunting.net");
	#if IS_RELEASE_BUILD == true
	SendRconCommand("mapname DriftRaceDmFunStuntParkourNGSxy");
	SetGameModeText("TdmDerbyRaceDmFunStuntFreeroamgxy");
	#else
	SendRconCommand("mapname NGS BETA BUILD R5");
	SetGameModeText("NGS BETA BUILD R5");
	#endif
	ShowPlayerMarkers(1);
	DisableInteriorEnterExits();
	ShowNameTags(1);
	SetNameTagDrawDistance(35.0);
	AllowInteriorWeapons(1);
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	SetWeather(5);
	SetWorldTime(12);
	ServerTime[0] = 12;
	ServerTime[1] = 0;
	BuildVehicle = -1;

	if(fexist("Other/loginsound.txt"))
	{
		new File:sound = fopen("Other/loginsound.txt");
		fread(sound, loginsoundlink);
		fclose(sound);
	}
	else
	{
	    strmid(loginsoundlink, "http://mellnik.bplaced.net/nfewufcghveqg/gfsioghfas/nasduigbfavzfe/agfsufdasdgehauebdqedwabe.mp3", 0, 255, 255);
	}

    AddPlayerClass(3,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
    AddPlayerClass(81,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(1,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(0,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(299,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(5,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(264,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(26,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(289,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(28,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(248,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(178,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(100,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(115,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(127,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(138,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(149,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(249,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(162,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(206,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(271,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(285,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);
	AddPlayerClass(283,1958.3783,1343.1572,15.3746,270.1425,22,99999,27,99999,33,99999);

	printf("#Server Meshes loaded in %i ms", (GetTickCount() + 3600000) - count);
	return 1;
}

LoadVisualStaticMeshes()
{
    new count = GetTickCount() + 3600000;
    pick_chainsaw = CreatePickup(341, 2, 1219.1809,-924.6318,42.9045, 0);
    pick_life[0] = CreatePickup(1240, 2, -1987.6259,274.7049,34.9564, 0);
    pick_life[1] = CreatePickup(1240, 2, 2463.1362,-1683.0521,13.3142, 0);
    pick_life[2] = CreatePickup(1240, 2, 1184.9302,-1325.9720,13.3399, 0);
    pick_life[3] = CreatePickup(1240, 2, 241.4559,-1754.1686,4.2808, 0);
    pick_life[4] = CreatePickup(1240, 2, 333.7505,-1520.1478,35.6370, 0);
    pick_life[5] = CreatePickup(1240, 2, 800.4719,-1629.9167,13.1530, 0);
    pick_life[6] = CreatePickup(1240, 2, 2458.5137,2019.7380,10.8325, 0);
    pick_life[7] = CreatePickup(1240, 2, -588.3522,-3579.2637,3.4029, 0);
    pick_life[8] = CreatePickup(1240, 2, 2271.3765,1518.1755,42.5862, 0);
    pick_life[9] = CreatePickup(1240, 2, 2316.5967,1792.5190,10.5918, 0);
    pick_life[10] = CreatePickup(1240, 2, -2383.1816,-587.0456,131.8897, 0);
    pick_life[11] = CreatePickup(1240, 2, -1405.9728,492.3374,18.0023, 0);
    pick_life[12] = CreatePickup(1240, 2, 2035.2893,-2348.9136,13.6844, 0);
    
    AdminLC = CreatePickup(1559, 23, 1805.7494,-1302.6721,120.2656, -1);
    AdminLC2 = CreatePickup(1559, 23, -794.806396,497.738037,1376.195312, 0);
   	aussenrein = CreatePickup(1559, 23, 1795.2469,-1406.5632,13.6531, -1);
	innenraus = CreatePickup(1559, 23, -1405.4905,985.1736,1049.0078, -1);
	vehiclebuy = CreatePickup(1559, 23, -1407.0137,1013.8229,1049.0288, -1);
	dm1pickup = CreatePickup(1247, 2, -3954.1172,980.9998,65.6059, -1);
	dm2pickup = CreatePickup(1247, 2, -3951.4558,982.3098,36.1859, -1);
	
	// old map icons
	CreateDynamicMapIcon(822.6, -1590.3, 13.5, 7, 1, -1, -1, -1);
	CreateDynamicMapIcon(-2570.1, 245.4, 10.3, 7, 1, -1, -1, -1);
	CreateDynamicMapIcon(2726.6, -2026.4, 17.5, 7, 1, -1, -1, -1);
	CreateDynamicMapIcon(2080.3, 2119.0, 10.8, 7, 1, -1, -1, -1);
	CreateDynamicMapIcon(2080.3, 2119.0, 10.8, 7, 1, -1, -1, -1);
	CreateDynamicMapIcon(675.7, -496.6, 16.8, 7, 1, -1, -1, -1);
    CreateDynamicMapIcon(1971.7, -2036.6, 13.5, 39, 1, -1, -1, -1);
    CreateDynamicMapIcon(2071.6, -1779.9, 13.5, 39, 1, -1, -1, -1);
    CreateDynamicMapIcon(2094.6, 2119.0, 10.8, 39, 1, -1, -1, -1);
    CreateDynamicMapIcon(-2490.5, -40.1, 39.3, 39, 1, -1, -1, -1);
	// old map icons end
	
	// vehicle shop
	CreateDynamicMapIcon(1795.2469, -1406.5632, 13.6531, 55, 1, -1, -1, -1, 500.0);
	// vehicle shop end
	
	// hotspots
	CreateDynamicMapIcon(341.8535, -1852.6327, 8.2618, 23, 1, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(-1196.3280, -17.4523, 15.8281, 23, 1, -1, -1, -1, 300.0);
	CreateDynamicMapIcon(1458.7290, 1854.6403, 54.9663, 23, 1, -1, -1, -1, 300.0);
	// hotspots end

	// login obj
	CreateDynamicObject(19462, 388.20, -1809.04, 16.17, 0.00, 90.00, 13.00);
	CreateDynamicObject(19462, 391.58, -1808.24, 16.17, 0.00, 90.00, 13.00);
	// login obj end

    Create3DTextLabel(""white"["orange"NGS"white"]\n/beach", -1, 341.8535, -1852.6327, 8.2618+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/sf", -1, -1990.6650, 136.9297, 27.3110+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/sfa", -1, -1196.3280, -17.4523, 15.8281+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/mc", -1, -2335.2832, -1644.9913, 486.0481+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/ls", -1, 2494.7476,-1666.6097,13.3438+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/lspd", -1, 1542.5554,-1674.7850,13.5547+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/sfpd", -1, -1624.2128,674.2734,6.9573+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/lvpd", -1, 2290.5759,2421.3708,10.8203+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/skyroad", -1, 587.9016,1400.4779,1228.1453+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/wj", -1, 341.6029,2008.7330,571.1588+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/snow", -1, -719.7679,1723.9852,7.0400+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/sd", -1, -793.2972,2230.8733,45.0103+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/aa", -1, 383.5131,2537.2727,18.8503+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/a51", -1, 307.2482,2050.7505,17.6406+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/trans", -1, 1034.5165,-1039.7190,31.6651+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/trans2", -1, -1932.7380,228.3443,34.1563+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/trans3", -1, 2386.2788,1021.7114,10.8203+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/lw", -1, 2645.5457,-2004.5851,13.3828+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/arch", -1, -2689.1001,217.8290,3.9509+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/ee", -1, -2678.2119,1594.8811,217.2739+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/qp", -1, 2121.9146,2397.7786,51.2586+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\nAdmin Plane\n/plane", -1, 1841.8307,-1398.3483,119.0471+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/et", -1, 956.2977,2441.0171,205.7626+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/lv", -1, 2039.8860,1546.1112,10.4450+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/bs", -1, 1207.7231,-920.2217,43.0507+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/bs2", -1, 810.2364,-1632.6433,13.3906+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/bs3", -1, 2447.1104,2024.7499,10.8203+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/bs4", -1, -2314.1365,-143.7879,35.3203+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/bs5", -1, -1907.5175,834.4271,35.0156+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/film", -1, 909.7761,-1221.2274,16.9766+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/park", -1, 1968.4741,-1440.0867,13.5475+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/glen", -1, 1892.7002,-1165.8480,24.0390+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/sky", -1, 1544.1896,-1352.2094,329.4762+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/sftj", -1, -1753.6401,884.9623,295.8750+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/quarry", -1, 833.0357,851.8098,12.0047+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/bordel", -1, -2628.8484,1367.2144,6.9035+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/vs", -1, 1859.3052,-1463.4524,13.5301+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/ms", -1, 800.6712,-1330.6608,13.1061+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/speed", -1, 680.2595, -1361.8927, 2552.2212+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/dd", -1, 4546.4175,655.6476,13.4803+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/lva", -1, 1320.6082,1268.7208,13.5903+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/glory", -1, 2354.1689, -2067.3284, 22.3832+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/maze", -1, 2330.3174, 535.1375, 2.9512+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/maze2", -1, 1458.9336, 1854.9144, 54.7362+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/maze3", -1, 836.5298,-2048.2273,12.8672+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/maze4", -1, 983.0536,2691.7898,10.6925+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/loop", -1, 494.7604, 4.7474, 704.3844+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/rect", -1, 742.8961,533.1397,461.9956+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/nrg", -1, 442.4455, 816.6687, 9.6865+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/da", -1, 788.3009,-471.4969,20.5428+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/drag", -1, -557.0079,-3575.5906,3.0870+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/drift", -1, 2333.8508,1405.8370,42.5904+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/balloon", -1, 295.4890,-1813.5734,52.0518+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/lsp", -1, 2505.2646,-1694.4974,17.9575+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/kk", -1, 2521.0232, -1504.3864, 25.5929+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/skyroad2", -1, 2912.3618,-792.8673,10.7623+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/skyroad3", -1, 205.0412,2481.6416,16.5166+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/globe", -1, 1954.7849,1915.3772,144.7200+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/farm", -1, -1206.7996,-1056.9430,128.3646+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/bowl", -1, -576.6021,421.7149,75.2376+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/parkour", -1, 2586.5618,-1346.5614,232.2472+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/parkour2", -1, -787.3710,-2766.3005,2660.3042+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/parkour3", -1, -783.9699, -3662.0358, 137.3758+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/parkour4", -1, -2929.4922,-1876.4229,8.3901+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/parkour5", -1, 1441.3851318359, -1700.8812255859, 915.390625+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/parkour6", -1, 2768.4343261719,-2743.7131347656,2460.0815429688+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/parkour7", -1, 3018.1736,-1879.4410,599.0370+0.5, 40.0, 0);
    Create3DTextLabel(""white"["orange"NGS"white"]\n/palominocreek", -1, 2343.0247,91.6131,26.3281+0.5, 40.0, 0);

    Create3DTextLabel(""white"["yellow"Private Vehicle Shop"white"]", -1, 1795.2469,-1406.5632,13.6531+0.5, 60.0, 0);
    Create3DTextLabel(""red">>> SLOW DOWN <<<", RED, 477.7281,1399.4580,735.2565+0.5, 60.0, 0);
    Create3DTextLabel(""white"["lila"Mellnik´s Office"white"]", YELLOW, 1794.8202,-1311.3057,120.6237+0.5, 35.0,0);
    Create3DTextLabel(""white"["yellow"Admin Liberty City"white"]", -1, 1805.7494,-1302.6721,120.2656+0.5, 35.0,0);
    Create3DTextLabel(""white"["yellow"Private Vehicle Shop"white"]", -1, -1407.0137,1013.8229,1049.0288+0.5, 35.0,0);
  	Create3DTextLabel(""white"["yellow"Bank"white"]\nPress 'SPACE'", -1, 2311.63, -3.89, 26.74+0.5, 25.0,1000);
	Create3DTextLabel(""white"["yellow"Bank"white"]\nPress 'SPACE'", -1, 2311.63, -3.89, 26.74+0.5, 25.0,1001);
	Create3DTextLabel(""white"["yellow"Bank"white"]\nPress 'SPACE'", -1, 2311.63, -3.89, 26.74+0.5, 25.0,1002);
	Create3DTextLabel(""white"["yellow"Bank"white"]\nPress 'SPACE'", -1, 2311.63, -3.89, 26.74+0.5, 25.0,1003);

	printf("#Visual Meshes loaded in %i ms", (GetTickCount() + 3600000) - count);
	return 1;
}

function:PlayerBuyVehicle(playerid, vprice, vmodel)
{
	if(GetPlayerCash(playerid) < vprice)
	{
		LangMSG(playerid, RED, "You can´t afford that vehicle", "Du hast zu wenig Geld für dieses Fahrzeug");
		ShowDialog(playerid, CARBUY_DIALOG);
		return 1;
	}

	ShowDialog(playerid, VEHICLEPLATE_DIALOG);

	PlayerInfoVeh[playerid][Model] = vmodel;
	PlayerInfoVeh[playerid][Price] = vprice;

	PreviewTmpVeh[playerid] = CreateVehicle(vmodel, -1412.1841, 1027.2224, 1049.1060, 231.6696, 0, 0, -1);
	LinkVehicleToInterior(PreviewTmpVeh[playerid], GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(PreviewTmpVeh[playerid], GetPlayerVirtualWorld(playerid));
	return 1;
}

CreateFinalCar(playerid)
{
    if(PreviewTmpVeh[playerid] != -1)
    {
		DestroyVehicle(PreviewTmpVeh[playerid]);
		PreviewTmpVeh[playerid] = -1;
	}

	if(PlayerInfo[playerid][Vehicle] != -1)
	{
		DestroyVehicle(PlayerInfo[playerid][Vehicle]);
		PlayerInfo[playerid][Vehicle] = -1;
	}

	new
		vlabel[100];

	format(vlabel, sizeof(vlabel), ""blue"%s´s \n"white"private vehicle", __GetName(playerid));

	PlayerInfo[playerid][PV_Vehicle] = CreateVehicle(PlayerInfoVeh[playerid][Model], 1826.9821, -1383.8724, 19.3348, 180.0407, 0, 0, -1);
	PlayerInfo[playerid][PV_3DLabel] = CreateDynamic3DTextLabel(vlabel, RED, 0.0, 0.0, 0.0, 30.0, INVALID_PLAYER_ID, PlayerInfo[playerid][PV_Vehicle], 0, -1, -1, -1, 30.0);

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetVehicleVirtualWorld(PlayerInfo[playerid][PV_Vehicle], 0);
	LinkVehicleToInterior(PlayerInfo[playerid][PV_Vehicle], 0);
    GivePlayerCash(playerid, -PlayerInfoVeh[playerid][Price]);
	format(vlabel, sizeof(vlabel), "-$%i", PlayerInfoVeh[playerid][Price]);
	GameTextForPlayer(playerid, vlabel, 3000, 1);

    SetVehicleNumberPlate(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Plate]);
    SetVehicleToRespawn(PlayerInfo[playerid][PV_Vehicle]);

    TogglePlayerControllable(playerid, true);
    PutPlayerInVehicle(playerid, PlayerInfo[playerid][PV_Vehicle], 0);
    SendInfo(playerid, "~h~~y~Private Vehicle Purchased!", 3500);
    gTeam[playerid] = NORMAL;
    ShowPlayerDialog(playerid, 5003, DIALOG_STYLE_MSGBOX, ""white"Vehicle bought!", ""white"You can now use /vmenu to control your new private vehicle!", "OK", "");

    MySQL_CreateBuyVehicle(playerid);
    return 1;
}

PortPlayerMap(playerid, Float:X, Float:Y, Float:Z, Float:Angle, const mapname[], const cmd[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, GREY, NOT_AVAIL, NOT_AVAIL_G);

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetCameraBehindPlayer(playerid);
	
    Streamer_UpdateEx(playerid, X, Y, Z);
	SetPlayerPos(playerid, X, Y, floatadd(Z, 3.0));
	SetPlayerFacingAngle(playerid, Angle);

    PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid, mapname, 1000, 6);
    NewMapEvent(playerid, mapname, cmd);
	return 1;
}

PortPlayerMapVeh(playerid, Float:X, Float:Y, Float:Z, Float:Angle, Float:XVeh, Float:YVeh, Float:ZVeh, Float:AngleVeh, const mapname[], const cmd[])
{
	if(gTeam[playerid] != NORMAL) return LangMSG(playerid, GREY, NOT_AVAIL, NOT_AVAIL_G);

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetCameraBehindPlayer(playerid);

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    new veh = GetPlayerVehicleID(playerid);
	    Streamer_UpdateEx(playerid, XVeh, YVeh, ZVeh);
	    SetVehiclePos(veh, XVeh, YVeh, floatadd(ZVeh, 4.5));
	    SetVehicleVirtualWorld(veh, 0);
   		SetVehicleZAngle(veh, AngleVeh);
		PutPlayerInVehicle(playerid, veh,0);
	}
	else
	{
	    Streamer_UpdateEx(playerid, X, Y, Z);
		SetPlayerPos(playerid, X, Y, floatadd(Z, 3.0));
		SetPlayerFacingAngle(playerid, Angle);
	}
	PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
    GameTextForPlayer(playerid, mapname, 1000, 6);
    NewMapEvent(playerid, mapname, cmd);
	return 1;
}

SendFirstSpawnMSG(playerid)
{
    new string[1024];
	strcat(string, "{FFF1AF}Hi {FFF1AF}and welcome on {646464}«(—[—|{CD0000}Next {005FFF}Generation "white"Stunting{FFE600}™{646464}|—]—)»\n");
	strcat(string, "\n{6EF83C}-> {FFF1AF}A Stunt-Server with something for everyone!");
	strcat(string, "\n{6EF83C}-> {FFF1AF}View "lila"/help {FFF1AF}and "lila"/rules {FFF1AF}before playing");
	strcat(string, "\n{6EF83C}-> {FFF1AF}To get an overview of all commands, type "lila"/cmds");
	strcat(string, "\n{6EF83C}-> {FFF1AF}Report players with "lila"/report");
	strcat(string, "\n{6EF83C}-> {FFF1AF}Visit us on "lila"http://ng-stunting.net");
    strcat(string, "\n{6EF83C}-> {FFF1AF}NG-Stunting opened on 11th Jan 2013");
    strcat(string, "\n{6EF83C}-> {FFF1AF}Current Version: "lila""CURRENT_VERSION"");
    strcat(string, "\n\n{FFF1AF}Thank you for playing on our Server. Team {CD0000}N{005FFF}G"white"S {FFF1AF}wishes much "lila"FUN!");
	
	ShowPlayerDialog(playerid, FIRST_SPAWN_DIALOG, DIALOG_STYLE_MSGBOX, " ", string, "OK", "");
	return 1;
}

SendWelcomeMSG(playerid)
{
	SendClientMessage(playerid, GREY, "===================="white""CURRENT_VERSION""grey"=======================");
	LangMSG(playerid, BLUE, "» Type /help for further information", "» Nutze /help um eine Übersicht zu erhalten");
	LangMSG(playerid, WHITE, "» /admins to see online administrative personnel", "» /admins um online Admins zu sehen");
	LangMSG(playerid, BLUE, "» You can show/hide the footer with /showf /hidef", "» Du kannst den Footer ein und ausschalten mit /showf /hidef");
	LangMSG(playerid, YELLOW, "» Visit our forum at forum.ng-stunting.net", "» Besuche uns im Forum unter forum.ng-stunting.net");
	LangMSG(playerid, ORANGE, "» You can use /radio or /streams for music streams", "» Tippe /radio oder /streams für Musik Streams");
	SendClientMessage(playerid, RED, "» Welcome on {646464}«(—[—|{CD0000}Next {005FFF}Generation "white"Stunting{FFE600}™{646464}|—]—)»");
	SendClientMessage(playerid, GREY, "===================="white""CURRENT_VERSION""grey"=======================");
	return 1;
}

SetPlayerBGStaticMeshes(playerid)
{
    TogglePlayerControllable(playerid, false);
    SetPlayerHealth(playerid, 99999.0);
	ResetPlayerWeapons(playerid);

    switch(CurrentBGMap)
    {
        case BG_VOTING :
        {
			SetPlayerPos(playerid, BG_MAP1_WHILECAM);
       		SetPlayerCameraPos(playerid, BG_MAP1_CAMPOS);
       		SetPlayerCameraLookAt(playerid, BG_MAP1_CAMLA);
        }
        case BG_MAP1 :
        {
	  		SetPlayerPos(playerid, BG_MAP1_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP1_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP1_CAMLA);
        }
        case BG_MAP2 :
        {
     		SetPlayerPos(playerid, BG_MAP2_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP2_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP2_CAMLA);
        }
        case BG_MAP3 :
        {
     		SetPlayerPos(playerid, BG_MAP3_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP3_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP3_CAMLA);
        }
        case BG_MAP4 :
        {
     		SetPlayerPos(playerid, BG_MAP4_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP4_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP4_CAMLA);
        }
        case BG_MAP5 :
        {
     		SetPlayerPos(playerid, BG_MAP5_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP5_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP5_CAMLA);
        }
    }
	return 1;
}

function:DerbyVoting()
{
	if(CurrentDerbyPlayers < 2)
	{
	    DerbyMSG("There need to be 2 players to start!", "Um das Derby zu starten werden 2 Spieler benötigt!");
		ClearDerbyVotes();
		ExecDerbyVotingTimer();
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}
	
	ClearDerbyAfkPlayers();
	
	new iTotalVotes;
	iTotalVotes = DerbyMapVotes[0] + DerbyMapVotes[1] + DerbyMapVotes[2] + DerbyMapVotes[3] + DerbyMapVotes[4] + DerbyMapVotes[5];
	if(iTotalVotes == 0)
	{
	    ExecDerbyVotingTimer();
		ClearDerbyVotes();
		DerbyMSG("There were no votes!", "Keine Votes wurde registriert!");
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
	    return 1;
	}

	new highestmapvotes = -1, draw = 0;
	for(new i = 0; i < sizeof(DerbyMapVotes); i++)
	{
 		if(DerbyMapVotes[i] > highestmapvotes && draw == 0)
		{
  			highestmapvotes = DerbyMapVotes[i];
		}
		else if(DerbyMapVotes[i] > highestmapvotes && draw != 0)
		{
		    highestmapvotes = DerbyMapVotes[i];
		    draw = 0;
		}
		else if(DerbyMapVotes[i] == highestmapvotes)
		{
			draw++;
		}
	}

	if(draw >= 1)
	{
	    DerbyMSG("Voting was not clear. New Voting starting.", "Das Voting war unentschieden.");
	    ExecDerbyVotingTimer();
		ClearDerbyVotes();
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}
	
	new
		active_db_players = 0;

	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == DERBY)
		{
	        SetPlayerVirtualWorld(i, DERBY_WORLD); // <bla>
	        if(IsPlayerOnDesktop(i, 5000))
			{
	            bDerbyAFK[i] = true;
	        }
	        else
			{
	            active_db_players++;
	        }
	    }
	}
	if(active_db_players < 2)
	{
	    // Wir können nicht starten
		DerbyMSG("Couldn't start Derby! Too many afk players", "Konnte Derby nicht starten! Zu viele AFK-Spieler");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}

	if(highestmapvotes == DerbyMapVotes[0]) StartDerbyMap1();
	else if(highestmapvotes == DerbyMapVotes[1]) StartDerbyMap2();
	else if(highestmapvotes == DerbyMapVotes[2]) StartDerbyMap3();
    else if(highestmapvotes == DerbyMapVotes[3]) StartDerbyMap4();
    else if(highestmapvotes == DerbyMapVotes[4]) StartDerbyMap5();
    else if(highestmapvotes == DerbyMapVotes[5]) StartDerbyMap6();
	return 1;
}

ClearDerbyAfkPlayers()
{
	for(new i ; i < MAX_PLAYERS ; i++)
	{
	    bDerbyAFK[i] = false;
	}
	return 1;
}

function:StartDerbyMap1()
{
    CurrentDerbyMap = 1;
    new pcount = 0;
	ClearDerbyVotes();
	DerbyMSG("Map 'Lighthouse' won! Let´s start!", "Map 'Lighthouse' hat gewonnen! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
		    
	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100], gstring[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
			    format(gstring, sizeof(gstring), "%s konnte nicht ins Auto gesetzt werden!", __GetName(i));
				DerbyMSG(string, gstring);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}
	
	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players", "Konnte Derby nicht starten! Zu viele AFK-Spieler");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}
	
	IsDerbyRunning = true;
	
 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i) && !bDerbyAFK[i])
		{
			DerbyWinner[i] = true;
			DerbyPlayers++;
		   	for(new m1s = 0; m1s < sizeof(Derby_Map1Spawns); m1s++)
			{
				if(!Derby_Map1Spawns[m1s][m1sUsed])
		 		{
		 		    Streamer_UpdateEx(i, Derby_Map1Spawns[m1s][m1sX], Derby_Map1Spawns[m1s][m1sY], Derby_Map1Spawns[m1s][m1sZ]);
	    			SetPlayerPos(i, Derby_Map1Spawns[m1s][m1sX], Derby_Map1Spawns[m1s][m1sY], Derby_Map1Spawns[m1s][m1sZ]);
	    		    
	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	    		    
					new vid;
					switch(random(6))
					{
						case 0: vid = 494;
						case 1: vid = 495;
						case 2: vid = 504;
						case 3: vid = 504;
						case 4: vid = 573;
						case 5: vid = 402;
					}
					pDerbyCar[i] = CreateVehicle(vid, Derby_Map1Spawns[m1s][m1sX], Derby_Map1Spawns[m1s][m1sY], floatadd(Derby_Map1Spawns[m1s][m1sZ], 3.5), Derby_Map1Spawns[m1s][m1sA], (random(128) + 127), (random(128) + 127), -1);
                    SetVehicleNumberPlate(pDerbyCar[i], "{3399ff}D{FFFFFF}erb{F81414}Y");
                    SetVehicleToRespawn(pDerbyCar[i]);
					SetVehicleVirtualWorld(pDerbyCar[i], GetPlayerVirtualWorld(i));
					TogglePlayerControllable(i, true);
 					SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
					ClearAnimations(i);
					PutPlayerInVehicle(i,pDerbyCar[i], 0);
					RepairVehicle(pDerbyCar[i]);
					SetCameraBehindPlayer(i);
					GameTextForPlayer(i, "~p~[DERBY]: ~w~Derby ist starting!",3000,5);
					Derby_Map1Spawns[m1s][m1sUsed] = true;
					break;
				}
 			}
		}
 	}
 	ExecDerbyTimer();
 	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

function:StartDerbyMap2()
{
    CurrentDerbyMap = 2;
    new pcount = 0;
	ClearDerbyVotes();
    DerbyMSG("Map 'Truncat' won! Let´s start!", "Map 'Truncat' hat gewonnen! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
		    
	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100], gstring[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
			    format(gstring, sizeof(gstring), "%s konnte nicht ins Auto gesetzt werden!", __GetName(i));
				DerbyMSG(string, gstring);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players", "Konnte Derby nicht starten!Zu viele AFK-Spieler");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}

    IsDerbyRunning = true;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
  		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i) && !bDerbyAFK[i])
		{
			DerbyWinner[i] = true;
			DerbyPlayers++;
			for(new m2s = 0; m2s < sizeof(Derby_Map2Spawns); m2s++)
			{
				if(!Derby_Map2Spawns[m2s][m2sUsed])
	    		{
	    		    Streamer_UpdateEx(i, Derby_Map2Spawns[m2s][m2sX], Derby_Map2Spawns[m2s][m2sY], Derby_Map2Spawns[m2s][m2sZ]);
	    		    SetPlayerPos(i, Derby_Map2Spawns[m2s][m2sX], Derby_Map2Spawns[m2s][m2sY], Derby_Map2Spawns[m2s][m2sZ]);
	    		    
	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	    		    
					new vid;
					switch(random(6))
					{
						case 0: vid = 494;
						case 1: vid = 495;
						case 2: vid = 504;
						case 3: vid = 504;
						case 4: vid = 573;
						case 5: vid = 402;
					}
					pDerbyCar[i] = CreateVehicle(vid, Derby_Map2Spawns[m2s][m2sX], Derby_Map2Spawns[m2s][m2sY], floatadd(Derby_Map2Spawns[m2s][m2sZ], 3.5), Derby_Map2Spawns[m2s][m2sA], (random(128) + 127), (random(128) + 127), -1);
                    SetVehicleNumberPlate(pDerbyCar[i], "{3399ff}D{FFFFFF}erb{F81414}Y");
                    SetVehicleToRespawn(pDerbyCar[i]);
					SetVehicleVirtualWorld(pDerbyCar[i], GetPlayerVirtualWorld(i));
					TogglePlayerControllable(i, true);
 					SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
					ClearAnimations(i);
					PutPlayerInVehicle(i,pDerbyCar[i],0);
					RepairVehicle(pDerbyCar[i]);
					SetCameraBehindPlayer(i);
					GameTextForPlayer(i, "~p~[DERBY]: ~w~Derby ist starting!",3000,5);
					Derby_Map2Spawns[m2s][m2sUsed] = true;
					break;
				}
			}
		}
	}
	ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

function:StartDerbyMap3()
{
    CurrentDerbyMap = 3;
    new pcount = 0;
	ClearDerbyVotes();
	DerbyMSG("Map 'Sky Skiing' won! Let´s start!", "Map 'Sky Skiing' hat gewonnen! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
		    
	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100], gstring[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
			    format(gstring, sizeof(gstring), "%s konnte nicht ins Auto gesetzt werden!", __GetName(i));
				DerbyMSG(string, gstring);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players", "Konnte Derby nicht starten!Zu viele AFK-Spieler");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}

    IsDerbyRunning = true;

    for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i) && !bDerbyAFK[i])
		{
			DerbyWinner[i] = true;
			DerbyPlayers++;
			for(new m3s = 0; m3s < sizeof(Derby_Map3Spawns); m3s++)
			{
				if(!Derby_Map3Spawns[m3s][m3sUsed])
	    		{
	    		    Streamer_UpdateEx(i, Derby_Map3Spawns[m3s][m3sX], Derby_Map3Spawns[m3s][m3sY], Derby_Map3Spawns[m3s][m3sZ]);
	    		    SetPlayerPos(i, Derby_Map3Spawns[m3s][m3sX], Derby_Map3Spawns[m3s][m3sY], Derby_Map3Spawns[m3s][m3sZ]);
	    		    
	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	    		    
					new vid;
					switch(random(6))
					{
						case 0: vid = 494;
						case 1: vid = 495;
						case 2: vid = 504;
						case 3: vid = 504;
						case 4: vid = 573;
						case 5: vid = 402;
					}
					pDerbyCar[i] = CreateVehicle(vid, Derby_Map3Spawns[m3s][m3sX], Derby_Map3Spawns[m3s][m3sY], floatadd(Derby_Map3Spawns[m3s][m3sZ], 3.5), Derby_Map3Spawns[m3s][m3sA], (random(128) + 127), (random(128) + 127), -1);
                    SetVehicleNumberPlate(pDerbyCar[i], "{3399ff}D{FFFFFF}erb{F81414}Y");
                    SetVehicleToRespawn(pDerbyCar[i]);
					SetVehicleVirtualWorld(pDerbyCar[i], GetPlayerVirtualWorld(i));
					TogglePlayerControllable(i, true);
					SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
					ClearAnimations(i);
					PutPlayerInVehicle(i,pDerbyCar[i],0);
					RepairVehicle(pDerbyCar[i]);
					SetCameraBehindPlayer(i);
					GameTextForPlayer(i, "~p~[DERBY]: ~w~Derby ist starting!",3000,5);
					Derby_Map3Spawns[m3s][m3sUsed] = true;
					break;
				}
			}
		}
	}
    ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

function:StartDerbyMap4()
{
    CurrentDerbyMap = 4;
    new pcount = 0;
	ClearDerbyVotes();
	DerbyMSG("Map 'Townhall' won! Let´s start!", "Map 'Townhall' hat gewonnen! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
		    
	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100], gstring[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
			    format(gstring, sizeof(gstring), "%s konnte nicht ins Auto gesetzt werden!", __GetName(i));
				DerbyMSG(string, gstring);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players", "Konnte Derby nicht starten!Zu viele AFK-Spieler");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}

    IsDerbyRunning = true;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i) && !bDerbyAFK[i])
		{
			DerbyWinner[i] = true;
			DerbyPlayers++;
			for(new m4s = 0; m4s < sizeof(Derby_Map4Spawns); m4s++)
			{
				if(!Derby_Map4Spawns[m4s][m4sUsed])
	    		{
	    		    Streamer_UpdateEx(i, Derby_Map4Spawns[m4s][m4sX], Derby_Map4Spawns[m4s][m4sY], Derby_Map4Spawns[m4s][m4sZ]);
	    		    SetPlayerPos(i, Derby_Map4Spawns[m4s][m4sX], Derby_Map4Spawns[m4s][m4sY], Derby_Map4Spawns[m4s][m4sZ]);
	    		    
	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	    		    
					new vid;
					switch(random(6))
					{
						case 0: vid = 494;
						case 1: vid = 495;
						case 2: vid = 504;
						case 3: vid = 504;
						case 4: vid = 573;
						case 5: vid = 402;
					}
					pDerbyCar[i] = CreateVehicle(vid, Derby_Map4Spawns[m4s][m4sX], Derby_Map4Spawns[m4s][m4sY], floatadd(Derby_Map4Spawns[m4s][m4sZ], 3.5), Derby_Map4Spawns[m4s][m4sA], (random(128) + 127), (random(128) + 127), -1);
                    SetVehicleNumberPlate(pDerbyCar[i], "{3399ff}D{FFFFFF}erb{F81414}Y");
                    SetVehicleToRespawn(pDerbyCar[i]);
					SetVehicleVirtualWorld(pDerbyCar[i], GetPlayerVirtualWorld(i));
					TogglePlayerControllable(i, true);
					SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
					ClearAnimations(i);
					PutPlayerInVehicle(i, pDerbyCar[i], 0);
					RepairVehicle(pDerbyCar[i]);
					SetCameraBehindPlayer(i);
					GameTextForPlayer(i, "~p~[DERBY]: ~w~Derby ist starting!",3000,5);
					Derby_Map4Spawns[m4s][m4sUsed] = true;
					break;
				}
			}
		}
	}
    ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

function:StartDerbyMap5()
{
    CurrentDerbyMap = 5;
    new pcount = 0;
	ClearDerbyVotes();
	DerbyMSG("Map 'Glazz' won! Let´s start!", "Map 'Glazz' hat gewonnen! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100], gstring[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
			    format(gstring, sizeof(gstring), "%s konnte nicht ins Auto gesetzt werden!", __GetName(i));
				DerbyMSG(string, gstring);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players", "Konnte Derby nicht starten!Zu viele AFK-Spieler");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}

    IsDerbyRunning = true;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i) && !bDerbyAFK[i])
		{
			DerbyWinner[i] = true;
			DerbyPlayers++;
			for(new m5s = 0; m5s < sizeof(Derby_Map5Spawns); m5s++)
			{
				if(!Derby_Map5Spawns[m5s][m5sUsed])
	    		{
	    		    Streamer_UpdateEx(i, Derby_Map5Spawns[m5s][m5sX], Derby_Map5Spawns[m5s][m5sY], Derby_Map5Spawns[m5s][m5sZ]);
	    		    SetPlayerPos(i, Derby_Map5Spawns[m5s][m5sX], Derby_Map5Spawns[m5s][m5sY], Derby_Map5Spawns[m5s][m5sZ]);

	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

					new vid;
					switch(random(6))
					{
						case 0: vid = 494;
						case 1: vid = 495;
						case 2: vid = 504;
						case 3: vid = 504;
						case 4: vid = 573;
						case 5: vid = 402;
					}
					pDerbyCar[i] = CreateVehicle(vid, Derby_Map5Spawns[m5s][m5sX], Derby_Map5Spawns[m5s][m5sY], floatadd(Derby_Map5Spawns[m5s][m5sZ], 3.5), Derby_Map5Spawns[m5s][m5sA], (random(128) + 127), (random(128) + 127), -1);
                    SetVehicleNumberPlate(pDerbyCar[i], "{3399ff}D{FFFFFF}erb{F81414}Y");
                    SetVehicleToRespawn(pDerbyCar[i]);
					SetVehicleVirtualWorld(pDerbyCar[i], GetPlayerVirtualWorld(i));
					TogglePlayerControllable(i, true);
					SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
					ClearAnimations(i);
					PutPlayerInVehicle(i, pDerbyCar[i], 0);
					RepairVehicle(pDerbyCar[i]);
					SetCameraBehindPlayer(i);
					GameTextForPlayer(i, "~p~[DERBY]: ~w~Derby ist starting!",3000,5);
					Derby_Map5Spawns[m5s][m5sUsed] = true;
					break;
				}
			}
		}
	}
    ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

function:StartDerbyMap6()
{
    CurrentDerbyMap = 6;
    new pcount = 0;
	ClearDerbyVotes();
	DerbyMSG("Map 'Rambo' won! Let´s start!", "Map 'Rambo' hat gewonnen! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100], gstring[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
			    format(gstring, sizeof(gstring), "%s konnte nicht ins Auto gesetzt werden!", __GetName(i));
				DerbyMSG(string, gstring);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players", "Konnte Derby nicht starten!Zu viele AFK-Spieler");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}

    IsDerbyRunning = true;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i) && !bDerbyAFK[i])
		{
			DerbyWinner[i] = true;
			DerbyPlayers++;
			for(new m6s = 0; m6s < sizeof(Derby_Map6Spawns); m6s++)
			{
				if(!Derby_Map6Spawns[m6s][m6sUsed])
	    		{
	    		    Streamer_UpdateEx(i, Derby_Map6Spawns[m6s][m6sX], Derby_Map6Spawns[m6s][m6sY], Derby_Map6Spawns[m6s][m6sZ]);
	    		    SetPlayerPos(i, Derby_Map6Spawns[m6s][m6sX], Derby_Map6Spawns[m6s][m6sY], Derby_Map6Spawns[m6s][m6sZ]);

	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

					pDerbyCar[i] = CreateVehicle(573, Derby_Map6Spawns[m6s][m6sX], Derby_Map6Spawns[m6s][m6sY], floatadd(Derby_Map6Spawns[m6s][m6sZ], 3.5), Derby_Map6Spawns[m6s][m6sA], (random(128) + 127), (random(128) + 127), -1);
                    SetVehicleNumberPlate(pDerbyCar[i], "{3399ff}D{FFFFFF}erb{F81414}Y");
                    SetVehicleToRespawn(pDerbyCar[i]);
					SetVehicleVirtualWorld(pDerbyCar[i], GetPlayerVirtualWorld(i));
					TogglePlayerControllable(i, true);
					SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
					ClearAnimations(i);
					PutPlayerInVehicle(i, pDerbyCar[i], 0);
					RepairVehicle(pDerbyCar[i]);
					SetCameraBehindPlayer(i);
					GameTextForPlayer(i, "~p~[DERBY]: ~w~Derby ist starting!", 3000, 5);
					Derby_Map6Spawns[m6s][m6sUsed] = true;
					break;
				}
			}
		}
	}
    ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

function:Derby()
{
    IsDerbyRunning = false;
    KillTimer(tDerbyTimer);
    KillTimer(tDerbyFallOver);
    ClearDerbySpawns();
	ClearDerbyVotes();
	ResetDerbyGameTime();
	ExecDerbyVotingTimer();

	if(DerbyPlayers > 1)
	{
    	for(new i = 0; i < MAX_PLAYERS; i++)
    	{
  			if(gTeam[i] == DERBY)
			{
			    RemovePlayerFromVehicle(i);
			    if(pDerbyCar[i] != -1)
			    {
			    	DestroyVehicle(pDerbyCar[i]);
			    	pDerbyCar[i] = -1;
				}
       			SetPlayerVirtualWorld(i, DERBY_WORLD);
       			SetPlayerDerbyStaticMeshes(i);
				TogglePlayerControllable(i, false);
				ShowDialog(i, DERBY_VOTING_DIALOG);
			}
		}
  		LangMSGToAll(-1, ""derby_sign" No winner! new round starting soon. Join with /derby", ""derby_sign" Keine Gewinner! Neue Runde startet bald. Join mit /derby");
	}
	else if(DerbyPlayers == 1)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
    	{
			if(gTeam[i] == DERBY && !bDerbyAFK[i])
			{
			    if(DerbyWinner[i])
			    {
			    	PlayerInfo[i][DerbyWins]++;
			    	
					new
						money = (1000 * CurrentDerbyPlayers),
						score = floatround(floatdiv(2 * CurrentDerbyPlayers, 1.5)),
						astring[128],
						string[128],
						gstring[128];
						
					if(PlayerInfo[i][DerbyWins] == 10)
					{
					    GivePlayerCash(i, 20000);
					    GameTextForPlayer(i, "+$20,000", 3000, 1);
					    SendClientMessage(i, YELLOW, "Info: "white"Achievement unlocked! (Win 10 Derbys)");
					}
						
			    	GivePlayerCash(i, money);
			    	format(astring, sizeof(astring), "+$%i~n~+%i Score~n~+1 Derby win", money, score);
			    	_GivePlayerScore(i, score);
			    	GameTextForPlayer(i, astring, 3000, 1);
			    	DerbyWinner[i] = false;
			    	format(string, sizeof(string), "%s won the Derby and earned "orange"$%i", __GetName(i), money);
			    	format(gstring, sizeof(gstring), "%s hat das Derby gewonnen und "orange"$%i "white"verdient!", __GetName(i), money);
					DerbyMSG(string, gstring);
	   			}
			    if(pDerbyCar[i] != -1)
			    {
			    	DestroyVehicle(pDerbyCar[i]);
			    	pDerbyCar[i] = -1;
				}
	   			TogglePlayerControllable(i, false);
				SetPlayerDerbyStaticMeshes(i);
	      		ShowDialog(i, DERBY_VOTING_DIALOG);
			}
		}
	}
	DerbyPlayers = 0;
	CurrentDerbyPlayers = 0;
	for(new i = 0; i < MAX_PLAYERS; i++)
   	{
		if(gTeam[i] == DERBY)
		{
		    if(bDerbyAFK[i])
		    {
		        if(IsPlayerOnDesktop(i, 1300))
		        {
		            continue;
		        }
		        else CurrentDerbyPlayers++;
		    }
		    else CurrentDerbyPlayers++;
		}
	}
	ClearDerbyAfkPlayers();
	return 1;
}

function:DerbyFallOver()
{
	new CURRENT_FALLOVER;
	switch(CurrentDerbyMap)
	{
	    case 1 : CURRENT_FALLOVER = DERBY_FALLOVER_M1;
	    case 2 : CURRENT_FALLOVER = DERBY_FALLOVER_M2; // <-- ;) ?
	    case 3 : CURRENT_FALLOVER = DERBY_FALLOVER_M3; // <-- ;) ? wasch war da falsch    -> http://www.youtube.com/watch?v=1zrtdDQlYOY
	    case 4 : CURRENT_FALLOVER = DERBY_FALLOVER_M4;
	    case 5 : CURRENT_FALLOVER = DERBY_FALLOVER_M5;
	    case 6 : CURRENT_FALLOVER = DERBY_FALLOVER_M6;
	}
	new Float:POS[3], string[64], gstring[64];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && DerbyWinner[i])
		{
		    if(bDerbyAFK[i]) continue;
		    
		    if(IsPlayerOnDesktop(i, 4000))
			{
	   			TogglePlayerControllable(i, true);
			    if(pDerbyCar[i] != -1)
			    {
			        SetVehiclePos(pDerbyCar[i], 0.0, 0.0, 15.0);
					RemovePlayerFromVehicle(i);
					DestroyVehicle(pDerbyCar[i]);
			    	pDerbyCar[i] = -1;
				}
				format(string, sizeof(string), "%s was kicked out of derby (AFK)", __GetName(i));
				format(gstring, sizeof(gstring), "%s wurde aus dem Derby gekickt (AFK)", __GetName(i));
                DerbyMSG(string, gstring);
				DerbyPlayers--;
	 			DerbyWinner[i] = false;
				SetPlayerDerbyStaticMeshes(i);
	   			TogglePlayerControllable(i, false);
				SetPlayerVirtualWorld(i, 12345); // <bla>
	  			if((DerbyPlayers == 1) && (IsDerbyRunning))
	  			{
					Derby();
	  			}
	  			continue;
		    }
		    
			if(GetPlayerPos(i, POS[0], POS[1], POS[2]))
			{
				if(POS[2] <= CURRENT_FALLOVER)
				{
					format(string, sizeof(string), "%s fell over the map!", __GetName(i));
					format(gstring, sizeof(gstring), "%s ist von der Map gefallen!", __GetName(i));
					DerbyMSG(string, gstring);
		 			DerbyPlayers--;
     			    if(pDerbyCar[i] != -1)
				    {
						DestroyVehicle(pDerbyCar[i]);
				    	pDerbyCar[i] = -1;
					}
		 			DerbyWinner[i] = false;
		   			TogglePlayerControllable(i, false);
					SetPlayerDerbyStaticMeshes(i);
		  			if((DerbyPlayers == 1) && (IsDerbyRunning))
		  			{
						Derby();
		  			}
				}
            }
		}
	}
}

function:PlayerUpdate(playerid)
{
	if(gTeam[playerid] == RACE)
	{
	    new tmp[255];
		if(RaceStatus == RaceStatus_Active)
		{
  			if(RaceJoinCount == 1)
  			{
                format(tmp, sizeof(tmp), "position: ~r~1/1~n~~w~checkpoint: ~b~%i/%i~n~~w~players: ~g~%i/12~n~~w~map: ~y~%s~n~~w~timeleft: ~r~%s", CPProgess[playerid], TotalRaceCP, RaceJoinCount, RaceName, GameTimeConvert(RaceTime));
			} else format(tmp, sizeof(tmp), "position: ~r~%i/%i~n~~w~checkpoint: ~b~%i/%i~n~~w~players: ~g~%i/12~n~~w~map: ~y~%s~n~~w~timeleft: ~r~%s", RacePosition[playerid], RaceJoinCount, CPProgess[playerid], TotalRaceCP, RaceJoinCount, RaceName, GameTimeConvert(RaceTime));
		}
		else if(RaceStatus == RaceStatus_StartUp) format(tmp, sizeof(tmp), "position: ~r~-/-~n~~w~checkpoint: ~b~-/-~n~~w~players: ~g~%i/12~n~~w~map: ~y~%s~n~~w~timeleft: ~r~--:--", RaceJoinCount, RaceName);

		PlayerTextDrawSetString(playerid, RaceInfo[playerid], tmp);
	}
	else if(gTeam[playerid] == GUNGAME)
	{
	    new wp[32], tmp[128], tmp2 = GetPlayerWeapon(playerid);
	    GetWeaponName(tmp2, wp, sizeof(wp));
	    format(tmp, sizeof(tmp), "players: ~b~%i~n~~w~level: ~r~%i of 14~n~~w~weapon:~n~~g~%s", GunGamePlayers, GunGame_Player[playerid][level], wp);
	    PlayerTextDrawSetString(playerid, TXTGunGameInfo[playerid], tmp);
	}
	return 1;
}

function:GlobTDUpdate()
{
	new tmp[156];

	if(g_FalloutStatus != e_Fallout_Inactive)
	{
	    switch(g_FalloutStatus)
	    {
	        case e_Fallout_Startup : format(tmp, sizeof(tmp), "timeleft: ~r~--:--~n~~w~players:~b~ %i~n~~w~status:~n~~g~startup", CurrentFalloutPlayers);
	        case e_Fallout_Running :
	        {
		        FalloutGameTime--;
				format(tmp, sizeof(tmp), "timeleft: ~r~%s~n~~w~players:~b~ %i~n~~w~status:~n~~g~playing", GameTimeConvert(FalloutGameTime), CurrentFalloutPlayers);
    		}
		}
		TextDrawSetString(TXTFalloutInfo, tmp);
	}

	if(CurrentBGMap != BG_VOTING)
	{
		BGGameTime--;
		new bg_players = BGTeam1Players + BGTeam2Players;
		switch(CurrentBGMap)
		{
		    case BG_MAP1 : format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Forest~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
		    case BG_MAP2 : format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Quaters~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
            case BG_MAP3 : format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Rust~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
            case BG_MAP4 : format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Italy~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
            case BG_MAP5 : format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Medieval~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
		}
		TextDrawSetString(TXTBGInfo, tmp);

	} else TextDrawSetString(TXTBGInfo, "timelft: ~r~--:--~n~~w~players:~b~ --/20~n~~w~Map: ~g~Voting~n~~w~Rangers Kills:~n~~y~---~n~~w~Spetsnaz Kills:~n~~y~---");

	if(IsDerbyRunning)
	{
 		DerbyGameTime--;
   		switch(CurrentDerbyMap)
	    {
			case 1: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~Lighthouse", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		    case 2: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~Truncat", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		    case 3: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~SkySkiing", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		    case 4: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~Townhall", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		    case 5: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~Glazz", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		    case 6: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~Rambo", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		}
		TextDrawSetString(TXTDerbyInfo, tmp);

	} else TextDrawSetString(TXTDerbyInfo, "Timeleft: ~r~--:--~n~~w~players:~b~ --/--~n~~w~Map:~n~~g~Voting");

    return 1;
}

ResetBGGameTime()
{
	BGGameTime = DEFAULT_BG_TIME;
	return 1;
}

ResetFalloutGameTime()
{
	FalloutGameTime = DEFAULT_FALLOUT_TIME;
	return 1;
}

ResetDerbyGameTime()
{
	DerbyGameTime = DEFAULT_DERBY_TIME;
	return 1;
}

function:ClearDerbyVotes()
{
	DerbyMapVotes[0] = 0;
	DerbyMapVotes[1] = 0;
	DerbyMapVotes[2] = 0;
	DerbyMapVotes[3] = 0;
	DerbyMapVotes[4] = 0;
	DerbyMapVotes[5] = 0;
	return 1;
}

function:ExecGlobTDUpdateTimer()
{
	KillTimer(tGlobTDUpdate);
	tGlobTDUpdate = SetTimer("GlobTDUpdate", GLOB_TDUPDATE_TIME, true);
	return 1;
}

function:ExecDerbyVotingTimer()
{
	KillTimer(tDerbyVoting);
	tDerbyVoting = SetTimer("DerbyVoting", DERBY_VOTING_TIME, false);
	return 1;
}

function:ExecDerbyTimer()
{
	KillTimer(tDerbyTimer);
    tDerbyTimer = SetTimer("Derby", DERBY_TIME, false);
    return 1;
}

function:ClearDerbySpawns()
{
	for(new i = 0; i < sizeof(Derby_Map1Spawns); i++)
	{
	    Derby_Map1Spawns[i][m1sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map2Spawns); i++)
	{
	    Derby_Map2Spawns[i][m2sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map3Spawns); i++)
	{
	    Derby_Map3Spawns[i][m3sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map4Spawns); i++)
	{
	    Derby_Map4Spawns[i][m4sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map5Spawns); i++)
	{
	    Derby_Map5Spawns[i][m5sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map6Spawns); i++)
	{
	    Derby_Map6Spawns[i][m6sUsed] = false;
	}
	return 1;
}

function:SetPlayerDerbyStaticMeshes(playerid)
{
    TogglePlayerControllable(playerid, false);
    SetPlayerHealth(playerid, 99999.0);
    switch(CurrentDerbyMap)
    {
		case 1 :
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M1);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M1);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M1);
		}
		case 2 :
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M2);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M2);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M2);
		}
		case 3 :
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M3);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M3);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M3);
		}
		case 4 :
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M4);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M4);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M4);
		}
		case 5 :
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M5);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M5);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M5);
		}
		case 6 :
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M6);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M6);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M6);
		}
	}
}

UpdateHP(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new Float:HP,
			veh;
	 	veh = GetPlayerVehicleID(playerid);
		GetVehicleHealth(veh, HP);
		if(HP != OldHealth[playerid])
		{
			OldDamage[playerid] = OldHealth[playerid] - HP;
			OldHealth[playerid] = HP;

			if(OldDamage[playerid] > 0)
			{
				new texts[128];
				if(LabelActive[playerid])
				{
					CDamage[playerid] += OldDamage[playerid];
					format(texts, sizeof(texts), "{ffd800}-%.0f\n%s", CDamage[playerid], UpdateString(HP));
					KillTimer(PlayerInfo[playerid][tTimerHP]);
					PlayerInfo[playerid][tTimerHP] = SetTimerEx("DeleteDerbyText", 2000, false, "i", playerid);
				}
				else
				{
					LabelActive[playerid] = true;
					format(texts, sizeof(texts), "{ffd800}-%.0f\n%s",OldDamage[playerid],UpdateString(HP));
					PlayerInfo[playerid][tTimerHP] = SetTimerEx("DeleteDerbyText", 2000, false, "i", playerid);
				}
				UpdatePlayer3DTextLabelText(playerid, DerbyVehLabel[playerid], -1, texts);
			}
		}
	}
	return 1;
}

UpdateBar(playerid)
{
	new Float:HP;
	GetVehicleHealth(GetPlayerVehicleID(playerid), HP);
	UpdatePlayer3DTextLabelText(playerid, DerbyVehLabel[playerid], -1, UpdateString(HP));
	return 1;
}

UpdateString(Float:HP)
{
	new str[30];
	if(HP == 1000) format(str, sizeof(str), "{00ff00}••••••••••");
	else if(HP >= 900) format(str, sizeof(str), "{66ff00}•••••••••{ffffff}•");
	else if(HP >= 800) format(str, sizeof(str), "{7fff00}••••••••{ffffff}••");
	else if(HP >= 700) format(str, sizeof(str), "{ccff00}•••••••{ffffff}•••");
	else if(HP >= 600) format(str, sizeof(str), "{f7f21a}••••••{ffffff}••••");
	else if(HP >= 500) format(str, sizeof(str), "{f4c430}•••••{ffffff}•••••");
	else if(HP >= 400) format(str, sizeof(str), "{e49b0f}••••{ffffff}••••••");
	else if(HP >= 300) format(str, sizeof(str), "{e4650e}•••{ffffff}•••••••");
	else if(HP >= 250) format(str, sizeof(str), "{ff2400}••{ffffff}••••••••");
	else format(str, sizeof(str), "{ff2400}Boom!");
	return str;
}

function:DeleteDerbyText(playerid)
{
	KillTimer(PlayerInfo[playerid][tTimerHP]);
	LabelActive[playerid] = false;
	UpdateBar(playerid);
	CDamage[playerid] = 0;
}

SetPlayerBGTeam1(playerid)
{
    ResetPlayerWeapons(playerid);
	SetPlayerSkin(playerid, 285);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerTeam(playerid, 10);
	SetPlayerColor(playerid, BLUE);
	GivePlayerWeapon(playerid, 24, 999999);
	GivePlayerWeapon(playerid, 31, 999999);
	GivePlayerWeapon(playerid, 34, 999999);
	switch(random(3))
	{
	    case 0 : return 1;
		case 1 : GivePlayerWeapon(playerid, 35, 1);
		case 2 : return 1;
	}
	return 1;
}

SetPlayerBGTeam2(playerid)
{
	ResetPlayerWeapons(playerid);
	SetPlayerSkin(playerid, 122);
	SetPlayerHealth(playerid, 100.0);
	SetPlayerTeam(playerid, 20);
	SetPlayerColor(playerid, RED);
	GivePlayerWeapon(playerid, 24, 999999);
	GivePlayerWeapon(playerid, 30, 999999);
	GivePlayerWeapon(playerid, 34, 999999);
	switch(random(3))
	{
	    case 0 : return 1;
		case 1 : GivePlayerWeapon(playerid, 35, 1);
		case 2 : return 1;
	}
	return 1;
}

ShowPlayerGunGameTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
    TextDrawHideForPlayer(playerid, TXTKeyInfo);
    PlayerTextDrawHide(playerid, TXTWanteds[playerid]);
	TextDrawShowForPlayer(playerid, TXTGunGameBox);
	TextDrawShowForPlayer(playerid, TXTGunGameSign);
	PlayerTextDrawShow(playerid, TXTGunGameInfo[playerid]);
}

HidePlayerGunGameTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawShowForPlayer(playerid, TXTKeyInfo);
	PlayerTextDrawShow(playerid, TXTWanteds[playerid]);
	TextDrawHideForPlayer(playerid, TXTGunGameBox);
	TextDrawHideForPlayer(playerid, TXTGunGameSign);
	PlayerTextDrawHide(playerid, TXTGunGameInfo[playerid]);
}

HidePlayerRaceTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
    TextDrawShowForPlayer(playerid, TXTKeyInfo);
    PlayerTextDrawShow(playerid, TXTWanteds[playerid]);
	TextDrawHideForPlayer(playerid, TXTRaceSign);
	TextDrawHideForPlayer(playerid, TXTRaceBox);
	PlayerTextDrawHide(playerid, RaceInfo[playerid]);
}

ShowPlayerRaceTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
    TextDrawHideForPlayer(playerid, TXTKeyInfo);
    PlayerTextDrawHide(playerid, TXTWanteds[playerid]);
	TextDrawShowForPlayer(playerid, TXTRaceSign);
	TextDrawShowForPlayer(playerid, TXTRaceBox);
	PlayerTextDrawShow(playerid, RaceInfo[playerid]);
}

ShowPlayerToyTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTToyBox);
	TextDrawShowForPlayer(playerid, TXTToyInfo);
}

HidePlayerToyTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTToyBox);
	TextDrawHideForPlayer(playerid, TXTToyInfo);
}

ShowPlayerDerbyTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
    TextDrawHideForPlayer(playerid, TXTKeyInfo);
    PlayerTextDrawHide(playerid, TXTWanteds[playerid]);
	TextDrawShowForPlayer(playerid, TXTDerbyBox);
	TextDrawShowForPlayer(playerid, TXTDerbyInfo);
	TextDrawShowForPlayer(playerid, TXTDerbyBoxSign);
}

HidePlayerDerbyTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawShowForPlayer(playerid, TXTKeyInfo);
	PlayerTextDrawShow(playerid, TXTWanteds[playerid]);
	TextDrawHideForPlayer(playerid, TXTDerbyBox);
	TextDrawHideForPlayer(playerid, TXTDerbyInfo);
	TextDrawHideForPlayer(playerid, TXTDerbyBoxSign);
}

ShowPlayerBGTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
	TextDrawHideForPlayer(playerid, TXTKeyInfo);
	PlayerTextDrawHide(playerid, TXTWanteds[playerid]);
	TextDrawShowForPlayer(playerid, TXTBGBox);
	TextDrawShowForPlayer(playerid, TXTBGInfo);
	TextDrawShowForPlayer(playerid, TXTBGSign);
}

HidePlayerBGTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawShowForPlayer(playerid, TXTKeyInfo);
	PlayerTextDrawShow(playerid, TXTWanteds[playerid]);
	TextDrawHideForPlayer(playerid, TXTBGInfo);
	TextDrawHideForPlayer(playerid, TXTBGSign);
	TextDrawHideForPlayer(playerid, TXTBGBox);
}

ShowPlayerFalloutTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
	TextDrawHideForPlayer(playerid, TXTKeyInfo);
	PlayerTextDrawHide(playerid, TXTWanteds[playerid]);
	TextDrawShowForPlayer(playerid, TXTFalloutBox);
	TextDrawShowForPlayer(playerid, TXTFalloutInfo);
	TextDrawShowForPlayer(playerid, TXTFalloutSign);
}

HidePlayerFalloutTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawShowForPlayer(playerid, TXTKeyInfo);
	PlayerTextDrawShow(playerid, TXTWanteds[playerid]);
	TextDrawHideForPlayer(playerid, TXTFalloutBox);
	TextDrawHideForPlayer(playerid, TXTFalloutInfo);
	TextDrawHideForPlayer(playerid, TXTFalloutSign);
}

HidePlayerDMTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
    TextDrawShowForPlayer(playerid, TXTKeyInfo);
    PlayerTextDrawShow(playerid, TXTWanteds[playerid]);
}

ShowPlayerDMTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
    TextDrawHideForPlayer(playerid, TXTKeyInfo);
    PlayerTextDrawHide(playerid, TXTWanteds[playerid]);
}

HidePlayerInfoTextdraws(playerid)
{
	TextDrawHideForPlayer(playerid, TXTInfo);
}

ShowPlayerInfoTextdraws(playerid)
{
	TextDrawShowForPlayer(playerid, TXTInfo);
}

Fallout_BuildMap()
{
	for(new i = 0; i < 101; i++)
	{
		DestroyDynamicObject(Info[I_iObject][i]);
		Info[I_iNumberout][i] = -1;
		KillTimer(Info[I_iShaketimer][i]);
		KillTimer(Info[I_iTimer][0]);
		Info[I_iShake][i] = 0;
	}

	new j;
	Info[I_iCount] = 15;
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1660.4783, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1655.1112, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1649.7442, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1644.3772, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1639.0102, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1633.6432, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1628.2762, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1622.9092, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1617.5422, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2482.1921, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2477.7395, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2473.2869, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2468.8343, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2464.3817, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2459.9291, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2455.4765, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2451.0239, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2446.5713, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	Info[I_iObject][j++] = CreateDynamicObject(1697, 2442.1187, -1612.1752, 160.0000, 31.8000, 0.0000, 0.0000);
	return 1;
}

Fallout_StartGame()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		PlayerInfo[i][FalloutLost] = false;
	    if(gTeam[i] == FALLOUT)
		{
			SetPlayerHealth(i, 100.0);
	    }
	}

	Info[I_iTimer][1] = SetTimer("FalloutCountDown", 1000, true);

	LangMSGToAll(-1, ""grey"A new fallout game has started!", ""grey"Eine neue Runde Fallout wurde gestartet!");
	return 1;
}

Fallout_SetPlayer(playerid)
{
	SetPlayerPos(playerid, 2482.1921 - random(39), -1660.4783 + random(47), 161.0000);
	SetPlayerFacingAngle(playerid, random(360));
	Streamer_Update(playerid);
	TogglePlayerControllable(playerid, false);
	SetCameraBehindPlayer(playerid);
	SetPlayerVirtualWorld(playerid, FALLOUT_WORLD);
	ShowPlayerFalloutTextdraws(playerid);
	ResetPlayerWeapons(playerid);
}

Fallout_Cancel()
{
    CurrentFalloutPlayers = 0;
	g_FalloutStatus = e_Fallout_Inactive;
	for(new i = 0; i < 101; i++)
	{
		DestroyDynamicObject(Info[I_iObject][i]);
		Info[I_iNumberout][i] = -1;
		KillTimer(Info[I_iShaketimer][i]);
		Info[I_iShake][i] = 0;
	}
	KillTimer(Info[I_iTimer][0]);
	KillTimer(Info[I_tLoseGame]);
	return 1;
}

function:Fallout_LoseGame()
{
	new players,
		Float:POS[3];

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] != FALLOUT) continue;
		if(PlayerInfo[i][FalloutLost]) continue;

		GetPlayerPos(i, POS[0], POS[1], POS[2]);

		if(POS[2] <= 158.0 && !PlayerInfo[i][FalloutLost])
		{
			GameTextForPlayer(i, "~p~You lost the Fallout!", 3000, 1);
			
			new string[100], gstring[100];
			format(string, sizeof(string), "%s fell over the glass bottom!", __GetName(i));
			format(gstring, sizeof(gstring), "%s ist heruntergefallen!", __GetName(i));
			FalloutMSG(string, gstring);
			
			PlayerInfo[i][FalloutLost] = true;
			HidePlayerFalloutTextdraws(i);
			CurrentFalloutPlayers--;
			ResetPlayerWorld(i);
			gTeam[i] = NORMAL;
			RandomSpawn(i);
		}
		else
		{
		    players++;
		}
	}

	if(players <= 1 && g_FalloutStatus == e_Fallout_Running)
	{
	    g_FalloutStatus = e_Fallout_Finish;
		SetTimer("DecideFalloutWinners", 1500, 0);
	}
	return 1;
}

function:FalloutCountDown()
{
	new player, string[100];

	Info[I_iCount]--;

	if(Info[I_iCount] == 0)
	{
		format(string, sizeof(string), "~b~Start!");
	}
	else
	{
		format(string, sizeof(string), "~y~FALLOUT STARTING IN~n~~p~- %i -~n~~y~SECONDS", Info[I_iCount]);
	}

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == FALLOUT)
		{
			GameTextForPlayer(i, string, 999, 3);
	    }
	}

	if(Info[I_iCount] <= 0)
	{
		KillTimer(Info[I_iTimer][1]);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == FALLOUT)
			{
				Streamer_Update(i);
				TogglePlayerControllable(i, true);
				PlayerInfo[i][FalloutLost] = false;
				player++;
		    }
		}

		if(player <= 1)
		{
		    Fallout_Cancel();

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(gTeam[i] == FALLOUT)
				{
			        HidePlayerFalloutTextdraws(i);
			        ResetPlayerWorld(i);
			        LangMSG(i, RED, "Fallout canceld due to lack of players!", "Fallout abbruch, da zu wenig Spieler!");
                    RandomSpawn(i);
					RandomWeapon(i);
			        gTeam[i] = NORMAL;
			    }
			}
		}
		else
		{
			SetTimer("StartFalling", 587, 0);
			g_FalloutStatus = e_Fallout_Running;
		}
	}
	return 1;
}

function:SolarFall()
{
	new objectid, go;
	for(new i = 0; i < 101; i++) if(Info[I_iNumberout][i] == -1) go++;

	if(go == 3)
	{
		if(g_FalloutStatus == e_Fallout_Running)
		{
			g_FalloutStatus = e_Fallout_Finish;
			SetTimer("DecideFalloutWinners", 200, 0);
		}
		KillTimer(Info[I_iTimer][0]);
		return 1;
	}

	start:
	objectid = random(101);

	if(Info[I_iNumberout][objectid] != -1) goto start;

	Info[I_iNumberout][objectid] = 0;

	Info[I_iShaketimer][objectid] = SetTimerEx("SquareShake", 100, 1, "i", objectid);
	return 1;
}

function:StartFalling()
{
	Info[I_iTimer][0] = SetTimer("SolarFall", 500, 1);
	Info[I_tLoseGame] = SetTimer("Fallout_LoseGame", 500, 1);
	return 1;
}

function:DecideFalloutWinners()
{
	g_FalloutStatus = e_Fallout_Inactive;

	new string[128],
		winners,
		money;
		
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
		{
		    if(gTeam[i] != FALLOUT) continue;
		    HidePlayerFalloutTextdraws(i);
		    ResetPlayerWorld(i);
			if(!PlayerInfo[i][FalloutLost])
			{
				winners++;

				format(string, sizeof(string), ""fallout_sign" Winner(s): %i. %s", winners, __GetName(i));
				SendClientMessageToAll(YELLOW, string);

				money = (500 * CurrentFalloutPlayers);
                GivePlayerCash(i, money);
				_GivePlayerScore(i, 5);
		    	format(string, sizeof(string), "+$%i~n~+5 Score~n~+1 Fallout win", money);
		    	GameTextForPlayer(i, string, 3000, 1);
				PlayerInfo[i][FalloutWins]++;
				
				if(PlayerInfo[i][FalloutWins] == 20)
				{
				    GivePlayerCash(i, 20000);
				    GameTextForPlayer(i, "+$20,000", 3000, 1);
				    SendClientMessage(i, YELLOW, "Info: "white"Achievement unlocked! (Win 20 Fallout)");
				}

				gTeam[i] = NORMAL;
				SpawnPlayer(i);
			}
		}
	}
	Fallout_Cancel();

	if(winners == 0) FalloutMSG(""white"There are no winners this round!", ""white"Es gibt keine Gewinner in dieser Runde!");
	return 1;
}

function:SquareShake(objectid)
{
	if(objectid == 0)
	{
		return KillTimer(Info[I_iShaketimer][objectid]);
	}

	switch(Info[I_iShake][objectid])
	{
		case 0, 5:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid], 31.8, 2, 0);
		}
		case 1, 6:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid], 33.8, 0, 0);
		}
		case 2, 7:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid], 31.8, -2, 0);
		}
		case 3, 8:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid], 29.8, 0, 0);
		}
		case 4, 9:
		{
			SetDynamicObjectRot(Info[I_iObject][objectid], 31.8, 0, 0);
		}
		case 10:
		{
			new Float:patPOS[3];
			GetDynamicObjectPos(Info[I_iObject][objectid], patPOS[0], patPOS[1], patPOS[2]);
			MoveDynamicObject(Info[I_iObject][objectid], patPOS[0], patPOS[1], floatsub(patPOS[2], 100.0), 4);
		}
		case 11..99:
		{
  			SetDynamicObjectPos(Info[I_iObject][objectid], floatsub(31.8, floatsub((Info[I_iShake][objectid] * 2), 20)), 0, 0);
		}
		case 100:
		{
			DestroyDynamicObject(Info[I_iObject][objectid]);

			KillTimer(Info[I_iShaketimer][objectid]);
		}
	}

	Info[I_iShake][objectid]++;
	return 1;
}

function:ModVehicleColor(playerid)
{
	new
	    color1,
	    color2;
	    
	color1 = PlayerInfoVeh[playerid][Color1] != 0 ? PlayerInfoVeh[playerid][Color1] : 0;
	color2 = PlayerInfoVeh[playerid][Color2] != 0 ? PlayerInfoVeh[playerid][Color2] : 0;
	
	ChangeVehicleColor(PlayerInfo[playerid][PV_Vehicle], color1, color2);
	return 1;
}

function:ModVehiclePaintJob(playerid)
{
	if(PlayerInfoVeh[playerid][PaintJob] != -1)
	{
		ChangeVehiclePaintjob(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][PaintJob]);
	}
	return 1;
}

function:ModVehicleComponents(playerid)
{
	if(PlayerInfoVeh[playerid][Mod1] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod1]);
	}

	if(PlayerInfoVeh[playerid][Mod2] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod2]);
	}

	if(PlayerInfoVeh[playerid][Mod3] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod3]);
	}

	if(PlayerInfoVeh[playerid][Mod4] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod4]);
	}

	if(PlayerInfoVeh[playerid][Mod5] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod5]);
	}

	if(PlayerInfoVeh[playerid][Mod6] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod6]);
	}

	if(PlayerInfoVeh[playerid][Mod7] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod7]);
	}

	if(PlayerInfoVeh[playerid][Mod8] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod8]);
  }

	if(PlayerInfoVeh[playerid][Mod9] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod9]);
	}

	if(PlayerInfoVeh[playerid][Mod10] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod10]);
	}

	if(PlayerInfoVeh[playerid][Mod11] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod11]);
	}

	if(PlayerInfoVeh[playerid][Mod12] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod12]);
	}

	if(PlayerInfoVeh[playerid][Mod13] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod13]);
	}

	if(PlayerInfoVeh[playerid][Mod14] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod14]);
	}

	if(PlayerInfoVeh[playerid][Mod15] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod15]);
	}

	if(PlayerInfoVeh[playerid][Mod16] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod16]);
	}

	if(PlayerInfoVeh[playerid][Mod17] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle],PlayerInfoVeh[playerid][Mod17]);
	}
}

function:SaveVehComponets(playerid, componentid)
{
	for(new s=0; s<20; s++)
	{
    	if(componentid == pv_spoiler[s][0])
		{
      		PlayerInfoVeh[playerid][Mod1] = componentid;
   	    }
	}

	for(new s=0; s<3; s++)
	{
    	if(componentid == pv_nitro[s][0])
		{
    		PlayerInfoVeh[playerid][Mod2] = componentid;
   		}
	}

	for(new s=0; s<23; s++)
	{
    	if(componentid == pv_fbumper[s][0])
		{
    		PlayerInfoVeh[playerid][Mod3] = componentid;
   	 	}
	}

	for(new s=0; s<22; s++)
	{
    	if(componentid == pv_rbumper[s][0])
		{
    		PlayerInfoVeh[playerid][Mod4] = componentid;
   		}
	}

	for(new s=0; s<28; s++)
	{
     	if(componentid == pv_exhaust[s][0])
		{
       		PlayerInfoVeh[playerid][Mod5] = componentid;
		}
	}

	for(new s=0; s<2; s++)
	{
		if(componentid == pv_bventr[s][0])
		{
			PlayerInfoVeh[playerid][Mod6] = componentid;
 		}
	}

	for(new s=0; s<2; s++)
	{
		if(componentid == pv_bventl[s][0])
		{
			PlayerInfoVeh[playerid][Mod7] = componentid;
 		}
	}

	for(new s = 0; s < 4; s++)
	{
		if(componentid == pv_bscoop[s][0])
		{
			PlayerInfoVeh[playerid][Mod8] = componentid;
 		}
	}

	for(new s=0; s<17; s++)
	{
		if(componentid == pv_roof[s][0])
		{
			PlayerInfoVeh[playerid][Mod9] = componentid;
		}
	}

	for(new s = 0; s < 21; s++)
	{
		if(componentid == pv_lskirt[s][0])
		{
			PlayerInfoVeh[playerid][Mod10] = componentid;
		}
	}

	for(new s=0; s<21; s++)
	{
		if(componentid == pv_rskirt[s][0])
		{
			PlayerInfoVeh[playerid][Mod11] = componentid;
 		}
	}

	for(new s=0; s<1; s++)
	{
		if(componentid == pv_hydraulics[s][0])
		{
			PlayerInfoVeh[playerid][Mod12] = componentid;
		}
	}

	for(new s=0; s<1; s++)
	{
     	if(componentid == pv_base[s][0])
 		{
       		PlayerInfoVeh[playerid][Mod13] = componentid;
		}
	}

	for(new s=0; s<4; s++)
	{
     	if(componentid == pv_rbbars[s][0])
 		{
       		PlayerInfoVeh[playerid][Mod14] = componentid;
 		}
	}

	for(new s=0; s<2; s++)
	{
    	if(componentid == pv_fbbars[s][0])
		{
    		PlayerInfoVeh[playerid][Mod15] = componentid;
		}
	}

	for(new s=0; s<17; s++)
	{
    	if(componentid == pv_wheels[s][0])
		{
      		PlayerInfoVeh[playerid][Mod16] = componentid;
   	    }
	}

	for(new s=0; s<2; s++)
	{
    	if(componentid == pv_lights[s][0])
		{
			PlayerInfoVeh[playerid][Mod17] = componentid;
 		}
    }

	return 1;
}

function:unmute(playerid)
{
    PlayerInfo[playerid][Muted] = false;
    PlayerInfo[playerid][MuteTimer] = -1;
    return 1;
}

ResetPlayerWorldBounds(playerid)
{
	SetPlayerWorldBounds(playerid, FLOAT_INFINITY, -FLOAT_INFINITY, FLOAT_INFINITY, -FLOAT_INFINITY);
	return 1;
}

function:IsPlayerAvail(playerid)
{
	if(IsPlayerConnected(playerid) && playerid != INVALID_PLAYER_ID && PlayerInfo[playerid][ExitType] == 0 && !IsPlayerNPC(playerid) && PlayerInfo[playerid][Logged])
	{
	    return true;
	}
	return false;
}

SollIchDirMaEtWatSagen()
{
	new a[][] =
	{
		"Unarmed (Fist)",
		"Brass K"
	};
	#pragma unused a
}

GameTimeConvert(seconds)
{
	new tmp[16];
 	new minutes = floatround(seconds / 60);
  	seconds -= minutes * 60;
   	format(tmp, sizeof(tmp), "%i:%02i", minutes, seconds);
   	return tmp;
}

SetPlayerCash(playerid, amount)
{
    if(playerid > 500 || playerid < 0) return 1;
    ResetPlayerMoney(playerid);
	PlayerInfo[playerid][Money] = amount;
    GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
    return 1;
}

GivePlayerCash(playerid, amount)
{
	if(playerid > 500 || playerid < 0) return 1;
    ResetPlayerMoney(playerid);
	PlayerInfo[playerid][Money] += amount;
    GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
    return 1;
}

GetPlayerCash(playerid)
{
    if(playerid > 500 || playerid < 0) return 1;
	return PlayerInfo[playerid][Money];
}

_GivePlayerScore(playerid, amount)
{
    if(playerid > 500 || playerid < 0) return 1;
    PlayerInfo[playerid][Score] += amount;
	SetPlayerScore(playerid, PlayerInfo[playerid][Score]);
	return 1;
}

_SetPlayerScore(playerid, amount)
{
    if(playerid > 500 || playerid < 0) return 1;
	PlayerInfo[playerid][Score] = amount;
    SetPlayerScore(playerid, PlayerInfo[playerid][Score]);
	return 1;
}

_GetPlayerScore(playerid)
{
    if(playerid > 500 || playerid < 0) return -1;
	return PlayerInfo[playerid][Score];
}

NewMinigameJoin(playerid, const minigame[], const cmd[])
{
	new string[128], gstring[128];
	format(string, sizeof(string), "[JOIN] "white"%s(%i) just joined %s [/%s]", __GetName(playerid), playerid, minigame, cmd);
    format(gstring, sizeof(gstring), "[JOIN] "white"%s(%i) betritt %s [/%s]", __GetName(playerid), playerid, minigame, cmd);
	LangMSGToAll(GREY, string, gstring);
}

NewMapEvent(Player, const mname[], const CMD[])
{
	new string[128];
	format(string, sizeof(string), "~r~~w~~h~Player ~b~~h~~h~%s(%i) ~w~~h~teleported to ~y~~h~%s [/%s]", __GetName(Player), Player, mname, CMD);
    TextDrawSetString(TXTInfo, string);
}

GetDistance(Float:xPos, Float:yPos, Float:zPos, Float:xPos2, Float:yPos2, Float:zPos2)
{
	xPos -= xPos2;
	yPos -= yPos2;
	zPos -= zPos2;
	return floatround(floatpower((xPos * xPos) + (yPos * yPos) + (zPos * zPos), 0.5));
}

IsValidVehicle(vmodel)
{
	if(vmodel < 400 || vmodel > 611) return 0;
	return 1;
}

GetNextFreeRace()
{
	new racename[10];
	    
	TotalRaces = dini_Int("/Race/Index/Index.ini", "TotalRaces");
	format(racename, sizeof(racename), "%03i", TotalRaces);
	return racename;
}

IsValidSkin(skinid)
{
    if(skinid == 74 || skinid > 299 || skinid < 0)
    {
        return 0;
	}
    return 1;
}

__GetPlayerID(const PlayerName[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
    	if(IsPlayerConnected(i) && !IsPlayerNPC(i))
      	{
        	new
				tmp[MAX_PLAYER_NAME];

        	GetPlayerName(i, tmp, MAX_PLAYER_NAME);
        	if(!strcmp(PlayerName, tmp, true))
        	{
          		return i;
        	}
      	}
    }
    return INVALID_PLAYER_ID;
}

__GetName(playerid)
{
    new
		name[MAX_PLAYER_NAME];

    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    return name;
}

__GetIP(playerid)
{
	new
		IP[16];

	GetPlayerIp(playerid, IP, sizeof(IP));
	return IP;
}

GetUptime()
{
    new
		Result[128],
        Remaining = gettime() - StartTime,
        Time[4];

    Time[0] = Remaining % 60;
    Remaining /= 60;
    Time[1] = Remaining % 60;
    Remaining /= 60;
    Time[2] = Remaining % 24;
    Remaining /= 24;
    Time[3] = Remaining;

    if(Time[3])
        format(Result, sizeof(Result), ""white"Server is up for %i days, %i hours, %i minutes and %i seconds", Time[3], Time[2], Time[1], Time[0]);
    else if(Time[2])
        format(Result, sizeof(Result), ""white"Server is up for %i hours, %i minutes and %i seconds", Time[2], Time[1], Time[0]);
    else if(Time[1])
        format(Result, sizeof(Result), ""white"Server is up for %i minutes and %i seconds", Time[1], Time[0]);
    else
        format(Result, sizeof(Result), ""white"Server is up for %i seconds", Time[0]);
    return Result;
}

GetVehicleNameById(vehicleid)
{
	new	string[56];

	if(IsValidVehicle(GetVehicleModel(vehicleid)))
	{
	    format(string, sizeof(string), VehicleNames[GetVehicleModel(vehicleid) - 400]);
	}
	else
	{
        format(string, sizeof(string), "---");
	}
    return string;
}

function:Race_CalculatePosition()
{
	new
	    cp,
	    vehicleid,
		Float:POS[4],
	    c,
		g_RacePosition[12][e_race_position];

	for(new i; i < sizeof(g_RacePosition); i++)
	{
	    g_RacePosition[i][RP_iPlayer] = INVALID_PLAYER_ID;
	    g_RacePosition[i][RP_iValue] = -(i + 1);
	}
	for(new i; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
	        if(gTeam[i] == RACE)
			{
				vehicleid = GetPlayerVehicleID(i);
				GetVehiclePos(vehicleid, POS[0], POS[1], POS[2]);
				cp = CPProgess[i] + 1;
				POS[3] = GetDistance(POS[0], POS[1], POS[2], CPCoords[cp][0], CPCoords[cp][1], CPCoords[cp][2]);
				if(POS[3] > OFFSET_VALUE)
				{
				    POS[3] = OFFSET_VALUE;
				}
				POS[3] = (OFFSET_VALUE - POS[3]);
	            g_RacePosition[c][RP_iPlayer] = i;
	            g_RacePosition[c][RP_iValue] = (CPProgess[i] * OFFSET_VALUE) + floatround(POS[3]);
	            c++;
	        }
	    }
	}
	SortDeepArray(g_RacePosition, RP_iValue, .order = SORT_DESC);
	for(new i; i < sizeof(g_RacePosition); i++)
	{
        if(g_RacePosition[i][RP_iPlayer] != INVALID_PLAYER_ID)
		{
            RacePosition[g_RacePosition[i][RP_iPlayer]] = i + 1;
		}
	}
	return 1;
}

function:RaceCounter()
{
	if(RaceStatus == RaceStatus_Active)
	{
		RaceTime--;
		if(RaceJoinCount <= 0)
		{
			StopRace();
			LangMSGToAll(WHITE, ""race_sign" Race ended, no one left in the race", ""race_sign" Race wurde beendet, keiner übrig im Race");
		}
	}
	if(RaceTime <= 0 && iRaceEnd == 0)
	{
	    StopRace();
	}
	return 1;
}

function:DelayAutoRace()
{
	new
		string[128],
		estring[128],
		gstring[128];

	strmid(string, RaceNames[random(TotalRaces)], 0, 128, 128);
	LoadAutoRace(string);

	RaceStatus = RaceStatus_StandBy;
	format(estring, sizeof(estring), ""race_sign" New race "white"%s is now active [/race]", string);
	format(gstring, sizeof(gstring), ""race_sign" Neues Race "white"%s ist nun aktiv [/race]", string);
	LangMSGToAll(-1, estring, gstring);
	return 1;
}

function:CountTillRace()
{
	switch(RaceCountAmount)
	{
 		case 0:
	    {
			StartRace();
	    }
	    case 1..5:
	    {
	        new
	            string[50];

			format(string, sizeof(string), "~y~RACE STARTING IN~n~~p~- %i -~n~~y~SECONDS", RaceCountAmount);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
			    if(gTeam[i] == RACE)
			    {
			    	GameTextForPlayer(i, string, 999, 3);
			    	PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			    }
			}
	    }
	    case 31, 6:
	    {
	        new
	            string[128],
	            gstring[128];

			format(string, sizeof(string), ""race_sign" Still %i seconds till %s named race starts [/race]", RaceCountAmount-1, RaceName);
			format(gstring, sizeof(gstring), ""race_sign" Noch %i Sekunden bis %s race startet [/race]", RaceCountAmount-1, RaceName);
			LangMSGToAll(-1, string, gstring);
	    }
	}
	return RaceCountAmount--;
}

StartRace()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
	    if(gTeam[i] == RACE)
	    {
	        TogglePlayerControllable(i, true);
	        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
  			GameTextForPlayer(i, "~g~GO~w~! ~g~GO~w~! ~g~GO~w~!", 2000, 5);
			SetCameraBehindPlayer(i);
	    }
	}
	LangMSGToAll(-1, ""race_sign" The current race has been started!", ""race_sign" Das aktuelle Rennen wurde gestartet!");
	trCounter = SetTimer("RaceCounter", 1000, true);
	tRacePosition = SetTimer("Race_CalculatePosition", 751, true);
	RaceTick = GetTickCount() + 3600000;
	RaceStatus = RaceStatus_Active;
	KillTimer(tRaceCount);
    iRaceEnd = 0;
}

StopRace()
{
	KillTimer(trCounter);
	KillTimer(tRacePosition);
	RaceTick = 0;
	RaceJoinCount = 0;
	RaceFinishCount = 0;
	RaceStatus = RaceStatus_Inactive;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
	    if(gTeam[i] == RACE)
	    {
			TogglePlayerControllable(i, true);
	    	DisablePlayerRaceCheckpoint(i);
			if(PlayerRaceVehicle[i] != -1)
			{
				DestroyVehicle(PlayerRaceVehicle[i]);
				PlayerRaceVehicle[i] = -1;
			}
			gTeam[i] = NORMAL;
			ResetPlayerWorld(i);
			RandomWeapon(i);
			HidePlayerRaceTextdraws(i);
			CPProgess[i] = 0;
		}
	}
	SetTimer("DelayAutoRace", (10 * 30 * 1000) + 307, false);
	return 1;
}

function:Race_End()
{
    iRaceEnd--;
	if(iRaceEnd == 0)
	{
	    SetTimer("StopRace", 503, false);
	    return 1;
	}
	if(RaceJoinCount == 1)
	{
	    SetTimer("StopRace", 251, false);
	    return 1;
	}

	new
	    String[64];
	format(String, sizeof(String), "~w~Still ~p~%i ~w~seconds left!", iRaceEnd);
    SetTimer("Race_End", 1000, false);

    for(new i; i < MAX_PLAYERS; i++)
	{
        if(gTeam[i] == RACE)
		{
            GameTextForPlayer(i, String, 1300, 4);
        }
    }
	RaceTime = iRaceEnd;
	return 1;
}

SetupRaceForPlayer(playerid)
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	ClearAnimations(playerid);
					
	CPProgess[playerid] = 0;
	TogglePlayerControllable(playerid, false);
	CPCoords[playerid][3] = 0;
	SetCP(playerid, CPProgess[playerid], CPProgess[playerid] + 1, TotalRaceCP, RaceType);
	SetCameraBehindPlayer(playerid);
	PlayerRaceVehicle[playerid] = CreateVehicle(RaceVehicle, RaceVehCoords[RaceSpawnCount][0], RaceVehCoords[RaceSpawnCount][1], floatadd(RaceVehCoords[RaceSpawnCount][2], 2.0), RaceVehCoords[RaceSpawnCount][3], (random(128) + 127), (random(128) + 127), -1);
	SetPlayerPos(playerid, RaceVehCoords[RaceJoinCount][0], RaceVehCoords[RaceSpawnCount][1], floatadd(RaceVehCoords[RaceSpawnCount][2], 2.0));
	SetPlayerFacingAngle(playerid, RaceVehCoords[RaceSpawnCount][3]);
	SetPlayerVirtualWorld(playerid, RaceVirtualWorld);
	SetPlayerInterior(playerid, 0);

	SetVehicleNumberPlate(PlayerRaceVehicle[playerid], "{3399ff}R{FFFFFF}ac{F81414}E");
	SetVehicleToRespawn(PlayerRaceVehicle[playerid]);
	SetVehicleVirtualWorld(PlayerRaceVehicle[playerid], RaceVirtualWorld);
	AddVehicleComponent(PlayerRaceVehicle[playerid], 1010);
	RepairVehicle(PlayerRaceVehicle[playerid]);

	PutPlayerInVehicle(playerid, PlayerRaceVehicle[playerid], 0);

	HidePlayerMeshTXT(playerid);

	new string[255];
    format(string, sizeof(string), "SELECT `name`, `time` FROM `"#TABLE_RACE"` WHERE `track` = '%s' ORDER BY `time` ASC LIMIT 5;", RaceName);
    mysql_function_query(g_SQL_handle, string, true, "OnQueryFinish", "siii", string, THREAD_RACE_TOPLIST, playerid, g_SQL_handle);

	RaceJoinCount++;
	RaceSpawnCount++;
}

SetCP(playerid, PrevCP, NextCP, MaxCP, Type)
{
	if(Type == 0)
	{
		if(NextCP == MaxCP)
		{
			SetPlayerRaceCheckpoint(playerid, 1, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		}
		else
		{
			SetPlayerRaceCheckpoint(playerid, 0, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		}
	}
	else if(Type == 3)
	{
		if(NextCP == MaxCP)
		{
			SetPlayerRaceCheckpoint(playerid, 4, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		}
		else
		{
			SetPlayerRaceCheckpoint(playerid, 3, CPCoords[PrevCP][0], CPCoords[PrevCP][1], CPCoords[PrevCP][2], CPCoords[NextCP][0], CPCoords[NextCP][1], CPCoords[NextCP][2], RACE_CHECKPOINT_SIZE);
		}
	}
}

LoadAutoRace(rName[])
{
	new
		rFile[255],
		string[255];

	format(rFile, sizeof(rFile), "/Race/%s.race", rName);
	if(!dini_Exists(rFile)) return printf("Race %s doesn't exist!", rName);
	strmid(RaceName, rName, 0, strlen(rName), sizeof(RaceName));
	RaceVehicle = dini_Int(rFile, "vModel");
	RaceType = dini_Int(rFile, "rType");
	RaceVirtualWorld = dini_Int(rFile, "rVirtualworld");
	TotalRaceCP = dini_Int(rFile, "TotalRaceCP");

	for(new i = 0; i < RACE_MAX_PLAYERS; i++)
	{
		format(string, sizeof(string), "vPosX_%i", i), RaceVehCoords[i][0] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosY_%i", i), RaceVehCoords[i][1] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosZ_%i", i), RaceVehCoords[i][2] = dini_Float(rFile, string);
		format(string, sizeof(string), "vAngle_%i", i), RaceVehCoords[i][3] = dini_Float(rFile, string);
	}

	for(new i = 0; i < TotalRaceCP; i++)
	{
 		format(string, sizeof(string), "CP_%i_PosX", i), CPCoords[i][0] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%i_PosY", i), CPCoords[i][1] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%i_PosZ", i), CPCoords[i][2] = dini_Float(rFile, string);
	}

	rPosition = 0;
	RaceFinishCount = 0;
	RaceJoinCount = 0;
	RaceSpawnCount = 0;

	RaceCountAmount = COUNT_DOWN_TILL_RACE_START;

	RaceTime = MAX_RACE_TIME;

	for(new i = 0; i < MAX_PLAYERS ; i++)
	{
	    RacePosition[i] = 0;
	}
	return 1;
}

LoadRaceNames()
{
	new
	    rNameFile[64],
	    string[64],
	    count0,
	    count1 = GetTickCount() + 3600000;

	format(rNameFile, sizeof(rNameFile), "/Race/Index/Index.ini");
	TotalRaces = dini_Int(rNameFile, "TotalRaces");

	for(new i = 0; i < TotalRaces; i++)
	{
	    format(string, sizeof(string), "Race_%i", i);
		strmid(RaceNames[i], dini_Get(rNameFile, string), 0, 20, sizeof(RaceNames));
	    printf("- Loaded Race: %s", RaceNames[i]);
	    count0++;
	}
	printf("#Races loaded in %i ms Total: %i", (GetTickCount() + 3600000) - count1, count0);
}

MySQL_CreatePlayerToy(playerid)
{
	new query[800];
	format(query, sizeof(query), "INSERT INTO `"#TABLE_TOYS"` (`ID`, `Name`) VALUES (NULL, '%s');", __GetName(playerid));
	mysql_function_query(g_SQL_handle, query, false, "", "");

	for(new i = 0; i < 5; i++)
	{
		PlayerToys[playerid][i][toy_model] = 0;
		PlayerToys[playerid][i][toy_bone] = 1;
		PlayerToys[playerid][i][toy_x] = 0.0;
		PlayerToys[playerid][i][toy_y] = 0.0;
		PlayerToys[playerid][i][toy_z] = 0.0;
		PlayerToys[playerid][i][toy_rx] = 0.0;
		PlayerToys[playerid][i][toy_ry] = 0.0;
		PlayerToys[playerid][i][toy_rz] = 0.0;
		PlayerToys[playerid][i][toy_sx] = 1.0;
		PlayerToys[playerid][i][toy_sy] = 1.0;
		PlayerToys[playerid][i][toy_sz] = 1.0;
	}

    MySQL_SavePlayerToys(playerid);
}

MySQL_LoadPlayerToys(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT `ID` FROM `"#TABLE_TOYS"` WHERE `Name` = '%s';", __GetName(playerid));
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_CHECK_IF_TOY_EXIST, playerid, g_SQL_handle);
}

AttachPlayerToys(playerid)
{
	for(new i = 0; i < 5; i++)
	{
        SetPlayerAttachedObject(playerid,
            i,
            PlayerToys[playerid][i][toy_model],
            PlayerToys[playerid][i][toy_bone],
            PlayerToys[playerid][i][toy_x],
            PlayerToys[playerid][i][toy_y],
            PlayerToys[playerid][i][toy_z],
            PlayerToys[playerid][i][toy_rx],
            PlayerToys[playerid][i][toy_ry],
            PlayerToys[playerid][i][toy_rz],
            PlayerToys[playerid][i][toy_sx],
            PlayerToys[playerid][i][toy_sy],
            PlayerToys[playerid][i][toy_sz]);
	}
}

MySQL_SavePlayerToys(playerid)
{
	new query[800];
	format(query, sizeof(query),
	"UPDATE `"#TABLE_TOYS"` SET \
	`Slot0_Model` = %i, `Slot0_Bone` = %i, `Slot0_XPos` = %.2f, `Slot0_YPos` = %.2f, `Slot0_ZPos` = %.2f, `Slot0_XRot` = %.2f, `Slot0_YRot` = %.2f, `Slot0_ZRot` = %.2f, `Slot0_XScale` = %.2f, `Slot0_YScale` = %.2f, `Slot0_ZScale` = %.2f \
	WHERE `Name` = '%s' LIMIT 1;",
		PlayerToys[playerid][0][toy_model],
        PlayerToys[playerid][0][toy_bone],
        PlayerToys[playerid][0][toy_x],
        PlayerToys[playerid][0][toy_y],
        PlayerToys[playerid][0][toy_z],
        PlayerToys[playerid][0][toy_rx],
        PlayerToys[playerid][0][toy_ry],
        PlayerToys[playerid][0][toy_rz],
        PlayerToys[playerid][0][toy_sx],
        PlayerToys[playerid][0][toy_sy],
        PlayerToys[playerid][0][toy_sz],
		__GetName(playerid));

    mysql_function_query(g_SQL_handle, query, false, "", "");
    
   	format(query, sizeof(query),
	"UPDATE `"#TABLE_TOYS"` SET \
	`Slot1_Model` = %i, `Slot1_Bone` = %i, `Slot1_XPos` = %.2f, `Slot1_YPos` = %.2f, `Slot1_ZPos` = %.2f, `Slot1_XRot` = %.2f, `Slot1_YRot` = %.2f, `Slot1_ZRot` = %.2f, `Slot1_XScale` = %.2f, `Slot1_YScale` = %.2f, `Slot1_ZScale` = %.2f \
	WHERE `Name` = '%s' LIMIT 1;",
		PlayerToys[playerid][1][toy_model],
        PlayerToys[playerid][1][toy_bone],
        PlayerToys[playerid][1][toy_x],
        PlayerToys[playerid][1][toy_y],
        PlayerToys[playerid][1][toy_z],
        PlayerToys[playerid][1][toy_rx],
        PlayerToys[playerid][1][toy_ry],
        PlayerToys[playerid][1][toy_rz],
        PlayerToys[playerid][1][toy_sx],
        PlayerToys[playerid][1][toy_sy],
        PlayerToys[playerid][1][toy_sz],
		__GetName(playerid));

    mysql_function_query(g_SQL_handle, query, false, "", "");
    
   	format(query, sizeof(query),
	"UPDATE `"#TABLE_TOYS"` SET \
	`Slot2_Model` = %i, `Slot2_Bone` = %i, `Slot2_XPos` = %.2f, `Slot2_YPos` = %.2f, `Slot2_ZPos` = %.2f, `Slot2_XRot` = %.2f, `Slot2_YRot` = %.2f, `Slot2_ZRot` = %.2f, `Slot2_XScale` = %.2f, `Slot2_YScale` = %.2f, `Slot2_ZScale` = %.2f \
	WHERE `Name` = '%s' LIMIT 1;",
		PlayerToys[playerid][2][toy_model],
        PlayerToys[playerid][2][toy_bone],
        PlayerToys[playerid][2][toy_x],
        PlayerToys[playerid][2][toy_y],
        PlayerToys[playerid][2][toy_z],
        PlayerToys[playerid][2][toy_rx],
        PlayerToys[playerid][2][toy_ry],
        PlayerToys[playerid][2][toy_rz],
        PlayerToys[playerid][2][toy_sx],
        PlayerToys[playerid][2][toy_sy],
        PlayerToys[playerid][2][toy_sz],
		__GetName(playerid));

    mysql_function_query(g_SQL_handle, query, false, "", "");
    
   	format(query, sizeof(query),
	"UPDATE `"#TABLE_TOYS"` SET \
	`Slot3_Model` = %i, `Slot3_Bone` = %i, `Slot3_XPos` = %.2f, `Slot3_YPos` = %.2f, `Slot3_ZPos` = %.2f, `Slot3_XRot` = %.2f, `Slot3_YRot` = %.2f, `Slot3_ZRot` = %.2f, `Slot3_XScale` = %.2f, `Slot3_YScale` = %.2f, `Slot3_ZScale` = %.2f \
	WHERE `Name` = '%s' LIMIT 1;",
		PlayerToys[playerid][3][toy_model],
        PlayerToys[playerid][3][toy_bone],
        PlayerToys[playerid][3][toy_x],
        PlayerToys[playerid][3][toy_y],
        PlayerToys[playerid][3][toy_z],
        PlayerToys[playerid][3][toy_rx],
        PlayerToys[playerid][3][toy_ry],
        PlayerToys[playerid][3][toy_rz],
        PlayerToys[playerid][3][toy_sx],
        PlayerToys[playerid][3][toy_sy],
        PlayerToys[playerid][3][toy_sz],
		__GetName(playerid));

    mysql_function_query(g_SQL_handle, query, false, "", "");
    
   	format(query, sizeof(query),
	"UPDATE `"#TABLE_TOYS"` SET \
	`Slot4_Model` = %i, `Slot4_Bone` = %i, `Slot4_XPos` = %.2f, `Slot4_YPos` = %.2f, `Slot4_ZPos` = %.2f, `Slot4_XRot` = %.2f, `Slot4_YRot` = %.2f, `Slot4_ZRot` = %.2f, `Slot4_XScale` = %.2f, `Slot4_YScale` = %.2f, `Slot4_ZScale` = %.2f \
	WHERE `Name` = '%s' LIMIT 1;",
		PlayerToys[playerid][4][toy_model],
        PlayerToys[playerid][4][toy_bone],
        PlayerToys[playerid][4][toy_x],
        PlayerToys[playerid][4][toy_y],
        PlayerToys[playerid][4][toy_z],
        PlayerToys[playerid][4][toy_rx],
        PlayerToys[playerid][4][toy_ry],
        PlayerToys[playerid][4][toy_rz],
        PlayerToys[playerid][4][toy_sx],
        PlayerToys[playerid][4][toy_sy],
        PlayerToys[playerid][4][toy_sz],
		__GetName(playerid));

    mysql_function_query(g_SQL_handle, query, false, "", "");
}

function:CoolDownDeath(playerid)
{
	PlayerInfo[playerid][iCoolDownDeath]--;
	return 1;
}

function:CoolDownCommand(playerid)
{
	PlayerInfo[playerid][iCoolDownCommand]--;
	return 1;
}

function:TogglePlayerControllableEx(playerid, toggle)
{
	TogglePlayerControllable(playerid, toggle);
}

function:SetPlayerPosEx(playerid, Float:X, Float:Y, Float:Z)
{
    Streamer_UpdateEx(playerid, X, Y, Z);
	SetPlayerPos(playerid, X, Y, Z);
}

GetToysAvail()
{
	new string[800];
	strcat(string, ""yellow"Each toy coasts "green"$25,000\n"dl"Top Hat\n"dl"Turtle\n"dl"Minigun\n"dl"Laser Pointer\n"dl"Police Shield");
	strcat(string, "\n"dl"Parrot\n"dl"Dildosaw\n"dl"Burgerhat\n"dl"Police Glasses\n"dl"Police Hat\n"dl"Santa Hat");
	strcat(string, "\n"dl"Gasmask\n"dl"Little Bambi\n"dl"Pumpkin\n"dl"Bassguitar\n"dl"Taxi Sign\n"dl"Money Bag");
	return string;
}

function:RandomSvrMsg()
{
	SendClientMessageToAll(GREY, "=================="white"SERVER"grey"=====================");
	SendClientMessageToAll(GREY, " ");
	SendClientMessageToAll(WHITE, ServerMSGS[random(sizeof(ServerMSGS))]);
	SendClientMessageToAll(GREY, " ");
	SendClientMessageToAll(GREY, "=================="white"SERVER"grey"=====================");
	return 1;
}

function:remove_health_obj(damagedid)
{
	if(IsPlayerConnected(damagedid))
	{
	    RemovePlayerAttachedObject(damagedid, 8);
	    PlayerHit[damagedid] = false;
	}
	return 1;
}

function:InitSession(playerid)
{
	TXTWanteds[playerid] = CreatePlayerTextDraw(playerid, 84.000000, 425.000000, "Wanteds: ~b~0");
	PlayerTextDrawAlignment(playerid, TXTWanteds[playerid], 3);
	PlayerTextDrawBackgroundColor(playerid, TXTWanteds[playerid], 255);
	PlayerTextDrawFont(playerid, TXTWanteds[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXTWanteds[playerid], 0.239999, 1.000000);
	PlayerTextDrawColor(playerid, TXTWanteds[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TXTWanteds[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXTWanteds[playerid], 1);
	PlayerTextDrawUseBox(playerid, TXTWanteds[playerid], 1);
	PlayerTextDrawBoxColor(playerid, TXTWanteds[playerid], 168430207);
	PlayerTextDrawTextSize(playerid, TXTWanteds[playerid], 69.000000, 0.000000);

	RaceInfo[playerid] = CreatePlayerTextDraw(playerid, 89.000000, 261.000000, "position: ~r~-/-~n~~w~checkpoint: ~b~-/-~n~~w~players: ~g~-/-~n~~w~map: ~y~~n~~w~timeleft: ~r~--:--");
	PlayerTextDrawAlignment(playerid, RaceInfo[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, RaceInfo[playerid], 255);
	PlayerTextDrawFont(playerid, RaceInfo[playerid], 2);
	PlayerTextDrawLetterSize(playerid, RaceInfo[playerid], 0.340000, 1.000000);
	PlayerTextDrawColor(playerid, RaceInfo[playerid], -1);
	PlayerTextDrawSetOutline(playerid, RaceInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RaceInfo[playerid], 1);

	TXTGunGameInfo[playerid] = CreatePlayerTextDraw(playerid, 90.000000, 258.000000, "players: ~b~--~n~~w~level: ~r~--~n~~w~weapon:~n~~g~NONE");
	PlayerTextDrawAlignment(playerid, TXTGunGameInfo[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, TXTGunGameInfo[playerid], 255);
	PlayerTextDrawFont(playerid, TXTGunGameInfo[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXTGunGameInfo[playerid], 0.340000, 1.000000);
	PlayerTextDrawColor(playerid, TXTGunGameInfo[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TXTGunGameInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXTGunGameInfo[playerid], 1);

	TXTPlayerInfo[playerid] = CreatePlayerTextDraw(playerid, 18.000000, 175.000000, "---");
	PlayerTextDrawBackgroundColor(playerid, TXTPlayerInfo[playerid], 255);
	PlayerTextDrawFont(playerid, TXTPlayerInfo[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TXTPlayerInfo[playerid], 0.370000, 1.400000);
	PlayerTextDrawColor(playerid, TXTPlayerInfo[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TXTPlayerInfo[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXTPlayerInfo[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TXTPlayerInfo[playerid], 1);
	PlayerTextDrawUseBox(playerid, TXTPlayerInfo[playerid], 1);
	PlayerTextDrawBoxColor(playerid, TXTPlayerInfo[playerid], 0x00000085);
	PlayerTextDrawTextSize(playerid, TXTPlayerInfo[playerid], 252.000000, -10.000000);

    RemoveBuildingForPlayer(playerid, 1231, 154.6641, -1839.4297, 5.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 1350, -1772.3125, -121.4375, 2.7734, 0.25);
    RemoveBuildingForPlayer(playerid, 1294, 1246.4531, -924.3047, 46.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1231, 1479.3828, -1682.3125, 15.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1494.2109, -1694.4375, 13.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1496.9766, -1686.8516, 11.8359, 0.25);
	RemoveBuildingForPlayer(playerid, 641, 1494.1406, -1689.2344, 11.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 673, 1498.9609, -1684.6094, 12.3984, 0.25);
	RemoveBuildingForPlayer(playerid, 705, 621.8125, -465.2656, 14.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 694, 731.6016, -433.0859, 13.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 705, 658.0078, -429.7266, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 709, 706.1016, -427.0313, 15.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 705, 774.0469, -486.0703, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 705, 763.1172, -449.6953, 15.2031, 0.25);
    RemoveBuildingForPlayer(playerid, 727, 1181.8047, -999.5469, 32.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1767.8359, -1455.5859, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 1750.3047, -1446.5234, 16.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1762.8047, -1443.7578, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 1776.3047, -1444.6797, 16.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1781.3906, -1450.5625, 15.6250, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 1785.4297, -1457.5234, 16.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 1294, 1812.3047, -1455.5078, 16.9063, 0.25);
	RemoveBuildingForPlayer(playerid, 4606, 1825.0000, -1413.9297, 12.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 4607, 1780.0000, -1360.0000, 12.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 4608, 1773.2734, -1368.2734, 18.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 4609, 1777.8906, -1376.8906, 20.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 4610, 1747.4375, -1361.5078, 21.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 1746.7500, -1359.7734, 16.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 4759, 1748.9297, -1420.2813, 41.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 1266, 1748.8438, -1420.4453, 35.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1728.1719, -1428.3750, 15.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1727.6172, -1423.7656, 14.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1783.0391, -1440.3438, 13.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1773.5234, -1437.0391, 13.0625, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1762.7188, -1433.5859, 13.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 1260, 1748.8438, -1420.4453, 35.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 4731, 1748.9297, -1420.2813, 41.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1783.2031, -1427.5234, 17.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1793.6172, -1420.6875, 17.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1727.8359, -1417.7969, 15.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1789.1250, -1413.3125, 15.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 4594, 1825.0000, -1413.9297, 12.5547, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1727.6172, -1411.3359, 13.7578, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1727.8359, -1405.5391, 15.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1727.6172, -1399.6797, 14.1172, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1727.8359, -1393.6719, 15.1250, 0.25);
	RemoveBuildingForPlayer(playerid, 674, 1740.3672, -1388.0625, 13.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1740.4609, -1386.5234, 13.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 674, 1749.5156, -1388.0000, 14.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1749.9063, -1386.4375, 14.5703, 0.25);
	RemoveBuildingForPlayer(playerid, 4714, 1754.5391, -1389.0859, 15.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 674, 1758.0469, -1387.9141, 15.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1758.7266, -1386.2578, 15.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 674, 1768.1484, -1387.6094, 15.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 4559, 1773.2734, -1368.2734, 18.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 4560, 1777.8906, -1376.8906, 20.3750, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1789.1250, -1402.1563, 15.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 955, 1789.2109, -1369.2656, 15.1641, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1809.8984, -1384.4688, 15.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1813.1641, -1384.4688, 15.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1831.3594, -1384.4688, 15.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1815.6406, -1382.2031, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1827.9609, -1377.7266, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1831.9609, -1381.0703, 13.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1788.9844, -1363.0703, 15.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1827.8906, -1363.0000, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 4558, 1747.4375, -1361.5078, 21.0313, 0.25);
	RemoveBuildingForPlayer(playerid, 1432, 1787.0469, -1360.9063, 14.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 4590, 1780.0000, -1360.0000, 12.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1432, 1787.0781, -1357.2656, 14.8672, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1831.3594, -1359.0938, 15.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 674, 1754.5391, -1350.0781, 14.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 674, 1759.8047, -1350.0781, 14.5859, 0.25);
	RemoveBuildingForPlayer(playerid, 1432, 1787.0469, -1353.7813, 14.8594, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1789.8672, -1353.2656, 15.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1432, 1791.4766, -1351.6406, 14.7813, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1800.5469, -1353.2109, 14.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 700, 1831.2813, -1354.1016, 14.4219, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1827.8906, -1344.8984, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1831.3594, -1348.4922, 15.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1738.9609, -1342.5703, 15.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1750.1328, -1342.5859, 15.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1760.7969, -1342.5859, 15.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1769.1641, -1342.6094, 15.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1779.6797, -1342.6094, 15.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1790.0859, -1342.6094, 15.2813, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1800.5469, -1342.6094, 14.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1813.9453, -1323.3516, 15.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1828.0000, -1330.4141, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1831.6953, -1326.8906, 13.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 1215, 1820.0859, -1326.1563, 13.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1817.2109, -1323.3516, 15.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1831.3594, -1323.4844, 15.1094, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1842.1328, -1406.4375, 15.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1842.1328, -1379.2422, 15.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1846.2422, -1329.1094, 15.6406, 0.25);
	RemoveBuildingForPlayer(playerid, 5464, 1902.4297, -1309.5391, 29.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1835.9063, -1461.4063, 15.7422, 0.25);
	RemoveBuildingForPlayer(playerid, 1283, 1846.0469, -1449.8828, 15.9375, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1842.1328, -1431.5859, 15.9141, 0.25);
	RemoveBuildingForPlayer(playerid, 621, 323.4297, -1659.6172, 31.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 339.9531, -1662.2422, 31.1328, 0.25);
	RemoveBuildingForPlayer(playerid, 978, -1197.0078, -10.9844, 13.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 1278, -1244.9219, 5.1250, 25.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 978, -1183.7344, 2.2891, 13.9844, 0.25);
	RemoveBuildingForPlayer(playerid, 16594, -25.2109, 2338.7813, 27.5078, 0.25);
	RemoveBuildingForPlayer(playerid, 16108, -25.2109, 2338.7813, 27.5078, 0.25);
	return 1;
}

function:SendInfo(playerid, info[], time)
{
	KillTimer(PlayerInfo[playerid][tInfo]);
	PlayerTextDrawSetString(playerid, TXTPlayerInfo[playerid], info);
	PlayerInfo[playerid][tInfo] = SetTimerEx("HideInfo", time, false, "i", playerid);
	PlayerTextDrawShow(playerid, TXTPlayerInfo[playerid]);
	PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
	return 1;
}

function:HideInfo(playerid)
{
	PlayerTextDrawHide(playerid, TXTPlayerInfo[playerid]);
	return 1;
}

function:KickEx(playerid)
{
	SetTimerEx("Kick_Delay", 1000, false, "i", playerid);
	return 1;
}

function:Kick_Delay(playerid)
{
	Kick(playerid);
	return 1;
}

UnixTimeToDate(unixtime)
{
	new u_year,
	    u_month,
	    u_day,
		u_hour,
		u_minute,
		u_second,
		u_date[50];

    TimestampToDate(unixtime, u_year, u_month, u_day, u_hour, u_minute, u_second, 1);
    
    format(u_date, sizeof(u_date), "%02i.%02i.%i - %02i:%02i:%02i", u_day, u_month, u_year, u_hour, u_minute, u_second);
    
	return u_date;
}
