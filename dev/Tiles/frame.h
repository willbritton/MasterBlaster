#include <stdbool.h>

/*
    @param unsigned char tileId
    @param bool flipX
    @param bool flipY
    @param bool useSpritePalette
    @param bool priority
*/
typedef struct Frame
{
    unsigned char tileId;
    bool flipX;
    bool flipY;
    bool useSpritePalette;
    bool priority;
} Frame;
