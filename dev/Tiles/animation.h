#include <stdlib.h>
#include "../../lib/SMSlib.h"
#include "../Core/defines.h"
#include "frame.h"

unsigned char MAX_FRAMES = 32;

/*
    @param Frame frames[32]
    @param unsigned char mapPosX
    @param unsigned char mapPosY
    @param unsigned char animationSpeed
    @param unsigned char currentFrame
    @param unsigned char numFrames
    @param unsigned char width
    @param unsigned char height
*/
typedef struct Animation
{
    Frame frames[32];
    unsigned char mapPosX;
    unsigned char mapPosY;
    unsigned char animationSpeed;
    unsigned char currentFrame;
    unsigned char numFrames;
    unsigned char width;
    unsigned char height;
} Animation;

void DeleteAnimation(Animation *anim)
{
    if(anim != NULL)
        free(anim);
}

void InitAnimation(Animation* anim,
    Frame frames[],
    unsigned char numFrames,
    unsigned char mapPosX,
    unsigned char mapPosY,
    unsigned char animationSpeed,
    unsigned char width,
    unsigned char height)
{
    anim->currentFrame = 0;
    anim->numFrames = numFrames;
    anim->mapPosX = mapPosX;
    anim->mapPosY = mapPosY;
    anim->animationSpeed = animationSpeed;
    anim->width = width;
    anim->height = height;

    if(anim->numFrames > MAX_FRAMES)
    {
        anim->numFrames = MAX_FRAMES;
    }

    for(unsigned char i = 0; i < anim->numFrames; i++)
    {
        anim->frames[i] = frames[i];
    }
}

void UpdateAnimation(Animation* animation, unsigned char time)
{
    if((time % animation->animationSpeed) == 0)
    {
        animation->currentFrame++;

        if(animation->currentFrame > animation->numFrames)
        {
            animation->currentFrame = 0;
        }

        unsigned int flags = 0;

        if(animation->frames[animation->currentFrame].flipX)
        {
            flags |= TILE_FLIPPED_X;
        }

        if(animation->frames[animation->currentFrame].flipY)
        {
            flags |= TILE_FLIPPED_X;
        }

        if(animation->frames[animation->currentFrame].useSpritePalette)
        {
            flags |= TILE_USE_SPRITE_PALETTE;
        }

        if(animation->frames[animation->currentFrame].priority)
        {
            flags |= TILE_PRIORITY;
        }

        if(animation->height > 1 || animation->width > 1)
        {
            // TODO: add the ability to send a rect of tiles
            // void SMS_loadTileMapArea (unsigned char x, unsigned char y,  unsigned int *src, unsigned char width, unsigned char height);
        }
        else
        {
            SMS_setTileatXY(animation->mapPosX, animation->mapPosX, animation->frames[animation->currentFrame].tileId | flags);
        }
    }
}

Animation* CreateAnimation(
    Frame frames[],
    unsigned char numFrames,
    unsigned char mapPosX,
    unsigned char mapPosY,
    unsigned char animationSpeed,
    unsigned char width,
    unsigned char height)
{
    struct Animation* anim = malloc(sizeof (struct Animation));

    if (anim == NULL)
        return NULL;

    InitAnimation(anim, frames, numFrames, mapPosX, mapPosY, animationSpeed, width, height);

    return anim;
}
