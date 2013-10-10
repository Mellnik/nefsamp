/*
    SA-MP "rBits" Include
    Copyright © 2011 RyDeR`
*/

#if defined _Included_rBits
    #endinput
#endif

#define _Included_rBits

#define BIT_TAGS \
    { rBit1, rBit2, rBit4, rBit8, rBit16 }

enum e_Bits
{
    rBit1,
    rBit2,
    rBit4,
    rBit8,
    rBit16,
    rBit32
};

#define rBit1:%0<%1> \
    rBit1: %0[((%1) + 31) >>> _: rBit32]

#define rBit1_Set(%0,%1,%2) \
    rBit_Set(%0, (%1), (%2), rBit1)

#define rBit1_Get(%0,%1) \
    rBit_Get(%0, (%1), rBit1)

#define rBit2:%0<%1> \
    rBit2: %0[((%1) + 15) >>> _: (rBit32 - rBit2)]

#define rBit2_Set(%0,%1,%2) \
    rBit_Set(%0, (%1), (%2), rBit2)

#define rBit2_Get(%0,%1) \
    rBit_Get(%0, (%1), rBit2)

#define rBit4:%0<%1> \
    rBit4: %0[((%1) + 7) >>> _: (rBit32 - rBit4)]

#define rBit4_Set(%0,%1,%2) \
    rBit_Set(%0, (%1), (%2), rBit4)

#define rBit4_Get(%0,%1) \
    rBit_Get(%0, (%1), rBit4)

#define rBit8:%0<%1> \
    rBit8: %0[(%1) char]

#define rBit8_Set(%0,%1,%2) \
    (_: %0{(%1)} = (%2))

#define rBit8_Get(%0,%1) \
    (_: %0{(%1)})

#define rBit16:%0<%1> \
    rBit16: %0[((%1) + 1) >>> _: (rBit32 - rBit16)]

#define rBit16_Set(%0,%1,%2) \
    rBit_Set(%0, (%1), (%2), rBit16)

#define rBit16_Get(%0,%1) \
    rBit_Get(%0, (%1), rBit16)

stock rBit_Set(BIT_TAGS: bitArr[], arrIdx, value, e_Bits: bitShift, arrSize = sizeof(bitArr))
{
    new bitVar = ((arrIdx & ((1 << _: (rBit32 - bitShift)) - 1)) << _: bitShift), bitLim = ((1 << (1 << _: bitShift)) - 1);
    if(!(0 <= (arrIdx >>>= _: (rBit32 - bitShift)) < arrSize)) return 0;
    (_: bitArr[arrIdx]) &= ~(bitLim << bitVar);
    (_: bitArr[arrIdx]) |= ((bitLim & value) << bitVar);

    return 1;
}

stock rBit_Get(BIT_TAGS: bitArr[], arrIdx, e_Bits: bitShift, arrSize = sizeof(bitArr))
{
    new bitVar = ((arrIdx & ((1 << _: (rBit32 - bitShift)) - 1)) << _: bitShift), bitLim = ((1 << (1 << _: bitShift)) - 1);
    if(!(0 <= (arrIdx >>>= _: (rBit32 - bitShift)) < arrSize)) return 0;
    return ((_: bitArr[arrIdx] >>> bitVar) & bitLim);
}
