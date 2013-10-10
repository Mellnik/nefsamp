						//////////////////////
						////New Menu Styles///
						//////Created by://///
						//////°Fallout°///////
						//////////////////////


#include <a_samp>

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
native F_CreateMenu(title[], Float:x, Float:y);
native F_DestroyMenu(menuid);
native F_HideMenuForPlayer(menuid, playerid);
native F_ShowMenuForPlayer(menuid, playerid);
native F_AddMenuItem(menuid, title[]);

native F_SetMenuTitleTextColor(menuid, color);
native F_SetMenuTitleBgColor(menuid, color); (bg = background)
native F_SetMenuTitleBoxColor(menuid, color);

native F_SetMenuItemTextColor(menuid, color);
native F_SetMenuItemBgColor(menuid, color); (bg = background)
native F_SetMenuItemBoxColor(menuid, color);

native F_SetMenuSelectedItemTextColor(menuid, color);
native F_SetMenuSelectedItemBgColor(menuid, color); (bg = background)
native F_SetMenuSelectedItemBoxColor(menuid, color);
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

forward F_OnPlayerSelectedMenuRow(playerid, menuid, row);
forward F_OnPlayerExitedMenu(playerid, menuid);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define F_MAX_MENUS 50
#define F_MAX_MENU_ROWS 20

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

enum MInfo
{
	Float:MenuX,
	Float:MenuY,
	Float:BoxLength,
	Rows,
	bool:Shown[MAX_PLAYERS],
	bool:UsedMenu,
	SelectedRow[MAX_PLAYERS],
	Text:T_Title,
	Text:T_Row[F_MAX_MENU_ROWS],
	SelectedRowTextColor,
	SelectedRowBgColor,
	SelectedRowBoxColor,
	ItemTextColor,
	ItemBgColor,
	ItemBoxColor,
}

