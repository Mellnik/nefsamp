// WBB_Connect 2.0 include by Hauke Marquardt alias |-|auke - 19.05.2012
/*
License:
        This code is free: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This code is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program.  If not, see <http://www.gnu.org/licenses/>.
        You´re not allowed to copy any code from this, into your code without
        naming authors name in credits!
*/
#if defined _wbb_connect_included
    #endinput
#endif

#define _wbb_connect_included

#define THREAD_STATE_NORMAL					0
#define THREAD_STATE_IMPORTANT				1
#define THREAD_STATE_ANNOUNCEMENT			2

#if !defined _h_library_norm_included
    #define PAWN_TYPE_INT                   1
    #define PAWN_TYPE_FLOAT                 2
    #define PAWN_TYPE_ARRAY                 3
    #define _h_library_norm_included
#endif

forward WBB_GotPostUser ( Index , Username[ ] );
forward WBB_GotThreadStarter ( Index , Username[ ] );
forward WBB_GotUserActivationCode ( Index , ActivationCode[ ] );
forward WBB_GotUserActivationState ( Index , State );
forward WBB_GotUserAge ( Index , Age );
forward WBB_GotUserFriendState ( Index , State );
forward WBB_GotUserGroupState ( Index , State );
forward WBB_GotUserID ( Index , UserID );
forward WBB_GotUserOnlineState ( Index , State );
forward WBB_GotUserPasswordCheckState ( Index , State );
forward WBB_GotUserTitle ( Index , Title[ ] );
forward WBB_GotUserValidState ( Index , State );
forward WBB_OnInitialize ( State );
forward WBB_PostAdded ( Index );
forward WBB_PostDeleted ( Index );
forward WBB_PostEdited ( Index );
forward WBB_PostTrashed ( Index );
forward WBB_ThreadAdded ( Index , ThreadID );
forward WBB_ThreadDeleted ( Index );
forward WBB_ThreadSticked ( Index );
forward WBB_ThreadUnsticked ( Index );
forward WBB_UserAdded ( Index );
forward WBB_UserAvatarDisabled ( Index );
forward WBB_UserAvatarEnabled ( Index );
forward WBB_UserBanned ( Index );
forward WBB_UserDisabled ( Index );
forward WBB_UserEnabled ( Index );
forward WBB_UserRemovedFromGroup ( Index );
forward WBB_UserSettedToGroup ( Index );
forward WBB_UserSignaturDisabled ( Index );
forward WBB_UserSignaturEnabled ( Index );
forward WBB_UserUnbanned ( Index );

stock WBB_Initialize ( Adress[ ] , AuthKey[ ] )
	return CallRemoteFunction ( "_WBB_Initialize" , "ss" , Adress , AuthKey );

stock WBB_AddPost ( Username[ ] , Thread , Subject[ ] , Content[ ] , Closed = 0 , Smilies = 1 , HTML = 0 , BBCodes = 1 , Signature = 1 , Index = 0 )
    return CallRemoteFunction ( "_WBB_AddPost" , "sdssdddddd" , Username , Thread , Subject , Content , Closed , Smilies , HTML , BBCodes , Signature , Index );

stock WBB_AddThread ( Username[ ] , Board , Prefix[ ] , Subject[ ] , Content[ ] , State = THREAD_STATE_NORMAL , Closed = 0 , Disabled = 0 , Smilies = 1 , HTML = 0 , BBCodes = 1 , Signature = 1 , Index = 0 )
    return CallRemoteFunction ( "_WBB_AddThread" , "sdsssdddddddd" , Username , Board , Prefix , Subject , Content , State , Closed , Disabled , Smilies , HTML , BBCodes , Signature , Index );

