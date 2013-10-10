#if defined _sampbag_included
	#endinput
#endif
#define _sampbag_included
#pragma library lgw
native IsBagFull(bagid);
native AddBagItem(bagid,itemid);
native GetSlotItem(bagid,slot);
native IsItemInBag(bagid,itemid);
native RemoveItem(bagid,itemid);
