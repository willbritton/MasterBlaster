#include "main.h"
#include "Players/players.h"

unsigned char frame_counter;
unsigned char volume_atenuation;

void loadGraphics2vram(void)
{
  /* Clear VRAM */
  SMS_VRAMmemsetW(0, 0x0000, 0x4000);

  //SMS_loadBGPalette(backgroundpalette_bin);
  //SMS_loadPSGaidencompressedTiles(backgroundtiles_psgcompr, 0);
  //SMS_loadTileMap(0,0, backgroundtilemap_bin, backgroundtilemap_bin_size);

  SMS_loadSpritePalette(spritepalette_bin);
  SMS_loadPSGaidencompressedTiles(spritetiles_psgcompr, PLAYER1_SPRITE_TILES_POSITION); // Bomberman - move to player?
  
  SMS_setSpritePaletteColor(0, RGB(0, 0, 0));
  SMS_setBGPaletteColor(0, RGB(0, 0, 0));
}

void main (void)
{
  frame_counter = 0;

  Player1Init();
  InitConsole();
  
  loadGraphics2vram();
  SMS_displayOn();

  PSGPlay(music_psg);

  // main game loop
  while(1)
  {
    // Check for game pause
		checkgamepause();

    if(gamepause==0)
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

      if(SMS_getKeysStatus() & PORT_A_KEY_1)
      {
        PSGSFXPlay(enemybomb_psg, 0x00);
      }

      SMS_finalizeSprites();
      SMS_waitForVBlank();

      PSGFrame();
      PSGSFXFrame();

      SMS_copySpritestoSAT();
      // SMS_setBGScrollX(scroll_x);
      // SMS_setBGScrollY(scroll_y);
    }
    else
    {
      // Update psg
			PSGFrame();

      if(PSGSFXGetStatus())
      {
        PSGSFXFrame();
      }

			// Wait
			SMS_waitForVBlank();
		
			// Reset
			numinterrupts=0;
    }
  }
}

SMS_EMBED_SEGA_ROM_HEADER(9999, 0);
SMS_EMBED_SDSC_HEADER(1, 0, 2022, 7, 11, "Gary Paluk", "Master Blaster", "Grab a friend and jump into endless bombastic fun!");
