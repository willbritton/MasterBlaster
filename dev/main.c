#include "main.h"
#include "Players/players.h"

/*
void main (void)
{
  //InitConsole();

  while(1)
	{
    // do nothing
  }
}
*/

unsigned char frame_counter;
unsigned char volume_atenuation;

void init_console(void)
{
  SMS_init();
  SMS_displayOff();
  SMS_setSpriteMode(SPRITEMODE_NORMAL);
  SMS_zeroBGPalette();
}

void loadGraphics2vram(void)
{
  SMS_loadBGPalette(backgroundpalette_bin);
  // SMS_loadPSGaidencompressedTiles(backgroundtiles_psgcompr, 0);
  // SMS_loadTileMap(0,0, backgroundtilemap_bin, backgroundtilemap_bin_size);

  SMS_loadSpritePalette(spritepalette_bin);
  SMS_loadPSGaidencompressedTiles (spritetiles_psgcompr,PLAYER1_SPRITE_TILES_POSITION); // Bomberman - move to player?
  
  SMS_setSpritePaletteColor(0, RGB(0, 0, 0));
}

void main (void)
{
  Player1Init();

  frame_counter = 0;

  init_console();
  loadGraphics2vram();
  SMS_displayOn();

  PSGPlay(music_psg);
  // PSGSFXPlay(fx_psg, 0x01|0x02);


  // main game loop
  while (1)
  {
    frame_counter++;

    if((frame_counter%64) == 0)
    {
      volume_atenuation++;
      if(volume_atenuation > 15)
      {
        volume_atenuation = 0;
      }
    }

    SMS_initSprites();
    
    Player1Update(frame_counter);

    SMS_finalizeSprites();
    SMS_waitForVBlank();

    PSGFrame();
    // PSGSFXFrame();

    SMS_copySpritestoSAT();
    // SMS_setBGScrollX(scroll_x);
    // SMS_setBGScrollY(scroll_y);
  }
}

SMS_EMBED_SEGA_ROM_HEADER(9999, 0);
SMS_EMBED_SDSC_HEADER(1, 0, 2022, 7, 11, "Gary Paluk", "Master Blaster", "Grab a friend and jump into endless bombastic fun.");