stock WBB_AddUser ( Username[ ] , Email[ ] , Password[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_AddUser" , "sssd" , Username , Email , Password , Index );

stock WBB_BanUser ( Username[ ] , Reason[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_BanUser" , "ssd" , Username , Reason , Index );

stock WBB_CheckUserPassword ( Username[ ] , Password[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_CheckUserPassword" , "ssd" , Username , Password , Index );

stock WBB_DeletePost ( Post , Index = 0 )
    return CallRemoteFunction ( "_WBB_DeletePost" , "dd" , Post , Index );

stock WBB_DeleteThread ( ThreadID , Index = 0 )
    return CallRemoteFunction ( "_WBB_DeleteThread" , "dd" , ThreadID , Index );

stock WBB_DisableUser ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_DisableUser" , "sd" , Username , Index );

stock WBB_DisableUserAvatar ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_DisableUserAvatar" , "sd" , Username , Index );

stock WBB_DisableUserSignatur ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_DisableUserSignatur" , "sd" , Username , Index );

stock WBB_EditPost ( Username[ ] , Post , Subject[ ] , Content[ ] , ShowEditInformation , EditReason[ ] , Smilies = 1 , HTML = 0 , BBCodes = 1 , Signature = 1 , Index = 0 )
    return CallRemoteFunction ( "_WBB_EditPost" , "sdssdsddddd" , Username , Post , Subject , Content , ShowEditInformation , EditReason , Smilies , HTML , BBCodes , Signature , Index );

stock WBB_EnableUser ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_EnableUser" , "sd" , Username , Index );

stock WBB_EnableUserAvatar ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_EnableUserAvatar" , "sd" , Username , Index );

stock WBB_EnableUserSignatur ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_EnableUserSignatur" , "sd" , Username , Index );

stock WBB_GetPostUser ( Post , Index = 0 )
    return CallRemoteFunction ( "_WBB_GetPostUser" , "dd" , Post , Index );

stock WBB_GetThreadUser ( Thread , Index = 0 )
    return CallRemoteFunction ( "_WBB_GetThreadUser" , "dd" , Thread , Index );

stock WBB_GetUserActivationCode ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_GetUserActivationCode" , "sd" , Username , Index );

stock WBB_GetUserAge ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_GetUserAge" , "sd" , Username , Index );

stock WBB_GetUserID ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_GetUserID" , "sd" , Username , Index );

stock WBB_GetUserTitle ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_GetUserTitle" , "sd" , Username , Index );

stock WBB_IsUserActivated ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_IsUserActivated" , "sd" , Username , Index );

stock WBB_IsUserFriendOfUser ( Username[ ] , Friend[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_IsUserFriendOfUser" , "ssd" , Username , Friend , Index );

stock WBB_IsUserInGroup ( Username[ ] , Group , Index = 0 )
    return CallRemoteFunction ( "_WBB_IsUserInGroup" , "sdd" , Username , Group , Index );

stock WBB_IsUserOnline ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_IsUserOnline" , "sd" , Username , Index );

stock WBB_IsValidUser ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_IsValidUser" , "sd" , Username , Index );

stock WBB_RemoveUserFromGroup ( Username[ ] , Group , Index = 0 )
    return CallRemoteFunction ( "_WBB_RemoveUserFromGroup" , "sdd" , Username , Group , Index );

stock WBB_SetUserToGroup ( Username[ ] , Group , Index = 0 )
    return CallRemoteFunction ( "_WBB_SetUserToGroup" , "sdd" , Username , Group , Index );

stock WBB_StickThread ( ThreadID , Index = 0 )
    return CallRemoteFunction ( "_WBB_StickThread" , "dd" , ThreadID , Index );

stock WBB_TrashPost ( Post , Index = 0 )
    return CallRemoteFunction ( "_WBB_TrashPost" , "dd" , Post , Index );

stock WBB_TrashThread ( ThreadID , Index = 0 )
    return CallRemoteFunction ( "_WBB_TrashThread" , "dd" , ThreadID , Index  );

stock WBB_UnBanUser ( Username[ ] , Index = 0 )
    return CallRemoteFunction ( "_WBB_UnBanUser" , "sd" , Username , Index );

stock WBB_UnstickThread ( ThreadID , Index = 0 )
    return CallRemoteFunction ( "_WBB_UnstickThread" , "dd" , ThreadID , Index );
