#include "..\..\lib\SMSlib.h"
#include <stdlib.h>

unsigned char MAX_FRAMES = 32;

typedef struct Animation
{
    unsigned char mFrames[32];

    unsigned char mMapPosX;
    unsigned char mMapPosY;
    unsigned char mAnimationSpeed;
    unsigned char mCurrentFrame;
    unsigned char mNumFrames;
} Animation;

void DeleteAnimation(Animation *anim)
{
    free(anim);
}

void InitAnimation(Animation* anim,
    unsigned char mapPosX,
    unsigned char mapPosY,
    unsigned char frames[],
    unsigned char animationSpeed)
{
    anim->mAnimationSpeed = animationSpeed;
    anim->mCurrentFrame = 0;

    anim->mMapPosX = mapPosX;
    anim->mMapPosY = mapPosY;

    anim->mNumFrames = sizeof(frames) / sizeof(unsigned char);

    if(anim->mNumFrames > MAX_FRAMES)
    {
        anim->mNumFrames = MAX_FRAMES;
    }

    unsigned char i = 0;
    while(i < anim->mNumFrames)
    {
        anim->mFrames[i] = frames[i];
        i++;
    }
}

Animation* CreateAnimation(unsigned char mapPosX,
    unsigned char mapPosY,
    unsigned char frames[],
    unsigned char animationSpeed)
{
    struct Animation *anim = malloc(sizeof (struct Animation));
    InitAnimation(anim, mapPosX, mapPosY, frames, animationSpeed);

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
    }
}
