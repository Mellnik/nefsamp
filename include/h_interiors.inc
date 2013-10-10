/*
	h_interiors 1.0, 31.07.2011, by Hauke Marquardt alias |-|auke

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
#define NULL -1
#define YES 1
#define NO 0
#define METHOD_KEY 0
#define METHOD_PICKUP 1

forward OnPlayerEnterInterior ( playerid , interior , method );
forward OnPlayerLeaveInterior ( playerid , interior , method );
forward OnPlayerEnteredInterior ( playerid , interior , method );
forward OnPlayerLeavedInterior ( playerid , interior , method );

stock AddInterior ( iM[ ] , iVW , iI , Float:iX , Float:iY , Float:iZ , Float:iA , iPT , iPM , iG , iAK , oM[ ] , oVW , oI , Float:oX , Float:oY , Float:oZ , Float:oA , oPT , oPM , oG , oAK )
    return CallRemoteFunction ( "__AddInterior" , "sddffffddddsddffffdddd" , iM , iVW , iI , iX , iY , iZ , iA , iPT , iPM , iG , iAK , oM , oVW , oI , oX , oY , oZ , oA , oPT , oPM , oG , oAK);

stock RemoveInterior ( interior )
	return CallRemoteFunction ( "__RemoveInterior" , "d" , interior );
