#include "..\..\lib\SMSlib.h"

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

Animation* CreateAnimation()
{
    Animation anim;
    return &anim;
}

void DisposeAnimation(Animation* anim)
{
    delete &anim;
}

void InitAnimation(Animation* anim,
    unsigned char mapPosX,
    unsigned char mapPosY,
    unsigned char frames[],
    unsigned char animationSpeed)
{
    // As soon as I touch these, things blow up
    // anim->mMapPosX = 2;
    // anim->mMapPosY = 2;
    // anim->mAnimationSpeed = 1;



    /*
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
    */
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
