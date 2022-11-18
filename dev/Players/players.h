unsigned char player1_x;
unsigned char player1_y;
unsigned char player1_current_frame;
unsigned char player1_direction;

// Player 1
#define PLAYER1_SPRITE_POSITION 256

// Walk up
#define PLAYER1_UP_NUMBER_FRAMES 6
#define PLAYER1_UP_NUMBER_TILES_BY_FRAME 2
#define PLAYER1_UP_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS 12

// Walk down
#define PLAYER1_DOWN_NUMBER_FRAMES 6
#define PLAYER1_DOWN_NUMBER_TILES_BY_FRAME 2
#define PLAYER1_DOWN_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS 12

// Walk left / right
#define PLAYER1_LR_NUMBER_FRAMES 6
#define PLAYER1_LR_NUMBER_TILES_BY_FRAME 2
#define PLAYER1_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS 24

#define UP 0
#define DOWN 1
#define LEFT 2
#define RIGHT 3

void Player1Init()
{
    player1_direction = DOWN;
    player1_x = 128-8;
    player1_y = 96-12;
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
        if(player1_direction != UP)
        {
            SMS_loadTiles(spritetiles_up_bin, PLAYER1_SPRITE_POSITION, 32*6*6);
        }
        player1_direction = UP;
        player1_y--;
    }
    else if(SMS_getKeysStatus() & PORT_A_KEY_DOWN)
    {
        if(player1_direction != DOWN)
        {
            SMS_loadTiles(spritetiles_down_bin, PLAYER1_SPRITE_POSITION, 32*6*6);
        }
        player1_direction = DOWN;
        player1_y++;
    }

    if(SMS_getKeysStatus() & PORT_A_KEY_LEFT)
    {
        if(player1_direction != LEFT && player1_direction != RIGHT)
        {
            SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, 32*6*12);
        }
        player1_direction = LEFT;
        player1_x--;
    }
    else if(SMS_getKeysStatus() & PORT_A_KEY_RIGHT)
    {
        if(player1_direction != LEFT && player1_direction != RIGHT)
        {
            SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, 32*6*12);
        }
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
        direction_offset = PLAYER1_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS >> 1;
    }
    else if(player1_direction == RIGHT)
    {
        direction_offset = 0;
    }
    else if(player1_direction == DOWN)
    {
        direction_offset = 0;
    }
    else if(player1_direction == UP)
    {
        direction_offset = 0;
    }


    if(player1_direction == UP)
    {
        for(j=0; j<3; j++)
        {
            for(i=0; i<2; i++) {
                SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_UP_NUMBER_TILES_BY_FRAME + PLAYER1_UP_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
            }
        }
    }
    else if(player1_direction == DOWN)
    {
        for(j=0; j<3; j++)
        {
            for(i=0; i<2; i++) {
                SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_DOWN_NUMBER_TILES_BY_FRAME + PLAYER1_DOWN_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
            }
        }
    }
    else if(player1_direction == LEFT || player1_direction == RIGHT)
    {
        for(j=0; j<3; j++)
        {
            for(i=0; i<2; i++) {
                SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_LR_NUMBER_TILES_BY_FRAME + PLAYER1_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
            }
        }
    }
    
    if((time%8) == 0) {
        player1_current_frame++;

        if(player1_direction == UP)
        {
            if(player1_current_frame == PLAYER1_UP_NUMBER_FRAMES) {
                player1_current_frame = 0;
            }
        }
        else if(player1_direction == DOWN)
        {
            if(player1_current_frame == PLAYER1_DOWN_NUMBER_FRAMES) {
                player1_current_frame = 0;
            }
        }
        else if(player1_direction == LEFT || player1_direction == RIGHT)
        {
            if(player1_current_frame == PLAYER1_LR_NUMBER_FRAMES) {
                player1_current_frame = 0;
            }
        }
    }
}