/*
 * Copyright (C) 2013 Mellnik
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
#if defined _FAQ_H_
  #endinput
#endif
#define _FAQ_H_

#include <a_samp>
#include <YSI\y_iterate>
#include <YSI\y_hooks>

enum E_FAQ_SETTING
{
	e_FAQ_SETTING_DEBUG,
	e_FAQ_SETTING_DIALOG_ID
}

#define MAX_DIALOG_STRING       (2048)
#define MAX_CATEGORYS           (10)
#define MAX_CETEGORY_ITEMS      (25)
#define FAQ_BASE_DIALOG         (30000)
#define INVALID_CATEGORY_ID     (~(0))
#define INVALID_ITEM_ID         (~(0))
#define INVALID_SETTING         (~(0))

new stock
	Iterator:Iter_FAQ_Categorys<MAX_CATEGORYS>,
	a_FAQ_Categorys[421],
	a_FAQ_Items[MAX_CATEGORYS][MAX_DIALOG_STRING],
	a_FAQ_Setting[E_FAQ_SETTING],
	a_FAQ_CategoryIdx[MAX_CATEGORYS],
	a_FAQ_CategoryItemIdx[MAX_CATEGORYS][MAX_CETEGORY_ITEMS];

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case FAQ_BASE_DIALOG .. FAQ_BASE_DIALOG + 10:
        {
			if(response)
			{
				Internal_PushInput(playerid, dialogid, listitem);
			}
			else
			{
			    FAQ_Display(playerid);
			}
		}
	}
	return 1;
}

/*------------------------------------------------------------------------------
Function: FAQ_Setting
Parameters: setting, value
Returns: 1 on success, 0 on failure
Description: FAQ Settings
------------------------------------------------------------------------------*/

stock FAQ_Setting(setting, value)
{
	return 1;
}

/*------------------------------------------------------------------------------
Function: FAQ_Display
Parameters: playerid
Returns: -
Description: Show the FAQ to a player
------------------------------------------------------------------------------*/

stock FAQ_Display(playerid)
{
	ShowPlayerDialog(playerid, FAQ_BASE_DIALOG, DIALOG_STYLE_LIST, "FAQ", a_FAQ_Categorys, "Select", "Cancel");
	return 1;
}

/*------------------------------------------------------------------------------
Function: FAQ_Hide
Parameters: playerid
Returns: -
Description: Hide the FAQ from a player
------------------------------------------------------------------------------*/

stock FAQ_Hide(playerid)
{
	ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "Close", "Close", "Close", "Close");
	return 1;
}

/*------------------------------------------------------------------------------
Function: FAQ_AddCategory
Parameters: category_name[], len
Returns: new category index, INVALID_CATEGORY_ID on failure
Description: Add a category to the FAQ
------------------------------------------------------------------------------*/

stock FAQ_AddCategory(const category_name[], len = sizeof(category_name))
{
	if(len == 1)
	{
        printf("[FAQ] Possible multidimensional array error @ %s define len by yourself", category_name);
	}
	
	if(len > 37)
	{
		printf("[FAQ] Category name length exceeds maximum if 37 @ %s", category_name);
		return INVALID_CATEGORY_ID;
	}
	
	new free = Internal_GetFreeCategory();
		
	if(free == INVALID_CATEGORY_ID)
	{
	    printf("[FAQ] No free category @ %s", category_name);
	    return INVALID_CATEGORY_ID;
	}

	new tmp[42];
	format(tmp, sizeof(tmp), "%i. %s\n", a_FAQ_CategoryIdx[free], category_name);
	strcat(a_FAQ_Categorys, tmp, 37);

	Iter_Add(Iter_FAQ_Categorys, free);
	return free;
}

/*------------------------------------------------------------------------------
Function: FAQ_RemoveCategory
Parameters: category_idx
Returns: 1 on success, 0 on failure
Description: Add a category to the FAQ
------------------------------------------------------------------------------*/

stock FAQ_RemoveCategory(category_idx)
{

}

/*------------------------------------------------------------------------------
Function: FAQ_AddItem
Parameters: category_idx, faq[], question[], answer[], description[]
Returns: new category index, 0 on failure
Description: Add a category to the FAQ
------------------------------------------------------------------------------*/

stock FAQ_AddItem(category_idx, const faq[], const question[], const answer[], const description[])
{

}

stock Internal_GetFreeCategory()
{
	for(new i = 0; i < MAX_CATEGORYS; ++i)
	{
	    if(Iter_Contains(Iter_FAQ_Categorys, i)) continue;
		return i;
	}
	return INVALID_CATEGORY_ID;
}

stock Internal_GetFreeCategoryItem(category)
{
	for(new i = 0; i < MAX_CETEGORY_ITEMS; ++i)
	{
	    if(Iter_Contains(Iter_FAQ_Items[category], i)) continue;
		return i;
	}
	return INVALID_ITEM_ID;
}

Internal_PushInput(playerid, dialogid, listitem)
{
	return 1;
}

