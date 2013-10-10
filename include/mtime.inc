//============ mtime - https://github.com/Mellnik/samp-plugin-mtime ============
// File: mtime.inc
// Author(s): Mellnik
//
// License: See LICENSE in root directory
//==============================================================================

#if defined _mtime_included
  #endinput
#endif
#define _mtime_included

enum
{
	DATE_LITTLEENDIAN,
	DATE_BIGENDIAN,
	DATE_MIDDLEENDIAN
}

enum
{
	CLOCK_EUROPEAN,
	CLOCK_AMERICAN
}

native mtime_UnixToDate(dest[], unixseconds, date = DATE_LITTLEENDIAN, timeformat = CLOCK_EUROPEAN, len = sizeof(dest));
native mtime_ToRegularTime(dest[], msecs, bool:use_hrs = true, len = sizeof(dest));
native mtime_GetLocalTime(dest[], date = DATE_LITTLEENDIAN, timeformat = CLOCK_EUROPEAN, len = sizeof(dest));
native mtime_GetServerUptime();

// EOF