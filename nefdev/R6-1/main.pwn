/*======================================================================*\
|| #################################################################### ||
|| # Project Stunt Evolution - Release 6-1                 			  # ||
|| # ---------------------------------------------------------------- # ||
|| # Copyright ©2011-2013 Stunt Evolution							  # ||
|| # Created by Mellnik                                               # ||
|| # ---------------------------------------------------------------- # ||
|| # http://stunt-evolution.net                          			  # ||
|| #################################################################### ||
\*======================================================================*/

#pragma dynamic 8000

#define IS_RELEASE_BUILD true

// -
// - Include
// -
#include <a_samp>   	// 0.3x R1-2
#include <YSI\y_iterate>// 28/03/2013
#include <sscanf2>      // 2.8.1
#include <streamer>     // 2.6.1 R84
#include <a_mysql_R16>  // R16
#include <dini>         // 1.6
#include <md-sort>
#include <zcmd>
#include <unixtimetodate>
#include <mSelection>
#include <se_maps>
#include <se_maps_2>
#include <se_maps_3>
#include <se_map_vehicles>

// -
// - MySQL
// -
#define SQL_HOST   						"127.0.0.1"
#if IS_RELEASE_BUILD == true
#define SQL_USER   						"seserver"
#define SQL_PASS   						"t2t0.SZth-zTruhJpR(7ucr8?u"
#define SQL_DATA   						"stuntevoserver"
#else
#define SQL_USER   						"sedev"
#define SQL_PASS   						"83Qhrb8e7ghRfvb7tgbfsd"
#define SQL_DATA                        "stuntevodev"
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
#define DERBY_WIHLE_CAM_M7              4028.5825, -1909.2007, 56.6765
#define DERBY_WIHLE_CAM_M8              2876.0093, -3530.1829, 24.4397
#define DERBY_WIHLE_CAM_M9              4520.9189, -1753.6084, 56.1358
#define DERBY_CAMPOS_M1                 -4031.8118, 985.9628, 73.5483
#define DERBY_CAMPOS_M2                 2878.3738, 509.6317, 57.4209
#define DERBY_CAMPOS_M3                 146.2626, 1726.9897, 375.9173
#define DERBY_CAMPOS_M4                 1481.6500, -1713.3242, 58.8331
#define DERBY_CAMPOS_M5                 -1990.0116, -962.2039, 65.3364
#define DERBY_CAMPOS_M6                 3917.3489, -53.3306, 18.7947
#define DERBY_CAMPOS_M7                 4090.4087, -1995.4886, 50.2633
#define DERBY_CAMPOS_M8                 2800.4382, -3449.5762, 39.5314
#define DERBY_CAMPOS_M9                 4453.8774, -1642.1117, 36.6551
#define DERBY_CAMLA_M1                  -4030.9736, 985.4224, 73.2184
#define DERBY_CAMLA_M2                  2879.3184, 509.2916, 56.9258
#define DERBY_CAMLA_M3                  147.0293, 1726.3483, 375.4769
#define DERBY_CAMLA_M4                  1481.6300, -1714.3220, 58.3079
#define DERBY_CAMLA_M5                  -1989.5079, -961.3351, 64.8612
#define DERBY_CAMLA_M6                  3916.3560, -53.4894, 18.5597
#define DERBY_CAMLA_M7                  4089.7327, -1994.7545, 49.7484
#define DERBY_CAMLA_M8                  2801.1716, -3450.2600, 38.9760
#define DERBY_CAMLA_M9                  4454.6743, -1642.7051, 36.2001
#define DERBY_FALLOVER_M1     			(20)
#define DERBY_FALLOVER_M2               (1)
#define DERBY_FALLOVER_M3               (327)
#define DERBY_FALLOVER_M4               (27)
#define DERBY_FALLOVER_M5               (36)
#define DERBY_FALLOVER_M6               (1)
#define DERBY_FALLOVER_M7               (1)
#define DERBY_FALLOVER_M8               (1)
#define DERBY_FALLOVER_M9               (1)
#define MAX_DERBY_PLAYERS  				(20)
#define DERBY_WORLD                     (5050)
#define DERBY_TIME      				(180000)
#define DERBY_VOTING_TIME     			(20000)
#define DEFAULT_DERBY_TIME              (180)
#define DERBY_FALLOVER_CHECK_TIME   	(500)

// -
// - Firework
// -
#define MAX_LIGHTS 						(100)
#define MAX_PARTS 						(13)
#define Sprinkleid 						(52)
#define RBSprinkleid 					(20)

// -
// - Enviroment
// -
#define HOSTNAME 						"                «(—[—| Stunt Evolution |—]—)»"
#define SE_SIGN1                       " SE"
#define SE_SIGN2                       "       STUNT EVOLUTION"
#if IS_RELEASE_BUILD == true
#define CURRENT_VERSION                 "Release 6-1"
#else
#define CURRENT_VERSION                 "Release 6-1 BETA BUILD"
#endif
#define MAX_REPORTS 					(7)
#define MAX_GANG_NAME					(20)
#define MIN_GANG_NAME					(4)
#define GANG_POS_NONE                   (0)
#define GANG_POS_JUNIOR_MEMBER          (1)
#define GANG_POS_MEMBER                 (2)
#define GANG_POS_SENIOR_MEMBER          (3)
#define GANG_POS_ADVISOR                (4)
#define GANG_POS_LEADER                 (5)
#define GANG_POS_MAIN_LEADER            (6)
#define house_mark                      "{FFFFFF}[{88EE88}House{FFFFFF}]"
#define business_mark                   "{FFFFFF}[{AAAAFF}Business{FFFFFF}]"
#define derby_sign                      "{FFFFFF}[{AAAAFF}DERBY{FFFFFF}]"
#define race_sign                       "{FFFFFF}[{AAAAFF}RACE{FFFFFF}]"
#define tdm_sign                        "{FFFFFF}[{AAAAFF}TDM{FFFFFF}]"
#define war_sign                        "{FFFFFF}[{AAAAFF}WAR{FFFFFF}]"
#define gungame_sign                    "{FFFFFF}[{AAAAFF}GUNGAME{FFFFFF}]"
#define fallout_sign                    "{FFFFFF}[{AAAAFF}FALLOUT{FFFFFF}]"
#define server_sign                     "{FFFFFF}[{6EF83C}SERVER{FFFFFF}]"
#define gang_sign                       "{FFFFFF}[{FFA000}GANG{FFFFFF}]"
#define se                              "{FFFFFF}[{969696}SE{FFFFFF}]"
#define NO_PERM_ENG                     "{0055FF}Info: {F0F0F0}Insufficient Permissions"
#define NOT_AVAIL                       "{0055FF}Info: {F0F0F0}You can´t use this command now! Use /exit to leave."
#define er                              "{0055FF}Info: {F0F0F0}"
#define dl                              "{2DFF00}• {F0F0F0}"
#define RANDOM_TEXTDRAW_TEXT            (10000)
#define MAX_ADMIN_LEVEL         		(6)
#define MAX_WARNINGS 					(3)
#define MAX_FAIL_LOGINS 				(3)
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
#define SCM SendClientMessage
#define SCMToAll SendClientMessageToAll
#define MAX_TELE_CATEGORYS              (10)
#define COLOR_RGB(%1,%2,%3,%4) (((((%1) & 0xff) << 24) | (((%2) & 0xff) << 16) | (((%3) & 0xff) << 8) | ((%4) & 0xff)))
#define UpperToLower(%1) for(new ToLowerChar; ToLowerChar < strlen(%1); ToLowerChar++) if(%1[ToLowerChar] > 64 && %1[ToLowerChar] < 91) %1[ToLowerChar] += 32

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
#define MAX_RACE_CHECKPOINTS_EACH_RACE 	(100)
#define MAX_RACES 						(25)
#define COUNT_DOWN_TILL_RACE_START 		(21)
#define MAX_RACE_TIME 					(300)
#define RACE_CHECKPOINT_SIZE 			(12.0)
#define RACE_MAX_PLAYERS 				(12)
#define OFFSET_VALUE 					(10000)
#define Key(%0) 						((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0))
#define PreloadAnimLib(%1,%2) 			ApplyAnimation(%1,%2,"NULL",0.0,0,0,0,0,0)
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

// - ~y~/Race: ~g~0 ~y~/derby: ~g~0 ~y~/gungame: ~g~0 ~y~/fallout: ~g~0 ~y~/war: ~g~0 ~<~~>~ ~y~/cmds
// - Colors
// -
#define SEMI_TRANS                      (0x0A0A0A7F)
#define PURPLE                  		(0x7800FF85)
#define NGS_GREEN                       (0x2DFF00FF)
#define NGS_BLUE                        (0x0055FFFF)
#define GREEN 							(0x87FF00FF)
#define GREEN2		 					(0x3BBD44FF)
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
#define yellow_e                        "{DBED15}"
#define white                           "{F0F0F0}"
#define blue							"{0087FF}"
#define orange                          "{FFA000}"
#define grey                            "{969696}"
#define red                             "{D63034}"
#define lb_e 							"{15D4ED}"
#define ngs_green                       "{2DFF00}"
#define ngs_blue                        "{0055FF}"

// Stunt Evolution Colors
#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_WHITEP 		0xFFE4C4FF
#define COLOR_ORANGE   		0xDB881AFF
#define COLOR_ORANGE2		0xFF5000FF
#define COLOR_IVORY 		0xFFFF82FF
#define COLOR_BLUE			0x004BFFFF
#define COLOR_RCONBLUE      0x0080FF99
#define COLOR_PURPLE 		0x5A00FFFF
#define COLOR_RED 			0xFF0000FF
#define COLOR_LIGHTGREEN 	0x00FF00FF
#define COLOR_YELLOW 		0xFFFF00FF
#define COLOR_YELLOW2 		0xF5DEB3FF
#define COLOR_LIGHTBLUE 	0x87CEFAFF
#define COLOR_PINK			0xEE82EEFF
#define COLOR_GOLD			0xFFD700FF
#define COLOR_FIREBRICK 	0xB22222FF
#define COLOR_GREEN 		0x3BBD44FF
#define COLOR_GREY			0xBABABAFF
#define COLOR_GREY2 		0x778899FF
#define COLOR_BROWN 		0x8B4513FF
#define COLOR_STEELBLUE 	0xB0C4DEFF
#define COLOR_SYSTEM 		0xEFEFF7FF
#define COLOR_CNR_COP       0x1F75FEFF

#define RED_E 		"{FF0000}"
#define BLUE_E 		"{004BFF}"
#define PINK_E 		"{FFB6C1}"
#define YELLOW_E 	"{DBED15}"
#define LG_E 		"{00FF00}"
#define LB_E 		"{15D4ED}"
#define LB2_E 		"{87CEFA}"
#define GREY_E 		"{BABABA}"
#define GREY2_E 	"{778899}"
#define WHITE_E 	"{FFFFFF}"
#define WHITEP_E 	"{FFE4C4}"
#define IVORY_E 	"{FFFF82}"
#define ORANGE_E 	"{DB881A}"
#define GREEN_E 	"{3BBD44}"
#define PURPLE_E 	"{5A00FF}"

// -
// - Player
// -
#define COOLDOWN_CHAT                   (5500)
#define COOLDOWN_CMD_BUY                (90000)
#define COOLDOWN_CMD_PBUY               (90000)
#define COOLDOWN_CMD_LOCK               (5000)
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
#define COOLDOWN_CMD_HAREFILL             (120000)
#define COOLDOWN_CMD_VIPLI              (90000)
#define COOLDOWN_CMD_CD                 (60000)
#define COOLDOWN_BIKEC                  (300000)


// ===
// Enums
// ===

// -
// - DIALOGIDS
// -
enum (+= 50)
{
    REGISTER_DIALOG,
    LOGIN_DIALOG,
    TELE_DIALOG,
    WEAPON_DIALOG,
    STREAM_DIALOG,
    ACHS_DIALOG,
    LIFT_DIALOG,
    BANK_DIALOG,
    BAN_DIALOG,
    VEHICLE_DIALOG,
    TOY_DIALOG,
    CARBUY_DIALOG,
    VEHICLE_PLATE_DIALOG,
    CUSTOM_PLATE_DIALOG,
    VMENU_DIALOG,
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
	MOST_PLAYING_TIME_DIALOG,
	RICHLIST_DIALOG,
	SCORE_DIALOG,
	GANGS_DIALOG,
	HOUSE_UPGRADE_DIALOG,
	SETTINGS_DIALOG,
	GANG_KICK_DIALOG,
	CLOSE_GANG_DIALOG,
	GANG_SET_RANK_DIALOG,
	RULES_DIALOG,
    TOP_GANGS_DIALOG,
    NAME_CHANGE_DIALOG,
    HAREFILL_DIALOG,
    VCONTROL_DIALOG,
    VIP_DIALOG,
    ADMIN_CMD_DIALOG,
    LABEL_DIALOG,
    COLOR_DIALOG,
    ANN2_DIALOG
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
  	THREAD_LOAD_PLAYER,
  	THREAD_LOAD_PLAYER_GANG,
  	THREAD_CHECK_PLAYER_PASSWD,
  	THREAD_BUY_VEHICLE,
  	THREAD_LOAD_PLAYER_VEH,
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
 	THREAD_ASSIGN_RANK,
	THREAD_ASSIGN_RANK_2,
  	THREAD_CHECK_AUTO_LOGIN
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
	WAR,
	HOUSE,
	BUYCAR,
	gBG_VOTING,
	GUNGAME,
	FALLOUT,
	BUILDRACE,
	STORE,
	SPEC,
	VIPL
}

// -
// - gang pos
// -
enum e_gang_pos
{
	E_gang_pos_name[16]
}

// -
// - player enum
// -
enum e_player_data
{
	bool:GotVIPLInv,
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
	bool:bHasSpawn,
	bool:bFirstSpawn,
	bool:bFooterEnabled,
	bool:bRainbow,
	bool:vTDShown,
	bool:RampActive,
	bool:bCaps,
	bool:bGod,
	TrailerVid,
	tRainbow,
	tTDhandle,
	ExitType,
	GlobalID,
	Level,
	Kills,
	Deaths,
	Money,
	Score,
	DerbyWins,
	RaceWins,
	FalloutWins,
	GungameWins,
	BGWins,
	PayDay,
	tPayDay,
	tInfo,
  	Houses,
	Props,
	PropEarnings,
	tickLastVIPLInv,
	tickLastRefill,
	tickLastReport,
	tickLastHitman,
	tickLastGInvite,
	tickLastGKick,
	tickLastGCreate,
	tickLastLocked,
	tickLastBIKEC,
  	tickLastBuy,
  	tickLastPBuy,
  	tickLastSell,
  	tickLastPSell,
  	tickLastPW,
  	tickLastChat,
  	tickLastPM,
  	tickPlayerUpdate,
  	tickLastCD,
  	LastLogged,
  	BuyAbleVeh,
	Reaction,
	Bank,
	TotalTime,
	ConnectTime,
	VIP,
	LastNameChange,
	Warnings,
	RankSelected,
	Wanteds,
	HitmanHit,
	Vehicle,
	PV_Vehicle,
	Text3D:PV_3DLabel,
	Text3D:AdminDutyLabel,
	Text3D:VIPLabel,
	ChatWrote,
	FailLogin,
	MuteTimer,
 	GangPosition,
 	TmpGangID,
 	GangID,
	Text3D:GangLabel,
	GangKickMem[MAX_PLAYER_NAME],
	GangAssignRank[MAX_PLAYER_NAME],
 	GangName[21],
 	GangTag[5],
 	RegDate,
 	HouseIntSelected,
	Float:sX,
	Float:sY,
	Float:sZ,
	Float:sA,
	SpecID,
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
enum e_player_ach_data
{
    E_ach_styler, // Buy a toy (/toy)
	E_ach_grimreaper, // Make 150 Kills
	E_ach_masskiller, // Get a 25 Killstreak
	E_ach_eliteracer, // win 10 races
	E_ach_toofast, // win 10 reaction tests
	E_ach_scorewhore, // get 2000 score
	E_ach_destroyer, // win 10 derbys
	E_ach_restinpeace, // die 50 times
	E_ach_silentkiller, // kill someone with a knife
    E_ach_oneshot2kills, // win 10 gungames
    E_ach_deepimpact, // win 10 fallouts
	E_ach_skydiver, // win /skydive and /skydive2 in a row
	E_ach_biker // win /bikec
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

enum e_top_time
{
	E_playerid,
	E_time
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
	intname[32],
	price
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
enum e_derby_map7_data
{
	Float:m7sX,
	Float:m7sY,
	Float:m7sZ,
	Float:m7sA,
	bool:m7sUsed
}
enum e_derby_map8_data
{
	Float:m8sX,
	Float:m8sY,
	Float:m8sZ,
	Float:m8sA,
	bool:m8sUsed
}
enum e_derby_map9_data
{
	Float:m9sX,
	Float:m9sY,
	Float:m9sZ,
	Float:m9sA,
	bool:m9sUsed
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

new const ServerMSGS[11][] =
{
	""IVORY_E"* Visit our site: http://www.stunt-evolution.net",
	""IVORY_E"* Join Minigames for money and score - /help",
	""IVORY_E"* Player Control: /settings",
	""IVORY_E"* Get VIP (/vip) today! http://www.stunt-evolution.net/vip",
	""IVORY_E"* Get VIP (/vip) today! http://www.stunt-evolution.net/vip",
	""IVORY_E"* Join Minigames to earn money and score - /help",
	""IVORY_E"* Got suggestions? Post them in our forum! (forum.stunt-evolution.net)",
	""IVORY_E"* Use /report to report a player to the admins",
	""IVORY_E"* Add NGS to your favlist! samp.stunt-evolution.net:7777",
	""IVORY_E"* Get VIP (/vip) today! http://www.stunt-evolution.net/vip",
	""IVORY_E"* User Control Panel is available under http://wwww.stunt-evolution.net"
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

new Derby_Map7Spawns[MAX_DERBY_PLAYERS][e_derby_map7_data] =
{
	{3960.6386, -1944.5787, 18.4141, 358.5083, false},
	{3980.8674, -1929.7977, 18.4195, 268.1833, false},
	{4022.4838, -1930.0488, 18.4187, 269.7169, false},
	{4045.8247, -1907.4794, 18.4188, 357.8791, false},
	{4030.3295, -1887.8428, 18.4189, 91.7818, false},
	{4016.0778, -1865.5898, 18.4192, 358.0066, false},
	{4035.0522, -1852.3995, 18.4187, 274.9741, false},
	{4061.4140, -1861.6960, 18.4195, 182.9152, false},
	{4021.7668, -1860.1213, 2.3192, 358.7831, false},
	{4010.0903, -1839.4732, 2.3187, 89.5712, false},
	{4000.9663, -1855.6241, 2.3181, 179.8362, false},
	{4000.9157, -1889.3894, 2.3193, 179.4432, false},
	{4002.6320, -1934.3292, 2.3212, 270.4774, false},
	{4055.7233, -1934.5892, 2.3187, 269.3928, false},
	{4078.1877, -1958.6982, 11.8245, 181.6002, false},
	{4075.5852, -1981.8278, 18.5128, 90.4912, false},
	{3970.4362, -1887.3116, 34.5187, 269.4546, false},
	{4055.2961, -1839.7485, 2.3198, 269.8952, false},
	{3987.2399, -1877.1705, 2.3187, 29.7201, false},
	{3949.7727, -1876.2434, 2.3193, 120.9179, false}
};

new Derby_Map8Spawns[MAX_DERBY_PLAYERS][e_derby_map8_data] =
{
	{2877.0895, -3516.3852, 3.8995, 3.6558, false},
	{2876.3090, -3489.0278, 3.7439, 359.1965, false},
	{2862.3476, -3455.2319, 3.7448, 87.9087, false},
	{2822.9160, -3455.1120, 3.7435, 90.5475, false},
	{2810.1420, -3470.2883, 3.7450, 184.3539, false},
	{2811.4875, -3500.8076, 3.7440, 181.9071, false},
	{2837.4123, -3532.7248, 3.7446, 273.5574, false},
	{2914.0532, -3521.1247, 3.7449, 276.6305, false},
	{2939.2919, -3483.3242, 3.7434, 359.0291, false},
	{2810.0517, -3533.5646, 3.6433, 179.0697, false},
	{2806.7663, -3556.5236, 3.6172, 163.5164, false},
	{2823.8247, -3620.4379, 3.6288, 196.9598, false},
	{2874.1066, -3651.7585, 3.6459, 292.5925, false},
	{2897.0979, -3629.5671, 3.6586, 303.1914, false},
	{2929.5373, -3612.1718, 4.0115, 298.3864, false},
	{2931.2968, -3570.4431, 4.4742, 55.9420, false},
	{2903.1877, -3607.6376, 3.7671, 26.7458, false},
	{2922.8671, -3455.3676, 3.7374, 269.1679, false},
	{2940.0532, -3483.3977, 3.7377, 179.7474, false},
	{2906.5222, -3545.7534, 4.8501, 43.4955, false}
};

new Derby_Map9Spawns[MAX_DERBY_PLAYERS][e_derby_map9_data] =
{
	{4564.8662, -1780.7690, 3.4892, 113.5751, false},
	{4537.0317, -1773.2226, 3.5079, 17.6972, false},
	{4532.4731, -1730.4630, 3.5094, 1.5997, false},
	{4528.1772, -1693.3404, 3.5067, 9.8237, false},
	{4509.5317, -1651.5343, 3.5063, 36.9094, false},
	{4476.1191, -1650.5437, 3.5087, 183.0121, false},
	{4478.9091, -1687.5764, 3.5100, 183.2693, false},
	{4479.6303, -1734.8458, 3.5113, 179.2202, false},
	{4496.7563, -1803.1461, 3.5070, 302.3572, false},
	{4553.0380, -1734.8894, 3.5056, 270.5491, false},
	{4539.4926, -1761.5322, 18.3019, 7.2416, false},
	{4525.7851, -1701.7504, 18.2979, 7.8820, false},
	{4496.1748, -1657.7183, 18.3030, 129.2133, false},
	{4543.4536, -1796.9326, 18.3018, 187.9175, false},
	{4505.9531, -1744.8052, 3.5002, 269.9085, false},
	{4515.0185, -1760.6062, 3.5032, 216.3052, false},
	{4565.7241, -1689.1856, 3.4987, 59.0123, false},
	{4540.9121, -1656.6251, 3.5087, 1.8054, false},
	{4558.3378, -1645.2890, 3.4925, 145.0575, false},
	{4507.0502, -1796.4394, 3.5054, 120.5433, false}
};

new const GangPositions[7][e_gang_pos] =
{
	{"None"},
	{"Junior Member"},
	{"Member"},
	{"Senior Member"},
	{"Advisor"},
	{"Leader"},
	{"Main Leader"}
};

new const HouseIntTypes[14][e_house_type] =
{
    {1, 244.411987, 305.032989, 999.148437, "Barrack", 30000}, //0 			// 7, klein billig aber gut
    {2, 225.756989, 1240.000000, 1082.149902, "Standard", 1000000}, //1 				// 1, billig haus
    {1, 223.043991, 1289.259888, 1082.199951, "Advanced Standard", 250000}, //2			// 2, klein aber fein
    {2, 2454.717041, -1700.871582, 1013.515197, "Ryders House", 300000}, //3				// 13, normal wohnung pic 443
    {8, 2807.619873, -1171.899902, 1025.570312, "Bunker House", 450000}, //4			// 9, muss raus // jetzt ist Colonel Furhberger's drinne
    {4, 302.180999, 300.722991, 999.148437, "Underground", 500000}, 	//5			// 10, nette bude
    {2, 271.884979, 306.631988, 999.148437, "Nice Small Hotel Room", 600000},//6 			// 8, nice one /white
	{3, 2496.049804, -1695.238159, 1014.742187, "CJs House", 750000}, //7			// 4, muss raus exec // jetzt ist CJ drinne
	{3, 235.508994, 1189.169897, 1080.339966, "Luxus House", 900000}, //8			// 0,  schönes haus mit roten boden pic 429
	{2, 1204.809936, -11.586799, 1000.921875, "Strip Club", 1000000}, //9			// 6, mus raus exec // jetzt ist strip club drinne
	{15,2215.454833, -1147.475585, 1025.796875, "Entire Motel", 1200000}, //10					// 12, muss raus // jetzt ist jeff motel drinne
	{12,2324.419921, -1145.568359, 1050.710083, "Small Villa", 1500000}, 	//11			// 11, muss raus // jetzt ist small villa drinne
	{7, 225.630997, 1022.479980, 1084.069946, "Big Villa", 2000000}, //12			// 3, big villa
	{5, 1267.663208, -781.323242, 1091.906250, "Madd Doggs Mansion", 3000000} 	//13		// 5, muss raus exec // jetzt ist maddog drinne
};

new Iterator:RaceJoins<12>,
	Iterator:DerbyVoters<MAX_PLAYERS>,
	Iterator:PlayerIgnore[MAX_PLAYERS]<MAX_PLAYERS>,
	Teleports[MAX_TELE_CATEGORYS][50][26],
	Teleport_Index[MAX_TELE_CATEGORYS],
	TeleportDialogString[MAX_TELE_CATEGORYS][2048],
	g_asIP[MAX_PLAYERS][16],
	pAch[MAX_PLAYERS][e_player_ach_data],
	mathsAnswered = -1,
	mathsCurrent[14],
	mathsAnswer,
	mathsAward,
	engine,
 	lights,
 	alarm,
 	doors,
 	bonnet,
 	boot,
 	objective,
	bool:IsMellnikGateMoving = false,
	MellnikGate,
	LastPlayerText[MAX_PLAYERS][144],
    PlayerToys[MAX_PLAYERS][5][e_toy_data],
	StartTime,
	hVIPVehObj[MAX_PLAYERS][13],
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
  	DerbyMapVotes[9],
  	CurrentDerbyMap = 1,
  	BGGameTime = DEFAULT_BG_TIME,
  	FalloutGameTime = DEFAULT_FALLOUT_TIME,
  	DerbyGameTime = DEFAULT_DERBY_TIME,
  	tDerbyTimer = -1,
  	tDerbyVoting = -1,
  	tDerbyFallOver = -1,
 	tProcessTick = -1,
  	pDerbyCar[MAX_PLAYERS],
  	bool:bDerbyAFK[MAX_PLAYERS],
  	DerbyPlayers = 0,
	bool:IsDerbyRunning = false,
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
  	VIPLpickup,
  	VIPLpickup2,
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
  	PlayerText:TXTPlayerFooter[MAX_PLAYERS],
  	PlayerText:DynamicAchTD[MAX_PLAYERS][2],
  	PlayerText:TXTKillerText[MAX_PLAYERS],
  	PlayerText:TXTGunGameInfo[MAX_PLAYERS],
  	PlayerText:TXTPlayerInfo[MAX_PLAYERS],
  	PlayerText:vTD[MAX_PLAYERS],
	PlayerText:RaceInfo[MAX_PLAYERS],
	PlayerText:InfoTD[MAX_PLAYERS],
  	Text:NGSLOGO[3],
  	Text:TXTGunGameSign,
  	Text:TXTGunGameBox,
  	Text:TXTGreenStripP1,
  	Text:TXTGreenStripP2,
  	Text:TXTBlackScreenP1,
  	Text:TXTBlackScreenP2,
  	Text:TXTLogonStars,
  	Text:TXTLoading,
  	Text:TXTInfo,
  	Text:TXTLocalSignP1,
  	Text:TXTLocalSignP2,
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
	Text:godTD,
	Text:CheckTD,
	Text:NewMsgTD,
	Text:ErrorTD,
	Text:FooterBlack,
    Text:AchTD[6],
	Text:TXTWelcome[6],
	Text:TXTConnect[10],
	toyslist = mS_INVALID_LISTID,
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
  	BankMIcon[MAX_BANKS],
  	CluckinBellMIcon[MAX_CLUCKINBELLS],
  	BurgerMIcon[MAX_BURGERSHOTS],
  	AmmunationMIcon[MAX_AMMUNATIONS],
  	PizzaMIcon[MAX_PIZZASTACKS],
  	TFSMIcon[MAX_TFS],
  	bool:ReactionOn,
  	tRandomTXTInfo,
  	AdminLC,
  	AdminLC2,
  	gLastMap[MAX_PLAYERS],
  	PlayerInfo[MAX_PLAYERS][e_player_data],
  	PlayerInfoVeh[MAX_PLAYERS][e_player_veh_data],
  	HouseInfo[MAX_HOUSES][e_house_data],
  	PropInfo[MAX_PROPS][e_property_data],
  	pick_chainsaw,
  	pick_life[14],
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
  	tickReactionStart,
  	CurrentFalloutPlayers = 0,
  	CurrentDerbyPlayers = 0,
  	iCountdownVIP = 5,
 	bool:IsCountDownRunning = false,
 	tVIPCountdown = -1,
 	randomColors[24] = {6, 7, 126, 128, 130, 152, 158, 228, 181, 229, 205, 1, 6, 243, 3, 175, 137, 155, 158, 79, 161, 162, 192, 3},
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
	RaceSpawnCount = 0,
	trCounter = -1,
	iRaceEnd,
	RaceTime,
	RacePosition[MAX_PLAYERS],
	RaceNames[MAX_RACES][16],
 	TotalRaces,
 	RaceStatus,
 	T_RacePlayers = 0,
	T_DerbyPlayers = 0,
	T_GunGamePlayers = 0,
	T_FalloutPlayers = 0,
	T_TDMPlayers = 0,
	T_WarPlayers = 0,
	T_MinigunPlayers = 0,
	T_SniperPlayers = 0;
	
new Float:FRX[MAX_PLAYERS], Float:FRY[MAX_PLAYERS], Float:FRZ[MAX_PLAYERS];
new Float:FTX[MAX_PLAYERS], Float:FTY[MAX_PLAYERS], Float:FTZ[MAX_PLAYERS];
new Float:RBX[MAX_PLAYERS], Float:RBY[MAX_PLAYERS], Float:RBZ[MAX_PLAYERS];
new firecrackertime[MAX_PLAYERS];
new firerockettime[MAX_PLAYERS];
new explosionrocket[MAX_PLAYERS];
new Firecracker[MAX_PLAYERS];
new Firerocket[MAX_PLAYERS];
new rocketsmoke[MAX_PLAYERS];
new FireCrackerRoll[MAX_PLAYERS];
new firecrackerroll[MAX_PLAYERS];
new CrackerRollSmoke[MAX_PLAYERS];
new Float:RollStartX[MAX_PLAYERS], Float:RollStartY[MAX_PLAYERS], Float:RollStartZ[MAX_PLAYERS];

new RocketBoxTime[MAX_PLAYERS];
new RocketBox[MAX_PLAYERS];
new RocketBoxSmoke[MAX_PLAYERS];

new FountainSmoke[MAX_PLAYERS];
new Fountain[MAX_PLAYERS];

new Light[MAX_LIGHTS][MAX_PLAYERS];
new RollParts[MAX_PLAYERS][MAX_PARTS];
new FountainSprinkle[Sprinkleid][MAX_PLAYERS];

new RocketBoxSprinkle[RBSprinkleid][MAX_PLAYERS];
new RBLight[MAX_LIGHTS][MAX_PLAYERS];

new Fountain1Time[MAX_PLAYERS];
new Fountain2Time[MAX_PLAYERS];
new Fountain3Time[MAX_PLAYERS];
new DestroySprinkleID[MAX_PLAYERS];

enum FWN
{
    FireCracker,
    Firerocket1,
    Firerocket2,
    Crackerroll,
    Fountain1,
    Fountain2,
    Fountain3,
    RocketB,
    DrawDistance,
};
new AllowedFirework[FWN];
	
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
	"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
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
	{133.2702, 2076.2271, 70.1628, 182.0589},
	{157.3591, 2062.8499, 67.4000, 85.6672},
	{134.7271, 2052.1414, 72.1535, 346.4713},
	{128.3802, 2049.6685, 88.4781, 8.9248},
	{110.9025, 2050.5190, 73.0875, 2.9044},
	{115.5225, 2063.9746, 65.2181, 314.8837},
	{130.2743, 2101.7676, 61.6595, 195.0075},
	{135.0822, 2041.0424, 65.1818, 86.6981},
	{121.3894, 2036.3778, 69.1681, 331.7290}
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
new Float:WorldSpawns[3][4] =
{
	{341.8535, -1852.6327, 8.2618, 90.2136}, //beach
	{-1196.3280, -17.4523, 15.8281, 42.5799}, //sfa
	{383.5131, 2537.2727, 18.8503, 179.3657} // /aa
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
    {1166},
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
    {1190},
    {1191}
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
    {1167},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1192},
    {1193}
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
	print("=====================Stunt Evolution=====================");

	mysql_debug(1);
	enable_mutex(true);
    MySQL_Connect();
    MySQL_ClearLoggedPlayers();

	Streamer_TickRate(69);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, STREAMER_TYPE_OBJECT - 15);

    BuildServerMap();
    BuildServerMap2();
    BuildServerMap3();
    
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
    ExecDerbyVotingTimer();
    ExecBGVotingTimer();
    LoadRaceNames();
    ClearDerbyVotes();

	tProcessTick = SetTimer("ProcessTick", 1000, true);
	tReactionTimer = SetTimer("xReactionTest", REAC_TIME, true);
	SetTimer("DelayAutoRace", 40307, false);
	SetTimer("Maths", 400000, true);
	SetTimer("RandomSvrMsg", SERVERMSGS_TIME, true);

    SollIchDirMaEtWatSagen();

	ConnectNPC("[SE]Floatround", "bot0");
	ConnectNPC("[SE]Inyaface", "bot1");
	ConnectNPC("[SE]SS_FatGuy", "bot2");
	ConnectNPC("[SE]TrainRider", "train_lv");
	ConnectNPC("[SE]CrazyLilMan", "at400_ls");

    LoadServerVehicles();

	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		SetVehicleNumberPlate(i, "{3399ff}S{FFFFFF}tun{F81414}T");
		SetVehicleToRespawn(i);
		AddVehicleComponent(i, 1010);
		ChangeVehicleColor(i, (random(128) + 127), (random(128) + 127));
	}

	print("=====================Stunt Evolution=====================");
	return 1;
}

public OnGameModeExit()
{
	print("Unloading GameMode...");
    new stats[255];
	mysql_stat(stats, g_SQL_handle);
	print(stats);

    KillTimer(tProcessTick);
	KillTimer(tReactionTimer);
	KillTimer(tRandomTXTInfo);
	KillTimer(tBGVoting);
	KillTimer(tBGTimer);
  	KillTimer(tDerbyTimer);
    KillTimer(tDerbyFallOver);
  	KillTimer(tDerbyVoting);
	KillTimer(trCounter);
	KillTimer(tRaceCount);

	DestroyTextdraws();
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
		if(!strcmp(__GetName(playerid), "[SE]TrainRider", true))
 		{
	        SetSpawnInfo(playerid, NO_TEAM, 255, 1462.0745, 2630.8787, 10.8203, 0.0, -1, -1, -1, -1, -1, -1);
		}
 	 	else if(!strcmp(__GetName(playerid), "[SE]CrazyLilMan", true))
 		{
	        SetSpawnInfo(playerid, NO_TEAM, 4, -2006.5000, 144.8758, 28.8756, 180.0000, -1, -1, -1, -1, -1, -1);
		}
		return 1;
	}

	TogglePlayerControllable(playerid, true);
    TextDrawHideForPlayer(playerid, TXTBlackScreenP1);
	TextDrawHideForPlayer(playerid, TXTBlackScreenP2);
	TextDrawHideForPlayer(playerid,	TXTGreenStripP1);
	TextDrawHideForPlayer(playerid,	TXTGreenStripP2);

	TextDrawShowForPlayer(playerid, NGSLOGO[0]);
	TextDrawShowForPlayer(playerid, NGSLOGO[1]);
	TextDrawShowForPlayer(playerid, NGSLOGO[2]);

	HidePlayerDerbyTextdraws(playerid);
	HidePlayerBGTextdraws(playerid);
	HidePlayerFalloutTextdraws(playerid);
	ShowPlayerWelcomeTextdraws(playerid);

	TextDrawHideForPlayer(playerid, TXTLocalSignP1);
	TextDrawHideForPlayer(playerid, TXTLocalSignP2);
 	TextDrawHideForPlayer(playerid, TXTLogonStars);

	ShowPlayerMeshTXT(playerid);

	ShowPlayerInfoTextdraws(playerid);

	SetPlayerPos(playerid, 387.5766, -1811.7660, 17.2455);
	SetPlayerFacingAngle(playerid, 301.7893);
	PlayerInfo[playerid][bFirstSpawn] = true;

	new rand = random(3);
	switch(rand)
	{
		case 0: ApplyAnimation(playerid, "DANCING", "DNCE_M_A", 4.1, 1, 1, 1, 1, 1);
		case 1: ApplyAnimation(playerid, "STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 1, 1, 1, 1, 1);
	}
	switch(rand)
	{
		case 0: ApplyAnimation(playerid, "DANCING", "DNCE_M_A", 4.1, 1, 1, 1, 1, 1);
		case 1: ApplyAnimation(playerid, "STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 1, 1, 1, 1, 1);
	}
	switch(rand)
	{
		case 0: ApplyAnimation(playerid, "DANCING", "DNCE_M_A", 4.1, 1, 1, 1, 1, 1);
		case 1: ApplyAnimation(playerid, "STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1);
		case 2: ApplyAnimation(playerid, "SMOKING", "M_smk_in", 4.1, 1, 1, 1, 1, 1);
	}

    TextDrawHideForPlayer(playerid, TXTInfo);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if(IsPlayerNPC(playerid)) return 1;
	if(!PlayerInfo[playerid][AllowSpawn])
	{
	    SCM(playerid, -1, ""er"You are not logged in!");
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

        if(!strcmp(botname, "[SE]Floatround", true))
		{
		    format(string, sizeof(string), ""vgreen"MC public urination\n\n[SE]Floatround\nID: %i", playerid);
	     	CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
			SetPlayerSkin(playerid, 2);
		}
        else if(!strcmp(botname, "[SE]Inyaface", true))
		{
		    format(string, sizeof(string), ""vgreen"MC uses time machines irresponsibly\n\n[SE]Inyaface\nID: %i", playerid);
			CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
			SetPlayerSkin(playerid, 3);
		}
        else if(!strcmp(botname, "[SE]SS_FatGuy", true))
		{
		 	format(string, sizeof(string), ""vgreen"MC ate to many burgers\n\n[SE]SS_FatGuy\nID: %i", playerid);
			CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
			SetPlayerSkin(playerid, 5);
		}
		else if(!strcmp(botname, "[SE]TrainRider", true))
		{
		    format(string, sizeof(string), ""vgreen"MC no MC\n\n[SE]TrainRider\nID: %i", playerid);
			CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
	        PutPlayerInVehicle(playerid, 1, 0);
	 	}
  		else if(!strcmp(botname, "[SE]CrazyLilMan", true))
		{
		    format(string, sizeof(string), ""vgreen"MC whose father is a traindriver\n\n[SE]CrazyLilMan\nID: %i", playerid);
			CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
	        PutPlayerInVehicle(playerid, 2, 0);
	 	}
		return 1;
    }

    PlayerTextDrawHide(playerid, TXTKillerText[playerid]);
	TextDrawHideForPlayer(playerid, TXTBlackScreenP1);
	TextDrawHideForPlayer(playerid, TXTBlackScreenP2);
	TextDrawShowForPlayer(playerid, FooterBlack);
	PlayerTextDrawShow(playerid, TXTPlayerFooter[playerid]);
	TextDrawShowForPlayer(playerid, NGSLOGO[0]);
    TextDrawShowForPlayer(playerid, NGSLOGO[1]);
    TextDrawShowForPlayer(playerid, NGSLOGO[2]);

    AttachPlayerToys(playerid);

    if(PlayerInfo[playerid][bFirstSpawn])
    {
        PlayerInfo[playerid][bFirstSpawn] = false;
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
		RandomSpawn(playerid);
		RandomWeapon(playerid);
		HidePlayerWelcomeTextdraws(playerid);
		TextDrawShowForPlayer(playerid, TXTInfo);
		if(PlayerInfo[playerid][VIP] == 1)
		{
		    SetPlayerArmour(playerid, 100.0);
		}
    }
    else switch(gTeam[playerid])
    {
        case SPEC:
        {
	    	SetPlayerPos(playerid, PlayerInfo[playerid][SpecX], PlayerInfo[playerid][SpecY], PlayerInfo[playerid][SpecZ]);
			SetPlayerFacingAngle(playerid, PlayerInfo[playerid][SpecA]);
			ResetPlayerWeapons(playerid);
			gTeam[playerid] = NORMAL;
        }
        case NORMAL:
        {
            if(PlayerInfo[playerid][bHasSpawn])
            {
        		SetPlayerPos(playerid, PlayerInfo[playerid][CSpawnX], PlayerInfo[playerid][CSpawnY], PlayerInfo[playerid][CSpawnZ]);
			    SetPlayerFacingAngle(playerid, PlayerInfo[playerid][CSpawnA]);
			    SetCameraBehindPlayer(playerid);
            }
            else
            {
                RandomSpawn(playerid);
            }
			SetCameraBehindPlayer(playerid);
			
			if(PlayerInfo[playerid][bGod])
			{
			    SetPlayerHealth(playerid, 99999.0);
			    ResetPlayerWeapons(playerid);
			    TextDrawShowForPlayer(playerid, godTD);
			}
			else
			{
			    RandomWeapon(playerid);
			}
			
			if(PlayerInfo[playerid][VIP] == 1)
			{
			    SetPlayerArmour(playerid, 100.0);
			}
		}
		case DERBY:
		{
		    SetPlayerDerbyStaticMeshes(playerid);
		}
		case WAR:
		{
			switch(random(4))
			{
			    case 0: SetPlayerPosition(playerid, 164.9882,1922.3430,18.4712,247.7249);
			    case 1: SetPlayerPosition(playerid, 285.5063,1819.9249,24.4108,1.9556);
			    case 2: SetPlayerPosition(playerid, 291.3683,1918.2693,17.6265,275.6602);
			    case 3: SetPlayerPosition(playerid, 236.5930,1918.7386,17.6446,145.6778);
			}

			SCM(playerid, -1, ""war_sign" You have respawned in War");
   			GivePlayerWeapon(playerid, 3, 1);
    		GivePlayerWeapon(playerid, 24, 9999999);
    		GivePlayerWeapon(playerid, 25, 9999999);
		 	GivePlayerWeapon(playerid, 28, 9999999);
    		GivePlayerWeapon(playerid, 30, 9999999);
    		GivePlayerWeapon(playerid, 33, 9999999);
    		GivePlayerWeapon(playerid, 39, 2);
    		GivePlayerWeapon(playerid, 17, 10);
    		GivePlayerWeapon(playerid, 10, 1);
			SetPlayerHealth(playerid, 100);
			
			SetPlayerWorldBounds(playerid, 432.0814, -81.74512, 2125.373, 1646.58);
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
			if(!PlayerInfo[playerid][bGod])
			{
		    	RandomWeapon(playerid);
			}
			ResetPlayerWorld(playerid);
			gTeam[playerid] = NORMAL;
		}
		case GUNGAME:
		{
			new rand = random(9);
			ResetPlayerWeapons(playerid);

			SetPlayerPosEx(playerid, GunGame_Spawns[rand][0], GunGame_Spawns[rand][1], floatadd(GunGame_Spawns[rand][2], 2.5));
			SetPlayerFacingAngle(playerid, GunGame_Spawns[rand][3]);
			SetCameraBehindPlayer(playerid);

			GivePlayerWeapon(playerid, 4, 1);
			GivePlayerWeapon(playerid, GunGame_Weapons[GunGame_Player[playerid][level]], 65535);

			GunGame_Player[playerid][dead] = false;
			GunGame_Player[playerid][pw] = true;
			if(GunGamePlayers >= 16) SetPlayerHealth(playerid, 100.0);
			else SetPlayerHealth(playerid, ((25) + (5 * GunGamePlayers)));
		}
    }
    
	if(PlayerInfo[playerid][onduty])
	{
		SetPlayerHealth(playerid, 99999.0);
		SetPlayerAttachedObject(playerid, 9, 18646, 2, 0.200000, 0.000000, 0.000000, -0.000000, 90.000000, 0.000000, 0.799999, 0.899999, 1.000000);
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
		SCM(playerid, GREY, " ");
	}

	PlayerInfo[playerid][Level] = 0;
    LabelActive[playerid] = false;
    PlayerHit[playerid] = false;
    PlayerInfo[playerid][tTimerHP] = -1;
	PlayerInfo[playerid][ExitType] = 1;
	PlayerInfo[playerid][Logged] = false;
	PlayerInfo[playerid][AllowSpawn] = false;
	PlayerInfo[playerid][AOnline] = true;
	PlayerInfo[playerid][bCaps] = true;
	PlayerInfo[playerid][bGod] = false;
	PlayerInfo[playerid][vTDShown] = false;
	bDerbyAFK[playerid] = false;
	PlayerInfo[playerid][GotVIPLInv] = false;
	PlayerInfo[playerid][ConnectTime] = 0;
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

	PlayerInfo[playerid][GangPosition] = GANG_POS_NONE;
	PlayerInfo[playerid][GangID] = 0;
	PlayerInfo[playerid][TmpGangID] = 0;
	PlayerInfo[playerid][GangName][0] = '\0';
	PlayerInfo[playerid][GangTag][0] = '\0';
	PlayerInfo[playerid][GangKickMem][0] = '\0';
	PlayerInfo[playerid][GangAssignRank][0] = '\0';
	
	SetPVarInt(playerid, "doingStunt", 0);

	strmid(PlayerInfoVeh[playerid][Plate], "---", 0, 13, 13);
    strmid(LastPlayerText[playerid], " ", 0, 144, 144);

 	GunGame_Player[playerid][level] = 0;
	GunGame_Player[playerid][dead] = true;
	GunGame_Player[playerid][pw] = true;

	SetPVarInt(playerid, "LastID", -1);
	PlayerInfo[playerid][SpeedBoost] = true;
	PlayerInfo[playerid][SuperJump] = false;
	PlayerInfo[playerid][Frozen] = false;
	PlayerInfo[playerid][SavedPos] = false;
	PlayerInfo[playerid][bFooterEnabled] = true;
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
	PlayerInfo[playerid][Warnings] = 0;
	PlayerInfo[playerid][Houses] = 0;
	PlayerInfo[playerid][Props] = 0;
	PlayerInfo[playerid][Wanteds] = 0;
	PlayerInfo[playerid][Vehicle] = -1;
	PlayerInfo[playerid][TrailerVid] = -1;
	PlayerInfo[playerid][PV_Vehicle] = -1;
	PlayerInfo[playerid][FailLogin] = 0;
 	PlayerInfo[playerid][TotalTime] = 0;
	PlayerInfo[playerid][Muted] = false;
	PlayerInfo[playerid][MuteTimer] = -1;
	PlayerInfo[playerid][VIP] = 0;
	PlayerInfo[playerid][Frozen] = false;
	PlayerInfo[playerid][onduty] = false;
	PlayerInfo[playerid][gInvite] = false;
	PlayerInfo[playerid][FalloutLost] = true;
    PlayerInfo[playerid][bHasSpawn] = false;
    PlayerInfo[playerid][bRainbow] = false;
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
   	PlayerInfo[playerid][tickLastChat] = 0;
   	PlayerInfo[playerid][tickLastReport] = 0;
   	PlayerInfo[playerid][tickLastPM] = 0;
   	PlayerInfo[playerid][tickLastCD] = 0;
	PlayerInfo[playerid][tickLastRefill] = 0;
	PlayerInfo[playerid][tickLastVIPLInv] = 0;
	PlayerInfo[playerid][tickLastBIKEC] = 0;

	for(new ii = 0; e_player_ach_data:ii < e_player_ach_data; ii++)
	{
	    pAch[playerid][e_player_ach_data:ii] = 0;
	}

    Iter_Clear(PlayerIgnore[playerid]);

	for(new obj = 0; obj < 13; obj++)
	{
	    hVIPVehObj[playerid][obj] = -1;
	}

    SetPVarInt(playerid, "lastVehicle", -1);
   	DerbyVehLabel[playerid] = PlayerText3D:-1;
   	PlayerInfo[playerid][PV_3DLabel] = Text3D:-1;
   	PlayerInfo[playerid][GangLabel] = Text3D:-1;
	PlayerInfo[playerid][AdminDutyLabel] = Text3D:-1;
	PlayerInfo[playerid][VIPLabel] = Text3D:-1;

    PlayerInfo[playerid][toy_selected] = 0;
    PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;
    
    SetPVarInt(playerid, "AntiFall", 1);

    PlayerRaceVehicle[playerid] = -1;
    pDerbyCar[playerid] = -1;
    PreviewTmpVeh[playerid] = -1;

	_SetPlayerScore(playerid, 0);
	SetPlayerTeam(playerid, NO_TEAM);

	new ip[16],
		count = 1;

	GetPlayerIp(playerid, ip, sizeof(ip));
    strcat(g_asIP[playerid], ip, 16);
    
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i) || IsPlayerNPC(i) || i == playerid || isnull(g_asIP[i])) continue;
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
	HidePlayerRaceTextdraws(playerid);

	if(GlobalMain)
	{
	    SCM(playerid, RED, "Server is in going in maintenance mode, please try again later.");
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
		TextDrawShowForPlayer(playerid, TXTGreenStripP1);
		TextDrawShowForPlayer(playerid, TXTGreenStripP2);
		TogglePlayerSpectating(playerid, true);

        InitSession(playerid);

        Streamer_UpdateEx(playerid, 323.6630, -1852.8362, 8.2406, -1, -1);

		MySQL_IsAccountBanned(playerid);
 	}
 	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(IsPlayerNPC(playerid)) return 1;
    g_asIP[playerid][0] = '\0';

	KillTimer(PlayerInfo[playerid][tPayDay]);
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

		switch(gTeam[playerid])
		{
		    case gBG_TEAM1:
		    {
			    BGTeam1Players--;
		    }
		    case gBG_TEAM2:
		    {
			    BGTeam2Players--;
		    }
			case FALLOUT:
			{
                PlayerInfo[playerid][FalloutLost] = true;
				gTeam[playerid] = NORMAL;
				CurrentFalloutPlayers--;
			    new count = 0;
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
						    FalloutMSG("Fallout has been canceled!");
						    gTeam[i] = NORMAL;
					    }
					}
					Fallout_Cancel();
				}
			}
			case RACE:
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
				
			    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, 1);
			    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_MAP_ICON, 1);
			}
			case DERBY:
			{
			    //OPDisc
			    if(DerbyVehLabel[playerid] != PlayerText3D:-1)
			    {
			    	DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);
			    	DerbyVehLabel[playerid] = PlayerText3D:-1;
			    }

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
        	PlayerInfo[playerid][onduty] = false;
		}
		if(PlayerInfo[playerid][AdminDutyLabel] != Text3D:-1)
		{
		    DestroyDynamic3DTextLabel(PlayerInfo[playerid][AdminDutyLabel]);
		    PlayerInfo[playerid][AdminDutyLabel] = Text3D:-1;
		}

		if(PlayerInfo[playerid][GangLabel] != Text3D:-1)
		{
		    DestroyDynamic3DTextLabel(PlayerInfo[playerid][GangLabel]);
 			PlayerInfo[playerid][GangLabel] = Text3D:-1;
		}

        if(PlayerInfo[playerid][VIPLabel] != Text3D:-1)
        {
            DestroyDynamic3DTextLabel(PlayerInfo[playerid][VIPLabel]);
            PlayerInfo[playerid][VIPLabel] = Text3D:-1;
        }

        for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++)
        {
			if(IsPlayerAttachedObjectSlotUsed(playerid, i))
			{
				RemovePlayerAttachedObject(playerid, i);
			}
		}

		if(PlayerInfo[playerid][bRainbow])
		{
			KillTimer(PlayerInfo[playerid][tRainbow]);
			PlayerInfo[playerid][bRainbow] = false;
		}

		if(PlayerInfo[playerid][Vehicle] != -1)
		{
			DestroyVehicle(PlayerInfo[playerid][Vehicle]);
			PlayerInfo[playerid][Vehicle] = -1;
		}
		for(new obj = 0; obj < 13; obj++)
		{
		    if(hVIPVehObj[playerid][obj] != -1)
		    {
		        DestroyObject(hVIPVehObj[playerid][obj]);
		        hVIPVehObj[playerid][obj] = -1;
		    }
		}
		if(PlayerInfo[playerid][TrailerVid] != -1)
		{
			DestroyVehicle(PlayerInfo[playerid][TrailerVid]);
			PlayerInfo[playerid][TrailerVid] = -1;
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
	    if(PlayerInfo[playerid][PV_3DLabel] != Text3D:-1)
	    {
	        DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
	        PlayerInfo[playerid][PV_3DLabel] = Text3D:-1;
	    }
		if(PlayerInfo[playerid][PV_Vehicle] != -1)
		{
			DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
			PlayerInfo[playerid][PV_Vehicle] = -1;
		}

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
	    	if(gTeam[i] == SPEC && PlayerInfo[i][SpecID] == playerid)
	    	{
	   			cmd_specoff(i, "");
				SendInfo(i, "~r~~h~Player disconnected!", 4000);
			}
			
	  		if(Iter_Contains(PlayerIgnore[i], playerid))
		    {
		        Iter_Remove(PlayerIgnore[i], playerid);
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

	PlayerInfo[playerid][GangPosition] = GANG_POS_NONE;
	PlayerInfo[playerid][GangID] = 0;
	PlayerInfo[playerid][TmpGangID] = 0;
	PlayerInfo[playerid][GangName][0] = '\0';
	PlayerInfo[playerid][GangTag][0] = '\0';
	PlayerInfo[playerid][GangKickMem][0] = '\0';
	PlayerInfo[playerid][GangAssignRank][0] = '\0';

	strmid(PlayerInfoVeh[playerid][Plate], "---", 0, 13, 13);
	strmid(LastPlayerText[playerid], " ", 0, 144, 144);

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
	PlayerInfo[playerid][Warnings] = 0;
	PlayerInfo[playerid][Houses] = 0;
	PlayerInfo[playerid][Props] = 0;
	PlayerInfo[playerid][Wanteds] = 0;
	PlayerInfo[playerid][Vehicle] = -1;
	PlayerInfo[playerid][PV_Vehicle] = -1;
	PlayerInfo[playerid][FailLogin] = 0;
	PlayerInfo[playerid][VIP] = 0;
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
    PlayerInfo[playerid][tickLastRefill] = 0;

    PlayerInfo[playerid][toy_selected] = 0;

    PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;

	_SetPlayerScore(playerid, 0);
	SetPlayerTeam(playerid, NO_TEAM);
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(PlayerInfo[playerid][IsDead])
	{
	    SCM(playerid, -1, ""er"You can´t use commands while being dead!");
	    return 0;
	}
	if(!PlayerInfo[playerid][Logged])
	{
	    SCM(playerid, -1, ""er"You need to spawn to use commands!");
	    return 0;
	}
	if(PlayerInfo[playerid][Frozen])
	{
	    SCM(playerid, -1, ""er"You can´t use commands now!");
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

    format(logData, sizeof(logData), "[%02d:%02d:%02d] (%i)%s USED %s SUCCESS: %i\r\n", time[0], time[1], time[2], playerid, __GetName(playerid), cmdtext, success);
    fwrite(lFile, logData);
    fclose(lFile);

	PlayerInfo[playerid][iCoolDownCommand]++;
	SetTimerEx("CoolDownCommand", COOLDOWN_CMD, false, "i", playerid);
	if(PlayerInfo[playerid][iCoolDownCommand] == 8)
	{
	    return GameTextForPlayer(playerid, "~b~~h~no command spam", 2000, 3);
	}
	else if(PlayerInfo[playerid][iCoolDownCommand] >= 12 && PlayerInfo[playerid][Level] < 5)
	{
	    new string[100];
		format(string, sizeof(string), "Command-Spam detected! %s(%i) has been kicked!", __GetName(playerid), playerid);
		AdminMSG(RED, string);
		PlayerInfo[playerid][iCoolDownCommand] = 0;
		return Kick(playerid);
	}

	if(!success)
	{
	    format(logData, sizeof(logData), "~r~~h~Unknown command: %s!~n~~n~~w~These commands may help you~n~~g~~h~/help /cmds /tele /rules", cmdtext);
 		TextDrawShowForPlayer(playerid, ErrorTD);
		SetTimerEx("hideError", 4000, false, "i", playerid);
	    SendInfo(playerid, logData, 4000);
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

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
{
    if(!PlayerHit[damagedid])
    {
	    PlayerHit[damagedid] = true;
	    SetPlayerAttachedObject(damagedid, 8, 1240, 2, 0.44099, 0.0000, 0.02300, -1.79999, 84.09998, 0.00000, 1.00000, 1.00000, 1.00000);
	    SetTimerEx("remove_health_obj", 800, false, "i", damagedid);
	}
	if(PlayerInfo[damagedid][bGod])
	{
	    GameTextForPlayer(playerid, "~b~~h~~h~Player has GOD enabled", 2000, 3);
	    SetPlayerHealth(damagedid, 99999.0);
	}
	return 1;
}

public OnQueryFinish(query[], resultid, extraid, connectionHandle)
{
    switch(resultid)
	{
	    case THREAD_CHECK_AUTO_LOGIN:
	    {
	        new rows, fields;
	        cache_get_data(rows, fields, g_SQL_handle);

	        if(rows > 0)
	        {
	            // Auto Login
				SetTimerEx("AutoLoginCam", 2500, false, "i", extraid);
	        }
	        else
	        {
	            // Login Dialog
				SetTimerEx("LoginDialog", 2500, false, "i", extraid);
				SetTimerEx("LoginCam", 2500, false, "ib", extraid, false);
	        }
	    }
	    case THREAD_LOAD_TOYS:
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
        case THREAD_CHECK_IF_TOY_EXIST:
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
					    tmp[MAX_PLAYER_NAME + 50],
					    rank = 1;

					cache_get_row(i, 0, result, g_SQL_handle, sizeof(result));
					rank = cache_get_row_int(i, 1, g_SQL_handle);

					format(tmp, sizeof(tmp), "\n%i. %s (%s)", count + 1, result, GangPositions[rank][E_gang_pos_name]);
					strcat(tmpstring, tmp);
					count++;
				}
				format(finstring, sizeof(finstring), "There are "yellow"%i"white" members in this gang\n"green"All Members:"white"", count);
				strcat(finstring, tmpstring);

				ShowPlayerDialog(extraid, GANGMEM_DIALOG, DIALOG_STYLE_LIST, ""se" - Gang Members", finstring, "OK", "");
            }
        }
		case THREAD_FETCH_GANG_INFO:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);

		    if(rows > 0)
			{
			    new gangname[MAX_GANG_NAME+1],
	    			gangtag[5],
					score,
					udate,
					count = 0,
					members[1536],
					string[2048];

				cache_get_row(0, 1, gangname, g_SQL_handle, sizeof(gangname));
				cache_get_row(0, 2, gangtag, g_SQL_handle, sizeof(gangtag));
				score = cache_get_row_int(0, 3, g_SQL_handle);
				udate = cache_get_row_int(0, 4, g_SQL_handle);

				for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    if(IsPlayerNPC(i) || !IsPlayerConnected(i)) continue;
				    if(PlayerInfo[i][GangPosition] == 0) continue;
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
					""white"Gang name:\t"ngs_blue"%s\n"white"Gang tag:\t"ngs_blue"%s\n"white"Gang created:\t"ngs_blue"%s\n"white"Gang score:\t"ngs_blue"%i\n"white"Users online:\t"ngs_blue"%i\n\n"white"Online:%s\n"white"[... to many online]", gangname, gangtag, UnixTimeToDate(udate), score, count, members);
				}
				else
				{
				    format(string, sizeof(string),
					""white"Gang name:\t"ngs_blue"%s\n"white"Gang tag:\t"ngs_blue"%s\n"white"Gang created:\t"ngs_blue"%s\n"white"Gang score:\t"ngs_blue"%i\n"white"Users online:\t"ngs_blue"%i\n\n"white"Online:%s", gangname, gangtag, UnixTimeToDate(udate), score, count, members);
				}

				ShowPlayerDialog(extraid, GANGINFO_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Gang Info", string, "OK", "");
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
	 		   	SCM(extraid, -1, ""server_sign" You have been banned.");
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
  		    if(PlayerInfo[extraid][PV_3DLabel] != Text3D:-1)
		    {
		        DestroyDynamic3DTextLabel(PlayerInfo[extraid][PV_3DLabel]);
		        PlayerInfo[extraid][PV_3DLabel] = Text3D:-1;
		    }
			if(PlayerInfo[extraid][PV_Vehicle] != -1)
			{
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
		case THREAD_BUY_VEHICLE:
		{
		    PlayerInfo[extraid][BuyAbleVeh] = 1;
		    MySQL_SavePlayer(extraid);
		    MySQL_SavePlayerVeh(extraid);
		}
		case THREAD_CREATE_GANG:
		{
			PlayerInfo[extraid][GangPosition] = GANG_POS_MAIN_LEADER;
			PlayerInfo[extraid][GangID] = mysql_insert_id();

            GivePlayerCash(extraid, -1000000);

            MySQL_SavePlayer(extraid);

			new string[128];

			format(string, sizeof(string), ""ngs_blue"* "white"%s has created a new gang: '"ngs_blue"%s"white"'", __GetName(extraid), PlayerInfo[extraid][GangName]);
            SCMToAll(-1, string);
            print(string);

            ShowPlayerDialog(extraid, 5004, DIALOG_STYLE_MSGBOX, ""white"Gang created!", ""white"You can now use these commands:\n\n"dl"/gmenu\n"dl"/ginvite\n"dl"/gkick\n"dl"/gclose\n\nUse "ngs_blue"! "white"to talk in your gang chat", "OK", "");

			format(string, sizeof(string), ""ngs_blue"Gang:"white" %s", PlayerInfo[extraid][GangName]);

			if(PlayerInfo[extraid][GangLabel] != Text3D:-1)
			{
			    DestroyDynamic3DTextLabel(PlayerInfo[extraid][GangLabel]);
	 			PlayerInfo[extraid][GangLabel] = Text3D:-1;
			}

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
                
		        format(string, sizeof(string), ""red"You have been banned!"white"\n\nAdmin: \t\t%s\nYour name: \t%s\nReason: \t%s\nDate: \t\t%s\n\nIf you think that you have been banned wrongly,\nwrite a ban appeal on forum.stunt-evolution.net", adminname, __GetName(extraid), reason, UnixTimeToDate(udate));
				ShowPlayerDialog(extraid, BAN_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Notice", string, "OK", "");
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
   				SetTimerEx("RegisterDialog", 2500, false, "i", extraid);
				SetTimerEx("LoginCam", 2500, false, "ib", extraid, false );
		    }
		    else
		    {
		        MySQL_CheckAutoLogin(extraid);
				/*SetTimerEx("LoginDialog", 2500, false, "i", extraid);
				SetTimerEx("LoginCam", 2500, false, "i", extraid);*/
		    }
		}
		case THREAD_LOAD_PLAYER:
		{
		    new rows, fields;
			cache_get_data(rows, fields, g_SQL_handle);
			
			if(rows > 0)
			{
			    PlayerInfo[extraid][GlobalID] = cache_get_row_int(0, 0, g_SQL_handle);
			    PlayerInfo[extraid][Level] = cache_get_row_int(0, 5, g_SQL_handle);
			    PlayerInfo[extraid][Score] = cache_get_row_int(0, 6, g_SQL_handle);
			    PlayerInfo[extraid][Money] = cache_get_row_int(0, 7, g_SQL_handle);
			    PlayerInfo[extraid][Bank] = cache_get_row_int(0, 8, g_SQL_handle);
			    PlayerInfo[extraid][Kills] = cache_get_row_int(0, 9, g_SQL_handle);
			    PlayerInfo[extraid][Deaths] = cache_get_row_int(0, 10, g_SQL_handle);
			    PlayerInfo[extraid][TotalTime] = cache_get_row_int(0, 11, g_SQL_handle);
                PlayerInfo[extraid][Reaction] = cache_get_row_int(0, 12, g_SQL_handle);
                PlayerInfo[extraid][PayDay] = cache_get_row_int(0, 13, g_SQL_handle);
                PlayerInfo[extraid][Houses] = cache_get_row_int(0, 14, g_SQL_handle);
                PlayerInfo[extraid][Props] = cache_get_row_int(0, 15, g_SQL_handle);
                PlayerInfo[extraid][PropEarnings] = cache_get_row_int(0, 16, g_SQL_handle);
                PlayerInfo[extraid][GangPosition] = cache_get_row_int(0, 17, g_SQL_handle);
                PlayerInfo[extraid][GangID] = cache_get_row_int(0, 18, g_SQL_handle);
                PlayerInfo[extraid][BuyAbleVeh] = cache_get_row_int(0, 19, g_SQL_handle);
                PlayerInfo[extraid][DerbyWins] = cache_get_row_int(0, 21, g_SQL_handle);
                PlayerInfo[extraid][RaceWins] = cache_get_row_int(0, 22, g_SQL_handle);
                PlayerInfo[extraid][BGWins] = cache_get_row_int(0, 23, g_SQL_handle);
                PlayerInfo[extraid][FalloutWins] = cache_get_row_int(0, 24, g_SQL_handle);
                PlayerInfo[extraid][GungameWins] = cache_get_row_int(0, 25, g_SQL_handle);
                PlayerInfo[extraid][Wanteds] = cache_get_row_int(0, 26, g_SQL_handle);
                PlayerInfo[extraid][VIP] = cache_get_row_int(0, 27, g_SQL_handle);
                PlayerInfo[extraid][RegDate] = cache_get_row_int(0, 28, g_SQL_handle);
                PlayerInfo[extraid][LastLogged] = cache_get_row_int(0, 29, g_SQL_handle);
                PlayerInfo[extraid][LastNameChange] = cache_get_row_int(0, 30, g_SQL_handle);
                pAch[extraid][E_ach_styler] = cache_get_row_int(0, 31, g_SQL_handle);
                pAch[extraid][E_ach_grimreaper] = cache_get_row_int(0, 32, g_SQL_handle);
                pAch[extraid][E_ach_masskiller] = cache_get_row_int(0, 33, g_SQL_handle);
                pAch[extraid][E_ach_eliteracer] = cache_get_row_int(0, 34, g_SQL_handle);
                pAch[extraid][E_ach_toofast] = cache_get_row_int(0, 35, g_SQL_handle);
                pAch[extraid][E_ach_scorewhore] = cache_get_row_int(0, 36, g_SQL_handle);
                pAch[extraid][E_ach_destroyer] = cache_get_row_int(0, 37, g_SQL_handle);
                pAch[extraid][E_ach_restinpeace] = cache_get_row_int(0, 38, g_SQL_handle);
                pAch[extraid][E_ach_silentkiller] = cache_get_row_int(0, 39, g_SQL_handle);
                pAch[extraid][E_ach_oneshot2kills] = cache_get_row_int(0, 40, g_SQL_handle);
                pAch[extraid][E_ach_deepimpact] = cache_get_row_int(0, 41, g_SQL_handle);
                pAch[extraid][E_ach_skydiver] = cache_get_row_int(0, 42, g_SQL_handle);
                pAch[extraid][E_ach_biker] = cache_get_row_int(0, 43, g_SQL_handle);
                
   				if(PlayerInfo[extraid][BuyAbleVeh] == 1)
				{
					MySQL_LoadPlayerVeh(extraid);
				}
   				if(PlayerInfo[extraid][GangID] != 0)
				{
				    MySQL_LoadPlayerGang(extraid);
				}
				
  			 	_SetPlayerScore(extraid, PlayerInfo[extraid][Score]);
			 	SetPlayerCash(extraid, PlayerInfo[extraid][Money]);
			 	PlayerInfo[extraid][ConnectTime] = gettime();
   			 	PlayerInfo[extraid][tPayDay] = SetTimerEx("payday", 60000, true, "i", extraid);

				SendWelcomeMSG(extraid);

                new string[128];
				if(PlayerInfo[extraid][Level] > 0)
				{
					format(string, sizeof(string), ""server_sign" Successfully logged in. (Adminlevel %i)", PlayerInfo[extraid][Level]);
					SCM(extraid, -1, string);
					format(string, sizeof(string), ""server_sign" You were last online at %s and registered on %s", UnixTimeToDate(PlayerInfo[extraid][LastLogged]), UnixTimeToDate(PlayerInfo[extraid][RegDate]));
  					SCM(extraid, -1, string);
					format(string, sizeof(string), ""server_sign" You've been online for %s", GetPlayingTimeFormat(extraid));
					SCM(extraid, -1, string);
		   		}
		   		else
		   		{
				   	SCM(extraid, -1, ""server_sign" Successfully logged in!");
					format(string, sizeof(string), ""server_sign" You were last online at %s and registered on %s", UnixTimeToDate(PlayerInfo[extraid][LastLogged]), UnixTimeToDate(PlayerInfo[extraid][RegDate]));
  					SCM(extraid, -1, string);
					format(string, sizeof(string), ""server_sign" You've been online for %s", GetPlayingTimeFormat(extraid));
					SCM(extraid, -1, string);
				}
				
				if(PlayerInfo[extraid][VIP] == 1)
				{
                    format(string, sizeof(string), ""server_sign" VIP %s(%i) logged in!", __GetName(extraid), extraid);
                    SCMToAll(-1, string);
				}
			}
		}
		case THREAD_LOAD_PLAYER_GANG:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);

		    if(rows > 0)
		    {
		        new buffer[25], string[64];

		        cache_get_row(0, 0, buffer, g_SQL_handle, sizeof(buffer));
		        strmid(PlayerInfo[extraid][GangName], buffer, 0, 25, 25);
				cache_get_row(0, 1, buffer, g_SQL_handle, sizeof(buffer));
				strmid(PlayerInfo[extraid][GangTag], buffer, 0, 5, 5);

				if(PlayerInfo[extraid][GangLabel] != Text3D:-1)
				{
				    DestroyDynamic3DTextLabel(PlayerInfo[extraid][GangLabel]);
		 			PlayerInfo[extraid][GangLabel] = Text3D:-1;
				}
				
 			    format(string, sizeof(string), ""ngs_blue"Gang:"white" %s", PlayerInfo[extraid][GangName]);
				PlayerInfo[extraid][GangLabel] = CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, extraid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
			}
		}
		case THREAD_ASSIGN_RANK:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);

	  		if(rows > 0)
		    {
				rows = cache_get_row_int(0, 0, g_SQL_handle);
				
				if(PlayerInfo[extraid][GangPosition] == GANG_POS_LEADER || PlayerInfo[extraid][GangPosition] == GANG_POS_MAIN_LEADER)
				{
					if(PlayerInfo[extraid][GangPosition] == GANG_POS_LEADER && rows == GANG_POS_LEADER)
					{
					    return SCM(extraid, -1, ""er"Cannot assign!");
					}

			        if(PlayerInfo[extraid][GangPosition] == GANG_POS_LEADER && rows == GANG_POS_MAIN_LEADER)
			        {
			            return SCM(extraid, -1, ""er"You can't set the main leader's rank!");
			        }

					if(rows == PlayerInfo[extraid][RankSelected])
					{
					    return SCM(extraid, -1, ""er"Player is already this rank!");
					}

					MySQL_FinalRankAssign(extraid);
				}
				else
				{
				     return SCM(extraid, -1, ""er"You don't have permission!");
				}
			}
			else
			{
				SCM(extraid, -1, ""er"This player is not in your gang!");
			}
		}
		case THREAD_ASSIGN_RANK_2:
		{
  			new string[128];

		    format(string, sizeof(string), ""gang_sign" %s´s Rank has been assigned to %s", PlayerInfo[extraid][GangAssignRank], GangPositions[PlayerInfo[extraid][RankSelected]][E_gang_pos_name]);
			GangMSG(PlayerInfo[extraid][GangID], string);

			PlayerInfo[extraid][RankSelected] = 0;
			PlayerInfo[extraid][GangAssignRank][0] = '\0';
		}
		case THREAD_KICK_FROM_GANG:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);

	  		if(rows > 0)
		    {
				if(cache_get_row_int(0, 0, g_SQL_handle) == GANG_POS_MAIN_LEADER)
				{
				    SCM(extraid, -1, ""er"You cannot kick other the main leader!");
				}
				else
		        {
					MySQL_FinalGangKick(extraid);
				}
			}
			else
			{
				SCM(extraid, -1, ""er"This player is not in your gang!");
				PlayerInfo[extraid][GangKickMem][0] = '\0';
			}
		}
		case THREAD_KICK_FROM_GANG_2:
		{
		    new string[128];

		    format(string, sizeof(string), ""gang_sign" %s kicked %s out of the gang", __GetName(extraid), PlayerInfo[extraid][GangKickMem]);
			GangMSG(PlayerInfo[extraid][GangID], string);

            PlayerInfo[extraid][GangKickMem][0] = '\0';
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
		    	SCM(extraid, -1, ""er"Login failed! Incorrect password");
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
		    PlayerInfo[extraid][RegDate] = gettime();
			PlayerInfo[extraid][ExitType] = 2;
			PlayerInfo[extraid][PayDay] = 60;
			PlayerInfo[extraid][tPayDay] = SetTimerEx("payday", 60000, true, "i", extraid);
			PlayerInfo[extraid][ConnectTime] = gettime();
		    PlayerInfo[extraid][AllowSpawn] = true;
		    
		    TogglePlayerSpectating(extraid, false);
		    SendWelcomeMSG(extraid);
		    GameTextForPlayer(extraid, "Welcome", 3000, 4);
		    MySQL_CreatePlayerToy(extraid);
	  		GivePlayerCash(extraid, 5000);
	    	GameTextForPlayer(extraid, "~n~+$5,000~n~Startcash", 3000, 1);
			SCM(extraid, -1, ""server_sign" You are now registered, and have been logged in!");
			InterpolateCameraPos(extraid, 352.937377, -1813.479492, 39.280658, 390.257812, -1808.886718, 18.014354, 800, CAMERA_MOVE);
			InterpolateCameraLookAt(extraid, 351.274230, -1816.356323, 37.054042, 386.991821, -1811.187500, 17.814441, 800, CAMERA_MOVE);
			PlayerPlaySound(extraid, 1057, 0.0, 0.0, 0.0);
			MySQL_SavePlayer(extraid);
			MySQL_LogPlayerIn(extraid);
		}
		case THREAD_LOAD_PLAYER_VEH:
		{
		    new rows, fields;
		    cache_get_data(rows, fields, g_SQL_handle);
		    
		    if(rows > 0)
		    {
		        PlayerInfoVeh[extraid][Model] = cache_get_row_int(0, 2, g_SQL_handle);
		        PlayerInfoVeh[extraid][Price] = cache_get_row_int(0, 3, g_SQL_handle);
          		PlayerInfoVeh[extraid][PaintJob] = cache_get_row_int(0, 4, g_SQL_handle);
                PlayerInfoVeh[extraid][Color1] = cache_get_row_int(0, 5, g_SQL_handle);
                PlayerInfoVeh[extraid][Color2] = cache_get_row_int(0, 6, g_SQL_handle);
                new plate[13];
                cache_get_row(0, 7, plate, g_SQL_handle, sizeof(plate));
                strmid(PlayerInfoVeh[extraid][Plate], plate, 0, 13, 13);
                PlayerInfoVeh[extraid][Mod1] = cache_get_row_int(0, 8, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod2] = cache_get_row_int(0, 9, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod3] = cache_get_row_int(0, 10, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod4] = cache_get_row_int(0, 11, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod5] = cache_get_row_int(0, 12, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod6] = cache_get_row_int(0, 13, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod7] = cache_get_row_int(0, 14, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod8] = cache_get_row_int(0, 15, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod9] = cache_get_row_int(0, 16, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod10] = cache_get_row_int(0, 17, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod11] = cache_get_row_int(0, 18, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod12] = cache_get_row_int(0, 19, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod13] = cache_get_row_int(0, 20, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod14] = cache_get_row_int(0, 21, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod15] = cache_get_row_int(0, 22, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod16] = cache_get_row_int(0, 23, g_SQL_handle);
                PlayerInfoVeh[extraid][Mod17] = cache_get_row_int(0, 24, g_SQL_handle);
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
			    SCM(extraid, -1, ""er"This Gang already exist, please choose another gangname");
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
					format(string, sizeof(string), ""ngs_blue"%i. "green"%s "ngs_blue"- "white"%02i:%02i.%03i", i + 1, name, minute, sec, msec);
					SCM(extraid, -1, string);
				}
		    }
		    else
		    {
		        SCM(extraid, -1, ""vgreen"» No race records available");
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
						SCMToAll(-1, str);

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
							SCMToAll(-1, str);
						}
						break;
		 	        }
		 	        else
				 	{
				 	    format(str, sizeof(str), ""race_sign" %s reached on %s place %i with %02i:%02i.%03i", name, RaceName, order, minute, sec, msec);
						SCMToAll(-1, str);

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
							SCMToAll(-1, str);
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
		if(gTeam[i] == SPEC && PlayerInfo[i][SpecID] == playerid)
   		{
   		    SetPlayerInterior(i, newinteriorid);
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
    new pip[16],
		bool:found = false,
		string[144];
		
	if(!success)
 	{
  		printf("[RCON] FAILED LOGIN BY IP %s USING PASSWORD %s", ip, password);

		for(new i = 0; i < MAX_PLAYERS; i++)
    	{
     		GetPlayerIp(i, pip, sizeof(pip));
       		if(!strcmp(ip, pip, true))
         	{
				format(string, sizeof(string), ""yellow"*** "red"%s(%i) tried to login to local RCON with password %s IP: %s", __GetName(i), i, password, ip);
				AdminMSG(RED, string);
				found = true;
				break;
			}
   		}
   		if(!found)
   		{
			format(string, sizeof(string), ""yellow"*** "red"IP %s tried to login to remote RCON with password %s", ip, password);
			AdminMSG(RED, string);
   		}
   	}
   	else
   	{
  		printf("[RCON] LOGIN BY IP %s", ip);

		for(new i = 0; i < MAX_PLAYERS; i++)
    	{
     		GetPlayerIp(i, pip, sizeof(pip));
       		if(!strcmp(ip, pip, true))
         	{
				format(string, sizeof(string), ""yellow"*** "red"IP %s logged in to local RCON", ip);
				AdminMSG(RED, string);
				found = true;
				break;
			}
   		}
   		if(!found)
   		{
			format(string, sizeof(string), ""yellow"*** "red"IP %s logged in to remote RCON with password %s", ip, password);
			AdminMSG(RED, string);
   		}
	}
    return 1;
}

public OnPlayerUpdate(playerid)
{
    PlayerInfo[playerid][tickPlayerUpdate] = GetTickCount() + 3600000;

	if(gTeam[playerid] == GUNGAME)
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
            return 0;
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
    SetPVarInt(playerid, "OnBike", 0);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(!PlayerInfo[playerid][Logged])
	{
	    SCM(playerid, -1, ""er"You need to spawn to use the chat!");
	    return 0;
	}

	if(PlayerInfo[playerid][Muted])
	{
	    SCM(playerid, RED, "You are muted! Please wait until the time is over!");
	    return 0;
	}

	if(GlobalMain)
	{
	    SCM(playerid, -1, ""er"Please log out now!");
	    return 0;
	}

	if(!strcmp(text, LastPlayerText[playerid], true))
	{
	    GameTextForPlayer(playerid, "~g~Do not repeat yourself!", 2000, 5);
	    return 0;
	}
	strmid(LastPlayerText[playerid], text, 0, 144, 144);

	if(strfind(text, "/q", true) != -1)
	{
		SCM(playerid, -1, ""er"Please do not type /q in chat!");
  		return 0;
  	}

    new File:lFile = fopen("Logs/chatlog.txt", io_append),
     	logData[255],
        time[3];

    gettime(time[0], time[1], time[2]);

    format(logData, sizeof(logData), "[%02d:%02d:%02d] (%i)%s: %s \r\n", time[0], time[1], time[2], playerid, __GetName(playerid), text);
    fwrite(lFile, logData);
    fclose(lFile);

	new is1 = 0,
		r = 0,
		strR[255];

 	while(strlen(text[is1]))
 	{
  		if('0' <= text[is1] <= '9')
  		{
 			new is2 = is1 + 1,
			 	p = 0;

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

        SCM(playerid, RED, "Advertising is not allowed!");
        return 0;
	}

	if(xTestBusy)
	{
		if(!strcmp(xChars, text, false) && ReactionOn)
		{
            ReactionOn = false;

		    new string[144],
		        rtime = (GetTickCount() + 3600000) - tickReactionStart,
		        second = rtime / 1000;

			rtime = rtime - second * 1000;

			format(string, sizeof(string), "["vlila"REACTION"white"]: {%06x}%s(%i) "white"has won the reaction test in %2i.%03i seconds!", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, second, rtime);
		    SCMToAll(WHITE, string);

		    format(string, sizeof(string), "» You have earned $%s + %i score.", ToCurrency(xCash), xScore);
		    SCM(playerid, GREEN, string);

			format(string, sizeof(string), "Won the Reaction Test in %2i.%03i seconds!", second, rtime);
			SetPlayerChatBubble(playerid, string, NGS_BLUE, 40.0, 5000);

			GivePlayerCash(playerid, xCash);

		    PlayerInfo[playerid][Reaction]++;
		    
		    if(pAch[playerid][E_ach_toofast] == 0 && PlayerInfo[playerid][Reaction] >= 10)
		    {
		        GivePlayerAchievement(playerid, "Too Fast", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
		        pAch[playerid][E_ach_toofast] = 1;
		    }
		    
			_GivePlayerScore(playerid, xScore);
			tReactionTimer = SetTimer("xReactionTest", REAC_TIME, true);
		    xTestBusy = false;
		    return 0;
		}
		else if(text[0] == '7')
		{
			SCM(playerid, NGS_GREEN, "Whoops... type it again...");
	  		return 0;
		}
	}

	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][onduty] && text[0] == '#')
	{
	    new msgstring[144];
	    format(msgstring, sizeof(msgstring), ""white"["red"ADMIN CHAT"white"] %s(%i): "LB2_E"%s", __GetName(playerid), playerid, text[1]);
		AdminMSG(-1, msgstring);
	    return 0;
	}
	if(text[0] == '#' && PlayerInfo[playerid][Level] >= 1)
	{
	    new msgstring[144];
		format(msgstring, sizeof(msgstring), ""white"["red"ADMIN CHAT"white"] %s(%i): "LB2_E"%s", __GetName(playerid), playerid, text[1]);
		AdminMSG(-1, msgstring);
		return 0;
	}
	if(text[0] == '@')
	{
	    cmd_r(playerid, text[1]);
		return 0;
	}

    new tick = GetTickCount() + 3600000;

	if((PlayerInfo[playerid][ChatWrote] >= 2) && ((PlayerInfo[playerid][tickLastChat] + COOLDOWN_CHAT) >= tick))
	{
		SCM(playerid, -1, ""er"Wait a bit before chatting again");
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
		SCM(playerid, NGS_GREEN, "Whoops... type it again...");
  		return 0;
	}

	if(text[0] == '!' && PlayerInfo[playerid][GangPosition] != 0)
	{
	    new gstring[144];
	    format(gstring, sizeof(gstring), ""white"["ngs_blue"GANG CHAT"white"] {%06x}%s"white"(%i)"white": %s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, text[1]);
		GangMSG(PlayerInfo[playerid][GangID], gstring);
		return 0;
	}

	if(!PlayerInfo[playerid][bCaps])
	{
	    UpperToLower(text);
	}

	new string[144];

	if(PlayerInfo[playerid][GangPosition] != 0)
	{
		format(string, sizeof(string), "%s", text);
		SetPlayerChatBubble(playerid, string, WHITE, 50.0, 7000);

	 	if(strlen(text) > 80)
		{
			new pos = strfind(text, " ", true, 60);
			if(pos == -1 || pos > 80)
			{
				pos = 70;
			}

	        new tmp[144];
			tmp[0] = EOS;
			if(PlayerInfo[playerid][Level] != 0) strcat(tmp, "{A8DBFF}");
			strcat(tmp, text[pos]);
			text[pos] = EOS;

			if(PlayerInfo[playerid][Level] == 0)
			{
				format(string, sizeof(string), "{%06x}[%s] %s"white"(%i): %s", GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][GangTag], __GetName(playerid), playerid, text);
				SCMToAll(-1, string);
				SCMToAll(-1, tmp);
	   		}
			else
			{
				format(string, sizeof(string), "{%06x}[%s] %s"white"(%i): {A8DBFF}%s", GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][GangTag], __GetName(playerid), playerid, text);
				SCMToAll(-1, string);
				SCMToAll(-1, tmp);
			}
		}
		else
		{
			if(PlayerInfo[playerid][Level] == 0)
			{
				format(string, sizeof(string), "{%06x}[%s] %s"white"(%i): %s", GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][GangTag], __GetName(playerid), playerid, text);
				SCMToAll(-1, string);
	   		}
			else
			{
				format(string, sizeof(string), "{%06x}[%s] %s"white"(%i): {A8DBFF}%s", GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][GangTag], __GetName(playerid), playerid, text);
				SCMToAll(-1, string);
			}
		}
		return 0;
	}


	format(string, sizeof(string), "%s", text);
	SetPlayerChatBubble(playerid, string, WHITE, 50.0, 7000);

	if(strlen(text) > 80)
	{
		new pos = strfind(text, " ", true, 60);
		if(pos == -1 || pos > 80)
		{
			pos = 70;
		}

        new tmp[144];
		tmp[0] = EOS;
		if(PlayerInfo[playerid][Level] != 0) strcat(tmp, "{A8DBFF}");
		strcat(tmp, text[pos]);
		text[pos] = EOS;
		if(PlayerInfo[playerid][Level] == 0)
		{
			format(string, sizeof(string), "{%06x}%s"white"(%i): %s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, text);
			SCMToAll(-1, string);
			SCMToAll(-1, tmp);
		}
		else
		{
			format(string, sizeof(string), "{%06x}%s"white"(%i): {A8DBFF}%s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, text);
			SCMToAll(-1, string);
			SCMToAll(-1, tmp);
		}
	}
	else
	{
		if(PlayerInfo[playerid][Level] == 0)
		{
	 		format(string, sizeof(string), "{%06x}%s"white"(%i): %s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, text);
			SCMToAll(-1, string);
  		}
		else
		{
 	 		format(string, sizeof(string), "{%06x}%s"white"(%i): {A8DBFF}%s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, text);
			SCMToAll(-1, string);
		}
	}
	return 0;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	// Closing open dialogs in order to avoid some exploits.
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	
	PlayerInfo[playerid][IsDead] = true;
	PlayerInfo[playerid][iCoolDownDeath]++;
	SetTimerEx("CoolDownDeath", COOLDOWN_DEATH, false, "i", playerid);
	if(PlayerInfo[playerid][iCoolDownDeath] >= 3)
	{
		return Kick(playerid);
	}

    SendDeathMessage(killerid, playerid, reason);
	PlayerInfo[playerid][Deaths]++;
	if(BuildRace == playerid + 1)
	{
		BuildRace = 0;
	}

	if(reason <= 46 && gTeam[killerid] == NORMAL && IsPlayerConnected(killerid) && PlayerInfo[playerid][HitmanHit] > 0)
	{
		new string[128];
		format(string, sizeof(string), "%s(%i) killed %s(%i) and received $%s for a completed hit!", __GetName(killerid), killerid, __GetName(playerid), playerid, ToCurrency(PlayerInfo[playerid][HitmanHit]));
		SCMToAll(YELLOW, string);
		GivePlayerCash(killerid, PlayerInfo[playerid][HitmanHit]);
		PlayerInfo[playerid][HitmanHit] = 0;
	}

	if(IsPlayerAvail(killerid))
	{
		PlayerInfo[killerid][Kills]++;
 		GivePlayerCash(playerid, -500);
		GameTextForPlayer(playerid, "~r~-$500", 2000, 1);
		new txt[64];
		format(txt, sizeof(txt), "Killed by~n~~r~%s(%i)", __GetName(killerid), killerid);
		PlayerTextDrawSetString(playerid, TXTKillerText[playerid], txt);
		PlayerTextDrawShow(playerid, TXTKillerText[playerid]);
		
		if(pAch[killerid][E_ach_grimreaper] == 0 && PlayerInfo[killerid][Kills] >= 150)
		{
		    GivePlayerAchievement(killerid, "Grimreaper", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
		    pAch[killerid][E_ach_grimreaper] = 1;
		}
		
	 	if(reason == 4 && pAch[killerid][E_ach_silentkiller] == 0)
		{
		    GivePlayerAchievement(killerid, "Silent Killer", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
	 		pAch[killerid][E_ach_silentkiller] = 1;
		}
	}

	if(PlayerInfo[playerid][Deaths] >= 50 && pAch[playerid][E_ach_restinpeace] == 0)
	{
	    GivePlayerAchievement(playerid, "Rest in Peace", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
	    pAch[playerid][E_ach_restinpeace] = 1;
	}

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
 		if(gTeam[i] == SPEC && PlayerInfo[i][SpecID] == playerid)
	    {
     		cmd_specoff(playerid, "");
       		SendInfo(i, "~r~~h~Player died!", 4000);
		}
	}
	
	SetPVarInt(playerid, "doingStunt", 0);
	
	TextDrawShowForPlayer(playerid, TXTBlackScreenP1);
	TextDrawShowForPlayer(playerid, TXTBlackScreenP2);
	PlayerTextDrawHide(playerid, TXTPlayerFooter[playerid]);
	TextDrawHideForPlayer(playerid, FooterBlack);
	TextDrawHideForPlayer(playerid, NGSLOGO[0]);
    TextDrawHideForPlayer(playerid, NGSLOGO[1]);
    TextDrawHideForPlayer(playerid, NGSLOGO[2]);
    TextDrawHideForPlayer(playerid, godTD);

	switch(random(7))
	{
		case 0: GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~b~C~h~L~h~U~h~C~w~K ~b~C~h~L~h~U~h~C~w~K, ~r~Y~h~O~r~U~h~'R~h~E ~r~FU~h~C~r~K~h~E~r~D", 6000, 3);
		case 1: GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~r~I~h~C~h~E~h~D", 6000, 3);
		case 2: GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~r~RE~h~ST ~h~IN ~h~PEA~h~CE", 6000, 3);
		case 3: GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~r~T~h~A~h~S~h~T~h~E ~r~T~h~H~h~E ~r~CO~h~CK", 6000, 3);
		case 4: GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~r~N~h~O ~h~C~h~A~h~K~h~E ~y~F~h~O~h~R ~h~Y~h~O~h~U", 6000, 3);
		case 5: GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~b~C~h~L~h~U~h~C~w~KITY FU~b~~h~~h~~h~C~b~~h~~h~K~b~~h~E~b~D", 6000, 3);
		case 6: GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~b~L~h~O~h~L ~w~U ~b~~h~~h~~h~D~b~~h~I~h~E~b~~h~D", 6000, 3);
	}

	switch(gTeam[playerid])
	{
	    case NORMAL:
	    {
	        if(IsPlayerAvail(killerid) && (playerid != killerid) && gTeam[killerid] == NORMAL)
     		{
			    PlayerInfo[killerid][Wanteds]++;

            	new wstring[255];

				switch(PlayerInfo[killerid][Wanteds])
				{
				    case 3:
				    {
				        SendInfo(killerid, "~r~~h~Triple Kill~n~~b~~h~$1,000 and 1 score Bonus!", 4000);
        				format(wstring, sizeof(wstring), "* {%06x}%s(%i) "RED_E"is on a kill streak with 3 kills!", GetPlayerColor(killerid) >>> 8, __GetName(killerid), killerid);
						SCMToAll(COLOR_RED, wstring);
						_GivePlayerScore(killerid, 1);
						GivePlayerCash(killerid, 1000);
				    }
				    case 5:
					{
					    SendInfo(killerid, "~r~~h~MULTI Kill~n~~b~~h~$2,000 and 2 score!", 4000);
        				format(wstring, sizeof(wstring), "* {%06x}%s(%i) "RED_E"is on a kill streak with 5 kills!", GetPlayerColor(killerid) >>> 8, __GetName(killerid), killerid);
						SCMToAll(COLOR_RED, wstring);
						_GivePlayerScore(killerid, 2);
						GivePlayerCash(killerid, 2000);
					}
					case 10:
  					{
					    SendInfo(killerid, "~r~~h~ULTRA Kill~n~~b~~h~$3,000 and 3 score!", 4000);
     					format(wstring, sizeof(wstring), "* {%06x}%s(%i) "RED_E"is unstoppable with a 10 streak kill!", GetPlayerColor(killerid) >>> 8, __GetName(killerid), killerid);
						SCMToAll(COLOR_RED, wstring);
						_GivePlayerScore(killerid, 3);
						GivePlayerCash(killerid, 3000);
					}
					case 15:
  					{
					    SendInfo(killerid, "~r~~h~MONSTER Kill~n~~b~~h~$4,000 and 4 score!", 4000);
   						format(wstring, sizeof(wstring), "* {%06x}%s(%i) "RED_E"can't be stopped with a 15 streak kill!", GetPlayerColor(killerid) >>> 8, __GetName(killerid), killerid);
						SCMToAll(COLOR_RED, wstring);
						_GivePlayerScore(killerid, 4);
						GivePlayerCash(killerid, 4000);
					}
					case 25:
  					{
					    SendInfo(killerid, "~r~~h~Incredible Kill~n~~b~~h~$5,000 and 5 score!", 4000);
          				format(wstring, sizeof(wstring), "* {%06x}%s(%i) "RED_E"can't be stopped with a 25 streak kill!", GetPlayerColor(killerid) >>> 8, __GetName(killerid), killerid);
						SCMToAll(COLOR_RED, wstring);
						_GivePlayerScore(killerid, 5);
						GivePlayerCash(killerid, 5000);
						if(pAch[killerid][E_ach_masskiller] == 0)
						{
						    GivePlayerAchievement(killerid, "Masskiller", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
						    pAch[killerid][E_ach_masskiller] = 1;
						}
					}
					case 30:
  					{
					    SendInfo(killerid, "~r~~h~Unbelievable~n~~b~~h~$6,000 and 6 score!", 4000);
          				format(wstring, sizeof(wstring), "* {%06x}%s(%i) "RED_E"can't be stopped with a 30 streak kill!", GetPlayerColor(killerid) >>> 8, __GetName(killerid), killerid);
						SCMToAll(COLOR_RED, wstring);
						_GivePlayerScore(killerid, 6);
						GivePlayerCash(killerid, 6000);
					}
					case 40:
  					{
   						SendInfo(killerid, "~r~~h~MEGA Kill~n~~b~~h~$7,000 and 7 score!", 4000);
          				format(wstring, sizeof(wstring), "* {%06x}%s(%i) "RED_E"is godlike with a 40 streak kill!", GetPlayerColor(killerid) >>> 8, __GetName(killerid), killerid);
						SCMToAll(COLOR_RED, wstring);
						_GivePlayerScore(killerid, 7);
						GivePlayerCash(killerid, 7000);
					}
					case 50:
  					{
					    SendInfo(killerid, "~r~~h~Fantastic Kill~n~~b~~h~$8,000 and 8 score!", 4000);
                 		format(wstring, sizeof(wstring), "* {%06x}%s(%i) "RED_E"shitting on everyone with a 50 streak kill!", GetPlayerColor(killerid) >>> 8, __GetName(killerid), killerid);
						SCMToAll(COLOR_RED, wstring);
						_GivePlayerScore(killerid, 8);
						GivePlayerCash(killerid, 8000);
					}
				}

				if(PlayerInfo[playerid][Wanteds] > 2)
				{
					new money,
						score,
						string[32];

					money = floatround((1500 * PlayerInfo[playerid][Wanteds]) / 2.6);
					score = floatround((2 * PlayerInfo[playerid][Wanteds]) / 2.6);

					_GivePlayerScore(killerid, score);
					GivePlayerCash(killerid, money);

					format(string, sizeof(string), "+1 Kill~n~+%i Score~n~+$%s", score, ToCurrency(money));
					GameTextForPlayer(killerid, string, 2000, 1);
				}
				else
				{
					_GivePlayerScore(killerid, 1);
					GivePlayerCash(killerid, 1100);
					GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,100", 2000, 1);
				}

				PlayerInfo[playerid][Wanteds] = 0;
				
			  	// Nur Kills bei NORMAL werten für GangScore
			 	if(PlayerInfo[killerid][GangPosition] > 0)
				{
				  	MySQL_UpdateGangScore(PlayerInfo[killerid][GangID], 1);
			 	}
	        }
	    }
		case DERBY:
		{
		    // OPDeath
		    if(bDerbyAFK[playerid])
			{
		        return 1;
		    }

		    if(IsDerbyRunning && DerbyWinner[playerid])
		    {
			    new string[64];

		    	format(string, sizeof(string), "%s's vehicle has been destroyed!", __GetName(playerid));
				DerbyMSG(string);

		    	DerbyPlayers--;
		    	DerbyWinner[playerid] = false;
			    if(pDerbyCar[playerid] != -1)
			    {
			    	DestroyVehicle(pDerbyCar[playerid]);
			    	pDerbyCar[playerid] = -1;
				}
			    if(DerbyVehLabel[playerid] != PlayerText3D:-1)
			    {
			    	DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);
			    	DerbyVehLabel[playerid] = PlayerText3D:-1;
			    }
                SetPlayerDerbyStaticMeshes(playerid);

		    	if(DerbyPlayers == 1) Derby();
			}
			else
			{
				cmd_exit(playerid, "");
			}
		}
		case RACE:
		{
		    new string[50];

	    	format(string, sizeof(string), "%s has died!", __GetName(playerid));
			RaceMSG(string);

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
		case FALLOUT:
		{
			new string[50];

			format(string, sizeof(string), "%s died!", __GetName(playerid));
			FalloutMSG(string);

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
					    FalloutMSG("Fallout has been canceled!");
						gTeam[i] = NORMAL;
				    }
				}
				Fallout_Cancel();
			}
	  	}
		case MINIGUN:
		{
		    if(IsPlayerAvail(killerid))
		    {
				_GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1000);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,000", 2000, 1);
		    }
		}
		case SNIPER:
		{
		    if(IsPlayerAvail(killerid))
		    {
				_GivePlayerScore(killerid, 2);
				GivePlayerCash(killerid, 1500);
				GameTextForPlayer(killerid, "+1 Kill~n~+2 Score~n~+$1,500", 2000, 1);
		    }
		}
		case gBG_TEAM1:
		{
  		    if(IsPlayerAvail(killerid))
		    {
		        BGTeam2Kills++;
		        _GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1500);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,500", 2000, 1);
		    }
		}
		case gBG_TEAM2:
		{
  		    if(IsPlayerAvail(killerid))
		    {
		        BGTeam1Kills++;
		        _GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1500);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,500", 2000, 1);
		    }
		}
		case DM, WAR:
		{
  		    if(IsPlayerAvail(killerid))
		    {
		        _GivePlayerScore(killerid, 1);
				GivePlayerCash(killerid, 1500);
				GameTextForPlayer(killerid, "+1 Kill~n~+1 Score~n~+$1,500", 2000, 1);
		    }
		    SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
		}
		case GUNGAME:
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
					new	c,
						g_WinnerName[3][MAX_PLAYER_NAME],
						g_Data[MAX_PLAYERS][e_GunGame];

					for(new i = 0; i < MAX_PLAYERS; i++)
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
					for(new i = 0; i < 3; i++)
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

                       	if(pAch[gWinners[0]][E_ach_oneshot2kills] == 0 && PlayerInfo[gWinners[0]][GungameWins] >= 10)
						{
						    GivePlayerAchievement(gWinners[0], "One Shot Two Kills", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
						    pAch[gWinners[0]][E_ach_oneshot2kills] = 1;
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

					for(new i = 0; i < MAX_PLAYERS; i++)
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
						new string[64];
						format(string, sizeof string, "%s reached the last level!", __GetName(killerid));
     				    for(new i = 0; i < MAX_PLAYERS; i++)
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
				rTime[3],
				Prize[2];

			rPosition++;
			TimeStamp = GetTickCount() + 3600000;
			TotalRaceTime = TimeStamp - RaceTick;
			ConvertTime(var, TotalRaceTime, rTime[0], rTime[1], rTime[2]);

			switch(rPosition)
			{
			    case 1:
				{
				    if(RaceSpawnCount == 1)
				    {
				        Prize[0] = random(2000);
						Prize[1] = 2;
						SCM(playerid, -1, ""se" No race win gained and less price money because you raced alone");
				    }
				    else
				    {
						Prize[0] = random(10000);
						Prize[1] = 10;
						PlayerInfo[playerid][RaceWins]++;
						
						if(pAch[playerid][E_ach_eliteracer] == 0 && PlayerInfo[playerid][RaceWins] >= 10)
						{
						    GivePlayerAchievement(playerid, "Elite Racer", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
						    pAch[playerid][E_ach_eliteracer] = 1;
						}
					}
				}
			    case 2:
				{
					Prize[0] = random(9000);
					Prize[1] = 9;
				}
				case 3:
				{
					Prize[0] = random(8000);
					Prize[1] = 8;
				}
				case 4:
				{
					Prize[0] = random(7000);
					Prize[1] = 7;
				}
				case 5:
				{
					Prize[0] = random(6000);
					Prize[1] = 6;
				}
			    case 6:
				{
					Prize[0] = random(5000);
					Prize[1] = 5;
				}
			    case 7:
				{
					Prize[0] = random(4000);
					Prize[1] = 4;
				}
			    case 8:
				{
					Prize[0] = random(3000);
					Prize[1] = 3;
				}
			    case 9:
				{
					Prize[0] = random(2000);
					Prize[1] = 2;
				}
			    default:
				{
					Prize[0] = random(250);
					Prize[1] = 1;
				}
			}
			
			format(string, sizeof(string), "» %s has finished the race %i. in %02i:%02i.%03i", __GetName(playerid), rPosition, rTime[0], rTime[1], rTime[2]);
			SCMToAll(YELLOW, string);
	    	GivePlayerCash(playerid, Prize[0]);
	    	format(string, sizeof(string), "+$%s~n~+%i Score", ToCurrency(Prize[0]), Prize[1]);
	    	_GivePlayerScore(playerid, Prize[1]);
	    	GameTextForPlayer(playerid, string, 3000, 1);

			if(RaceFinishCount <= 5 && TotalRaceTime >= 30000)
			{
			    // Wenn eh nicht unter den TOP 5,wird seine Zeit eh nicht relevant sein.
			    format(string, sizeof(string), "INSERT INTO `"#TABLE_RACE"` VALUES (NULL, '%s', '%s', %i);", RaceName, __GetName(playerid), TotalRaceTime);
			    mysql_function_query(g_SQL_handle, string, false, "OnQueryFinish", "siii", string, THREAD_RACE_FINISH, playerid, g_SQL_handle);
			}
			else if(TotalRaceTime < 30000) // Do not save cheaters time
			{
			  	format(string, sizeof(string), ""yellow"** "red"Suspect player completed race in %i milliseconds | Player: %s(%i) | Race", TotalRaceTime, __GetName(playerid), playerid);
				AdminMSG(RED, string);
				print(string);
			}

			RaceFinishCount++;
			GivePlayerCash(playerid, Prize[0]);
			_GivePlayerScore(playerid, Prize[1]);
			DisablePlayerRaceCheckpoint(playerid);
			CPProgess[playerid]++;
			
			if(RaceJoinCount == 1) // Wenn er alleine race fährt
			{
				StopRace();
			}
			else // Mehr als 1 im race
			{
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
	if(gTeam[playerid] == NORMAL)
	{
	    for(new i = 0; i < sizeof(pick_life); i++)
	    {
			if(pickupid == pick_life[i])
			{
			    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			    SendInfo(playerid, "~h~~y~Health refueled!", 2500);
				SetPlayerHealth(playerid, 100.0);
				return 1;
			}
	    }
		if(pickupid == pick_chainsaw && !PlayerInfo[playerid][bGod])
		{
		    PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			GivePlayerWeapon(playerid, 9, 1);
  		}
  		if(pickupid == VIPLpickup)
  		{
  		    if(PlayerInfo[playerid][VIP] == 1 || PlayerInfo[playerid][Level] > 0)
  		    {
	    		SetPlayerPosition(playerid, -3939.1855, 1308.7438, 3.4587, 86.1611, 3);
	  		    gTeam[playerid] = VIPL;
	  		    PlayerPlaySound(playerid, 1068, 0, 0, 0);
	  		    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
			}
			else
			{
			    SCM(playerid, -1, ""er"You need to be VIP or an invite. See /vip");
			}
  		}
	}
	else if(gTeam[playerid] == VIPL)
	{
		if(pickupid == VIPLpickup2)
		{
		    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
		    SetPlayerPosition(playerid, -2622.6589,1406.2648,7.1016,178.5571);
		    ResetPlayerWorld(playerid);
		    PlayerPlaySound(playerid, 1069, 0, 0, 0);
		    gTeam[playerid] = NORMAL;
		}
	}
	
	if(pickupid == AdminLC2)
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
		if(!PlayerInfo[playerid][bGod])
		{
	    	RandomWeapon(playerid);
		}
		gTeam[playerid] = NORMAL;
	}
	else if(pickupid == vehiclebuy)
	{
	    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
		if(PlayerInfo[playerid][BuyAbleVeh] == 1)
		{
			return SCM(playerid, -1, ""er"You already own a vehicle");
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
	    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
		new currentveh, Float:angle;
	  	currentveh = GetPlayerVehicleID(playerid);
	  	SetVehiclePos(currentveh, -3945.3562,963.2668,36.3281);
		GetVehicleZAngle(currentveh, angle);
		SetVehicleZAngle(currentveh, angle);
	}
	else if(pickupid == dm2pickup)
	{
	    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
		new currentveh, Float:angle;
	  	currentveh = GetPlayerVehicleID(playerid);
	  	SetVehiclePos(currentveh, -3951.6909,968.0073,65.6281);
		GetVehicleZAngle(currentveh, angle);
		SetVehicleZAngle(currentveh, angle);
	}

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
		        SetCameraBehindPlayer(playerid);
		        return 1;
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
		        SetCameraBehindPlayer(playerid);
		        return 1;
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
		        SetCameraBehindPlayer(playerid);
		        return 1;
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
		        SetCameraBehindPlayer(playerid);
		        return 1;
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
		        SetCameraBehindPlayer(playerid);
		        return 1;
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
		        SetCameraBehindPlayer(playerid);
		        return 1;
			}
		}

	    // aout
		for(new bo = 0; bo < MAX_BANKS; bo++)
		{
		    if(pickupid == BankPickOut[bo])
		    {
		        ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
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
		        ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
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
		        ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
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
			    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
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
		        ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
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
		        ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
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
    new Float:POS[3];
    
	for(new i; i < sizeof(Obj_FloorDoors); i++)
	{
		if(objectid == Obj_FloorDoors[i][0])
		{
		    GetObjectPos(Obj_FloorDoors[i][0], POS[0], POS[1], POS[2]);

		    if(POS[0] < X_DOOR_L_OPENED - 0.5)
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

	    GetObjectPos(Obj_Elevator, POS[0], POS[1], POS[2]);
        Label_Elevator = CreateDynamic3DTextLabel("Press '"vgreen"F"white"' to use elevator", -1, 1784.9822, -1302.0426, floatsub(POS[2], 0.9), 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 5.0);

	    ElevatorState = ELEVATOR_STATE_WAITING;
	    SetTimer("Elevator_TurnToIdle", ELEVATOR_WAIT_TIME, false);
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	new string[4];
	format(string, sizeof(string), "%i", clickedplayerid);
	cmd_stats(playerid, string);
	return 1;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
	if(listid == toyslist)
	{
	    if(response)
	    {
		    if(GetPlayerCash(playerid) < 25000)
		    {
				SCM(playerid, -1, ""er"Each toy coasts $25,000");
				return 1;
		    }
		    GivePlayerCash(playerid, -25000);
		    GameTextForPlayer(playerid, "~r~-$25,000", 2000, 1);

            PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model] = modelid;
			SetPlayerAttachedObject(playerid, PlayerInfo[playerid][toy_selected], PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_model], 1);

			MySQL_SavePlayerToys(playerid);

			EditAttachedObject(playerid, PlayerInfo[playerid][toy_selected]);
		    ShowPlayerToyTextdraws(playerid);
		    SCM(playerid, GREEN, "Successfully bought the toy for $25,000!");
		    
		    if(pAch[playerid][E_ach_styler] == 0)
		    {
		        GivePlayerAchievement(playerid, "Styler", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
		        pAch[playerid][E_ach_styler] = 1;
		    }
	    }
	}
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	if(gTeam[playerid] == NORMAL)
	{
    	SetVehicleHealth(vehicleid, 1000.0);
		RepairVehicle(vehicleid);
		return 1;
	}
	else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && gTeam[playerid] == DERBY)
	{
		new Float:HP,
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

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return 1;
	
	new str[255];
	switch(checkpointid)
	{
 		case 1: //BikeChallenge Prize
		{
			if(GetPVarInt(playerid, "doingStunt") == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	  		{
	  		    if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 522) return 1;
	  		    
     			new tick = GetTickCount() + 3600000;
				if((PlayerInfo[playerid][tickLastBIKEC] + COOLDOWN_BIKEC) >= tick)
				{
				    return GameTextForPlayer(playerid,"~r~~h~Please wait before doing this stunt again", 6000, 5);
				}
				
   				RemovePlayerFromVehicle(playerid);
				new Float:POS[3];
	   			GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				SetPlayerPos(playerid, POS[0], POS[1], floatadd(POS[2], 10.0));
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				
				GameTextForPlayer(playerid,"~r~~h~Congrats!~n~~w~You finished the bike challenge.", 6000, 5);
				PlayerPlaySound(playerid, 1149,0,0,0);
				format(str, sizeof(str), "["BLUE_E"SE"WHITE_E"] {%06x}%s(%i) "PINK_E"has successfully completed /bikec.", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid);
				SendClientMessageToAll(COLOR_WHITE, str);
				_GivePlayerScore(playerid, 6);
				GivePlayerCash(playerid, 7000);
				InfoTD_MSG(playerid, 5000, "~r~~h~Congratulations!~n~~w~You finished the bile challange~n~~r~~h~6 score and $7,000!");
				if(pAch[playerid][E_ach_biker] == 0)
				{
					pAch[playerid][E_ach_biker] = 1;
  					GivePlayerAchievement(playerid, "Biker", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
				}
				SetPVarInt(playerid, "doingStunt", 0);
				PlayerInfo[playerid][tickLastBIKEC] = tick;
	  		}
 		}
 		case 2: //Skydive Prize
		{
			if(GetPVarInt(playerid, "doingStunt") == 2)
	  		{
	  			if(GetPlayerWeapon(playerid) != 46)
	  			{
	  				SendClientMessage(playerid, COLOR_YELLOW, ">> "RED_E"Challenge failed, you must have a parachute to complete this challenge.");
	  				return 1;
	  			}
				GameTextForPlayer(playerid, "~r~~h~Congrats!~n~~w~You finished the skydive challenge.",6000,5);
				PlayerPlaySound(playerid, 1149,0,0,0);
				format(str, sizeof(str), "["BLUE_E"SE"WHITE_E"] {%06x}%s(%i) "PINK_E"has successfully completed /skydive.", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid);
				SendClientMessageToAll(COLOR_WHITE, str);
				_GivePlayerScore(playerid, 8);
				GivePlayerCash(playerid, 8000);
		  		ResetPlayerWeapons(playerid);
		  		SetPVarInt(playerid, "doingStunt", 0);
				InfoTD_MSG(playerid, 5000, "~r~~h~Congratulations!~n~~w~You finished the first skydive challange~n~~r~~h~8 score and $8,000!");
				SetPVarInt(playerid, "CompletedSD1", 1);
				if(GetPVarInt(playerid, "CompletedSD1") == 1 && GetPVarInt(playerid, "CompletedSD2") == 1)
				{
					if(pAch[playerid][E_ach_skydiver] == 0)
					{
						pAch[playerid][E_ach_skydiver] = 1;
      					GivePlayerAchievement(playerid, "Skydiver", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
					}
				}
			}
	 	}
		case 3: //Skydive2 Prize
		{
			if(GetPVarInt(playerid, "doingStunt") == 2)
	  		{
	  			if(GetPlayerWeapon(playerid) != 46)
	  			{
	  				SendClientMessage(playerid, COLOR_YELLOW, ">> "RED_E"Challenge failed, you must have a parachute to complete this challenge.");
	  				return 1;
	  			}
				GameTextForPlayer(playerid,"~r~~h~Congrats!~n~~w~You finished the skydive2 challenge.",6000,5);
				PlayerPlaySound(playerid, 1149,0,0,0);
				format(str, sizeof(str), "["BLUE_E"SE"WHITE_E"] {%06x}%s(%i) "PINK_E"has successfully completed /skydive2.", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid);
				SendClientMessageToAll(COLOR_WHITE, str);
				_GivePlayerScore(playerid, 10);
				GivePlayerCash(playerid, 10000);
		  		ResetPlayerWeapons(playerid);
		  		SetPVarInt(playerid, "doingStunt", 0);
				InfoTD_MSG(playerid, 5000, "~r~~h~Congratulations!~n~~w~You finished the second skydive challange~n~~r~~h~10 score and $10,000!");
				SetPVarInt(playerid, "CompletedSD2", 1);
				if(GetPVarInt(playerid, "CompletedSD1") == 1 && GetPVarInt(playerid, "CompletedSD2") == 1)
				{
					if(pAch[playerid][E_ach_skydiver] == 0)
					{
						pAch[playerid][E_ach_skydiver] = 1;
      					GivePlayerAchievement(playerid, "Skydiver", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
					}
				}
			}
	 	}
		case 4: //Skydive3 Prize
		{
			if(GetPVarInt(playerid, "doingStunt") == 2)
	  		{
	  			if(GetPlayerWeapon(playerid) != 46)
	  			{
	  				SendClientMessage(playerid, COLOR_YELLOW, ">> "RED_E"Challenge failed, you must have a parachute to complete this challenge.");
	  				return 1;
	  			}
				GameTextForPlayer(playerid,"~r~~h~Congrats!~n~~w~You finished the skydive3 challenge.",6000,5);
				PlayerPlaySound(playerid, 1149,0,0,0);
				format(str, sizeof(str), "["BLUE_E"SE"WHITE_E"] {%06x}%s(%i) "PINK_E"has successfully completed /skydive3.", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid);
				SendClientMessageToAll(COLOR_WHITE, str);
				_GivePlayerScore(playerid, 10);
				GivePlayerCash(playerid, 15000);
		  		ResetPlayerWeapons(playerid);
		  		SetPVarInt(playerid, "doingStunt", 0);
				InfoTD_MSG(playerid, 5000, "~r~~h~Congratulations!~n~~w~You finished the first skydive challange~n~~r~~h~10 score and $15,000!");
			}
	 	}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid)
{

	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
 		if(gTeam[i] == SPEC && PlayerInfo[i][SpecID] == playerid)
	    {
			if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
			{
				PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
			}
			else if(newstate == PLAYER_STATE_ONFOOT)
			{
				PlayerSpectatePlayer(i, playerid);
			}
			else if(newstate == PLAYER_STATE_SPECTATING)
			{
			    cmd_specoff(i, "");
			    SendInfo(i, "~h~~y~Player started spectating someone else!", 4000);
			}
		}
	}
	
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    new vID = GetPlayerVehicleID(playerid),
 			string[144];

		if(PlayerInfo[playerid][vTDShown])
		{
		    KillTimer(PlayerInfo[playerid][tTDhandle]);
		}
		format(string, sizeof(string), "%s", GetVehicleNameById(vID));
		PlayerTextDrawSetString(playerid, vTD[playerid], string);
		PlayerTextDrawShow(playerid, vTD[playerid]);
		PlayerInfo[playerid][tTDhandle] = SetTimerEx("hidevTD", 3000, false, "i", playerid);
	}
	
    if(gTeam[playerid] == DERBY)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
		    if(DerbyVehLabel[playerid] != PlayerText3D:-1)
		    {
		    	DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);
		    	DerbyVehLabel[playerid] = PlayerText3D:-1;
		    }
			DerbyVehLabel[playerid] = CreatePlayer3DTextLabel(playerid, " ", -1, 0, 0, 0.9, 10.0, INVALID_PLAYER_ID, GetPlayerVehicleID(playerid), 1);
			UpdateBar(playerid);
		}
		else if(DerbyVehLabel[playerid] != PlayerText3D:-1)
	    {
	    	DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);
	    	DerbyVehLabel[playerid] = PlayerText3D:-1;
	    }
	}
	else if(gTeam[playerid] == NORMAL)
	{
	    if(GetPVarInt(playerid, "AntiFall") == 1 && GetPVarInt(playerid, "doingStunt") == 0)
	    {
	        switch(newstate)
	        {
	            case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER:
	            {
	                if(IsBikeModel(GetVehicleModel(GetPlayerVehicleID(playerid))))
	                {
		 				SetPVarInt(playerid, "OnBike", 1);
                        SetPVarInt(playerid, "lastVehicle", GetPlayerVehicleID(playerid));
	                }
	            }
	            case PLAYER_STATE_ONFOOT:
	            {
	                if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	                {
	                    if(GetPVarInt(playerid, "OnBike") == 1)
	                    {
	                        new olds = (oldstate == PLAYER_STATE_DRIVER ? (0): (1));
	                        PutPlayerInVehicle(playerid, GetPVarInt(playerid, "lastVehicle"), olds);
	                    }
	                }
	            }
	        }
		}
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
	    return ShowDialog(playerid, BANK_DIALOG);
	}

	if(GetPVarInt(playerid, "doingStunt") != 0) return 1;

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

			if(Key(KEY_FIRE) && GetPVarInt(playerid, "Ramped") == 1)
			{
			    if(!PlayerInfo[playerid][RampActive])
			    {
				    new vehIDr = GetPlayerVehicleID(playerid), Float:vPOS[4], Float:salttmp;
					GetVehiclePos(vehIDr, vPOS[0], vPOS[1], vPOS[2]);
					GetVehicleZAngle(vehIDr, vPOS[3]);
					salttmp = (floatpower(GetPlayerPing(playerid), 0.25) * 6.0 + 5.0);
					vPOS[0] += (floatsin(-vPOS[3], degrees) * salttmp);
					vPOS[1] += (floatcos(-vPOS[3], degrees) * salttmp);
					SetTimerEx("DestroyRampObject", 3000, false, "ii", CreateDynamicObject(1632, vPOS[0], vPOS[1], vPOS[2], 0, 0, vPOS[3]), playerid);
					PlayerInfo[playerid][RampActive] = true;
					/*
					    beste position für die rampe:
					    salttmp = (ping ^ 0.25) * 4 + 3
					    x = sin(-angle) * salttmp
					    y = cos(-angle) * salttmp
					*/
				}
			    return 1;
			}
			
		    if(PlayerInfo[playerid][SpeedBoost])
		    {
				if(Key(KEY_FIRE))
				{
					new Float:POS[3], vid = GetPlayerVehicleID(playerid);
					GetVehicleVelocity(vid, POS[0], POS[1], POS[2]);
					SetVehicleVelocity(vid, POS[0] * 1.3, POS[1] * 1.3, POS[2] * 1.3);
					AddVehicleComponent(vid, 1010);
					return 1;
		   		}

				if(Key(KEY_CROUCH))
				{
					new Float:POS[3], vid = GetPlayerVehicleID(playerid);
					GetVehicleVelocity(vid, POS[0], POS[1], POS[2]);
					SetVehicleVelocity(vid, POS[0], POS[1], floatadd(POS[2], 0.20));
					SetVehicleHealth(vid, 1000.0);
					return 1;
				}

				if(Key(KEY_YES) || Key(KEY_NO))
				{
					new Float:POS[3], vid = GetPlayerVehicleID(playerid);
					GetVehicleVelocity(vid, POS[0], POS[1], POS[2]);
					SetVehicleVelocity(vid, POS[0] > 0 ? POS[0] * 0.75 : 0.0, POS[1] > 0 ? POS[1] * 0.75 : 0.0, POS[2]);
					SetVehicleHealth(vid, 1000.0);
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
		new string[255],
	 		rNameFile[255],
	   		rFile[255],
	     	Float:vPos[4];

	    if(Key(KEY_FIRE))
	    {
		    if(BuildTakeVehPos)
		    {
		    	if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, RED, ">> You need to be in a vehicle");
				format(rFile, sizeof(rFile), "/Race/%s.race", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				GetVehicleZAngle(GetPlayerVehicleID(playerid), vPos[3]);
		        dini_Create(rFile);
				dini_IntSet(rFile, "vModel", BuildModeVID);
				dini_IntSet(rFile, "rType", BuildRaceType);
				dini_IntSet(rFile, "rVirtualworld", BuildVirtualWorld);
		        format(string, sizeof(string), "vPosX_%i", BuildVehPosCount);
				dini_FloatSet(rFile, string, vPos[0]);
		        format(string, sizeof(string), "vPosY_%i", BuildVehPosCount);
				dini_FloatSet(rFile, string, vPos[1]);
		        format(string, sizeof(string), "vPosZ_%i", BuildVehPosCount);
				dini_FloatSet(rFile, string, vPos[2]);
		        format(string, sizeof(string), "vAngle_%i", BuildVehPosCount);
				dini_FloatSet(rFile, string, vPos[3]);
		        format(string, sizeof(string), ">> Vehicle Pos '%i' has been taken.", BuildVehPosCount + 1);
		        SCM(playerid, YELLOW, string);
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
			    if(BuildCheckPointCount > MAX_RACE_CHECKPOINTS_EACH_RACE) return SCM(playerid, RED, ">> You reached the maximum amount of checkpoints!");
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, RED, ">> You need to be in a vehicle");
				format(rFile, sizeof(rFile), "/Race/%s.race", BuildName);
				GetVehiclePos(GetPlayerVehicleID(playerid), vPos[0], vPos[1], vPos[2]);
				format(string, sizeof(string), "CP_%i_PosX", BuildCheckPointCount);
				dini_FloatSet(rFile, string, vPos[0]);
				format(string, sizeof(string), "CP_%i_PosY", BuildCheckPointCount);
				dini_FloatSet(rFile, string, vPos[1]);
				format(string, sizeof(string), "CP_%i_PosZ", BuildCheckPointCount);
				dini_FloatSet(rFile, string, vPos[2]);
    			format(string, sizeof(string), ">> Checkpoint '%i' has been setted!", BuildCheckPointCount + 1);
		        SCM(playerid, YELLOW, string);
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

			    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, 1);
			    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_MAP_ICON, 1);
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

        SetPlayerAttachedObject(playerid,
			index,
			modelid,
			boneid,
			PlayerToys[playerid][index][toy_x],
			PlayerToys[playerid][index][toy_y],
			PlayerToys[playerid][index][toy_z],
			PlayerToys[playerid][index][toy_rx],
			PlayerToys[playerid][index][toy_ry],
			PlayerToys[playerid][index][toy_rz],
			PlayerToys[playerid][index][toy_sx],
			PlayerToys[playerid][index][toy_sy],
			PlayerToys[playerid][index][toy_sz]);
    }
    return 1;
}

// ===
// commands
// ===

COMMAND:lsb(playerid, params[])
{
	cmd_beach(playerid, "");
	return 1;
}
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
    PortPlayerMapVeh(playerid, 1542.5554, -1674.7850, 13.5547, 92.8351,1536.0787,-1671.4823,13.3828,178.0104, "Los Santos Police Department", "lspd");
    return 1;
}
COMMAND:lvpd(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2290.5759,2421.3708,10.8203,178.5880,2289.8555,2414.7170,10.8222,269.7221, "Las Venturas Police Department", "lvpd");
    return 1;
}
COMMAND:sfpd(playerid, params[])
{
    PortPlayerMapVeh(playerid, -1624.2128,674.2734,6.9573,219.9653,-1623.9940,674.0118,7.1875,219.9653, "San Fierro Police Department", "sfpd");
    return 1;
}
COMMAND:skyroad4(playerid, params[])
{
    PortPlayerMapVeh(playerid, 587.9016,1400.4779,1228.1453,3.2243,587.9016,1400.4779,1228.1453,3.2243, "Skyroad 4", "skyroad4");
    return 1;
}
COMMAND:dfun(playerid, params[])
{
    PortPlayerMapVeh(playerid, 3638.867, 1179.233, 10.214, 0.0,  3638.867, 1179.233, 10.214, 0.0, "Dune Fun", "dfun");
    return 1;
}
COMMAND:slide(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1572.9949, -1238.7869, 277.7445, 358.2480, 1572.9949, -1238.7869, 277.7445, 358.2480, "Slide", "slide");
    return 1;
}
COMMAND:hp(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2848.1548,-1977.4320,10.6646,271.6942, 2848.1548,-1977.4320,10.6646,271.6942, "HalfPipe", "hp");
    return 1;
}
COMMAND:tube(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1254.5294,-2285.2883,1084.8463,333.6016,1254.5294,-2285.2883,1084.8463,333.6016, "Tube", "tube");
    return 1;
}
COMMAND:racemap(playerid, params[])
{
    PortPlayerMapVeh(playerid, -2904.3860, -415.5923, 4.6274, 0.3237,-2904.3860, -415.5923, 4.6274, 0.3237, "Racemap", "racemap");
    return 1;
}
COMMAND:racemap2(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2741.1375,1969.4594,5269.7466,178.2995,2739.9221,1904.8870,5269.4741,180.1579, "Racemap 2", "racemap2");
    return 1;
}
COMMAND:hayclimb(playerid, params[])
{
    PortPlayerMap(playerid, -1788.4408, 575.2750, 35.1641, 145.6224, "Hayclimb", "hayclimb");
    return 1;
}
COMMAND:dfun2(playerid, params[])
{
    PortPlayerMapVeh(playerid, 473.3654,-1883.9589,2.4099,167.1191,473.3654,-1883.9589,2.4099,167.1191, "Dune Fun 2", "dfun2");
    return 1;
}
COMMAND:mi(playerid, params[])
{
    PortPlayerMap(playerid, -3801.8572, 498.8828, 16.5183, 121.5722, "Mellnik´s Island", "mi");
    return 1;
}
COMMAND:bikec(playerid, params[])
{
    if(PortPlayerMap(playerid, 1102.3887,1355.4951,10.8203,276.7901, "Bike Challange", "bikec"))
    {
        SetPVarInt(playerid, "doingStunt", 1);
        
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
	    if(PlayerInfo[playerid][PV_3DLabel] != Text3D:-1)
	    {
	        DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
	        PlayerInfo[playerid][PV_3DLabel] = Text3D:-1;
	    }
		if(PlayerInfo[playerid][PV_Vehicle] != -1)
		{
			DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
			PlayerInfo[playerid][PV_Vehicle] = -1;
		}
		if(PlayerInfo[playerid][Vehicle] != -1)
		{
			DestroyVehicle(PlayerInfo[playerid][Vehicle]);
			PlayerInfo[playerid][Vehicle] = -1;
		}
		for(new obj = 0; obj < 13; obj++)
		{
		    if(hVIPVehObj[playerid][obj] != -1)
		    {
		        DestroyObject(hVIPVehObj[playerid][obj]);
		        hVIPVehObj[playerid][obj] = -1;
		    }
		}
		if(PlayerInfo[playerid][TrailerVid] != -1)
		{
			DestroyVehicle(PlayerInfo[playerid][TrailerVid]);
			PlayerInfo[playerid][TrailerVid] = -1;
		}
    }
    return 1;
}
COMMAND:treehouse(playerid, params[])
{
    PortPlayerMap(playerid, -804.6822, -2075.3076, 45.1331, 320.1583, "Treehouse", "treehouse");
    return 1;
}
COMMAND:tm(playerid, params[])
{
	cmd_trackmania(playerid, "");
	return 1;
}
COMMAND:tm2(playerid, params[])
{
    cmd_trackmania2(playerid, "");
	return 1;
}
COMMAND:trackmania(playerid, params[])
{
    PortPlayerMapVeh(playerid, 1297.3998, -5626.5122, 81.7, 149.0596,1297.3998, -5626.5122, 81.7, 149.0596, "Trackmania", "trackmania");
    return 1;
}
COMMAND:trackmania2(playerid, params[])
{
    PortPlayerMapVeh(playerid, -1929.1312, 6627.0327, 12.0, 180.0,-1929.1312, 6627.0327, 12.0, 180.0, "Trackmania", "trackmania2");
    return 1;
}
COMMAND:ip(playerid, params[])
{
    PortPlayerMapVeh(playerid, -5051.7461, -2237.2556, 10.9, 359.8096,-5051.7461, -2237.2556, 10.9, 359.8096, "Infernus Paradise", "ip");
    return 1;
}
COMMAND:ip2(playerid, params[])
{
    PortPlayerMapVeh(playerid, -297.6044, 3682.8264, 24.0, 0.0, -297.6044, 3682.8264, 24.0, 0.0, "Infernus Paradise 2", "ip2");
    return 1;
}
COMMAND:ip3(playerid, params[])
{
    PortPlayerMapVeh(playerid, 4546.4175,655.6476,13.4803,0.0375,4546.4175,655.6476,13.4803,0.0375, "Infernus Paradise 3", "ip3");
    return 1;
}
COMMAND:disney(playerid, params[])
{
    PortPlayerMapVeh(playerid, 400.2232,636.9904,16.8194,136.9245,400.2232,636.9904,16.8194,136.924, "Disney", "disney");
    return 1;
}
COMMAND:gd(playerid, params[])
{
    PortPlayerMapVeh(playerid, 551.1603,860.3625,7113.0366,268.0655,551.1603,860.3625,7113.0366,268.0655, "Going Down", "gd");
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
COMMAND:skyroad(playerid, params[])
{
    PortPlayerMapVeh(playerid,  2999.2258, -1433.3010, 1244.1365, 101.9770, 2954.5017, -1441.2960, 1245.5, 100.9987, "Skyroad", "skyroad");
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
COMMAND:qjump(playerid, params[])
{
    PortPlayerMapVeh(playerid, 868.278,245.432,587.522,0.0,868.278,245.432,587.522,0.0, "Quarry Jump", "qjump");
    return 1;
}
COMMAND:party(playerid, params[])
{
    PortPlayerMap(playerid, -377.2038,2131.4634,133.1797,227.9924, "Party", "party");
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
COMMAND:qp2(playerid, params[])
{
    PortPlayerMap(playerid, 2121.9146,2397.7786,51.2586,272.0792, "Quad Parkour 2", "qp2");
    return 1;
}
COMMAND:qp(playerid, params[])
{
    PortPlayerMap(playerid, -2904.806, 880.312, 5.354, 56.0, "Quad Parkour", "qp");
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
    ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    PortPlayerMap(playerid, 3362.586, -1939.724, 43.027, 37.0, "BMX Parkour", "bmx");
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
    PortPlayerMapVeh(playerid,-2682.1389,1344.4447,17.0603,244.5469,-2691.2363,1353.6704,16.7702,240.1605, "Bordel", "bordel");
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
COMMAND:lvdrift(playerid, params[])
{
    PortPlayerMapVeh(playerid, 2333.8508,1405.8370,42.5904,358.0404,2333.8508,1405.8370,42.5904,358.0404, "Las Venturas Drift", "lvdrift");
    return 1;
}
COMMAND:sfdrift(playerid, params[])
{
    PortPlayerMapVeh(playerid, -2410.9963, -600.7848, 132.3277, 127.1357, -2410.9963, -600.7848, 132.3277, 127.1357, "San Fierro Drift", "sfdrift");
    return 1;
}
COMMAND:driftisland(playerid, params[])
{
    PortPlayerMapVeh(playerid, 3075.9263,-3153.9749,49.1486,3.6277,3075.9263,-3153.9749,49.1486,3.6277, "Drift Island", "df");
    return 1;
}
COMMAND:drift(playerid, params[])
{
    PortPlayerMapVeh(playerid, -344.308, 1528.474, 75.159, 256.0,-344.308, 1528.474, 75.159, 256.0, "Drift", "drift");
    return 1;
}
COMMAND:balloon(playerid, params[])
{
    PortPlayerMap(playerid, 295.4890,-1813.5734,52.0518,4.9753, "Balloon", "balloon");
    return 1;
}
COMMAND:lsp(playerid, params[])
{
    PortPlayerMap(playerid, 2505.2646,-1694.4974,17.9575,182.0808, "Los Santos Parkour", "lsp");
    return 1;
}
COMMAND:df(playerid, params[])
{
    cmd_driftisland(playerid, "");
    return 1;
}
COMMAND:parkour(playerid, params[])
{
    if(PortPlayerMap(playerid, 2586.5618,-1346.5614,232.2472,0.0, "Parkour 1", "parkour"))
    {
        ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    }
    return 1;
}
COMMAND:parkour1(playerid, params[])
{
	cmd_parkour(playerid, "");
    return 1;
}
COMMAND:parkour2(playerid, params[])
{
    if(PortPlayerMap(playerid, -787.3710,-2766.3005,2660.3042,0.0, "Parkour 2", "parkour2"))
    {
        ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    }
    return 1;
}
COMMAND:parkour3(playerid, params[])
{
    if(PortPlayerMap(playerid, -783.9699, -3662.0358, 137.3758,0.0, "Parkour 3", "parkour3"))
    {
        ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    }
    return 1;
}
COMMAND:parkour4(playerid, params[])
{
    if(PortPlayerMap(playerid, -2929.4922,-1876.4229,8.3901, 344.1002, "Parkour 4", "parkour4"))
    {
        ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    }
    return 1;
}
COMMAND:parkour5(playerid, params[])
{
    if(PortPlayerMap(playerid, 1441.3851318359, -1700.8812255859, 915.390625, 344.1002, "Parkour 5", "parkour5"))
    {
        ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    }
    return 1;
}
COMMAND:parkour6(playerid, params[])
{
    if(PortPlayerMap(playerid, 2768.4343261719,-2743.7131347656,2460.0815429688, 0.0, "Parkour 6", "parkour6"))
    {
        ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    }
    return 1;
}
COMMAND:parkour7(playerid, params[])
{
    if(PortPlayerMap(playerid, 3018.1736,-1879.4410,599.0370,178.1489, "Parkour 7", "parkour7"))
    {
        ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    }
    return 1;
}
COMMAND:parkour8(playerid, params[])
{
    if(PortPlayerMap(playerid, 2246,-1276,942, 0.0, "Parkour 8", "parkour8"))
    {
        ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""se" - Parkour", ""white"Use /spos and /lpos - very helpful in parkour maps.", "OK", "");
    }
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
COMMAND:farm2(playerid, params[])
{
    PortPlayerMapVeh(playerid,-146.8734,30.2465,5.8940,125.9588,-146.8734,30.2465,5.8940,125.9588, "Farm 2", "farm2");
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
COMMAND:glassjump(playerid, params[])
{
    PortPlayerMapVeh(playerid,2121.4280, 2560.6331, 514.7283, 0.0, 2121.4280, 2560.6331, 514.7283, 0.0, "Glass Jump", "glassjump");
    return 1;
}
COMMAND:bj(playerid, params[])
{
    PortPlayerMap(playerid,294.3475,-1610.8379,494.6685,174.5567, "Base Jump 1", "bj");
    return 1;
}
COMMAND:bikejump(playerid, params[])
{
    PortPlayerMapVeh(playerid,641.9279,2222.7144,940.5793,93.1221,641.9279,2222.7144,940.5793,93.1221, "Bike Jump", "bikejump");
    return 1;
}
COMMAND:tunneljump(playerid, params[])
{
    PortPlayerMap(playerid,-494.527, 1600.167, 844.297, 271.0, "Tunnel Jump", "tunneljump");
    return 1;
}
COMMAND:hugejump(playerid, params[])
{
    PortPlayerMapVeh(playerid,863.2654, 2490.4468, 694.3790, 296.0000, 899.6528, 2502.3611, 694.5513, 91.7515, "Huge Jump", "hugejump");
    return 1;
}
COMMAND:loopjump(playerid, params[])
{
    PortPlayerMapVeh(playerid,-2682.3909, 385.2379, 924.8377, 269.6873, -2682.3909, 385.2379, 924.8377, 269.6873, "Loop Jump", "loopjump");
    return 1;
}
COMMAND:xslide(playerid, params[])
{
    PortPlayerMapVeh(playerid,1862.760, 1337.315, 55.933, 33.0,1862.760, 1337.315, 55.933, 33.0, "XSlide", "xslide");
    return 1;
}
COMMAND:drop(playerid, params[])
{
    PortPlayerMapVeh(playerid,309.7934, 5461.4546, 3426.6863, 180.0,309.7934, 5461.4546, 3426.6863, 180.0, "Drop", "drop");
    return 1;
}
COMMAND:tugfun(playerid, params[])
{
    PortPlayerMapVeh(playerid,2774.316, -1309.180, 4316.250, 0.0,2774.316, -1309.180, 4316.250, 0.0, "Tugfun", "Tugfun");
    return 1;
}
COMMAND:deathjump(playerid, params[])
{
    PortPlayerMapVeh(playerid,2629.9734,-1029.7679,882.9141,240.2882,2629.9734,-1029.7679,882.9141,240.2882, "Death Jump", "deathjump");
    return 1;
}
COMMAND:bj1(playerid, params[])
{
    cmd_bj(playerid, "");
    return 1;
}
COMMAND:skydive(playerid, params[])
{
    if(PortPlayerMap(playerid,3887.5874,3891.2942,2018.7869,91.8075, "Skydive 1", "skydive"))
    {
        cmd_pc(playerid, "");
        SetPVarInt(playerid, "doingStunt", 2);
    }
    return 1;
}
COMMAND:skydive2(playerid, params[])
{
    if(PortPlayerMap(playerid,-1288.0760,-44.0085,4216.4507,93.1578, "Skydive 2", "skydive2"))
    {
        cmd_pc(playerid, "");
        SetPVarInt(playerid, "doingStunt", 2);
    }
    return 1;
}
COMMAND:skydive3(playerid, params[])
{
    if(PortPlayerMap(playerid,2875,-3233,3268,0, "Skydive 3", "skydive3"))
    {
        cmd_pc(playerid, "");
        SetPVarInt(playerid, "doingStunt", 2);
    }
    return 1;
}
COMMAND:pool(playerid, params[])
{
    PortPlayerMap(playerid,4155.7158,2426.9578,1.2054,358.2449, "Pool", "pool");
    return 1;
}
COMMAND:docks(playerid, params[])
{
    PortPlayerMapVeh(playerid,2714.5000,-2711.2676,2.4919,170.7375,2714.5000,-2711.2676,2.4919,170.7375, "Docks", "docks");
    return 1;
}
COMMAND:sfstation(playerid, params[])
{
    PortPlayerMapVeh(playerid,-1952.5077,137.8305,26.2813,268.8237,-1952.5077,137.8305,26.2813,268.8237, "SF Station", "sfstation");
    return 1;
}
COMMAND:lsstation(playerid, params[])
{
    PortPlayerMapVeh(playerid,1706.4425,-1943.0046,13.5607,269.2462,1706.4425,-1943.0046,13.5607,269.2462, "LS Station", "lsstation");
    return 1;
}
COMMAND:lvstation(playerid, params[])
{
    PortPlayerMapVeh(playerid,1433.8182,2606.3877,10.6719,90.1619,1433.8182,2606.3877,10.6719,90.1619, "LV Station", "lvstation");
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
    ShowPlayerDialog(playerid, NETSTATS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - My NetworkStats", stats, "OK", "");
	return 1;
}

COMMAND:netstats(playerid, params[])
{
	new stats[423];
    GetNetworkStats(stats, sizeof(stats));
    ShowPlayerDialog(playerid, NETSTATS_DIALOG + 1, DIALOG_STYLE_MSGBOX, ""se" - Server Network Stats", stats, "OK", "");
	return 1;
}

COMMAND:myskin(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	extract params -> new skin; else
	{
 		return SCM(playerid, NGS_GREEN, "Usage: /myskin <skin id>");
	}
	if(!IsValidSkin(skin)) return SCM(playerid, -1, ""er"Invaild Skin ID");
	SetSpawnInfo(playerid, NO_TEAM, skin, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
    SetPlayerSkin(playerid, skin);
	return 1;
}

COMMAND:fallout(playerid, params[])
{
    if(gTeam[playerid] == FALLOUT) return cmd_exit(playerid, "");
    if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");

    CheckPlayerGod(playerid);

	if(g_FalloutStatus == e_Fallout_Inactive)
	{
	    ResetFalloutGameTime();
	    Fallout_BuildMap();
	    Fallout_StartGame();
		gTeam[playerid] = FALLOUT;
		g_FalloutStatus = e_Fallout_Startup;
		Fallout_SetPlayer(playerid);
        SCMToAll(BLUE, ""fallout_sign" Type /fallout to participate");
        CurrentFalloutPlayers++;
        NewMinigameJoin(playerid, "Fallout", "fallout");
        SetPlayerInterior(playerid, 0);
	}
	else if(g_FalloutStatus == e_Fallout_Startup)
	{
		gTeam[playerid] = FALLOUT;
		new string[100];
		format(string, sizeof(string), "%s joined Fallout!", __GetName(playerid));
		FalloutMSG(string);
		Fallout_SetPlayer(playerid);
		CurrentFalloutPlayers++;
        NewMinigameJoin(playerid, "Fallout", "fallout");
        SetPlayerInterior(playerid, 0);
	}
	else if(g_FalloutStatus == e_Fallout_Running)
	{
	    SCM(playerid, -1, ""er"Fallout already started!");
	}
	return 1;
}

COMMAND:derby(playerid, params[])
{
	if(gTeam[playerid] == DERBY) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");
	if(CurrentDerbyPlayers == MAX_DERBY_PLAYERS) return SCM(playerid, -1, ""er"Derby reached it's max Players!");

    CheckPlayerGod(playerid);

    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
    gTeam[playerid] = DERBY;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	ClearAnimations(playerid);

	if(IsDerbyRunning)
	{
        ShowPlayerDerbyTextdraws(playerid);
        SCM(playerid, -1, ""er"Derby already started, please wait till next round!");
	}
	else
	{
		ShowDialog(playerid, DERBY_VOTING_DIALOG);
        SCM(playerid, RED, "You joined Derby. Please vote for a map!");
	}

	SetPlayerDerbyStaticMeshes(playerid);
	ShowPlayerDerbyTextdraws(playerid);
	CurrentDerbyPlayers++;
	SetPlayerVirtualWorld(playerid, DERBY_WORLD);
	SetPlayerInterior(playerid, 0);

	NewMinigameJoin(playerid, "Derby", "derby");
	return 1;
}

COMMAND:war(playerid, params[])
{
	if(gTeam[playerid] == WAR) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");
	
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	
	CheckPlayerGod(playerid);
	
	ResetPlayerWeapons(playerid);
	switch(random(4))
	{
	    case 0: SetPlayerPosition(playerid, 164.9882,1922.3430,18.4712,247.7249);
	    case 1: SetPlayerPosition(playerid, 285.5063,1819.9249,24.4108,1.9556);
	    case 2: SetPlayerPosition(playerid, 291.3683,1918.2693,17.6265,275.6602);
	    case 3: SetPlayerPosition(playerid, 236.5930,1918.7386,17.6446,145.6778);
	}
	SetPlayerHealth(playerid, 100.0);
	
	ShowPlayerDMTextdraws(playerid);
	
	GivePlayerWeapon(playerid, 3, 1);
	GivePlayerWeapon(playerid, 24, 9999999);
	GivePlayerWeapon(playerid, 25, 9999999);
	GivePlayerWeapon(playerid, 28, 9999999);
	GivePlayerWeapon(playerid, 30, 9999999);
	GivePlayerWeapon(playerid, 33, 9999999);
	GivePlayerWeapon(playerid, 39, 2);
	GivePlayerWeapon(playerid, 17, 10);
	GivePlayerWeapon(playerid, 10, 1);
	
	gTeam[playerid] = WAR;
	
	SetPlayerVirtualWorld(playerid, 5);
	SetCameraBehindPlayer(playerid);
	SetPlayerInterior(playerid, 0);
	SetPlayerWorldBounds(playerid, 432.0814, -81.74512, 2125.373, 1646.58);
	
	NewMinigameJoin(playerid, "WAR", "war");
	return 1;
}

COMMAND:dm(playerid, params[])
{
	if(gTeam[playerid] == DM && gLastMap[playerid] == DM_1) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");

    CheckPlayerGod(playerid);

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
	if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");

    CheckPlayerGod(playerid);

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
	if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");

    CheckPlayerGod(playerid);

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
	if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");

    CheckPlayerGod(playerid);

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
	TextDrawHideForPlayer(playerid, TXTInfo);
	return 1;
}

ShowPlayerMeshTXT(playerid)
{
	TextDrawShowForPlayer(playerid, TXTInfo);
	return 1;
}

COMMAND:hidef(playerid, params[])
{
    PlayerInfo[playerid][bFooterEnabled] = false;
	TextDrawHideForPlayer(playerid, TXTInfo);
    PlayerTextDrawHide(playerid, TXTPlayerFooter[playerid]);
    TextDrawHideForPlayer(playerid, FooterBlack);
	return 1;
}

COMMAND:showf(playerid, params[])
{
    PlayerInfo[playerid][bFooterEnabled] = true;
	TextDrawShowForPlayer(playerid, TXTInfo);
	PlayerTextDrawShow(playerid, TXTPlayerFooter[playerid]);
	TextDrawShowForPlayer(playerid, FooterBlack);
	return 1;
}

COMMAND:flip(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	new currentveh, Float:angle;
  	currentveh = GetPlayerVehicleID(playerid);
	GetVehicleZAngle(currentveh, angle);
	SetVehicleZAngle(currentveh, angle);
	SCM(playerid, NGS_BLUE, "You can also press '2' to flip you vehicle");
	return 1;
}

COMMAND:sp(playerid, params[])
{
	cmd_s(playerid, params);
	return 1;
}

COMMAND:s(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
    if(GetPVarInt(playerid, "doingStunt") != 0) return SCM(playerid, -1, ""er"You can't save your position now");
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
	SCM(playerid, -1, ""vgreen"Position saved! Load Position with "white"/l");
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
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
    if(GetPVarInt(playerid, "doingStunt") != 0) return SCM(playerid, -1, ""er"You can't load your position now");
	if(!PlayerInfo[playerid][SavedPos])
	{
		SCM(playerid, WHITE, "No position saved. Use /s first.");
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
	SCM(playerid, WHITE, ""vgreen"Saved position loaded");
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
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
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
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
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

COMMAND:color(playerid, params[])
{
	cmd_colors(playerid, params);
	return 1;
}

COMMAND:colors(playerid, params[])
{
	if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2 || gTeam[playerid] == gBG_VOTING)
	{
	    return SCM(playerid, -1, ""er"You can't use this command while being in TDM!");
	}

	new r, g, b;
	if(sscanf(params, "iii", r, g, b) || !(0 <= r <= 255) || !(0 <= g <= 255) || !(0 <= b <= 255))
	{
		SCM(playerid, -1, ""se" You can also set your own color using RGB values. /color <0-255> <0-255> <0-255>");
		SCM(playerid, -1, ""se" Quick color change: /blue /orange /red /yellow /grey /pink /green - /random for a random color");
		ShowPlayerDialog(playerid, COLOR_DIALOG, DIALOG_STYLE_LIST, ""se" - Colors", ""RED_E"Red\n"BLUE_E"Blue\n"WHITE_E"White\n{FFFF82}Ivory\n"PINK_E"Pink\n"YELLOW_E"Yellow\n"GREEN_E"Green\n"LB_E"Lightblue\n"GREY_E"Grey\n"ORANGE_E"Orange\n{800080}Purple\n"LG_E"Light Green\n{B0C4DE}Steelblue", "Select", "Exit");
	}
	else
	{
		if(r < 30 || g < 30 || b < 30)
		{
   			return SCM(playerid, -1, ""er"Color too dark! RGB values under 30 are not allowed!");
		}
		new col = COLOR_RGB(r, g, b, 99), string[144];
		SetPlayerColor(playerid, col);

		format(string, sizeof(string), ""se" Your nickname color has been changed to %i-%i-%i in RGB", r, g, b);
		SCM(playerid, col, string);
	}
	return 1;
}

COMMAND:random(playerid, params[])
{
	new rand = random(sizeof(PlayerColors)), string[144];
	SetPlayerColor(playerid, PlayerColors[rand]);
	format(string, sizeof(string), "Color set! Your new color: {%06x}Color", GetPlayerColor(playerid) >>> 8);
	SCM(playerid, BLUE, string);
	return 1;
}

COMMAND:red(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return SCM(playerid, RED, NOT_AVAIL);
	SetPlayerColor(playerid, RED);
	SCM(playerid, BLUE, "Color set!");
	return 1;
}

COMMAND:yellow(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return SCM(playerid, RED, NOT_AVAIL);
	SetPlayerColor(playerid, YELLOW);
	SCM(playerid, BLUE, "Color set!");
	return 1;
}

COMMAND:grey(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return SCM(playerid, RED, NOT_AVAIL);
	SetPlayerColor(playerid, GREY);
	SCM(playerid, BLUE, "Color set!");
	return 1;
}

COMMAND:pink(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return SCM(playerid, RED, NOT_AVAIL);
	SetPlayerColor(playerid, PINK);
	SCM(playerid, BLUE, "Color set!");
	return 1;
}

COMMAND:blue(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return SCM(playerid, RED, NOT_AVAIL);
	SetPlayerColor(playerid, BLUE);
	SCM(playerid, BLUE, "Color set!");
	return 1;
}

COMMAND:green(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return SCM(playerid, RED, NOT_AVAIL);
	SetPlayerColor(playerid, GREEN);
	SCM(playerid, BLUE, "Color set!");
	return 1;
}

COMMAND:orange(playerid, params[])
{
    if(gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return SCM(playerid, RED, NOT_AVAIL);
	SetPlayerColor(playerid, NGS_BLUE);
	SCM(playerid, BLUE, "Color set!");
	return 1;
}

COMMAND:spawn(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	SetCameraBehindPlayer(playerid);
    TogglePlayerControllable(playerid, true);
    TogglePlayerSpectating(playerid, false);
	ResetPlayerWorld(playerid);
	SpawnPlayer(playerid);
	return 1;
}

COMMAND:fs(playerid, params[])
{
	SCM(playerid, BLUE, "Fight Styles: /boxing /kungfu /kneehead /grabkick /elbow /normal");
	return 1;
}

COMMAND:fightsytles(playerid, params[])
{
	SCM(playerid, BLUE, "Fight Styles: /boxing /kungfu /kneehead /grabkick /elbow /normal");
	return 1;
}

COMMAND:normal(playerid, params[])
{
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
	SCM(playerid, BLUE, "You have changed your fighting style to normal!");
	return 1;
}

COMMAND:boxing(playerid, params[])
{
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
	SCM(playerid, BLUE, "You have changed your fighting style to boxing!");
	return 1;
}

COMMAND:kungfu(playerid, params[])
{
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
	SCM(playerid, BLUE, "You have changed your fighting style to kungfu!");
	return 1;
}

COMMAND:kneehead(playerid, params[])
{
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
	SCM(playerid, BLUE, "You have changed your fighting style to kneehead!");
	return 1;
}

COMMAND:grabkick(playerid, params[])
{
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
	SCM(playerid, BLUE, "You have changed your fighting style to grabkick");
	return 1;
}

COMMAND:elbow(playerid, params[])
{
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
	SCM(playerid, BLUE, "You have changed your fighting style to elbow");
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

COMMAND:superman(playerid, params[])
{
	cmd_sj(playerid, "");
	return 1;
}

COMMAND:sb(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	if(PlayerInfo[playerid][SpeedBoost])
    {
     	SCM(playerid, YELLOW, "SpeedBoost has been disabled!");
	}
	else
	{
	    SCM(playerid, YELLOW, "SpeedBoost has been enabled!");
	}
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	PlayerInfo[playerid][SpeedBoost] = !PlayerInfo[playerid][SpeedBoost];
	return 1;
}

COMMAND:sj(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	if(PlayerInfo[playerid][SuperJump])
    {
     	SCM(playerid, YELLOW, "SuperJump has been disabled!");
	}
	else
	{
	    SCM(playerid, YELLOW, "SuperJump has been enabled!");
	}
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	PlayerInfo[playerid][SuperJump] = !PlayerInfo[playerid][SuperJump];
	return 1;
}

COMMAND:enter(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

    new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
	    found = true;
	    if(HouseInfo[i][locked])
		{
			SCM(playerid, -1, ""er"This house is locked");
			break;
		}
	    SetPlayerInterior(playerid, HouseIntTypes[HouseInfo[i][interior]][interior]);
		SetPlayerVirtualWorld(playerid, HouseInfo[i][iID] + 1000);
  		SetPlayerPos(playerid, HouseIntTypes[HouseInfo[i][interior]][house_x], HouseIntTypes[HouseInfo[i][interior]][house_y], HouseIntTypes[HouseInfo[i][interior]][house_z]);
		gTeam[playerid] = HOUSE;
		SendInfo(playerid, "~h~~y~House entered!", 3000);
	}
	if(!found) SCM(playerid, -1, ""er"You aren't near if any house");
	return 1;
}

COMMAND:bbuy(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastPBuy] + COOLDOWN_CMD_PBUY) >= tick)
	{
    	return SCM(playerid, -1, ""er"Please wait a bit before using this cmd again!");
	}

	new bool:found = false;
	for(new i = 0; i < propid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z])) continue;
	    found = true;

	    if(PropInfo[i][sold])
		{
			SCM(playerid, -1, ""er"Business is not for sale");
			break;
		}
		if(PlayerInfo[playerid][Props] >= MAX_PROPS_PER_PLAYER)
		{
			SCM(playerid, -1, ""er"You already own a business!");
			break;
		}
	    if(_GetPlayerScore(playerid) < PropInfo[i][E_score])
		{
			SCM(playerid, -1, ""er"You need more score for this business!");
			break;
		}
		if(GetPlayerCash(playerid) < PropInfo[i][price])
		{
			SCM(playerid, -1, ""er"You need more money to buy this business!");
			break;
		}
		strmid(PropInfo[i][Owner], __GetName(playerid), 0, 25, 25);
	    PropInfo[i][sold] = 1;
	    
	    new	nlabel[144];
			
	    format(nlabel, sizeof(nlabel), ""business_mark"\nOwner: %s\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", __GetName(playerid), PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
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
	    format(nlabel, sizeof(nlabel), ""se" %s(%i) bought the business %i for $%s!", __GetName(playerid), playerid, PropInfo[i][iID], ToCurrency(PropInfo[i][price]));
	    SCMToAll(-1, nlabel);
	    ShowPlayerDialog(playerid, 5005, DIALOG_STYLE_MSGBOX, ""white"Business bought!", ""white"You can now use these commands:\n\n"dl"/bsell\n"dl"/gotomybizz", "OK", "");
	    break;
	}
	if(!found) SCM(playerid, -1, ""er"You aren't near of any business");
	return 1;
}

COMMAND:pbuy(playerid, params[])
{
	cmd_bbuy(playerid, "");
    return 1;
}

COMMAND:buy(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastBuy] + COOLDOWN_CMD_BUY) >= tick)
	{
    	return SCM(playerid, -1, ""er"Please wait a bit before using this cmd again!");
	}

	new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
        found = true;

	    if(HouseInfo[i][sold])
		{
			SCM(playerid, -1, ""er"House is not buyable");
			break;
		}
		if(PlayerInfo[playerid][Houses] >= MAX_HOUSES_PER_PLAYER)
		{
			SCM(playerid, -1, ""er"You already own a House!");
			break;
		}
	    if(_GetPlayerScore(playerid) < HouseInfo[i][E_score])
		{
			SCM(playerid, -1, ""er"You need more score for this House!");
			break;
		}
		if(GetPlayerCash(playerid) < HouseInfo[i][price])
		{
			SCM(playerid, -1, ""er"You need more money to buy this House!");
			break;
		}

		strmid(HouseInfo[i][Owner], __GetName(playerid), 0, 25, 25);
	    HouseInfo[i][sold] = 1;

	    new nlabel[144];

	    format(nlabel, sizeof(nlabel), ""house_mark"\nOwner: %s\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", __GetName(playerid), HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
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
	    format(nlabel, sizeof(nlabel), ""se" %s(%i) bought the house %i for $%s!", __GetName(playerid), playerid, HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]));
	    SCMToAll(-1, nlabel);
	    ShowPlayerDialog(playerid, 5006, DIALOG_STYLE_MSGBOX, ""white"House bought!", ""white"You can now use these commands:\n\n"dl"/upgrade\n"dl"/lock\n"dl"/enter\n"dl"/exit\n"dl"/sell\n"dl"/gotomyhouse", "OK", "");
	    break;
	}
	if(!found) SCM(playerid, -1, ""er"You aren't near of any house");
	return 1;
}

COMMAND:bsell(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastPSell] + COOLDOWN_CMD_PSELL) >= tick)
	{
    	return SCM(playerid, -1, ""er"Please wait a bit before using this cmd again!");
	}

	new bool:found = false;
	for(new i = 0; i < propid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z])) continue;
	    found = true;

	    if(!PropInfo[i][sold])
		{
			SCM(playerid, -1, ""er"Business can´t be sold!");
			break;
		}
		if(strcmp(PropInfo[i][Owner], __GetName(playerid)))
		{
			SCM(playerid, -1, ""er"You don´t own this Business!");
			break;
		}
	    strmid(PropInfo[i][Owner], "ForSale", 0, 25, 25);
	    PropInfo[i][sold] = 0;

	    new nlabel[144];

	    format(nlabel, sizeof(nlabel), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
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
	    format(nlabel, sizeof(nlabel), ""se" %s(%i) sold the business %i for $%s!", __GetName(playerid), playerid, PropInfo[i][iID], ToCurrency(floatround(PropInfo[i][price] / 4)));
	    SCMToAll(-1, nlabel);
	    break;
	}
	if(!found) SCM(playerid, -1, ""er"You aren't near of any business");
	return 1;
}

COMMAND:psell(playerid, params[])
{
	cmd_bsell(playerid, "");
	return 1;
}

COMMAND:sell(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastSell] + COOLDOWN_CMD_SELL) >= tick)
	{
    	return SCM(playerid, -1, ""er"Please wait a bit before using this cmd again!");
	}

    new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
	    found = true;

	    if(!HouseInfo[i][sold])
		{
			SCM(playerid, -1, ""er"House cannot be sold!");
			break;
		}
	    if(strcmp(HouseInfo[i][Owner], __GetName(playerid)))
		{
			SCM(playerid, -1, ""er"You don´t own this house!");
			break;
		}
	    strmid(HouseInfo[i][Owner], "ForSale", 0, 25, 25);
	    HouseInfo[i][sold] = 0;
	    HouseInfo[i][locked] = 1;

	    new nlabel[144];

	    format(nlabel, sizeof(nlabel), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
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
	    format(nlabel, sizeof(nlabel), ""se" %s(%i) sold the house %i for $%s!", __GetName(playerid), playerid, HouseInfo[i][iID], ToCurrency(floatround(HouseInfo[i][price] / 4)));
	    SCMToAll(-1, nlabel);
	    break;
	}
	if(!found) SCM(playerid, -1, ""er"You aren't near of any house");
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
		    else SCM(playerid, -1, ""er"You are not in your vehicle");
		}
    }
    else
	{
		SCM(playerid, -1, NOT_AVAIL);
	}
    return 1;
}

COMMAND:pvlock(playerid, params[])
{
	cmd_lock(playerid, "");
	return 1;
}

COMMAND:pvunlock(playerid, params[])
{
	cmd_unlock(playerid, "");
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
	    	return SCM(playerid, -1, ""er"Please wait a bit before using this cmd again!");
		}

	    new bool:found = false;
		for(new i = 0; i < houseid; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z]))
			{
				found = true;
				if(strcmp(HouseInfo[i][Owner], __GetName(playerid)))
				{
					SCM(playerid, -1, ""er"This isn´t your House!");
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
					SCM(playerid, -1, ""er"This isn´t your House!");
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
		if(!found) SCM(playerid, -1, ""er"You aren´t near of any house!");
	}
	else
	{
  		SCM(playerid, RED, NOT_AVAIL);
	}
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
	if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");

    CheckPlayerGod(playerid);

	GunGamePlayers++;
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 1338);

	GunGame_Player[playerid][level] = 0;
	GunGame_Player[playerid][dead] = true;
	GunGame_Player[playerid][pw] = true;

	gTeam[playerid] = GUNGAME;

	new rand = random(9);
	ResetPlayerWeapons(playerid);

	SetPlayerPosEx(playerid, GunGame_Spawns[rand][0], GunGame_Spawns[rand][1], floatadd(GunGame_Spawns[rand][2], 2.5));
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
	if(gTeam[playerid] == gBG_VOTING || gTeam[playerid] == gBG_TEAM1 || gTeam[playerid] == gBG_TEAM2) return cmd_exit(playerid, "");
    if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");
    
    CheckPlayerGod(playerid);

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

COMMAND:acmds(playerid, params[])
{
	cmd_adminhelp(playerid, "");
	return 1;
}

COMMAND:adminhelp(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    new string[1024];

	    strcat(string, ""yellow_e"Level 1:\n"white"/warn /slap /reports /spec /specoff /disarm /pweaps /getin\n/gotoxyz /spectators /caps /day /night /dawn /lightfw\n/kick /mute /unmute\n\n");
	    strcat(string, ""yellow_e"Level 2:\n"white"/online /offline /onduty /offduty /asay\n/move /ban /cuff /uncuff /announce /announce2\n\n");
	    strcat(string, ""yellow_e"Level 3:\n"white"/freeze /unfreeze /eject /go /burn /mkick /clearchat /ipban \n/giveweapon\n\n");
	    strcat(string, ""yellow_e"Level 4:\n"white"/sethealth /get /getip /healall /armorall /cashfall /scorefall\n\n");
	    strcat(string, ""yellow_e"Level 5:\n"white"/setcash /setscore\n\n");
	    strcat(string, ""yellow_e"Level 6:\n"white"/resethouse /resetbizz /sethouseprice /sethousescore /setbizzprice \n/setbizzscore /setbizzearnings /setvip");

        ShowPlayerDialog(playerid, ADMIN_CMD_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Admin Commands", string, "OK", "");
	}
  	else
	{
  		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:mini(playerid, params[])
{
	cmd_minigun(playerid, "");
	return 1;
}

COMMAND:minigun(playerid, params[])
{
    if(gTeam[playerid] == MINIGUN) return cmd_exit(playerid, "");
	if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");

    CheckPlayerGod(playerid);

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
	if(gTeam[playerid] == SNIPER) return cmd_exit(playerid, "");
    if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");
    
    CheckPlayerGod(playerid);

	gTeam[playerid] = SNIPER;
	ResetPlayerWeapons(playerid);
	GivePlayerWeapon(playerid, 34, 99999);
	SetPlayerVirtualWorld(playerid, SNIPER_WORLD);
	SetPlayerInterior(playerid, 0);

	HidePlayerMeshTXT(playerid);

	new rand = random(7);
	SetPlayerPosEx(playerid, Sniper_Spawns[rand][0], Sniper_Spawns[rand][1], Sniper_Spawns[rand][2]+2.5);
	SetPlayerFacingAngle(playerid, Sniper_Spawns[rand][3]);

	NewMinigameJoin(playerid, "Sniper", "sniper");
   	return 1;
}

COMMAND:bounties(playerid, params[])
{
	new count = 0;
	SCM(playerid, -1, "================Current bounties=================");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerAvail(i) && PlayerInfo[i][HitmanHit] > 0)
		{
			new string[100];
			format(string, sizeof(string), "- Hit on %s(%i) for $%s", __GetName(i), i, ToCurrency(PlayerInfo[i][HitmanHit]));
			SCM(playerid, GREY, string);
			count++;
		}
	}
	if(count == 0)
	{
		SCM(playerid, GREY, "No bounties at the moment");
	}
	SCM(playerid, -1, "==============================================");
	return 1;
}

COMMAND:ff(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	
	new Float:height;
	if(sscanf(params, "f", height))
	{
		new Float:POS[3];
		GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
		SetPlayerPos(playerid, POS[0], POS[1], floatadd(POS[2], 500.0));
	}
	else
	{
		new Float:POS[3];
		GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
		SetPlayerPos(playerid, POS[0], POS[1], floatadd(POS[2], height));
	}
	return cmd_parch(playerid, "");
}

COMMAND:dive(playerid, params[])
{
	cmd_ff(playerid, params);
	return 1;
}

COMMAND:freefall(playerid, params[])
{
	cmd_ff(playerid, params);
	return 1;
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
		case VIPL:
		{
 		    SetPlayerPos(playerid, -2623.6348, 1407.9154, 7.1016);
		    ResetPlayerWorld(playerid);
		    gTeam[playerid] = NORMAL;
		    PlayerPlaySound(playerid, 1069, 0, 0, 0);
		    
		    if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
		    SetPVarInt(playerid, "doingStunt", 0);
		    return 1;
		}
	    case BUILDRACE:
	    {
	        if(BuildRace == playerid + 1) BuildRace = 0;
     	    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, 1);
		    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_MAP_ICON, 1);
	        gTeam[playerid] = NORMAL;
	        
	        if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
	        SetPVarInt(playerid, "doingStunt", 0);
	        return 1;
	    }
	    case SPEC:
	    {
	        cmd_specoff(playerid, "");
	        return 1;
	    }
	    case NORMAL:
	    {
	        SCM(playerid, -1, ""er"You can´t use this command now!");
	        SetPVarInt(playerid, "doingStunt", 0);
	        return 1;
	    }
	    case BUYCAR:
	    {
			SetPlayerInterior(playerid, 0);
		    SetPlayerPosEx(playerid, 1798.0952, -1410.8192, floatadd(13.5458, 4.5));
		    RandomWeapon(playerid);
			gTeam[playerid] = NORMAL;
			
			if(!PlayerInfo[playerid][bGod])
			{
		    	RandomWeapon(playerid);
			}
			
			if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
	    }
	    case STORE:
	    {
	        SCM(playerid, -1, ""er"Leave the store by entering the pickup");
	        
	        if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
	        SetPVarInt(playerid, "doingStunt", 0);
	        return 1;
	    }
	    case MINIGUN, SNIPER:
	    {
			gTeam[playerid] = NORMAL;
			ResetPlayerWeapons(playerid);
			RandomWeapon(playerid);
			RandomSpawn(playerid);
			ResetPlayerWorld(playerid);
			ShowPlayerMeshTXT(playerid);
			
			if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
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
			    	break;
		    	}
		    	else continue;
			}
			if(!found)
			{
				SCM(playerid, -1, ""er"Go to the house door to exit!");
				return 0;
			}
			return 1;
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
			
			if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
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
			
			if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
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
			
			if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
		}
		case DM, WAR:
		{
			gTeam[playerid] = NORMAL;
			RandomWeapon(playerid);
			RandomSpawn(playerid);
			ResetPlayerWorld(playerid);
			HidePlayerDMTextdraws(playerid);
			
			if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
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

		    if(DerbyVehLabel[playerid] != PlayerText3D:-1)
		    {
		    	DeletePlayer3DTextLabel(playerid, DerbyVehLabel[playerid]);
		    	DerbyVehLabel[playerid] = PlayerText3D:-1;
		    }

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
			
			if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
		}
		case FALLOUT:
		{
			gTeam[playerid] = NORMAL;

		    TogglePlayerControllable(playerid, true);
		    RandomSpawn(playerid);
		    RandomWeapon(playerid);
		    HidePlayerFalloutTextdraws(playerid);
		    ResetPlayerWorld(playerid);
		    CurrentFalloutPlayers--;
            PlayerInfo[playerid][FalloutLost] = true;
		    new count = 0;
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
					    FalloutMSG("Fallout has been canceled!");
						gTeam[i] = NORMAL;
				    }
				}
				Fallout_Cancel();
			}
			
			if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
		}
		case GUNGAME:
		{
		    ResetPlayerWorld(playerid);
  			gTeam[playerid] = NORMAL;

	    	RandomSpawn(playerid);
	    	RandomWeapon(playerid);
	    	SetCameraBehindPlayer(playerid);
	    	GunGamePlayers--;
	    	HidePlayerGunGameTextdraws(playerid);
	    	
	    	if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
	    	SetPVarInt(playerid, "doingStunt", 0);
	    	return 1;
		}
		case RACE:
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
			
		    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, 1);
		    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_MAP_ICON, 1);
		    
		    if(GetPVarInt(playerid, "HadGod") == 1) cmd_god(playerid, "");
		    SetPVarInt(playerid, "doingStunt", 0);
			return 1;
		}
		default: return 0;
	}
	return 1;
}

COMMAND:setspawn(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, GREY, NOT_AVAIL);
    if(GetPlayerInterior(playerid) != 0) return SCM(playerid, GREY, ""er"Wrong interior");

    GetPlayerPos(playerid, PlayerInfo[playerid][CSpawnX], PlayerInfo[playerid][CSpawnY], PlayerInfo[playerid][CSpawnZ]);
    GetPlayerFacingAngle(playerid, PlayerInfo[playerid][CSpawnA]);
    PlayerInfo[playerid][bHasSpawn] = true;

	SCM(playerid, YELLOW, "You will now spawn here!");
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
		return SCM(playerid, NGS_GREEN, "Usage: /hitman <playerid> <amount>");
	}

	if(amount < 5000 || amount > 1000000)
	{
	    return SCM(playerid, -1, ""er"$5,000 - $1,000,000!");
	}

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastHitman] + COOLDOWN_CMD_HITMAN) >= tick) return SCM(playerid, -1, ""er"You have to wait a bit before using it again!");

	if(IsPlayerAvail(player) && player != playerid)
	{
		if(GetPlayerCash(playerid) >= amount)
		{
		    new string[144];

		    if(PlayerInfo[player][HitmanHit] == 0)
		    {
		        PlayerInfo[player][HitmanHit] = PlayerInfo[player][HitmanHit] += amount;
				format(string, sizeof(string), ""se" "YELLOW_E"%s(%i) has placed a bounty on %s(%i) for $%s get him!", __GetName(playerid), playerid, __GetName(player), player, ToCurrency(amount));
				SCMToAll(-1, string);
				format(string, sizeof(string), "You´ve placed a bounty on %s(%i) for $%s", __GetName(player), player, ToCurrency(amount));
				SCM(playerid, YELLOW, string);
		    }
		    else if(PlayerInfo[player][HitmanHit] != 0)
		    {
		        PlayerInfo[player][HitmanHit] += amount;
				format(string, sizeof(string), ""se" "YELLOW_E"%s(%i) has placed another bounty on %s(%i) for $%s Total: "red"$%s", __GetName(playerid), playerid, __GetName(player), player, ToCurrency(amount), ToCurrency(PlayerInfo[player][HitmanHit]));
				SCMToAll(-1, string);
				format(string, sizeof(string), "You´ve placed a bounty on %s(%i) for $%s", __GetName(player), player, ToCurrency(amount));
				SCM(playerid, YELLOW, string);
		    }
			PlayerInfo[playerid][tickLastHitman] = tick;
			GivePlayerCash(playerid, -amount);
			format(string, sizeof(string), "~r~-$%s", ToCurrency(amount));
			GameTextForPlayer(playerid, string, 2000, 1);
		}
		else
		{
			SCM(playerid, -1, ""er"You do not have enough money!");
		}
	}
	else
	{
		SCM(playerid, -1, ""er"That player is not connected or yourself");
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
	        return SCM(playerid, NGS_GREEN, "Usage: /sethealth <playerid> <health>");
	    }
	    if(amount > 100) return SCM(playerid, -1, ""er"Do not set it higher than 100");
 		if(IsPlayerAvail(player))
		{
			new string[128];
			if(player != playerid)
			{
				format(string, sizeof(string), "Admin %s has set your health to %f.", __GetName(playerid), amount);
				SCM(player, YELLOW, string);
				format(string, sizeof(string), "You have set %s's health to %f.", __GetName(player), amount);
				SCM(playerid, YELLOW, string);
			}
			else
			{
				format(string, sizeof(string), "You have set your health to %f.", amount);
				SCM(playerid, YELLOW, string);
			}
			SetPlayerHealth(player, amount);
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
	        return SCM(playerid, NGS_GREEN, "Usage: /setcash <playerid> <amount>");
	    }

    	if(amount < 0 || amount > 50000000)
		{
			return SCM(playerid, -1, ""er"$0 - $50,000,000");
		}

		if(IsPlayerAvail(player))
		{
			new string[128];
			if(player != playerid)
			{
				format(string, sizeof(string), "Admin %s has set your cash to $%s.", __GetName(playerid), ToCurrency(amount));
				SCM(player, YELLOW, string);
				format(string, sizeof(string), "You have set %s's cash to $%s.", __GetName(player), ToCurrency(amount));
				SCM(playerid, YELLOW, string);
			}
			else
			{
				format(string, sizeof(string), "You have set your cash to $%s.", ToCurrency(amount));
				SCM(playerid, YELLOW, string);
			}
			SetPlayerCash(player, amount);
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
	        return SCM(playerid, NGS_GREEN, "Usage: /setscore <playerid> <score>");
	    }

    	if(amount < 0 || amount > 10000000)
		{
			return SCM(playerid, -1, ""er"Score: 0 - 10000000");
		}

		if(IsPlayerAvail(player))
		{
			new string[128];
			if(player != playerid)
			{
				format(string, sizeof(string), "Admin %s has set your score to %i.", __GetName(playerid), amount);
				SCM(player, YELLOW, string);
				format(string, sizeof(string), "You set %s's score to %i.", __GetName(player), amount);
				SCM(playerid, YELLOW, string);
			}
			else
			{
				format(string, sizeof(string), "You have set your score to %i.", amount);
				SCM(playerid, YELLOW, string);
			}
			_SetPlayerScore(player, amount);
		}
	 	else
	 	{
		 	SCM(playerid, -1, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
		SCM(playerid, RED, NO_PERM_ENG);
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
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:onduty(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	if(PlayerInfo[playerid][Level] >= 2)
	{
		if(!PlayerInfo[playerid][onduty])
		{
			PlayerInfo[playerid][onduty] = true;
			PlayerInfo[playerid][AdminDutyLabel] = CreateDynamic3DTextLabel("Admin On Duty", ADMIN, 0.0, 0.0, 0.35, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
  			new aonduty[64];
	        format(aonduty, sizeof(aonduty), ""yellow"** "red"Admin %s is now onduty!", __GetName(playerid));
	        SCMToAll(RED, aonduty);
        	SetPlayerHealth(playerid, 99999.0);
			SetPlayerAttachedObject(playerid, 9, 18646, 2, 0.200000, 0.000000, 0.000000, -0.000000, 90.000000, 0.000000, 0.799999, 0.899999, 1.000000);
		}
		else
		{
			SCM(playerid, -1, ""er"You are already onduty");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
        	format(offduty, sizeof(offduty), ""yellow"** "red"Admin %s is now offduty!", __GetName(playerid));
        	SCMToAll(-1, offduty);
        	SetPlayerHealth(playerid, 100.0);
        	RemovePlayerAttachedObject(playerid, 9);
      		if(PlayerInfo[playerid][AdminDutyLabel] != Text3D:-1)
			{
			    DestroyDynamic3DTextLabel(PlayerInfo[playerid][AdminDutyLabel]);
			    PlayerInfo[playerid][AdminDutyLabel] = Text3D:-1;
			}
		}
		else
		{
			SCM(playerid, -1, ""er"You are not onduty");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
			return SCM(playerid, NGS_GREEN, "Usage: /eject <playerid>");
	  	}

	  	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");

		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			return SCM(playerid, -1, ""er"You cannot use this command on this admin");
		}

        if(IsPlayerAvail(player) && gTeam[player] == NORMAL)
		{
			if(IsPlayerInAnyVehicle(player))
			{
			    new	string[128],
					Float:POS[3];

				if(player != playerid)
				{
					format(string, sizeof(string), "Admin %s has ejected you from your vehicle", __GetName(playerid));
					SCM(player, YELLOW, string);
				}
				format(string, sizeof(string), "You have ejected %s from their vehicle", __GetName(player));
				SCM(playerid, YELLOW, string);
    		   	GetPlayerPos(player, POS[0], POS[1], POS[2]);
    		   	SetPlayerPos(player, POS[0], POS[1], POS[2] + 3);
			}
			else
			{
				SCM(playerid, -1, ""er"Player is not in a vehicle");
			}
	    }
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:explode(playerid, params[])
{
	cmd_burn(playerid, params);
	return 1;
}

COMMAND:burn(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /burn <playerid>");
	  	}

	  	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");

		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			SCM(playerid, -1, ""er"You cannot use this command on this admin");
			return 1;
		}
        if(IsPlayerAvail(player))
		{
		    new string[64],
				Float:POS[3];

			format(string, sizeof(string), "You have burnt %s ", __GetName(player));
			SCM(playerid, BLUE, string);
			GetPlayerPos(player, POS[0], POS[1], POS[2]);
			CreateExplosion(POS[0], POS[1], POS[2] + 3, 1, 10);
	    }
		else
		{
			SCM(playerid, -1, ""er"Player is not connected");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:getip(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /ip <playerid>");
	  	}

	  	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");

		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			return SCM(playerid, -1, ""er"You cannot use this command on this admin");
		}
        if(IsPlayerAvail(player))
		{
			new string[64];
			format(string, sizeof(string), "%s's ip is %s", __GetName(player), __GetIP(player));
			SCM(playerid, BLUE, string);
	    }
		else
		{
			SCM(playerid, -1, ""er"Player is not connected");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:kill(playerid, params[])
{
	cmd_spawn(playerid, params);
	return 1;
}

COMMAND:car(playerid, params[])
{
	if(gTeam[playerid] == NORMAL)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 65.0, 1797.3141, -1302.0978, 120.2659) && PlayerInfo[playerid][Level] < 1) return SCM(playerid, -1, ""er"Can´t spawn vehicle at this place!");

		CarSpawner(playerid, 415);
	}
	else
	{
   		SCM(playerid, RED, NOT_AVAIL);
	}
	return 1;
}

COMMAND:id(playerid, params[])
{
	if(!strlen(params))
	{
		SCM(playerid, NGS_GREEN, "Usage: /id <nick/part of nick>");
		return 1;
	}
	new found, string[128], playername[MAX_PLAYER_NAME];
	format(string, sizeof(string), "Searched for: %s ", params);
	SCM(playerid, GREEN, string);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerAvail(i))
		{
	  		GetPlayerName(i, playername, MAX_PLAYER_NAME);
			new namelen = strlen(playername), bool:searched = false;
	    	for(new pos = 0; pos < namelen; pos++)
			{
				if(!searched)
				{
					if(strfind(playername, params, true) == pos)
					{
		                found++;
						format(string, sizeof(string), "%i. %s (ID %i)", found, playername, i);
						SCM(playerid, GREEN, string);
						searched = true;
					}
				}
			}
		}
	}
	if(found == 0) SCM(playerid, -1, ""er"No players have this in their nick");
	return 1;
}

COMMAND:asay(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    extract params -> new string:text[144]; else
	    {
	        return SCM(playerid, NGS_GREEN, "Usage: /asay <message>");
	    }
	    
	    if(strlen(text) > 100 || strlen(text) < 3) return SCM(playerid, -1, ""er"Length: 3-100");

		new string[200];
		format(string, sizeof(string), ""yellow"** "red"Admin %s(%i): %s", __GetName(playerid), playerid, text);
		SCMToAll(-1, string);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:ann(playerid, params[])
{
	cmd_announce(playerid, params);
	return 1;
}

COMMAND:announce(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid))
	{
	    extract params -> new string:text[144]; else
	    {
	        return SCM(playerid, NGS_GREEN, "Usage: /announce <message>");
	    }
	    
	    if(strfind(text, "~", true) != -1) return SCM(playerid, -1, ""er"'~' is not allowed in announce.");
	    if(strfind(text, "#", true) != -1) return SCM(playerid, -1, ""er"'#' is not allowed in announce.");
	    if(strlen(text) > 50 || strlen(text) < 1) return SCM(playerid, -1, ""er"Length 1-50");

		GameTextForAll(text, 4000, 3);
    }
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:ann2(playerid, params[])
{
	cmd_announce2(playerid, params);
	return 1;
}

COMMAND:announce2(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid))
	{
	    extract params -> new string:text[144]; else
	    {
	        return SCM(playerid, NGS_GREEN, "Usage: /announce2 <message>");
	    }

	    if(strlen(text) > 144 || strlen(text) < 1) return SCM(playerid, -1, ""er"Length 1-50");

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(IsPlayerAvail(i))
		    {
				ShowPlayerDialog(i, ANN2_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Admin Announcement", text, "OK", "");
			}
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:spectators(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1)
	{
	    new Iterator:speccers<250>;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == SPEC)
		    {
		        Iter_Add(speccers, i);
		    }
		}

		if(Iter_Count(speccers) == 0)
		{
			return SendInfo(playerid, "~h~~y~No spectators found!", 2100);
		}

		new string[144];
		format(string, sizeof(string), ""se" Displaying a list of %i admin(s)/VIP(s) spectating:", Iter_Count(speccers));
		SCM(playerid, -1, string);

        for(new i = Iter_First(speccers), count = 0; i != Iter_End(speccers); i = Iter_Next(speccers, i), ++count)
        {
            format(string, sizeof(string), " %i. %s(%i) spectating %s(%i)", count + 1, __GetName(i), i, __GetName(PlayerInfo[i][SpecID]), PlayerInfo[i][SpecID]);
            SCM(playerid, -1, string);
        }
    }
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return true;
}

COMMAND:jetpack(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	if(PlayerInfo[playerid][VIP] != 1) return SCM(playerid, RED, NO_PERM_ENG);
    if(GetPVarInt(playerid, "doingStunt") != 0) return SCM(playerid, -1, ""er"You can't use this command now");

	SendInfo(playerid, "~h~~y~Jetpack spawned!", 2000);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}

COMMAND:gotomyhouse(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
    if(PlayerInfo[playerid][Houses] == 0) return  SCM(playerid, -1, ""er"You got no house!");

 	new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
        if(!strcmp(__GetName(playerid), HouseInfo[i][Owner], true) && HouseInfo[i][sold] == 1)
        {
            found = true;
   			SetPlayerPos(playerid, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z]);
   			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
   			SetPVarInt(playerid, "doingStunt", 0);
            break;
        }
	}
    if(!found) SCM(playerid, -1, ""er"House not found");
	return 1;
}

COMMAND:gotomybusiness(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
    if(PlayerInfo[playerid][Props] == 0) return  SCM(playerid, -1, ""er"You got no business!");

 	new bool:found = false;
	for(new i = 0; i < propid; i++)
	{
        if(!strcmp(__GetName(playerid), PropInfo[i][Owner], true) && PropInfo[i][sold] == 1)
        {
            found = true;
   			SetPlayerPos(playerid, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z]);
   			PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
   			SetPVarInt(playerid, "doingStunt", 0);
            break;
        }
	}
    if(!found) SCM(playerid, -1, ""er"Business not found");
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

COMMAND:goto(playerid, params[])
{
	cmd_go(playerid, params);
	return 1;
}

COMMAND:go(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

	if((PlayerInfo[playerid][Level] == 0))
	{
	    if(gTeam[playerid] == NORMAL)
	    {
		    new player;
		 	if(sscanf(params, "u", player))
			{
				return SCM(playerid, NGS_GREEN, "Usage: /go <playerid>");
		  	}
            if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
  			if(Iter_Contains(PlayerIgnore[player], playerid))
			{
			    return SCM(playerid, -1, ""er"This player ignores you");
			}
			if(!IsPlayerNPC(player))
			{
				if(!IsPlayerAvail(player)) return SCM(playerid, -1, ""er"Player is not avialable");
			}
			if(player == playerid) return SCM(playerid, -1, ""er"This will not work");
			if(gTeam[player] != NORMAL) return SCM(playerid, -1, ""er"Player is in a minigame");
			if(PlayerInfo[player][Wanteds] != 0) return SCM(playerid, -1, ""er"This player has wanteds");
			if(PlayerInfo[player][Level] != 0) return SCM(playerid, -1, ""er"You can´t teleport to admins");

			new Float:POS[3],
				string[128];

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
			SCM(playerid, BLUE, string);
			format(string, sizeof(string), "%s has teleported to you!", __GetName(playerid));
			SCM(player, BLUE, string);
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
		}
		else
		{
		    SCM(playerid, RED, "You need to be in normal world");
		}
	}
	else if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid))
	{
	    new player;
	 	if(sscanf(params, "u", player))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /go <playerid>");
	  	}
	  	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
		if(!IsPlayerNPC(player))
		{
			if(!IsPlayerAvail(player)) return SCM(playerid, -1, ""er"Player is not avialable");
		}
		if(gTeam[player] != NORMAL) return SCM(playerid, -1, ""er"Player is in a minigame");
	 	if(player != INVALID_PLAYER_ID && player != playerid)
	 	{
			new Float:POS[3],
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
			SCM(playerid, BLUE, string);
			SetPVarInt(playerid, "doingStunt", 0);
			return 1;
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or is yourself");
		}
	}
	return 1;
}

COMMAND:cuff(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /cuff <playerid>");
	  	}
	  	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
        SetPlayerSpecialAction(player, SPECIAL_ACTION_CUFFED);
        
        new str[255];
    	format(str, sizeof(str), ""se" "GREY_E"You have cuffed %s(%i).", __GetName(player), player);
		SCM(playerid, COLOR_STEELBLUE, str);
		SCM(playerid, COLOR_STEELBLUE, ">> "GREY2_E"Type /uncuff to uncuff the player.");
		format(str, sizeof(str), ""se" "GREY_E"%s(%i) has cuffed you.", __GetName(playerid), playerid);
		SCM(player, COLOR_STEELBLUE, str);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:uncuff(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 2)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /uncuff <playerid>");
	  	}
        if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
        SetPlayerSpecialAction(player, SPECIAL_ACTION_NONE);
        
        new str[255];
		format(str, sizeof(str), ""se" "GREY_E"You have uncuffed %s(%i).", __GetName(player), player);
		SCM(playerid, COLOR_STEELBLUE, str);
		format(str, sizeof(str), ""se" "GREY_E"%s(%i) has uncuffed you.", __GetName(playerid), playerid);
		SCM(player, COLOR_STEELBLUE, str);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
			return SCM(playerid, NGS_GREEN, "Usage: /get <playerid>");
	  	}
	  	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
	  	if(!IsPlayerConnected(player)) return SCM(playerid, -1, ""er"Player is not connected!");
		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			return SCM(playerid, -1, ""er"You cannot use this command on this admin");
		}
	 	if(IsPlayerAvail(player) && player != playerid && gTeam[player] == NORMAL)
	 	{
			new Float:POS[3];

			GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
			SetPlayerInterior(player, GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player, GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player) == PLAYER_STATE_DRIVER)
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
			new string[128];
			format(string, sizeof(string), "You have been teleported to Admin %s's location", __GetName(playerid));
			SCM(player, BLUE, string);
			format(string, sizeof(string), "You have teleported %s to your location", __GetName(player));
			SCM(playerid, BLUE, string);
			return 1;
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or is yourself");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:warn(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1)
	{
 		new player, reason[144];
		if(sscanf(params, "rs[144]", player, reason))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /warn <playerid> <reason>");
		}

		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL)
		{
	 		return SCM(playerid, -1, ""er"You cannot use this command on this admin");
		}
	 	if(IsPlayerAvail(player) && player != playerid)
	 	{
	 	    new string[144];
			PlayerInfo[player][Warnings]++;
			if(PlayerInfo[player][Warnings] == MAX_WARNINGS)
			{
				format(string, sizeof(string), ""yellow"** "red"%s has been kicked by console. [Reason: %s] [Warning: %i/%i]", __GetName(player), reason, PlayerInfo[player][Warnings], MAX_WARNINGS);
				SCMToAll(GREY, string);
				print(string);
				Kick(player);
			}
			else
			{
				format(string, sizeof(string), ""yellow"** "red"Admin %s has given %s a kick warning. [Reason: %s] [Warning: %i/%i]", __GetName(playerid), __GetName(player), reason, PlayerInfo[player][Warnings], MAX_WARNINGS);
				SCMToAll(YELLOW, string);
			}
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or invalid");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:mkick(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3)
	{
		new player;
		if(sscanf(params, "r", player))
		{
	        return SCM(playerid, NGS_GREEN, "Usage: /mkick <playerid>");
		}
		if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Player isn't in any minigame");
		
		if(gTeam[player] == NORMAL)
		{
		    return SCM(playerid, -1, ""er"Player isn't in any minigame");
		}
		if(cmd_exit(player, "") != 0)
		{
			SCM(player, NGS_BLUE, "You have been kicked out of the minigame by an admin");
	        SCM(playerid, NGS_BLUE, "Player has been kicked out of the minigame");
		}
		else
		{
		    SCM(playerid, NGS_BLUE, "Can't kick the player out of the minigame");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:ping(playerid, params[])
{
	new player;
	if(sscanf(params, "r", player))
	{
        return SCM(playerid, NGS_GREEN, "Usage: /ping <playerid>");
	}
	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid playerid");
	
	new string[128];
	format(string, sizeof(string), ""ngs_green"%s´s(%i) ping is %i", __GetName(player), player, GetPlayerPing(player));
	SCM(playerid, -1, string);
	return 1;
}

COMMAND:caps(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
 		new player;
		if(sscanf(params, "r", player))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /caps <playerid>");
		}
		
		if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
		
		new string[144];
		if(PlayerInfo[player][bCaps])
		{
			format(string, sizeof(string), ""yellow"** "red"Admin %s has disabled %s´s Caps", __GetName(playerid), __GetName(player));
			SCMToAll(YELLOW, string);
			PlayerInfo[player][bCaps] = false;
		}
		else
		{
			format(string, sizeof(string), ""yellow"** "red"Admin %s has re-enabled %s´s Caps", __GetName(playerid), __GetName(player));
			SCMToAll(YELLOW, string);
			PlayerInfo[player][bCaps] = true;
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:day(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    new str[144];
	    SetWorldTime(12);
	    SetWeather(1);
	    format(str, sizeof(str), ""LB_E"Administrator {%06x}%s(%i) "LB_E"has changed the time to: "YELLOW_E"day time", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid);
		SendClientMessageToAll(COLOR_STEELBLUE, str);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return true;
}

COMMAND:dawn(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    new str[144];
		SetWorldTime(6);
		SetWeather(1);
		format(str, sizeof(str), ""LB_E"Administrator {%06x}%s(%i) "LB_E"has changed the time to: "YELLOW_E"Dawn", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid);
		SendClientMessageToAll(COLOR_STEELBLUE, str);
 	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;

}

COMMAND:night(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    new str[144];
	    SetWorldTime(0);
	    SetWeather(17);
	    format(str, sizeof(str), ""LB_E"Administrator {%06x}%s(%i) "LB_E"has changed the time to: "YELLOW_E"night time", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid);
		SendClientMessageToAll(COLOR_STEELBLUE, str);
 	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
   	return true;
}

COMMAND:kick(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
 		new player, reason[144];
		if(sscanf(params, "rs[144]", player, reason))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /kick <playerid> <reason>");
		}
		if(isnull(reason)) return SCM(playerid, NGS_GREEN, "Usage: /kick <playerid> <reason>");
		if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
		{
		    new string[144];
			format(string, sizeof(string), ""yellow"** "red"%s has been kicked by Admin %s [Reason: %s]", __GetName(player), __GetName(playerid), reason);
			SCMToAll(YELLOW, string);
			print(string);
			KickEx(player);
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or is yourself or is the highest level admin");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:lightfw(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	if(PlayerInfo[playerid][Level] >= 1)
	{
		new distance;
	    if(AllowedFirework[DrawDistance] == 0) distance = 15;
	    if(AllowedFirework[DrawDistance] == 1) distance = 22;
	    if(AllowedFirework[DrawDistance] == 2) distance = 30;
		new fwtype;
	    if(sscanf(params, "i", fwtype))
		{
	        SendClientMessage(playerid, NGS_GREEN, "Usage: /lightfw <1-8>");
	        return 1;
	    }
		switch(fwtype)
	 	{
	  		case 1:
			{
				if(firecrackertime[playerid] == 0)
			    {
			        new Float:X, Float:Y,Float:Z;
			        firecrackertime[playerid] = 1;
					GetPlayerPos(playerid,X,Y,Z);
					GetPosInFrontOfPlayer(playerid, X,Y, 8);
					Firecracker[playerid] = CreateObject(1672, X,Y,(Z-0.9), 0, 0, 0);
					SetTimerEx("FirecrackerTime", (2000+(random(3000))), 0, "i", playerid);
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_RED, "ERROR: You already threw a firecracker.");
			}
			case 2:
			{
				if(firecrackerroll[playerid] == 0)
			    {
			        new Float:X, Float:Y,Float:Z;
			        firecrackerroll[playerid] = 1;
					GetPlayerPos(playerid,X,Y,Z);
					GetPosInFrontOfPlayer(playerid, X,Y, 8);
					FireCrackerRoll[playerid] = CreateRoll(playerid,X,Y,(Z-1.00));
					RollStartX[playerid] = X;
					RollStartY[playerid] = Y;
					RollStartZ[playerid] = (Z-1.00);
					CrackerRollSmoke[playerid] = CreateObject(2780, X, Y, (Z-5.00), 0, 0, 0);
					SetTimerEx("CrackerRollTime", (2000+(random(3000))), 0, "i", playerid);
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_RED, "ERROR: You already placed a firecracker roll.");
			}
			case 3:
			{
				if(firerockettime[playerid] == 0)
			    {
			        new Float:X, Float:Y,Float:Z;
			        firerockettime[playerid] = 1;
					GetPlayerPos(playerid,X,Y,Z);
					GetPosInFrontOfPlayer(playerid, X,Y, distance);
					Firerocket[playerid] = CreateObject(354, X,Y,(Z), 0, 0, 0);
					rocketsmoke[playerid] = CreateObject(2780, X,Y,(Z), 0, 0, 0);
					MoveObject(Firerocket[playerid], X, Y, Z+30, 10);
					MoveObject(rocketsmoke[playerid], X, Y, Z+30, 10);
					SetTimerEx("FirerocketTime", 3000, 0, "i", playerid);
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_RED, "ERROR: You already lit a firerocket.");
			}
			case 4:
			{
				if(firerockettime[playerid] == 0)
				{
				    new Float:X, Float:Y,Float:Z;
				    firerockettime[playerid] = 2;
					GetPlayerPos(playerid,X,Y,Z);
					GetPosInFrontOfPlayer(playerid, X,Y, distance);
					Firerocket[playerid] = CreateObject(354, X,Y,(Z), 0, 0, 0);
					rocketsmoke[playerid] = CreateObject(2780, X,Y,(Z), 0, 0, 0);
					MoveObject(Firerocket[playerid], X, Y, Z+50, 15);
					MoveObject(rocketsmoke[playerid], X, Y, Z+50, 15);
					SetTimerEx("FirerocketTime", 3000, 0, "i", playerid);
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_RED, "ERROR: You already lit a firerocket.");
			}
			case 5:
			{
				if(Fountain1Time[playerid] == 0 && Fountain2Time[playerid] == 0 && Fountain3Time[playerid] == 0)
				{
				    new Float:X, Float:Y,Float:Z;
				    Fountain1Time[playerid] = 1;
					GetPlayerPos(playerid,X,Y,Z);
					GetPosInFrontOfPlayer(playerid, X,Y, 15);
					FTX[playerid] = X;
					FTY[playerid] = Y;
					FTZ[playerid] = (Z-1.0);
					Fountain[playerid] = CreateObject(354, X,Y,(Z-1.0), 0, 0, 0);
					FountainSmoke[playerid] = CreateObject(2780, X,Y,(Z-1.0), 0, 0, 0);
					SetTimerEx("FountainTimer", 3000, 0, "i", playerid);
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_RED, "ERROR: You already lit a Firework Fountain.");
			}
			case 6:
			{
				if(Fountain1Time[playerid] == 0 && Fountain2Time[playerid] == 0 && Fountain3Time[playerid] == 0)
				{
				    new Float:X, Float:Y,Float:Z;
				    Fountain2Time[playerid] = 1;
					GetPlayerPos(playerid,X,Y,Z);
					GetPosInFrontOfPlayer(playerid, X,Y, 15);
					FTX[playerid] = X;
					FTY[playerid] = Y;
					FTZ[playerid] = (Z-1.0);
					Fountain[playerid] = CreateObject(354, X,Y,(Z-1.0), 0, 0, 0);
					FountainSmoke[playerid] = CreateObject(2780, X,Y,(Z-1.0), 0, 0, 0);
					SetTimerEx("FountainTimer", 3000, 0, "i", playerid);
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_RED, "ERROR: You already lit a Firework Fountain.");
			}
			case 7:
			{
				if(Fountain1Time[playerid] == 0 && Fountain2Time[playerid] == 0 && Fountain3Time[playerid] == 0)
				{
				    new Float:X, Float:Y,Float:Z;
				    Fountain3Time[playerid] = 1;
					GetPlayerPos(playerid,X,Y,Z);
					GetPosInFrontOfPlayer(playerid, X,Y, 15);
					FTX[playerid] = X;
					FTY[playerid] = Y;
					FTZ[playerid] = (Z-1.0);
					Fountain[playerid] = CreateObject(354, X,Y,(Z-1.0), 0, 0, 0);
					FountainSmoke[playerid] = CreateObject(2780, X,Y,(Z-1.0), 0, 0, 0);
					SetTimerEx("FountainTimer", 3000, 0, "i", playerid);
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_RED, "ERROR: You already lit a Firework Fountain.");
			}
			case 8:
			{
				if(RocketBoxTime[playerid] == 0)
				{
				    new Float:X, Float:Y,Float:Z;
				    RocketBoxTime[playerid] = 1;
					GetPlayerPos(playerid,X,Y,Z);
					GetPosInFrontOfPlayer(playerid, X,Y, distance);
					RBX[playerid] = X;
					RBY[playerid] = Y;
					RBZ[playerid] = (Z-1.0);
					RocketBox[playerid] = CreateObject(354, X,Y,(Z-1.0), 0, 0, 0);
					RocketBoxSmoke[playerid] = CreateObject(2780, X,Y,(Z-1.0), 0, 0, 0);
					SetTimerEx("RocketBoxTimer", 3000, 0, "i", playerid);
					return 1;
				}
				else return SendClientMessage(playerid, COLOR_RED, "ERROR: You already lit a Firework RocketBox.");
			}
			default: SendClientMessage(playerid, COLOR_WHITE, "No.");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:mute(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
 		new player, time, reason[144];
		if(sscanf(params, "rds[144]", player, time, reason))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /mute <playerid> <seconds> <reason>");
		}
		if(PlayerInfo[player][Muted])
		{
			return SCM(playerid, -1, ""er"This player is already muted");
		}

		if(time < 1) return SCM(playerid, -1, ""er"seconds > 0 bitch please :p");

		if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
		{
		    new string[144];
  			PlayerInfo[player][Muted] = true;
	    	format(string, sizeof(string), ""yellow"** "red"%s has been muted by Admin %s for %i seconds [Reason: %s]", __GetName(player), __GetName(playerid), time, reason);
            SCMToAll(YELLOW, string);
            print(string);
			PlayerInfo[player][MuteTimer] = SetTimerEx("unmute", time * 1000, false, "i", player);
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or is yourself or is the highest level admin");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:unmute(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
 		new player;
		if(sscanf(params, "r", player))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /unmute <playerid>");
		}

		if(!PlayerInfo[player][Muted])
		{
			return SCM(playerid, -1, ""er"This player is not muted");
		}
		if(IsPlayerAvail(player) && player != playerid)
		{
			PlayerInfo[player][Muted] = false;
			KillTimer(PlayerInfo[player][MuteTimer]);
			SCM(player, NGS_BLUE, "You have been unmuted!");
			new string[128];
			format(string, sizeof(string), ""yellow"** "red"%s has been unmuted by Admin %s", __GetName(player), __GetName(playerid));
			SCMToAll(RED, string);
		}
		else
		{
            SCM(playerid, -1, ""er"Player isn´t connected or invalid!");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:updateloginsound(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
		return SCM(playerid, RED, NO_PERM_ENG);
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
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastGCreate] + COOLDOWN_CMD_GCREATE) >= tick)
	{
		return SCM(playerid, -1, ""er"Please wait a bit before using this command again!");
	}

	if(PlayerInfo[playerid][GangID] != 0) return SCM(playerid, -1, ""er"You are already in a gang");
	if(GetPlayerCash(playerid) < 1000000) return SCM(playerid, -1, ""er"You need at least "ngs_blue"$1,000,000 "white"for creating a gang!");
 	if(_GetPlayerScore(playerid) < 1000) return SCM(playerid, -1, ""er"You need at least "ngs_blue"1,000 Score "white"for creating a gang!");

	new ntmp[144],
	    ttmp[144];

	if(sscanf(params, "s[144]s[144]", ntmp, ttmp))
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /gcreate <gang-name> <gang-tag>");
	}
	if(strlen(ntmp) > MAX_GANG_NAME || strlen(ntmp) < MIN_GANG_NAME || isnull(ntmp))
	{
	    CancelGangCreation(playerid);
	    return SCM(playerid, -1, ""er"Gang name length: 4 - 20 characters");
	}
	if(strlen(ttmp) > 4 || strlen(ttmp) < 2 || isnull(ttmp))
	{
	    CancelGangCreation(playerid);
	    return SCM(playerid, -1, ""er"Gang tag length: 2 - 4 characters");
	}


	if(!strcmp(__GetName(playerid), ntmp, true))
	{
	    CancelGangCreation(playerid);
	    return SCM(playerid, -1, ""er"Dont name your gang as your nick");
	}
    if(strfind(ntmp, " ", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"Spaces are not allowed");
	}
    if(strfind(ntmp, "-", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"- ist not allowed");
	}
    if(strfind(ntmp, "|", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"| ist not allowed");
	}
    if(strfind(ntmp, "@", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"@ ist not allowed");
	}
    if(strfind(ntmp, "*", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"* ist not allowed");
	}
    if(strfind(ntmp, "'", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"' ist not allowed");
	}
    if((strfind(ntmp, "`", false) != -1) || (strfind(ntmp, "´", false) != -1))
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"`´ ist not allowed");
	}
    if(strfind(ntmp, "admin", false) != -1)
	{
	    CancelGangCreation(playerid);
		return SCM(playerid, -1, ""er"Not possible");
	}
	mysql_real_escape_string(ntmp, PlayerInfo[playerid][GangName], g_SQL_handle, 21);
	/*
	GANG NAME IS OK
	*/

	if(!strcmp(__GetName(playerid), ttmp, true))
	{
	    CancelGangCreation(playerid);
	    return SCM(playerid, -1, ""er"Dont tag your gang as your nick");
	}
    if(strfind(ttmp, " ", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"Spaces are not allowed");
	}
    if(strfind(ttmp, "-", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"- ist not allowed");
	}
    if(strfind(ttmp, "*", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"* ist not allowed");
	}
    if(strfind(ttmp, "|", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"| ist not allowed");
	}
    if(strfind(ttmp, "@", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"@ ist not allowed");
	}
    if(strfind(ttmp, "'", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"' ist not allowed");
	}
    if(strfind(ttmp, "`", false) != -1 || strfind(ttmp, "´", false) != -1)
	{
        CancelGangCreation(playerid);
        return SCM(playerid, -1, ""er"`´ ist not allowed");
	}
    if(strfind(ttmp, "admin", false) != -1)
	{
	    CancelGangCreation(playerid);
		return SCM(playerid, -1, ""er"Not possible");
	}
	if((strfind(ttmp, "[", true) != -1) || (strfind(ttmp, "]", true) != -1))
	{
	 	CancelGangCreation(playerid);
		return SCM(playerid, -1, ""er"Do not add [ or ]");
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
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastGInvite] + COOLDOWN_CMD_GINVITE) >= tick) return SCM(playerid, -1, ""er"Please wait a bit before inviting again!");
	if(PlayerInfo[playerid][GangID] == 0) return SCM(playerid, -1, ""er"You aren't in any gang!");
	if(PlayerInfo[playerid][GangPosition] < GANG_POS_ADVISOR) return SCM(playerid, -1, ""er"You you need to be at least advisor");

	new player;
	if(sscanf(params, "r", player))
	{
        return SCM(playerid, NGS_GREEN, "Usage: /ginvite <playerid>");
	}

	new Float:pPOS[3];
	GetPlayerPos(player, pPOS[0], pPOS[1], pPOS[2]);
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, pPOS[0], pPOS[1], pPOS[2]))
	{
	    return SCM(playerid, -1, ""er"You need to be near that player!");
	}

    if(player == playerid) return SCM(playerid, -1, ""er"You can´t invite yourself");
	if(IsPlayerNPC(player)) return SCM(playerid, -1, ""er"You can´t invite NPCS");
    if(PlayerInfo[player][GangID] != 0) return SCM(playerid, -1, ""er"Player is already in a gang");

    if(PlayerInfo[player][gInvite]) return SCM(playerid, -1, ""er"Player has been already invited by someone else!");
    if(!IsPlayerAvail(player)) return SCM(playerid, -1, ""er"Player is not available!");

    PlayerInfo[player][TmpGangID] = PlayerInfo[playerid][GangID];
    PlayerInfo[player][gInvite] = true;
    PlayerInfo[player][GangID] = 0;
    PlayerInfo[player][GangPosition] = GANG_POS_NONE;
    strmid(PlayerInfo[player][GangName], PlayerInfo[playerid][GangName], 0, 21, 21);
    strmid(PlayerInfo[player][GangTag], PlayerInfo[playerid][GangTag], 0, 5, 5);
    
  	new string[255];

	format(string, sizeof(string), ""gang_sign" %s(%i) invited you to: %s", __GetName(playerid), playerid, PlayerInfo[playerid][GangName]);
	SCM(player, GREY, string);

	format(string, sizeof(string), ""white"» Invitation has been sent to "yellow"%s(%i)", __GetName(player), player);
	SCM(playerid, GREEN, string);

	PlayerInfo[playerid][tickLastGInvite] = tick;
	return 1;
}

COMMAND:gdeny(playerid, params[])
{
    if(PlayerInfo[playerid][GangID] != 0) return SCM(playerid, -1, ""er"You are already in a gang!");
    if(!PlayerInfo[playerid][gInvite]) return SCM(playerid, -1, ""er"You haven´t been invited!");
    PlayerInfo[playerid][TmpGangID] = 0;
    PlayerInfo[playerid][GangID] = 0;
    PlayerInfo[playerid][GangPosition] = GANG_POS_NONE;
    PlayerInfo[playerid][gInvite] = false;
    PlayerInfo[playerid][GangName][0] = '\0';
    PlayerInfo[playerid][GangTag][0] = '\0';
    SCM(playerid, GREEN, "The invitation has been rejected");
	return 1;
}

COMMAND:gclose(playerid, params[])
{
    if(PlayerInfo[playerid][GangID] == 0) return SCM(playerid, -1, ""er"You aren´t in any gang!");
    if(PlayerInfo[playerid][GangPosition] != GANG_POS_MAIN_LEADER) return SCM(playerid, -1, ""er"You have to be the gang main leader!");

	ShowDialog(playerid, CLOSE_GANG_DIALOG);
	return 1;
}

COMMAND:gjoin(playerid, params[])
{
    if(PlayerInfo[playerid][GangID] != 0) return SCM(playerid, -1, ""er"You are already in a gang!");
    if(!PlayerInfo[playerid][gInvite]) return SCM(playerid, -1, ""er"You did not get any invitations!");

	new string[128];

	PlayerInfo[playerid][gInvite] = false;
	PlayerInfo[playerid][GangPosition] = GANG_POS_JUNIOR_MEMBER;
	PlayerInfo[playerid][GangID] = PlayerInfo[playerid][TmpGangID];
	PlayerInfo[playerid][TmpGangID] = 0;

    MySQL_SavePlayer(playerid);

	format(string, sizeof(string), ""gang_sign" %s has joined the gang!", __GetName(playerid));
	GangMSG(PlayerInfo[playerid][GangID], string);

	format(string, sizeof(string), ""gang_sign" You joined the gang "yellow"%s"white"!", PlayerInfo[playerid][GangName]);
	SCM(playerid, -1, string);

	if(PlayerInfo[playerid][GangLabel] != Text3D:-1)
	{
	    DestroyDynamic3DTextLabel(PlayerInfo[playerid][GangLabel]);
		PlayerInfo[playerid][GangLabel] = Text3D:-1;
	}
	
	ShowPlayerDialog(playerid, 5004, DIALOG_STYLE_MSGBOX, ""se" - Gang joined!", ""white"You can now use these commands:\n\n"dl"/gmenu\n\nUse "ngs_blue"! "white"to talk in your gang chat", "OK", "");
	
	format(string, sizeof(string), ""ngs_blue"Gang:"white" %s", PlayerInfo[playerid][GangName]);
	PlayerInfo[playerid][GangLabel] = CreateDynamic3DTextLabel(string, -1, 0.0, 0.0, 0.5, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
 	return 1;
}

COMMAND:gmenu(playerid, params[])
{
    if(PlayerInfo[playerid][GangID] == 0) return SCM(playerid, -1, ""er"You aren´t in any gang!");

	ShowDialog(playerid, GMENU_DIALOG);
	return 1;
}

COMMAND:gleave(playerid, params[])
{
    if(PlayerInfo[playerid][GangID] == 0) return SCM(playerid, -1, ""er"You aren´t in any gang");
    if(PlayerInfo[playerid][GangPosition] == GANG_POS_MAIN_LEADER) return SCM(playerid, -1, ""er"You can't leave a gang as main leader");

    new string[128];
		
	format(string, sizeof(string), ""gang_sign" %s(%i) has left the gang", __GetName(playerid), playerid);
    GangMSG(PlayerInfo[playerid][GangID], string);
    SCM(playerid, -1, ""gang_sign" You've left your gang!");

    PlayerInfo[playerid][GangID] = 0;
    PlayerInfo[playerid][GangName][0] = '\0';
    PlayerInfo[playerid][GangTag][0] = '\0';
 	PlayerInfo[playerid][GangPosition] = GANG_POS_NONE;

    MySQL_SavePlayer(playerid);

	if(PlayerInfo[playerid][GangLabel] != Text3D:-1)
	{
	    DestroyDynamic3DTextLabel(PlayerInfo[playerid][GangLabel]);
		PlayerInfo[playerid][GangLabel] = Text3D:-1;
	}
	return 1;
}

COMMAND:gsetrank(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	if(PlayerInfo[playerid][GangID] == 0) return SCM(playerid, -1, ""er"You aren´t in any gang");
    if(PlayerInfo[playerid][GangPosition] < GANG_POS_LEADER) return SCM(playerid, -1, ""er"You have to be at least the gang leader to set ranks");
    
    ShowDialog(playerid, GANG_SET_RANK_DIALOG);
	return 1;
}

COMMAND:gkick(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastGKick] + COOLDOWN_CMD_GKICK) >= tick) return SCM(playerid, -1, ""er"Please wait a bit before kicking again!");

    if(PlayerInfo[playerid][GangID] == 0) return SCM(playerid, -1, ""er"You aren´t in any gang");
	if(PlayerInfo[playerid][GangPosition] != GANG_POS_MAIN_LEADER) return SCM(playerid, -1, ""er"You have to be the gang leader to uninvite players");

	ShowDialog(playerid, GANG_KICK_DIALOG);
	
	PlayerInfo[playerid][tickLastGKick] = tick;
	return 1;
}

COMMAND:ipban(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3)
	{
	    new player, reason[144];
	    if(sscanf(params, "rs[144]", player, reason))
	    {
	        return SCM(playerid, NGS_GREEN, "Usage: /ipban <playerid> <reason>");
	    }
		if(strlen(reason) > 50) return SCM(playerid, -1, ""er"Too long reason");
	    if(player == playerid) return SCM(playerid, -1, ""er"Fail :p");
        if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
	  	if(isnull(reason) || strlen(reason) < 2) return SCM(playerid, NGS_GREEN, "Usage: /ban <playerid> <reason>");
	  	if(IsPlayerNPC(player)) return SCM(playerid, -1, ""er"Invalid player!");

	    if(strfind(reason, "-", false) != -1)
		{
	        return SCM(playerid, -1, ""er"- ist not allowed");
		}
	    if(strfind(reason, "|", false) != -1)
		{
	        return SCM(playerid, -1, ""er"| ist not allowed");
		}
	    if(strfind(reason, "@", false) != -1)
		{
	        return SCM(playerid, -1, ""er"@ ist not allowed");
		}
	    if(strfind(reason, "*", false) != -1)
		{
	        return SCM(playerid, -1, ""er"* ist not allowed");
		}
	    if(strfind(reason, "'", false) != -1)
		{
	        return SCM(playerid, -1, ""er"' ist not allowed");
		}
	    if((strfind(reason, "`", false) != -1) || (strfind(reason, "´", false) != -1))
		{
	        return SCM(playerid, -1, ""er"`´ ist not allowed");
		}

	  	if(PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
	  	{
		 	if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
			{
				new string[255];

	   			MySQL_CreateBan(__GetName(player), __GetName(playerid), reason);
				MySQL_BanIP(__GetIP(player));

                if(PlayerInfo[player][Houses] > 0)
                {
                    new bool:found = false;
					for(new i = 0; i < houseid; i++)
					{
	    				if(strcmp(__GetName(player), HouseInfo[i][Owner])) continue;
						found = true;

                        strmid(HouseInfo[i][Owner], "ForSale", 0, 25, 25);
					    HouseInfo[i][sold] = 0;
					    HouseInfo[i][locked] = 1;
					    HouseInfo[i][date] = 0;

					    format(string, sizeof(string), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
					    UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, string);
					    DestroyDynamicMapIcon(HouseInfo[i][iconid]);
					    DestroyDynamicPickup(HouseInfo[i][pickid]);
					    HouseInfo[i][iconid] = CreateDynamicMapIcon(HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], 31, 1, -1, -1, -1, 100.0);
					    HouseInfo[i][pickid] = CreateDynamicPickup(1273, 1, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], -1, -1, -1, 30.0);
					    MySQL_SaveHouse(i);
					    break;
					}
					if(found)
					{
						PlayerInfo[player][Houses]--;
					}
                }

                if(PlayerInfo[player][Props] > 0)
                {
                    new bool:found = false;
					for(new i = 0; i < propid; i++)
					{
	    				if(strcmp(__GetName(player), PropInfo[i][Owner])) continue;
						found = true;

                        strmid(PropInfo[i][Owner], "ForSale", 0, 25, 25);
					    PropInfo[i][sold] = 0;
					    PropInfo[i][date] = 0;

					    format(string, sizeof(string), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
					    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, string);
					    DestroyDynamicMapIcon(PropInfo[i][iconid]);
					    PropInfo[i][iconid] = CreateDynamicMapIcon(PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z], 52, 1, -1, -1, -1, 100.0);
					    MySQL_SaveProp(i);
					    break;
					}
					if(found)
					{
						PlayerInfo[player][Props]--;
						PlayerInfo[player][PropEarnings] = 0;
					}
                }

				format(string, sizeof(string), ""yellow"** "red"%s has been banned by Admin %s [Reason: %s]", __GetName(player), __GetName(playerid), reason);
				SCMToAll(YELLOW, string);
				print(string);

	    		format(string, sizeof(string), ""red"You have been banned!"white"\n\nAdmin: \t\t%s\nReason: \t\t%s\n\nIf you think that you have been banned wrongly,\nwrite a ban appeal on forum.stunt-evolution.net", __GetName(playerid), reason);
	    		ShowPlayerDialog(player, BAN_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Notice", string, "OK", "");
	    		KickEx(player);
	    		PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0);
				return 1;
			}
			else
			{
				SCM(playerid, -1, ""er"Player is not connected or is yourself or is the highest level admin");
			}
		}
		else
		{
		    new warnstring[128];
		    format(warnstring, sizeof(warnstring), "OMGLOL: %s just tried to ban you with reason: %s", __GetName(playerid), reason);
		    SCM(player, RED, warnstring);
		    SCM(playerid, RED, "I hope that was a joke");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:ban(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 2)
	{
	    new player, reason[144];
	    if(sscanf(params, "rs[144]", player, reason))
	    {
	        return SCM(playerid, NGS_GREEN, "Usage: /ban <playerid> <reason>");
	    }
		if(strlen(reason) > 50) return SCM(playerid, -1, ""er"Too long reason");
	    if(player == playerid) return SCM(playerid, -1, ""er"Fail :p");
        if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
	  	if(isnull(reason) || strlen(reason) < 2) return SCM(playerid, NGS_GREEN, "Usage: /ban <playerid> <reason>");
	  	if(IsPlayerNPC(player)) return SCM(playerid, -1, ""er"Invalid player!");

	    if(strfind(reason, "-", false) != -1)
		{
	        return SCM(playerid, -1, ""er"- ist not allowed");
		}
	    if(strfind(reason, "|", false) != -1)
		{
	        return SCM(playerid, -1, ""er"| ist not allowed");
		}
	    if(strfind(reason, "@", false) != -1)
		{
	        return SCM(playerid, -1, ""er"@ ist not allowed");
		}
	    if(strfind(reason, "*", false) != -1)
		{
	        return SCM(playerid, -1, ""er"* ist not allowed");
		}
	    if(strfind(reason, "'", false) != -1)
		{
	        return SCM(playerid, -1, ""er"' ist not allowed");
		}
	    if((strfind(reason, "`", false) != -1) || (strfind(reason, "´", false) != -1))
		{
	        return SCM(playerid, -1, ""er"`´ ist not allowed");
		}

	  	if(PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
	  	{
		 	if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] != MAX_ADMIN_LEVEL)
			{
				new string[255];

	   			MySQL_CreateBan(__GetName(player), __GetName(playerid), reason);

                if(PlayerInfo[player][Houses] > 0)
                {
                    new bool:found = false;
					for(new i = 0; i < houseid; i++)
					{
	    				if(strcmp(__GetName(player), HouseInfo[i][Owner])) continue;
						found = true;

                        strmid(HouseInfo[i][Owner], "ForSale", 0, 25, 25);
					    HouseInfo[i][sold] = 0;
					    HouseInfo[i][locked] = 1;
					    HouseInfo[i][date] = 0;

					    format(string, sizeof(string), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
					    UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, string);
					    DestroyDynamicMapIcon(HouseInfo[i][iconid]);
					    DestroyDynamicPickup(HouseInfo[i][pickid]);
					    HouseInfo[i][iconid] = CreateDynamicMapIcon(HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], 31, 1, -1, -1, -1, 100.0);
					    HouseInfo[i][pickid] = CreateDynamicPickup(1273, 1, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], -1, -1, -1, 30.0);
					    MySQL_SaveHouse(i);
					    break;
					}
					if(found)
					{
						PlayerInfo[player][Houses]--;
					}
                }

                if(PlayerInfo[player][Props] > 0)
                {
                    new bool:found = false;
					for(new i = 0; i < propid; i++)
					{
	    				if(strcmp(__GetName(player), PropInfo[i][Owner])) continue;
						found = true;

                        strmid(PropInfo[i][Owner], "ForSale", 0, 25, 25);
					    PropInfo[i][sold] = 0;
					    PropInfo[i][date] = 0;

					    format(string, sizeof(string), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
					    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, string);
					    DestroyDynamicMapIcon(PropInfo[i][iconid]);
					    PropInfo[i][iconid] = CreateDynamicMapIcon(PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z], 52, 1, -1, -1, -1, 100.0);
					    MySQL_SaveProp(i);
					    break;
					}
					if(found)
					{
						PlayerInfo[player][Props]--;
						PlayerInfo[player][PropEarnings] = 0;
					}
                }

				format(string, sizeof(string), ""yellow"** "red"%s has been banned by Admin %s [Reason: %s]", __GetName(player), __GetName(playerid), reason);
				SCMToAll(YELLOW, string);
				print(string);

	    		format(string, sizeof(string), ""red"You have been banned!"white"\n\nAdmin: \t\t%s\nReason: \t\t%s\n\nIf you think that you have been banned wrongly,\nwrite a ban appeal on forum.stunt-evolution.net", __GetName(playerid), reason);
	    		ShowPlayerDialog(player, BAN_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Notice", string, "OK", "");
	    		KickEx(player);
	    		PlayerPlaySound(playerid, 1184, 0.0, 0.0, 0.0);
				return 1;
			}
			else
			{
				SCM(playerid, -1, ""er"Player is not connected or is yourself or is the highest level admin");
			}
		}
		else
		{
		    new warnstring[128];
		    format(warnstring, sizeof(warnstring), "OMGLOL: %s just tried to ban you with reason: %s", __GetName(playerid), reason);
		    SCM(player, RED, warnstring);
		    SCM(playerid, RED, "I hope that was a joke");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:main(playerid, params[])
{
	if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL && IsPlayerAdmin(playerid))
	{
	    SetTimer("mainmode", 120000, false);
	    GlobalMain = true;
	    for(new i = 0; i < 50; i++)
		{
			SCMToAll(GREEN, " ");
		}
		SCMToAll(RED, "The server is going down in 2 minutes. Please logout before that time.");
	    ShowPlayerDialog(playerid, 8469, DIALOG_STYLE_MSGBOX, ""se" - Notice", ""white"_______________________________________________________________________\n\nThe Server is going down in 2 minutes. Please logout before that time.\n_______________________________________________________________________", "OK", "");
 	}
	return 1;
}

COMMAND:throw(playerid, params[])
{
	cmd_slap(playerid, params);
	return 1;
}

COMMAND:givegun(playerid, params[]) return cmd_giveweapon(playerid, params);
COMMAND:giveweapon(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 3)
    {
		new weaponID, weaponName[20], player, ammo_a, str[144];

		if(sscanf(params, "rii", player, weaponID, ammo_a))
		{
		    SendClientMessage(playerid, NGS_GREEN, "Usage: /giveweapon <playerid> <weaponid> <ammo>");
		    return 1;
		}
		
        if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
        if(gTeam[player] != NORMAL) return SCM(playerid, -1, ""er"Player is in a minigame!");
        if(PlayerInfo[player][bGod]) return SCM(playerid, -1, ""er"You can't give players weapons who enabled GOD");
        
		if(ammo_a < 0 || ammo_a > 10000)
		{
		    format(str, sizeof(str), ""er"Invalid ammo provided!");
		    SCM(playerid, COLOR_RED, str);
		    return 1;
		}

        if(weaponID == 38 || weaponID == 36 || weaponID == 35) return SCM(playerid, -1, ""er"Can't give restriced weapon");

		if(weaponID < 0 && weaponID > 47)
		{
		    if(weaponID == 20)
		    {
				SCM(playerid, -1, ""er"Invalid weapon ID provided!");
				return 1;
			}
			SCM(playerid, -1, ""er"Invalid weapon ID provided!");
			return 1;
		}

		GivePlayerWeapon(player, weaponID, ammo_a);
		GetWeaponName(weaponID, weaponName, sizeof(weaponName));

		format(str, sizeof(str), ""WHITE_E"["BLUE_E"SE"WHITE_E"] "GREY_E"Administrator %s(%i) gave you a %s(%d) with %d ammo.", __GetName(playerid), playerid, weaponName, weaponID, ammo_a);
		SendClientMessage(player, COLOR_STEELBLUE, str);
		format(str, sizeof(str), ""WHITE_E"["BLUE_E"SE"WHITE_E"] "GREY_E"You gave %s(%i) a %s(%d) with %d ammo.", __GetName(player), player, weaponName, weaponID, ammo_a);
		SendClientMessage(playerid, COLOR_STEELBLUE, str);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
			return SCM(playerid, NGS_GREEN, "Usage: /slap <playerid>");
	  	}

		if(IsPlayerAvail(player) && (PlayerInfo[player][Level] != MAX_ADMIN_LEVEL) && (gTeam[player] == NORMAL || gTeam[player] == DM || gTeam[player] == MINIGUN || gTeam[player] == SNIPER || gTeam[player] == WAR || gTeam[player] == GUNGAME))
		{
  			new Float:Health,
			  	Float:POS[3],
			  	string[128];

  			GetPlayerHealth(player, Health);
			SetPlayerHealth(player, floatsub(Health, 25.0));
			GetPlayerPos(player, POS[0], POS[1], POS[2]);
			SetPlayerPos(player, POS[0], POS[1], floatadd(POS[2], 10.0));
			format(string, sizeof(string), "You have slapped %s", __GetName(player));
			SCM(playerid, BLUE, string);
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or is the highest level admin or in a minigame");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:gotoxyz(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    if(GetPVarInt(playerid, "doingStunt") != 0) return SCM(playerid, -1, ""er"You can't use this command now");
		new Float:POS[3];
		if(sscanf(params, "fff", POS[0], POS[1], POS[2]))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /gotoxyz <X> <Y> <Z>");
		}
		SetPlayerPos(playerid, POS[0], POS[1], POS[2]);

		new string[144];
		format(string, sizeof(string), ""se" You have teleported yourself to %.3f %.3f %.3f!", POS[0], POS[1], POS[2]);
		SCM(playerid, -1, string);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:disarm(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    new player;
		if(sscanf(params, "r", player))
		{
		    return SCM(playerid, NGS_GREEN, "Usage: /disarm <playerid>");
		}

		if(gTeam[player] == GUNGAME) return SCM(playerid, -1, ""er"Cannot disarm player in gungame");
	    if(!IsPlayerAvail(player) || PlayerInfo[player][Level] >= PlayerInfo[playerid][Level]) return SCM(playerid, -1, ""er"Player is not connected or is an higher level admin than you");

		ResetPlayerWeapons(player);

		SendInfo(playerid, "~h~~y~An Admin reset your weapons!", 2500);
		SendInfo(playerid, "~h~~y~Player's has been disarmed!", 2500);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:getin(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
		new seat, player;
		if(sscanf(params, "ri", player, seat))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /getin <playerid> <seat id 1-3>");
		}

		if(!IsPlayerAvail(player)) return SCM(playerid, -1, ""er"Player is not connected");
		if(player == playerid || gTeam[player] != NORMAL)
		{
		    return SCM(playerid, -1, ""er"Cannot get in that player");
		}

		new string[144];
		if(!IsPlayerInAnyVehicle(player))
		{
			format(string, sizeof(string), ""er"%s(%i) is not in any vehicle!", __GetName(player), player);
			SCM(playerid, -1, string);
			return 1;
		}

		if(IsVehicleOneSeater(GetPlayerVehicleID(player)))
		{
			format(string, sizeof(string), ""er"%s(%i) is currently driving a one seat vehicle!", __GetName(player), player);
			SCM(playerid, -1, string);
			return 1;
		}

		if(seat < 0 || seat > 3)
		{
			return SCM(playerid, NGS_GREEN, "Usage: /getin <playerid> <seat id 1-3>");
		}

		new vID = GetPlayerVehicleID(player), vM = GetVehicleModel(vID);

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(!IsPlayerInVehicle(i, vID)) continue;
		    if(GetPlayerVehicleSeat(i) == seat)
		    {
				format(string, sizeof(string), ""er"Seat %i in %s(%i)'s %s is occupied by %s(%i)", seat, __GetName(player), player, VehicleNames[vM - 400], __GetName(i), i);
				SCM(playerid, -1, string);
				return 1;
			}
		}

		SetPlayerInterior(playerid, GetPlayerInterior(player));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(player));
		PutPlayerInVehicle(playerid, vID, seat);

		format(string, sizeof(string), ""se" %s(%i) teleported into your %s to seat %i", __GetName(playerid), playerid, VehicleNames[vM - 400], seat);
		SCM(player, -1, string);
		format(string, sizeof(string), ""se" You teleported into %s(%i)'s %s to seat %i.", __GetName(player), player, VehicleNames[vM - 400], seat);
		SCM(playerid, -1, string);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:pweaps(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 1)
	{
	    new player;
	    if(sscanf(params, "r", player))
		{
	        return SCM(playerid, NGS_GREEN, "Usage: /pweaps <playerid>");
	    }

	    if(!IsPlayerAvail(player)) return SCM(playerid, -1, ""er"Player is not connected");

	    new bullets[12],
	 		weapons[12],
	 		weapname[12][50],
	 		string[512];

		for(new i = 0; i < 12; i++)
		{
		    GetPlayerWeaponData(player, i + 1, weapons[i], bullets[i]);
		}

		for(new i = 0; i < 11; i++)
		{
		    GetWeaponName(weapons[i], weapname[i], 50);
		}

	    format(string, sizeof(string), ""yellow"- - - - -  [ %s's Weapons ] - - - - -", __GetName(player));
	    SCM(playerid, -1, string);
	    format(string, sizeof(string), "%s(0) - %s(%i) - %s(%i) - %s(%i) - %s(%i) - %s(%i)", weapname[0], weapname[1], bullets[1], weapname[2], bullets[2], weapname[3], bullets[3], weapname[4], bullets[4], weapname[5], bullets[5]);
	    SCM(playerid, WHITE, string);
	    format(string, sizeof(string), "%s(%i) - %s(%i) - %s(%i) - %s(0) - %s(0) - %s(0)", weapname[6], bullets[6], weapname[7], bullets[7] ,weapname[8], bullets[8], weapname[9], weapname[10], weapname[11]);
	    SCM(playerid, WHITE, string);
 	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
	new tempstring[128], finstring[2048], count = 0;
	format(finstring, sizeof(finstring), ""ngs_blue"Administrators:\n"white"");

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerAvail(i)) continue;
	    if(PlayerInfo[i][Level] > 0 && PlayerInfo[i][AOnline])
	    {
	        if(IsPlayerOnDesktop(i))
	        {
				format(tempstring, sizeof(tempstring), "%s(%i) | Level: %i | [AFK]\n", __GetName(i), i, PlayerInfo[i][Level]);
			}
			else
			{
			    format(tempstring, sizeof(tempstring), "%s(%i) | Level: %i\n", __GetName(i), i, PlayerInfo[i][Level]);
			}
			strcat(finstring, tempstring);
			count++;
	    }
	}

	strcat(finstring, "\n"ngs_blue"Very Important Players:\n"white"");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerAvail(i)) continue;
	    if(PlayerInfo[i][VIP] > 0)
	    {
	        if(IsPlayerOnDesktop(i))
	        {
				format(tempstring, sizeof(tempstring), "%s(%i) | [AFK]\n", __GetName(i), i);
	        }
			else
			{
			    format(tempstring, sizeof(tempstring), "%s(%i)\n", __GetName(i), i);
			}
	        strcat(finstring, tempstring);
			count++;
	    }
	}
	if(count == 0)
	{
	    SendInfo(playerid, "~h~~y~No admins/VIPs online!", 2100);
	}
	else
	{
	    format(tempstring, sizeof(tempstring), "\n"white"Total of "ngs_blue"%i "white"admins/VIPs online!", count);
	    strcat(finstring, tempstring);
		ShowPlayerDialog(playerid, ADMINS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Admins", finstring, "OK", "");
	}
	return 1;
}

COMMAND:premiums(playerid, params[])
{
	cmd_vips(playerid, "");
	return 1;
}

COMMAND:vips(playerid, params[])
{
	new tempstring[128], finstring[1024], count = 0;
	format(finstring, sizeof(finstring), ""yellow"ID:\t\tName:\n"white"");

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerAvail(i)) continue;
	    if(PlayerInfo[i][VIP] > 0)
	    {
            if(IsPlayerOnDesktop(i))
            {
				format(tempstring, sizeof(tempstring), "%i\t\t%s | [AFK]\n", i, __GetName(i));
			}
			else
			{
			    format(tempstring, sizeof(tempstring), "%i\t\t%s\n", i, __GetName(i));
			}
			strcat(finstring, tempstring);
			count++;
	    }
	}
	if(count == 0)
	{
	    SendInfo(playerid, "~h~~y~No VIPs online!", 2100);
	}
	else
	{
	    format(tempstring, sizeof(tempstring), "\n\n"white"Total of "ngs_blue"%i "white"aVIPs online!", count);
	    strcat(finstring, tempstring);
		ShowPlayerDialog(playerid, ADMINS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - VIPs", finstring, "OK", "");
	}
	return 1;
}

COMMAND:a(playerid, params[])
{
    if(PlayerInfo[playerid][Level] == 0) return SCM(playerid, -1, NOT_AVAIL);
    
    new msgstring[144], msg[144];
	if(sscanf(params, "s[144]", msg))
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /a <text>");
	}

	format(msgstring, sizeof(msgstring), ""white"["red"ADMIN CHAT"white"] %s(%i): "LB2_E"%s", __GetName(playerid), playerid, msg);
	AdminMSG(-1, msgstring);
	return 1;
}

COMMAND:p(playerid, params[])
{
	if(PlayerInfo[playerid][VIP] != 1 && PlayerInfo[playerid][Level] == 0) return cmd_vip(playerid, "");

	new msg[144];
	if(sscanf(params, "s[144]", msg))
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /p <text>");
	}

	new is1 = 0,
		r = 0,
		strR[255];

 	while(strlen(msg[is1]))
 	{
  		if('0' <= msg[is1] <= '9')
  		{
 			new is2 = is1 + 1,
			 	p = 0;

			while(p == 0)
  			{
   				if('0' <= msg[is2] <= '9' && strlen(msg[is2]))
		   		{
			  		is2++;
				}
 				else
  				{
				   	strmid(strR[r], msg, is1, is2, sizeof(strR));
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
	  	format(string, sizeof(string), ""yellow"** "red"Suspicion advertising | Player: %s(%i) Advertised IP: %s - PlayerIP: %s", __GetName(playerid), playerid, msg, __GetIP(playerid));
		AdminMSG(RED, string);

        SCM(playerid, RED, "Advertising is not allowed!");
        return 1;
	}

	new string[255];
	format(string, sizeof(string), ""white"["lb_e"VIP CHAT"white"] {%06x}%s"white"(%i): %s", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, msg);
	VIPMSG(-1, string);
	return 1;
}

COMMAND:vipl(playerid, params[])
{
	cmd_viplounge(playerid, "");
	return 1;
}

COMMAND:vipli(playerid, params[])
{
	if(PlayerInfo[playerid][VIP] == 1)
	{
		new tick = GetTickCount() + 3600000;
		if((PlayerInfo[playerid][tickLastVIPLInv] + COOLDOWN_CMD_VIPLI) >= tick)
		{
		    return SCM(playerid, -1, ""se" Please wait before using this command again again");
		}
		
		new player;
		if(sscanf(params, "r", player))
		{
		    return SCM(playerid, NGS_GREEN, "Usage: /vipli <playerid>");
		}
		
		if(PlayerInfo[player][VIP] == 1) return SCM(playerid, -1, ""er"You cannot invite this player");
		if(PlayerInfo[player][Level] > 0) return SCM(playerid, -1, ""er"You cannot invite this player");
		
		PlayerInfo[player][GotVIPLInv] = true;
		
		new string[144];
		format(string, sizeof(string), ""yellow_e"%s(%i) invited you to the VIP Lounge. Type /accept to join.", __GetName(playerid), playerid);
		SCM(player, -1, string);

		format(string, sizeof(string), ""yellow_e"Invitation sent to %s(%i)", __GetName(player), player);
		SCM(playerid, -1, string);
		
	    PlayerInfo[playerid][tickLastVIPLInv] = tick;
	}
	else
	{
	    cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:accept(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 1) return SCM(playerid, -1, ""er"You can't use this command as VIP");
    
	if(!PlayerInfo[playerid][GotVIPLInv])
	{
	    return SCM(playerid, -1, ""er"You got no invitation");
	}
	
	if(gTeam[playerid] != NORMAL)
	{
	    cmd_exit(playerid, "");
	}
	
	SetPlayerPos(playerid, -2640.762939,1406.682006,906.460937);
	SetPlayerInterior(playerid, 3);
    gTeam[playerid] = VIPL;
    ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

	SCM(playerid, -1, ""yellow_e"You've used your invitation");

	PlayerInfo[playerid][GotVIPLInv] = false;
	return 1;
}

COMMAND:viplounge(playerid, params[])
{
    PortPlayerMap(playerid, -2622.3103,1403.3483,7.1016,12.389, "VIP Lounge", "vipl");
	return 1;
}

COMMAND:premium(playerid, params[])
{
	cmd_vip(playerid, "");
	return 1;
}

COMMAND:vipcmds(playerid, params[])
{
	cmd_vip(playerid, "");
	return 1;
}

COMMAND:viphelp(playerid, params[])
{
	cmd_vip(playerid, "");
	return 1;
}

COMMAND:vip(playerid, params[])
{
	new string[2048];
	
	strcat(string, ""ngs_blue"Very Important Player (VIP)\n\n"yellow_e"Features:"white"\n"dl" Access to VIP vehicles in /v\n"dl" VIP Chat (/p)\n"dl" 100\% Armor On Spawn\n"dl" Jetpack Spawn (/jetpack)\n"dl" Hydra Spawn (/hydra)\n");
	strcat(string, ""dl" Countdown command (/cd)\n"dl" Namechange all 30 days (/changename)\n"dl" Open/Close Mellnik´s Gate (/opengate /closegate)");
	strcat(string, "\n"dl" Spectate Players (/spec)\n"dl" More interest each PayDay\n"dl" Access to VIP Forums\n"dl" Access to Beta Changelogs\n"dl" Rainbow effect (/rainbow)\n"dl" Custom Label (/label)\n");
	strcat(string, ""dl" Get listed in /vips and /admins\n");
	strcat(string, ""dl" Message to all players when joining the server\n"dl" Vehicle Control System (/vcs)\n"dl" VIP Lounge (/vipl)\n"dl" VIP Lounge Invite (/vipli)\n"dl" Direct Spawn in /adminhq\n"dl" Access to VIP Private Vehicles");
	strcat(string, "\n"dl" Attach Trailers to your truck (/trailer)\n"dl" Create Ramps (/ramp)\n"dl" Health and Armor (/harefill)");
	strcat(string, "\n\n"ngs_blue"Get VIP today! Go To:\n");
	strcat(string, ""red"-> "yellow_e"http://www.stunt-evolution.net/vip");
    ShowPlayerDialog(playerid, VIP_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Very Important Player (VIP)", string, "OK", "");
	return 1;
}

COMMAND:hydra(playerid, params[])
{
	if(PlayerInfo[playerid][VIP] == 1)
	{
	    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	    if(IsPlayerInRangeOfPoint(playerid, 65.0, 1797.3141, -1302.0978, 120.2659) && PlayerInfo[playerid][Level] < 1) return SCM(playerid, -1, ""er"Can´t spawn vehicle at this place!");
		
		CarSpawner(playerid, 520);
	}
	else
	{
		cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:god(playerid, params[])
{
	if(gTeam[playerid] == NORMAL)
	{
	    if(PlayerInfo[playerid][bGod])
	    {
	        SetPVarInt(playerid, "HadGod", 0);
	 		SendClientMessage(playerid, COLOR_RED, ""WHITE_E"["BLUE_E"SE"WHITE_E"] "GREY_E"You have disabled god-mode. You can now lose health in stunt zones.");
			SendClientMessage(playerid, COLOR_RED, "> "YELLOW_E"You can now freely use weapons.");
	        TextDrawHideForPlayer(playerid, godTD);
	        SetPlayerHealth(playerid, 100.0);
	        PlayerInfo[playerid][bGod] = false;
	        RandomWeapon(playerid);
	    }
	    else
	    {
	        new Float:HP;
	        GetPlayerHealth(playerid, HP);
			if(HP < 45) return GameTextForPlayer(playerid, "~b~~h~~h~Your health is too low!", 2000, 3);
	        SetPVarInt(playerid, "HadGod", 1);
		    SendClientMessage(playerid, COLOR_RED, ""WHITE_E"["BLUE_E"SE"WHITE_E"] "GREY_E"You have enabled god-mode. You will now have infinith health in stunt zones.");
			SendClientMessage(playerid, COLOR_RED, "> "YELLOW_E"You will not be able to use weapons with godmode enabled, type /god again to disable.");
	        TextDrawShowForPlayer(playerid, godTD);
	        ResetPlayerWeapons(playerid);
	        SetPlayerHealth(playerid, 999999.0);
	        PlayerInfo[playerid][bGod] = true;
	    }
	}
	else
	{
  		SCM(playerid, RED, NOT_AVAIL);
	}
	return 1;
}

COMMAND:v70(playerid, params[]) // Cheetah
{
	if(PlayerInfo[playerid][VIP] == 0) return 1;

    CarSpawner(playerid, 415);

    new vID = GetPlayerVehicleID(playerid);

	hVIPVehObj[playerid][0] = CreateObject(2985,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][0], vID, -0.450000,0.824999,-0.599999,-27.000003,-0.000000,-269.999877);

	hVIPVehObj[playerid][1] = CreateObject(2985,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][1], vID, 0.524999,0.824999,-0.674999,21.599998,-0.000000,-269.999877);

	hVIPVehObj[playerid][2] =  CreateObject(18647,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][2], vID, -1.049999,-0.150000,-0.524999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][3] = CreateObject(18647,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][3], vID, 1.049999,-0.150000,-0.524999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][4] = CreateObject(1254,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][4], vID, -0.000000,2.100000,0.000000,67.500007,0.000000,0.000000);

	hVIPVehObj[playerid][5] = CreateObject(19314,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][5], vID, -0.000000,0.000000,0.599999,70.200004,89.099983,0.000000);

	ChangeVehicleColor(vID, 0, 0);
	SendClientMessage(playerid, -1, ""se" "LB2_E"You have spawned a custom Cheetah!");
	return 1;
}

COMMAND:v71(playerid, params[])// Infernus
{
	if(PlayerInfo[playerid][VIP] == 0) return 1;

    CarSpawner(playerid, 411);

    new vID = GetPlayerVehicleID(playerid);

	hVIPVehObj[playerid][0] = CreateObject(19419,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][0], vID, 0.000000,-2.100000,0.300000,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][1] = CreateObject(19419,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][1], vID, 0.000000,-1.725000,0.300000,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][2] =  CreateObject(18647,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][2], vID, -1.049999,-0.150000,-0.524999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][3] = CreateObject(18647,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][3], vID, 1.049999,-0.150000,-0.524999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][4] = CreateObject(18646,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][4], vID, -0.449999,0.000000,0.749999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][5] = CreateObject(1247,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][5], vID, -0.000000,2.175000,0.075000,70.200004,-0.000001,-0.000001);

	ChangeVehicleColor(vID, 0, 0);
	SendClientMessage(playerid, -1, ""se" "LB2_E"You have spawned a custom Infurnes!");
	return 1;
}

COMMAND:v72(playerid, params[]) // Huntley
{
	if(PlayerInfo[playerid][VIP] == 0) return 1;

    CarSpawner(playerid, 579);

    new vID = GetPlayerVehicleID(playerid);

	hVIPVehObj[playerid][0] = CreateObject(2985,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][0], vID, -0.000000,1.725000,-0.225000,0.000001,0.000000,91.799980);

	hVIPVehObj[playerid][1]= CreateObject(19314,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][1], vID, 0.000000,0.225000,1.200000,91.799980,-89.099983,0.000000);

	hVIPVehObj[playerid][2] = CreateObject(359,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][2], vID, -0.600000,-1.049999,1.200000,-0.000001,-0.000001,89.099983);

	hVIPVehObj[playerid][3] = CreateObject(359,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][3], vID, 0.674999,-1.049999,1.200000,-0.000001,-0.000001,89.099983);

	hVIPVehObj[playerid][4] = CreateObject(18652,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][4], vID, -1.049999,0.000000,-0.524999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][5] = CreateObject(18652,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][5], vID, 1.049999,0.000000,-0.524999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][6] = CreateObject(1247,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][6], vID, -1.125000,0.899999,0.150000,-5.399999,0.000000,89.099983);

	hVIPVehObj[playerid][7] = CreateObject(1247,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][7], vID, 1.124999,0.899999,0.150000,-5.399999,0.000000,89.099983);

    hVIPVehObj[playerid][8] = CreateObject(1318,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][8], vID, 0.000000,-0.899999,1.350000,-264.599853,-359.100280,-359.100280);

	hVIPVehObj[playerid][9] = CreateObject(954,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][9], vID, -0.000000,-2.700001,0.749999,-21.600002,-0.000000,-0.000000);

	hVIPVehObj[playerid][10] = CreateObject(1254,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][10], vID, 0.000000,2.400000,0.225000,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][11] = CreateObject(19419,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][11], vID, -0.000000,-2.250000,1.125000,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][12] = CreateObject(1248,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][12], vID, -0.000000,-2.775001,0.000000,0.000000,0.000000,0.000000);

	ChangeVehicleColor(vID, 0, 0);
	SendClientMessage(playerid, -1, ""se" "LB2_E"You have spawned a custom Huntley!");
	return 1;
}

COMMAND:v73(playerid, params[]) // Bullet
{
	if(PlayerInfo[playerid][VIP] == 0) return 1;

    CarSpawner(playerid, 541);

    new vID = GetPlayerVehicleID(playerid);

	hVIPVehObj[playerid][0] = CreateObject(1254,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][0], vID, -0.000000,1.950000,0.075000,72.900001,0.000000,0.000000);

	hVIPVehObj[playerid][1] = CreateObject(18647,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][1], vID, -0.974999,0.000000,-0.375000,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][2] = CreateObject(18647,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][2], vID, 0.974999,0.000000,-0.375000,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][3] = CreateObject(18749,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][3], vID, -0.000000,-1.800000,0.375000,-78.299995,-0.000001,0.000000);

	hVIPVehObj[playerid][4] = CreateObject(359,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][4], vID, -0.300000,0.000000,0.599999,-0.000002,0.000000,89.099960);

	hVIPVehObj[playerid][5] = CreateObject(359,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][5], vID, 0.374999,0.000000,0.599999,-0.000002,0.000000,89.099960);

	hVIPVehObj[playerid][6] = CreateObject(18646,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][6], vID, -0.000000,0.000000,0.674999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][7] = CreateObject(355,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][7], vID, -0.149999,-2.324999,0.000000,5.399998,-16.200000,5.400000);

	ChangeVehicleColor(vID, 0, 3);
	SendClientMessage(playerid, -1, ""se" "LB2_E"You have spawned a custom Bullet!");
	return 1;
}

COMMAND:v74(playerid, params[]) // NRG
{
	if(PlayerInfo[playerid][VIP] == 0) return 1;

    CarSpawner(playerid, 522);

    new vID = GetPlayerVehicleID(playerid);

	hVIPVehObj[playerid][0] = CreateObject(18650,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][0], vID, 0.000000,0.000000,-0.674999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][1] = CreateObject(362,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][1], vID, 0.075000,0.600000,0.675000,5.399998,24.300001,99.899971);

	hVIPVehObj[playerid][2] = CreateObject(1254,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][2], vID, -0.150000,1.800000,0.524999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][3] = CreateObject(18646,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][3], vID, 0.000000,-0.899999,0.599999,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][4] = CreateObject(19130,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][4], vID, -0.675000,0.000000,0.824999,40.500003,0.000002,-80.999992);

	hVIPVehObj[playerid][5] = CreateObject(19130,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][5], vID, 0.824999,0.000000,0.824999,40.500003,0.000002,-269.999877);

	hVIPVehObj[playerid][6] = CreateObject(18749,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][6], vID, 0.000000,-1.125000,0.300000,0.000000,0.000000,0.000000);

	hVIPVehObj[playerid][7] = CreateObject(359,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][7], vID, -0.375000,0.000000,0.000000,0.000000,0.000000,89.099983);

	hVIPVehObj[playerid][8] = CreateObject(359,0,0,-1000,0,0,0,100);
	AttachObjectToVehicle(hVIPVehObj[playerid][8], vID, 0.449999,0.000000,0.000000,0.000000,0.000000,89.099983);

	ChangeVehicleColor(vID, 0, 6);
	SendClientMessage(playerid, -1, ""se" "LB2_E"You have spawned a custom NRG!");
	return 1;
}

COMMAND:adminhq(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

    new string[144];
	if(PlayerInfo[playerid][Level] > 0)
	{
		SetPlayerPos(playerid, 1797.4270,-1300.9581,120.2656);
		format(string, sizeof(string), ""se" Admin %s teleported to Admin´s Headquarter! (/adminhq)", __GetName(playerid));
		SCMToAll(-1, string);
	 	ResetPlayerWorld(playerid);
	 	PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=111772", 1797.3141, -1302.0978, 120.2659, 65.0, 1);
	}
	else if(PlayerInfo[playerid][VIP] == 1)
	{
		SetPlayerPos(playerid, 1797.4270,-1300.9581,120.2656);
		format(string, sizeof(string), ""se" VIP %s teleported to Admin´s Headquarter! (/adminhq)", __GetName(playerid));
		SCMToAll(-1, string);
	 	ResetPlayerWorld(playerid);
	 	PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=111772", 1797.3141, -1302.0978, 120.2659, 65.0, 1);
	}
	else
	{
	    SetPlayerPos(playerid, 1786.5049,-1298.0465,120.2656);
		format(string, sizeof(string), ""se" Player %s teleported to Admin´s Headquarter! (/adminhq)", __GetName(playerid));
		SCMToAll(-1, string);
	    ResetPlayerWorld(playerid);
		PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=111772", 1797.3141, -1302.0978, 120.2659, 65.0, 1);
	}
	return 1;
}

COMMAND:count(playerid, params[])
{
	cmd_cd(playerid, params);
	return 1;
}

COMMAND:countdown(playerid, params[])
{
	cmd_cd(playerid, params);
	return 1;
}

COMMAND:cd(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 0) return SCM(playerid, RED, NO_PERM_ENG);
   	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastCD] + COOLDOWN_CMD_CD) >= tick)
	{
	    return SCM(playerid, -1, ""se" Please wait before sending a message again");
	}
    if(IsCountDownRunning) return SCM(playerid, -1, ""er"Countdown is already running");
    
    iCountdownVIP = 5;
    IsCountDownRunning = true;
    
    tVIPCountdown = SetTimer("CountdownVIP", 1000, true);
    
    new str[255];
   	format(str, sizeof(str), ""se" VIP {%06x}%s(%i) "white"has started a countdown!", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid);
	SCMToAll(-1, str);
	
	PlayerInfo[playerid][tickLastCD] = tick;
	return 1;
}

function:CountdownVIP()
{
	switch(iCountdownVIP)
	{
	    case 5:
	    {
			GameTextForAll("~h~~r~- 5 -", 1000, 3);
	    }
	    case 4:
	    {
	        GameTextForAll("~h~~p~- 4 -", 1000, 3);
	    }
	    case 3:
	    {
	        GameTextForAll("~h~~b~- 3 -", 1000, 3);
	    }
	    case 2:
	    {
	        GameTextForAll("~h~~g~- 2 -", 1000, 3);
	    }
	    case 1:
	    {
	        GameTextForAll("~h~~y~- 1 -", 1000, 3);
	    }
 	    case 0:
	    {
	        GameTextForAll("~h~~g~GO GO GO", 1000, 3);
	        KillTimer(tVIPCountdown);
         	IsCountDownRunning = false;
	    }
	    default:
	    {
	        GameTextForAll("~h~~g~GO GO GO", 1000, 3);
	        KillTimer(tVIPCountdown);
         	IsCountDownRunning = false;
	    }
	}
	iCountdownVIP--;
	return 1;
}

COMMAND:setvip(playerid, params[])
{
	if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			SCM(playerid, NGS_GREEN, "Usage: /setvip <playerid>");
            SCM(playerid, NGS_GREEN, "If the specified player already got VIP, his status will be removed");
            return 1;
		}

        if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Cannot assign VIP");

		if(IsPlayerAvail(player))
		{
		    new string[144];
		    if(PlayerInfo[player][VIP] == 0)
		    {
		        PlayerInfo[player][VIP] = 1;
				format(string, sizeof(string), ""se" Admin %s(%i) has given %s(%i) VIP status", __GetName(playerid), playerid, __GetName(player), player);
				SCMToAll(-1, string);
		    }
		    else
		    {
		        PlayerInfo[player][VIP] = 0;
				format(string, sizeof(string), ""se" %s´s(%i) VIP status was removed by Admin %s(%i)", __GetName(player), player, __GetName(playerid), playerid);
	            SCMToAll(BLUE, string);
		    }
		    MySQL_SavePlayer(player);
		}
		else
		{
			SCM(playerid, -1, ""er"Cannot assign VIP");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:rainbow(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
	    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use the rainbow feature!");
	}

	if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][PV_Vehicle]) return SCM(playerid, -1, ""er"Not possible in PVs!");

	if(!PlayerInfo[playerid][bRainbow])
	{
		PlayerInfo[playerid][tRainbow] = SetTimerEx("ChangeColors", 500, true, "i", playerid);
		PlayerInfo[playerid][bRainbow] = true;
		SCM(playerid, -1, ""se" The Rainbow Effect has been turned on");
	}
	else
	{
		KillTimer(PlayerInfo[playerid][tRainbow]);
		PlayerInfo[playerid][bRainbow] = false;
		SCM(playerid, -1, ""se" The Rainbow Effect has been turned off");
	}
	return true;
}

COMMAND:setadminlevel(playerid, params[])
{
	if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL || IsPlayerAdmin(playerid))
	{
	    new player, alevel;
	 	if(sscanf(params, "ri", player, alevel))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /setadminlevel <playerid> <level>");
	  	}

		if(IsPlayerAvail(player))
		{
			if(alevel > MAX_ADMIN_LEVEL)
			{
				return SCM(playerid, -1, ""er"Incorrect Level");
			}
			if(alevel == PlayerInfo[player][Level])
			{
				return SCM(playerid, -1, ""er"Player is already this level");
			}
  			new time[3], string[128];
   			gettime(time[0], time[1], time[2]);

			if(alevel > 0)
			{
				format(string, sizeof(string), "Admin %s has set you to Admin Status [level %i]", __GetName(playerid), alevel);
			}
			else
			{
				format(string, sizeof(string), "Admin %s has set you to Player Status [level %i]", __GetName(playerid), alevel);
			}
			SCM(player, BLUE, string);

			if(alevel > PlayerInfo[player][Level])
			{
				GameTextForPlayer(player, "Promoted", 5000, 3);
			}
			else
			{
				GameTextForPlayer(player, "Demoted", 5000, 3);
			}
			format(string, sizeof(string), "You have made %s Level %i at %i:%i:%i", __GetName(player), alevel, time[0], time[1], time[2]);
			SCM(playerid, BLUE, string);
			format(string, sizeof(string), "Admin %s has made %s Level %i at %i:%i:%i", __GetName(playerid), __GetName(player), alevel, time[0], time[1], time[2]);
            SCM(player, BLUE, string);
            print(string);
			PlayerInfo[player][Level] = alevel;
		}
		else
		{
			SCM(playerid, -1, ""er"Cannot assign permissions");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:report(playerid, params[])
{
	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastReport] + COOLDOWN_CMD_REPORT) >= tick)
	{
    	return SCM(playerid, -1, ""er"Please wait a bit before using this cmd again!");
	}

	new	player,
		reason[144];

	if(sscanf(params, "rs[144]", player, reason)) return SCM(playerid, NGS_GREEN, "Usage: /report <playerid> <reason>");

 	if(IsPlayerAvail(player) && player != playerid && PlayerInfo[player][Level] == 0)
	{
		if(strlen(reason) < 4) return SCM(playerid, -1, ""er"Please write more");

		new time[3],
			string[144];

		gettime(time[0], time[1], time[2]);

		format(string, sizeof(string), ""YELLOW_E"Report(%02i:%02i:%02i) "RED_E"%s(%i) -> %s(%i) -> %s", time[0], time[1], time[2], __GetName(playerid), playerid, __GetName(player), player, reason);
		for(new i = 1; i < MAX_REPORTS - 1; i++)
		{
			Reports[i] = Reports[i + 1];
		}
		Reports[MAX_REPORTS - 1] = string;

        AdminMSG(-1, string);

		SCM(playerid, YELLOW, "Your report has been sent to online Admins");
		PlayerInfo[playerid][tickLastReport] = tick;
	}
	else
	{
		SCM(playerid, -1, ""er"You cannot report this player!");
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
				SCM(playerid, WHITE, Reports[i]);
			}
		}
		
		if(ReportCount == 0)
		{
			SCM(playerid, WHITE, "There have been no reports");
		}
    }
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:race(playerid, params[])
{
    if(gTeam[playerid] == RACE) return cmd_exit(playerid, "");
    if(gTeam[playerid] != NORMAL) cmd_exit(playerid, "");
	if(RaceSpawnCount >= 12 && RaceStatus != RaceStatus_Active) return SCM(playerid, -1, ""er"Race reached it's max players");
	
	CheckPlayerGod(playerid);
	
	if(RaceStatus == RaceStatus_StandBy)
	{
	    Iter_Clear(RaceJoins);
	    RaceStatus = RaceStatus_StartUp;
		tRaceCount = SetTimer("CountTillRace", 999, true);
	}
	else if(RaceStatus == RaceStatus_Inactive)
	{
		// Wait till cooldown expires.
		SCM(playerid, -1, ""er"No Race active!");
	}
	else if(RaceStatus == RaceStatus_Active)
	{
		// Too late!
		SCM(playerid, -1, ""er"Sorry, race already started");
	}

	if(RaceStatus == RaceStatus_StartUp)
	{
		if(Iter_Contains(RaceJoins, playerid))
		{
			SCM(playerid, -1, ""er"You already joined this race round!");
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

COMMAND:sethouseprice(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL) return SCM(playerid, RED, NO_PERM_ENG);

	extract params -> new hprice; else
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /sethouseprice <price>");
	}

 	new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
	    found = true;

	    if(HouseInfo[i][sold] == 1) return SCM(playerid, -1, ""er"House connot be sold");

	    HouseInfo[i][price] = hprice;

	    new string[144];
 	   	format(string, sizeof(string), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
	    UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, string);
	    MySQL_SaveHouse(i);

		SendInfo(playerid, "~h~~h~House price has been set!", 2000);
	    break;
	}
    if(!found) SCM(playerid, -1, ""er"You need to stand in the house pickup (Entrance)");
	return 1;
}

COMMAND:sethousescore(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL) return SCM(playerid, RED, NO_PERM_ENG);

	extract params -> new hscore; else
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /sethousescore <score>");
	}

 	new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
	    found = true;

	    if(HouseInfo[i][sold] == 1) return SCM(playerid, -1, ""er"House connot be sold");

	    HouseInfo[i][E_score] = hscore;

	    new string[144];
 	   	format(string, sizeof(string), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
	    UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, string);
	    MySQL_SaveHouse(i);

		SendInfo(playerid, "~h~~h~House score has been set!", 2000);
	    break;
	}
    if(!found) SCM(playerid, -1, ""er"You need to stand in the house pickup (Entrance)");
	return 1;
}

COMMAND:resethouse(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL) return SCM(playerid, RED, NO_PERM_ENG);

 	new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
	    found = true;

		if(HouseInfo[i][sold] == 0) return SCM(playerid, -1, ""er"House is not sold");

		new bool:pfound = false, string[144];
		for(new pid = 0; pid < MAX_PLAYERS; pid++)
		{
		    if(!strcmp(__GetName(pid), HouseInfo[i][Owner], true))
		    {
				pfound = true;
		        PlayerInfo[pid][Houses]--;
		        SCM(pid, -1, "An admin destroyed your house!");
				MySQL_SavePlayer(pid);
				break;
		   	}
		}
		if(!pfound)
		{
			format(string, sizeof(string), "UPDATE `"#TABLE_ACCOUNT"` SET `Houses` = `Houses` - 1 WHERE `Name` = '%s' LIMIT 1;", HouseInfo[i][Owner]);
			mysql_function_query(g_SQL_handle, string, false, "", "");
		}
	    strmid(HouseInfo[i][Owner], "ForSale", 0, 25, 25);
	    HouseInfo[i][sold] = 0;
        HouseInfo[i][locked] = 1;
        HouseInfo[i][date] = 0;
		MySQL_SaveHouse(i);

	    format(string, sizeof(string), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
	    UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, string);
	    DestroyDynamicMapIcon(HouseInfo[i][iconid]);
	    DestroyDynamicPickup(HouseInfo[i][pickid]);
	    HouseInfo[i][iconid] = CreateDynamicMapIcon(HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], 31, 1, -1, -1, -1, 100.0);
	    HouseInfo[i][pickid] = CreateDynamicPickup(1273, 1, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z], -1, -1, -1, 30.0);

		SendInfo(playerid, "~h~~h~The house has been reset!", 2000);
  		break;
	}
    if(!found) SCM(playerid, -1, ""er"You need to stand in the house pickup (Entrance)");
	return 1;
}

COMMAND:setbizzprice(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL) return SCM(playerid, RED, NO_PERM_ENG);

	extract params -> new pprice; else
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /setbizzprice <price>");
	}

 	new bool:found = false;
	for(new i = 0; i < propid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z])) continue;
	    found = true;

	    if(PropInfo[i][sold] == 1) return SCM(playerid, -1, ""er"Business connot be sold");

	    PropInfo[i][price] = pprice;

	    new string[144];
	    format(string, sizeof(string), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
	    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, string);
	    MySQL_SaveProp(i);

		SendInfo(playerid, "~h~~h~Business price has been set!", 2000);
	    break;
	}
    if(!found) SCM(playerid, -1, ""er"You need to stand in the business pickup (Entrance)");
	return 1;
}

COMMAND:setbizzscore(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL) return SCM(playerid, RED, NO_PERM_ENG);

	extract params -> new pscore; else
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /setbizzscore <score>");
	}

 	new bool:found = false;
	for(new i = 0; i < propid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z])) continue;
	    found = true;

	    if(PropInfo[i][sold] == 1) return SCM(playerid, -1, ""er"Business connot be sold");

	    PropInfo[i][E_score] = pscore;

	    new string[144];
	    format(string, sizeof(string), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
	    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, string);
	    MySQL_SaveProp(i);

		SendInfo(playerid, "~h~~h~Business score has been set!", 2000);
	    break;
	}
    if(!found) SCM(playerid, -1, ""er"You need to stand in the business pickup (Entrance)");
	return 1;
}

COMMAND:setbizzearnings(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL) return SCM(playerid, RED, NO_PERM_ENG);

	extract params -> new pearnings; else
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /setbizzearnings <earnings>");
	}

 	new bool:found = false;
	for(new i = 0; i < propid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z])) continue;
	    found = true;

	    if(PropInfo[i][sold] == 1) return SCM(playerid, -1, ""er"Business connot be sold");

	    PropInfo[i][earnings] = pearnings;

	    new string[144];
	    format(string, sizeof(string), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
	    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, string);
	    MySQL_SaveProp(i);

		SendInfo(playerid, "~h~~h~Business earnings have been set!", 2000);
	    break;
	}
    if(!found) SCM(playerid, -1, ""er"You need to stand in the business pickup (Entrance)");
	return 1;
}

COMMAND:resetbizz(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL) return SCM(playerid, RED, NO_PERM_ENG);

 	new bool:found = false;
	for(new i = 0; i < propid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z])) continue;
	    found = true;

		if(PropInfo[i][sold] == 0) return SCM(playerid, -1, ""er"Business is not sold");

		new bool:pfound = false, string[144];
		for(new pid = 0; pid < MAX_PLAYERS; pid++)
		{
		    if(!strcmp(__GetName(pid), PropInfo[i][Owner], true))
		    {
				pfound = true;
		        PlayerInfo[pid][Props]--;
				PlayerInfo[pid][PropEarnings] = 0;
		        SCM(pid, -1, "An admin destroyed your business!");
				MySQL_SavePlayer(pid);
				break;
		   	}
		}
		if(!pfound)
		{
			format(string, sizeof(string), "UPDATE `"#TABLE_ACCOUNT"` SET `Props` = `Props` - 1, `PropEarnings` = 0 WHERE `Name` = '%s' LIMIT 1;", PropInfo[i][Owner]);
			mysql_function_query(g_SQL_handle, string, false, "", "");
		}
	    strmid(PropInfo[i][Owner], "ForSale", 0, 25, 25);
	    PropInfo[i][sold] = 0;
        PropInfo[i][date] = 0;
		MySQL_SaveProp(i);

	    format(string, sizeof(string), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
	    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, string);
	    DestroyDynamicMapIcon(PropInfo[i][iconid]);
	    PropInfo[i][iconid] = CreateDynamicMapIcon(PropInfo[i][E_x], PropInfo[i][E_y], PropInfo[i][E_z], 52, 1, -1, -1, -1, 100.0);

        SendInfo(playerid, "~h~~h~The business has been reset!", 2000);
  		break;
	}
    if(!found) SCM(playerid, -1, ""er"You need to stand in the business pickup (Entrance)");
	return 1;
}

COMMAND:createrace(playerid, params[])
{
	if(IsPlayerAdmin(playerid) && PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL)
	{
		if(BuildRace != 0) return SCM(playerid, -1, ""er"There's already someone building a race!");
		if(RaceStatus == RaceStatus_Active) return SCM(playerid, -1, ""er"Wait first till race ends!");
		if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, -1, ""er"Please leave your vehicle first!");
		BuildRace = playerid + 1;
		ShowDialog(playerid, DIALOG_RACE_RACETYPE);
		gTeam[playerid] = BUILDRACE;

	    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, 0);
	    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_MAP_ICON, 0);
	    Streamer_DestroyAllVisibleItems(playerid, STREAMER_TYPE_PICKUP);
	    Streamer_DestroyAllVisibleItems(playerid, STREAMER_TYPE_MAP_ICON);
	}
	else
	{
	    SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:createprop(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
		return SCM(playerid, RED, NO_PERM_ENG);
	}

	extract params -> new p_price, p_score, p_earnings; else
	{
		return SCM(playerid, NGS_GREEN, "Usage: /createprop <price> <score> <earnings>");
	}

  	new Float:POS[3];

  	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
 	PropInfo[propid][E_x] = POS[0];
	PropInfo[propid][E_y] = POS[1];
	PropInfo[propid][E_z] = POS[2];
	PropInfo[propid][E_score] = p_score;
	PropInfo[propid][price] = p_price;
	PropInfo[propid][earnings] = p_earnings;
	PropInfo[propid][sold] = 0;

	strmid(PropInfo[propid][Owner], "ForSale", 0, 25, 25);

	new query[356];
	format(query, sizeof(query), "INSERT INTO `"#TABLE_PROP"` VALUES (NULL, '%s', %.2f, %.2f, %.2f, %i, %i, %i, 0, 0);",
		PropInfo[propid][Owner],
		PropInfo[propid][E_x],
	 	PropInfo[propid][E_y],
		PropInfo[propid][E_z],
		PropInfo[propid][price],
		PropInfo[propid][earnings],
		PropInfo[propid][E_score]);

    mysql_function_query(g_SQL_handle, query, false, "", "");
    mysql_function_query(g_SQL_handle, "SELECT * FROM `"#TABLE_PROP"` ORDER BY `ID` DESC LIMIT 1;", false, "OnPropLoadEx", "i", propid);

    propid++;
    return 1;
}

COMMAND:createhouse(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
		return SCM(playerid, RED, NO_PERM_ENG);
	}

	extract params -> new h_price, h_score, h_int; else
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /createhouse <price> <score> <int id>");
	}

	if(h_int > 13 || h_int < 0) return SCM(playerid, -1, ""er"Interior 0-13");

	new Float:POS[3];

	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);

	HouseInfo[houseid][E_x] = POS[0];
	HouseInfo[houseid][E_y] = POS[1];
	HouseInfo[houseid][E_z] = POS[2];
	HouseInfo[houseid][E_score] = h_score;
	HouseInfo[houseid][price] = h_price;
	HouseInfo[houseid][interior] = h_int;
	HouseInfo[houseid][locked] = 1;
	HouseInfo[houseid][sold] = 0;

	strmid(HouseInfo[houseid][Owner], "ForSale", 0, 25, 25);

	new query[255];
	format(query, sizeof(query), "INSERT INTO `"#TABLE_HOUSE"` VALUES (NULL, '%s', %.2f, %.2f, %.2f, %i, %i, %i, %i, %i, 0);",
	    HouseInfo[houseid][Owner],
	    HouseInfo[houseid][E_x],
	    HouseInfo[houseid][E_y],
	    HouseInfo[houseid][E_z],
	    HouseInfo[houseid][interior],
	    HouseInfo[houseid][price],
	    HouseInfo[houseid][E_score],
	    HouseInfo[houseid][sold],
	    HouseInfo[houseid][locked]);

    mysql_function_query(g_SQL_handle, query, false, "", "");
    mysql_function_query(g_SQL_handle, "SELECT * FROM `"#TABLE_HOUSE"` ORDER BY `ID` DESC LIMIT 1;", false, "OnHouseLoadEx", "i", houseid);

    houseid++;
    return 1;
}

COMMAND:createstore(playerid, params[])
{
    if(!IsPlayerAdmin(playerid) || PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
	{
		return SCM(playerid, RED, NO_PERM_ENG);
	}

	new string[80],
		file[50],
		labeltext[50],
		Float:POS[4];

	extract params -> new string:store[15]; else
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /createstore (bank/ammunation/burger/cluckinbell/pizza/247)");
	}

	if(strlen(store) < 3 || strlen(store) > 11)
	{
		return SCM(playerid, NGS_GREEN, "Usage: /createstore (bank/ammunation/burger/cluckinbell/pizza/247)");
	}

    if(strcmp(store, "bank", true) && strcmp(store, "ammunation", true) && strcmp(store, "burger", true) && strcmp(store, "cluckinbell", true) && strcmp(store, "pizza", true) && strcmp(store, "247", true))
	{
		return SCM(playerid, NGS_GREEN, "Usage: /createstore (bank/ammunation/burger/cluckinbell/pizza/247)");
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
				return SCM(playerid, -1, ""er"Unable to create more banks. There are already "#MAX_BANKS" created");
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
				return SCM(playerid, -1, ""er"Unable to create more banks. There are already "#MAX_AMMUNATIONS" created");
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
				return SCM(playerid, -1, ""er"There are already "#MAX_BURGERSHOTS" created");
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
				return SCM(playerid, -1, ""er"There are already "#MAX_CLUCKINBELLS" created");
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
				return SCM(playerid, -1, ""er"There are already "#MAX_PIZZASTACKS" created");
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
				return SCM(playerid, -1, ""er"There are already "#MAX_TFS" created");
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
		CreateDynamic3DTextLabel(lstring, YELLOW, POS[0], POS[1], floatadd(POS[2], 0.7), 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
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
		SCM(playerid, YELLOW, string);
	}
    return 1;
}

COMMAND:rules(playerid, params[])
{
	new rules[512];

	strcat(rules, ""white"- No cheating of any kind\n- Do not ask others to gift you money\n- No mods that affect other player's gameplay\n- No insult\n- No advertising of any kind\n- No (command)spamming\n");
	strcat(rules, "- No abusing bugs/glitches/commands\n- Do not share your account\n- No AFK in minigames\n- Do not ask for an unban ingame\n- Do not ask for an admin level/free VIP\n- Do not use Vortex to driveby players\n- Do not driveby at Hotspots/Spawnareas");

    ShowPlayerDialog(playerid, RULES_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Rules", rules, "OK", "");
	return 1;
}

COMMAND:rule(playerid, params[])
{
	cmd_rules(playerid, "");
	return 1;
}

COMMAND:kills(playerid, params[])
{
	new kills[MAX_PLAYERS][e_top_kills],
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

    ShowPlayerDialog(playerid, MOST_KILLS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Most Kills", finstring, "OK", "");
	return 1;
}

COMMAND:deaths(playerid, params[])
{
	new deaths[MAX_PLAYERS][e_top_deaths],
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

    ShowPlayerDialog(playerid, MOST_DEATHS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Most Deaths", finstring, "OK", "");
	return 1;
}

COMMAND:toptime(playerid, params[])
{
	new playingtime[MAX_PLAYERS][e_top_time],
		finstring[2048],
		tmpstring[68];

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
	        playingtime[i][E_playerid] = i;
		    PlayerInfo[i][TotalTime] = PlayerInfo[i][TotalTime] + (gettime() - PlayerInfo[i][ConnectTime]);
		    PlayerInfo[i][ConnectTime] = gettime();
	        playingtime[i][E_time] = PlayerInfo[i][TotalTime];
	    }
	    else
	    {
	        playingtime[i][E_playerid] = -1;
	        playingtime[i][E_time] = -1;
	    }
	}

	SortDeepArray(playingtime, E_time, .order = SORT_DESC);

	for(new i = 0; i < 30; i++)
	{
	    if(playingtime[i][E_time] != -1)
	    {
		    format(tmpstring, sizeof(tmpstring), "{%06x}%i - %s(%i) - Time: %s\n", (GetPlayerColor(playingtime[i][E_playerid]) >>> 8), i + 1, __GetName(playingtime[i][E_playerid]), playingtime[i][E_playerid], GetPlayingTimeFormat(playingtime[i][E_playerid]));
		    strcat(finstring, tmpstring);
		}
		else
		{
		    format(tmpstring, sizeof(tmpstring), ""white"%i - ---\n", i + 1);
		    strcat(finstring, tmpstring);
		}
	}

    ShowPlayerDialog(playerid, MOST_PLAYING_TIME_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Most Playing Time", finstring, "OK", "");
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
		    format(tmpstring, sizeof(tmpstring), "{%06x}%i - %s(%i) - Money: $%s\n", (GetPlayerColor(richlist[i][E_playerid]) >>> 8), i + 1, __GetName(richlist[i][E_playerid]), richlist[i][E_playerid], ToCurrency(richlist[i][E_money]));
		    strcat(finstring, tmpstring);
		}
		else
		{
		    format(tmpstring, sizeof(tmpstring), ""white"%i - ---\n", i + 1);
		    strcat(finstring, tmpstring);
		}
	}

    ShowPlayerDialog(playerid, RICHLIST_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Richlist", finstring, "OK", "");
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
	ShowPlayerDialog(playerid, WANTEDS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Most wanteds", finstring, "OK", "");
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
	ShowPlayerDialog(playerid, SCORE_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Score", finstring, "OK", "");
	return 1;
}

COMMAND:groups(playerid, params[])
{
	cmd_gangs(playerid, "");
	return 1;
}

COMMAND:gangs(playerid, params[])
{
	new Iterator:Gangs[2]<MAX_PLAYERS>,
		finstring[1500],
		tmpstring[35];

	Iter_Init(Gangs);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerAvail(i)) continue;
        if(PlayerInfo[i][GangID] > 0 && !Iter_Contains(Gangs[0], PlayerInfo[i][GangID]))
        {
            Iter_Add(Gangs[0], PlayerInfo[i][GangID]);
            Iter_Add(Gangs[1], i);
        }
	}

	if(Iter_Count(Gangs[1]) > 0)
	{
	    format(tmpstring, sizeof(tmpstring), ""white"%i gang(s) online:\n", Iter_Count(Gangs[1]));
	    strcat(finstring, tmpstring);

	    for(new i = Iter_First(Gangs[1]), count = 0; i != Iter_End(Gangs[1]); i = Iter_Next(Gangs[1], i), ++count)
	    {
	        if(count <= 40)
	        {
	        	format(tmpstring, sizeof(tmpstring), "\n%i - [%s] %s", count + 1, PlayerInfo[i][GangTag], PlayerInfo[i][GangName]);
	        	strcat(finstring, tmpstring);
			}
			else
			{
			    format(tmpstring, sizeof(tmpstring), "\n[... to many online]");
			    strcat(finstring, tmpstring);
			    break;
			}
	    }
		ShowPlayerDialog(playerid, GANGS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Online Gangs", finstring, "OK", "");
	}
	else
	{
	    SendInfo(playerid, "~h~~y~No Gangs Online!", 2100);
	}
	return 1;
}

COMMAND:gtop(playerid, params[])
{
	mysql_function_query(g_SQL_handle, "SELECT `GangName`, `GangTag`, `GangScore` FROM `"#TABLE_GANG"` ORDER BY `GangScore` DESC LIMIT 30;", true, "OnGTopReceived", "i", playerid);
	return 1;
}

function:OnGTopReceived(playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, g_SQL_handle);
	
	if(rows > 0)
	{
	    new tmp[21], tmp2[5], finstring[1024], tmpstring[40];
	    strcat(finstring, ""white"");
	    for(new i = 0; i < rows; i++)
	    {
	        cache_get_row(i, 0, tmp, g_SQL_handle, sizeof(tmp));
	        cache_get_row(i, 1, tmp2, g_SQL_handle, sizeof(tmp2));
	        format(tmpstring, sizeof(tmpstring), "%i - [%s]%s [%i]\n", i + 1, tmp2, tmp, cache_get_row_int(i, 2, g_SQL_handle));
	        strcat(finstring, tmpstring);
	    }
	    ShowPlayerDialog(playerid, TOP_GANGS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Top Gangs", finstring, "OK", "");
	}
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
	ShowPlayerDialog(playerid, TOPLIST_DIALOG, DIALOG_STYLE_LIST, ""se" - Toplists", ""dl"Richlist (/richlist)\n"dl"Most Wanteds (/wanteds)\n"dl"Score (/score)\n"dl"Most Kills (/kills)\n"dl"Most Deaths (/deaths)\n"dl"Most playing time (/toptime)\n"dl"Online Gangs (/gangs)\n"dl"Top Gangs (/gtop)", "Select", "");
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

COMMAND:vctrl(playerid, params[])
{
	cmd_vcontrol(playerid, "");
	return 1;
}

COMMAND:vcs(playerid, params[])
{
	cmd_vcontrol(playerid, "");
	return 1;
}

COMMAND:vcontrol(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 1)
	{
	    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);

		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		{
		    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
		}

		ShowDialog(playerid, VCONTROL_DIALOG);
	}
	else
	{
	    cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:labels(playerid, params[])
{
	cmd_label(playerid, "");
	return 1;
}

COMMAND:label(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 1)
	{
	    if(PlayerInfo[playerid][VIPLabel] == Text3D:-1)
	    {
	        ShowDialog(playerid, LABEL_DIALOG);
	    }
	    else
	    {
			SCM(playerid, -1, ""er"You already got a label. Tpye /elabel to edit or /dlabel to detach it.");
		}
	}
	else
	{
	    cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:elabel(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 1)
	{
	    if(PlayerInfo[playerid][VIPLabel] != Text3D:-1)
	    {
	        ShowDialog(playerid, LABEL_DIALOG + 1);
	    }
	    else
	    {
		    SCM(playerid, -1, ""er"No label attached");
		}
	}
	else
	{
	    cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:dlabel(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 1)
	{
	    if(PlayerInfo[playerid][VIPLabel] != Text3D:-1)
	    {
	        DestroyDynamic3DTextLabel(PlayerInfo[playerid][VIPLabel]);
	        PlayerInfo[playerid][VIPLabel] = Text3D:-1;
	        SCM(playerid, -1, ""er"Label removed!");
	    }
	    else
	    {
			SCM(playerid, -1, ""er"No label attached");
		}
	}
	else
	{
	    cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:trailer(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 1)
	{
	    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	    
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		{
		    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to attach a trailer!");
		}
		
		new vid = GetPlayerVehicleID(playerid);
		new model = GetVehicleModel(vid);
		
		if(model == 403 || model == 514 || model == 515)
		{
			if(PlayerInfo[playerid][TrailerVid] != -1)
			{
				DestroyVehicle(PlayerInfo[playerid][TrailerVid]);
				PlayerInfo[playerid][TrailerVid] = -1;
			}
		
		    new Float:p[4];
		    
			GetVehiclePos(vid, p[0], p[1], p[2]);
			GetVehicleZAngle(vid, p[3]);
			
			p[0] += (floatsin(-p[3], degrees) * -9);
			p[1] += (floatcos(-p[3], degrees) * -9);
			
			PlayerInfo[playerid][TrailerVid] = CreateVehicle(435, p[0], p[1], p[2], p[3], 0, 0, -1);
			
			SendInfo(playerid, "~h~~y~Trailer attached", 2000);
		}
		else
		{
		    SCM(playerid, -1, ""er"You need to be in a truck!");
		}
	}
	else
	{
	    cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:ramp(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 1)
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		{
		    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
		}

		if(GetPVarInt(playerid, "Ramped") == 0)
		{
			SetPVarInt(playerid, "Ramped", 1);
			SCM(playerid, GREEN, "You have turned ramp spawning ON!");
	  		SCM(playerid, YELLOW, "Press 'FIRE' (CTRL) key in a vehicle to spawn a ramp");
	    	SCM(playerid, YELLOW, "To disable ramp spawning, type /ramp again");
		}
		else
		{
			SetPVarInt(playerid, "Ramped", 0);
	 		SCM(playerid, GREEN, "You have turned ramp spawning OFF!");
		}
	}
	else
	{
	    cmd_vip(playerid, "");
	}
    return 1;
}

COMMAND:vmenu(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
    if(GetPVarInt(playerid, "doingStunt") != 0) return SCM(playerid, -1, ""er"You can't spawn a car now");
    
    if(PlayerInfo[playerid][BuyAbleVeh] == 1)
    {
    	ShowDialog(playerid, VMENU_DIALOG);
	}
	else
	{
	    SCM(playerid, -1, ""er"You dont have a private vehcile!");
	}
	return 1;
}

COMMAND:harefill(playerid, params[])
{
    if(PlayerInfo[playerid][VIP] == 1)
	{
	    if(PlayerInfo[playerid][bGod]) return SCM(playerid, -1, ""er"You need to disable GodMode first. (/god)");
	    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	    ShowDialog(playerid, HAREFILL_DIALOG);
	}
	else
	{
	    cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:spec(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid) || PlayerInfo[playerid][VIP] == 1)
	{
	    new player;
	 	if(sscanf(params, "r", player))
		{
			return SCM(playerid, NGS_GREEN, "Usage: /spec <playerid>");
	  	}

	  	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");

		if(PlayerInfo[playerid][Level] == 0 && PlayerInfo[playerid][VIP] == 1 && PlayerInfo[player][Level] > 0)
		{
			return SCM(playerid, -1, ""er"You cannot spectate admins");
		}

		if(PlayerInfo[player][Level] == MAX_ADMIN_LEVEL && PlayerInfo[playerid][Level] != MAX_ADMIN_LEVEL)
		{
			return SCM(playerid, -1, ""er"You cannot use this command on this admin");
		}

		if(gTeam[playerid] != NORMAL)
		{
			cmd_exit(playerid, "");
		}

        if(IsPlayerAvail(player) && player != playerid)
		{
			if(gTeam[player] == SPEC)
			{
				return SCM(playerid, -1, ""er"Player is spectating someone else");
			}
			if(PlayerInfo[player][IsDead])
			{
				return SCM(playerid, -1, ""er"Player is dead");
			}
			
			gTeam[playerid] = SPEC;
			
			GetPlayerPos(playerid, PlayerInfo[playerid][SpecX], PlayerInfo[playerid][SpecY], PlayerInfo[playerid][SpecZ]);
			GetPlayerFacingAngle(playerid, PlayerInfo[playerid][SpecA]);

			SetPlayerInterior(playerid, GetPlayerInterior(player));
			SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(player));
			TogglePlayerSpectating(playerid, true);

			if(IsPlayerInAnyVehicle(player))
			{
				PlayerSpectateVehicle(playerid, GetPlayerVehicleID(player));
				PlayerInfo[playerid][SpecID] = player;
			}
			else
			{
				PlayerSpectatePlayer(playerid, player);
				PlayerInfo[playerid][SpecID] = player;
			}

			new string[144],
				Float:hp,
				Float:ar,
				count = 0;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(gTeam[i] == SPEC && PlayerInfo[i][SpecID] == player)
			    {
			        count++;
			    }
			}

			if(count == 1)
			{
				format(string, sizeof(string), ""WHITE_E"["BLUE_E"SE"WHITE_E"] "GREY_E"%s(%i) is also spectated by another admin/VIP (/spectators)", __GetName(player), player);
			}
			else if(count > 1)
			{
			    format(string, sizeof(string), ""WHITE_E"["BLUE_E"SE"WHITE_E"] "GREY_E"%s(%i) is also spectated by %i other admins/VIPs (/spectators)", __GetName(player), player, count);
			}

			GetPlayerHealth(player, hp);
			GetPlayerArmour(player, ar);
			format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~n~~n~~w~%s - id:%i~n~hp:%0.1f ar:%0.1f $%s", __GetName(player), player, hp, ar, ToCurrency((GetPlayerCash(player) + PlayerInfo[player][Bank])));
			GameTextForPlayer(playerid, string, 30000, 3);
			
			SendInfo(playerid, "~y~~h~Now spectating!", 2500);
		}
		else
		{
			SCM(playerid, -1, ""er"Player is not connected or unavailable");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:specoff(playerid, params[])
{
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid) || PlayerInfo[playerid][VIP] == 1)
	{
        if(gTeam[playerid] == SPEC)
		{
		    ResetPlayerWorld(playerid);
		    PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;
			TogglePlayerSpectating(playerid, false);
			GameTextForPlayer(playerid, "~n~~n~~n~~w~Spectate mode ended", 1000, 3);
			SendInfo(playerid, "~y~~h~No longer spectating!", 2500);
		}
		else
		{
			SendInfo(playerid, "~r~~h~You are not spectating!", 2500);
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
			SCM(playerid, NGS_GREEN, "Usage: /freeze <playerid>");
			return 1;
	 	}
	 	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
	 	if(player == playerid) return SCM(playerid, -1, ""er"You can't freeze yourself!");
	 	
		if(IsPlayerAvail(player))
		{
		 	if(gTeam[player] != NORMAL)
	 		{
	 		    cmd_exit(player, "");
			}

			SCM(player, RED, "You have been freezed by an admin");
			TogglePlayerControllable(player, false);
			PlayerInfo[player][Frozen] = true;
		}
		else
		{
		    SCM(playerid, -1, ""er"Invalid player");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
			SCM(playerid, NGS_GREEN, "Usage: /unfreeze <playerid>");
			return 1;
	 	}
	 	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Invalid player!");
	 	
	 	if(PlayerInfo[player][Frozen])
 		{
			TogglePlayerControllable(player, true);
			PlayerInfo[player][Frozen] = false;
			SCM(player, GREEN, "You have been unfreezed by an admin");
		}
		else
		{
		    SCM(playerid, -1, ""er"Not possible to unfreeze him now");
		}
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:clearchat(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 3)
	{
		for(new i = 0; i < 129; i++)
		{
			SCMToAll(GREEN, " ");
		}
 	}
 	else
 	{
	 	SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:move(playerid, params[])
{
	if(gTeam[playerid] == NORMAL)
	{
	    if(GetPVarInt(playerid, "doingStunt") != 0) return SCM(playerid, -1, ""er"You cant use this command now!");
		if(PlayerInfo[playerid][Level] >= 2)
		{
		    if(!strlen(params))
			{
				SCM(playerid, NGS_GREEN, "Usage: /move [up / down / +x / -x / +y / -y / off]");
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
		    else if(!strcmp(params, "off", true))
			{
				TogglePlayerControllable(playerid, true);
			}
			else
			{
				SCM(playerid, NGS_GREEN, "Usage: /move [up / down / +x / -x / +y / -y / off]");
			}
		}
		else
		{
			SCM(playerid, RED, NO_PERM_ENG);
		}
	}
	else
	{
 		SCM(playerid, RED, NOT_AVAIL);
	}
	return 1;
}

COMMAND:paint(playerid, params[])
{
	cmd_cc(playerid, params);
	return 1;
}

COMMAND:vcolor(playerid, params[])
{
	cmd_cc(playerid, params);
	return 1;
}

COMMAND:cc(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, -1, ""er"You have to be in a vehicle");

    new color1, color2;
    if(sscanf(params, "ii", color1, color2))
    {
        return SCM(playerid, NGS_GREEN, "Usage: /cc <color1 id> <color2 id>");
    }

	if(color1 > 255 || color2 > 255 || color1 < 0 || color2 < 0)
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /cc <color1 id> <color2 id>");
	}

    if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][PV_Vehicle])
    {
        PlayerInfoVeh[playerid][Color1] = color1;
        PlayerInfoVeh[playerid][Color2] = color2;
        GivePlayerCash(playerid, -500);
	}

	ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
	PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
	SendInfo(playerid, "~h~~y~Changed Vehicle Color", 2000);
	return 1;
}

COMMAND:changepassword(playerid, params[])
{
	cmd_changepass(playerid, "");
	return 1;
}

COMMAND:changename(playerid, params[])
{
	ShowDialog(playerid, NAME_CHANGE_DIALOG);
	return 1;
}

COMMAND:changepass(playerid, params[])
{
    new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastPW] + COOLDOWN_CMD_CHANGEPASS) >= tick)
	{
    	return SCM(playerid, -1, ""er"Please wait a bit before using this cmd again!");
	}

	new pass[144];
	if(sscanf(params, "s[144]", pass))
	{
		SCM(playerid, NGS_GREEN, "Usage: /changepass <new pass>");
	    return 1;
	}
	if(strlen(pass) < 4 || strlen(pass) > 32)
	{
		SCM(playerid, -1, ""er"Incorrect password length. (4 - 32)");
		return 1;
	}
	new string[128];
    MySQL_UpdatePlayerPass(playerid, pass);
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
    format(string, sizeof(string), ""server_sign" You have successfully changed your password to %s", pass);
	SCM(playerid, -1, string);
	PlayerInfo[playerid][tickLastPW] = tick;
	return 1;
}

COMMAND:stats(playerid, params[])
{
	new player1,
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
		new gangnam[21],
		    houseyn[7],
			propyn[7],
			string1[255],
			string2[300],
			string3[300],
			vip[5],
			pDeaths,
			finstring[sizeof(string1) + sizeof(string2) + sizeof(string3) + sizeof(vip)];
			
 		if(PlayerInfo[player1][Deaths] == 0)
	 	{
	 		pDeaths = 1;
	 	}
	 	else
	 	{
	 		pDeaths = PlayerInfo[player1][Deaths];
	 	}

		if(PlayerInfo[player1][GangPosition] == 0)
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
		
		if(PlayerInfo[playerid][VIP] != 0)
		{
		    strmid(vip, "Yes", 0, 5, 5);
		}
		else
		{
		    strmid(vip, "No", 0, 5, 5);
		}

 		format(string1, sizeof(string1), "\n"ngs_blue"Stats of the player: "white"%s\n\n\
	 	Kills:\t\t\t %i\nDeaths:\t\t\t %i\nK/D:\t\t\t %0.2f\nScore:\t\t\t %i\nCash:\t\t\t $%s\nBank Cash:\t\t $%s\n",
   			__GetName(player1),
	 		PlayerInfo[player1][Kills],
        	PlayerInfo[player1][Deaths],
        	Float:PlayerInfo[player1][Kills] / Float:pDeaths,
        	_GetPlayerScore(player1),
        	ToCurrency(GetPlayerCash(player1)),
        	ToCurrency(PlayerInfo[player1][Bank]));

		format(string2, sizeof(string2), "Race wins:\t\t %i\nDerby wins:\t\t %i\nReaction wins:\t\t %i\nTDM wins:\t\t %i\nFallout wins:\t\t %i\nGungame wins:\t\t %i\nTime until PayDay:\t %i minutes\n",
	   		PlayerInfo[player1][RaceWins],
	   		PlayerInfo[player1][DerbyWins],
	   		PlayerInfo[player1][Reaction],
	   		PlayerInfo[player1][BGWins],
	   		PlayerInfo[player1][FalloutWins],
	   		PlayerInfo[player1][GungameWins],
	   		PlayerInfo[player1][PayDay]);

        format(string3, sizeof(string3), "Playing Time:\t\t %s\nGang:\t\t\t %s\nVIP:\t\t\t %s\nHouse:\t\t\t %s\nBusiness:\t\t %s\nWanteds:\t\t %i\nRegister Date:\t\t %s\nLast log in:\t\t %s",
            GetPlayingTimeFormat(player1),
			gangnam,
			vip,
			houseyn,
			propyn,
			PlayerInfo[player1][Wanteds],
			UnixTimeToDate(PlayerInfo[player1][RegDate]),
			UnixTimeToDate(PlayerInfo[player1][LastLogged]));

		strcat(finstring, string1);
		strcat(finstring, string2);
		strcat(finstring, string3);

		ShowPlayerDialog(playerid, STATS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Player Statistics", finstring, "OK", "");
	}
	else
	{
		SCM(playerid, -1, ""er"Player is not connected!");
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
		SCMToAll(BLUE, string);
		GameTextForAll("Health for all!", 3000, 3);
		SetPlayerHealth(playerid, 100.0);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
		SCMToAll(BLUE, string);
		GameTextForAll("Armour for all!", 3000, 3);
		SetPlayerArmour(playerid, 100.0);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
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
		return SCM(playerid, NGS_GREEN, "Usage: /pay <playerid> <money>");
	}
	if(IsPlayerAvail(player))
	{
    	if(GetPlayerCash(playerid) < cash)
		{
			return SCM(playerid, RED, "You don't have that much!");
		}
    	if(cash < 1000 || cash > 1000000)
		{
			return SCM(playerid, YELLOW, "Info: $1,000 - $1,000,000");
		}
    	if(player == playerid)
		{
			return SCM(playerid, RED, "You can't pay yourself");
		}
		new string[100];
      	GivePlayerCash(playerid, -cash);
      	GivePlayerCash(player, cash);
        format(string, sizeof(string), "Info: %s paid you $%s", __GetName(playerid), ToCurrency(cash));
        SCM(player, YELLOW, string);
        SCM(playerid, YELLOW, "Successfully paid the money!");
    }
    else
    {
        SCM(playerid, -1, ""er"Player is not connected");
    }
	return 1;
}

COMMAND:pornos(playerid, params[])
{
    SCM(playerid, RED, "Du kannst mir mal fett ein kauen, kein Godfather.");
	return 1;
}

COMMAND:upgrade(playerid, params[])
{
    if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
	if(PlayerInfo[playerid][Houses] == 0) return SCM(playerid, -1, ""er"You don't own a house");

    new bool:found = false;
	for(new i = 0; i < houseid; i++)
	{
	    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
	    found = true;
		ShowDialog(playerid, HOUSE_UPGRADE_DIALOG);
	}
	if(!found) SCM(playerid, -1, ""er"You need to stand in your house pickup (Entrance)");
	return 1;
}

COMMAND:upgrades(playerid, params[])
{
	cmd_upgrade(playerid, "");
	return 1;
}

COMMAND:houseupgrades(playerid, params[])
{
	cmd_upgrade(playerid, "");
	return 1;
}

COMMAND:houseupgrade(playerid, params[])
{
	cmd_upgrade(playerid, "");
	return 1;
}

COMMAND:settings(playerid, params[])
{
	if(gTeam[playerid] != NORMAL) return SCM(playerid, RED, NOT_AVAIL);
    ShowDialog(playerid, SETTINGS_DIALOG);
	return 1;
}

COMMAND:cp(playerid, params[])
{
	cmd_settings(playerid, "");
	return 1;
}

COMMAND:advsave(playerid, params[])
{
    if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL && IsPlayerAdmin(playerid))
    {
	    new File:lFile = fopen("Other/advsave.txt", io_append),
	     	logData[255],
	        Float:POS[4];

		GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), POS[3]);

	    format(logData, sizeof(logData), "{%.4f, %.4f, %.4f, %.4f, false},\r\n", POS[0], POS[1], POS[2], POS[3]);
	    fwrite(lFile, logData);
	    fclose(lFile);
	}
	return 1;
}

COMMAND:m(playerid, params[])
{
	cmd_minigames(playerid, "");
	return 1;
}

COMMAND:minigames(playerid, params[])
{
	ShowPlayerDialog(playerid, HELP_DIALOG + 3, DIALOG_STYLE_LIST, ""se" - Minigames", ""dl"Race (/race)\n"dl"Derby (/derby)\n"dl"Fallout (/fallout)\n"dl"Gungame (/gungame)\n"dl"Minigun (/minigun)\n"dl"Sniper (/sniper)\n"dl"Death Match (/dm1-4)\n"dl"Team Death Match (/tdm)\n"dl"WAR (/war)", "Select", "");
	return 1;
}

COMMAND:minigame(playerid, params[])
{
	cmd_minigames(playerid, "");
	return 1;
}

COMMAND:opengate(playerid, params[])
{
	if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL || PlayerInfo[playerid][VIP] == 1)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 15.0, 1012.0341, -2068.1919, 13.8425)) return SCM(playerid, -1, ""er"You need to be closer");
		if(IsMellnikGateMoving) return SCM(playerid, -1, ""er"Gate is currently working");
		IsMellnikGateMoving = true;
		MoveDynamicObject(MellnikGate, 1020.15161, -2069.69775, 13.84253, 1.50);
  	}
	else
	{
        cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:closegate(playerid, params[])
{
	if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL || PlayerInfo[playerid][VIP] == 1)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 15.0, 1012.0341, -2068.1919, 13.8425)) return SCM(playerid, -1, ""er"You need to be closer");
		if(IsMellnikGateMoving) return SCM(playerid, -1, ""er"Gate is currently working");
		IsMellnikGateMoving = true;
		MoveDynamicObject(MellnikGate, 1012.05396, -2068.18970, 13.84253, 1.50);
  	}
	else
	{
	    cmd_vip(playerid, "");
	}
	return 1;
}

COMMAND:mellnik(playerid, params[])
{
	if(PlayerInfo[playerid][Level] == MAX_ADMIN_LEVEL)
	{
		SetPlayerSkin(playerid, 295);
	    SetPlayerAttachedObject(playerid, 9, 358, 1, 0.2, -0.125, -0.1, 0.0, 25.0, 180.0, 1, 1, 1);
	    SetSpawnInfo(playerid, NO_TEAM, 295, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
  	}
	else
	{
	    SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:antifall(playerid, params[])
{
	new str[144];
	if(GetPVarInt(playerid, "AntiFall") == 0)
	{
		SetPVarInt(playerid, "AntiFall", 1);
	    SendClientMessage(playerid, COLOR_GOLD, "Anti-fall has been turned on.");
		format(str, sizeof(str),"5%s(%i)3 has turned anti-fall on.", __GetName(playerid), playerid);
	}
	else
	{
	    SetPVarInt(playerid, "AntiFall", 0);
	    SendClientMessage(playerid, COLOR_GOLD, "Anti-fall has been turned off.");
		format(str, sizeof(str),"5%s(%i)3 has turned anti-fall off.", __GetName(playerid), playerid);
	}
	return 1;
}

COMMAND:ans(playerid, params[])
{
    cmd_answer(playerid, params);
	return 1;
}

COMMAND:answer(playerid, params[])
{
	new answer;
	if(sscanf(params, "i", answer))
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /answer <answer>");
	}
	
	new str[255];
	if(mathsAnswered == -1)
	{
	    SCM(playerid, -1, ""RED_E"[MATHS] "LB2_E"Sorry, not maths is in progress!");
	    return true;
	}

	if(mathsAnswered == 1 && answer == mathsAnswer)
	{
	    if(answer == mathsAnswer)
	    {
	    	format(str, sizeof(str), ""RED_E"[MATHS] "LB2_E"Sorry, you're too late, although your answer(%i) would have been right!", answer);
		}
		else
		{
		    format(str, sizeof(str), ""RED_E"[MATHS] "LB2_E"Sorry, you're too late, even though your answer(%i) would have been wrong!", answer);
		}
		SCM(playerid, -1, str);
	    return true;
	}

	if(answer > mathsAnswer || answer < mathsAnswer)
	{
	    format(str, sizeof(str), ""RED_E"[MATHS] "LB2_E"Sorry, your answer(%i) to %s is wrong!", answer, mathsCurrent);
	    SCM(playerid, -1, str);
		return true;
	}

	format(str, sizeof(str), ""RED_E"[MATHS] :: {%06x}%s(%i) "LB2_E"has correctly answered %s (answer: %i) winning 4 score and $%s!", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, mathsCurrent, answer, ToCurrency(mathsAward));
	SCMToAll(-1, str);

	_GivePlayerScore(playerid, 4);
	GivePlayerCash(playerid, mathsAward);

	mathsAnswered = 1;
	SendInfo(playerid, "~p~Congratulations!~n~~r~You gave the right maths answer!", 4000);

	format(str, sizeof(str), "Won a math challenge.\n%s", mathsCurrent, answer);
	SetPlayerChatBubble(playerid, str, NGS_GREEN, 40.0, 12000);
	return true;
}

COMMAND:weather(playerid, params[])
{
	extract params -> new weather; else
	{
		return SCM(playerid, NGS_GREEN, "Usage: /weather <weather id>");
	}

	SetPlayerWeather(playerid, weather);

	new string[64];
	format(string, sizeof(string), "You've set your weather to '%i'", weather);
	SCM(playerid, BLUE, string);
	return 1;
}

COMMAND:cashfall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
		extract params -> new money; else
		{
			return SCM(playerid, NGS_GREEN, "Usage: /cashfall <cash>");
		}

		if(money > 50000 || money < 1000) return SCM(playerid, -1, ""er"Cash: $1,000 - $50,000");

		new string[100];
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerAvail(i))
			{
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				GivePlayerCash(i, money);
			}
		}
		format(string, sizeof(string), "~y~$%s ~w~for all!", ToCurrency(money));
		GameTextForAll(string, 5000, 0);
		format(string, sizeof(string), "Admin %s(%i) has given all players $%s", __GetName(playerid), playerid, ToCurrency(money));
		SCMToAll(YELLOW, string);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:scorefall(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
		extract params -> new score; else
		{
			return SCM(playerid, NGS_GREEN, "Usage: /scorefall <cash>");
		}

		if(score > 100 || score < 1) return SCM(playerid, -1, ""er"Score: 1 - 100");

		new string[100];
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerAvail(i))
			{
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				_GivePlayerScore(i, score);
			}
		}
		format(string, sizeof(string), "~y~%i Score ~w~for all!", score);
		GameTextForAll(string, 5000, 0);
		format(string, sizeof(string), "Admin %s(%i) has given all players %i Score", __GetName(playerid), playerid, score);
		SCMToAll(YELLOW, string);
	}
	else
	{
		SCM(playerid, RED, NO_PERM_ENG);
	}
	return 1;
}

COMMAND:ignore(playerid, params[])
{
    new player;
	if(sscanf(params, "r", player))
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /ignore <playerid>");
	}

	if(player == INVALID_PLAYER_ID) return SCM(playerid, -1, ""er"Player not connected or a NPC!");
	if(player == playerid) return SCM(playerid, -1, ""er"You cannot ignore yourself!");
	if(PlayerInfo[player][Level] > 0) return SCM(playerid, -1, ""er"You cannot ignore Admins!");

	new string[144];
	if(Iter_Contains(PlayerIgnore[playerid], player))
	{
		format(string, sizeof(string), ""er"You are already ignoring %s(%i)! Use /unignore to unignore.", __GetName(player), player);
		SCM(playerid, -1, string);
		return 1;
	}

	Iter_Add(PlayerIgnore[playerid], player);

	format(string, sizeof(string), "[IGNORE] %s(%i) is now ignored by you.", __GetName(player), player);
	SCM(playerid, YELLOW, string);
	SCM(playerid, -1, ""er"Type /unignore to recieve PMs from this player.");
	return 1;
}

COMMAND:unignore(playerid, params[])
{
	new player;
   	if(sscanf(params, "r", player))
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /unignore <playerid>");
	}

	if(player == INVALID_PLAYER_ID)
	{
		return SCM(playerid, -1, ""er"Player not connected or a NPC!");
	}

	new string[144];
	if(!Iter_Contains(PlayerIgnore[playerid], player))
	{
		format(string, sizeof(string), ""er"You aren't ignoring %s(%i)! Use /ignore to ignore.", __GetName(player), player);
		SCM(playerid, -1, string);
		return 1;
	}

	Iter_Remove(PlayerIgnore[playerid], player);

	format(string, sizeof(string), "[IGNORE] %s(%i) is not ignored by you anymore.", __GetName(player), player);
	SCM(playerid, YELLOW, string);
	return true;
}

COMMAND:pn(playerid, params[])
{
	cmd_pm(playerid, params);
	return 1;
}

COMMAND:pm(playerid, params[])
{
	if(PlayerInfo[playerid][Muted])
	{
	    SCM(playerid, RED, "You are muted! Please wait until the time is over!");
	    return 0;
	}

	new player, msg[144], finmsg[144];
	if(sscanf(params, "rs[144]", player, msg))
	{
		return SCM(playerid, NGS_GREEN, "Usage: /pm <playerid> <message>");
	}
	new tick = GetTickCount() + 3600000;
	if((PlayerInfo[playerid][tickLastPM] + COOLDOWN_CMD_PM) >= tick)
	{
	    return SCM(playerid, -1, ""se" Please wait before sending a message again");
	}
    PlayerInfo[playerid][tickLastPM] = tick;

	new is1 = 0,
		r = 0,
		strR[255];

 	while(strlen(msg[is1]))
 	{
  		if('0' <= msg[is1] <= '9')
  		{
 			new is2 = is1 + 1,
			 	p = 0;

			while(p == 0)
  			{
   				if('0' <= msg[is2] <= '9' && strlen(msg[is2]))
		   		{
			  		is2++;
				}
 				else
  				{
				   	strmid(strR[r], msg, is1, is2, sizeof(strR));
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
	  	format(string, sizeof(string), ""yellow"** "red"Suspicion advertising | Player: %s(%i) Advertised IP: %s - PlayerIP: %s", __GetName(playerid), playerid, msg, __GetIP(playerid));
		AdminMSG(RED, string);

        SCM(playerid, RED, "Advertising is not allowed!");
        return 1;
	}

	if(!IsPlayerAvail(player))
	{
		return SCM(playerid, -1, ""er"Player is not connected!");
	}
	if(player == playerid)
	{
	    return SCM(playerid, -1, ""er"You can´t pm yourself");
	}
	if(Iter_Contains(PlayerIgnore[player], playerid))
	{
	    return SCM(playerid, -1, ""er"This player has blocked you from PMing him");
	}
	
	TextDrawShowForPlayer(playerid, CheckTD);
	TextDrawShowForPlayer(player, NewMsgTD);
	SetTimerEx("hideMsgTD", 3000, false, "i", player);
	SetTimerEx("hideCheck", 3000, false, "i", playerid);
	
	format(finmsg, sizeof(finmsg), "***[PM] from %s(%i): %s", __GetName(playerid), playerid, msg);
    SCM(player, YELLOW, finmsg);
	format(finmsg, sizeof(finmsg), ">>>[PM] to %s(%i): %s", __GetName(player), player, msg);
	SCM(playerid, YELLOW, finmsg);
	SetPVarInt(player, "LastID", playerid);

   	format(finmsg, sizeof(finmsg), "~g~~h~PM from ~y~%s(%i)", __GetName(playerid), playerid);
	InfoTD_MSG(player, 3500, finmsg);
	format(finmsg, sizeof(finmsg), "~g~~h~PM sent to ~b~~h~%s(%i)!", __GetName(player), player);
	InfoTD_MSG(playerid, 3500, finmsg);

	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	PlayerPlaySound(player, 1057, 0.0, 0.0, 0.0);

	format(finmsg, sizeof(finmsg), "[PM] from %s(%i) to %s(%i): %s", __GetName(playerid), playerid, __GetName(player), player, msg);
	AdminMSG(GREY, finmsg);
	return 1;
}

COMMAND:r(playerid, params[])
{
    if(GetPVarInt(playerid, "LastID") == -1)
	{
		return SCM(playerid, -1, ""er"Noone has send you a message yet");
	}

	extract params -> new string:msg[128]; else
	{
	    return SCM(playerid, NGS_GREEN, "Usage: /r <message>");
	}
	new finmsg[144];

	new is1 = 0,
		r = 0,
		strR[255];

 	while(strlen(msg[is1]))
 	{
  		if('0' <= msg[is1] <= '9')
  		{
 			new is2 = is1 + 1,
			 	p = 0;

			while(p == 0)
  			{
   				if('0' <= msg[is2] <= '9' && strlen(msg[is2]))
		   		{
			  		is2++;
				}
 				else
  				{
				   	strmid(strR[r], msg, is1, is2, sizeof(strR));
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
	  	format(string, sizeof(string), ""yellow"** "red"Suspicion advertising | Player: %s(%i) Advertised IP: %s - PlayerIP: %s", __GetName(playerid), playerid, msg, __GetIP(playerid));
		AdminMSG(RED, string);

        SCM(playerid, RED, "Advertising is not allowed!");
        return 1;
	}

	new lID = GetPVarInt(playerid, "LastID");
	if(!IsPlayerAvail(lID))
	{
		return SCM(playerid, -1, ""er"Player is not connected!");
	}
	if(Iter_Contains(PlayerIgnore[lID], playerid))
	{
	    return SCM(playerid, -1, ""er"This player has blocked you from PMing him");
	}
	format(finmsg, sizeof(finmsg), "***[PM] from %s(%i): %s", __GetName(playerid), playerid, msg);
    SCM(lID, YELLOW, finmsg);
	format(finmsg, sizeof(finmsg), ">>>[PM] to %s(%i): %s", __GetName(lID), lID, msg);
	SCM(playerid, YELLOW, finmsg);
	SetPVarInt(lID, "LastID", playerid);

	TextDrawShowForPlayer(playerid, CheckTD);
	TextDrawShowForPlayer(lID, NewMsgTD);
	SetTimerEx("hideMsgTD", 3000, false, "i", lID);
	SetTimerEx("hideCheck", 3000, false, "i", playerid);
	
   	format(finmsg, sizeof(finmsg), "~g~~h~PM from ~y~%s(%i)", __GetName(playerid), playerid);
	InfoTD_MSG(lID, 3500, finmsg);
	format(finmsg, sizeof(finmsg), "~g~~h~PM sent to ~b~~h~%s(%i)!", __GetName(lID), lID);
	InfoTD_MSG(playerid, 3500, finmsg);
	
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	PlayerPlaySound(lID, 1057, 0.0, 0.0, 0.0);

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
	if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, -1, ""er"GTFO of your vehicle first, sir");

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

	ShowPlayerDialog(playerid, TOY_DIALOG, DIALOG_STYLE_LIST, ""se" - Player Toys", string, "Select", "Cancel");
	return 1;
}

COMMAND:achievements(playerid, params[])
{
	cmd_achs(playerid, params);
	return 1;
}

COMMAND:erfolge(playerid, params[])
{
	cmd_achs(playerid, params);
	return 1;
}

COMMAND:ach(playerid, params[])
{
	cmd_achs(playerid, params);
	return 1;
}

COMMAND:achs(playerid, params[])
{
	new otherplayer, player;
	if(sscanf(params, "r", otherplayer))
	{
	    player = playerid;
	}
	else player = otherplayer;

	new tmp[e_player_ach_data][10],
		finstring[2048],
		str[144];

	for(new i = 0; e_player_ach_data:i < e_player_ach_data; i++)
	{
	    if(pAch[player][e_player_ach_data:i] == 1)
	    {
	        tmp[e_player_ach_data:i] = ""GREEN_E"•";
	    }
	    else
	    {
	        tmp[e_player_ach_data:i] = ""RED_E"•";
	    }
	}

    format(str, sizeof(str), ""white"[%s"white"] Styler "LB2_E"-> Buy a toy\n", tmp[E_ach_styler]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Grim Reaper "LB2_E"-> Make 150 kills\n", tmp[E_ach_grimreaper]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Mass Killer "LB2_E"-> Do a 25 Kill Streak\n", tmp[E_ach_masskiller]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Elite Racer "LB2_E"-> Win 10 races\n", tmp[E_ach_eliteracer]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Too Fast "LB2_E"-> Win 10 Reaction Tests\n", tmp[E_ach_toofast]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Score Whore "LB2_E"-> Get 2000 score\n", tmp[E_ach_scorewhore]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Destroyer "LB2_E"-> Win 20 derbys\n", tmp[E_ach_destroyer]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Rest in Peace "LB2_E"-> Die 50 times\n", tmp[E_ach_restinpeace]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Silent Killer "LB2_E"-> Kill someone with a Knife\n", tmp[E_ach_silentkiller]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] One Shot Two Kills "LB2_E"-> Win 10 gungames\n", tmp[E_ach_oneshot2kills]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Deep Impact "LB2_E"-> Win 10 Fallout games\n", tmp[E_ach_deepimpact]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Skydiver "LB2_E"-> Win /skydive and /skydive2 in a row\n", tmp[E_ach_skydiver]);
    strcat(finstring, str);
    format(str, sizeof(str), ""white"[%s"white"] Biker "LB2_E"-> Win /bikec\n", tmp[E_ach_biker]);
    strcat(finstring, str);
    
    strcat(finstring, "\n\n"white"Use /achs <playerid> to see someone else's achievements");
    
	ShowPlayerDialog(playerid, ACHS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Achievements", finstring, "OK", "");
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
    ShowDialog(playerid, CMDS_DIALOG);
	return 1;
}

COMMAND:uptime(playerid, params[])
{
	SCM(playerid, GREY, GetUptime());
	return 1;
}

COMMAND:help(playerid, params[])
{
	ShowDialog(playerid, HELP_DIALOG);
    return 1;
}

COMMAND:anims(playerid, params[])
{
    new cstring[1024];
    strcat(cstring, ""ngs_blue"All animations are listed below:\n");
    strcat(cstring, ""white"/piss - /wank - /dance [1-3] /vomit\n/drunk - /sit - /wave - /lay - /smoke\n/rob - /cigar - /laugh - /handsup - /fucku\n\n");
	strcat(cstring, ""ngs_blue"To stop an animation:");
	strcat(cstring, "\n"white"You can press: [SHIFT], [ENTER], [LMB].");

	ShowPlayerDialog(playerid, ANIMS_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Animations", cstring, "OK", "");
	return 1;
}

COMMAND:sit(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "PED", "SEAT_down",3,0,1,1,1,1,1);
	return 1;
}

COMMAND:handsup(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);
	return 1;
}

COMMAND:cigar(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
	return 1;
}

COMMAND:piss(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "PAULNMAC", "Piss_loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:wank(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "PAULNMAC", "wank_loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:dance(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);

    extract params -> new dance; else
    {
        return SCM(playerid, NGS_GREEN, "Usage: /dance <1-3>");
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
  	    SCM(playerid, NGS_GREEN, "Usage: /dance <1-3>");
  	}

	return 1;
}

COMMAND:vomit(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:drunk(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "PED", "WALK_DRUNK",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:wave(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:lay(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "BEACH", "Lay_Bac_Loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:smoke(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "SHOP", "Smoke_RYD",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:rob(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "SHOP", "ROB_Loop",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:laugh(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
    ApplyAnimation(playerid, "RAPPING", "Laugh_01",4.1,0,1,1,1,1);
	return 1;
}

COMMAND:fucku(playerid, params[])
{
    if(gTeam[playerid] != NORMAL && gTeam[playerid] != HOUSE && gTeam[playerid] != VIPL) return SCM(playerid, RED, NOT_AVAIL);
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
	if(PlayerInfo[playerid][bGod]) return SCM(playerid, -1, ""er"You need to disable GodMode first. (/god)");
	if(gTeam[playerid] == NORMAL)
	{
		ShowDialog(playerid, WEAPON_DIALOG);
	}
	else
	{
  		SCM(playerid, RED, NOT_AVAIL);
	}
	return 1;
}

COMMAND:nos(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && gTeam[playerid] == NORMAL)
    {
        if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][PV_Vehicle])
        {
            return SCM(playerid, -1, ""er"Not useable in private vehicles");
        }
        else
        {
	        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
			AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
		}
	}
	else
	{
		SCM(playerid, GREY, NOT_AVAIL);
	}
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
    if(GetPVarInt(playerid, "doingStunt") != 0) return SCM(playerid, -1, ""er"You can't spawn a car now");
	if(IsPlayerInRangeOfPoint(playerid, 65.0, 1797.3141, -1302.0978, 120.2659) && PlayerInfo[playerid][Level] < 1) return SCM(playerid, -1, ""er"Can´t spawn vehicle at this place!");
	if(strlen(params) > 29) return SCM(playerid, NGS_BLUE, "I don´t know that vehicle...");

	if(gTeam[playerid] == NORMAL)
	{
	    if(IsNumeric(params))
	    {
			if(!IsValidVehicle(strval(params)))
			{
				return SCM(playerid, NGS_BLUE, "I don´t know that vehicle...");
			}

	        CarSpawner(playerid, strval(params));
	    }
	    else
	    {
		    new VehicleS[144];
			if(!sscanf(params, "s[144]", VehicleS))
			{
				new veh = GetVehicleModelID(VehicleS);
				if(!IsValidVehicle(veh))
				{
					return SCM(playerid, NGS_BLUE, "I don´t know that vehicle...");
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
  		SCM(playerid, RED, NOT_AVAIL);
	}
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
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

function:OnPlayerNameChangeRequest(newname[], playerid)
{
	new rows, fields;
	cache_get_data(rows, fields, g_SQL_handle);
	
	if(rows > 0)
	{
	    SCM(playerid, -1, ""er"Your name is already in use or contains invalid characters");
	}
	else
	{
	    new oldname[MAX_PLAYER_NAME], query[255];
	    strmid(oldname, __GetName(playerid), 0, MAX_PLAYER_NAME, sizeof(oldname));
	    
		if(SetPlayerName(playerid, newname) == 1)
        {
            if(PlayerInfo[playerid][Houses] > 0)
            {
				for(new i = 0; i < houseid; i++)
				{
    				if(strcmp(oldname, HouseInfo[i][Owner])) continue;

                    strmid(HouseInfo[i][Owner], newname, 0, 25, 25);

				    format(query, sizeof(query), ""house_mark"\nOwner: %s\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", __GetName(playerid), HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[HouseInfo[i][interior]][intname]);
				    UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, query);
				    MySQL_SaveHouse(i);
				    break;
				}
            }

            if(PlayerInfo[playerid][Props] > 0)
            {
				for(new i = 0; i < propid; i++)
				{
    				if(strcmp(oldname, PropInfo[i][Owner])) continue;

                    strmid(PropInfo[i][Owner], newname, 0, 25, 25);

				    format(query, sizeof(query), ""business_mark"\nOwner: %s\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", __GetName(playerid), PropInfo[i][iID], ToCurrency(PropInfo[i][price]), PropInfo[i][E_score], ToCurrency(PropInfo[i][earnings]));
				    UpdateDynamic3DTextLabelText(PropInfo[i][label], -1, query);
				    MySQL_SaveProp(i);
				    break;
				}
            }
            
            format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `Name` = '%s' WHERE `Name` = '%s' LIMIT 1;", newname, oldname);
            mysql_function_query(g_SQL_handle, query, false, "", "");
            format(query, sizeof(query), "UPDATE `"#TABLE_VEHICLE"` SET `Owner` = '%s' WHERE `Owner` = '%s' LIMIT 1;", newname, oldname);
            mysql_function_query(g_SQL_handle, query, false, "", "");
            format(query, sizeof(query), "UPDATE `"#TABLE_TOYS"` SET `Name` = '%s' WHERE `Name` = '%s' LIMIT 1;", newname, oldname);
            mysql_function_query(g_SQL_handle, query, false, "", "");
            format(query, sizeof(query), "UPDATE `"#TABLE_RACE"` SET `name` = '%s' WHERE `name` = '%s';", newname, oldname);
            mysql_function_query(g_SQL_handle, query, false, "", "");
            
			PlayerInfo[playerid][LastNameChange] = gettime();
			
			new nextnc = (PlayerInfo[playerid][LastNameChange] + ((PlayerInfo[playerid][VIP] == 1) ? (2592000) : (7776000)));
			
			format(query, sizeof(query), ""white"You have successfully changed your name.\n\nNew name: %s\nOld name: %s\nNext namechange available: %s", newname, oldname, UnixTimeToDate(nextnc));
			ShowPlayerDialog(playerid, NAME_CHANGE_DIALOG + 5 /*Invalid*/, DIALOG_STYLE_MSGBOX, ""se" - Namechange", query, "OK", "");
			
			format(query, sizeof(query), ""se" %s(%i) has changed his name to %s", oldname, playerid, newname);
			SCMToAll(-1, query);
			
			MySQL_SavePlayer(playerid);
			MySQL_SavePlayerToys(playerid);
			MySQL_SavePlayerVeh(playerid);
        }
        else
        {
            SCM(playerid, -1, ""er"Your name is already in use or contains invalid characters");
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
	        case COLOR_DIALOG:
	        {
    			switch(listitem)
	    		{
	    			case 0:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_RED);
	    	    		SendClientMessage(playerid, COLOR_RED, ">> Your nick color has been changed to RED.");
	    	    	}
    	    		case 1:
	    	    	{
						SetPlayerColor(playerid, COLOR_BLUE);
						SendClientMessage(playerid, COLOR_BLUE, ">> Your nick color has been changed to BLUE.");
	    	    	}
    	    		case 2:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_WHITE);
	    	    		SendClientMessage(playerid, COLOR_WHITE, ">> Your nick color has been changed to WHITE.");
					}
					case 3:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_IVORY);
	    	    		SendClientMessage(playerid, COLOR_IVORY, ">> Your nick color has been changed to IVORY.");
					}
					case 4:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_PINK);
	    	    		SendClientMessage(playerid, COLOR_PINK, ">> Your nick color has been changed to PINK.");
					}
					case 5:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_YELLOW);
	    	    		SendClientMessage(playerid, COLOR_YELLOW, ">> Your nick color has been changed to YELLOW.");
					}
					case 6:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_GREEN);
	    	    		SendClientMessage(playerid, COLOR_GREEN, ">> Your nick color has been changed to GREEN.");
					}
					case 7:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_LIGHTBLUE);
	    	    		SendClientMessage(playerid, COLOR_LIGHTBLUE, ">> Your nick color has been changed to LIGHTBLUE.");
					}
					case 8:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_GREY);
	    	    		SendClientMessage(playerid, COLOR_GREY, ">> Your nick color has been changed to GREY.");
					}
					case 9:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_ORANGE);
	    	    		SendClientMessage(playerid, COLOR_ORANGE, ">> Your nick color has been changed to ORANGE.");
					}
					case 10:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_PURPLE);
	    	    		SendClientMessage(playerid, COLOR_PURPLE, ">> Your nick color has been changed to PURPLE.");
					}
					case 11:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_LIGHTGREEN);
	    	    		SendClientMessage(playerid, COLOR_LIGHTGREEN, ">> Your nick color has been changed to LIGHTGREEN.");
					}
					case 12:
	    	    	{
	    	    		SetPlayerColor(playerid, COLOR_STEELBLUE);
	    	    		SendClientMessage(playerid, COLOR_STEELBLUE, ">> Your nick color has been changed to STEELBLUE.");
					}
				}
				return true;
			}
	        case LABEL_DIALOG:
	        {
	            if(strlen(inputtext) > 35 || strlen(inputtext) < 3) return SCM(playerid, -1, ""er"Inputlength: 3-35");
	            
	            new text[36];
	            sscanf(inputtext, "s[36]", text);
	            
				new is1 = 0,
					r = 0,
					strR[255];

			 	while(strlen(text[is1]))
			 	{
			  		if('0' <= text[is1] <= '9')
			  		{
			 			new is2 = is1 + 1,
						 	p = 0;

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

			        SCM(playerid, RED, "Advertising is not allowed!");
			        return 1;
				}
	            
	            PlayerInfo[playerid][VIPLabel] = CreateDynamic3DTextLabel(text, -1, 0.0, 0.0, 0.65, 20.0, playerid, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);

                SCM(playerid, -1, ""er"Label attached! Note: You can't see the label yourself");
				return true;
	        }
	        case LABEL_DIALOG + 1:
	        {
	            if(strlen(inputtext) > 35 || strlen(inputtext) < 3) return SCM(playerid, -1, ""er"Inputlength: 3-35");

	            new text[36];
	            sscanf(inputtext, "s[36]", text);

				new is1 = 0,
					r = 0,
					strR[255];

			 	while(strlen(text[is1]))
			 	{
			  		if('0' <= text[is1] <= '9')
			  		{
			 			new is2 = is1 + 1,
						 	p = 0;

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

			        SCM(playerid, RED, "Advertising is not allowed!");
			        return 1;
				}
				
				UpdateDynamic3DTextLabelText(PlayerInfo[playerid][VIPLabel], -1, text);
	            SCM(playerid, -1, ""er"Label text changed!");
	            return true;
	        }
	        case VCONTROL_DIALOG:
	        {
	            switch(listitem) // "Engine control\nLight control\nAlarm\nBonnet\nBoot"
	            {
					case 0: ShowPlayerDialog(playerid, VCONTROL_DIALOG+1, DIALOG_STYLE_MSGBOX, ""white"VCS > Toggle engine", ""white"Do you want to start or stop your engine?", "Start", "Stop");
                    case 1: ShowPlayerDialog(playerid, VCONTROL_DIALOG+2, DIALOG_STYLE_MSGBOX, ""white"VCS > Toggle lights", ""white"Do you want to enable or disable your lights?\n\nNOTE: Lights are only visible at night.", "Enable", "Disable");
                    case 2: ShowPlayerDialog(playerid, VCONTROL_DIALOG+3, DIALOG_STYLE_MSGBOX, ""white"VCS > Toggle alarm", ""white"Do you want to enable or disable your alarm?\n\nNOTE: The alarm will not reset itself when it's over,\nyou'll need to reset it by yourself.", "Enable", "Disable");
                    case 3: ShowPlayerDialog(playerid, VCONTROL_DIALOG+4, DIALOG_STYLE_MSGBOX, ""white"VCS > Toggle bonnet", ""white"Do you want to open or close your bonnet?", "Open", "Close");
                    case 4: ShowPlayerDialog(playerid, VCONTROL_DIALOG+5, DIALOG_STYLE_MSGBOX, ""white"VCS > Toggle boot", ""white"Do you want to open or close your boot?", "Open", "Close");
	            }
	            return true;
	        }
	        case VCONTROL_DIALOG+1:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
     			GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            	SetVehicleParamsEx(GetPlayerVehicleID(playerid), 1, lights, alarm, doors, bonnet, boot, objective);
	        }
	        case VCONTROL_DIALOG+2:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, 1, alarm, doors, bonnet, boot, objective);
	        }
	        case VCONTROL_DIALOG+3:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, 1, doors, bonnet, boot, objective);
	        }
	        case VCONTROL_DIALOG+4:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, 1, boot, objective);
	        }
	        case VCONTROL_DIALOG+5:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, 1, objective);
	        }
	        case NAME_CHANGE_DIALOG:
	        {
	            if(strlen(inputtext) > 21 || strlen(inputtext) < 3) return SCM(playerid, -1, "Name length: 3-21");
	            if(!strcmp(inputtext, __GetName(playerid), true)) return SCM(playerid, -1, "The name only differs in case. Just relog with that.");
	            
				new newname[MAX_PLAYER_NAME], query[255];
				mysql_real_escape_string(inputtext, newname, g_SQL_handle, MAX_PLAYER_NAME);
				
                format(query, sizeof(query), "SELECT `ID` FROM `"#TABLE_ACCOUNT"` WHERE `Name` = '%s';", newname);
                mysql_function_query(g_SQL_handle, query, true, "OnPlayerNameChangeRequest", "si", newname, playerid);
	            return true;
	        }
	        case HAREFILL_DIALOG:
	        {
	            if(listitem == 0)
	            {
	                SetPlayerHealth(playerid, 100.0);
	                SetPlayerChatBubble(playerid, "Refilled "red"Health "white"using VIP rights", -1, 40.0, 5000);
	                SendInfo(playerid, "~h~~y~Health refilled", 2000);
             	    GivePlayerCash(playerid, -5000);
				    GameTextForPlayer(playerid, "~r~-$5,000", 3000, 1);
	            }
	            else
	            {
	                SetPlayerArmour(playerid, 100.0);
	                SetPlayerChatBubble(playerid, "Refilled "ngs_blue"Armor "white"using VIP rights", -1, 40.0, 5000);
					SendInfo(playerid, "~h~~y~Armor refilled", 2000);
	    			GivePlayerCash(playerid, -2500);
				    GameTextForPlayer(playerid, "~r~-$2,500", 3000, 1);
	            }
				PlayerInfo[playerid][tickLastRefill] = GetTickCount() + 3600000;
	            return 1;
	        }
	        case GANG_SET_RANK_DIALOG:
	        {
				if(listitem == 0) return ShowDialog(playerid, GANG_SET_RANK_DIALOG);
				
				PlayerInfo[playerid][RankSelected] = listitem;
				
				new string[128];
				format(string, sizeof(string), ""white"Now enter the name of the player who should get the rank:\n\nSelected Rank: %s", GangPositions[listitem][E_gang_pos_name]);
				
				ShowPlayerDialog(playerid, GANG_SET_RANK_DIALOG + 1, DIALOG_STYLE_INPUT, ""se" - Gang Rank Menu", string, "Next", "Cancel");
	            return true;
	        }
	        case GANG_SET_RANK_DIALOG + 1:
	        {
			    if(!strcmp(__GetName(playerid), inputtext, true))
			    {
			        return SCM(playerid, -1, ""er"You can't assign your own rank");
			    }
			    
	            if(strlen(inputtext) > MAX_PLAYER_NAME || strlen(inputtext) < 3) return SCM(playerid, -1, ""er"Player doesn't exist");
	            if(sscanf(inputtext, "s[25]", PlayerInfo[playerid][GangAssignRank])) return SCM(playerid, -1, ""er"Player doesn't exist");
	            mysql_real_escape_string(PlayerInfo[playerid][GangAssignRank], PlayerInfo[playerid][GangAssignRank], g_SQL_handle, 25);

				new ID = __GetPlayerID(PlayerInfo[playerid][GangAssignRank]);
				
		  		if(ID != INVALID_PLAYER_ID)
		  		{
					if(!IsPlayerAvail(ID)) return SCM(playerid, -1, ""er"Spieler ist not available");
		        	if(PlayerInfo[ID][GangID] != PlayerInfo[playerid][GangID]) return SCM(playerid, -1, ""er"This player is not in your gang!");
		        	if(PlayerInfo[ID][GangPosition] == PlayerInfo[playerid][RankSelected]) return SCM(playerid, -1, ""er"Player is already this rank!");
		        	if(PlayerInfo[ID][GangPosition] >= PlayerInfo[playerid][GangPosition]) return SCM(playerid, -1, ""er"You can't assign this rank to this player!");

			  		PlayerInfo[ID][GangPosition] = PlayerInfo[playerid][RankSelected];

		  			MySQL_SavePlayer(ID);

					new string[128];

				    format(string, sizeof(string), ""gang_sign" %s set %s´s rank to %s", __GetName(playerid), __GetName(ID), GangPositions[PlayerInfo[playerid][RankSelected]][E_gang_pos_name]);
					GangMSG(PlayerInfo[playerid][GangID], string);
					
					PlayerInfo[playerid][RankSelected] = 0;
				}
				else
				{
				    MySQL_AssignRankIfExist(playerid);
	            }
	            return true;
	        }
	        case CLOSE_GANG_DIALOG:
	        {
	            new query[255];
				format(query, sizeof(query),
				"UPDATE `"#TABLE_ACCOUNT"` SET `GangPosition` = 0, `GangID` = 0 WHERE `GangID` = %i;", PlayerInfo[playerid][GangID]);
				mysql_function_query(g_SQL_handle, query, false, "", "");

				GangMSG(PlayerInfo[playerid][GangID], ""gang_sign" The gang has been closed by it's Leader");

				for(new i = 0; i < MAX_PLAYERS; i++)
				{
				    if(IsPlayerConnected(i) && !IsPlayerNPC(i) && i != playerid)
				    {
				        if(PlayerInfo[i][GangID] == PlayerInfo[playerid][GangID] || PlayerInfo[i][TmpGangID] == PlayerInfo[playerid][GangID])
				        {
					        PlayerInfo[i][gInvite] = false;
					        PlayerInfo[i][GangID] = 0;
					        PlayerInfo[i][TmpGangID] = 0;
					        PlayerInfo[i][GangPosition] = GANG_POS_NONE;
					        PlayerInfo[i][GangName][0] = '\0';
							PlayerInfo[i][GangTag][0] = '\0';
							MySQL_SavePlayer(i);
					 		if(PlayerInfo[i][GangLabel] != Text3D:-1)
							{
							    DestroyDynamic3DTextLabel(PlayerInfo[i][GangLabel]);
					 			PlayerInfo[i][GangLabel] = Text3D:-1;
							}
						}
				    }
				}

				format(query, sizeof(query),
				"DELETE FROM `"#TABLE_GANG"` WHERE `ID` = %i LIMIT 1;", PlayerInfo[playerid][GangID]);
				mysql_function_query(g_SQL_handle, query, false, "", "");

			    PlayerInfo[playerid][gInvite] = false;
			    PlayerInfo[playerid][GangID] = 0;
			    PlayerInfo[playerid][TmpGangID] = 0;
			    PlayerInfo[playerid][GangPosition] = GANG_POS_NONE;
			    PlayerInfo[playerid][GangName][0] = '\0';
				PlayerInfo[playerid][GangTag][0] = '\0';
				MySQL_SavePlayer(playerid);

				if(PlayerInfo[playerid][GangLabel] != Text3D:-1)
				{
				    DestroyDynamic3DTextLabel(PlayerInfo[playerid][GangLabel]);
					PlayerInfo[playerid][GangLabel] = Text3D:-1;
				}
				SCM(playerid, -1, ""gang_sign" The gang has been closed!");
	            return true;
	        }
	        case GANG_KICK_DIALOG:
	        {
			    if(!strcmp(__GetName(playerid), inputtext, true))
			    {
			        return SCM(playerid, -1, ""er"You can't kick yourself");
			    }
	        
	            if(strlen(inputtext) > MAX_PLAYER_NAME || strlen(inputtext) < 3) return SCM(playerid, -1, ""er"Player doesn't exist");
	            if(sscanf(inputtext, "s[25]", PlayerInfo[playerid][GangKickMem])) return SCM(playerid, -1, ""er"Player doesn't exist");
	            mysql_real_escape_string(PlayerInfo[playerid][GangKickMem], PlayerInfo[playerid][GangKickMem], g_SQL_handle, 25);

		  		new ID = __GetPlayerID(PlayerInfo[playerid][GangKickMem]);

		  		if(ID != INVALID_PLAYER_ID)
		  		{
					if(!IsPlayerAvail(ID)) return SCM(playerid, -1, ""er"Spieler ist not available");
		        	if(PlayerInfo[ID][GangID] != PlayerInfo[playerid][GangID]) return SCM(playerid, -1, ""er"This player is not in your gang!");
		        	if(PlayerInfo[ID][GangPosition] == GANG_POS_MAIN_LEADER) return SCM(playerid, -1, ""er"You cannot kick other leaders!");

                    PlayerInfo[ID][GangName][0] = '\0';
                    PlayerInfo[ID][GangTag][0] = '\0';
					PlayerInfo[ID][GangID] = 0;
			  		PlayerInfo[ID][GangPosition] = 0;

		  			MySQL_SavePlayer(ID);

					if(PlayerInfo[ID][GangLabel] != Text3D:-1)
					{
					    DestroyDynamic3DTextLabel(PlayerInfo[ID][GangLabel]);
						PlayerInfo[ID][GangLabel] = Text3D:-1;
					}

					new string[128];

				    format(string, sizeof(string), ""gang_sign" %s kicked %s out of the gang", __GetName(playerid), PlayerInfo[playerid][GangKickMem]);
					GangMSG(PlayerInfo[playerid][GangID], string);
			        
			        SCM(ID, -1, ""gang_sign" You have been kicked out of your gang!");
			        
			        PlayerInfo[playerid][GangKickMem][0] = '\0';
			  	}
			  	else
			  	{
					MySQL_KickFromGangIfExist(playerid);
				}
				return true;
	        }
	        case SETTINGS_DIALOG:
	        {
	            switch(listitem)
	            {
					case 0:
					{
					    cmd_sb(playerid, "");
					    ShowDialog(playerid, SETTINGS_DIALOG);
					}
					case 1:
					{
					    cmd_sj(playerid, "");
					    ShowDialog(playerid, SETTINGS_DIALOG);
					}
					case 2:
					{
					    if(PlayerInfo[playerid][bFooterEnabled]) cmd_hidef(playerid, "");
					    else cmd_showf(playerid, "");
					    ShowDialog(playerid, SETTINGS_DIALOG);
					}
					case 3:
					{
					    cmd_random(playerid, "");
					    ShowDialog(playerid, SETTINGS_DIALOG);
					}
					case 4:
					{
					    if(PlayerInfo[playerid][bHasSpawn])
					    {
					        PlayerInfo[playerid][bHasSpawn] = false;
					    }
					    else
					    {
					    	cmd_setspawn(playerid, "");
						}
						ShowDialog(playerid, SETTINGS_DIALOG);
					}
					case 5:
					{
					    cmd_changepass(playerid, "");
					}
					case 6:
					{
					    cmd_stats(playerid, "");
					}
					case 7:
					{
					    cmd_help(playerid, "");
					}
					case 8:
					{
					    cmd_mynetstats(playerid, "");
					}
	            }
	            return true;
	        }
	        case HELP_DIALOG:
	        {
	            switch(listitem)
	            {
	                case 0: // General Help
	                {
						new cstring[2048];

						strcat(cstring, ""red"» "ngs_blue"Commands:\n");
						strcat(cstring, ""white"There are many commands, to get an overview use "yellow"/cmds\n\n");

						strcat(cstring, ""red"» "ngs_blue"Minigames\n");
						strcat(cstring, ""white"Available minigames:\n");
						strcat(cstring, ""yellow"/derby /race /gungame /fallout /tdm /minigun /sniper /dm[1-4]\n\n");

						strcat(cstring, ""red"» "ngs_blue"Admins\n");
						strcat(cstring, ""white"Admins are here to help, use "yellow"/report "white"if you want to report a player or if you have a question\n\n");

						strcat(cstring, ""red"» "ngs_blue"Gangs\n");
						strcat(cstring, ""white"Gangs are groups which have been created by players\n\n");

						strcat(cstring, ""red"» "ngs_blue"Houses/Business\n");
						strcat(cstring, ""white"Houses and business are for sale around San Andreas. Use "yellow"/cmds "white"for more infos");

						ShowPlayerDialog(playerid, HELP_DIALOG + 1, DIALOG_STYLE_MSGBOX, ""se" - General Help", cstring, "OK", "Back");
	                }
	                case 1: // Commands
	                {
	                    cmd_cmds(playerid, "");
	                }
	                case 2: // shortcuts
	                {
						new cstring[512];

						strcat(cstring, ""red"» "ngs_blue"LMB (Left Mice Button)\n");
						strcat(cstring, ""white"Speedboost for vehicles\n\n");

						strcat(cstring, ""red"» "ngs_blue"2\n");
						strcat(cstring, ""white"Flip your vehicle\n\n");

						strcat(cstring, ""red"» "ngs_blue"H\n");
						strcat(cstring, ""white"Jump with your vehicle\n\n");

						ShowPlayerDialog(playerid, HELP_DIALOG + 2, DIALOG_STYLE_MSGBOX, ""se" - Shortcuts", cstring, "OK", "Back");
	                }
	                case 3: // Minigames
	                {
	                    ShowPlayerDialog(playerid, HELP_DIALOG + 3, DIALOG_STYLE_LIST, ""se" - Minigames", ""dl"Race (/race)\n"dl"Derby (/derby)\n"dl"Fallout (/fallout)\n"dl"Gungame (/gungame)\n"dl"Minigun (/minigun)\n"dl"Sniper (/sniper)\n"dl"Death Match (/dm1-4)", "Select", "");
	                }
	                case 4: // Maps
	                {
	                    cmd_tele(playerid, "");
	                }
	                case 5: // settings
	                {
						cmd_settings(playerid, "");
	                }
	            }
	            return true;
	        }
	        case HELP_DIALOG + 3:
	        {
	            switch(listitem)
	            {
	                case 0: cmd_race(playerid, "");
	                case 1: cmd_derby(playerid, "");
	                case 2: cmd_fallout(playerid, "");
	                case 3: cmd_gungame(playerid, "");
	                case 4: cmd_minigun(playerid, "");
	                case 5: cmd_sniper(playerid, "");
	                case 6: ShowPlayerDialog(playerid, HELP_DIALOG + 4, DIALOG_STYLE_MSGBOX, ""se" - Minigames", ""white"Death Match (/dm1-4)", "OK", "Back");
	                case 7: cmd_tdm(playerid, "");
	                case 8: cmd_war(playerid, "");
	            }
	            return true;
	        }
		    case CMDS_DIALOG:
		    {
		        new cstring[2048];
		        
		        switch(listitem)
		        {
		            case 0: // General
		            {
		                strcat(cstring, ""yellow"/toys "white"- player toys\n");
		                strcat(cstring, ""yellow"/help "white"- small usefull explanations\n");
		                strcat(cstring, ""yellow"/god "white"- infinite health\n");
						strcat(cstring, ""yellow"/pm "white"- write a personal message to a player\n");
						strcat(cstring, ""yellow"/r "white"- reply to your last pm\n");
						strcat(cstring, ""yellow"/t "white"- list of all teleport\n");
						strcat(cstring, ""yellow"/w "white"- free weapons\n");
						strcat(cstring, ""yellow"/v "white"- list of all vehicles also /v <vehicle name>\n");
						strcat(cstring, ""yellow"/id "white"- get the id of a player\n");
						strcat(cstring, ""yellow"/go "white"- goto a desired player\n");
						strcat(cstring, ""yellow"/tgo "white"- set if player can goto you\n");
						strcat(cstring, ""yellow"/admins "white"- a list of all online admins\n");
						strcat(cstring, ""yellow"/car "white"- quick spawn a car\n");
						strcat(cstring, ""yellow"/top "white"- top list selection\n");
						strcat(cstring, ""yellow"/report "white"- report a player to admins\n");
     					strcat(cstring, ""yellow"/jetpack "white"- get a free jetpack\n");
				        strcat(cstring, ""yellow"/streams "white"- listen to audio streams\n");
						strcat(cstring, ""yellow"/sb "white"- toggle speedboost\n");
						strcat(cstring, ""yellow"/sj "white"- toggle superjump\n");
		                strcat(cstring, ""yellow"/fs "white"- fightstyles\n");
		            }
		            case 1: // Account
		            {
		                strcat(cstring, ""yellow"/settings "white"- player control panel\n");
		                strcat(cstring, ""yellow"/changename "white"- change your account's nickname\n");
		                strcat(cstring, ""yellow"/changepass "white"- change your account's password\n");
		                strcat(cstring, ""yellow"/stats "white"- stats of a player also /stats <playerid>\n");
		                strcat(cstring, ""yellow"/achs "white"- achievements\n");
		            }
		            case 2: // Gang
		            {
						strcat(cstring, ""yellow"/gcreate "white"- create a gang\n");
						strcat(cstring, ""yellow"/gmenu "white"- gang menu\n");
						strcat(cstring, ""yellow"/gsetrank "white"- set a players rank\n");
						strcat(cstring, ""yellow"/ginvite "white"- invite someone to your gang\n");
						strcat(cstring, ""yellow"/gkick "white"- kick someone off your gang\n");
						strcat(cstring, ""yellow"/gjoin "white"- join a gang\n");
						strcat(cstring, ""yellow"/gleave "white"- leave the gang you are in\n");
						strcat(cstring, ""yellow"/gclose "white"- destroy your gang\n");
						strcat(cstring, ""yellow"/gdeny "white"- deny an invitation\n");
						strcat(cstring, ""yellow"/gangs "white"- online gangs\n");
		            }
		            case 3: // House/Business
		            {
		                strcat(cstring, ""yellow"/upgrade "white"- upgrade your house interior\n");
						strcat(cstring, ""yellow"/enter "white"- enter a unlocked house\n");
						strcat(cstring, ""yellow"/buy "white"- buy a house\n");
						strcat(cstring, ""yellow"/exit "white"- exit your house\n");
						strcat(cstring, ""yellow"/sell "white"- sell your house\n");
						strcat(cstring, ""yellow"/lock "white"- lock or unlock your house\n");
						strcat(cstring, ""yellow"/gotomyhouse "white"- goto your house\n");
						strcat(cstring, ""yellow"/gotomybizz "white"- goto your business\n");
						strcat(cstring, ""yellow"/bbuy "white"- buy a business\n");
						strcat(cstring, ""yellow"/bsell "white"- sell your business\n");
		            }
		            case 4: // Private Vehicle
		            {
                        strcat(cstring, ""yellow"/pv "white"- private vehicle control\n");
                        strcat(cstring, ""yellow"/lock "white"- lock your vehicle\n");
                        strcat(cstring, ""yellow"/unlock "white"- unlock your vehicle\n");
                        strcat(cstring, ""yellow"/cc "white"- dye your vehicle\n");
		            }
		            case 5: // Other
		            {
		                strcat(cstring, ""yellow"/color "white"- change your color\n");
		   				strcat(cstring, ""yellow"/uptime "white"- see the uptime of the server\n");
						strcat(cstring, ""yellow"/hidef "white"- hide the footer\n");
						strcat(cstring, ""yellow"/showf "white"- show the footer\n");
						strcat(cstring, ""yellow"/hitman "white"- set a bounty on someones head\n");
						strcat(cstring, ""yellow"/bounties "white"- see current bounties\n");
						strcat(cstring, ""yellow"/para "white"- free weapons\n");
						strcat(cstring, ""yellow"/pay "white"- give some cash to a person\n");
						strcat(cstring, ""yellow"/s "white"- save your current position\n");
						strcat(cstring, ""yellow"/l "white"- lave your saved position\n");
						strcat(cstring, ""yellow"/weather "white"- change your weather\n");
						strcat(cstring, ""yellow"/anims "white"- a lsit of all animations\n");
						strcat(cstring, ""yellow"/skin "white"- change your current skin\n");
						strcat(cstring, ""yellow"/netstats "white"- servers network stats\n");
						strcat(cstring, ""yellow"/mynetstats "white"- your network stats\n");
						strcat(cstring, ""yellow"/ping "white"- check somebody´s ping\n");
					}
					case 6: return cmd_vip(playerid, "");
		        }

				ShowPlayerDialog(playerid, CMDS_DIALOG + 1, DIALOG_STYLE_MSGBOX, ""se" - Commands", cstring, "OK", "Back");
				return true;
		    }
	        case HOUSE_UPGRADE_DIALOG:
	        {
				PlayerInfo[playerid][HouseIntSelected] = listitem;
				new string[144];
				format(string, sizeof(string), ""white"House Upgrade\n\n- Interior: %s\n- Price: $%s\n\nClick \"Upgrade\" in order to apply the new interior.", HouseIntTypes[listitem][intname], ToCurrency(HouseIntTypes[listitem][price]));
				ShowPlayerDialog(playerid, HOUSE_UPGRADE_DIALOG + 1, DIALOG_STYLE_MSGBOX, ""se" - House Upgrade", string, "Upgrade", "Cancel");
				return true;
	        }
	        case HOUSE_UPGRADE_DIALOG + 1:
	        {
	            if(GetPlayerCash(playerid) < HouseIntTypes[PlayerInfo[playerid][HouseIntSelected]][price])
	            {
	                return SCM(playerid, -1, ""er"You can't afford that interior");
	            }

             	new bool:found = false;
				for(new i = 0; i < houseid; i++)
				{
				    if(!IsPlayerInRangeOfPoint(playerid, 1.5, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z])) continue;
                    if(!strcmp(__GetName(playerid), HouseInfo[i][Owner], true) && HouseInfo[i][sold] == 1)
                    {
                        found = true;
          	            if(PlayerInfo[playerid][HouseIntSelected] == HouseInfo[i][interior])
			            {
                 			SCM(playerid, -1, ""er"This house already got the interior");
							break;
			            }
			            for(new pid = 0; pid < MAX_PLAYERS; pid++)
			            {
			                if(gTeam[pid] == HOUSE && GetPlayerInterior(pid) == HouseIntTypes[HouseInfo[i][interior]][interior] && GetPlayerVirtualWorld(pid) == (HouseInfo[i][iID] + 1000))
			                {
			                    gTeam[pid] = NORMAL;
			                    SetPlayerPos(pid, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z]);
								ResetPlayerWorld(pid);
			                }
			            }
			            HouseInfo[i][locked] = 1;
                        new string[128];
                        format(string, sizeof(string), "~r~-$%s", ToCurrency(HouseIntTypes[PlayerInfo[playerid][HouseIntSelected]][price]));
                        GameTextForPlayer(playerid, string, 2000, 1);
                        GivePlayerCash(playerid, -HouseIntTypes[PlayerInfo[playerid][HouseIntSelected]][price]);
                        HouseInfo[i][interior] = PlayerInfo[playerid][HouseIntSelected];
               			SetPlayerPos(playerid, HouseInfo[i][E_x], HouseInfo[i][E_y], HouseInfo[i][E_z]);
						ResetPlayerWorld(playerid);
						gTeam[playerid] = NORMAL;
              		    format(string, sizeof(string), ""house_mark"\nOwner: %s\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", __GetName(playerid), HouseInfo[i][iID], ToCurrency(HouseInfo[i][price]), HouseInfo[i][E_score], HouseIntTypes[PlayerInfo[playerid][HouseIntSelected]][intname]);
		    			UpdateDynamic3DTextLabelText(HouseInfo[i][label], -1, string);
                        MySQL_SaveHouse(i);
                        MySQL_SavePlayer(playerid);
                        SCM(playerid, GREEN, "Successfully upgraded the interior!");
                        break;
                    }
				}
                if(!found) SCM(playerid, -1, ""er"You need to stand in your house pickup (Entrance)");
	            return true;
	        }
	        case TOPLIST_DIALOG:
	        {
	            switch(listitem)
	            {
	                case 0: cmd_richlist(playerid, "");
	                case 1: cmd_wanteds(playerid, "");
	                case 2: cmd_score(playerid, "");
	                case 3: cmd_kills(playerid, "");
	                case 4: cmd_deaths(playerid, "");
	                case 5: cmd_toptime(playerid, "");
	                case 6: cmd_gangs(playerid, "");
	                case 7: cmd_gtop(playerid, "");
	            }
	            return true;
	        }
	 	    case DIALOG_RACE_RACETYPE:
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
	 	    case DIALOG_RACE_RACEVEH, DIALOG_RACE_RACEVEHERR:
		    {
		        if(!strlen(inputtext)) return ShowDialog(playerid, DIALOG_RACE_RACEVEHERR);
		        if(IsNumeric(inputtext))
		        {
		            if(!IsValidVehicle(strval(inputtext))) return ShowDialog(playerid, DIALOG_RACE_RACEVEHERR);
					new Float:POS[4];
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
					new Float:POS[4];
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
		    case DIALOG_RACE_RACESTARTPOS:
		    {
				SCM(playerid, GREEN, ">> Go to the start line on the left road and press 'KEY_FIRE' and do the same with the right road block.");
				SCM(playerid, GREEN, ">> When this is done, you will see a dialog to continue.");
				BuildVehPosCount = 0;
		        BuildTakeVehPos = true;
		        return true;
		    }
    	    case DIALOG_RACE_CHECKPOINTS:
		    {
		        SCM(playerid, GREEN, ">> Start taking checkpoints now by clicking 'KEY_FIRE'.");
		        SCM(playerid, GREEN, ">> IMPORTANT: Press 'ENTER' when you're done with the checkpoints! If it doesn't react press again and again.");
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
		    case TELE_DIALOG:
		    {
		        switch(listitem)
		        {
		            case 0: // Parkours
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 1, DIALOG_STYLE_LIST, ""se" - Teleports > Parkours", TeleportDialogString[0], "Select", "Back");
		            }
		            case 1: // Stunting
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 2, DIALOG_STYLE_LIST, ""se" - Teleports > Stunts", TeleportDialogString[1], "Select", "Back");
					}
		            case 2: // basejump
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 3, DIALOG_STYLE_LIST, ""se" - Teleports > Basejump/Skydive", TeleportDialogString[2], "Select", "Back");
					}
		            case 3: // vehicle jumps
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 4, DIALOG_STYLE_LIST, ""se" - Teleports > Vehicle Jumps", TeleportDialogString[3], "Select", "Back");
					}
		            case 4: // fun maps
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 5, DIALOG_STYLE_LIST, ""se" - Teleports > Fun Maps", TeleportDialogString[4], "Select", "Back");
					}
		            case 5: // specials
		            {
						ShowPlayerDialog(playerid, TELE_DIALOG + 6, DIALOG_STYLE_LIST, ""se" - Teleports > Specials", TeleportDialogString[5], "Select", "Back");
					}
					case 6: // Vehicle Tuning
					{
					    ShowPlayerDialog(playerid, TELE_DIALOG + 7, DIALOG_STYLE_LIST, ""se" - Teleports > Vehicle Tuning", TeleportDialogString[6], "Select", "Back");
					}
					case 7: // Cities
					{
					    ShowPlayerDialog(playerid, TELE_DIALOG + 8, DIALOG_STYLE_LIST, ""se" - Teleports > Cities", TeleportDialogString[7], "Select", "Back");
					}
					case 8: // Hotspots
					{
					    ShowPlayerDialog(playerid, TELE_DIALOG + 9, DIALOG_STYLE_LIST, ""se" - Teleports > Hotspots", TeleportDialogString[8], "Select", "Back");
					}
					case 9: // Drifts
					{
					    ShowPlayerDialog(playerid, TELE_DIALOG + 10, DIALOG_STYLE_LIST, ""se" - Teleports > Drifts", TeleportDialogString[9], "Select", "Back");
					}
		        }
		    }
		    case TELE_DIALOG +1: // parkours
		    {
		        PushTeleportIntput(playerid, 0, listitem);
		    }
		    case TELE_DIALOG +2: // Stunting
		    {
		        PushTeleportIntput(playerid, 1, listitem);
		    }
		    case TELE_DIALOG +3: //base jumps
		    {
		        PushTeleportIntput(playerid, 2, listitem);
		    }
		    case TELE_DIALOG +4: // vehicle jumps
		    {
		        PushTeleportIntput(playerid, 3, listitem);
		    }
		    case TELE_DIALOG +5: // other fun maps
		    {
		        PushTeleportIntput(playerid, 4, listitem);
		    }
		    case TELE_DIALOG +6: // specials
		    {
		        PushTeleportIntput(playerid, 5, listitem);
		    }
		    case TELE_DIALOG +7: // Vehicle Tuning
		    {
		        PushTeleportIntput(playerid, 6, listitem);
		    }
		    case TELE_DIALOG +8: // Cities
		    {
		        PushTeleportIntput(playerid, 7, listitem);
		    }
		    case TELE_DIALOG +9: // Hotspots
		    {
		        PushTeleportIntput(playerid, 8, listitem);
		    }
		    case TELE_DIALOG +10: // Hotspots
		    {
		        PushTeleportIntput(playerid, 9, listitem);
		    }
	        case GMENU_DIALOG:
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
		            case 2:
		            {
						new cstring[512];
						
						strcat(cstring, ""yellow"/gcreate "white"- create a gang\n");
						strcat(cstring, ""yellow"/gmenu "white"- gang menu\n");
						strcat(cstring, ""yellow"/gsetrank "white"- set a players rank\n");
						strcat(cstring, ""yellow"/ginvite "white"- invite someone to your gang\n");
						strcat(cstring, ""yellow"/gkick "white"- kick someone off your gang\n");
						strcat(cstring, ""yellow"/gjoin "white"- join a gang\n");
						strcat(cstring, ""yellow"/gleave "white"- leave the gang you are in\n");
						strcat(cstring, ""yellow"/gclose "white"- destroy your gang\n");
						strcat(cstring, ""yellow"/gdeny "white"- deny an invitation\n");
						strcat(cstring, ""yellow"/gangs "white"- online gangs\n");
		            
		                ShowPlayerDialog(playerid, GMENU_DIALOG + 1, DIALOG_STYLE_MSGBOX, ""se" - Gang commands", cstring, "OK", "Back");
		            }
		            case 3: // edit rank
		            {
		                cmd_gsetrank(playerid, "");
		            }
		            case 4: // kick player
					{
						cmd_gkick(playerid, "");
					}
		        }
		        return true;
	        }
	        case DERBY_VOTING_DIALOG:
	        {
				if(!IsDerbyRunning)
				{
				    if(Iter_Contains(DerbyVoters, playerid)) return SCM(playerid, -1, ""er"You already voted this round");
				    
				    Iter_Add(DerbyVoters, playerid);
				
				    new string[100];

				    switch(listitem)
				    {
						case 0:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'SilverGround'", __GetName(playerid), playerid);
							DerbyMapVotes[6]++;
							DerbyMSG(string);
						}
						case 1:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'Anubis'", __GetName(playerid), playerid);
							DerbyMapVotes[7]++;
							DerbyMSG(string);
						}
						case 2:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'Confusing'", __GetName(playerid), playerid);
							DerbyMapVotes[8]++;
							DerbyMSG(string);
						}
				        case 3:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'Lighthouse'", __GetName(playerid), playerid);
							DerbyMapVotes[0]++;
							DerbyMSG(string);
						}
						case 4:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'Truncat'", __GetName(playerid), playerid);
							DerbyMapVotes[1]++;
							DerbyMSG(string);
						}
						case 5:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'Sky Skiing'", __GetName(playerid), playerid);
							DerbyMapVotes[2]++;
							DerbyMSG(string);
						}
						case 6:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'Townhall'", __GetName(playerid), playerid);
							DerbyMapVotes[3]++;
							DerbyMSG(string);
						}
						case 7:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'Glazz'", __GetName(playerid), playerid);
							DerbyMapVotes[4]++;
							DerbyMSG(string);
						}
						case 8:
						{
						    format(string, sizeof(string), "%s(%i) has voted for Map 'Rambo'", __GetName(playerid), playerid);
							DerbyMapVotes[5]++;
							DerbyMSG(string);
						}
					}
				}
				else
				{
					SCM(playerid, BLUE, "No voting time now!");
				}
				return true;
			}
			case BANK_DIALOG:
			{
			    new string[130];
			    switch(listitem)
			    {
				    case 0: // Deposit
				    {
				        format(string, sizeof(string), ""white"» You got "yellow"$%s"white" in your bank account.\n\nType in the amount you want to deposit below:", ToCurrency(PlayerInfo[playerid][Bank]));
				        ShowPlayerDialog(playerid, BANK_DIALOG+1, DIALOG_STYLE_INPUT, ""se" - Bank > Deposit", string, "Deposit", "Cancel");
				    }
				    case 1: // Withdraw
				    {
				        format(string, sizeof(string), ""white"» You got "yellow"$%s"white" in your bank account.\n\nType in the amount you want to withdraw below:", ToCurrency(PlayerInfo[playerid][Bank]));
				        ShowPlayerDialog(playerid, BANK_DIALOG+2, DIALOG_STYLE_INPUT, ""se" - Bank > Withdraw", string, "Withdraw", "Cancel");
				    }
				    case 2: // Check Balance
				    {
				        format(string, sizeof(string), ""white"» You got "yellow"$%s"white" in your bank account.", ToCurrency(PlayerInfo[playerid][Bank]));
				        ShowPlayerDialog(playerid, 11231, DIALOG_STYLE_MSGBOX, ""se" - Bank > Balance", string, "OK", "");
				    }
			    }
			    return true;
			}
			case BANK_DIALOG + 1:
			{
			    new string[100];

				extract inputtext -> new inamount; else
				{
				    return SCM(playerid, WHITE, ""er"Invalid amount");
				}

				if(inamount > GetPlayerCash(playerid))
				{
					SCM(playerid, WHITE, ""er"You don't have that much money!");
				}
				else if(inamount < 1)
				{
					SCM(playerid, WHITE, ""er"Invalid amount");
				}
				else
				{
					GivePlayerCash(playerid, -inamount);
					PlayerInfo[playerid][Bank] += inamount;
					format(string, sizeof(string), "» You have deposited {FF7800}$%s"white" into your bank account", ToCurrency(inamount));
					SCM(playerid, WHITE, string);
				}
				return true;
			}
			case BANK_DIALOG+2:
			{
			    new string[100];

				extract inputtext -> new outamount; else
				{
				    return SCM(playerid, WHITE, ""er"Invalid amount");
				}

				if(outamount > PlayerInfo[playerid][Bank])
				{
					SCM(playerid, WHITE, ""er"You do not have that much money in your bank account!");
				}
				else if(outamount < 1)
				{
					SCM(playerid, WHITE, ""er"Invalid amount!");
				}
				else
				{
					GivePlayerCash(playerid, outamount);
					PlayerInfo[playerid][Bank] -= outamount;
					format(string, sizeof(string), "» You have withdrawn {FF7800}$%s"white" from your bank account", ToCurrency(outamount));
					SCM(playerid, WHITE, string);
				}
				return true;
			}
			case LIFT_DIALOG:
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
			case LOGIN_DIALOG:
			{
				if(strlen(inputtext) < 4 || strlen(inputtext) > 32)
				{
					SCM(playerid, -1, ""er"Length 4 - 32");
					return LoginDialog(playerid);
				}
				if(isnull(inputtext)) return LoginDialog(playerid);
				if(strfind(inputtext, " ", false) != -1)
				{
				    SCM(playerid, -1, ""er"No spaces allowed");
					return LoginDialog(playerid);
				}
				extract inputtext -> new string:password[33]; else // früher war das auch ohne dem makro
				{
					LoginDialog(playerid);
					return SCM(playerid, -1, ""er"Length 4 - 32");
				}
		   		MySQL_CheckPlayerPassword(playerid, password);
			    return true;
			}
			case REGISTER_DIALOG:
			{
			    if(strlen(inputtext) < 4 || strlen(inputtext) > 32)
				{
					SCM(playerid, -1, ""er"Password length: 4 - 32 characters");
					return RegisterDialog(playerid);
				}
				if(isnull(inputtext)) return RegisterDialog(playerid);
				if(strfind(inputtext, " ", true) != -1)
				{
				    SCM(playerid, -1, ""er"No spaces allowed");
					return RegisterDialog(playerid);
				}
				extract inputtext -> new string:password[33]; else // früher war das auch ohne dem makro // overflow nachdem jemand poiuytrewqasdfghjklmnbvcxz67890 eingegeben hat
				{
					RegisterDialog(playerid);
					return SCM(playerid, -1, ""er"Length 4 - 32");
				}
			    MySQL_CreateAccount(playerid, password);
			    return true;
			}
			case STREAM_DIALOG:
			{
				switch(listitem)
		    	{
	      			case 0: ShowPlayerDialog(playerid, STREAM_DIALOG+1, DIALOG_STYLE_LIST, ""se" - Streams > Streams > Electronic", ""dl"#MUSIK.TRANCE - WWW.RAUTEMUSIK.FM\n"dl":: Electro Radio :: all about electromusic", "Select", "Back");
					case 1: ShowPlayerDialog(playerid, STREAM_DIALOG+2, DIALOG_STYLE_LIST, ""se" - Streams > Metal", ""dl"RockRadio1.Com - Classic Hard Rock and Heavy\n"dl"#MUSIK.METAL - WWW.RAUTEMUSIK.FM", "Select", "Back");
					case 2: ShowPlayerDialog(playerid, STREAM_DIALOG+3, DIALOG_STYLE_LIST, ""se" - Streams > Pop", ""dl"idobi Radio: New. Music.\n"dl"DEFJAY.DE - 100% R&B!", "Select", "Back");
					case 3: ShowPlayerDialog(playerid, STREAM_DIALOG+4, DIALOG_STYLE_LIST, ""se" - Streams > Hip Hop", ""dl"HOT 108 JAMZ - #1 FOR HIP HOP\n"dl"Radio Traditional Hip Hop", "Select", "Back");
					case 4: ShowPlayerDialog(playerid, STREAM_DIALOG+5, DIALOG_STYLE_LIST, ""se" - Streams > Rap", ""dl"POWERHITZ.COM - #1 FOR HITZ\n"dl"RADIOUP.COM - THE HITLIST", "Select", "Back");
					case 5: ShowPlayerDialog(playerid, STREAM_DIALOG+6, DIALOG_STYLE_LIST, ""se" - Streams > Mainstream/Rock", ""dl"#MUSIK.MAIN - WWW.RAUTEMUSIK.FM - 24H\n"dl"181.FM - Kickin' Country", "Select", "Back");
					case 6: ShowPlayerDialog(playerid, STREAM_DIALOG+7, DIALOG_STYLE_LIST, ""se" - Streams > Oldies", ""dl"#MUSIK.GOLDIES - WWW.RAUTEMUSIK.FM\n"dl"181.FM - Good Time Oldie", "Select", "Back");
					case 7: ShowPlayerDialog(playerid, STREAM_DIALOG+8, DIALOG_STYLE_INPUT, ""se" - Streams > Your own stream", ""white"Please enter the audio stream you want to listen to", "Play", "Back");
				}
				return true;
			}
			case STREAM_DIALOG+1:
			{
				switch(listitem)
		    	{
		        	case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=29555");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=108251");
    			}
				return true;
			}
			case STREAM_DIALOG+2:
			{
				switch(listitem)
		    	{
		       		case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=558051");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=318248");
				}
				return true;
			}
			case STREAM_DIALOG+3:
			{
				switch(listitem)
		    	{
		        	case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=914897");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=65456");
				}
				return true;
			}
			case STREAM_DIALOG+4:
			{
	  			switch(listitem)
		    	{
		        	case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=32999");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1891213");
				}
				return true;
			}
			case STREAM_DIALOG+5:
			{
				switch(listitem)
			    {
			        case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=352174");
			        case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=656213");
				}
				return true;
			}
			case STREAM_DIALOG+6:
			{
				switch(listitem)
			    {
			        case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=38370");
			        case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283687");
				}
				return true;
			}
			case STREAM_DIALOG+7:
			{
				switch(listitem)
		    	{
		        	case 0: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=105772");
		        	case 1: PlayAudioStreamForPlayer(playerid, "http://yp.shoutcast.com/sbin/tunein-station.pls?id=103482");
				}
				return true;
			}
			case STREAM_DIALOG+8:
			{
			    extract inputtext -> new string:link[128]; else
			    {
					return ShowPlayerDialog(playerid, STREAM_DIALOG+8, DIALOG_STYLE_INPUT, ""se" - Streams > Your own stream", ""white"Please enter the audio stream you want to listen to", "Play", "Back");
			    }
				PlayAudioStreamForPlayer(playerid, link);
				return true;
			}
			case TOY_DIALOG:
			{
			    switch(listitem)
			    {
			        case 0: //slot 1
			        {
						PlayerInfo[playerid][toy_selected] = 0;
						if(PlayerToys[playerid][0][toy_model] == 0)
						{
						    ShowModelSelectionMenu(playerid, toyslist, "Select Toy", 0x4A5A6BBB, 0x282828FF, 0x4A5A6BBB);
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""se" - Player Toys > Slot 1", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
			        }
			        case 1: //slot 2
			        {
			        	PlayerInfo[playerid][toy_selected] = 1;
						if(PlayerToys[playerid][1][toy_model] == 0)
						{
						    ShowModelSelectionMenu(playerid, toyslist, "Select Toy", 0x4A5A6BBB, 0x282828FF, 0x4A5A6BBB);
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""se" - Player Toys > Slot 2", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
			        }
			        case 2: //slot 3
			        {
			            PlayerInfo[playerid][toy_selected] = 2;
						if(PlayerToys[playerid][2][toy_model] == 0)
						{
						    ShowModelSelectionMenu(playerid, toyslist, "Select Toy", 0x4A5A6BBB, 0x282828FF, 0x4A5A6BBB);
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""se" - Player Toys > Slot 3", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
					}
			        case 3: //slot 4
			        {
			            PlayerInfo[playerid][toy_selected] = 3;
						if(PlayerToys[playerid][3][toy_model] == 0)
						{
						    ShowModelSelectionMenu(playerid, toyslist, "Select Toy", 0x4A5A6BBB, 0x282828FF, 0x4A5A6BBB);
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""se" - Player Toys > Slot 4", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
					}
			        case 4: //slot 5
			        {
			            PlayerInfo[playerid][toy_selected] = 4;
						if(PlayerToys[playerid][4][toy_model] == 0)
						{
						    ShowModelSelectionMenu(playerid, toyslist, "Select Toy", 0x4A5A6BBB, 0x282828FF, 0x4A5A6BBB);
						}
						else
						{
			            	ShowPlayerDialog(playerid, TOY_DIALOG + 1, DIALOG_STYLE_LIST, ""se" - Player Toys > Slot 5", ""dl"Edit Toy Position\n"dl"Change Bone\n"dl""grey"Remove Toy", "Select", "Cancel");
						}
					}
			    }
				return true;
			}
			case TOY_DIALOG + 1:
			{
				switch(listitem)
				{
				    case 0: // edit
				    {
				        EditAttachedObject(playerid, PlayerInfo[playerid][toy_selected]);
				        ShowPlayerToyTextdraws(playerid);
				        SCM(playerid, YELLOW, "You are now editing the toy");
				    }
				    case 1: // change bone
					{
					    new finstring[750],
							string[128];
							
						format(string, sizeof(string), ""se" - Player Toys > Slot %i > Change Bone", PlayerInfo[playerid][toy_selected] + 1);

					    strcat(finstring, ""dl"Spine\n"dl"Head\n"dl"Left upper arm\n"dl"Right upper arm\n"dl"Left hand\n"dl"Right hand\n"dl"Left thigh\n"dl"Right tigh\n"dl"Left foot\n"dl"Right foot");
					    strcat(finstring, "\n"dl"Right calf\n"dl"Left calf\n"dl"Left forearm\n"dl"Right forearm\n"dl"Left clavicle\n"dl"Right clavicle\n"dl"Neck\n"dl"Jaw");

					    ShowPlayerDialog(playerid, TOY_DIALOG + 2, DIALOG_STYLE_LIST, string, finstring, "Select", "Cancel");
					}
					case 2: // remove toy
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
			case TOY_DIALOG + 2: //change bone
			{
			    listitem++;
			    PlayerToys[playerid][PlayerInfo[playerid][toy_selected]][toy_bone] = listitem;

			    if(IsPlayerAttachedObjectSlotUsed(playerid, PlayerInfo[playerid][toy_selected]))
				{
					RemovePlayerAttachedObject(playerid, PlayerInfo[playerid][toy_selected]);
				}

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

			    SendInfo(playerid, "~h~~g~Bone changed", 2000);
			    return true;
			}
			case VEHICLE_DIALOG:
			{
			   	switch(listitem)
				{
				    case 0:
   					{
    					if(PlayerInfo[playerid][VIP] < 1)
						{
							return SCM(playerid, -1, ""er"You need to be VIP to access this section");
						}
						ShowPlayerDialog(playerid, VEHICLE_DIALOG+16, DIALOG_STYLE_LIST, ""se" - Vehicles > VIP Vehicles", ""RED_E"Custom Cheetah\n"LB_E"Police Infurnes\n"YELLOW_E"Custom NRG\n"GREEN_E"Custom Bullet\n"WHITE_E"Custom Huntley", "Select", "Back");
					}
					case 1: ShowPlayerDialog(playerid, VEHICLE_DIALOG+1, DIALOG_STYLE_LIST, ""se" - Vehicles > Airplanes", "Andromada\nAT-400\nBeagle\nCropduster\nDodo\nNevada\nRustler\nShamal\nSkimmer\nStuntplane", "Select", "Back");
					case 2: ShowPlayerDialog(playerid, VEHICLE_DIALOG+2, DIALOG_STYLE_LIST, ""se" - Vehicles > Helicopters", "Cargobob\nLeviathan\nMaverick\nNews Maverick\nPolice Maverick\nRaindance\nSeasparrow\nSparrow", "Select", "Back");
					case 3: ShowPlayerDialog(playerid, VEHICLE_DIALOG+3, DIALOG_STYLE_LIST, ""se" - Vehicles > Bikes", "BF-400\nBike\nBMX\nFaggio\nFCR-900\nFreeway\nMountain Bike\nNRG-500\nPCJ-600\nPizzaboy\nQuad\nSanchez\nWayfarer", "Select", "Back");
					case 4: ShowPlayerDialog(playerid, VEHICLE_DIALOG+4, DIALOG_STYLE_LIST, ""se" - Vehicles > Convertibles", "Comet\nFeltzer\nStallion\nWindsor", "Select", "Back");
					case 5: ShowPlayerDialog(playerid, VEHICLE_DIALOG+5, DIALOG_STYLE_LIST, ""se" - Vehicles > Industrial", "Benson\nBobcat\nBurrito\nBoxville\nBoxburg\nCement Truck\nDFT-30\nFlatbed\nLinerunner\nMule\nNewsvan\nPacker\nPetrol Tanker\nPony\nRoadtrain\nRumpo\nSadler\nSadler Shit\nTopfun\nTractor\nTrashmaster\nUtility Van\nWalton\nYankee\nYosemite", "Select", "Back");
					case 6: ShowPlayerDialog(playerid, VEHICLE_DIALOG+6, DIALOG_STYLE_LIST, ""se" - Vehicles > Lowriders", "Blade\nBroadway\nRemington\nSavanna\nSlamvan\nTahoma\nTornado\nVoodoo", "Select", "Back");
					case 7: ShowPlayerDialog(playerid, VEHICLE_DIALOG+7, DIALOG_STYLE_LIST, ""se" - Vehicles > Off Road", "BF Injection\nDune\nHuntley\nLandstalker\nMesa\nMonster\nMonster A\nMonster B\nPatriot\nRancher A\nRancher B\nSandking", "Select", "Back");
					case 8: ShowPlayerDialog(playerid, VEHICLE_DIALOG+8, DIALOG_STYLE_LIST, ""se" - Vehicles > Public Service Vehicles", "Ambulance\nBarracks\nBus\nCabbie\nCoach\nCop Bike (HPV-1000)\nEnforcer\nFBI Rancher\nFBI Truck\nFiretruck\nFiretruck LA\nPolice Car (LSPD)\nPolice Car (LVPD)\nPolice Car (SFPD)\nRanger\nRhino\nS.W.A.T\nTaxi", "Select", "Back");
					case 9: ShowPlayerDialog(playerid, VEHICLE_DIALOG+9, DIALOG_STYLE_LIST, ""se" - Vehicles > Saloons", "Admiral\nBloodring Banger\nBravura\nBuccaneer\nCadrona\nClover\nElegant\nElegy\nEmperor\nEsperanto\nFortune\nGlendale Shit\nGlendale\nGreenwood\nHermes\nIntruder\nMajestic\nManana\nMerit\nNebula\nOceanic\nPicador\nPremier\nPrevion\nPrimo\nSentinel\nStafford\nSultan\nSunrise\nTampa\nVincent\nVirgo\nWillard\nWashington", "Select", "Back");
					case 10: ShowPlayerDialog(playerid, VEHICLE_DIALOG+10, DIALOG_STYLE_LIST, ""se" - Vehicles > Sport Vehicles", "Alpha\nBanshee\nBlista Compact\nBuffalo\nBullet\nCheetah\nClub\nEuros\nFlash\nHotring Racer\nHotring Racer A\nHotring Racer B\nInfernus\nJester\nPhoenix\nSabre\nSuper GT\nTurismo\nUranus\nZR-350", "Select", "Back");
					case 11: ShowPlayerDialog(playerid, VEHICLE_DIALOG+11, DIALOG_STYLE_LIST, ""se" - Vehicles > Station Wagons", "Moonbeam\nPerenniel\nRegina\nSolair\nStratum", "Select", "Back");
					case 12: ShowPlayerDialog(playerid, VEHICLE_DIALOG+12, DIALOG_STYLE_LIST, ""se" - Vehicles > Boats", "Coastguard\nDinghy\nJetmax\nLaunch\nMarquis\nPredator\nReefer\nSpeeder\nSquallo\nTropic", "Select", "Back");
					case 13: ShowPlayerDialog(playerid, VEHICLE_DIALOG+13, DIALOG_STYLE_LIST, ""se" - Vehicles > Trailers", "Article Trailer\nArticle Trailer 2\nArticle Trailer 3\nBaggage Trailer A\nBaggage Trailer B\nFarm Trailer\nPetrol Trailer\nStairs Trailer\nUtility Trailer", "Select", "Back");
					case 14: ShowPlayerDialog(playerid, VEHICLE_DIALOG+14, DIALOG_STYLE_LIST, ""se" - Vehicles > Unique Vehicles", "Baggage\nBrownstreak (Train)\nCaddy\nCamper\nCamper A\nCombine Harvester\nDozer\nDumper\nForklift\nFreight (Train)\nHotknife\nHotdog\nMower\nMr Whoopee\nRomero\nSecuricar\nStretch\nSweeper\nTram\nTowtruck\nTug", "Select", "Back");
					case 15: ShowPlayerDialog(playerid, VEHICLE_DIALOG+15, DIALOG_STYLE_LIST, ""se" - Vehicles > RC Vehicles", "RC Bandit\nRC Baron\nRC Raider\nRC Goblin\nRC Tiger\nRC Cam", "Select", "Back");
				}
				return true;
			}
			case VEHICLE_DIALOG+1:
			{
	   			new model_array[] = {592, 577, 511, 512, 593, 553, 476, 519, 460, 513};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+2:
			{
			    new model_array[] = {548, 417, 487, 488, 497, 563, 447, 469};
	            CarSpawner(playerid, model_array[listitem]);
			    return true;
			}
			case VEHICLE_DIALOG+3:
			{
				new	model_array[] = {581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 471, 468, 586};
    			CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+4:
			{
	   			new	model_array[] = {480, 533, 439, 555};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+5:
			{
				new model_array[] = {499, 422, 482, 498, 609, 524, 578, 455, 403, 414, 582, 443, 514, 413, 515, 440, 543, 605, 459, 531, 408, 552, 478, 456, 554};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+6:
			{
			    new model_array[] = { 536, 575, 534, 567, 535, 566, 576, 412 };
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+7:
			{
	    		new model_array[] = {424, 573, 579, 400, 500, 444, 556, 557, 470, 489, 505, 495};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+8:
			{
				new model_array[] = {416, 433, 431, 438, 437, 523, 427, 490, 528, 407, 544, 596, 598, 597, 599, 432, 601, 420};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+9:
			{
			    new model_array[] = {445, 504, 401, 518, 527, 542, 507, 562, 585, 419, 526, 604, 466, 492, 474, 546, 517, 410, 551, 516, 467, 600, 426, 436, 547, 405, 580, 560, 550, 549, 540, 491, 529, 421};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
   			}
			case VEHICLE_DIALOG+10:
			{
	    		new model_array[] = {602, 429, 496, 402, 541, 415, 589, 587, 565, 494, 502, 503, 411, 559, 603, 475, 506, 451, 558, 477};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+11:
			{
				new model_array[] = {418, 404, 479, 458, 561};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+12:
			{
		        new model_array[] = {472, 473, 493, 595, 484, 430, 453, 452, 446, 454};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+13:
			{
			    new model_array[] = {435, 450, 591, 606, 607, 610, 584, 608, 611};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+14:
			{
		        new model_array[] = {485, 537, 457, 483, 508, 532, 486, 406, 530, 538, 434, 588, 572, 423, 442, 428, 409, 574, 449, 525, 583};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+15:
			{
		        new model_array[] = {441, 464, 465, 501, 564, 594};
	            CarSpawner(playerid, model_array[listitem]);
				return true;
			}
			case VEHICLE_DIALOG+16:
			{
			    switch(listitem)
			    {
					case 0: cmd_v70(playerid, "");
					case 1: cmd_v71(playerid, "");
					case 2: cmd_v74(playerid, "");
					case 3: cmd_v73(playerid, "");
					case 4: cmd_v72(playerid, "");
			    }
			    return true;
			}
			case WEAPON_DIALOG:
			{
	  			switch(listitem)
		    	{
					case 0: ShowPlayerDialog(playerid, WEAPON_DIALOG+1, DIALOG_STYLE_LIST, ""se" - Weapons > Rifles", ""dl"AK-47\n"dl"M4\n"dl"Country Rifle\n"dl"Sniper Rifle", "Select", "Back");
					case 1: ShowPlayerDialog(playerid, WEAPON_DIALOG+2, DIALOG_STYLE_LIST, ""se" - Weapons > Submachine Guns", ""dl"MP 5\n"dl"UZI\n"dl"TEC-9", "Select", "Back");
					case 2: ShowPlayerDialog(playerid, WEAPON_DIALOG+3, DIALOG_STYLE_LIST, ""se" - Weapons > Shot Guns", ""dl"Pump Gun\n"dl"Spawn-Off\n"dl"Combat Shotgun", "Select", "Back");
					case 3: ShowPlayerDialog(playerid, WEAPON_DIALOG+4, DIALOG_STYLE_LIST, ""se" - Weapons > Hand Guns", ""dl"9mm\n"dl"Silenced 9mm\n"dl"Desert Eagle", "Select", "Back");
	   				case 4: ShowPlayerDialog(playerid, WEAPON_DIALOG+5, DIALOG_STYLE_LIST, ""se" - Weapons > Melee Weapons", ""dl"Golf Club\n"dl"Nightstick\n"dl"Knife\n"dl"Shovel\n"dl"Katana\n"dl"Chainsaw\n"dl"Double-ended Dildo\n"dl"Silver Vibrator\n"dl"Flowers", "Select", "Back");
	   				case 5: ShowPlayerDialog(playerid, WEAPON_DIALOG+6, DIALOG_STYLE_LIST, ""se" - Weapons > Special Weapons", ""dl"Tear Gas\n"dl"Molotov Cocktail\n"dl"Flamethrower\n"dl"Spraycan\n"dl"Fire Extinguisher", "Select", "Back");
				}
				return true;
			}
			case WEAPON_DIALOG+1:
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
			case WEAPON_DIALOG+2:
			{
				switch(listitem)
				{
			    	case 0:{GivePlayerWeapon(playerid,29,99999);}
					case 1:{GivePlayerWeapon(playerid,28,99999);}
					case 2:{GivePlayerWeapon(playerid,32,99999);}
				}
				return true;
			}
			case WEAPON_DIALOG+3:
			{
	  			switch(listitem)
				{
			    	case 0:{GivePlayerWeapon(playerid,25,99999);}
            		case 1:{GivePlayerWeapon(playerid,26,99999);}
					case 2:{GivePlayerWeapon(playerid,27,99999);}
				}
			    return true;
			}
			case WEAPON_DIALOG+4:
			{
				switch(listitem)
				{
			    	case 0:{GivePlayerWeapon(playerid,22,99999);}
					case 1:{GivePlayerWeapon(playerid,23,99999);}
			    	case 2:{GivePlayerWeapon(playerid,24,99999);}
				}
			    return true;
			}
			case WEAPON_DIALOG+5:
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
			case WEAPON_DIALOG+6:
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
			case VMENU_DIALOG:
			{
   				switch(listitem)
			    {
			        case 0:
			        {
			            if(GetPlayerVehicleID(playerid) == PlayerInfo[playerid][PV_Vehicle]) return SCM(playerid, -1, ""er"You are alread in your car!");
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
			  		    if(PlayerInfo[playerid][PV_3DLabel] != Text3D:-1)
					    {
					        DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
					        PlayerInfo[playerid][PV_3DLabel] = Text3D:-1;
					    }
						if(PlayerInfo[playerid][PV_Vehicle] != 1)
						{
							DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
							PlayerInfo[playerid][PV_Vehicle] = -1;
						}
						if(PlayerInfo[playerid][Vehicle] != -1)
						{
							DestroyVehicle(PlayerInfo[playerid][Vehicle]);
							PlayerInfo[playerid][Vehicle] = -1;
						}
		   				for(new obj = 0; obj < 13; obj++)
						{
						    if(hVIPVehObj[playerid][obj] != -1)
						    {
						        DestroyObject(hVIPVehObj[playerid][obj]);
						        hVIPVehObj[playerid][obj] = -1;
						    }
						}
		   		   		if(PlayerInfo[playerid][TrailerVid] != -1)
						{
							DestroyVehicle(PlayerInfo[playerid][TrailerVid]);
							PlayerInfo[playerid][TrailerVid] = -1;
						}

						new Float:POS[4],
						    vlabel[128];

                        format(vlabel, sizeof(vlabel), ""ngs_blue"%s´s \n"white"private vehicle", __GetName(playerid));

						GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
						GetPlayerFacingAngle(playerid, POS[3]);

						PlayerInfo[playerid][PV_Vehicle] = CreateVehicle(PlayerInfoVeh[playerid][Model], POS[0], POS[1], POS[2], POS[3], 0, 0, -1);
						PlayerInfo[playerid][PV_3DLabel] = CreateDynamic3DTextLabel(vlabel, -1, 0.0, 0.0, 0.0, 30.0, INVALID_PLAYER_ID, PlayerInfo[playerid][PV_Vehicle], 0, -1, -1, -1, 30.0);

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
						ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
					}
					case 3:
					{
					    cmd_cc(playerid, "");
					}
					case 4:
					{
						MySQL_DeletePlayerVehiclePerm(playerid);
					}
				}
				return true;
			}
			case CARBUY_DIALOG:
			{
			    new string[2048];
   				switch(listitem)
		    	{
		        	case 0:
		        	{
						strcat(string, ""dl"Blade "green"$595,000\n"dl"Broadway "green"$390,000\n"dl"Remington "green"$500,000\n"dl"Savanna "green"$530,000\n"dl"Slamvan "green"$390,000\n"dl"Tahoma "green"$300,000\n"dl"Tornado "green"$399,000\n"dl"Voodoo "green"$500,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+1, DIALOG_STYLE_LIST, ""se" - Private Vehicles > Lowriders", string, "Select", "Back");
					}
		        	case 1:
					{
					    strcat(string, ""dl"Alpha "green"$305,000\n"dl"Banshee "green"$600,000\n"dl"Buffalo "green"$450,000\n"dl"Bullet "green"$960,000\n"dl"Cheetah "green"$498,000\n"dl"Club "green"$300,000\n"dl"Euros "green"$310,000\n"dl"Infernus "green"$1,350,000\n");
						strcat(string, ""dl"Jester "green"$1,400,000\n"dl"Phoenix "green"$1,000,000\n"dl"Sabre "green"$500,000\n"dl"Super GT "green"$600,000\n"dl"Turismo "green"$999,000\n"dl"Uranus "green"$450,000\n"dl"ZR-350 "green"$450,000");
                        strcat(string, "\n"dl"Flash "green"$500,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+2, DIALOG_STYLE_LIST, ""se" - Private Vehicles > Sport Vehicles", string, "Select", "Back");
					}
					case 2:
					{
					    strcat(string, ""dl"Bravura "green"$200,000\n"dl"Sentinel "green"$350,000\n"dl"Manana "green"$200,000\n"dl"Esperanto "green"$200,000\n"dl"Washington "green"$350,000\n"dl"Premier "green"$400,000\n"dl"Admiral "green"$300,000\n"dl"Glendale "green"$300,000\n"dl"Oceanic "green"$300,000");
					    strcat(string, "\n"dl"Hermes "green"$300,000\n"dl"Greenwood "green"$350,000\n"dl"Elegant "green"$400,000\n"dl"Fortune "green"$500,000\n"dl"Clover "green"$400,000\n"dl"Tampa "green"$250,000\n"dl"Sunrise "green"$450,000\n"dl"Sultan "green"$550,000\n"dl"Merit "green"$400,000");
						strcat(string, "\n"dl"Elegy "green"$500,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+3, DIALOG_STYLE_LIST, ""se" - Private Vehicles > Saloons", string, "Select", "Back");
					}
					case 3:
					{
					    strcat(string, ""dl"BF-400 "green"$500,000\n"dl"Wayfarer "green"$250,000\n"dl"PCJ-600 "green"$340,000\n"dl"Faggio "green"$100,000\n"dl"Freeway "green"$500,000\n"dl"Sanchez "green"$400,000\n"dl"FCR-900 "green"$300,000\n"dl"NRG-500 "green"$780,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+4, DIALOG_STYLE_LIST, ""se" - Private Vehicles > Bikes", string, "Select", "Back");
					}
					case 4:
					{
					    strcat(string, ""dl"Stallion "green"$200,000\n"dl"Comet "green"$400,000\n"dl"Feltzer "green"$700,000\n"dl"Windsor "green"$500,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+5, DIALOG_STYLE_LIST, ""se" - Private Vehicles > Convertibles", string, "Select", "Back");
					}
					case 5:
					{
					    strcat(string, ""dl"Landstalker "green"$300,000\n"dl"BF Injection "green"$650,000\n"dl"Monster "green"$700,000\n"dl"Patriot "green"$455,000\n"dl"Rancher "green"$300,000\n"dl"Sandking "green"$500,000");
						ShowPlayerDialog(playerid, CARBUY_DIALOG+6, DIALOG_STYLE_LIST, ""se" - Private Vehicles > Off Road", string, "Select", "Back");
					}
   					case 6:
					{
					    if(PlayerInfo[playerid][VIP] == 1)
					    {
						    strcat(string, ""dl"Vortex\n"dl"Hustler\n"dl"Bandito\n"dl"Kart");
							ShowPlayerDialog(playerid, CARBUY_DIALOG+7, DIALOG_STYLE_LIST, ""se" - Private Vehicles > "lb_e"VIP Vehicles", string, "Select", "Back");
						}
						else
						{
						    SCM(playerid, -1, ""er"You need to be VIP");
						    ShowDialog(playerid, CARBUY_DIALOG);
						}
					}
				}
			    return true;
			}
			case CARBUY_DIALOG+1:
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
			case CARBUY_DIALOG+2:
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
			        case 13: PlayerBuyVehicle(playerid, 450000, 558);
			        case 14: PlayerBuyVehicle(playerid, 450000, 477);
			        case 15: PlayerBuyVehicle(playerid, 450000, 565);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
				}
			    return true;
			}//401, 405, 410, 419, 421, 426, 445, 466, 467, 474, 492, 507, 526, 542, 549, 550, 560, 551, 562
			case CARBUY_DIALOG+3:
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
			        case 18: PlayerBuyVehicle(playerid, 400000, 562);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
				}
			    return true;
			}
			case CARBUY_DIALOG+4:
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
			case CARBUY_DIALOG+5:
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
			case CARBUY_DIALOG+6:
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
			case CARBUY_DIALOG+7:
			{
			    switch(listitem) // 539, 545, 568, 571
			    {
			        case 0: PlayerBuyVehicle(playerid, 0, 539);
			        case 1: PlayerBuyVehicle(playerid, 0, 545);
			        case 2: PlayerBuyVehicle(playerid, 0, 568);
			        case 3: PlayerBuyVehicle(playerid, 0, 571);
			        default: ShowDialog(playerid, CARBUY_DIALOG);
			    }
			    return true;
			}
			case NEON_DIALOG:
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
	  		    if(PlayerInfo[playerid][PV_3DLabel] != Text3D:-1)
			    {
			        DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
			        PlayerInfo[playerid][PV_3DLabel] = Text3D:-1;
			    }
				if(PlayerInfo[playerid][PV_Vehicle] != 1)
				{
					DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
					PlayerInfo[playerid][PV_Vehicle] = -1;
				}

 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
				for(new obj = 0; obj < 13; obj++)
				{
				    if(hVIPVehObj[playerid][obj] != -1)
				    {
				        DestroyObject(hVIPVehObj[playerid][obj]);
				        hVIPVehObj[playerid][obj] = -1;
				    }
				}
		   		if(PlayerInfo[playerid][TrailerVid] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][TrailerVid]);
					PlayerInfo[playerid][TrailerVid] = -1;
				}
				
				new Float:POS[4],
				    vlabel[128];

                format(vlabel, sizeof(vlabel), ""ngs_blue"%s´s \n"white"private vehicle", __GetName(playerid));

				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				GetPlayerFacingAngle(playerid, POS[3]);

				PlayerInfo[playerid][PV_Vehicle] = CreateVehicle(PlayerInfoVeh[playerid][Model], POS[0], POS[1], POS[2], POS[3], 0, 0, -1);
				PlayerInfo[playerid][PV_3DLabel] = CreateDynamic3DTextLabel(vlabel, -1, 0.0, 0.0, 0.0, 30.0, INVALID_PLAYER_ID, PlayerInfo[playerid][PV_Vehicle], 0, -1, -1, -1, 30.0);

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
			case VEHICLE_PLATE_DIALOG:
			{
   				if(strlen(inputtext) < 2 || strlen(inputtext) > 12 || isnull(inputtext))
		    	{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
			 		ShowDialog(playerid, VEHICLE_PLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, " ", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
			 		ShowDialog(playerid, VEHICLE_PLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, "|", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
			 		ShowDialog(playerid, VEHICLE_PLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, "'", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
			 		ShowDialog(playerid, VEHICLE_PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "@", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
			 		ShowDialog(playerid, VEHICLE_PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "`", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
			 		ShowDialog(playerid, VEHICLE_PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "´", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
			 		ShowDialog(playerid, VEHICLE_PLATE_DIALOG);
					return 1;
				}
				if(sscanf(inputtext, "s[13]", PlayerInfoVeh[playerid][Plate]))
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
			 		ShowDialog(playerid, VEHICLE_PLATE_DIALOG);
					return 1;
				}
				mysql_real_escape_string(PlayerInfoVeh[playerid][Plate], PlayerInfoVeh[playerid][Plate], g_SQL_handle, 13);
				CreateFinalCar(playerid);
				return true;
			}
			case CUSTOM_PLATE_DIALOG:
			{
   				if(strlen(inputtext) < 2 || strlen(inputtext) > 12 || isnull(inputtext))
		    	{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
				 	ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
				 	return 1;
				}
    			if(strfind(inputtext, "|", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
				 	ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, " ", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
				 	ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
					return 1;
				}
    			if(strfind(inputtext, "'", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
				 	ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "@", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
				 	ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "`", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
				 	ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
					return 1;
				}
			    if(strfind(inputtext, "´", false) != -1)
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
				 	ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
					return 1;
				}
				if(sscanf(inputtext, "s[13]", PlayerInfoVeh[playerid][Plate]))
				{
					SCM(playerid, RED, "Number plate length: 2 - 12 characters");
				 	ShowDialog(playerid, CUSTOM_PLATE_DIALOG);
				 	return 1;
				}

                mysql_real_escape_string(PlayerInfoVeh[playerid][Plate], PlayerInfoVeh[playerid][Plate], g_SQL_handle, 13);

	  		    if(PlayerInfo[playerid][PV_3DLabel] != Text3D:-1)
			    {
			        DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
			        PlayerInfo[playerid][PV_3DLabel] = Text3D:-1;
			    }
				if(PlayerInfo[playerid][PV_Vehicle] != 1)
				{
					DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
					PlayerInfo[playerid][PV_Vehicle] = -1;
				}
 				if(PlayerInfo[playerid][Vehicle] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][Vehicle]);
					PlayerInfo[playerid][Vehicle] = -1;
				}
				for(new obj = 0; obj < 13; obj++)
				{
				    if(hVIPVehObj[playerid][obj] != -1)
				    {
				        DestroyObject(hVIPVehObj[playerid][obj]);
				        hVIPVehObj[playerid][obj] = -1;
				    }
				}
		   		if(PlayerInfo[playerid][TrailerVid] != -1)
				{
					DestroyVehicle(PlayerInfo[playerid][TrailerVid]);
					PlayerInfo[playerid][TrailerVid] = -1;
				}
				
				new Float:POS[4],
				    vlabel[128];

                format(vlabel, sizeof(vlabel), ""ngs_blue"%s´s \n"white"private vehicle", __GetName(playerid));

				GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
				GetPlayerFacingAngle(playerid, POS[3]);

				PlayerInfo[playerid][PV_Vehicle] = CreateVehicle(PlayerInfoVeh[playerid][Model], POS[0], POS[1], POS[2], POS[3], 0, 0, -1);
				PlayerInfo[playerid][PV_3DLabel] = CreateDynamic3DTextLabel(vlabel, -1, 0.0, 0.0, 0.0, 30.0, INVALID_PLAYER_ID, PlayerInfo[playerid][PV_Vehicle], 0, -1, -1, -1, 30.0);

				SetVehicleVirtualWorld(PlayerInfo[playerid][PV_Vehicle], GetPlayerVirtualWorld(playerid));
				LinkVehicleToInterior(PlayerInfo[playerid][PV_Vehicle], GetPlayerInterior(playerid));
				SetVehicleNumberPlate(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Plate]);
				SetVehicleToRespawn(PlayerInfo[playerid][PV_Vehicle]);

				PutPlayerInVehicle(playerid, PlayerInfo[playerid][PV_Vehicle], 0);

				SendInfo(playerid, "~h~~y~Plate changed!", 2500);
			    return true;
			}
			case BGVOTING_DIALOG:
			{
   				if(CurrentBGMap == BG_VOTING)
				{
				    new string[100];
	 				switch(listitem)
					{
						case 0:
						{
						   	format(string, sizeof(string), "%s voted for map 'Forest'", __GetName(playerid));
							BGMSG(string);
							BGMapVotes[0]++;
						}
						case 1:
						{
						   	format(string, sizeof(string), "%s voted for map 'Quarters'", __GetName(playerid));
							BGMSG(string);
						   	BGMapVotes[1]++;
						}
						case 2:
						{
						   	format(string, sizeof(string), "%s voted for map 'Rust'", __GetName(playerid));
							BGMSG(string);
						   	BGMapVotes[2]++;
						}
						case 3:
						{
						   	format(string, sizeof(string), "%s voted for map 'Italy'", __GetName(playerid));
							BGMSG(string);
						   	BGMapVotes[3]++;
						}
						case 4:
						{
						   	format(string, sizeof(string), "%s voted for map 'Medieval'", __GetName(playerid));
							BGMSG(string);
						   	BGMapVotes[4]++;
						}
					}
				}
				else
				{
				    SCM(playerid, RED, ""derby_sign" No voting time at the momment!");
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
	        case VCONTROL_DIALOG+1:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
     			GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
            	SetVehicleParamsEx(GetPlayerVehicleID(playerid), 0, lights, alarm, doors, bonnet, boot, objective);
	        }
	        case VCONTROL_DIALOG+2:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, 0, alarm, doors, bonnet, boot, objective);
	        }
	        case VCONTROL_DIALOG+3:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, 0, doors, bonnet, boot, objective);
	        }
	        case VCONTROL_DIALOG+4:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, 0, boot, objective);
	        }
	        case VCONTROL_DIALOG+5:
	        {
     			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
				    return SCM(playerid, -1, ""er"You must be a driver in a vehicle to use vehicle control!");
				}
				GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, 0, objective);
	        }
 		    case GMENU_DIALOG + 1:
 		    {
 		        ShowDialog(playerid, GMENU_DIALOG);
 		        return true;
 		    }
 		    case HELP_DIALOG + 4:
 		    {
 		        ShowPlayerDialog(playerid, HELP_DIALOG + 3, DIALOG_STYLE_LIST, ""se" - Minigames", ""dl"Race (/race)\n"dl"Derby (/derby)\n"dl"Fallout (/fallout)\n"dl"Gungame (/gungame)\n"dl"Minigun (/minigun)\n"dl"Sniper (/sniper)\n"dl"Death Match (/dm1-4)\n"dl"Team Death Match (/tdm)\n"dl"WAR (/war)", "Select", "");
 		        return true;
 		    }
 		    case HELP_DIALOG + 1, HELP_DIALOG + 2:
 		    {
 		        cmd_help(playerid, "");
 		        return true;
 		    }
 		    case TELE_DIALOG + 1..TELE_DIALOG + 10:
 		    {
 		        ShowDialog(playerid, TELE_DIALOG);
 		        return true;
 		    }
			case DIALOG_RACE_RACETYPE:
			{
			    BuildRace = 0;
			    return true;
			}
    	    case DIALOG_RACE_RACEVW, DIALOG_RACE_RACEVWERR:
		    {
		        ShowDialog(playerid, DIALOG_RACE_RACETYPE);
		        return true;
		    }
	 	    case DIALOG_RACE_RACEVEH, DIALOG_RACE_RACEVEHERR:
		    {
		        ShowDialog(playerid, DIALOG_RACE_RACEVW);
		        return true;
		    }
		    case DIALOG_RACE_RACESTARTPOS:
			{
			    ShowDialog(playerid, DIALOG_RACE_RACEVEH);
			    return true;
			}
		    case DIALOG_RACE_CHECKPOINTS:
			{
			    ShowDialog(playerid, DIALOG_RACE_RACESTARTPOS);
			    return true;
			}
		    case DIALOG_RACE_RACERDY:
			{
			    ShowDialog(playerid, DIALOG_RACE_RACERDY);
			    return true;
			}
 		    case DERBY_VOTING_DIALOG:
 		    {
 		        ShowDialog(playerid, DERBY_VOTING_DIALOG);
 		        return true;
 		    }
 		    case LOGIN_DIALOG:
 		    {
 		        LoginDialog(playerid);
 		        return true;
 		    }
 		    case REGISTER_DIALOG:
 		    {
 		        RegisterDialog(playerid);
 		        return true;
 		    }
		    case CMDS_DIALOG + 1:
		    {
		        ShowDialog(playerid, CMDS_DIALOG);
		        return true;
		    }
 		    case STREAM_DIALOG:
 		    {
 		        StopAudioStreamForPlayer(playerid);
 		        return true;
			}
			case STREAM_DIALOG+1..STREAM_DIALOG+8:
			{
				ShowDialog(playerid, STREAM_DIALOG);
				return true;
			}
			case VEHICLE_DIALOG+1..VEHICLE_DIALOG+16:
			{
				ShowDialog(playerid, VEHICLE_DIALOG);
				return true;
			}
			case WEAPON_DIALOG+1..WEAPON_DIALOG+6:
			{
				ShowDialog(playerid, WEAPON_DIALOG);
				return true;
			}
			case VEHICLE_PLATE_DIALOG:
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
			case CARBUY_DIALOG:
			{
   				SetCameraBehindPlayer(playerid);
		    	SetPlayerVirtualWorld(playerid, 0);
		    	TogglePlayerControllable(playerid, true);
		    	return true;
			}
			case CARBUY_DIALOG+1..CARBUY_DIALOG+7:
			{
				ShowDialog(playerid, CARBUY_DIALOG);
				return true;
			}
			case BGVOTING_DIALOG:
			{
		 		ShowDialog(playerid, BGVOTING_DIALOG);
		 		return true;
			}
		}
	}
	return 0;
}

public OnDynamicObjectMoved(objectid)
{
	if(objectid == MellnikGate)
	{
	    IsMellnikGateMoving = false;
	}
	return 1;
}

function:CancelGangCreation(playerid)
{
	PlayerInfo[playerid][GangPosition] = 0;
	PlayerInfo[playerid][GangID] = 0;
	PlayerInfo[playerid][GangName][0] = '\0';
	PlayerInfo[playerid][GangTag][0] = '\0';
 	return 1;
}

function:OnHouseLoadEx(index)
{
	new	line[150],
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

		format(line, sizeof(line), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[index][iID], ToCurrency(HouseInfo[index][price]), HouseInfo[index][E_score], HouseIntTypes[HouseInfo[index][interior]][intname]);

		HouseInfo[index][label] = CreateDynamic3DTextLabel(line, (HouseInfo[index][sold]) ? (0xFF0000FF) : (0x00FF00FF), HouseInfo[index][E_x], HouseInfo[index][E_y], floatadd(HouseInfo[index][E_z], 0.3), 30.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 30.0);
		HouseInfo[index][pickid] = CreateDynamicPickup((HouseInfo[index][sold]) ? (1272) : (1273), 1, HouseInfo[index][E_x], HouseInfo[index][E_y], HouseInfo[index][E_z], -1, -1, -1, 30.0);
		HouseInfo[index][iconid] = CreateDynamicMapIcon(HouseInfo[index][E_x], HouseInfo[index][E_y], HouseInfo[index][E_z], (HouseInfo[index][sold]) ? (32) : (31), 1, -1, -1, -1, 100.0);
		index++;
	}
	mysql_free_result();
	return 1;
}

function:OnHouseLoad()
{
	new	line[150],
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
		    format(line, sizeof(line), ""house_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[houseid][iID], ToCurrency(HouseInfo[houseid][price]), HouseInfo[houseid][E_score], HouseIntTypes[HouseInfo[houseid][interior]][intname]);
		}
		else
		{
		    format(line, sizeof(line), ""house_mark"\nOwner: %s\nID: %i\nPrice: $%s\nScore: %i\nInterior: %s", HouseInfo[houseid][Owner], HouseInfo[houseid][iID], ToCurrency(HouseInfo[houseid][price]), HouseInfo[houseid][E_score], HouseIntTypes[HouseInfo[houseid][interior]][intname]);
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
	new line[150],
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

		format(line, sizeof(line), ""business_mark"\nOwner: ---\nID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[pindex][iID], ToCurrency(PropInfo[pindex][price]), PropInfo[pindex][E_score], ToCurrency(PropInfo[pindex][earnings]));

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
	new line[150],
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
			format(line, sizeof(line), ""business_mark"\nOwner: ---\n"white"ID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[propid][iID], ToCurrency(PropInfo[propid][price]), PropInfo[propid][E_score], ToCurrency(PropInfo[propid][earnings]));
		}
        else
		{
			format(line, sizeof(line), ""business_mark"\nOwner: %s\n"white"ID: %i\nPrice: $%s\nScore: %i\nEarnings: $%s", PropInfo[propid][Owner], PropInfo[propid][iID], ToCurrency(PropInfo[propid][price]), PropInfo[propid][E_score], ToCurrency(PropInfo[propid][earnings]));
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
	    BGMSG("There were no votes! New Voting starting");
	    ExecBGVotingTimer();
		ClearBGVotes();
		for(new i = 0; i < MAX_PLAYERS; i++)
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
	    BGMSG("Voting was not clear! New Voting starting!");
	    ExecBGVotingTimer();
		ClearBGVotes();
		for(new i = 0; i < MAX_PLAYERS; i++)
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
	    BGMSG("Map 'Forest' won! Let´s start!");
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
	    BGMSG("Map 'Quaters' won! Let´s start!");
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
	    BGMSG("Map 'Rust' won! Let´s start!");
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
	    BGMSG("Map 'Italy' won! Let´s start!");
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
	    BGMSG("Map 'Medieval' won! Let´s start!");
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
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == gBG_TEAM1 || gTeam[i] == gBG_TEAM2 || gTeam[i] == gBG_VOTING)
	    {
	        SetPlayerBGStaticMeshes(i);
	    }
	}

	CurrentBGMap = BG_VOTING;
	ExecBGVotingTimer();

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(gTeam[i] == gBG_TEAM1 || gTeam[i] == gBG_TEAM2 || gTeam[i] == gBG_VOTING)
	    {
			ShowDialog(i, BGVOTING_DIALOG);
	    }
	}

	ResetBGGameTime();

    BGTeam1Players = 0;
    BGTeam2Players = 0;

	new string[128],
		money;

	if(BGTeam1Kills == BGTeam2Kills)
	{
	    format(string, sizeof(string), "Standoff! Rangers kills: %i Spetsnaz kills: %i", BGTeam1Kills, BGTeam2Kills);
		BGMSG(string);
		BGMSG("New Voting starting!");
		BGTeam1Kills = 0;
		BGTeam2Kills = 0;
	}
	else if(BGTeam1Kills > BGTeam2Kills)
	{
	    format(string, sizeof(string), "Rangers won! Rangers kills: %i Spetsnaz kills: %i", BGTeam1Kills, BGTeam2Kills);
		BGMSG(string);
		BGMSG("New Voting starting!");
		BGTeam1Kills = 0;
		BGTeam2Kills = 0;

		money = (800 * BGTeam1Players) + (100 * BGTeam2Players);
 		format(string, sizeof(string), "+$%s~n~+5 Score~n~+1 BG win", ToCurrency(money));

	 	for(new i = 0; i < MAX_PLAYERS; i++)
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
		BGMSG(string);
		BGMSG("New Voting starting!");
		BGTeam1Kills = 0;
		BGTeam2Kills = 0;

		money = (800 * BGTeam1Players) + (100 * BGTeam2Players);
 		format(string, sizeof(string), "+$%s~n~+5 Score~n~+1 BG win", ToCurrency(money));

	 	for(new i = 0; i < MAX_PLAYERS; i++)
		{
		    if(gTeam[i] == gBG_TEAM2)
		    {
		        GivePlayerCash(i, money);
		        _GivePlayerScore(i, 5);
		        PlayerInfo[i][BGWins]++;
		    }
		}
	}

	for(new i = 0; i < MAX_PLAYERS; i++)
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

function:AutoLoginCam(playerid)
{
    ShowPlayerConnectTextdraws(playerid);
    TextDrawHideForPlayer(playerid, TXTLoading);
    LoginCam(playerid, true);
    //ShowPlayerConnectTextdraws(playerid);
    SetTimerEx("ForceCamExit", 10000, false, "i", playerid);
	return 1;
}

function:ForceCamExit(playerid)
{
    MySQL_LoadPlayer(playerid);
    MySQL_LogPlayerIn(playerid);
    MySQL_LoadPlayerToys(playerid);
    PlayerInfo[playerid][AllowSpawn] = true;
    PlayerInfo[playerid][ExitType] = 2;
	TogglePlayerSpectating(playerid, false);
	HidePlayerConnectTextdraws(playerid);
	InterpolateCameraPos(playerid, 352.937377, -1813.479492, 39.280658, 390.257812, -1808.886718, 18.014354, 800, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 351.274230, -1816.356323, 37.054042, 386.991821, -1811.187500, 17.814441, 800, CAMERA_MOVE);
	return 1;
}

function:RegisterDialog(playerid)
{
    TextDrawHideForPlayer(playerid, TXTLoading);
    
	new newtext1[1024], newtext2[128];
    format(newtext2, sizeof(newtext2), ""ngs_blue"Registration "white"- %s", __GetName(playerid));

	format(newtext1, sizeof(newtext1), ""white"Welcome to "red"Stunt "blue"Evolution "white"! \nHow are you, %s?\n\nDesired name: \t%s\nYour IP: \t%s\n\nIt seems that you don´t have an account, please enter a password below:", __GetName(playerid), __GetName(playerid), __GetIP(playerid));
	ShowPlayerDialog(playerid, REGISTER_DIALOG, DIALOG_STYLE_PASSWORD, newtext2, newtext1, "Register", "");
	return 1;
}

function:LoginCam(playerid, bool:autologin)
{
	InterpolateCameraPos(playerid, 546.127258, -1789.304077, 43.170913, 353.325012, -1818.477539, 39.799224, autologin ? 9100 : 11337, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 542.160339, -1789.496826, 42.694873, 351.647918, -1820.904907, 37.098251, autologin ? 9100 : 11337, CAMERA_MOVE);
    return 1;
}

function:LoginDialog(playerid)
{
	new newtext[1024], newtext2[128];
    TextDrawHideForPlayer(playerid, TXTLoading);
    format(newtext2, sizeof(newtext2), ""ngs_blue"Login "white"- %s", __GetName(playerid));
    format(newtext, sizeof(newtext), ""white"Welcome to "red"Stunt "blue"Evolution "white"! \nHow are you, %s?\n\nAccount: \t%s\nYour IP: \t%s\n\nThe name that you are using is registered! Please enter the password:",  __GetName(playerid), __GetName(playerid), __GetIP(playerid));
	ShowPlayerDialog(playerid, LOGIN_DIALOG, DIALOG_STYLE_PASSWORD, newtext2, newtext, "Login", "");
    return 1;
}

function:LoginFailDialog(playerid)
{
   	TextDrawHideForPlayer(playerid, TXTLoading);
	new newtext[1024], newtext2[128];
    format(newtext2, sizeof(newtext2), ""ngs_blue"Login "white"- %s", __GetName(playerid));
    format(newtext, sizeof(newtext), ""white"Welcome to "red"Stunt "blue"Evolution "white"!\n"red"Wrong Password! Tries left: %i"white"\n\nAccount: \t%s\nYour IP: \t%s\n\nThe name that you are using is registered! Please enter the password:", (3 - PlayerInfo[playerid][FailLogin]), __GetName(playerid), __GetIP(playerid));
	ShowPlayerDialog(playerid, LOGIN_DIALOG, DIALOG_STYLE_PASSWORD, newtext2, newtext, "Login", "");
    return 1;
}

GetPlayingTimeFormat(playerid)
{
    PlayerInfo[playerid][TotalTime] = PlayerInfo[playerid][TotalTime] + (gettime() - PlayerInfo[playerid][ConnectTime]);
    PlayerInfo[playerid][ConnectTime] = gettime();

    new ptime[32],
        time[3];

    time[0] = floatround(PlayerInfo[playerid][TotalTime] / 3600, floatround_floor);
    time[1] = floatround(PlayerInfo[playerid][TotalTime] / 60, floatround_floor) % 60;
    time[2] = floatround(PlayerInfo[playerid][TotalTime] % 60, floatround_floor);

	format(ptime, sizeof(ptime), "%ih %02im %02is", time[0], time[1], time[2]);
	return ptime;
}

function:CarSpawner(playerid, model)
{
	if(model == 432 || model == 425 || model == 447 || model == 571 || model == 568 || model == 539 || model == 545)
	{
	    if(PlayerInfo[playerid][Level] <= 3)
	    {
            return SCM(playerid, -1, ""er"Only admins can spawn this");
		}
	}
	
	if(model == 520 && PlayerInfo[playerid][VIP] == 0 && PlayerInfo[playerid][Level] == 0) return SCM(playerid, -1, ""er"Only admins can spawn this");
	
	if(model == 538 || model == 537 || model == 449)
	{
		return SCM(playerid, -1, ""er"Cannot spawn these vehicles");
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
    if(PlayerInfo[playerid][PV_3DLabel] != Text3D:-1)
    {
        DestroyDynamic3DTextLabel(PlayerInfo[playerid][PV_3DLabel]);
        PlayerInfo[playerid][PV_3DLabel] = Text3D:-1;
    }
	if(PlayerInfo[playerid][PV_Vehicle] != -1)
	{
		DestroyVehicle(PlayerInfo[playerid][PV_Vehicle]);
		PlayerInfo[playerid][PV_Vehicle] = -1;
	}
	if(PlayerInfo[playerid][Vehicle] != -1)
	{
		DestroyVehicle(PlayerInfo[playerid][Vehicle]);
		PlayerInfo[playerid][Vehicle] = -1;
	}
	for(new obj = 0; obj < 13; obj++)
	{
	    if(hVIPVehObj[playerid][obj] != -1)
	    {
	        DestroyObject(hVIPVehObj[playerid][obj]);
	        hVIPVehObj[playerid][obj] = -1;
	    }
	}
	if(PlayerInfo[playerid][TrailerVid] != -1)
	{
		DestroyVehicle(PlayerInfo[playerid][TrailerVid]);
		PlayerInfo[playerid][TrailerVid] = -1;
	}
		
	new Float:POS[4],
		string[255],
		color1 = (random(128) + 127),
		color2 = (random(128) + 127);

	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
	GetPlayerFacingAngle(playerid, POS[3]);

	PlayerInfo[playerid][Vehicle] = CreateVehicle(model, POS[0], POS[1], POS[2], POS[3], color1, color2, -1);

	SetVehicleZAngle(PlayerInfo[playerid][Vehicle], POS[3]);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	ClearAnimations(playerid);
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");
	SetVehicleVirtualWorld(PlayerInfo[playerid][Vehicle], GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(PlayerInfo[playerid][Vehicle], GetPlayerInterior(playerid));
	SetVehicleNumberPlate(PlayerInfo[playerid][Vehicle], "{3399ff}S{FFFFFF}tun{F81414}T");
	SetVehicleToRespawn(PlayerInfo[playerid][Vehicle]);
	AddVehicleComponent(PlayerInfo[playerid][Vehicle], 1010);
	PutPlayerInVehicle(playerid, PlayerInfo[playerid][Vehicle], 0);
	format(string, sizeof(string), "Vehicle Spawned!~n~~b~~h~Name: ~w~%s~n~~b~~h~Model: ~w~%i~n~~b~~h~Colors: ~w~%i, %i", GetVehicleNameById(PlayerInfo[playerid][Vehicle]), GetVehicleModel(PlayerInfo[playerid][Vehicle]), color1, color2);
	SendInfo(playerid, string, 2500);
	return 1;
}

// --
// -- Messages
// --

FalloutMSG(const string[])
{
	new finstring[200];
	format(finstring, sizeof(finstring), ""fallout_sign" %s", string);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (gTeam[i] == FALLOUT))
		{
			SCM(i, GREY, finstring);
		}
	}
}

DerbyMSG(const string[])
{
	new finstring[200];
	format(finstring, sizeof(finstring), ""derby_sign" %s", string);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (gTeam[i] == DERBY))
		{
			SCM(i, -1, finstring);
		}
	}
}

BGMSG(const string[])
{
	new finstring[200];
	format(finstring, sizeof(finstring), ""tdm_sign" %s", string);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerAvail(i) && (gTeam[i] == gBG_TEAM1 || gTeam[i] == gBG_VOTING || gTeam[i] == gBG_TEAM2))
		{
  			SCM(i, -1, finstring);
		}
	}
}

RaceMSG(const string[])
{
	new finstring[200];
	format(finstring, sizeof(finstring), ""race_sign" %s", string);

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (gTeam[i] == RACE))
		{
			SCM(i, -1, finstring);
		}
	}
}

GangMSG(gGangID, const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerAvail(i))
	    {
			if(PlayerInfo[i][GangID] == gGangID && PlayerInfo[i][GangPosition] != GANG_POS_NONE)
			{
				SCM(i, RED, string);
			}
		}
	}
}

AdminMSG(color, const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (PlayerInfo[i][Level] >= 1))
		{
			SCM(i, color, string);
		}
	}
}

VIPMSG(color, const msg[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if((IsPlayerAvail(i)) && (PlayerInfo[i][VIP] == 1 || PlayerInfo[i][Level] > 0))
		{
			SCM(i, color, msg);
		}
	}
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
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_LOAD_PLAYER, playerid, g_SQL_handle);
}

MySQL_LoadPlayerGang(playerid)
{
	new query[200];
	format(query, sizeof(query), "SELECT `GangName`, `GangTag` FROM `"#TABLE_GANG"` WHERE `ID` = %i;", PlayerInfo[playerid][GangID]);
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_LOAD_PLAYER_GANG, playerid, g_SQL_handle);
}

MySQL_LoadPlayerVeh(playerid)
{
	new query[150];
	format(query, sizeof(query), "SELECT * FROM `"#TABLE_VEHICLE"` WHERE `Owner` = '%s';", __GetName(playerid));
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_LOAD_PLAYER_VEH, playerid, g_SQL_handle);
}

MySQL_AssignRankIfExist(playerid)
{
	new query[180];
  	format(query, sizeof(query), "SELECT `GangPosition` FROM `"#TABLE_ACCOUNT"` WHERE `GangID` = %i AND `Name` = '%s';", PlayerInfo[playerid][GangID], PlayerInfo[playerid][GangAssignRank]);
  	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_ASSIGN_RANK, playerid, g_SQL_handle);
}

MySQL_KickFromGangIfExist(playerid)
{
	new query[180];
  	format(query, sizeof(query), "SELECT `GangPosition` FROM `"#TABLE_ACCOUNT"` WHERE `GangID` = %i AND `Name` = '%s';", PlayerInfo[playerid][GangID], PlayerInfo[playerid][GangKickMem]);
  	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_KICK_FROM_GANG, playerid, g_SQL_handle);
}

MySQL_SavePlayer(playerid)
{
	new query[1500],
	 	query2[500];

    PlayerInfo[playerid][TotalTime] = PlayerInfo[playerid][TotalTime] + (gettime() - PlayerInfo[playerid][ConnectTime]);
    PlayerInfo[playerid][ConnectTime] = gettime();

	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `Level` = %i, `Score` = %i, `Money` = %i, `Bank` = %i, `Kills` = %i, `Deaths` = %i, `Time` = %i, \
	`Reaction` = %i, `PayDay` = %i, `Houses` = %i, `Props` = %i, `PropEarnings` = %i, `GangPosition` = %i, `GangID` = %i, `Vehicle` = %i, `DerbyWins` = %i",
		PlayerInfo[playerid][Level],
		_GetPlayerScore(playerid),
		GetPlayerCash(playerid),
		PlayerInfo[playerid][Bank],
		PlayerInfo[playerid][Kills],
		PlayerInfo[playerid][Deaths],
		PlayerInfo[playerid][TotalTime],
		PlayerInfo[playerid][Reaction],
		PlayerInfo[playerid][PayDay],
		PlayerInfo[playerid][Houses],
		PlayerInfo[playerid][Props],
		PlayerInfo[playerid][PropEarnings],
		PlayerInfo[playerid][GangPosition],
		PlayerInfo[playerid][GangID],
		PlayerInfo[playerid][BuyAbleVeh],
		PlayerInfo[playerid][DerbyWins]);

    format(query2, sizeof(query2), ", `Skin` = %i, `GungameWins` = %i, `RaceWins` = %i, `BGWins` = %i, `FalloutWins` = %i, `Wanteds` = %i, `VIP` = %i, `LastNameChange` = %i WHERE `Name` = '%s' LIMIT 1;",
		GetPlayerSkin(playerid),
		PlayerInfo[playerid][GungameWins],
		PlayerInfo[playerid][RaceWins],
		PlayerInfo[playerid][BGWins],
		PlayerInfo[playerid][FalloutWins],
		PlayerInfo[playerid][Wanteds],
		PlayerInfo[playerid][VIP],
		PlayerInfo[playerid][LastNameChange],
		__GetName(playerid));

	strcat(query, query2);

	mysql_function_query(g_SQL_handle, query, false, "", "");
	
	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `Ach1` = %i, `Ach2` = %i, `Ach3` = %i, `Ach4` = %i, `Ach5` = %i, `Ach6` = %i, `Ach7` = %i, `Ach8` = %i, `Ach9` = %i, `Ach10` = %i, `Ach11` = %i, `Ach12` = %i, `Ach13` = %i WHERE `Name` = '%s' LIMIT 1;",
	    pAch[playerid][E_ach_styler],
	    pAch[playerid][E_ach_grimreaper],
	    pAch[playerid][E_ach_masskiller],
	    pAch[playerid][E_ach_eliteracer],
	    pAch[playerid][E_ach_toofast],
	    pAch[playerid][E_ach_scorewhore],
	    pAch[playerid][E_ach_destroyer],
	    pAch[playerid][E_ach_restinpeace],
	    pAch[playerid][E_ach_silentkiller],
		pAch[playerid][E_ach_oneshot2kills],
		pAch[playerid][E_ach_deepimpact],
		pAch[playerid][E_ach_skydiver],
		pAch[playerid][E_ach_biker],
		__GetName(playerid));
	    
	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_UpdatePlayerPass(playerid, hash[])
{
	new query[128], escape[33];
	mysql_real_escape_string(hash, escape, g_SQL_handle, 33);
	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `Hash` = MD5('%s') WHERE `Name` = '%s' LIMIT 1;", escape, __GetName(playerid));
 	mysql_function_query(g_SQL_handle, query, false, "", "");
}

MySQL_SavePlayerVeh(playerid)
{
	new query[800];
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
    mysql_function_query(g_SQL_handle, query, false, "OnQueryFinish", "siii", query, THREAD_DELETE_VEH, playerid, g_SQL_handle);
}

MySQL_FetchGangMemberNames(playerid, gGangID)
{
	new query[128];
	format(query, sizeof(query), "SELECT `Name`, `GangPosition` FROM `accounts` WHERE `GangID` = %i ORDER BY `GangPosition` DESC LIMIT 20;", gGangID);
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
	new query[128];
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
	format(query, sizeof(query), "SELECT * FROM `"#TABLE_BLACKLIST"` WHERE `IP` = '%s';", __GetIP(playerid));
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_CHECK_IP, playerid, g_SQL_handle);
}

MySQL_CreateGang(playerid)
{
    new query[200];
    format(query, sizeof(query), "INSERT INTO `"#TABLE_GANG"` VALUES (NULL, '%s', '%s', 0, %i);", PlayerInfo[playerid][GangName], PlayerInfo[playerid][GangTag], gettime());
    mysql_function_query(g_SQL_handle, query, false, "OnQueryFinish", "siii", query, THREAD_CREATE_GANG, playerid, g_SQL_handle);
}

MySQL_CheckPlayerPassword(playerid, password[])
{
    new query[255], escape[33];
	mysql_real_escape_string(password, escape, g_SQL_handle, 33);
    format(query, sizeof(query), "SELECT `Hash` FROM `"#TABLE_ACCOUNT"` WHERE `Name` = '%s' AND (`Hash` = MD5('%s') OR `Hash` = SHA1('%s'));", __GetName(playerid), escape, escape); // SHA1 because of Stunt Evolution server merge
    mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_CHECK_PLAYER_PASSWD, playerid, g_SQL_handle);
}

MySQL_CreateAccount(playerid, password[])
{
    new query[350], escape[33];
	mysql_real_escape_string(password, escape, g_SQL_handle, 33);
    format(query, sizeof(query), "INSERT INTO `"#TABLE_ACCOUNT"` (`Name`, `Logged`, `Hash`, `IP`, `GangPosition`, `GangID`, `RegDate`) VALUES ('%s', 1, MD5('%s'), '%s', 0, 0, %i);", __GetName(playerid), escape, __GetIP(playerid), gettime());
	mysql_function_query(g_SQL_handle, query, false, "OnQueryFinish", "siii", query, THREAD_CREATE_ACCOUNT, playerid, g_SQL_handle);
	PlayerInfo[playerid][LastLogged] = gettime();
	PlayerInfo[playerid][LastNameChange] = 0;
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
    format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `Logged` = 0, `LastLogged` = %i WHERE `Name` = '%s' LIMIT 1", gettime(), __GetName(playerid));
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
	mysql_function_query(g_SQL_handle, query, false, "OnQueryFinish", "siii", query, THREAD_BUY_VEHICLE, playerid, g_SQL_handle);
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
	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `GangID` = 0, `GangPosition` = 0 WHERE `Name` = '%s' LIMIT 1;", PlayerInfo[playerid][GangKickMem]);
	mysql_function_query(g_SQL_handle, query, false, "OnQueryFinish", "siii", query, THREAD_KICK_FROM_GANG_2, playerid, g_SQL_handle);
}

MySQL_FinalRankAssign(playerid)
{
	new query[255];
	format(query, sizeof(query), "UPDATE `"#TABLE_ACCOUNT"` SET `GangPosition` = %i WHERE `Name` = '%s' LIMIT 1;", PlayerInfo[playerid][RankSelected], PlayerInfo[playerid][GangAssignRank]);
	mysql_function_query(g_SQL_handle, query, false, "OnQueryFinish", "siii", query, THREAD_ASSIGN_RANK_2, playerid, g_SQL_handle);
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
            print("=====================Stunt Evolution=====================");
            SendRconCommand("exit");
        }
    }
}

LoadStores()
{
	new file[50],
		count = GetTickCount() + 3600000,
		lstring[128];

	for(new b = 0; b < MAX_BANKS; b++)
	{
	    format(file, sizeof(file), "/Store/Banks/%i.ini", b);
		if(fexist(file))
		{
			BankPickOut[b] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		BankPickInt[b] = CreateDynamicPickup(1559, 1, 2304.69, -16.19, 26.74, (b + 1000), -1, -1, 50.0);
	  		BankPickMenu[b] = CreateDynamicPickup(1559, 1, 2311.63, -3.89, 26.74, (b + 1000), -1, -1, 50.0);
	  		BankMIcon[b] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 25, -1, 0, 0, -1, 200.0);
	  		format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		CreateDynamic3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
		}
	}
    for(new a = 0; a < MAX_AMMUNATIONS; a++)
	{
	    format(file, sizeof(file), "/Store/Ammunations/%i.ini", a);
		if(fexist(file))
		{
			AmmunationPickOut[a] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		AmmunationPickInt[a] = CreateDynamicPickup(1559, 1, 315.81, -143.65, 999.60, (a + 1000), 7, -1, 50.0);
			AmmunationMIcon[a] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 6, -1, 0, 0, -1, 200.0);
			format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
			CreateDynamic3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
		}
	}
	for(new bs = 0; bs < MAX_BURGERSHOTS; bs++)
	{
	    format(file, sizeof(file), "/Store/BurgerShots/%i.ini", bs);
		if(fexist(file))
		{
			BurgerPickOut[bs] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		BurgerPickInt[bs] = CreateDynamicPickup(1559, 1, 362.87, -75.17, 1001.50, (bs + 1000), 10, -1, 50.0);
		   	BurgerMIcon[bs] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 10, -1, 0, 0, -1, 200.0);
		   	format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		CreateDynamic3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
		}
	}
	for(new cb = 0; cb < MAX_CLUCKINBELLS; cb++)
	{
	    format(file, sizeof(file), "/Store/CluckinBells/%i.ini", cb);
		if(fexist(file))
		{
			CluckinBellPickOut[cb] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		CluckinBellPickInt[cb] = CreateDynamicPickup(1559, 1, 364.87, -11.74, 1001.85, (cb + 1000), 9, -1, 50.0);
			CluckinBellMIcon[cb] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 14, -1, 0, 0, -1, 200.0);
			format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		CreateDynamic3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
		}
	}
	for(new ps = 0; ps < MAX_PIZZASTACKS; ps++)
	{
	    format(file, sizeof(file), "/Store/WellStackedPizzas/%i.ini", ps);
		if(fexist(file))
		{
			PizzaPickOut[ps] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		PizzaPickInt[ps] = CreateDynamicPickup(1559, 1, 372.36, -133.50, 1001.49, (ps + 1000), 5, -1, 50.0);
			PizzaMIcon[ps] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 29, -1, 0, 0, -1, 200.0);
			format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		CreateDynamic3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
		}
	}
	for(new tfs = 0; tfs < MAX_TFS; tfs++)
	{
	    format(file, sizeof(file), "/Store/TwentyFourSeven/%i.ini", tfs);
		if(fexist(file))
		{
			TFSPickOut[tfs] = CreateDynamicPickup(1559, 1, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 0, 0, -1, 50.0);
	  		TFSPickInt[tfs] = CreateDynamicPickup(1559, 1, -25.884, -185.868, 1003.546, (tfs + 1000), 17, -1, 50.0);
			TFSMIcon[tfs] = CreateDynamicMapIcon(dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ"), 17, -1, 0, 0, -1, 200.0);
			format(lstring, sizeof(lstring), ""white"["yellow"Store"white"]\n%s", dini_Get(file, "StoreName"));
	  		CreateDynamic3DTextLabel(lstring, YELLOW, dini_Float(file, "PickOutX"), dini_Float(file, "PickOutY"), dini_Float(file, "PickOutZ") + 0.7, 25.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 25.0);
		}
	}
 	printf("#Stores loaded in %i ms", (GetTickCount() + 3600000) - count);
 	return 1;
}

RemoveFirstQueueFloor()
{
	for(new i; i < sizeof(ElevatorQueue) - 1; i++)
	{
	    ElevatorQueue[i] = ElevatorQueue[i + 1];
	}
	ElevatorQueue[sizeof(ElevatorQueue) - 1] = INVALID_FLOOR;
	return 1;
}

AddFloorToQueue(floorid)
{
	new slot = -1;
	for(new i; i < sizeof(ElevatorQueue); i++)
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
	    {
	        ReadNextFloorInQueue();
		}
	    return 1;
	}
	return 0;
}

ResetElevatorQueue()
{
	for(new i; i < sizeof(ElevatorQueue); i++)
	{
	    ElevatorQueue[i] = INVALID_FLOOR;
	    FloorRequestedBy[i] = INVALID_PLAYER_ID;
	}
	return 1;
}

IsFloorInQueue(floorid)
{
	for(new i; i < sizeof(ElevatorQueue); i++)
	{
	    if(ElevatorQueue[i] == floorid)
	    {
	        return 1;
		}
	}
	return 0;
}

ReadNextFloorInQueue()
{
	if(ElevatorState != ELEVATOR_STATE_IDLE || ElevatorQueue[0] == INVALID_FLOOR)
	{
	    return 0;
	}
	Elevator_CloseDoors();
	Floor_CloseDoors(ElevatorFloor);
	return 1;
}

DidPlayerRequestElevator(playerid)
{
	for(new i; i < sizeof(FloorRequestedBy); i++)
	{
	    if(FloorRequestedBy[i] == playerid)
	    {
	        return 1;
		}
	}
	return 0;
}

ShowElevatorDialog(playerid)
{
	new string[512];
	for(new i; i < sizeof(ElevatorQueue); i++)
	{
	    if(FloorRequestedBy[i] != INVALID_PLAYER_ID)
	    {
	        strcat(string, "{FF0000}");
		}
	    strcat(string, FloorNames[i]);
	    strcat(string, "\n");
	}

	ShowPlayerDialog(playerid, LIFT_DIALOG, DIALOG_STYLE_LIST, ""se" - Admin Elevator", string, "Accept", "Cancel");
	return 1;
}

CallElevator(playerid, floorid)
{
	if(FloorRequestedBy[floorid] != INVALID_PLAYER_ID || IsFloorInQueue(floorid))
	{
	    return 0;
	}
	
	FloorRequestedBy[floorid] = playerid;
	AddFloorToQueue(floorid);
	return 1;
}

Elevator_Initialize()
{
	Obj_Elevator = CreateObject(18755, 1786.678100, -1303.459472, GROUND_Z_COORD + ELEVATOR_OFFSET, 0.000000, 0.000000, 270.000000);
	Obj_ElevatorDoors[0] = CreateObject(18757, X_DOOR_CLOSED, -1303.459472, GROUND_Z_COORD, 0.000000, 0.000000, 270.000000);
	Obj_ElevatorDoors[1] = CreateObject(18756, X_DOOR_CLOSED, -1303.459472, GROUND_Z_COORD, 0.000000, 0.000000, 270.000000);

	Label_Elevator = Create3DTextLabel("Press 'F' to use elevator", NGS_BLUE, 1784.9822, -1302.0426, 13.6491, 4.0, 0, 1);

	new string[128],
		Float:z;

	for(new i; i < sizeof(Obj_FloorDoors); i++)
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

	for(new i; i < sizeof(Obj_FloorDoors); i++)
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
	new rand = random(3);
	SetPlayerPosEx(playerid, WorldSpawns[rand][0], WorldSpawns[rand][1], floatadd(WorldSpawns[rand][2], 5.0));
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

CreateTextdraws()
{
    new count = GetTickCount() + 3600000;
	TXTLoading = TextDrawCreate(319.000000, 208.000000, "Loading...");
	TXTInfo = TextDrawCreate(245.000000, 419.000000, "~w~~h~Player ~b~~h~~h~Mellnik(6) ~w~~h~teleported to ~p~~h~Los Santos [/~w~~h~LS~p~~h~]");
	TXTBlackScreenP1 = TextDrawCreate(731.000000, -59.000000, "                   ");
	TXTBlackScreenP2 = TextDrawCreate(731.000000, 342.000000, "                   ");
	TXTLogonStars = TextDrawCreate(245.000000, 75.000000, "[][][][][][][][][][]");
	TXTLocalSignP1 = TextDrawCreate(291.000000, 12.000000, SE_SIGN1);
	TXTLocalSignP2 = TextDrawCreate(262.000000, 55.000000, SE_SIGN2);
	TXTGreenStripP1 = TextDrawCreate(663.000000, 103.000000, "n");
    TXTGreenStripP2 = TextDrawCreate(663.000000, 340.000000, "n");
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
 	NGSLOGO[0] = TextDrawCreate(31.000000, 318.000000, "~w~~<~~r~~h~S~w~~h~tunt ~g~~h~E~w~~h~volutio~b~~h~N~w~~>~");
 	NGSLOGO[1] = TextDrawCreate(31.000000, 324.000000, "-");
 	NGSLOGO[2] = TextDrawCreate(36.000000, 330.000000, "        "CURRENT_VERSION"");

	FooterBlack = TextDrawCreate(710.000000, 430.000000, "New Textdraw");
	TextDrawBackgroundColor(FooterBlack, 255);
	TextDrawFont(FooterBlack, 1);
	TextDrawLetterSize(FooterBlack, 0.500000, 1.000000);
	TextDrawColor(FooterBlack, -1);
	TextDrawSetOutline(FooterBlack, 0);
	TextDrawSetProportional(FooterBlack, 1);
	TextDrawSetShadow(FooterBlack, 1);
	TextDrawUseBox(FooterBlack, 1);
	TextDrawBoxColor(FooterBlack, 168430159);
	TextDrawTextSize(FooterBlack, -490.000000, -40.000000);

	TXTConnect[0] = TextDrawCreate(552.666809, 126.442207, "usebox");
	TextDrawLetterSize(TXTConnect[0], 0.000000, 18.272958);
	TextDrawTextSize(TXTConnect[0], 116.222175, 0.000000);
	TextDrawAlignment(TXTConnect[0], 1);
	TextDrawColor(TXTConnect[0], 65535);
	TextDrawUseBox(TXTConnect[0], true);
	TextDrawBoxColor(TXTConnect[0], 0x00000088);
	TextDrawSetShadow(TXTConnect[0], 0);
	TextDrawSetOutline(TXTConnect[0], 0);
	TextDrawFont(TXTConnect[0], 0);

	TXTConnect[1] = TextDrawCreate(269.000000, 100.000000, "SAMP");
	TextDrawBackgroundColor(TXTConnect[1], 0x00000000);
	TextDrawFont(TXTConnect[1], 5);
	TextDrawLetterSize(TXTConnect[1], 0.500000, 1.000000);
	TextDrawColor(TXTConnect[1], -1);
	TextDrawSetOutline(TXTConnect[1], 0);
	TextDrawSetProportional(TXTConnect[1], 1);
	TextDrawSetShadow(TXTConnect[1], 1);
	TextDrawTextSize(TXTConnect[1], 107.000000, 93.000000);
	TextDrawSetPreviewModel(TXTConnect[1], 18749);
	TextDrawSetPreviewRot(TXTConnect[1], 0.000000, 0.000000, 180.000000, 0.800000);

	TXTConnect[2] = TextDrawCreate(176.000000, 219.000000, "Box");
	TextDrawBackgroundColor(TXTConnect[2], 0x00000000);
	TextDrawFont(TXTConnect[2], 5);
	TextDrawLetterSize(TXTConnect[2], 0.500000, 1.000000);
	TextDrawColor(TXTConnect[2], -1);
	TextDrawSetOutline(TXTConnect[2], 0);
	TextDrawSetProportional(TXTConnect[2], 1);
	TextDrawSetShadow(TXTConnect[2], 1);
	TextDrawTextSize(TXTConnect[2], 76.000000, 71.000000);
	TextDrawSetPreviewModel(TXTConnect[2], 415);
	TextDrawSetPreviewRot(TXTConnect[2], 0.000000, 0.000000, 70.000000, 0.899999);

	TXTConnect[3] = TextDrawCreate(231.555633, 169.742218, "Stunt Evolution");
	TextDrawLetterSize(TXTConnect[3], 0.457998, 1.843909);
	TextDrawAlignment(TXTConnect[3], 1);
	TextDrawColor(TXTConnect[3], -1);
	TextDrawSetShadow(TXTConnect[3], 0);
	TextDrawSetOutline(TXTConnect[3], 1);
	TextDrawBackgroundColor(TXTConnect[3], 0x000000FF);
	TextDrawFont(TXTConnect[3], 2);
	TextDrawSetProportional(TXTConnect[3], 1);

	TXTConnect[4] = TextDrawCreate(265.333374, 215.040023, ""CURRENT_VERSION"");
	TextDrawLetterSize(TXTConnect[4], 0.546443, 2.057955);
	TextDrawAlignment(TXTConnect[4], 1);
	TextDrawColor(TXTConnect[4], WHITE);
	TextDrawSetShadow(TXTConnect[4], 0);
	TextDrawSetOutline(TXTConnect[4], 1);
	TextDrawBackgroundColor(TXTConnect[4], 0x000000FF);
	TextDrawFont(TXTConnect[4], 2);
	TextDrawSetProportional(TXTConnect[4], 1);

	TXTConnect[5] = TextDrawCreate(277.333190, 252.373443, "Welcome!");
	TextDrawLetterSize(TXTConnect[5], 0.602443, 1.814043);
	TextDrawAlignment(TXTConnect[5], 1);
	TextDrawColor(TXTConnect[5], WHITE);
	TextDrawSetShadow(TXTConnect[5], 0);
	TextDrawSetOutline(TXTConnect[5], 0);
	TextDrawBackgroundColor(TXTConnect[5], 0x000000FF);
	TextDrawFont(TXTConnect[5], 1);
	TextDrawSetProportional(TXTConnect[5], 1);

	TXTConnect[6] = TextDrawCreate(236.444427, 185.173339, "~b~Stunt~w~/~g~~h~Drift~w~/~y~Race~w~/~r~Derby~w~/~p~~h~Fun");
	TextDrawLetterSize(TXTConnect[6], 0.449999, 1.600000);
	TextDrawAlignment(TXTConnect[6], 1);
	TextDrawColor(TXTConnect[6], -1);
	TextDrawSetShadow(TXTConnect[6], 0);
	TextDrawSetOutline(TXTConnect[6], 1);
	TextDrawBackgroundColor(TXTConnect[6], 51);
	TextDrawFont(TXTConnect[6], 1);
	TextDrawSetProportional(TXTConnect[6], 1);

	TXTConnect[7] = TextDrawCreate(369.777954, 150.826553, "0.3x");
	TextDrawLetterSize(TXTConnect[7], 0.236666, 1.649776);
	TextDrawAlignment(TXTConnect[7], 1);
	TextDrawColor(TXTConnect[7], -1);
	TextDrawSetShadow(TXTConnect[7], 0);
	TextDrawSetOutline(TXTConnect[7], 1);
	TextDrawBackgroundColor(TXTConnect[7], 51);
	TextDrawFont(TXTConnect[7], 2);
	TextDrawSetProportional(TXTConnect[7], 1);

	TXTConnect[8] = TextDrawCreate(434.666534, 344.959991, "loadsc0:loadsc0");
	TextDrawLetterSize(TXTConnect[8], 0.000000, 0.000000);
	TextDrawTextSize(TXTConnect[8], 213.333236, 141.866821);
	TextDrawFont(TXTConnect[8], 4);

	TXTConnect[9] = TextDrawCreate(388.000000, 198.000000, "Box");
	TextDrawBackgroundColor(TXTConnect[9], 0x00000000);
	TextDrawFont(TXTConnect[9], 5);
	TextDrawLetterSize(TXTConnect[9], 0.500000, 1.000000);
	TextDrawColor(TXTConnect[9], -1);
	TextDrawSetOutline(TXTConnect[9], 0);
	TextDrawSetProportional(TXTConnect[9], 1);
	TextDrawSetShadow(TXTConnect[9], 1);
	TextDrawTextSize(TXTConnect[9], 87.000000, 82.000000);
	TextDrawSetPreviewModel(TXTConnect[9], 18779);
	TextDrawSetPreviewRot(TXTConnect[9], 0.000000, 0.000000, 50.000000, 1.000000);

	AchTD[0] = TextDrawCreate(495.000000, 190.000000, "Box0");
	TextDrawBackgroundColor(AchTD[0], 255);
	TextDrawFont(AchTD[0], 1);
	TextDrawLetterSize(AchTD[0], 0.000000, 9.100000);
	TextDrawColor(AchTD[0], -1);
	TextDrawSetOutline(AchTD[0], 0);
	TextDrawSetProportional(AchTD[0], 1);
	TextDrawSetShadow(AchTD[0], 1);
	TextDrawUseBox(AchTD[0], 1);
	TextDrawBoxColor(AchTD[0], 90);
	TextDrawTextSize(AchTD[0], 141.000000, 0.000000);

	AchTD[1] = TextDrawCreate(495.000000, 190.000000, "Box1");
	TextDrawBackgroundColor(AchTD[1], 255);
	TextDrawFont(AchTD[1], 1);
	TextDrawLetterSize(AchTD[1], 0.000000, 4.299999);
	TextDrawColor(AchTD[1], -1);
	TextDrawSetOutline(AchTD[1], 0);
	TextDrawSetProportional(AchTD[1], 1);
	TextDrawSetShadow(AchTD[1], 1);
	TextDrawUseBox(AchTD[1], 1);
	TextDrawBoxColor(AchTD[1], -241);
	TextDrawTextSize(AchTD[1], 141.000000, 0.000000);

	AchTD[2] = TextDrawCreate(187.000000, 191.000000, "ACHIEVEMENT UNLOCKED");
	TextDrawBackgroundColor(AchTD[2], 255);
	TextDrawFont(AchTD[2], 1);
	TextDrawLetterSize(AchTD[2], 0.649999, 2.000000);
	TextDrawColor(AchTD[2], 16711935);
	TextDrawSetOutline(AchTD[2], 0);
	TextDrawSetProportional(AchTD[2], 1);
	TextDrawSetShadow(AchTD[2], 0);

	AchTD[3] = TextDrawCreate(495.000000, 194.000000, "Box2");
	TextDrawBackgroundColor(AchTD[3], 255);
	TextDrawFont(AchTD[3], 1);
	TextDrawLetterSize(AchTD[3], 0.000000, 9.100000);
	TextDrawColor(AchTD[3], -1);
	TextDrawSetOutline(AchTD[3], 0);
	TextDrawSetProportional(AchTD[3], 1);
	TextDrawSetShadow(AchTD[3], 1);
	TextDrawUseBox(AchTD[3], 1);
	TextDrawBoxColor(AchTD[3], 90);
	TextDrawTextSize(AchTD[3], 141.000000, 0.000000);

	AchTD[4] = TextDrawCreate(450.000000, 192.000000, "Box3");
	TextDrawBackgroundColor(AchTD[4], 255);
	TextDrawFont(AchTD[4], 1);
	TextDrawLetterSize(AchTD[4], 0.000000, 1.700000);
	TextDrawColor(AchTD[4], -1);
	TextDrawSetOutline(AchTD[4], 0);
	TextDrawSetProportional(AchTD[4], 1);
	TextDrawSetShadow(AchTD[4], 1);
	TextDrawUseBox(AchTD[4], 1);
	TextDrawBoxColor(AchTD[4], 16711690);
	TextDrawTextSize(AchTD[4], 182.000000, 0.000000);

	AchTD[5] = TextDrawCreate(317.000000, 193.000000, "]                                            ]");
	TextDrawAlignment(AchTD[5], 2);
	TextDrawBackgroundColor(AchTD[5], 255);
	TextDrawFont(AchTD[5], 2);
	TextDrawLetterSize(AchTD[5], 0.500000, 1.600000);
	TextDrawColor(AchTD[5], 16711935);
	TextDrawSetOutline(AchTD[5], 0);
	TextDrawSetProportional(AchTD[5], 1);
	TextDrawSetShadow(AchTD[5], 0);

	ErrorTD = TextDrawCreate(385.777801, 335.004394, "LD_CHAT:badchat");
	TextDrawLetterSize(ErrorTD, 0.449999, 1.600000);
	TextDrawTextSize(ErrorTD, 42.222240, 31.360012);
	TextDrawAlignment(ErrorTD, 2);
	TextDrawColor(ErrorTD, -1);
	TextDrawSetShadow(ErrorTD, 0);
	TextDrawSetOutline(ErrorTD, 1);
	TextDrawBackgroundColor(ErrorTD, 51);
	TextDrawFont(ErrorTD, 4);
	TextDrawSetProportional(ErrorTD, 1);

	NewMsgTD = TextDrawCreate(370.222778, 329.031158, "LD_CHAT:goodcha");
	TextDrawLetterSize(NewMsgTD, 0.000000, 0.000000);
	TextDrawTextSize(NewMsgTD, 32.444427, 28.871093);
	TextDrawAlignment(NewMsgTD, 2);
	TextDrawColor(NewMsgTD, -1);
	TextDrawSetShadow(NewMsgTD, 0);
	TextDrawSetOutline(NewMsgTD, 0);
	TextDrawFont(NewMsgTD, 4);

	CheckTD = TextDrawCreate(370.222778, 329.031158, "LD_CHAT:thumbup");
	TextDrawLetterSize(CheckTD, 0.000000, 0.000000);
	TextDrawTextSize(CheckTD, 45.777770, 31.359985);
	TextDrawAlignment(CheckTD, 1);
	TextDrawColor(CheckTD, -1);
	TextDrawSetShadow(CheckTD, 0);
	TextDrawSetOutline(CheckTD, 0);
	TextDrawFont(CheckTD, 4);

	godTD = TextDrawCreate(501.333, 99.555, "~y~GODMODE ENABLED");
	TextDrawLetterSize(godTD, 0.324, 1.569);
	TextDrawTextSize(godTD, 611.555, 4.978);
	TextDrawAlignment(godTD, 1);
	TextDrawColor(godTD, -65281);
	TextDrawUseBox(godTD, 1);
	TextDrawBoxColor(godTD, 102);
	TextDrawSetOutline(godTD, 1);
	TextDrawBackgroundColor(godTD, 51);
	TextDrawFont(godTD, 1);
	TextDrawSetProportional(godTD, 1);

	TXTWelcome[0] = TextDrawCreate(634.444, 115.490, "TBox");
	TextDrawLetterSize(TXTWelcome[0], 0.000, 23.690);
	TextDrawTextSize(TXTWelcome[0], 409.110, 0.000);
	TextDrawAlignment(TXTWelcome[0], 1);
	TextDrawColor(TXTWelcome[0], 553648128);
	TextDrawUseBox(TXTWelcome[0], 1);
	TextDrawBoxColor(TXTWelcome[0], 65673);
	TextDrawBackgroundColor(TXTWelcome[0], 16777318);
	TextDrawFont(TXTWelcome[0], 0);

	TXTWelcome[1] = TextDrawCreate(419.999, 122.950, "~y~Welcome to Stunt Evolution");
	TextDrawLetterSize(TXTWelcome[1], 0.512, 1.927);
	TextDrawAlignment(TXTWelcome[1], 1);
	TextDrawColor(TXTWelcome[1], -1);
	TextDrawSetOutline(TXTWelcome[1], 1);
	TextDrawBackgroundColor(TXTWelcome[1], 51);
	TextDrawFont(TXTWelcome[1], 0);
	TextDrawSetProportional(TXTWelcome[1], 1);

	TXTWelcome[2] = TextDrawCreate(422.221, 158.791, "~w~Type ~b~~h~/help ~w~to get started.~n~~n~         ~b~~h~/cmds ~w~for commands.~n~~n~         ~b~~h~/teles ~w~for teleports.");
	TextDrawLetterSize(TXTWelcome[2], 0.285, 1.321);
	TextDrawAlignment(TXTWelcome[2], 1);
	TextDrawColor(TXTWelcome[2], -1);
	TextDrawSetOutline(TXTWelcome[2], 1);
	TextDrawBackgroundColor(TXTWelcome[2], 51);
	TextDrawFont(TXTWelcome[2], 2);
	TextDrawSetProportional(TXTWelcome[2], 1);

	TXTWelcome[3] = TextDrawCreate(420.444, 232.959, "~r~/cmds /teles /help /rules");
	TextDrawLetterSize(TXTWelcome[3], 0.452, 1.570);
	TextDrawAlignment(TXTWelcome[3], 1);
	TextDrawColor(TXTWelcome[3], -1);
	TextDrawSetOutline(TXTWelcome[3], 2);
	TextDrawBackgroundColor(TXTWelcome[3], 64804);
	TextDrawFont(TXTWelcome[3], 1);
	TextDrawSetProportional(TXTWelcome[3], 1);

	TXTWelcome[4] = TextDrawCreate(425.777, 279.751, "www.stunt-evolution.net");
	TextDrawLetterSize(TXTWelcome[4], 0.386, 1.878);
	TextDrawAlignment(TXTWelcome[4], 1);
	TextDrawColor(TXTWelcome[4], -1);
	TextDrawSetOutline(TXTWelcome[4], 2);
	TextDrawBackgroundColor(TXTWelcome[4], -16776961);
	TextDrawFont(TXTWelcome[4], 3);
	TextDrawSetProportional(TXTWelcome[4], 1);

	TXTWelcome[5] = TextDrawCreate(448.000, 264.817, "Visit our website at:");
	TextDrawLetterSize(TXTWelcome[5], 0.417, 1.271);
	TextDrawAlignment(TXTWelcome[5], 1);
	TextDrawColor(TXTWelcome[5], -1);
	TextDrawSetOutline(TXTWelcome[5], 1);
	TextDrawBackgroundColor(TXTWelcome[5], 51);
	TextDrawFont(TXTWelcome[5], 1);
	TextDrawSetProportional(TXTWelcome[5], 1);

	TextDrawBackgroundColor(NGSLOGO[0], 51);
	TextDrawFont(NGSLOGO[0], 3);
	TextDrawLetterSize(NGSLOGO[0], 0.340000, 1.000000);
	TextDrawColor(NGSLOGO[0], -1);
	TextDrawSetOutline(NGSLOGO[0], 1);
	TextDrawSetProportional(NGSLOGO[0], 1);

	TextDrawBackgroundColor(NGSLOGO[1], 51);
	TextDrawFont(NGSLOGO[1], 1);
	TextDrawLetterSize(NGSLOGO[1], 8.039995, 1.000000);
	TextDrawColor(NGSLOGO[1], NGS_BLUE);
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
	TextDrawColor(TXTLogonStars, NGS_BLUE);
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

	TextDrawBackgroundColor(TXTGreenStripP1, 255);
	TextDrawFont(TXTGreenStripP1, 1);
	TextDrawLetterSize(TXTGreenStripP1, 0.500000, 0.099999);
	TextDrawColor(TXTGreenStripP1, -65281);
	TextDrawSetOutline(TXTGreenStripP1, 0);
	TextDrawSetProportional(TXTGreenStripP1, 1);
	TextDrawSetShadow(TXTGreenStripP1, 1);
	TextDrawUseBox(TXTGreenStripP1, 1);
	TextDrawBoxColor(TXTGreenStripP1, NGS_BLUE);
	TextDrawTextSize(TXTGreenStripP1, -160.000000, -70.000000);

	TextDrawBackgroundColor(TXTGreenStripP2, 255);
	TextDrawFont(TXTGreenStripP2, 1);
	TextDrawLetterSize(TXTGreenStripP2, 0.500000, 0.099999);
	TextDrawColor(TXTGreenStripP2, 6946815);
	TextDrawSetOutline(TXTGreenStripP2, 0);
	TextDrawSetProportional(TXTGreenStripP2, 1);
	TextDrawSetShadow(TXTGreenStripP2, 1);
	TextDrawUseBox(TXTGreenStripP2, 1);
	TextDrawBoxColor(TXTGreenStripP2, NGS_BLUE);
	TextDrawTextSize(TXTGreenStripP2, -160.000000, -70.000000);

	printf("#TextDraws loaded in %i ms", (GetTickCount() + 3600000) - count);
	return 1;
}

DestroyTextdraws()
{
	TextDrawHideForAll(TXTLoading);
	TextDrawHideForAll(TXTBlackScreenP1);
	TextDrawHideForAll(TXTBlackScreenP2);
	TextDrawHideForAll(TXTLogonStars);
	TextDrawHideForAll(TXTLocalSignP1);
	TextDrawHideForAll(TXTLocalSignP2);
	TextDrawHideForAll(TXTGreenStripP1);
	TextDrawHideForAll(TXTGreenStripP2);

	TextDrawDestroy(TXTLoading);
	TextDrawDestroy(TXTBlackScreenP1);
	TextDrawDestroy(TXTBlackScreenP2);
	TextDrawDestroy(TXTLogonStars);
	TextDrawDestroy(TXTLocalSignP1);
	TextDrawDestroy(TXTLocalSignP2);
	TextDrawDestroy(TXTGreenStripP1);
	TextDrawDestroy(TXTGreenStripP2);
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
    
	new xLength = (random(10) + 3),
		string[144],
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
	format(string, sizeof(string), "["vlila"REACTION"white"]: The first who types '"vlila"%s"white"' wins $%s + %i score", xChars, ToCurrency(xCash), xScore);
	tickReactionStart = GetTickCount() + 3600000;
	SCMToAll(WHITE, string);
	KillTimer(tReactionTimer);
	xTestBusy = true;
	SetTimer("xReactionProgress", 60000, false);
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
	    new string0[100],
			string1[100],
			string2[100],
			string3[100],
			string4[100],
			string5[100],
			interest = floatround(floatmul(floatdiv(PlayerInfo[playerid][Bank], 2000.0), 8.0), floatround_round),
			vipinterest = floatround(interest / 2.5),
			b_vipearnings = 0;

		GameTextForPlayer(playerid, "~y~PayDay~n~~w~Paycheck", 6000, 1);

		format(string0, sizeof(string0), "Bank Balance before PayDay: "green"$%s", ToCurrency(PlayerInfo[playerid][Bank]));
		format(string1, sizeof(string1), "Bank Interest Gained: "green"$%s", ToCurrency(interest));
		
		if(PlayerInfo[playerid][VIP] == 1)
		{
        	format(string4, sizeof(string4), "Bank Interest Gained "lb_e"(VIP BOOST)"white": "green"$%s", ToCurrency(vipinterest));
        }
        else format(string4, sizeof(string4), "Bank Interest Gained "lb_e"(VIP BOOST)"white": "red"---");
        
		if(PlayerInfo[playerid][Props] >= 1)
		{
		    b_vipearnings = floatround(PlayerInfo[playerid][PropEarnings] / 2.5);
		    format(string3, sizeof(string3), "Business earnings: "green"$%s", ToCurrency(PlayerInfo[playerid][PropEarnings]));
		    format(string5, sizeof(string5), "Business earnings "lb_e"(VIP BOOST)"white": "green"$%s", ToCurrency(b_vipearnings));
		}
		else
		{
			format(string3, sizeof(string3), "Business earnings: "red"---");
			format(string5, sizeof(string5), "Business earnings "lb_e"(VIP BOOST)"white": "red"---", ToCurrency(b_vipearnings));
		}
		
		PlayerInfo[playerid][Bank] = PlayerInfo[playerid][Bank] + interest + PlayerInfo[playerid][PropEarnings] + vipinterest + b_vipearnings;

		format(string2, sizeof(string2), "Bank Balance after PayDay: "green"$%s", ToCurrency(PlayerInfo[playerid][Bank]));
        
		SCM(playerid, -1, ""green"|--------------------"yellow"PAY-DAY"green"-------------------|");
		SCM(playerid, WHITE, string0);
		SCM(playerid, WHITE, string1);
		SCM(playerid, WHITE, string4);
		SCM(playerid, WHITE, string3);
		SCM(playerid, WHITE, string5);
		SCM(playerid, WHITE, string2);
		SCM(playerid, -1, ""green"|--------------------------------------------------|");
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
    SCMToAll(-1, ""server_sign" Maintenance initiated...");

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerNPC(i) || PlayerInfo[i][Level] > 0) continue;
	    if(IsPlayerConnected(i))
	    {
			SCM(i, RED, "Your account has been saved and you have been disconnected");
			KickEx(i);
		}
	}
	return 1;
}

LoadServerStaticMeshes()
{
	new string[100], count = GetTickCount() + 3600000;
	format(string, sizeof(string), "hostname %s", HOSTNAME);

	SendRconCommand(string);
	SendRconCommand("weburl www.stunt-evolution.net");
	#if IS_RELEASE_BUILD == true
	SendRconCommand("mapname "CURRENT_VERSION" (SE)");
	SetGameModeText("TdmDerbyRaceDmFunStuntFreeroam");
	#else
	SendRconCommand("mapname SE BETA R6-1");
	SetGameModeText("SE BETA R6-1");
	#endif
	ShowPlayerMarkers(1);
	DisableInteriorEnterExits();
	ShowNameTags(1);
	SetNameTagDrawDistance(35.0);
	AllowInteriorWeapons(1);
	UsePlayerPedAnims();
	EnableStuntBonusForAll(0);
	SetWeather(1);
	SetWorldTime(12);
	RaceStatus = RaceStatus_Inactive;
    CurrentBGMap = BG_VOTING;
	StartTime = gettime();
	Iter_Init(PlayerIgnore);
	for(new i = 1; i < MAX_REPORTS; i++)
	{
		Reports[i] = "<none>";
	}
	
    CreateDynamicSphere(341.8535, -1852.6327, 6.8569, 25.0); // <- beach sphere
    CreateDynamicSphere(383.5090, 2536.9236, 18.8019, 17.0); // <- AA sphere
    CreateDynamicSphere(-1203.3666, -27.8846, 15.8403, 15.0); // <- SFA 1 sphere
    CreateDynamicSphere(-1183.3441, -9.4441, 15.8403, 15.0); // <- SFA 2 sphere

	toyslist = LoadModelSelectionMenu("Other/toys.txt");

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
    
	MellnikGate = CreateDynamicObject(975, 1012.05396, -2068.18970, 13.84253,   0.00000, 0.00000, 349.38431);
    
    pick_chainsaw = CreateDynamicPickup(341, 2, 1219.1809,-924.6318,42.9045);
    pick_life[0] = CreateDynamicPickup(1240, 2, -1987.6259,274.7049,34.9564);
    pick_life[1] = CreateDynamicPickup(1240, 2, 2463.1362,-1683.0521,13.3142);
    pick_life[2] = CreateDynamicPickup(1240, 2, 1184.9302,-1325.9720,13.3399);
    pick_life[3] = CreateDynamicPickup(1240, 2, 241.4559,-1754.1686,4.2808);
    pick_life[4] = CreateDynamicPickup(1240, 2, 333.7505,-1520.1478,35.6370);
    pick_life[5] = CreateDynamicPickup(1240, 2, 800.4719,-1629.9167,13.1530);
    pick_life[6] = CreateDynamicPickup(1240, 2, 2458.5137,2019.7380,10.8325);
    pick_life[7] = CreateDynamicPickup(1240, 2, -588.3522,-3579.2637,3.4029);
    pick_life[8] = CreateDynamicPickup(1240, 2, 2271.3765,1518.1755,42.5862);
    pick_life[9] = CreateDynamicPickup(1240, 2, 2316.5967,1792.5190,10.5918);
    pick_life[10] = CreateDynamicPickup(1240, 2, -2383.1816,-587.0456,131.8897);
    pick_life[11] = CreateDynamicPickup(1240, 2, -1405.9728,492.3374,18.0023);
    pick_life[12] = CreateDynamicPickup(1240, 2, 2035.2893,-2348.9136,13.6844);
    pick_life[13] = CreateDynamicPickup(1240, 2, 400.7469, 2544.7986, 19.6311);

    AdminLC = CreateDynamicPickup(1559, 23, 1805.7494,-1302.6721,120.2656);
    AdminLC2 = CreateDynamicPickup(1559, 23, -794.806396,497.738037,1376.195312);
   	aussenrein = CreateDynamicPickup(1559, 23, 1795.2469,-1406.5632,13.6531);
	innenraus = CreateDynamicPickup(1559, 23, -1405.4905,985.1736,1049.0078);
	vehiclebuy = CreateDynamicPickup(1559, 23, -1407.0137,1013.8229,1049.0288);
	dm1pickup = CreateDynamicPickup(1247, 2, -3954.1172,980.9998,65.6059);
	dm2pickup = CreateDynamicPickup(1247, 2, -3951.4558,982.3098,36.1859);
	VIPLpickup = CreateDynamicPickup(1559, 2, -2624.3010,1411.4360,7.2303);
	VIPLpickup2 = CreateDynamicPickup(1559, 23, -3936.6282,1305.2244,2.4587);

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

	CreateDynamicCP(1024.6803,1292.1177,20.3791, 5.0, -1, -1, -1, 100.0); // Bike Challenge Reward
	CreateDynamicCP(3896.1235,3884.3840,184.7534, 12.0, -1, -1, -1, 100.0); // SkyDive1 Reward
	CreateDynamicCP(-1278.9248,-34.3641,1122.3420, 12.0, -1, -1, -1, 100.0); // SkyDive2 Reward
	CreateDynamicCP(2890.5774, -3223.6228, 2132.9097, 12.0, -1, -1, -1, 100.0); // SkyDive3 Reward

	// anti vehile drop
	CreateObject(8040,-1296.403,-1665.809,538.216,0.0,0.0,-6.016); // Ski-Ramp
	CreateObject(8040, 423.46, 3216.41, 739.40,   0.00, 0.00, -106.57); //AAJUMP
	CreateObject(14548,-2183.280,1194.442,1696.073,0.0,0.0,-3.438); // Andro
	CreateObject(18365, 3315.628, -1892.834, 49.420, 0.0, 0.0, 0.0); // bmx
	CreateObject(4867, 3570.977, 1234.999, 8.923, 0.0, 0.0, 90.241); // carsumo
	CreateObject(8420, 317.289, 651.237, 573.563, 0.0, 0.0, 36.956); // pipe
	CreateObject(13607, 1086.370, 1070.795, 70.407, 0.0, 0.0, -34.377); // nrgbowl
	CreateObject(4108, 2773.962, -1274.130, 4315.749, 0.0, 0.0, 0.0); // TugFun
	CreateObject(8040, 310.667, 5487.085, 3426.353, 0.0, 0.0, -89.381); // Drop
 	CreateObject(5794, 4200.000, 1871.350, 2835.076, 0.0, 0.0, 0.0); // LF
 	CreateObject(8357, -2919.677, -313.097, 3.643, 0.0, 0.0, 0.0); // Racemap
 	CreateObject(4232, 1652.955, 2891.235, 140.517, 0.0, 0.0, 23.205); // BC
	CreateObject(8040, 2498.082, -1697.696, 713.894, 0.0, 0.0, -181.341); // SKC
	CreateObject(17864, -2799.695, 2923.545, 9.153, 0.0, 0.0, 0.0); // Kartrack
	CreateObject(8040, 2348.883, -45.075, 366.637, 0.0, 0.0, 90.241); // Waterjump
 	CreateObject(8040, 2121.594, 2546.270, 514.322, 0.0, 0.0, -89.381); // Glassjump
 	CreateObject(8040, 607.596, 2233.157, 940.345, 0.0, 0.0, -179.622); // Bikejump
	CreateObject(8040, 894.12, 2502.60, 694.15,   0.00, 0.00, 180.00); //hugejump
	CreateObject(8040, 493.427, -35.034, 680.793, 0.0, 0.0, -180.000); // huge loop (/loop)
	CreateObject(8040, 941.538, -1387.319, 654.160, 0.0, 0.0, 0.0); // PipeJump static
	CreateObject(8040,865.293,255.333,587.316,0.0,0.0,110.008); // QJUMP
	CreateObject(8040,31.291,274.093,1199.888,0.0,0.0,-35.466); // Spiral
	CreateObject(9612, 2962.32, -661.09, -27.59,   0.00, 0.00, 270.49); //Drag
	CreateObject(8040, -2683.68, 383.00, 921.70,   0.00, 0.00, 65.27); //LoopJump
	CreateObject(8040,2664.19995117,-1044.90002441,883.00,0.0,0.00,359.52038574); //DeathJump
	CreateObject(4867, 1851.615, -3182.590, 17.740, 0.0, 0.0, 0.164); // Planes
	CreateObject(4726, -1197.48755, -22.77995, 11.03192,   0.00000, 0.00000, -134.99997); //SFA
	CreateObject(4726, -1177.33362, -4.65729, 11.03192,   0.00000, 0.00000, -134.99997); //SFA
	CreateObject(4726, -1158.56238, 14.86679, 11.03192,   0.00000, 0.00000, -134.99997); //SFA
	// anti vehicle drop end

	// vehicle shop
	CreateDynamicMapIcon(1795.2469, -1406.5632, 13.6531, 55, 1, -1, -1, -1, 500.0);
	// vehicle shop end

	// hotspots
	CreateDynamicMapIcon(-1196.1506, -17.3470, 15.8281, 23, 1, -1, -1, -1, 300.0); // SFA
	CreateDynamicMapIcon(383.3428, 2536.3140, 18.8503, 23, 1, -1, -1, -1, 300.0); // AA
	CreateDynamicMapIcon(341.5075, -1852.6332, 8.2612, 23, 1, -1, -1, -1, 300.0); // BEACH
	// hotspots end

	// login obj
	CreateDynamicObject(19462, 388.20001, -1809.04004, 16.17000,   0.00000, 90.00000, 13.00000);
	CreateDynamicObject(19462, 391.57999, -1808.23999, 16.17000,   0.00000, 90.00000, 13.00000);
	CreateDynamicObject(18102, 386.79163, -1807.13257, 20.75563,   0.00000, 0.00000, -245.76001);
	// login obj end
    
	AddTeleport(9, "Drift", "drift", -344.308, 1528.474, 75.159);
	AddTeleport(9, "Drift Island", "df", 3075.9263,-3153.9749,49.1486);
	AddTeleport(9, "Las Venturas Drift", "lvdrift", 2333.8508,1405.8370,42.5904);
	AddTeleport(9, "San Fierro Drift", "sfdrift", -2410.9963, -600.7848, 132.3277);
	AddTeleport(3, "Trackmania", "tm", 1297.3998, -5626.5122, 81.7);
	AddTeleport(3, "Trackmania 2", "tm2", -1929.1312, 6627.0327, 12.0);
	AddTeleport(3, "Infernus Paradise", "ip", -5051.7461, -2237.2556, 10.9);
	AddTeleport(3, "Infernus Paradise 2", "ip2", -297.6044, 3682.8264, 24.0);
	AddTeleport(3, "Infernus Paradise 3", "ip3", 4546.4175,655.6476,13.4803);
	AddTeleport(3, "Speed", "speed", 680.2595, -1361.8927, 2552.2214);
	AddTeleport(3, "Disney", "disney", 400.2232,636.9904,16.8194);
	AddTeleport(4, "Mellnik´s Island", "mi", -3801.8572, 498.8828, 16.5183);
	AddTeleport(4, "Treehouse", "treehouse", -804.6822, -2075.3076, 47.1331);
	AddTeleport(4, "Party", "party", -377.2038,2131.4634,133.1797);
	AddTeleport(4, "Balloon", "balloon", 295.4890,-1813.5734,52.0518);
	AddTeleport(1, "Bike Challange", "bikec", 1102.3887, 1355.4951, 10.8203);
	AddTeleport(5, "Hayclimb", "hayclimb", -1788.4408, 575.2750, 35.1641);
	AddTeleport(1, "HalfPipe", "hp", 2848.1548,-1977.4320,10.6646);
	AddTeleport(5, "Slide", "slide", 1572.9949, -1238.7869, 277.7445);
	AddTeleport(4, "Tugfun", "tugfun", 2774.316, -1309.180, 4316.250);
	AddTeleport(1, "Drop", "drop", 309.7934, 5461.4546, 3426.6863);
	AddTeleport(5, "XSlide", "xslide", 1862.760, 1337.315, 55.933);
	AddTeleport(3, "Loop Jump", "loopjump", -2682.3909, 385.2379, 924.8377);
	AddTeleport(3, "Death Jump", "deathjump", 2629.9734,-1029.7679,882.9141);
	AddTeleport(3, "Glass Jump", "glassjump", 2121.4280, 2560.6331, 514.7283);
	AddTeleport(1, "Going Down", "gd", 551.1603,860.3625,7113.0366);
	AddTeleport(1, "Maze 1", "maze", 2330.3174, 535.1375, 2.9512);
	AddTeleport(1, "Maze 2", "maze2", 1458.9336, 1854.9144, 54.7362);
	AddTeleport(1, "Maze 3", "maze3", 836.5298,-2048.2273,12.8672);
	AddTeleport(1, "Maze 4", "maze4", 983.0536,2691.7898,10.6925);
	AddTeleport(3, "Tunnel Jump", "bikejump", -494.527, 1600.167, 844.297);
	AddTeleport(3, "Bike Jump", "bikejump", 641.9279,2222.7144,940.5793);
	AddTeleport(3, "Globe", "globe", 1954.7849,1915.3772,144.7200);
	AddTeleport(3, "Quarry Jump", "qjump", 2121.4280, 2560.6331, 514.7283);
	AddTeleport(2, "Skydive", "skydive", 3887.5874,3891.2942,2018.7869);
	AddTeleport(2, "Skydive 2", "skydive2", -1288.0760,-44.0085,4216.4507);
	AddTeleport(2, "Skydive 3", "skydive3", 2875,-3233,3268);
	AddTeleport(0, "BMX Parkour", "bmx", 3362.586, -1939.724, 43.027);
	AddTeleport(0, "Quad Parkour", "qp", -2904.806, 880.312, 5.354);
	AddTeleport(0, "Quad Parkour 2", "qp2", 2121.9146,2397.7786,51.2586);
	AddTeleport(8, "Los Santos Beach", "beach", 341.8535, -1852.6327, 8.2618);
	AddTeleport(4, "Mount Chilliad", "mc", -2335.2832, -1644.9913, 486.0481);
	AddTeleport(7, "San Fierro Airport", "sfa", -1196.3280, -17.4523, 15.8281);
	AddTeleport(7, "Los Santos Airport", "lsa",  2003.1035,-2455.4905,15.8403);
	AddTeleport(7, "Los Santos", "ls", 2494.7476, -1666.6097, 13.3438);
	AddTeleport(7, "Los Santos Police Department", "lspd", 1542.5554, -1674.7850, 13.5547);
	AddTeleport(7, "Las Venturas Police Department", "lvpd", 2290.5759,2421.3708, 10.8203);
	AddTeleport(7, "San Fierro Police Department", "sfpd", -1624.2128,674.2734,6.9573);
	AddTeleport(3, "Skyroad", "skyroad", 2999.2258, -1433.3010, 1244.1365);
	AddTeleport(4, "Tube", "tube", 1254.5294,-2285.2883,1084.8463);
	AddTeleport(4, "Dune Fun", "dfun",  3638.867, 1179.233, 10.214);
	AddTeleport(4, "Dune Fun 2", "dfun2", 473.3654,-1883.9589,2.4099);
	AddTeleport(3, "Skyroad 2", "skyroad2", 2912.3618,-792.8673,10.7623);
	AddTeleport(3, "Skyroad 3", "skyroad3", 205.0412,2481.6416,16.5166);
	AddTeleport(3, "Skyroad 4", "skyroad4", 587.9016,1400.4779,1228.1453);
	AddTeleport(3, "Water Jump", "wj", 341.6029,2008.7330,571.1588);
	AddTeleport(8, "Abandoned Airport", "aa", 383.5131,2537.2727,18.8503);
	AddTeleport(6, "Transfender", "trans", 1034.5165,-1039.7190,31.6651);
	AddTeleport(6, "Transfender 2", "trans2", -1932.7380,228.3443,34.1563);
	AddTeleport(6, "Transfender 3", "trans3", 2386.2788,1021.7114,10.8203);
	AddTeleport(6, "Loco Low", "lw", 2645.5457, -2004.5851,13.3828);
	AddTeleport(6, "Arch Wheel Angels", "arch", -2689.1001,217.8290,3.9509);
	AddTeleport(7, "Las Ventuars Airport", "lva", 1320.6082,1268.7208,13.5903);
	AddTeleport(7, "Las Venturas", "lv", 2039.8860,1546.1112,10.4450);
	AddTeleport(6, "Vehicle Shop", "vs", 1859.3052,-1463.4524,13.5301);
	AddTeleport(4, "RectAngle", "rect", 742.8961,533.1397,461.9956);
	AddTeleport(4, "Balloon", "balloon", 295.4890,-1813.5734,52.0518);
	AddTeleport(0, "Parkour 1", "parkour", 2586.5618,-1346.5614,232.2472);
	AddTeleport(0, "Parkour 2", "parkour2", -787.3710,-2766.3005,2660.3042);
	AddTeleport(0, "Parkour 3", "parkour3", -783.9699, -3662.0358, 137.3758);
	AddTeleport(0, "Parkour 4", "parkour4", -2929.4922,-1876.4229,8.3901);
	AddTeleport(0, "Parkour 5", "parkour5", 1441.3851318359, -1700.8812255859, 915.390625);
	AddTeleport(0, "Parkour 6", "parkour6", 2768.4343261719,-2743.7131347656,2460.0815429688);
	AddTeleport(0, "Parkour 7", "parkour7", 3018.1736,-1879.4410,599.0370);
	AddTeleport(0, "Parkour 8", "parkour8", 2246,-1276,942);
	AddTeleport(4, "Krusty Krab", "kk", 2521.0232, -1504.3864, 25.5929);
	AddTeleport(0, "Los Santos Parkour", "lsp", 2505.2646,-1694.4974,17.9575);
	AddTeleport(5, "Bowl", "bowl", -576.6021,421.7149,75.2376);
	AddTeleport(7, "San Fierro", "sf", -1990.6650, 136.9297, 27.3110);
	AddTeleport(5, "Snow Market", "snow", -719.7679,1723.9852,7.0400);
	AddTeleport(1, "Sherman Dam", "sd", -793.2972,2230.8733,45.0103);
	AddTeleport(7, "Quarry", "quarry",  833.0357,851.8098,12.0047);
	AddTeleport(7, "Area 51", "a51", 307.2482,2050.7505,17.6406);
	AddTeleport(2, "Base Jump", "bj", 294.3475,-1610.8379,494.6685);
	AddTeleport(2, "Easter Egg", "egg", -2678.2119,1594.8811,217.2739);
	AddTeleport(0, "Glory", "glory", 2121.9146,2397.7786,51.2586);
	AddTeleport(2, "Eiffel Tower", "et", 956.2977,2441.0171,205.7626);
	AddTeleport(2, "Sky", "sky", 1544.1896,-1352.2094,329.4762);
	AddTeleport(2, "San Fierro Tower Jump", "sftj", -1753.6401,884.9623,295.8750);
	AddTeleport(2, "Plane", "plane", 1841.8307,-1398.3483,117.0471);
	AddTeleport(7, "Farm", "farm", -1206.7996,-1056.9430,128.3646);
	AddTeleport(7, "Farm 2", "farm2", -146.8734,30.2465,5.8940);
	AddTeleport(7, "Docks", "docks", 2714.5000,-2711.2676,2.4919);
	AddTeleport(7, "Palomino Creek", "palominocreek", 2343.0247,91.6131,26.3281);
	AddTeleport(7, "Burger Shot", "bs", 1207.7231,-920.2217,43.0507);
	AddTeleport(7, "Burger Shot 2", "bs2", 810.2364,-1632.6433,13.3906);
	AddTeleport(7, "Burger Shot 3", "bs3", 2447.1104,2024.7499,10.8203);
	AddTeleport(7, "Burger Shot 4", "bs4", -2314.1365,-143.7879,35.3203);
	AddTeleport(7, "Burger Shot 5", "bs5", -1907.5175,834.4271,35.0156);
	AddTeleport(7, "Film", "film", 909.7761,-1221.2274,16.9766);
	AddTeleport(8, "Bordel", "bordel", -2682.1389,1344.4447,17.0603);
	AddTeleport(3, "Huge Jump", "hugejump", 863.2654, 2490.4468, 694.3790);
	AddTeleport(3, "Jubber Jump", "jujump", 1387.8517,-2425.5776,525.6338);
	AddTeleport(3, "Loop", "loop",  494.7604,4.7474,704.3844);
	AddTeleport(5, "Dillimore Airport", "da", 788.3009,-471.4969,20.5428);
	AddTeleport(4, "Pool", "pool", 4155.7158,2426.9578,1.2054);
	AddTeleport(5, "Drag", "drag", -557.0079,-3575.5906,7.0870);
	AddTeleport(3, "Drift", "drift", 2333.8508,1405.8370,42.5904);
	AddTeleport(7, "San Fierro Station", "sfstation", -1952.5077,137.8305,26.2813);
	AddTeleport(7, "Los Santos Station", "lsstation", 1706.4425,-1943.0046,13.5607);
	AddTeleport(7, "Las Venturas Station", "lsstation", 1433.8182,2606.3877,10.6719);
	AddTeleport(7, "Glen Park", "glen", 2354.1689, -2067.3284, 22.3832);
	AddTeleport(7, "Park", "park", 1968.4741,-1440.0867,13.5475);
	AddTeleport(7, "Market Station", "ms",  800.6712,-1330.6608,13.1061);
	AddTeleport(5, "NRG", "nrg", 442.4455, 816.6687, 9.6865);
	AddTeleport(8, "San Fierro Airport", "sfa", -1196.3280, -17.4523, 15.8281);
	AddTeleport(8, "Mellnik´s Island", "mi", -3801.8572, 498.8828, 16.5183);
	AddTeleport(5, "Racemap", "racemap", -2904.3860, -415.5923, 4.6274);
	AddTeleport(5, "Racemap 2", "racemap2", 2741.1375,1969.4594,5269.7466);

    CreateDynamic3DTextLabel(""white"["ngs_blue"Private Vehicle Shop"white"]", -1, 1795.2469,-1406.5632,13.6531+0.5, 60.0);
    CreateDynamic3DTextLabel(""red">>> SLOW DOWN <<<", RED, 477.7281,1399.4580,735.2565+0.5, 60.0);
    CreateDynamic3DTextLabel(""white"["lila"Mellnik´s Office"white"]", -1, 1794.8202,-1311.3057,120.6237+0.5, 35.0);
    CreateDynamic3DTextLabel(""white"["yellow"Admin Liberty City"white"]", -1, 1805.7494,-1302.6721,120.2656+0.5, 35.0);
    CreateDynamic3DTextLabel(""white"["ngs_blue"Private Vehicle Shop"white"]", -1, -1407.0137,1013.8229,1049.0288+0.5, 35.0);
    CreateDynamic3DTextLabel(""white"["ngs_blue"VIP"white"]\nLounge Entrance", -1, -2624.3010,1411.4360,7.2303+0.5, 35.0);

    CreateDynamic3DTextLabel(""white"["yellow"Bank"white"]\nPress 'SPACE'", -1, 2311.63, -3.89, 26.74+0.5, 20.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);

    // Create3DTextLabel("{ffffff}You must to enter in the balloon to start it!\nIf you are in it, write "vgreen"'/ballonup'", 0xF67E0FF, 836.0856, -2000.4789, 14.7462, 40.0, 0);

	printf("#Visual Meshes loaded in %i ms", (GetTickCount() + 3600000) - count);
	return 1;
}

function:PlayerBuyVehicle(playerid, vprice, vmodel)
{
	if(GetPlayerCash(playerid) < vprice)
	{
		SCM(playerid, -1, ""er"You can´t afford that vehicle");
		ShowDialog(playerid, CARBUY_DIALOG);
		return 1;
	}

	ShowDialog(playerid, VEHICLE_PLATE_DIALOG);

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
	for(new obj = 0; obj < 13; obj++)
	{
	    if(hVIPVehObj[playerid][obj] != -1)
	    {
	        DestroyObject(hVIPVehObj[playerid][obj]);
	        hVIPVehObj[playerid][obj] = -1;
	    }
	}
	if(PlayerInfo[playerid][TrailerVid] != -1)
	{
		DestroyVehicle(PlayerInfo[playerid][TrailerVid]);
		PlayerInfo[playerid][TrailerVid] = -1;
	}

	new vlabel[100];

	format(vlabel, sizeof(vlabel), ""ngs_blue"%s´s \n"white"private vehicle", __GetName(playerid));

	PlayerInfo[playerid][PV_Vehicle] = CreateVehicle(PlayerInfoVeh[playerid][Model], 1826.9821, -1383.8724, 19.3348, 180.0407, 0, 0, -1);
	PlayerInfo[playerid][PV_3DLabel] = CreateDynamic3DTextLabel(vlabel, -1, 0.0, 0.0, 0.0, 30.0, INVALID_PLAYER_ID, PlayerInfo[playerid][PV_Vehicle], 0, -1, -1, -1, 30.0);

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetVehicleVirtualWorld(PlayerInfo[playerid][PV_Vehicle], 0);
	LinkVehicleToInterior(PlayerInfo[playerid][PV_Vehicle], 0);
    GivePlayerCash(playerid, -PlayerInfoVeh[playerid][Price]);
	format(vlabel, sizeof(vlabel), "-$%s", ToCurrency(PlayerInfoVeh[playerid][Price]));
	GameTextForPlayer(playerid, vlabel, 3000, 1);

    SetVehicleNumberPlate(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Plate]);
    SetVehicleToRespawn(PlayerInfo[playerid][PV_Vehicle]);

    TogglePlayerControllable(playerid, true);
    PutPlayerInVehicle(playerid, PlayerInfo[playerid][PV_Vehicle], 0);
    SendInfo(playerid, "~h~~y~Private Vehicle Purchased!", 3500);
    gTeam[playerid] = NORMAL;

    ShowPlayerDialog(playerid, 5003, DIALOG_STYLE_MSGBOX, ""white"Vehicle bought!", ""white"You can now use these commands:\n\n"dl"/pv\n"dl"/lock\n"dl"/unlock", "OK", "");

    MySQL_CreateBuyVehicle(playerid);
    return 1;
}

PortPlayerMap(playerid, Float:X, Float:Y, Float:Z, Float:Angle, const mapname[], const cmd[])
{
	if(gTeam[playerid] != NORMAL)
	{
	    SCM(playerid, GREY, NOT_AVAIL);
		return 0;
	}

	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);

    if(strcmp(cmd, "/bikec", true) && strcmp(cmd, "/skydive", true) && strcmp(cmd, "/skydive2", true))
    {
        SetPVarInt(playerid, "doingStunt", 0);
    }

    Streamer_UpdateEx(playerid, X, Y, Z);
	SetPlayerPos(playerid, X, Y, floatadd(Z, 3.0));
	SetPlayerFacingAngle(playerid, Angle);

    PlayerPlaySound(playerid, 1039, 0.0, 0.0, 0.0);
	GameTextForPlayer(playerid, mapname, 1000, 6);
    NewMapEvent(playerid, mapname, cmd);
    SetCameraBehindPlayer(playerid);
	return 1;
}

PortPlayerMapVeh(playerid, Float:X, Float:Y, Float:Z, Float:Angle, Float:XVeh, Float:YVeh, Float:ZVeh, Float:AngleVeh, const mapname[], const cmd[])
{
	if(gTeam[playerid] != NORMAL)
	{
	    SCM(playerid, GREY, NOT_AVAIL);
		return 0;
	}
	
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);

    if(strcmp(cmd, "/bikec", true) && strcmp(cmd, "/skydive", true) && strcmp(cmd, "/skydive2", true) && strcmp(cmd, "/skydive3", true))
    {
        SetPVarInt(playerid, "doingStunt", 0);
    }

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
    SetCameraBehindPlayer(playerid);
	return 1;
}

SendWelcomeMSG(playerid)
{
	SCM(playerid, GREY, "===================="white""CURRENT_VERSION""grey"=======================");
	SCM(playerid, NGS_GREEN, "» Type /help for further information");
	SCM(playerid, WHITE, "» /admins to see online administrative personnel");
	SCM(playerid, BLUE, "» You can show/hide the footer with /showf /hidef");
	SCM(playerid, YELLOW, "» Visit our forum at http://forum.stunt-evolution.net");
	SCM(playerid, NGS_BLUE, "» You can use /radio or /streams for music streams");
	SCM(playerid, RED, "» Welcome on {646464}«(—[—|{CD0000}Stunt {005FFF}Evolution{FFE600}™{646464}|—]—)»");
	//SCM(playerid, RED, "» Welcome on {646464}«(—[—|{CD0000}Next {005FFF}Generation "white"Stunting{FFE600}™{646464}|—]—)»");
	SCM(playerid, GREY, "===================="white""CURRENT_VERSION""grey"=======================");
	return 1;
}

SetPlayerBGStaticMeshes(playerid)
{
    TogglePlayerControllable(playerid, false);
    SetPlayerHealth(playerid, 99999.0);
	ResetPlayerWeapons(playerid);

    switch(CurrentBGMap)
    {
        case BG_VOTING:
        {
			SetPlayerPos(playerid, BG_MAP1_WHILECAM);
       		SetPlayerCameraPos(playerid, BG_MAP1_CAMPOS);
       		SetPlayerCameraLookAt(playerid, BG_MAP1_CAMLA);
        }
        case BG_MAP1:
        {
	  		SetPlayerPos(playerid, BG_MAP1_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP1_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP1_CAMLA);
        }
        case BG_MAP2:
        {
     		SetPlayerPos(playerid, BG_MAP2_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP2_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP2_CAMLA);
        }
        case BG_MAP3:
        {
     		SetPlayerPos(playerid, BG_MAP3_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP3_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP3_CAMLA);
        }
        case BG_MAP4:
        {
     		SetPlayerPos(playerid, BG_MAP4_WHILECAM);
	       	SetPlayerCameraPos(playerid, BG_MAP4_CAMPOS);
	       	SetPlayerCameraLookAt(playerid, BG_MAP4_CAMLA);
        }
        case BG_MAP5:
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
	    DerbyMSG("There need to be 2 players to start!");
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
	iTotalVotes = DerbyMapVotes[0] + DerbyMapVotes[1] + DerbyMapVotes[2] + DerbyMapVotes[3] + DerbyMapVotes[4] + DerbyMapVotes[5] + DerbyMapVotes[6] + DerbyMapVotes[7] + DerbyMapVotes[8];
	if(iTotalVotes == 0)
	{
	    ExecDerbyVotingTimer();
		ClearDerbyVotes();
		DerbyMSG("There were no votes!");
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
	    DerbyMSG("Voting was not clear. New Voting starting.");
	    ExecDerbyVotingTimer();
		ClearDerbyVotes();
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
 			if(gTeam[i] == DERBY) ShowDialog(i, DERBY_VOTING_DIALOG);
		}
		return 1;
	}

	new	active_db_players = 0;

	for(new i = 0; i < MAX_PLAYERS; i++)
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
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
		for(new i = 0; i < MAX_PLAYERS; i++)
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
    else if(highestmapvotes == DerbyMapVotes[6]) StartDerbyMap7();
    else if(highestmapvotes == DerbyMapVotes[7]) StartDerbyMap8();
    else if(highestmapvotes == DerbyMapVotes[8]) StartDerbyMap9();
	return 1;
}

ClearDerbyAfkPlayers()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
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
	DerbyMSG("Map 'Lighthouse' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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
    DerbyMSG("Map 'Truncat' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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
	DerbyMSG("Map 'Sky Skiing' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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
	DerbyMSG("Map 'Townhall' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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
	DerbyMSG("Map 'Glazz' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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
	DerbyMSG("Map 'Rambo' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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

function:StartDerbyMap7()
{
    CurrentDerbyMap = 7;
    new pcount = 0;
	ClearDerbyVotes();
	DerbyMSG("Map 'SilverGround' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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
			for(new m7s = 0; m7s < sizeof(Derby_Map7Spawns); m7s++)
			{
				if(!Derby_Map7Spawns[m7s][m7sUsed])
	    		{
	    		    Streamer_UpdateEx(i, Derby_Map7Spawns[m7s][m7sX], Derby_Map7Spawns[m7s][m7sY], Derby_Map7Spawns[m7s][m7sZ]);
	    		    SetPlayerPos(i, Derby_Map7Spawns[m7s][m7sX], Derby_Map7Spawns[m7s][m7sY], Derby_Map7Spawns[m7s][m7sZ]);

	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

					pDerbyCar[i] = CreateVehicle(415, Derby_Map7Spawns[m7s][m7sX], Derby_Map7Spawns[m7s][m7sY], floatadd(Derby_Map7Spawns[m7s][m7sZ], 3.5), Derby_Map7Spawns[m7s][m7sA], (random(128) + 127), (random(128) + 127), -1);
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
					Derby_Map7Spawns[m7s][m7sUsed] = true;
					break;
				}
			}
		}
	}
    ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

function:StartDerbyMap8()
{
    CurrentDerbyMap = 8;
    new pcount = 0;
	ClearDerbyVotes();
	DerbyMSG("Map 'Anubis' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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
			for(new m8s = 0; m8s < sizeof(Derby_Map8Spawns); m8s++)
			{
				if(!Derby_Map8Spawns[m8s][m8sUsed])
	    		{
	    		    Streamer_UpdateEx(i, Derby_Map8Spawns[m8s][m8sX], Derby_Map8Spawns[m8s][m8sY], Derby_Map8Spawns[m8s][m8sZ]);
	    		    SetPlayerPos(i, Derby_Map8Spawns[m8s][m8sX], Derby_Map8Spawns[m8s][m8sY], Derby_Map8Spawns[m8s][m8sZ]);

	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

					pDerbyCar[i] = CreateVehicle(415, Derby_Map8Spawns[m8s][m8sX], Derby_Map8Spawns[m8s][m8sY], floatadd(Derby_Map8Spawns[m8s][m8sZ], 3.5), Derby_Map8Spawns[m8s][m8sA], (random(128) + 127), (random(128) + 127), -1);
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
					Derby_Map8Spawns[m8s][m8sUsed] = true;
					break;
				}
			}
		}
	}
    ExecDerbyTimer();
	tDerbyFallOver = SetTimer("DerbyFallOver", DERBY_FALLOVER_CHECK_TIME, true);
	return 1;
}

function:StartDerbyMap9()
{
    CurrentDerbyMap = 9;
    new pcount = 0;
	ClearDerbyVotes();
	DerbyMSG("Map 'Confusing' won! Let´s start!");

 	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(gTeam[i] == DERBY && IsPlayerConnected(i) && !IsPlayerNPC(i))
		{
		    ClearAnimations(i);
		    SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);

	        if(IsPlayerOnDesktop(i, 1500))
			{
			    new string[100];
			    format(string, sizeof(string), "%s couldn´t be put in vehicle!", __GetName(i));
				DerbyMSG(string);
				bDerbyAFK[i] = true;
				DerbyWinner[i] = false;
	        }
			else pcount++;
		}
	}

	if(pcount <= 1)
	{
		DerbyMSG("Couldn't start Derby! Too many afk players");
        ExecDerbyVotingTimer();
        ClearDerbyVotes();
        IsDerbyRunning = false;
		for(new i = 0; i < MAX_PLAYERS; i++)
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
			for(new m9s = 0; m9s < sizeof(Derby_Map8Spawns); m9s++)
			{
				if(!Derby_Map9Spawns[m9s][m9sUsed])
	    		{
	    		    Streamer_UpdateEx(i, Derby_Map9Spawns[m9s][m9sX], Derby_Map9Spawns[m9s][m9sY], Derby_Map9Spawns[m9s][m9sZ]);
	    		    SetPlayerPos(i, Derby_Map9Spawns[m9s][m9sX], Derby_Map9Spawns[m9s][m9sY], Derby_Map9Spawns[m9s][m9sZ]);

	    		    SetPlayerHealth(i, 100.0);
	    		    ResetPlayerWeapons(i);
	    		    ShowPlayerDialog(i, -1, DIALOG_STYLE_LIST, "Close", "Close", "Close", "Close");

					pDerbyCar[i] = CreateVehicle(415, Derby_Map9Spawns[m9s][m9sX], Derby_Map9Spawns[m9s][m9sY], floatadd(Derby_Map9Spawns[m9s][m9sZ], 3.5), Derby_Map9Spawns[m9s][m9sA], (random(128) + 127), (random(128) + 127), -1);
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
					Derby_Map9Spawns[m9s][m9sUsed] = true;
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
  		SCMToAll(-1, ""derby_sign" No winner! new round starting soon. Join with /derby");
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

					if(PlayerInfo[i][DerbyWins] >= 10 && pAch[i][E_ach_destroyer] == 0)
					{
					    GivePlayerAchievement(i, "Destroyer", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
					    pAch[i][E_ach_destroyer] = 1;
					}

					new money = (1000 * CurrentDerbyPlayers),
						score = floatround(floatdiv(2 * CurrentDerbyPlayers, 1.5)),
						astring[128],
						string[128];

			    	GivePlayerCash(i, money);
			    	format(astring, sizeof(astring), "+$%s~n~+%i Score~n~+1 Derby win", ToCurrency(money), score);
			    	_GivePlayerScore(i, score);
			    	GameTextForPlayer(i, astring, 3000, 1);
			    	DerbyWinner[i] = false;
			    	format(string, sizeof(string), "%s won the Derby and earned "ngs_blue"$%s", __GetName(i), ToCurrency(money));
					DerbyMSG(string);
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
	    case 1: CURRENT_FALLOVER = DERBY_FALLOVER_M1;
	    case 2: CURRENT_FALLOVER = DERBY_FALLOVER_M2; // <-- ;) ?
	    case 3: CURRENT_FALLOVER = DERBY_FALLOVER_M3; // <-- ;) ? wasch war da falsch    -> http://www.youtube.com/watch?v=1zrtdDQlYOY
	    case 4: CURRENT_FALLOVER = DERBY_FALLOVER_M4;
	    case 5: CURRENT_FALLOVER = DERBY_FALLOVER_M5;
	    case 6: CURRENT_FALLOVER = DERBY_FALLOVER_M6;
	    case 7: CURRENT_FALLOVER = DERBY_FALLOVER_M7;
	    case 8: CURRENT_FALLOVER = DERBY_FALLOVER_M8;
	    case 9: CURRENT_FALLOVER = DERBY_FALLOVER_M9;
	}
	new Float:POS[3], string[64];
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
                DerbyMSG(string);
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
					DerbyMSG(string);
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

function:ProcessTick()
{
	new tmp[255];
	
	T_RacePlayers = 0;
	T_DerbyPlayers = 0;
	T_GunGamePlayers = 0;
	T_FalloutPlayers = 0;
	T_TDMPlayers = 0;
	T_WarPlayers = 0;
	T_MinigunPlayers = 0;
	T_SniperPlayers = 0;
	
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i))
	    {
			switch(gTeam[i])
			{
			    case NORMAL:
			    {
	   			    if(GetPlayerState(i) == PLAYER_STATE_DRIVER && IsPlayerInAnyDynamicArea(i))
				    {
						SetVehicleVelocity(GetPlayerVehicleID(i), 0.0, 0.30, 0.35);
				    }
			    }
			    case RACE:
			    {
					if(RaceStatus == RaceStatus_Active)
					{
			  			if(RaceJoinCount == 1)
			  			{
			                format(tmp, sizeof(tmp), "position: ~r~1/1~n~~w~checkpoint: ~b~%i/%i~n~~w~players: ~g~%i/12~n~~w~map: ~y~%s~n~~w~timeleft: ~r~%s", CPProgess[i], TotalRaceCP, RaceJoinCount, RaceName, GameTimeConvert(RaceTime));
						}
						else
						{
							format(tmp, sizeof(tmp), "position: ~r~%i/%i~n~~w~checkpoint: ~b~%i/%i~n~~w~players: ~g~%i/12~n~~w~map: ~y~%s~n~~w~timeleft: ~r~%s", RacePosition[i], RaceJoinCount, CPProgess[i], TotalRaceCP, RaceJoinCount, RaceName, GameTimeConvert(RaceTime));
						}
					}
					else if(RaceStatus == RaceStatus_StartUp)
					{
						format(tmp, sizeof(tmp), "position: ~r~-/-~n~~w~checkpoint: ~b~-/-~n~~w~players: ~g~%i/12~n~~w~map: ~y~%s~n~~w~timeleft: ~r~--:--", RaceJoinCount, RaceName);
					}
					PlayerTextDrawSetString(i, RaceInfo[i], tmp);
					
			        if(IsPlayerInAnyVehicle(i))
			        {
						new kmh = GetPlayerKMH(i);
						if(300 <= kmh > 280)
						{
						  	format(tmp, sizeof(tmp), ""yellow"** "red"Possible speed cheat detected | Player: %s(%i) | Race", __GetName(i), i);
							AdminMSG(RED, tmp);
							print(tmp);
						}
						else if(kmh > 300)
						{
						    cmd_exit(i, "");
						  	format(tmp, sizeof(tmp), ""yellow"** "red"Speed cheat detected | Player: %s(%i) | Player has been removed from race", __GetName(i), i);
							AdminMSG(RED, tmp);
							print(tmp);
						}
					}
					
					T_RacePlayers++;
			    }
			    case DERBY:
			    {
					T_DerbyPlayers++;
			    }
			    case GUNGAME:
			    {
				    new wp[32],
						pweapon = GetPlayerWeapon(i);

				    GetWeaponName(pweapon, wp, sizeof(wp));
				    format(tmp, sizeof(tmp), "players: ~b~%i~n~~w~level: ~r~%i of 14~n~~w~weapon:~n~~g~%s", GunGamePlayers, GunGame_Player[i][level], wp);
				    PlayerTextDrawSetString(i, TXTGunGameInfo[i], tmp);
				    
				    T_GunGamePlayers++;
			    }
			    case FALLOUT:
			    {
			        T_FalloutPlayers++;
			    }
			    case gBG_VOTING, gBG_TEAM1, gBG_TEAM2:
			    {
			        T_TDMPlayers++;
			    }
			    case WAR:
			    {
			        T_WarPlayers++;
			    }
			    case MINIGUN:
			    {
			        T_MinigunPlayers++;
			    }
			    case SNIPER:
			    {
			        T_SniperPlayers++;
			    }
			}
	    }
	}
		
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		format(tmp, sizeof(tmp), "~y~stunt-evolution.net ~<~~>~ ~y~wanteds: ~g~%i ~<~~>~ ~y~/race: ~g~%i ~y~/derby: ~g~%i ~y~/fallout: ~g~%i ~y~/gungame: ~g~%i ~y~/tdm: ~g~%i ~y~/war: ~g~%i ~y~/minigun: ~g~%i ~y~/sniper: ~g~%i",
			PlayerInfo[i][Wanteds],
			T_RacePlayers,
			T_DerbyPlayers,
			T_FalloutPlayers,
			T_GunGamePlayers,
			T_TDMPlayers,
			T_WarPlayers,
			T_MinigunPlayers,
			T_SniperPlayers);
		
	    if(!IsPlayerAvail(i)) continue;
	    PlayerTextDrawSetString(i, TXTPlayerFooter[i], tmp);
	}

	if(g_FalloutStatus != e_Fallout_Inactive)
	{
	    switch(g_FalloutStatus)
	    {
	        case e_Fallout_Startup:
			{
				format(tmp, sizeof(tmp), "timeleft: ~r~--:--~n~~w~players:~b~ %i~n~~w~status:~n~~g~startup", CurrentFalloutPlayers);
			}
	        case e_Fallout_Running:
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
		    case BG_MAP1: format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Forest~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
		    case BG_MAP2: format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Quaters~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
            case BG_MAP3: format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Rust~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
            case BG_MAP4: format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Italy~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
            case BG_MAP5: format(tmp, sizeof(tmp), "timelft: ~r~%s~n~~w~players:~b~ %i~n~~w~Map: ~g~Medieval~n~~w~Rangers Kills:~n~~y~%i~n~~w~Spetsnaz Kills:~n~~y~%i", GameTimeConvert(BGGameTime), bg_players, BGTeam1Kills, BGTeam2Kills);
		}
		TextDrawSetString(TXTBGInfo, tmp);
	}
	else
	{
		TextDrawSetString(TXTBGInfo, "timelft: ~r~--:--~n~~w~players:~b~ --/20~n~~w~Map: ~g~Voting~n~~w~Rangers Kills:~n~~y~---~n~~w~Spetsnaz Kills:~n~~y~---");
	}

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
		    case 7: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~SilverGround", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		    case 8: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~Anubis", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		    case 9: format(tmp, sizeof(tmp), "Timeleft: ~r~%s~n~~w~players: ~b~%i/20~n~~w~Map:~n~~g~Confusing", GameTimeConvert(DerbyGameTime), DerbyPlayers);
		}
		TextDrawSetString(TXTDerbyInfo, tmp);
	}
	else
	{
		TextDrawSetString(TXTDerbyInfo, "Timeleft: ~r~--:--~n~~w~players:~b~ --/--~n~~w~Map:~n~~g~Voting");
	}
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
	for(new i = 0; i < 9; i++)
	{
	    DerbyMapVotes[i] = 0;
	}
	Iter_Clear(DerbyVoters);
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
	for(new i = 0; i < sizeof(Derby_Map7Spawns); i++)
	{
	    Derby_Map7Spawns[i][m7sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map8Spawns); i++)
	{
	    Derby_Map8Spawns[i][m8sUsed] = false;
	}
	for(new i = 0; i < sizeof(Derby_Map9Spawns); i++)
	{
	    Derby_Map9Spawns[i][m9sUsed] = false;
	}
	return 1;
}

function:SetPlayerDerbyStaticMeshes(playerid)
{
    SetPlayerHealth(playerid, 99999.0);
    switch(CurrentDerbyMap)
    {
		case 1:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M1);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M1);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M1);
		}
		case 2:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M2);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M2);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M2);
		}
		case 3:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M3);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M3);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M3);
		}
		case 4:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M4);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M4);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M4);
		}
		case 5:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M5);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M5);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M5);
		}
		case 6:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M6);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M6);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M6);
		}
		case 7:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M7);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M7);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M7);
		}
		case 8:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M8);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M8);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M8);
		}
		case 9:
		{
	 		SetPlayerPos(playerid, DERBY_WIHLE_CAM_M9);
	       	SetPlayerCameraPos(playerid, DERBY_CAMPOS_M9);
	       	SetPlayerCameraLookAt(playerid, DERBY_CAMLA_M9);
		}
	}
	TogglePlayerControllable(playerid, false);
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
		case 1: GivePlayerWeapon(playerid, 35, 1);
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
		case 1: GivePlayerWeapon(playerid, 35, 1);
	}
	return 1;
}

ShowPlayerWelcomeTextdraws(playerid)
{
	for(new i = 0; i < 6; i++)
	{
    	TextDrawShowForPlayer(playerid, TXTWelcome[i]);
	}
}

HidePlayerWelcomeTextdraws(playerid)
{
	for(new i = 0; i < 6; i++)
	{
    	TextDrawHideForPlayer(playerid, TXTWelcome[i]);
	}
}

ShowPlayerConnectTextdraws(playerid)
{
	for(new i = 0; i < 10; i++)
	{
    	TextDrawShowForPlayer(playerid, TXTConnect[i]);
	}
}

HidePlayerConnectTextdraws(playerid)
{
	for(new i = 0; i < 10; i++)
	{
    	TextDrawHideForPlayer(playerid, TXTConnect[i]);
	}
}

ShowPlayerGunGameTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
	TextDrawShowForPlayer(playerid, TXTGunGameBox);
	TextDrawShowForPlayer(playerid, TXTGunGameSign);
	PlayerTextDrawShow(playerid, TXTGunGameInfo[playerid]);
}

HidePlayerGunGameTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawHideForPlayer(playerid, TXTGunGameBox);
	TextDrawHideForPlayer(playerid, TXTGunGameSign);
	PlayerTextDrawHide(playerid, TXTGunGameInfo[playerid]);
}

HidePlayerRaceTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawHideForPlayer(playerid, TXTRaceSign);
	TextDrawHideForPlayer(playerid, TXTRaceBox);
	PlayerTextDrawHide(playerid, RaceInfo[playerid]);
}

ShowPlayerRaceTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
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
	TextDrawShowForPlayer(playerid, TXTDerbyBox);
	TextDrawShowForPlayer(playerid, TXTDerbyInfo);
	TextDrawShowForPlayer(playerid, TXTDerbyBoxSign);
}

HidePlayerDerbyTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawHideForPlayer(playerid, TXTDerbyBox);
	TextDrawHideForPlayer(playerid, TXTDerbyInfo);
	TextDrawHideForPlayer(playerid, TXTDerbyBoxSign);
}

ShowPlayerBGTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
	TextDrawShowForPlayer(playerid, TXTBGBox);
	TextDrawShowForPlayer(playerid, TXTBGInfo);
	TextDrawShowForPlayer(playerid, TXTBGSign);
}

HidePlayerBGTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawHideForPlayer(playerid, TXTBGInfo);
	TextDrawHideForPlayer(playerid, TXTBGSign);
	TextDrawHideForPlayer(playerid, TXTBGBox);
}

ShowPlayerFalloutTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
	TextDrawShowForPlayer(playerid, TXTFalloutBox);
	TextDrawShowForPlayer(playerid, TXTFalloutInfo);
	TextDrawShowForPlayer(playerid, TXTFalloutSign);
}

HidePlayerFalloutTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
	TextDrawHideForPlayer(playerid, TXTFalloutBox);
	TextDrawHideForPlayer(playerid, TXTFalloutInfo);
	TextDrawHideForPlayer(playerid, TXTFalloutSign);
}

HidePlayerDMTextdraws(playerid)
{
    TextDrawShowForPlayer(playerid, TXTInfo);
}

ShowPlayerDMTextdraws(playerid)
{
    TextDrawHideForPlayer(playerid, TXTInfo);
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

	SCMToAll(-1, ""grey"A new fallout game has started!");
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

			new string[100];
			format(string, sizeof(string), "%s fell over the glass bottom!", __GetName(i));
			FalloutMSG(string);

			PlayerInfo[i][FalloutLost] = true;
			HidePlayerFalloutTextdraws(i);
			CurrentFalloutPlayers--;
			ResetPlayerWorld(i);
			gTeam[i] = NORMAL;
			RandomSpawn(i);
			RandomWeapon(i);
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
			        SCM(i, RED, "Fallout canceld due to lack of players!");
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
		    RandomWeapon(i);
			if(!PlayerInfo[i][FalloutLost])
			{
				winners++;

				format(string, sizeof(string), ""fallout_sign" Winner(s): %i. %s", winners, __GetName(i));
				SCMToAll(YELLOW, string);

				money = (500 * CurrentFalloutPlayers);
                GivePlayerCash(i, money);
				_GivePlayerScore(i, 5);
		    	format(string, sizeof(string), "+$%s~n~+5 Score~n~+1 Fallout win", ToCurrency(money));
		    	GameTextForPlayer(i, string, 3000, 1);
				PlayerInfo[i][FalloutWins]++;
				
				if(pAch[i][E_ach_deepimpact] == 0 && PlayerInfo[i][FalloutWins] >= 10)
				{
				    GivePlayerAchievement(i, "Deep Impact", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
				    pAch[i][E_ach_deepimpact] = 1;
				}
				
				gTeam[i] = NORMAL;
				SpawnPlayer(i);
			}
		}
	}
	Fallout_Cancel();

	if(winners == 0) FalloutMSG(""white"There are no winners this round!");
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
	new color1,
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
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod1]);
	}

	if(PlayerInfoVeh[playerid][Mod2] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod2]);
	}

	if(PlayerInfoVeh[playerid][Mod3] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod3]);
	}

	if(PlayerInfoVeh[playerid][Mod4] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod4]);
	}

	if(PlayerInfoVeh[playerid][Mod5] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod5]);
	}

	if(PlayerInfoVeh[playerid][Mod6] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod6]);
	}

	if(PlayerInfoVeh[playerid][Mod7] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod7]);
	}

	if(PlayerInfoVeh[playerid][Mod8] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod8]);
  }

	if(PlayerInfoVeh[playerid][Mod9] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod9]);
	}

	if(PlayerInfoVeh[playerid][Mod10] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod10]);
	}

	if(PlayerInfoVeh[playerid][Mod11] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod11]);
	}

	if(PlayerInfoVeh[playerid][Mod12] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod12]);
	}

	if(PlayerInfoVeh[playerid][Mod13] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod13]);
	}

	if(PlayerInfoVeh[playerid][Mod14] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod14]);
	}

	if(PlayerInfoVeh[playerid][Mod15] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod15]);
	}

	if(PlayerInfoVeh[playerid][Mod16] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod16]);
	}

	if(PlayerInfoVeh[playerid][Mod17] != 0)
	{
		AddVehicleComponent(PlayerInfo[playerid][PV_Vehicle], PlayerInfoVeh[playerid][Mod17]);
	}
}

function:SaveVehComponets(playerid, componentid)
{
	for(new s = 0; s < 20; s++)
	{
    	if(componentid == pv_spoiler[s][0])
		{
      		PlayerInfoVeh[playerid][Mod1] = componentid;
   	    }
	}

	for(new s = 0; s < 3; s++)
	{
    	if(componentid == pv_nitro[s][0])
		{
    		PlayerInfoVeh[playerid][Mod2] = componentid;
   		}
	}

	for(new s = 0; s < 23; s++)
	{
    	if(componentid == pv_fbumper[s][0])
		{
    		PlayerInfoVeh[playerid][Mod3] = componentid;
   	 	}
	}

	for(new s = 0; s < 22; s++)
	{
    	if(componentid == pv_rbumper[s][0])
		{
    		PlayerInfoVeh[playerid][Mod4] = componentid;
   		}
	}

	for(new s = 0; s < 28; s++)
	{
     	if(componentid == pv_exhaust[s][0])
		{
       		PlayerInfoVeh[playerid][Mod5] = componentid;
		}
	}

	for(new s = 0; s < 2; s++)
	{
		if(componentid == pv_bventr[s][0])
		{
			PlayerInfoVeh[playerid][Mod6] = componentid;
 		}
	}

	for(new s = 0; s < 2; s++)
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

	for(new s = 0; s < 17; s++)
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

	for(new s = 0; s < 21; s++)
	{
		if(componentid == pv_rskirt[s][0])
		{
			PlayerInfoVeh[playerid][Mod11] = componentid;
 		}
	}

	for(new s = 0; s < 1; s++)
	{
		if(componentid == pv_hydraulics[s][0])
		{
			PlayerInfoVeh[playerid][Mod12] = componentid;
		}
	}

	for(new s = 0; s < 1; s++)
	{
     	if(componentid == pv_base[s][0])
 		{
       		PlayerInfoVeh[playerid][Mod13] = componentid;
		}
	}

	for(new s = 0; s < 4; s++)
	{
     	if(componentid == pv_rbbars[s][0])
 		{
       		PlayerInfoVeh[playerid][Mod14] = componentid;
 		}
	}

	for(new s = 0; s < 2; s++)
	{
    	if(componentid == pv_fbbars[s][0])
		{
    		PlayerInfoVeh[playerid][Mod15] = componentid;
		}
	}

	for(new s = 0; s < 17; s++)
	{
    	if(componentid == pv_wheels[s][0])
		{
      		PlayerInfoVeh[playerid][Mod16] = componentid;
   	    }
	}

	for(new s = 0; s < 2; s++)
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

ResetPlayerWorld(playerid)
{
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
}

function:IsPlayerAvail(playerid)
{
	if(IsPlayerConnected(playerid) && playerid != INVALID_PLAYER_ID && PlayerInfo[playerid][ExitType] == 0 && !IsPlayerNPC(playerid) && PlayerInfo[playerid][Logged])
	{
	    return 1;
	}
	return 0;
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
	if(playerid == INVALID_PLAYER_ID) return 1;
    ResetPlayerMoney(playerid);
	PlayerInfo[playerid][Money] = amount;
    GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
    return 1;
}

GivePlayerCash(playerid, amount)
{
	if(playerid == INVALID_PLAYER_ID) return 1;
    ResetPlayerMoney(playerid);
	PlayerInfo[playerid][Money] += amount;
    GivePlayerMoney(playerid, PlayerInfo[playerid][Money]);
	return 1;
}

GetPlayerCash(playerid)
{
    if(playerid == INVALID_PLAYER_ID) return 1;
	return PlayerInfo[playerid][Money];
}

_GivePlayerScore(playerid, amount)
{
    if(playerid == INVALID_PLAYER_ID) return 1;
    PlayerInfo[playerid][Score] += amount;
	SetPlayerScore(playerid, PlayerInfo[playerid][Score]);
	
	if(pAch[playerid][E_ach_scorewhore] == 0 && PlayerInfo[playerid][Score] >= 2000)
	{
	    GivePlayerAchievement(playerid, "Score Whore", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
	    pAch[playerid][E_ach_scorewhore] = 1;
	}
	return 1;
}

_SetPlayerScore(playerid, amount)
{
    if(playerid == INVALID_PLAYER_ID) return 1;
	PlayerInfo[playerid][Score] = amount;
    SetPlayerScore(playerid, PlayerInfo[playerid][Score]);
    
 	if(pAch[playerid][E_ach_scorewhore] == 0 && PlayerInfo[playerid][Score] >= 2000)
	{
	    GivePlayerAchievement(playerid, "Score Whore", "Congrats you earned $10,000!~n~and 10 score!~n~~w~Type /ach to view your achievements.");
	    pAch[playerid][E_ach_scorewhore] = 1;
	}
	return 1;
}

_GetPlayerScore(playerid)
{
    if(playerid == INVALID_PLAYER_ID) return -1;
	return PlayerInfo[playerid][Score];
}

NewMinigameJoin(playerid, const minigame[], const cmd[])
{
	new string[128];
	format(string, sizeof(string), ""white"[JOIN] "GREY_E"%s(%i) just joined %s [/%s]", __GetName(playerid), playerid, minigame, cmd);
	SCMToAll(GREY, string);
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
        	if(!strcmp(PlayerName, __GetName(i), true))
        	{
          		return i;
        	}
      	}
    }
    return INVALID_PLAYER_ID;
}

__GetName(playerid)
{
    new name[MAX_PLAYER_NAME];

    GetPlayerName(playerid, name, MAX_PLAYER_NAME);
    return name;
}

__GetIP(playerid)
{
	new IP[16];

	GetPlayerIp(playerid, IP, sizeof(IP));
	return IP;
}

GetUptime()
{
    new Result[128],
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
    {
        format(Result, sizeof(Result), ""white"Server is up for %i days, %i hours, %i minutes and %i seconds", Time[3], Time[2], Time[1], Time[0]);
	}
    else if(Time[2])
    {
        format(Result, sizeof(Result), ""white"Server is up for %i hours, %i minutes and %i seconds", Time[2], Time[1], Time[0]);
	}
    else if(Time[1])
    {
        format(Result, sizeof(Result), ""white"Server is up for %i minutes and %i seconds", Time[1], Time[0]);
	}
    else
    {
        format(Result, sizeof(Result), ""white"Server is up for %i seconds", Time[0]);
	}
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
	new cp,
	    vehicleid,
		Float:POS[4],
	    c,
		g_RacePosition[12][e_race_position];

	for(new i; i < sizeof(g_RacePosition); i++)
	{
	    g_RacePosition[i][RP_iPlayer] = INVALID_PLAYER_ID;
	    g_RacePosition[i][RP_iValue] = -(i + 1);
	}
	for(new i = 0; i < MAX_PLAYERS; i++)
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
			SCMToAll(WHITE, ""race_sign" Race ended, no one left in the race");
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
	new string[16],
		estring[128];

	strmid(string, RaceNames[random(TotalRaces)], 0, 16, 16);
	LoadAutoRace(string);

	RaceStatus = RaceStatus_StandBy;

	format(estring, sizeof(estring), ""race_sign" New race "white"%s is now active [/race]", string);
	SCMToAll(-1, estring);

	format(estring, sizeof(estring), "SELECT `name`, `time` FROM `"#TABLE_RACE"` WHERE `track` = '%s' ORDER BY `time` ASC LIMIT 1;", string);
	mysql_function_query(g_SQL_handle, estring, true, "OnRaceDataLoaded", "s", string);
	return 1;
}

function:OnRaceDataLoaded(racename[])
{
	new rows, fields;
	cache_get_data(rows, fields, g_SQL_handle);

	if(rows > 0)
	{
		new name[25],
		    string[128],
		    rFile[32],
		    minute,
		    sec,
		    msec;

		format(rFile, sizeof(rFile), "/Race/%s.race", racename);
		if(!fexist(rFile)) return 1;

		format(string, sizeof(string), " -> Vehicle: %s | Checkpoints: %i", (IsValidVehicle(dini_Int(rFile, "vModel"))) ? (VehicleNames[dini_Int(rFile, "vModel") - 400]) : ("Unknown"), dini_Int(rFile, "TotalRaceCP"));
		SCMToAll(YELLOW, string);

		cache_get_row(0, 0, name, g_SQL_handle, sizeof(name));
		ConvertTime(var, cache_get_row_int(0, 1, g_SQL_handle), minute, sec, msec);

		format(string, sizeof(string), " -> #1 %s | %02i:%02i.%03i", name, minute, sec, msec);
		SCMToAll(YELLOW, string);
	}
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
	        new string[50];

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
	    case 21, 6:
	    {
	        new string[128];

			format(string, sizeof(string), ""race_sign" Still %i seconds till %s named race starts [/race]", RaceCountAmount - 1, RaceName);
			SCMToAll(-1, string);
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
	trCounter = SetTimer("RaceCounter", 1000, true);
	tRacePosition = SetTimer("Race_CalculatePosition", 751, true);
	RaceTick = GetTickCount() + 3600000;
	RaceStatus = RaceStatus_Active;
	KillTimer(tRaceCount);
    iRaceEnd = 0;
    SCMToAll(-1, ""race_sign" The current race has been started!");
}

StopRace()
{
	KillTimer(trCounter);
	KillTimer(tRacePosition);
	RaceTick = 0;
	RaceJoinCount = 0;
	RaceSpawnCount = 0;
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
	
	SetTimer("DelayAutoRace", (6 * 30 * 1000) + 307, false);
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

	new String[64];
	format(String, sizeof(String), "~w~Still ~p~%i ~w~seconds left!", iRaceEnd);
    SetTimer("Race_End", 1000, false);

    for(new i = 0; i < MAX_PLAYERS; i++)
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
	SetPlayerPos(playerid, RaceVehCoords[RaceSpawnCount][0], RaceVehCoords[RaceSpawnCount][1], floatadd(RaceVehCoords[RaceSpawnCount][2], 2.0));
	SetPlayerFacingAngle(playerid, RaceVehCoords[RaceSpawnCount][3]);
	SetPlayerVirtualWorld(playerid, RaceVirtualWorld);
	SetPlayerInterior(playerid, 0);

	SetVehicleNumberPlate(PlayerRaceVehicle[playerid], "{3399ff}R{FFFFFF}ac{F81414}E");
	SetVehicleToRespawn(PlayerRaceVehicle[playerid]);
	SetVehicleVirtualWorld(PlayerRaceVehicle[playerid], RaceVirtualWorld);
	AddVehicleComponent(PlayerRaceVehicle[playerid], 1010);
	RepairVehicle(PlayerRaceVehicle[playerid]);

    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_PICKUP, 0);
    Streamer_ToggleItemUpdate(playerid, STREAMER_TYPE_MAP_ICON, 0);
    Streamer_DestroyAllVisibleItems(playerid, STREAMER_TYPE_PICKUP);
    Streamer_DestroyAllVisibleItems(playerid, STREAMER_TYPE_MAP_ICON);

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
	new rFile[255],
		string[255];

	format(rFile, sizeof(rFile), "/Race/%s.race", rName);
	if(!fexist(rFile)) return printf("Race %s doesn't exist!", rName);
	strmid(RaceName, rName, 0, strlen(rName), sizeof(RaceName));
	RaceVehicle = dini_Int(rFile, "vModel");
	RaceType = dini_Int(rFile, "rType");
	RaceVirtualWorld = dini_Int(rFile, "rVirtualworld");
	TotalRaceCP = dini_Int(rFile, "TotalRaceCP");

	for(new i = 0; i < RACE_MAX_PLAYERS; i++)
	{
		format(string, sizeof(string), "vPosX_%i", i);
		RaceVehCoords[i][0] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosY_%i", i);
		RaceVehCoords[i][1] = dini_Float(rFile, string);
		format(string, sizeof(string), "vPosZ_%i", i);
		RaceVehCoords[i][2] = dini_Float(rFile, string);
		format(string, sizeof(string), "vAngle_%i", i);
		RaceVehCoords[i][3] = dini_Float(rFile, string);
	}

	for(new i = 0; i < TotalRaceCP; i++)
	{
 		format(string, sizeof(string), "CP_%i_PosX", i);
 		CPCoords[i][0] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%i_PosY", i);
 		CPCoords[i][1] = dini_Float(rFile, string);
 		format(string, sizeof(string), "CP_%i_PosZ", i);
 		CPCoords[i][2] = dini_Float(rFile, string);
	}

	rPosition = 0;
	RaceFinishCount = 0;
	RaceJoinCount = 0;
	RaceSpawnCount = 0;

	RaceCountAmount = COUNT_DOWN_TILL_RACE_START;

	RaceTime = MAX_RACE_TIME;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    RacePosition[i] = 0;
	}
	return 1;
}

LoadRaceNames()
{
	new rNameFile[64],
	    string[64],
	    count0,
	    count1 = GetTickCount() + 3600000;

	format(rNameFile, sizeof(rNameFile), "/Race/Index/Index.ini");
	TotalRaces = dini_Int(rNameFile, "TotalRaces");

	for(new i = 0; i < TotalRaces; i++)
	{
	    format(string, sizeof(string), "Race_%i", i);
		strmid(RaceNames[i], dini_Get(rNameFile, string), 0, 16, 16);
	    printf("- Loaded Race: %s", RaceNames[i]);
	    count0++;
	}
	printf("#Races loaded in %i ms Total: %i", (GetTickCount() + 3600000) - count1, count0);
}

MySQL_CreatePlayerToy(playerid)
{
	new query[100];
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

MySQL_CheckAutoLogin(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT `ID` FROM `"#TABLE_ACCOUNT"` WHERE `Name` = '%s' AND `IP` = '%s';", __GetName(playerid), __GetIP(playerid));
	mysql_function_query(g_SQL_handle, query, true, "OnQueryFinish", "siii", query, THREAD_CHECK_AUTO_LOGIN, playerid, g_SQL_handle);
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
	`Slot0_Model` = %i, `Slot0_Bone` = %i, `Slot0_XPos` = %.3f, `Slot0_YPos` = %.3f, `Slot0_ZPos` = %.3f, `Slot0_XRot` = %.3f, `Slot0_YRot` = %.3f, `Slot0_ZRot` = %.3f, `Slot0_XScale` = %.3f, `Slot0_YScale` = %.3f, `Slot0_ZScale` = %.3f \
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
	`Slot1_Model` = %i, `Slot1_Bone` = %i, `Slot1_XPos` = %.3f, `Slot1_YPos` = %.3f, `Slot1_ZPos` = %.3f, `Slot1_XRot` = %.3f, `Slot1_YRot` = %.3f, `Slot1_ZRot` = %.3f, `Slot1_XScale` = %.3f, `Slot1_YScale` = %.3f, `Slot1_ZScale` = %.3f \
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
	`Slot2_Model` = %i, `Slot2_Bone` = %i, `Slot2_XPos` = %.3f, `Slot2_YPos` = %.3f, `Slot2_ZPos` = %.3f, `Slot2_XRot` = %.3f, `Slot2_YRot` = %.3f, `Slot2_ZRot` = %.3f, `Slot2_XScale` = %.3f, `Slot2_YScale` = %.3f, `Slot2_ZScale` = %.3f \
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
	`Slot3_Model` = %i, `Slot3_Bone` = %i, `Slot3_XPos` = %.3f, `Slot3_YPos` = %.3f, `Slot3_ZPos` = %.3f, `Slot3_XRot` = %.3f, `Slot3_YRot` = %.3f, `Slot3_ZRot` = %.3f, `Slot3_XScale` = %.3f, `Slot3_YScale` = %.3f, `Slot3_ZScale` = %.3f \
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
	`Slot4_Model` = %i, `Slot4_Bone` = %i, `Slot4_XPos` = %.3f, `Slot4_YPos` = %.3f, `Slot4_ZPos` = %.3f, `Slot4_XRot` = %.3f, `Slot4_YRot` = %.3f, `Slot4_ZRot` = %.3f, `Slot4_XScale` = %.3f, `Slot4_YScale` = %.3f, `Slot4_ZScale` = %.3f \
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

function:ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
	    case LABEL_DIALOG + 1:
	    {
	        ShowPlayerDialog(playerid, LABEL_DIALOG + 1, DIALOG_STYLE_INPUT, ""se" - Change VIP Label Text", ""white"Enter the new text which your label shall display\n"ngs_blue"* "white"Input length: 3-35", "Next", "Cancel");
	    }
	    case LABEL_DIALOG:
	    {
        	ShowPlayerDialog(playerid, LABEL_DIALOG, DIALOG_STYLE_INPUT, ""se" - Attach VIP Label", ""white"Enter some text which your label shall display\n"ngs_blue"* "white"Input length: 3-35", "Next", "Cancel");
	    }
	    case VCONTROL_DIALOG:
	    {
			ShowPlayerDialog(playerid, VCONTROL_DIALOG, DIALOG_STYLE_LIST, ""se" - Vehicle Control", ""dl"Engine control\n"dl"Light control\n"dl"Alarm\n"dl"Bonnet\n"dl"Boot", "Select", "Cancel");
	    }
	    case NAME_CHANGE_DIALOG:
	    {
	        new string[1024];
	        
	        if(PlayerInfo[playerid][VIP] == 1)
	        {
	            if((PlayerInfo[playerid][LastNameChange] + 2592000) > gettime())
	            {
	                format(string, sizeof(string), ""red"Namechange not possible"white"\n\nNamechange cooldown: 30 days "lb_e"(VIP)"white"\nLast Namechange: %s\nNext Namechange available: %s\nCurrent Name: %s",
						UnixTimeToDate(PlayerInfo[playerid][LastNameChange]),
						UnixTimeToDate(PlayerInfo[playerid][LastNameChange] + 2592000),
						__GetName(playerid));
					return ShowPlayerDialog(playerid, NAME_CHANGE_DIALOG + 5 /*Invalid*/, DIALOG_STYLE_MSGBOX, ""se" - Namechange", string, "OK", "");
	            }
	            else
	            {
	                if(PlayerInfo[playerid][LastNameChange] == 0)
	                {
		                format(string, sizeof(string), ""green"Namechange possible"white"\n\nNamechange cooldown: 30 days "lb_e"(VIP)"white"\nLast Namechange: Never\nNext Namechange available: %s\nCurrent Name: %s\n\nEnter a new valid nickname below:",
							UnixTimeToDate(PlayerInfo[playerid][RegDate]),
							__GetName(playerid));
	                }
	                else
	                {
		                format(string, sizeof(string), ""green"Namechange possible"white"\n\nNamechange cooldown: 30 days "lb_e"(VIP)"white"\nLast Namechange: %s\nNext Namechange available: %s\nCurrent Name: %s\n\nEnter a new valid nickname below:",
							UnixTimeToDate(PlayerInfo[playerid][LastNameChange]),
							UnixTimeToDate(PlayerInfo[playerid][LastNameChange] + 2592000),
							__GetName(playerid));
	                }
	                
					return ShowPlayerDialog(playerid, NAME_CHANGE_DIALOG, DIALOG_STYLE_INPUT, ""se" - Namechange", string, "Change", "Cancel");
	            }
	        }
	        else
	        {
	            if((PlayerInfo[playerid][LastNameChange] + 7776000) > gettime())
	            {
	                format(string, sizeof(string), ""red"Namechange not possible"white"\n\nNamechange cooldown: 90 days\nLast Namechange: %s\nNext Namechange available: %s\nCurrent Name: %s",
						UnixTimeToDate(PlayerInfo[playerid][LastNameChange]),
						UnixTimeToDate(PlayerInfo[playerid][LastNameChange] + 7776000),
						__GetName(playerid));
					return ShowPlayerDialog(playerid, NAME_CHANGE_DIALOG + 5 /*Invalid*/, DIALOG_STYLE_MSGBOX, ""se" - Namechange", string, "OK", "");
	            }
	            else
	            {
	                if(PlayerInfo[playerid][LastNameChange] == 0)
	                {
		                format(string, sizeof(string), ""green"Namechange possible"white"\n\nNamechange cooldown: 90 days\nLast Namechange: Never\nNext Namechange available: %s\nCurrent Name: %s\n\nEnter a new valid nickname below:",
							UnixTimeToDate(PlayerInfo[playerid][RegDate]),
							__GetName(playerid));
	                }
	                else
	                {
		                format(string, sizeof(string), ""green"Namechange possible"white"\n\nNamechange cooldown: 90 days\nLast Namechange: %s\nNext Namechange available: %s\nCurrent Name: %s\n\nEnter a new valid nickname below:",
							UnixTimeToDate(PlayerInfo[playerid][LastNameChange]),
							UnixTimeToDate(PlayerInfo[playerid][LastNameChange] + 7776000),
							__GetName(playerid));
	                }

					return ShowPlayerDialog(playerid, NAME_CHANGE_DIALOG, DIALOG_STYLE_INPUT, ""se" - Namechange", string, "Change", "Cancel");
	            }
			}
		}
		case HAREFILL_DIALOG:
		{
		 	new tick = GetTickCount() + 3600000;
			if((PlayerInfo[playerid][tickLastRefill] + COOLDOWN_CMD_HAREFILL) >= tick)
			{
				return SCM(playerid, -1, ""er"Please wait a bit before using this command again!");
			}
		    ShowPlayerDialog(playerid, HAREFILL_DIALOG, DIALOG_STYLE_LIST, ""se" - Health & Armor Refill", ""dl"Health\t\t"grey"[$5,000]\n"dl"Armor\t\t"grey"[$2,500]", "Select", "Cancel");
		}
	    case GANG_SET_RANK_DIALOG:
	    {
			if(PlayerInfo[playerid][GangPosition] == GANG_POS_LEADER)
			{
			    ShowPlayerDialog(playerid, GANG_SET_RANK_DIALOG, DIALOG_STYLE_LIST, ""se" - Gang Rank Menu", ""grey"Select a rank below:\n"dl"Junior Member\n"dl"Member\n"dl"Senior Member\n"dl"Advisor", "Next", "Cancel");
			}
			else if(PlayerInfo[playerid][GangPosition] == GANG_POS_MAIN_LEADER)
			{
	    		ShowPlayerDialog(playerid, GANG_SET_RANK_DIALOG, DIALOG_STYLE_LIST, ""se" - Gang Rank Menu", ""grey"Select a rank below:\n"dl"Junior Member\n"dl"Member\n"dl"Senior Member\n"dl"Advisor\n"dl"Leader", "Next", "Cancel");
			}
		}
	    case CLOSE_GANG_DIALOG:
	    {
	        ShowPlayerDialog(playerid, CLOSE_GANG_DIALOG, DIALOG_STYLE_MSGBOX, ""se" - Close Gang", ""white"If you want to close your gang write click on 'Close'\nelse 'Cancel'", "Close", "Cancel");
	    }
	    case GANG_KICK_DIALOG:
	    {
	        ShowPlayerDialog(playerid, GANG_KICK_DIALOG, DIALOG_STYLE_INPUT, ""se" - Gang Kick Menu", ""white"Enter the "ngs_blue"exact "white"name the of the player you want to kick out of your gang:", "Kick", "Cancel");
	    }
	    case SETTINGS_DIALOG:
	    {
	    	ShowPlayerDialog(playerid, SETTINGS_DIALOG, DIALOG_STYLE_LIST, ""se" - Settings", GetPlayerSettings(playerid), "Select", "Cancel");
	    }
	    case HELP_DIALOG:
	    {
	        ShowPlayerDialog(playerid, HELP_DIALOG, DIALOG_STYLE_LIST, ""se" - Help", ""dl"General Help\n"dl"Commands\n"dl"Shortcuts\n"dl"Minigames\n"dl"Maps\n"dl"Settings\n"dl""grey"ServerIP: 176.28.51.84:7777", "OK", "");
	    }
	    case CMDS_DIALOG:
	    {
        	ShowPlayerDialog(playerid, CMDS_DIALOG, DIALOG_STYLE_LIST, ""se" - Commands", ""dl"General\n"dl"Account\n"dl"Gang\n"dl"House/Business\n"dl"Private Vehicle\n"dl"Other\n"dl"VIP", "Select", "Cancel");
		}
	    case HOUSE_UPGRADE_DIALOG:
	    {
	        new string[512],
				string2[256];

			format(string, sizeof(string), ""dl"Barrack\n"dl"Standard\n"dl"Advanced Standard\n"dl"Ryders House\n"dl"Bunker House\n"dl"Underground\n"dl"Nice Small Hotel Room\n"dl"CJs House");
			format(string2, sizeof(string2), "\n"dl"Luxus House\n"dl"Strip Club\n"dl"Entire Motel\n"dl"Small Villa\n"dl"Big Villa\n"dl"Madd Doggs Mansion");
			strcat(string, string2);

	        ShowPlayerDialog(playerid, HOUSE_UPGRADE_DIALOG, DIALOG_STYLE_LIST, ""se" - House Upgrade", string, "Select", "Cancel");
	    }
		case DIALOG_RACE_RACETYPE:
		{
			ShowPlayerDialog(playerid, DIALOG_RACE_RACETYPE, DIALOG_STYLE_LIST, ""se" - Race Creation "white"- (Step 1/5)", ""dl"Normal Race\n"dl"Air Race", "Next", "Exit");
		}
	    case DIALOG_RACE_RACEVW:
		{
			ShowPlayerDialog(playerid, DIALOG_RACE_RACEVW, DIALOG_STYLE_INPUT, ""se" - Race Creation "white"- (Step 2/5)", ""white"virtual world:", "Next", "Back");
		}
	    case DIALOG_RACE_RACEVWERR:
		{
			ShowPlayerDialog(playerid, DIALOG_RACE_RACEVWERR, DIALOG_STYLE_INPUT, ""se" - Race Creation "white"- (Step 2/5)", ""er"Wrong virtualworld (min. 1 - max. 2147483647)\n\nvirtual world:", "Next", "Back");
		}
		case DIALOG_RACE_RACEVEH:
		{
			ShowPlayerDialog(playerid, DIALOG_RACE_RACEVEH, DIALOG_STYLE_INPUT, ""se" - Race Creation "white"- (Step 3/5)", ""white"vehicle:", "Next", "Back");
		}
		case DIALOG_RACE_RACEVEHERR:
		{
			ShowPlayerDialog(playerid, DIALOG_RACE_RACEVEHERR, DIALOG_STYLE_INPUT, ""se" - Race Creation "white"- (Step 3/5)", ""er"Invalid Vehilce ID/Name\n\nvehicle:", "Next", "Back");
		}
		case DIALOG_RACE_RACESTARTPOS:
		{
			ShowPlayerDialog(playerid, DIALOG_RACE_RACESTARTPOS, DIALOG_STYLE_MSGBOX, ""se" - Race Creation "white"- (Step 4/5)", ""white"Set start postions 'KEY_FIRE'", "GO", "Back");
		}
		case DIALOG_RACE_CHECKPOINTS:
		{
			ShowPlayerDialog(playerid, DIALOG_RACE_CHECKPOINTS, DIALOG_STYLE_MSGBOX, ""se" - Race Creation "white"- (Step 5/5)", ""white"Checkpoints", "GO", "Back");
		}
		case DIALOG_RACE_RACERDY:
		{
			ShowPlayerDialog(playerid, DIALOG_RACE_RACERDY, DIALOG_STYLE_MSGBOX, ""se" - Race Creation "white"- (DONE)", ""white"Race has been created - ready to use", "Finish", "");
		}
		case STREAM_DIALOG:
		{
			ShowPlayerDialog(playerid, STREAM_DIALOG, DIALOG_STYLE_LIST, ""se" - Audio Streams", ""dl"Electro\n"dl"Metal\n"dl"Pop\n"dl"Hip Hop\n"dl"Rap\n"dl"Rock\n"dl"Oldies\n"dl""grey"Your own stream", "Select", "Stop stream");
		}
		case VEHICLE_PLATE_DIALOG:
  		{
			ShowPlayerDialog(playerid, VEHICLE_PLATE_DIALOG, DIALOG_STYLE_INPUT, ""se" - Private Vehicle Shop", ""white"Please enter something for your number plate:\nYou can change it later.\nLength: 2 - 12 characters", "Next", "Back");
  		}
		case NEON_DIALOG:
		{
		    ShowPlayerDialog(playerid, NEON_DIALOG, DIALOG_STYLE_LIST, ""se" - Private Vehicle > Neon Menu", ""dl"Red\n"dl"Green\n"dl"Blue\n"dl"Yellow\n"dl"White\n"dl""grey"Remove", "OK", "Cancel");
		}
		case CUSTOM_PLATE_DIALOG:
		{
		    ShowPlayerDialog(playerid, CUSTOM_PLATE_DIALOG, DIALOG_STYLE_INPUT, ""se" - Private Vehicle > Plate", ""white"Please enter something for your number plate:\nLength: 2 - 12 characters", "Change", "Cancel");
		}
		case VEHICLE_DIALOG:
		{
			new string[512],
				finstring[1024];

			format(finstring, sizeof(finstring), ""dl""yellow_e"VIP Vehicles\n"dl"Airplanes\n"dl"Helicopters\n"dl"Bikes\n"dl"Convertibles\n"dl"Industrial\n"dl"Lowriders\n"dl"Off Road\n"dl"Public Service Vehicles\n"dl"Saloons\n");
			format(string, sizeof(string), ""dl"Sport Vehicles\n"dl"Station Wagons\n"dl"Boats\n"dl"Trailers\n"dl"Unique Vehicles\n"dl"RC Vehicles");
			strcat(finstring, string, sizeof(string));
			ShowPlayerDialog(playerid, VEHICLE_DIALOG, DIALOG_STYLE_LIST, ""se" - Vehicle Menu", finstring, "Select", "Cancel");
		}
		case TELE_DIALOG:
		{
			ShowPlayerDialog(playerid, TELE_DIALOG, DIALOG_STYLE_LIST, ""se" - Teleports",
			""dl"Parkours\n"dl"Stunts\n"dl"Basejump/Skydive\n"dl"Vehicle Jumps\n"dl"Fun Maps\n"dl"Specials\n"dl"Vehicle Tuning\n"dl"Cities\n"dl"Hotspots\n"dl"Drifts", "Select", "Cancel");
		}
		case VMENU_DIALOG:
		{
			ShowPlayerDialog(playerid, VMENU_DIALOG, DIALOG_STYLE_LIST, ""se" - Private Vehicle Menu", ""dl"Spawn Vehicle\n"dl"Attach Neon\n"dl"Change Number Plate\n"dl"Change Vehicle Color\n"dl""grey"Sell vehicle", "Select", "Cancel");
		}
		case WEAPON_DIALOG:
		{
			ShowPlayerDialog(playerid, WEAPON_DIALOG, DIALOG_STYLE_LIST, ""se" - Weapons", ""dl"Rifles\n"dl"Submachine Guns\n"dl"Shot Guns\n"dl"Hand Guns\n"dl"Melee Weapons\n"dl"Special Weapons", "Select", "Cancel");
		}
		case CARBUY_DIALOG:
		{
  			ShowPlayerDialog(playerid, CARBUY_DIALOG, DIALOG_STYLE_LIST, ""se" - Private Vehicle Shop", ""dl"Lowriders\n"dl"Sport Vehicles\n"dl"Saloons\n"dl"Bikes\n"dl"Convertibles\n"dl"Off Road\n"dl""lb_e"VIP Vehicles", "Select", "Cancel");
		}
		case GMENU_DIALOG:
		{
		    new string[128];
		    format(string, sizeof(string), ""grey"[%s] %s "white"- Gang Menu", PlayerInfo[playerid][GangTag], PlayerInfo[playerid][GangName]);
		
		    switch(PlayerInfo[playerid][GangPosition])
			{
			    case GANG_POS_JUNIOR_MEMBER, GANG_POS_MEMBER, GANG_POS_SENIOR_MEMBER, GANG_POS_ADVISOR:
			    {
			        ShowPlayerDialog(playerid, GMENU_DIALOG, DIALOG_STYLE_LIST, string, ""dl"Gang Info\n"dl"Show all gang members\n"dl"View all gang commands", "Select", "Cancel");
			    }
			    case GANG_POS_LEADER:
			    {
			        ShowPlayerDialog(playerid, GMENU_DIALOG, DIALOG_STYLE_LIST, string, ""dl"Gang Info\n"dl"Show All Gang Members\n"dl"View All Gang Commands\n"dl"Set Player Rank", "Select", "Cancel");
			    }
			    case GANG_POS_MAIN_LEADER:
			    {
			    	ShowPlayerDialog(playerid, GMENU_DIALOG, DIALOG_STYLE_LIST, string, ""dl"Gang Info\n"dl"Show All Gang Members\n"dl"View All Gang Commands\n"dl"Set Player Rank\n"dl"Kick Player From Gang", "Select", "Cancel");
			    }
			}
		}
		case BGVOTING_DIALOG:
		{
		    ShowPlayerDialog(playerid, BGVOTING_DIALOG, DIALOG_STYLE_LIST, ""se" - TDM Map Voting", ""dl"Forest\n"dl"Quarters\n"dl"Rust\n"dl"Italy\n"dl"Medieval", "Vote", "");
		}
		case DERBY_VOTING_DIALOG:
		{
            ShowPlayerDialog(playerid, DERBY_VOTING_DIALOG, DIALOG_STYLE_LIST, ""se" - Derby Map Voting", ""dl"SilverGround\n"dl"Anubis\n"dl"Confusing\n"dl"Lighthouse\n"dl"Truncat\n"dl"Sky Skiing\n"dl"Townhall\n"dl"Glazz\n"dl"Rambo", "Vote", "");
		}
		case BANK_DIALOG:
		{
		    ShowPlayerDialog(playerid, BANK_DIALOG, DIALOG_STYLE_LIST, ""se" - Bank Menu", ""dl"Deposit\n"dl"Withdraw\n"dl"Check Balance", "Select", "Cancel");
		}
	}
	return 1;
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

function:RandomSvrMsg()
{
	switch(random(2))
	{
	    case 0: SCMToAll(WHITE, ServerMSGS[random(sizeof(ServerMSGS))]);
	    case 1:
	    {
	        new count = 0, string[64];
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
			    if(IsPlayerNPC(i) || !IsPlayerConnected(i)) continue;
				count++;
			}
			format(string, sizeof(string), ""se" "IVORY_E"Total Players online: %i", count);
			SCMToAll(WHITE, string);
	    }
	}
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
	InfoTD[playerid] = CreatePlayerTextDraw(playerid, 148.888, 361.385, "~b~~h~Welcome!");
 	PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.326, 1.654);
	PlayerTextDrawAlignment(playerid, InfoTD[playerid], 1);
	PlayerTextDrawColor(playerid, InfoTD[playerid], -18177);
	PlayerTextDrawSetOutline(playerid, InfoTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);
	
	DynamicAchTD[playerid][0] = CreatePlayerTextDraw(playerid, 313.000000, 213.000000, "TITLE");
	PlayerTextDrawAlignment(playerid, DynamicAchTD[playerid][0], 2);
	PlayerTextDrawBackgroundColor(playerid, DynamicAchTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, DynamicAchTD[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, DynamicAchTD[playerid][0], 0.519999, 1.700000);
	PlayerTextDrawColor(playerid, DynamicAchTD[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid, DynamicAchTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, DynamicAchTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, DynamicAchTD[playerid][0], 0);

	DynamicAchTD[playerid][1] = CreatePlayerTextDraw(playerid, 313.000000, 235.000000, "INFO");
	PlayerTextDrawAlignment(playerid, DynamicAchTD[playerid][1], 2);
	PlayerTextDrawBackgroundColor(playerid, DynamicAchTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, DynamicAchTD[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, DynamicAchTD[playerid][1], 0.290000, 1.200000);
	PlayerTextDrawColor(playerid, DynamicAchTD[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid, DynamicAchTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, DynamicAchTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, DynamicAchTD[playerid][1], 0);
	
	vTD[playerid] = CreatePlayerTextDraw(playerid, 555.110412, 320.119964, "_");
	PlayerTextDrawLetterSize(playerid, vTD[playerid], 0.561555, 3.038580);
	PlayerTextDrawAlignment(playerid, vTD[playerid], 2);
	PlayerTextDrawColor(playerid, vTD[playerid], 8388863);
	PlayerTextDrawSetShadow(playerid, vTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, vTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, vTD[playerid], 51);
	PlayerTextDrawFont(playerid, vTD[playerid], 2);
	PlayerTextDrawSetProportional(playerid, vTD[playerid], 1);
	
	TXTPlayerFooter[playerid] = CreatePlayerTextDraw(playerid, 9.500000, 433.000000, "~y~stunt-evolution.net ~<~~>~ ~y~wanteds: ~g~0 ~<~~>~ ~y~/race: ~g~0 ~y~/derby: ~g~0 ~y~/fallout: ~g~0 ~y~/gungame: ~g~0 ~y~/tdm: ~g~0 ~y~/war: ~g~0 ~y~/minigun: ~g~0 ~y~/sniper: ~g~0");
	PlayerTextDrawBackgroundColor(playerid, TXTPlayerFooter[playerid], 168430216);
	PlayerTextDrawFont(playerid, TXTPlayerFooter[playerid], 2);
	PlayerTextDrawLetterSize(playerid, TXTPlayerFooter[playerid], 0.2210000, 1.120000);
	PlayerTextDrawColor(playerid, TXTPlayerFooter[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TXTPlayerFooter[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXTPlayerFooter[playerid], 1);

	TXTKillerText[playerid] = CreatePlayerTextDraw(playerid, 319.000000, 204.000000, "Killed by~n~~r~");
	PlayerTextDrawAlignment(playerid, TXTKillerText[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, TXTKillerText[playerid], 255);
	PlayerTextDrawFont(playerid, TXTKillerText[playerid], 3);
	PlayerTextDrawLetterSize(playerid, TXTKillerText[playerid], 0.290000, 1.099999);
	PlayerTextDrawColor(playerid, TXTKillerText[playerid], -1);
	PlayerTextDrawSetOutline(playerid, TXTKillerText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TXTKillerText[playerid], 1);

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

	PreloadAnimLib(playerid, "DANCING");
	PreloadAnimLib(playerid, "STRIP");
	PreloadAnimLib(playerid, "ROB_BANK");

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
	SetTimerEx("Kick_Delay", 3000, false, "i", playerid);
	return 1;
}

function:Kick_Delay(playerid)
{
	Kick(playerid);
	return 1;
}

GetPlayerSettings(playerid)
{
	new string[1024],
	    tmpstring[128];

	if(PlayerInfo[playerid][SpeedBoost])
	{
	    format(tmpstring, sizeof(tmpstring), ""white"1)\tSpeedboost\t"vgreen"[ON]\n");
	    strcat(string, tmpstring);
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""white"1)\tSpeedboost\t"red"[OFF]\n");
	    strcat(string, tmpstring);
	}

	if(PlayerInfo[playerid][SuperJump])
	{
	    format(tmpstring, sizeof(tmpstring), ""white"2)\tSuperjump\t"vgreen"[ON]\n");
	    strcat(string, tmpstring);
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""white"2)\tSuperjump\t"red"[OFF]\n");
	    strcat(string, tmpstring);
	}
	
	if(PlayerInfo[playerid][bFooterEnabled])
	{
	    format(tmpstring, sizeof(tmpstring), ""white"3)\tFooter\t\t"vgreen"[ON]\n");
	    strcat(string, tmpstring);
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""white"3)\tFooter\t\t"red"[OFF]\n");
	    strcat(string, tmpstring);
	}

    format(tmpstring, sizeof(tmpstring), ""white"4)\tColor\t\t{%06x}Color\n", GetPlayerColor(playerid) >>> 8);
    strcat(string, tmpstring);

	if(!PlayerInfo[playerid][bHasSpawn])
	{
	    format(tmpstring, sizeof(tmpstring), ""white"5)\tSpawn Place\t"vgreen"Default Random\n");
	    strcat(string, tmpstring);
	}
	else
	{
	    format(tmpstring, sizeof(tmpstring), ""white"5)\tSpawn Place\t"vgreen"Custom\n");
	    strcat(string, tmpstring);
	}

    format(tmpstring, sizeof(tmpstring), ""grey"6)\tChange Pass\n");
    strcat(string, tmpstring);
    format(tmpstring, sizeof(tmpstring), ""grey"7)\tStats\n");
    strcat(string, tmpstring);
    format(tmpstring, sizeof(tmpstring), ""grey"8)\tHelp\n");
    strcat(string, tmpstring);
    format(tmpstring, sizeof(tmpstring), ""grey"9)\tNetstats");
    strcat(string, tmpstring);
	return string;
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

    format(u_date, sizeof(u_date), "%02i/%02i/%i %02i:%02i:%02i", u_day, u_month, u_year, u_hour, u_minute, u_second);
	return u_date;
}

ToCurrency(CCash)
{
    new szStr[16];
    format(szStr, sizeof(szStr), "%i", CCash);

    for(new iLen = strlen(szStr) - 3; iLen > 0; iLen -= 3)
    {
        strins(szStr, ",", iLen);
    }
    return szStr;
}

GetPlayerKMH(playerid)
{
	new Float:Vx, Float:Vy, Float:Vz, Float:rtn;
  
  	GetVehicleVelocity(GetPlayerVehicleID(playerid), Vx, Vy, Vz);
  	rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz, 2)));
  	return floatround(rtn * 100 * 1.61);
}

function:ChangeColors(playerid)
{
	new vehid = GetPlayerVehicleID(playerid);

	if(PlayerInfo[playerid][bRainbow] && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && vehid != PlayerInfo[playerid][PV_Vehicle])
	{
		ChangeVehicleColor(vehid, randomColors[random(23)], randomColors[random(23)]);
	}
	else
	{
		KillTimer(PlayerInfo[playerid][tRainbow]);
		PlayerInfo[playerid][bRainbow] = false;
		SCM(playerid, -1, ""se" The Rainbow Effect has been turned off");
	}
	return true;
}

function:DestroyRampObject(objid, playerid)
{
	DestroyDynamicObject(objid);
	PlayerInfo[playerid][RampActive] = false;
}

IsVehicleOneSeater(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 406, 425, 430, 432, 435, 441, 446, 448, 449, 450, 452..454, 460, 464, 465, 472,
		473, 476, 481, 484..486, 493, 501, 509, 510, 512, 513, 519, 520, 530, 531, 532,
	 	539, 553, 564, 568, 571, 572, 574, 577, 584, 590..595, 606,
	 	607, 608, 610, 611: return 1;
	}
	return 0;
}

AddTeleport(teleport_category, const teleport_name[], const teleport_cmd[], Float:x, Float:y, Float:z)
{
	new buffer[64];
    format(buffer, sizeof(buffer), "cmd_%s", teleport_cmd);
    
    if(funcidx(buffer) == -1)
	{
  		printf("AddTeleport: %s does not exist.", teleport_cmd);
  		return 0;
	}
	
	format(buffer, sizeof(buffer), ""se"\n"white"%s (/%s)", teleport_name, teleport_cmd);
	
	CreateDynamic3DTextLabel(buffer, -1, x, y, z + 0.50, 40.0);
	
	format(buffer, sizeof(buffer), "%s (/%s)\n", teleport_name, teleport_cmd);
	
	strcat(TeleportDialogString[teleport_category], buffer);
    strmid(Teleports[teleport_category][Teleport_Index[teleport_category]++], teleport_cmd, 0, 26, 26);
    return 1;
}

PushTeleportIntput(playerid, teleport_category, input)
{
	new string[32];
	format(string, sizeof(string), "cmd_%s", Teleports[teleport_category][input]);
	CallLocalFunction(string, "is", playerid, "\1");
}

function:hidevTD(playerid)
{
	PlayerTextDrawHide(playerid, vTD[playerid]);
	PlayerInfo[playerid][vTDShown] = false;
}

SetPlayerPosition(playerid, Float:X, Float:Y, Float:Z, Float:a, inter = 0)
{
    SetPlayerPos(playerid, X, Y, Z);
	SetCameraBehindPlayer(playerid);
	SetPlayerFacingAngle(playerid, a);
	SetPlayerInterior(playerid, inter);
}

function:Maths()
{
	new str[255];
	if(mathsAnswered == 0)
	{
		format(str, sizeof(str), ""RED_E"[MATHS] "LB_E"Previous question(%s) wasn't answered "GREEN_E"(right answer was %i)", mathsCurrent, mathsAnswer);
		SCMToAll(NGS_GREEN, str);
	}
	
    new NR1 = random(100),
		NR2 = random(100),
		NR3 = random(100),
		OP1 = random(3),
		OP2 = random(3),
		FOP1[2],
		FOP2[2];

    mathsAnswer = 0;
    mathsAnswered = 0;
    mathsAward = 0;

    // 0 = -
    // 1 = +
    // 2 = *

	switch(OP1)
	{
		case 0:
        {
        	format(FOP1, sizeof(FOP1), "-");
        	mathsAward = mathsAward + 2500;
            switch(OP2)
            {
            	case 0:
                {
                	format(FOP2, sizeof(FOP2), "-");
                    mathsAnswer = NR1-NR2-NR3;
                    mathsAward = mathsAward + 2500;
             	}
                case 1:
                {
                	format(FOP2, sizeof(FOP2), "+");
                    mathsAnswer = NR1-NR2+NR3;
                    mathsAward = mathsAward + 2000;
                }
                case 2:
                {
                	format(FOP2, sizeof(FOP2), "*");
                	mathsAnswer = NR1-NR2*NR3;
                	mathsAward = mathsAward + 3500;
            	}
          	}
 		}
  		case 1:
    	{
     		format(FOP1, sizeof(FOP1), "+");
			mathsAward = mathsAward + 2000;
            switch(OP2)
			{
   				case 0:
                {
                	format(FOP2, sizeof(FOP2), "-");
                    mathsAnswer = NR1+NR2-NR3;
                    mathsAward = mathsAward + 2500;
                }
                case 1:
                {
                	format(FOP2, sizeof(FOP2), "+");
                    mathsAnswer = NR1+NR2+NR3;
                    mathsAward = mathsAward + 2000;
                }
                case 2:
                {
                	format(FOP2, sizeof(FOP2), "*");
                	mathsAnswer = NR1+NR2*NR3;
                	mathsAward = mathsAward + 3500;
           		}
			}
		}
		case 2:
		{
			format(FOP1, sizeof(FOP1), "*");
			mathsAward = mathsAward + 3500;
			switch(OP2)
			{
				case 0:
				{
					format(FOP2, sizeof(FOP2), "-");
					mathsAnswer = NR1*NR2-NR3;
					mathsAward = mathsAward + 2500;
				}
				case 1:
				{
					format(FOP2, sizeof(FOP2), "+");
					mathsAnswer = NR1*NR2+NR3;
					mathsAward = mathsAward + 2000;
				}
				case 2:
				{
					format(FOP2, sizeof(FOP2), "x");
					mathsAnswer = NR1*NR2*NR3;
					mathsAward = mathsAward + 3500;
				}
			}
		}
	}
	format(mathsCurrent, sizeof(mathsCurrent), "%i%s%i%s%i", NR1,FOP1,NR2,FOP2,NR3);
	format(str, sizeof(str), ""RED_E"[MATHS] "LB_E"Calculate %s and write /answer <answer> "YELLOW_E"(Score: 4 | Money: $%s)", mathsCurrent, ToCurrency(mathsAward));
	SCMToAll(-1, str);
	return 1;
}

CheckPlayerGod(playerid)
{
	TextDrawHideForPlayer(playerid, godTD);
	SetPlayerHealth(playerid, 100.0);
	PlayerInfo[playerid][bGod] = false;
}

IsBikeModel(modelid)
{
	switch(modelid)
	{
	    case 581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 471, 468, 586: return 1;
	}
	return 0;
}

function:hideCheck(playerid)
{
    TextDrawHideForPlayer(playerid, CheckTD);
	return 1;
}

function:hideError(playerid)
{
    TextDrawHideForPlayer(playerid, ErrorTD);
	return 1;
}

function:hideMsgTD(playerid)
{
    TextDrawHideForPlayer(playerid, NewMsgTD);
	return 1;
}

GivePlayerAchievement(playerid, achname[], stuffz[])
{
	if(GetPVarInt(playerid, "AchShowing") == 1) return 1;

	GivePlayerCash(playerid, 10000);
    PlayerInfo[playerid][Score] += 5;
	SetPlayerScore(playerid, PlayerInfo[playerid][Score]);

	new string[144];
	format(string, sizeof(string), ""se" {%06x}%s(%i) "GREEN_E"has unlocked the achievement '%s'!", GetPlayerColor(playerid) >>> 8, __GetName(playerid), playerid, achname);
	SCMToAll(-1, string);

	ShowPlayerAchievement(playerid, achname, stuffz);
	return 1;
}

ShowPlayerAchievement(playerid, title[], infos[])
{
	TextDrawShowForPlayer(playerid, AchTD[0]);
	TextDrawShowForPlayer(playerid, AchTD[1]);
	TextDrawShowForPlayer(playerid, AchTD[2]);
	TextDrawShowForPlayer(playerid, AchTD[3]);
	TextDrawShowForPlayer(playerid, AchTD[4]);
	TextDrawShowForPlayer(playerid, AchTD[5]);
	PlayerTextDrawSetString(playerid, DynamicAchTD[playerid][0], title);
	PlayerTextDrawSetString(playerid, DynamicAchTD[playerid][1], infos);
	PlayerTextDrawShow(playerid, DynamicAchTD[playerid][0]);
	PlayerTextDrawShow(playerid, DynamicAchTD[playerid][1]);
	PlayerPlaySound(playerid, 1183, 0, 0, 0);
	SetPVarInt(playerid, "AchShowing", 1);
	SetTimerEx("HideAch", 10000, false, "i", playerid);
	return 1;
}

function:HideAch(playerid)
{
	DeletePVar(playerid, "AchShowing");
    PlayerPlaySound(playerid, 1186, 0, 0, 0);
    TextDrawHideForPlayer(playerid, AchTD[0]);
	TextDrawHideForPlayer(playerid, AchTD[1]);
	TextDrawHideForPlayer(playerid, AchTD[2]);
	TextDrawHideForPlayer(playerid, AchTD[3]);
	TextDrawHideForPlayer(playerid, AchTD[4]);
	TextDrawHideForPlayer(playerid, AchTD[5]);
	PlayerTextDrawHide(playerid, DynamicAchTD[playerid][0]);
	PlayerTextDrawHide(playerid, DynamicAchTD[playerid][1]);
	return 1;
}

function:InfoTD_MSG(playerid, ms_time, text[])
{
	if(GetPVarInt(playerid, "InfoTDshown") != -1)
	{
	    PlayerTextDrawHide(playerid, InfoTD[playerid]);
	    KillTimer(GetPVarInt(playerid, "InfoTDshown"));
	}

    PlayerTextDrawSetString(playerid, InfoTD[playerid], text);
    PlayerTextDrawShow(playerid, InfoTD[playerid]);
	SetPVarInt(playerid, "InfoTDshown", SetTimerEx("InfoTD_Hide", ms_time, false, "i", playerid));
}

function:InfoTD_Hide(playerid)
{
	SetPVarInt(playerid, "InfoTDshown", -1);
	PlayerTextDrawHide(playerid, InfoTD[playerid]);
}

function:SplitRBSprinkle(lightobject, playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetObjectPos(RocketBoxSprinkle[RocketBoxTime[playerid]][playerid], X, Y, Z);
	CreateExplosion(X, Y, Z, 2, 0);
	DestroyObject(RocketBoxSprinkle[RocketBoxTime[playerid]][playerid]);
	RBLight[1][playerid] = CreateObject(lightobject, X, Y, Z, 0, 0, 0);
	MoveObject(RBLight[1][playerid], (X-(0+(random(8)))), (Y-(0+(random(8)))), (Z-25), (2+(random(4))));
	RBLight[2][playerid] = CreateObject(lightobject, X, Y, Z, 0, 0, 0);
	MoveObject(RBLight[2][playerid], (X+(0+(random(8)))), (Y+(0+(random(8)))), (Z-25), (2+(random(4))));
	RBLight[3][playerid] = CreateObject(lightobject, X, Y, Z, 0, 0, 0);
	MoveObject(RBLight[3][playerid], (X-(0+(random(8)))), (Y+(0+(random(8)))), (Z-25), (2+(random(4))));
	RBLight[4][playerid] = CreateObject(lightobject, X, Y, Z, 0, 0, 0);
	MoveObject(RBLight[4][playerid], (X+(0+(random(8)))), (Y-(0+(random(8)))), (Z-25), (2+(random(4))));
	SetTimerEx("DestroyRBLight", 2600, 0, "i", playerid);
	return 1;
}

function:DestroyRBLight(playerid)
{
	DestroyObject(RBLight[1][playerid]);
	DestroyObject(RBLight[2][playerid]);
	DestroyObject(RBLight[3][playerid]);
	DestroyObject(RBLight[4][playerid]);
	RocketBoxTime[playerid] = RocketBoxTime[playerid] + 1;
	RocketBoxTimer(playerid);
	return 1;
}

function:RocketBoxTimer(playerid)
{
	if(RocketBoxTime[playerid] == 11)
	{
	    RocketBoxTime[playerid] = 0;
	    DestroyObject(RocketBox[playerid]);
	    DestroyObject(RocketBoxSmoke[playerid]);
	    return 1;
	}
	if(RocketBoxTime[playerid] >= 1)
	{
	    new LightObject;
	    switch(random(2))
		{
			case 0:
			{
				LightObject = 354;
			}
			case 1:
			{
				LightObject = 1213;
			}
		}
	    RocketBoxSprinkle[RocketBoxTime[playerid]][playerid] = CreateObject(LightObject, RBX[playerid], RBY[playerid], RBZ[playerid], 0, 0, 0);
		MoveObject(RocketBoxSprinkle[RocketBoxTime[playerid]][playerid], RBX[playerid], RBY[playerid], (RBZ[playerid]+35), 20);
		SetTimerEx("SplitRBSprinkle", 1500, 0, "ii",LightObject, playerid);
		return 1;
	}
	return 1;
}

function:Destroy1Sprinkle(playerid)
{
	if(DestroySprinkleID[playerid] >= 50)
	{
	    new x;
	    for (x=0;x<Sprinkleid;x++)
		{
			DestroyObject(FountainSprinkle[x][playerid]);
		}
	    return 1;
	}
	if(DestroySprinkleID[playerid] >= 0)
	{
		DestroyObject(FountainSprinkle[DestroySprinkleID[playerid]][playerid]);
		DestroySprinkleID[playerid] = DestroySprinkleID[playerid]+1;
		return 1;
	}
	return 1;
}

function:Destroy3Sprinkle(playerid)
{
	if(DestroySprinkleID[playerid] >= 50)
	{
	    new x;
	    for (x=0;x<Sprinkleid;x++)
		{
			DestroyObject(FountainSprinkle[x][playerid]);
		}
	    return 1;
	}
	if(DestroySprinkleID[playerid] >= 0)
	{
	    new Float:X, Float:Y, Float:Z;
	    GetObjectPos(FountainSprinkle[DestroySprinkleID[playerid]][playerid] ,X, Y, Z);
	    CreateExplosion(X, Y, Z, 12, 0);
		DestroyObject(FountainSprinkle[DestroySprinkleID[playerid]][playerid]);
		DestroySprinkleID[playerid] = DestroySprinkleID[playerid]+1;
		return 1;
	}
	return 1;
}

function:LastSprinkles(playerid)
{
    Fountain1Time[playerid] = 0;
    Fountain2Time[playerid] = 0;
    Fountain3Time[playerid] = 0;
    DestroySprinkleID[playerid] = 0;
    return 1;
}

function:FountainTimer(playerid)
{
	if(Fountain1Time[playerid] >= 50)
	{
	    DestroyObject(Fountain[playerid]);
	    DestroyObject(FountainSmoke[playerid]);
	    SetTimerEx("Destroy1Sprinkle", 300, 0, "i",playerid);
	    SetTimerEx("LastSprinkles", 600, 0, "i", playerid);
	    return 1;
	}
	if(Fountain1Time[playerid] >= 1)
	{
	    new Float:RandomXPos;
	    new Float:RandomYPos;
	    switch(random(2))
		{
			case 0:
			{
				RandomXPos = -(random(4));
			}
			case 1:
			{
				RandomXPos = (random(4));
			}
		}
	    switch(random(2))
		{
			case 0:
			{
				RandomYPos = -(random(4));
			}
			case 1:
			{
				RandomYPos = (random(4));
			}
		}
		FountainSprinkle[Fountain1Time[playerid]][playerid] = CreateObject(354, FTX[playerid], FTY[playerid], FTZ[playerid], 0, 0, 0);
		MoveObject(FountainSprinkle[Fountain1Time[playerid]][playerid], (FTX[playerid]+RandomXPos), (FTY[playerid]+RandomYPos), (FTZ[playerid]+8), 30);
		Fountain1Time[playerid] = Fountain1Time[playerid]+1;
		SetTimerEx("Destroy1Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("FountainTimer", (100+(random(200))), 0, "i",playerid);
		return 1;
	}
	if(Fountain2Time[playerid] >= 50)
	{
	    DestroyObject(Fountain[playerid]);
	    DestroyObject(FountainSmoke[playerid]);
	    SetTimerEx("Destroy1Sprinkle", 300, 0, "i",playerid);
	    SetTimerEx("LastSprinkles", 600, 0, "i", playerid);
	    return 1;
	}
	if(Fountain2Time[playerid] >= 1)
	{
	    new Float:RandomXPos;
	    new Float:RandomYPos;
	    switch(random(2))
		{
			case 0:
			{
				RandomXPos = -(random(4));
			}
			case 1:
			{
				RandomXPos = (random(4));
			}
		}
	    switch(random(2))
		{
			case 0:
			{
				RandomYPos = -(random(4));
			}
			case 1:
			{
				RandomYPos = (random(4));
			}
		}
		FountainSprinkle[Fountain2Time[playerid]][playerid] = CreateObject(1213, FTX[playerid], FTY[playerid], FTZ[playerid], 0, 0, 0);
		MoveObject(FountainSprinkle[Fountain2Time[playerid]][playerid], (FTX[playerid]+RandomXPos), (FTY[playerid]+RandomYPos), (FTZ[playerid]+8), 30);
		Fountain2Time[playerid] = Fountain2Time[playerid]+1;
		SetTimerEx("Destroy1Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("FountainTimer", (100+(random(200))), 0, "i",playerid);
		return 1;
	}
	if(Fountain3Time[playerid] >= 50)
	{
	    DestroyObject(Fountain[playerid]);
	    DestroyObject(FountainSmoke[playerid]);
	    SetTimerEx("Destroy3Sprinkle", 300, 0, "i",playerid);
	    SetTimerEx("LastSprinkles", 600, 0, "i", playerid);
	    return 1;
	}
	if(Fountain3Time[playerid] >= 1)
	{
	    new Float:RandomXPos;
	    new Float:RandomYPos;
	    new RandomLight;
	    switch(random(2))
		{
			case 0:
			{
				RandomXPos = -(random(4));
			}
			case 1:
			{
				RandomXPos = (random(4));
			}
		}
	    switch(random(2))
		{
			case 0:
			{
				RandomYPos = -(random(4));
			}
			case 1:
			{
				RandomYPos = (random(4));
			}
		}
		switch(random(2))
		{
			case 0:
			{
				RandomLight = 354;
			}
			case 1:
			{
				RandomLight = 1213;
			}
		}
		FountainSprinkle[Fountain3Time[playerid]][playerid] = CreateObject(RandomLight, FTX[playerid], FTY[playerid], FTZ[playerid], 0, 0, 0);
		MoveObject(FountainSprinkle[Fountain3Time[playerid]][playerid], (FTX[playerid]+RandomXPos), (FTY[playerid]+RandomYPos), (FTZ[playerid]+8), 30);
		Fountain3Time[playerid] = Fountain3Time[playerid]+1;
		SetTimerEx("Destroy3Sprinkle", 300, 0, "i",playerid);
		SetTimerEx("FountainTimer", (100+(random(200))), 0, "i",playerid);
		return 1;
	}
	return 1;
}

function:CreateRoll(Rollid, Float:X, Float:Y, Float:Z)
{
	RollParts[Rollid][1] = CreateObject(1654, X,Y,Z, 90, 90, 0);
	RollParts[Rollid][2] = CreateObject(1654,(X+0.25),Y,Z, 90, 90, 0);
	RollParts[Rollid][3] = CreateObject(1654,(X+0.50),Y,Z, 90, 90, 0);
	RollParts[Rollid][4] = CreateObject(1654,(X+0.75),Y,Z, 90, 90, 0);
	RollParts[Rollid][5] = CreateObject(1654,(X+1.00),Y,Z, 90, 90, 0);
	RollParts[Rollid][6] = CreateObject(1654,(X+1.25),Y,Z, 90, 90, 0);
	RollParts[Rollid][7] = CreateObject(1654, X,(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][8] = CreateObject(1654,(X+0.25),(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][9] = CreateObject(1654,(X+0.50),(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][10] = CreateObject(1654,(X+0.75),(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][11] = CreateObject(1654,(X+1.00),(Y+0.1),Z, 90, 90, 0);
	RollParts[Rollid][12] = CreateObject(1654,(X+1.25),(Y+0.1),Z, 90, 90, 0);
	return 1;
}

function:DestroyRoll(Rollid)
{
	DestroyObject(RollParts[Rollid][1]);
	DestroyObject(RollParts[Rollid][2]);
	DestroyObject(RollParts[Rollid][3]);
	DestroyObject(RollParts[Rollid][4]);
	DestroyObject(RollParts[Rollid][5]);
	DestroyObject(RollParts[Rollid][6]);
	DestroyObject(RollParts[Rollid][7]);
	DestroyObject(RollParts[Rollid][8]);
	DestroyObject(RollParts[Rollid][9]);
	DestroyObject(RollParts[Rollid][10]);
	DestroyObject(RollParts[Rollid][11]);
	DestroyObject(RollParts[Rollid][12]);
	return 1;
}

function:CrackerRollTime(playerid)
{
	if(firecrackerroll[playerid] == 1)
	{
	    DestroyObject(CrackerRollSmoke[playerid]);
	}
	if(firecrackerroll[playerid] == 49)
	{
	    firecrackerroll[playerid] = 0;
	    DestroyRoll(playerid);
	    return 1;
	}
	if(firecrackerroll[playerid] >= 1)
	{
	    new Float:X, Float:Y, Float:Z;
	    if(firecrackerroll[playerid] >= 1 && firecrackerroll[playerid] <= 4)
	    {
	        GetObjectPos(RollParts[playerid][1], X, Y, Z);
            DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 5 && firecrackerroll[playerid] <= 8)
	    {
	        GetObjectPos(RollParts[playerid][2], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 9 && firecrackerroll[playerid] <= 12)
	    {
	        GetObjectPos(RollParts[playerid][3], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 13 && firecrackerroll[playerid] <= 16)
	    {
	        GetObjectPos(RollParts[playerid][4], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 17 && firecrackerroll[playerid] <= 20)
	    {
	        GetObjectPos(RollParts[playerid][5], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 21 && firecrackerroll[playerid] <= 24)
	    {
	        GetObjectPos(RollParts[playerid][6], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 25 && firecrackerroll[playerid] <= 28)
	    {
	        GetObjectPos(RollParts[playerid][12], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 29 && firecrackerroll[playerid] <= 32)
	    {
	        GetObjectPos(RollParts[playerid][11], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 33 && firecrackerroll[playerid] <= 36)
	    {
	        GetObjectPos(RollParts[playerid][10], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 37 && firecrackerroll[playerid] <= 40)
	    {
	        GetObjectPos(RollParts[playerid][9], X, Y, Z);
			DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 41 && firecrackerroll[playerid] <= 44)
	    {
	        GetObjectPos(RollParts[playerid][8], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    if(firecrackerroll[playerid] >= 45 && firecrackerroll[playerid] <= 48)
	    {
	        GetObjectPos(RollParts[playerid][7], X, Y, Z);
	        DestroyRoll(playerid);
	        CreateExplosion(X, Y, Z, 12, 0);
	        CreateRoll(playerid, RollStartX[playerid], RollStartY[playerid], RollStartZ[playerid]);
	        firecrackerroll[playerid] = firecrackerroll[playerid]+1;
	        SetTimerEx("CrackerRollTime", (100+(random(200))), 0, "i", playerid);
	        return 1;
	    }
	    return 1;
	}
	return 1;
}

function:FirecrackerTime(playerid)
{
	if(firecrackertime[playerid] == 1)
	{
	    new Float:X, Float:Y, Float:Z;
		GetObjectPos(Firecracker[playerid], X, Y, Z);
		CreateExplosion(X,Y,Z, 12, 0);
		DestroyObject(Firecracker[playerid]);
		firecrackertime[playerid] = 0;
		return 1;
	}
	return 1;
}

function:FirerocketTime(playerid)
{
	if(firerockettime[playerid] == 1)
	{
		GetObjectPos(Firerocket[playerid], FRX[playerid], FRY[playerid], FRZ[playerid]);
		explosionrocket[playerid] = CreateExplosion(FRX[playerid], FRY[playerid], FRZ[playerid], 6, 0);
		SetTimerEx("splittime", 500, 0, "i", playerid);
		return 1;
	}
	if(firerockettime[playerid] == 2)
	{
		GetObjectPos(Firerocket[playerid], FRX[playerid], FRY[playerid], FRZ[playerid]);
		explosionrocket[playerid] = CreateExplosion(FRX[playerid], FRY[playerid], FRZ[playerid], 6, 0);
		SetTimerEx("splittime2", 100, 0, "i", playerid);
		return 1;
	}
	return 1;
}

function:splittime(playerid)
{
	if(firerockettime[playerid] == 1)
	{
		CreateExplosion(FRX[playerid]-(0+(random(3))),FRY[playerid]-(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]-(0+(random(3))),FRY[playerid]+(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]-(0+(random(3))),FRY[playerid],FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]+(0+(random(3))),FRY[playerid]-(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]+(0+(random(3))),FRY[playerid]+(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid]+(0+(random(3))),FRY[playerid],FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]-(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]+(0+(random(3))),FRZ[playerid]-(0+(random(3))), 4, 0);
		Light[1][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid]-(0+(random(6))),FRZ[playerid]+(0+(random(6))), 0, 0,0);
		Light[2][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid],FRZ[playerid]+(0+(random(6))), 0, 0,0);
		Light[3][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid],FRZ[playerid]-(0+(random(6))), 0, 0,0);
		Light[4][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid]-(0+(random(6))),FRZ[playerid]+(0+(random(6))), 0, 0,0);
		Light[5][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid]+(0+(random(6))),FRZ[playerid]+(0+(random(6))), 0, 0,0);
		Light[6][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid],FRZ[playerid]-(0+(random(6))), 0, 0,0);
		Light[7][playerid] = CreateObject(354,FRX[playerid]-(0+(random(6))),FRY[playerid]-(0+(random(6))),FRZ[playerid]-(0+(random(6))), 0, 0,0);
		Light[8][playerid] = CreateObject(354,FRX[playerid],FRY[playerid]-(0+(random(6))),FRZ[playerid]+(0+(random(6))), 0, 0,0);
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(Light[1][playerid], X, Y, Z);
		MoveObject(Light[1][playerid], X-(0+(random(6))), Y-(0+(random(6))), Z-20, 6);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		MoveObject(Light[2][playerid], X-(0+(random(6))), Y+(0+(random(6))), Z-20, 5);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		MoveObject(Light[3][playerid], X-(0+(random(6))), Y, Z-20, 4);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		MoveObject(Light[4][playerid], X+(0+(random(6))), Y-(0+(random(6))), Z-20, 5);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		MoveObject(Light[5][playerid], X+(0+(random(6))), Y+(0+(random(6))), Z-20, 5);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		MoveObject(Light[6][playerid], X+(0+(random(6))), Y, Z-20, 4);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		MoveObject(Light[7][playerid], X, Y-(0+(random(6))), Z-20, 6);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		MoveObject(Light[8][playerid], X, Y+(0+(random(6))), Z-20, 5);
		SetTimerEx("lighttimer", 3900, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

function:splittime2(playerid)
{
	if(firerockettime[playerid] == 2)
	{
		CreateExplosion(FRX[playerid]-(0+(random(10))),FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]-(0+(random(10))),FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]-(0+(random(10))),FRY[playerid],FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+(0+(random(10))),FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+(0+(random(10))),FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+(0+(random(10))),FRY[playerid],FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 6, 0);
		Light[1][playerid] = CreateObject(354,FRX[playerid]-(0+(random(10))),FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[2][playerid] = CreateObject(354,FRX[playerid]-(0+(random(10))),FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[3][playerid] = CreateObject(354,FRX[playerid]-(0+(random(10))),FRY[playerid],FRZ[playerid]-5, 0, 0,0);
		Light[4][playerid] = CreateObject(354,FRX[playerid]+(0+(random(10))),FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[5][playerid] = CreateObject(354,FRX[playerid]+(0+(random(10))),FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[6][playerid] = CreateObject(354,FRX[playerid]+(0+(random(10))),FRY[playerid],FRZ[playerid]-5, 0, 0,0);
		Light[7][playerid] = CreateObject(354,FRX[playerid],FRY[playerid]-(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		Light[8][playerid] = CreateObject(354,FRX[playerid],FRY[playerid]+(0+(random(10))),FRZ[playerid]-5, 0, 0,0);
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(Light[1][playerid], X, Y, Z);
		MoveObject(Light[1][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		MoveObject(Light[2][playerid], X-6, Y+6, Z-20, 4);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		MoveObject(Light[3][playerid], X-6, Y, Z-20, 4);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		MoveObject(Light[4][playerid], X+6, Y-6, Z-20, 4);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		MoveObject(Light[5][playerid], X+6, Y+6, Z-20, 4);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		MoveObject(Light[6][playerid], X+6, Y, Z-20, 4);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		MoveObject(Light[7][playerid], X, Y-6, Z-20, 4);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		MoveObject(Light[8][playerid], X, Y+6, Z-20, 4);
		SetTimerEx("splittime3", 3000, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

function:splittime3(playerid)
{
	if(firerockettime[playerid] == 2)
	{
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(Light[1][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(Light[9][playerid], X, Y, Z);
		Light[11][playerid] = CreateObject(1213,X-7,Y+7,Z+8, 0, 0,0);
		Light[12][playerid] = CreateObject(1213,X-7,Y,Z+5, 0, 0,0);
		Light[13][playerid] = CreateObject(1213,X,Y+7,Z-5, 0, 0,0);
		Light[14][playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		Light[15][playerid] = CreateObject(1213,X,Y-7,Z+5, 0, 0,0);
		Light[16][playerid] = CreateObject(1213,X-7,Y,Z-5, 0, 0,0);
		Light[17][playerid] = CreateObject(1213,X,Y+7,Z-8, 0, 0,0);
		Light[18][playerid] = CreateObject(1213,X,Y+7,Z-5, 0, 0,0);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		Light[19][playerid] = CreateObject(1213,X+7,Y,Z-1, 0, 0,0);
		Light[20][playerid] = CreateObject(1213,X-7,Y,Z-8, 0, 0,0);
		Light[21][playerid] = CreateObject(1213,X+7,Y+7,Z-5, 0, 0,0);
		Light[22][playerid] = CreateObject(1213,X,Y,Z+5, 0, 0,0);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		Light[23][playerid] = CreateObject(1213,X+7,Y-7,Z-5, 0, 0,0);
		Light[24][playerid] = CreateObject(1213,X-7,Y,Z-7, 0, 0,0);
		Light[25][playerid] = CreateObject(1213,X+7,Y+7,Z+5, 0, 0,0);
		Light[26][playerid] = CreateObject(1213,X,Y-7,Z, 0, 0,0);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		Light[27][playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		Light[28][playerid] = CreateObject(1213,X-7,Y,Z+8, 0, 0,0);
		Light[29][playerid] = CreateObject(1213,X+7,Y,Z-8, 0, 0,0);
		Light[30][playerid] = CreateObject(1213,X,Y+7,Z+5, 0, 0,0);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		Light[31][playerid] = CreateObject(1213,X-7,Y-7,Z-7, 0, 0,0);
		Light[32][playerid] = CreateObject(1213,X,Y,Z-5, 0, 0,0);
		Light[33][playerid] = CreateObject(1213,X+7,Y+7,Z+5, 0, 0,0);
		Light[34][playerid] = CreateObject(1213,X+4,Y-7,Z-5, 0, 0,0);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		Light[35][playerid] = CreateObject(1213,X-7,Y-7,Z-8, 0, 0,0);
		Light[36][playerid] = CreateObject(1213,X-7,Y,Z+5, 0, 0,0);
		Light[37][playerid] = CreateObject(1213,X,Y,Z-5, 0, 0,0);
		Light[38][playerid] = CreateObject(1213,X,Y-7,Z+8, 0, 0,0);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		Light[39][playerid] = CreateObject(1213,X-4,Y-7,Z-8, 0, 0,0);
		Light[40][playerid] = CreateObject(1213,X+7,Y,Z+8, 0, 0,0);
		Light[41][playerid] = CreateObject(1213,X+4,Y,Z+5, 0, 0,0);
		Light[42][playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		GetObjectPos(Light[1][playerid], X, Y, Z);
		MoveObject(Light[1][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[2][playerid], X, Y, Z);
		MoveObject(Light[2][playerid], X-6, Y+6, Z-20, 4);
		GetObjectPos(Light[3][playerid], X, Y, Z);
		MoveObject(Light[3][playerid], X-6, Y, Z-20, 4);
		GetObjectPos(Light[4][playerid], X, Y, Z);
		MoveObject(Light[4][playerid], X+6, Y-6, Z-20, 4);
		GetObjectPos(Light[5][playerid], X, Y, Z);
		MoveObject(Light[5][playerid], X+6, Y+6, Z-20, 4);
		GetObjectPos(Light[6][playerid], X, Y, Z);
		MoveObject(Light[6][playerid], X+6, Y, Z-20, 4);
		GetObjectPos(Light[7][playerid], X, Y, Z);
		MoveObject(Light[1][playerid], X, Y-6, Z-20, 4);
		GetObjectPos(Light[8][playerid], X, Y, Z);
		MoveObject(Light[8][playerid], X, Y+6, Z-20, 4);
		GetObjectPos(Light[11][playerid], X, Y, Z);
		MoveObject(Light[11][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[12][playerid], X, Y, Z);
		MoveObject(Light[12][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[13][playerid], X, Y, Z);
		MoveObject(Light[13][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[14][playerid], X, Y, Z);
		MoveObject(Light[14][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[15][playerid], X, Y, Z);
		MoveObject(Light[15][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[16][playerid], X, Y, Z);
		MoveObject(Light[16][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[17][playerid], X, Y, Z);
		MoveObject(Light[17][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[18][playerid], X, Y, Z);
		MoveObject(Light[18][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[19][playerid], X, Y, Z);
		MoveObject(Light[19][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[20][playerid], X, Y, Z);
		MoveObject(Light[20][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[21][playerid], X, Y, Z);
		MoveObject(Light[21][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[22][playerid], X, Y, Z);
		MoveObject(Light[22][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[23][playerid], X, Y, Z);
		MoveObject(Light[23][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[24][playerid], X, Y, Z);
		MoveObject(Light[24][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[25][playerid], X, Y, Z);
		MoveObject(Light[25][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[26][playerid], X, Y, Z);
		MoveObject(Light[26][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[27][playerid], X, Y, Z);
		MoveObject(Light[27][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[28][playerid], X, Y, Z);
		MoveObject(Light[28][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[29][playerid], X, Y, Z);
		MoveObject(Light[29][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[30][playerid], X, Y, Z);
		MoveObject(Light[30][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[31][playerid], X, Y, Z);
		MoveObject(Light[31][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[32][playerid], X, Y, Z);
		MoveObject(Light[32][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[33][playerid], X, Y, Z);
		MoveObject(Light[33][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[34][playerid], X, Y, Z);
		MoveObject(Light[34][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[35][playerid], X, Y, Z);
		MoveObject(Light[35][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[36][playerid], X, Y, Z);
		MoveObject(Light[36][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[37][playerid], X, Y, Z);
		MoveObject(Light[37][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[38][playerid], X, Y, Z);
		MoveObject(Light[38][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[39][playerid], X, Y, Z);
		MoveObject(Light[39][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[40][playerid], X, Y, Z);
		MoveObject(Light[40][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[41][playerid], X, Y, Z);
		MoveObject(Light[41][playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(Light[42][playerid], X, Y, Z);
		MoveObject(Light[42][playerid], X-6, Y-6, Z-20, 4);
		SetTimerEx("lighttimer2", 4000, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

function:lighttimer(playerid)
{
	DestroyObject(Light[1][playerid]);
	DestroyObject(Light[2][playerid]);
	DestroyObject(Light[3][playerid]);
	DestroyObject(Light[4][playerid]);
	DestroyObject(Light[5][playerid]);
    DestroyObject(Light[6][playerid]);
    DestroyObject(Light[7][playerid]);
    DestroyObject(Light[8][playerid]);
    firerockettime[playerid] = 0;
	return 1;
}

function:lighttimer2(playerid)
{
	DestroyObject(Light[1][playerid]);
	DestroyObject(Light[2][playerid]);
	DestroyObject(Light[3][playerid]);
	DestroyObject(Light[4][playerid]);
	DestroyObject(Light[5][playerid]);
    DestroyObject(Light[6][playerid]);
    DestroyObject(Light[7][playerid]);
    DestroyObject(Light[8][playerid]);
    DestroyObject(Light[11][playerid]);
	DestroyObject(Light[12][playerid]);
	DestroyObject(Light[13][playerid]);
	DestroyObject(Light[14][playerid]);
	DestroyObject(Light[15][playerid]);
    DestroyObject(Light[16][playerid]);
    DestroyObject(Light[17][playerid]);
    DestroyObject(Light[18][playerid]);
    DestroyObject(Light[19][playerid]);
	DestroyObject(Light[20][playerid]);
	DestroyObject(Light[21][playerid]);
	DestroyObject(Light[22][playerid]);
	DestroyObject(Light[23][playerid]);
    DestroyObject(Light[24][playerid]);
    DestroyObject(Light[25][playerid]);
    DestroyObject(Light[26][playerid]);
    DestroyObject(Light[27][playerid]);
	DestroyObject(Light[28][playerid]);
	DestroyObject(Light[29][playerid]);
	DestroyObject(Light[30][playerid]);
	DestroyObject(Light[31][playerid]);
    DestroyObject(Light[32][playerid]);
    DestroyObject(Light[33][playerid]);
    DestroyObject(Light[34][playerid]);
    DestroyObject(Light[35][playerid]);
	DestroyObject(Light[36][playerid]);
	DestroyObject(Light[37][playerid]);
	DestroyObject(Light[38][playerid]);
	DestroyObject(Light[39][playerid]);
    DestroyObject(Light[40][playerid]);
    DestroyObject(Light[41][playerid]);
    DestroyObject(Light[42][playerid]);
    firerockettime[playerid] = 0;
	return 1;
}
