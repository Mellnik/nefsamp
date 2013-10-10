#if defined _ufunctions_included
  #endinput
#endif

#define _ufunctions_included

#if !defined isnull
	#define isnull(%1) \
				((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

#if !defined NULL
	#define NULL 0
#endif