#include "..\..\lib\SMSlib.h"
#include <stdlib.h>

unsigned char MAX_FRAMES = 32;

typedef struct Animation
{
    int mFrames[32];
    unsigned char mMapPosX;
    unsigned char mMapPosY;
    unsigned char mAnimationSpeed;
    unsigned char mCurrentFrame;
    unsigned char mNumFrames;
} Animation;

void DeleteAnimation(Animation *anim)
{
    if(anim != NULL)
        free(anim);
}

void InitAnimation(Animation* anim,
    int frames[],
    unsigned char numFrames,
    unsigned char mapPosX,
    unsigned char mapPosY,
    unsigned char animationSpeed)
{
    anim->mCurrentFrame = 0;
    anim->mNumFrames = numFrames;
    anim->mMapPosX = mapPosX;
    anim->mMapPosY = mapPosY;
    anim->mAnimationSpeed = animationSpeed;

    if(anim->mNumFrames > MAX_FRAMES)
    {
        anim->mNumFrames = MAX_FRAMES;
    }

    for(unsigned char i = 0; i < anim->mNumFrames; i++)
    {
        anim->mFrames[i] = frames[i];
    }
}

Animation* CreateAnimation(
    int frames[],
    unsigned char numFrames,
    unsigned char mapPosX,
    unsigned char mapPosY,
    unsigned char animationSpeed)
{
    struct Animation* anim = malloc(sizeof (struct Animation));

    if (anim == NULL)
        return NULL;

    InitAnimation(anim, frames, numFrames, mapPosX, mapPosY, animationSpeed);

    return anim;
}

void UpdateAnimation(Animation* animation, unsigned char time)
{
    if((time % animation->mAnimationSpeed) == 0)
    {
        animation->mCurrentFrame++;

        if(animation->mCurrentFrame > animation->mNumFrames)
        {
            animation->mCurrentFrame = 0;
        }

        SMS_setTileatXY(animation->mMapPosX, animation->mMapPosX, animation->mFrames[animation->mCurrentFrame]);

        // void SMS_loadTileMapArea (unsigned char x, unsigned char y,  unsigned int *src, unsigned char width, unsigned char height);
    }
}
