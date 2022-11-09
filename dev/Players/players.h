unsigned char player1_x;
unsigned char player1_y;
unsigned char player1_current_frame;
unsigned char player1_direction;

#define PLAYER1_SPRITE_TILES_POSITION 256
#define PLAYER1_NUMBER_FRAMES 3
#define PLAYER1_NUMBER_TILES_BY_FRAME 2
#define PLAYER1_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS 12

#define UP 0
#define DOWN 1
#define LEFT 2
#define RIGHT 3

void Player1Init()
{
    player1_direction = LEFT;
    player1_x = 50;
    player1_y = 134;
    player1_current_frame = 0;
}

void Player1Update(unsigned char time)
{
    Player1UpdatePosition();
    Player1UpdateDraw(time);
}

void Player1UpdatePosition()
{
    if(SMS_getKeysStatus() & PORT_A_KEY_UP)
    {
        player1_direction = UP;
        player1_y--;
    }
    else if(SMS_getKeysStatus() & PORT_A_KEY_DOWN)
    {
        player1_direction = DOWN;
        player1_y++;
    }

    if(SMS_getKeysStatus() & PORT_A_KEY_LEFT)
    {
        player1_direction = LEFT;
        player1_x--;
    }
    else if(SMS_getKeysStatus() & PORT_A_KEY_RIGHT)
    {
        player1_direction = RIGHT;
        player1_x++;
    }
}

void Player1UpdateDraw(unsigned char time)
{
    unsigned char i, j;
    unsigned char direction_offset = 0;

    if(player1_direction == LEFT)
    {
        direction_offset = PLAYER1_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS >> 1;
    }
    else if(player1_direction == RIGHT)
    {
        direction_offset = 0;
    }

    for(j=0; j<3; j++)
    {
        for(i=0; i<2; i++) {
            SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_TILES_POSITION + direction_offset + player1_current_frame * PLAYER1_NUMBER_TILES_BY_FRAME + PLAYER1_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
        }
    }

    if((time%16) == 0) {
        player1_current_frame++;
        if(player1_current_frame == PLAYER1_NUMBER_FRAMES) {
            player1_current_frame = 0;
        }
    }
}