new MenuInfo[F_MAX_MENUS][MInfo];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_CreateMenu(title[], Float:x, Float:y, Float:boxlength)
{
	new id;
	while(MenuInfo[id][UsedMenu] == true) id++;

	MenuInfo[id][T_Title] = TextDrawCreate( x, y, title);
	TextDrawUseBox(MenuInfo[id][T_Title], 1);
	TextDrawBoxColor(MenuInfo[id][T_Title], 0x000000CC);
	TextDrawTextSize(MenuInfo[id][T_Title], boxlength, 0.000000);
	TextDrawBackgroundColor(MenuInfo[id][T_Title], 0x000000ff);
	TextDrawFont(MenuInfo[id][T_Title], 0);
	TextDrawLetterSize(MenuInfo[id][T_Title], 0.399999, 1.100000);
	TextDrawColor(MenuInfo[id][T_Title], 0xffffffff);
	TextDrawSetOutline(MenuInfo[id][T_Title], 1);
	TextDrawSetProportional(MenuInfo[id][T_Title], 1);
	TextDrawSetShadow(MenuInfo[id][T_Title], 1);

    MenuInfo[id][MenuX] = x;
    MenuInfo[id][MenuY] = y;
    MenuInfo[id][BoxLength] = boxlength;
    MenuInfo[id][Rows] = 0;
    MenuInfo[id][SelectedRowTextColor] = 0xffffffff;
    MenuInfo[id][SelectedRowBgColor] = 0x000000ff;
    MenuInfo[id][SelectedRowBoxColor] = 0xffffff99;
	MenuInfo[id][ItemTextColor] = 0xffffffff;
	MenuInfo[id][ItemBgColor] = 0x000000ff;
	MenuInfo[id][ItemBoxColor] = 0x00000099;
    for(new i=0; i<MAX_PLAYERS; i++)
    {
    	MenuInfo[id][Shown][i] = false;
    }
    MenuInfo[id][UsedMenu] = true;
    return id;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_DestroyMenu(menuid)
{
    for(new i=0; i<MAX_PLAYERS; i++)
    {
		if(MenuInfo[menuid][Shown][i] == true)
		{
		    TextDrawHideForPlayer(i, Text:MenuInfo[menuid][T_Title]);
		    MenuInfo[menuid][Shown][i] = false;
		}
	}
	if(MenuInfo[menuid][UsedMenu] == true)
	{
		MenuInfo[menuid][UsedMenu] = false;
    	return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_HideMenuForPlayer(menuid, playerid)
{
	if(MenuInfo[menuid][Shown][playerid] == true)
	{
	    TextDrawHideForPlayer(playerid, Text:MenuInfo[menuid][T_Title]);
	    for(new i=0; i<F_MAX_MENU_ROWS; i++)
		{
		    if(i < MenuInfo[menuid][Rows])
		    {
				TextDrawHideForPlayer(playerid, Text:MenuInfo[menuid][T_Row][i]);
		    }
		}
	    MenuInfo[menuid][Shown][playerid] = false;
    	return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_ShowMenuForPlayer(menuid, playerid)
{
	for(new m=0; m<F_MAX_MENUS; m++)
	{
		if(MenuInfo[m][Shown][playerid] == true)
		{
		    TextDrawHideForPlayer(playerid, Text:MenuInfo[m][T_Title]);
			TextDrawBoxColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], 0x00000099);
		    for(new i=0; i<F_MAX_MENU_ROWS; i++)
			{
			    if(i < MenuInfo[m][Rows])
			    {
					TextDrawHideForPlayer(playerid, Text:MenuInfo[m][T_Row][i]);
			    }
			}
		    MenuInfo[m][Shown][playerid] = false;
		}
	}
	if(MenuInfo[menuid][Shown][playerid] == false && MenuInfo[menuid][UsedMenu] == true)
	{
	    TextDrawShowForPlayer(playerid, Text:MenuInfo[menuid][T_Title]);
		TextDrawColor(MenuInfo[menuid][T_Row][0], MenuInfo[menuid][SelectedRowTextColor]);
		TextDrawBackgroundColor(MenuInfo[menuid][T_Row][0], MenuInfo[menuid][SelectedRowBgColor]);
		TextDrawBoxColor(MenuInfo[menuid][T_Row][0], MenuInfo[menuid][SelectedRowBoxColor]);
		for(new i=0; i<F_MAX_MENU_ROWS; i++)
		{
		    if(i < MenuInfo[menuid][Rows])
		    {
				TextDrawShowForPlayer(playerid, Text:MenuInfo[menuid][T_Row][i]);
		    }
		}
	    MenuInfo[menuid][Shown][playerid] = true;
	    MenuInfo[menuid][SelectedRow][playerid] = 0;
    	return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_AddMenuItem(menuid, title[])
{
	if(MenuInfo[menuid][UsedMenu] == true && MenuInfo[menuid][Rows] < F_MAX_MENU_ROWS)
	{
    	MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]] = TextDrawCreate( MenuInfo[menuid][MenuX], floatadd(MenuInfo[menuid][MenuY], floatmul(MenuInfo[menuid][Rows]+1, 13.4)), title);
		TextDrawUseBox(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], 1);
		TextDrawBoxColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], MenuInfo[menuid][ItemBoxColor]);
		TextDrawTextSize(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], MenuInfo[menuid][BoxLength], 0.000000);
		TextDrawBackgroundColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], MenuInfo[menuid][ItemBgColor]);
		TextDrawFont(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], 1);
		TextDrawLetterSize(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], 0.299999, 1.100000);
		TextDrawColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], MenuInfo[menuid][ItemTextColor]);
		TextDrawSetOutline(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], 1);
		TextDrawSetProportional(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], 1);
		TextDrawSetShadow(MenuInfo[menuid][T_Row][MenuInfo[menuid][Rows]], 1);
    	MenuInfo[menuid][Rows] ++;
    	return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuTitleTextColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
		TextDrawColor(MenuInfo[menuid][T_Title], color);
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuTitleBgColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
		TextDrawBackgroundColor(MenuInfo[menuid][T_Title], color);
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuTitleBoxColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
		TextDrawBoxColor(MenuInfo[menuid][T_Title], color);
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuItemTextColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
	    for(new i=0; i<F_MAX_MENU_ROWS; i++)
		{
		    if(i < MenuInfo[menuid][Rows])
		    {
				TextDrawColor(MenuInfo[menuid][T_Row][i], color);
				MenuInfo[menuid][ItemTextColor] = color;
		    }
		}
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuItemBgColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
	    for(new i=0; i<F_MAX_MENU_ROWS; i++)
		{
		    if(i < MenuInfo[menuid][Rows])
		    {
				TextDrawBackgroundColor(MenuInfo[menuid][T_Row][i], color);
				MenuInfo[menuid][ItemBgColor] = color;
		    }
		}
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuItemBoxColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
	    for(new i=0; i<F_MAX_MENU_ROWS; i++)
		{
		    if(i < MenuInfo[menuid][Rows])
		    {
				TextDrawBoxColor(MenuInfo[menuid][T_Row][i], color);
				MenuInfo[menuid][ItemBoxColor] = color;
		    }
		}
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuSelectedItemTextColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
        MenuInfo[menuid][SelectedRowTextColor] = color;
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuSelectedItemBgColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
        MenuInfo[menuid][SelectedRowBgColor] = color;
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_SetMenuSelectedItemBoxColor(menuid, color)
{
    if(MenuInfo[menuid][UsedMenu] == true)
    {
        MenuInfo[menuid][SelectedRowBoxColor] = color;
		return 1;
	}
	return 0;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

stock F_OnPlayerKeyStateChange(playerid, newkeys)
{
    if(newkeys == 65408) //up
    {
		for(new menuid=0; menuid<F_MAX_MENUS; menuid++)
		{
			if(MenuInfo[menuid][Shown][playerid] == true)
			{
				TextDrawColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemTextColor]);
				TextDrawBackgroundColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBgColor]);
				TextDrawBoxColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBoxColor]);
	    		TextDrawHideForPlayer(playerid, Text:MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]]);
				TextDrawShowForPlayer(playerid, Text:MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]]);
			    if(MenuInfo[menuid][SelectedRow][playerid] > 0)
        		{
                    MenuInfo[menuid][SelectedRow][playerid] --;
				}
				else
				{
                    MenuInfo[menuid][SelectedRow][playerid] = MenuInfo[menuid][Rows]-1;
				}
				TextDrawColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowTextColor]);
				TextDrawBackgroundColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowBgColor]);
				TextDrawBoxColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowBoxColor]);
	    		TextDrawHideForPlayer(playerid, Text:MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]]);
				TextDrawShowForPlayer(playerid, Text:MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]]);
				PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
			}
		}
    }
    if(newkeys == 128) //down
    {
		for(new menuid=0; menuid<F_MAX_MENUS; menuid++)
		{
			if(MenuInfo[menuid][Shown][playerid] == true)
			{
				TextDrawColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemTextColor]);
				TextDrawBackgroundColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBgColor]);
				TextDrawBoxColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBoxColor]);
	    		TextDrawHideForPlayer(playerid, Text:MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]]);
				TextDrawShowForPlayer(playerid, Text:MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]]);
			    if(MenuInfo[menuid][SelectedRow][playerid] < MenuInfo[menuid][Rows]-1)
        		{
                    MenuInfo[menuid][SelectedRow][playerid] ++;
				}
				else
				{
                    MenuInfo[menuid][SelectedRow][playerid] = 0;
				}
				TextDrawColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowTextColor]);
				TextDrawBackgroundColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowBgColor]);
				TextDrawBoxColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowBoxColor]);
	    		TextDrawHideForPlayer(playerid, Text:MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]]);
				TextDrawShowForPlayer(playerid, Text:MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]]);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
		}
    }
    if(newkeys == 8) //select
    {
		for(new menuid=0; menuid<F_MAX_MENUS; menuid++)
		{
			if(MenuInfo[menuid][Shown][playerid] == true)
			{
				TextDrawColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemTextColor]);
				TextDrawBackgroundColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBgColor]);
				TextDrawBoxColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBoxColor]);
        		F_HideMenuForPlayer(menuid, playerid);
 		 		CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iii", playerid, menuid, MenuInfo[menuid][SelectedRow][playerid]);
				PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
				return 1;
			}
		}
    }
    if(newkeys == 16) //quit
    {
		for(new menuid=0; menuid<F_MAX_MENUS; menuid++)
		{
			if(MenuInfo[menuid][Shown][playerid] == true)
			{
				TextDrawColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemTextColor]);
				TextDrawBackgroundColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBgColor]);
				TextDrawBoxColor(MenuInfo[menuid][T_Row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBoxColor]);
        		F_HideMenuForPlayer(menuid, playerid);
        		CallRemoteFunction("F_OnPlayerExitedMenu", "ii", playerid, menuid);
				PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
			}
		}
    }
	return 1;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

