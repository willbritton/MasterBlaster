;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___SMS__SDSC_signature
	.globl ___SMS__SDSC_descr
	.globl ___SMS__SDSC_name
	.globl ___SMS__SDSC_author
	.globl ___SMS__SEGA_signature
	.globl _main
	.globl _loadGraphics2vram
	.globl _Player1Init
	.globl _checkgamepause
	.globl _InitConsole
	.globl _InterruptHandler
	.globl _PSGSFXFrame
	.globl _PSGFrame
	.globl _PSGSFXGetStatus
	.globl _PSGPlayNoRepeat
	.globl _PSGPlay
	.globl _SMS_VRAMmemsetW
	.globl _SMS_VRAMmemcpy
	.globl _SMS_setLineCounter
	.globl _SMS_setLineInterruptHandler
	.globl _SMS_resetPauseRequest
	.globl _SMS_queryPauseRequested
	.globl _SMS_getKeysStatus
	.globl _SMS_loadSpritePalette
	.globl _SMS_loadBGPalette
	.globl _SMS_setSpritePaletteColor
	.globl _SMS_setBGPaletteColor
	.globl _SMS_copySpritestoSAT
	.globl _SMS_finalizeSprites
	.globl _SMS_addSprite
	.globl _SMS_initSprites
	.globl _SMS_loadPSGaidencompressedTiles
	.globl _SMS_loadTiles
	.globl _SMS_waitForVBlank
	.globl _SMS_VDPturnOnFeature
	.globl _SMS_init
	.globl _volume_atenuation
	.globl _frame_counter
	.globl _player1_direction
	.globl _player1_current_frame
	.globl _player1_y
	.globl _player1_x
	.globl _gamepause
	.globl _numinterrupts
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot2
	.globl _Player1Update
	.globl _Player1UpdatePosition
	.globl _Player1UpdateDraw
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ROM_bank_to_be_mapped_on_slot2	=	0xffff
_SRAM_bank_to_be_mapped_on_slot2	=	0xfffc
_SMS_SRAM	=	0x8000
_numinterrupts::
	.ds 1
_gamepause::
	.ds 1
_player1_x::
	.ds 1
_player1_y::
	.ds 1
_player1_current_frame::
	.ds 1
_player1_direction::
	.ds 1
_frame_counter::
	.ds 1
_volume_atenuation::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;Core\funcs.h:6: void InterruptHandler(void)
;	---------------------------------
; Function InterruptHandler
; ---------------------------------
_InterruptHandler::
;Core\funcs.h:9: }
	ret
;Core\funcs.h:11: void InitConsole(void)
;	---------------------------------
; Function InitConsole
; ---------------------------------
_InitConsole::
;Core\funcs.h:14: SMS_init();
	call	_SMS_init
;Core\funcs.h:17: SMS_getKeysStatus();
	call	_SMS_getKeysStatus
;Core\funcs.h:20: SMS_setLineInterruptHandler(&InterruptHandler);
	ld	hl,#_InterruptHandler
	push	hl
	call	_SMS_setLineInterruptHandler
;Core\funcs.h:21: SMS_setLineCounter (192);
	ld	h,#0xc0
	ex	(sp),hl
	inc	sp
	call	_SMS_setLineCounter
	inc	sp
;Core\funcs.h:22: SMS_enableLineInterrupt();
	ld	hl,#0x0010
	call	_SMS_VDPturnOnFeature
;Core\funcs.h:25: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl,#0x0020
	jp  _SMS_VDPturnOnFeature
;Core\funcs.h:28: void checkgamepause()
;	---------------------------------
; Function checkgamepause
; ---------------------------------
_checkgamepause::
;Core\funcs.h:30: if(SMS_queryPauseRequested())
	call	_SMS_queryPauseRequested
	bit	0,l
	ret	Z
;Core\funcs.h:32: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
;Core\funcs.h:33: gamepause=1-gamepause;
	ld	hl,#_gamepause
	ld	a,#0x01
	sub	a, (hl)
	ld	(hl),a
;Core\funcs.h:34: if(gamepause==1)
	ld	a,(#_gamepause + 0)
	dec	a
	jr	NZ,00102$
;Core\funcs.h:35: PSGPlayNoRepeat(pause_psg);
	ld	hl,#_pause_psg
	push	hl
	call	_PSGPlayNoRepeat
	pop	af
	ret
00102$:
;Core\funcs.h:37: PSGPlay(music_psg);
	ld	hl,#_music_psg
	push	hl
	call	_PSGPlay
	pop	af
	ret
;Players/players.h:29: void Player1Init()
;	---------------------------------
; Function Player1Init
; ---------------------------------
_Player1Init::
;Players/players.h:31: player1_direction = DOWN;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x01
;Players/players.h:32: player1_x = 128-8;
	ld	hl,#_player1_x + 0
	ld	(hl), #0x78
;Players/players.h:33: player1_y = 96-12;
	ld	hl,#_player1_y + 0
	ld	(hl), #0x54
;Players/players.h:34: player1_current_frame = 0;
	ld	hl,#_player1_current_frame + 0
	ld	(hl), #0x00
	ret
;Players/players.h:37: void Player1Update(unsigned char time)
;	---------------------------------
; Function Player1Update
; ---------------------------------
_Player1Update::
;Players/players.h:39: Player1UpdatePosition();
	call	_Player1UpdatePosition
;Players/players.h:40: Player1UpdateDraw(time);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_Player1UpdateDraw
	inc	sp
	ret
;Players/players.h:43: void Player1UpdatePosition()
;	---------------------------------
; Function Player1UpdatePosition
; ---------------------------------
_Player1UpdatePosition::
;Players/players.h:45: if(SMS_getKeysStatus() & PORT_A_KEY_UP)
	call	_SMS_getKeysStatus
	bit	0, l
	jr	Z,00108$
;Players/players.h:47: if(player1_direction != UP)
	ld	a,(#_player1_direction + 0)
	or	a, a
	jr	Z,00102$
;Players/players.h:49: SMS_loadTiles(spritetiles_up_psgcompr, PLAYER1_SPRITE_POSITION, 32*6*6);
	ld	hl,#0x0480
	push	hl
	ld	hl,#0x0100
	push	hl
	ld	hl,#_spritetiles_up_psgcompr
	push	hl
	call	_SMS_loadTiles
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
00102$:
;Players/players.h:51: player1_direction = UP;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x00
;Players/players.h:52: player1_y--;
	ld	hl, #_player1_y+0
	dec	(hl)
	jr	00109$
00108$:
;Players/players.h:54: else if(SMS_getKeysStatus() & PORT_A_KEY_DOWN)
	call	_SMS_getKeysStatus
	bit	1, l
	jr	Z,00109$
;Players/players.h:56: if(player1_direction != DOWN)
	ld	a,(#_player1_direction + 0)
	dec	a
	jr	Z,00104$
;Players/players.h:58: SMS_loadTiles(spritetiles_down_psgcompr, PLAYER1_SPRITE_POSITION, 32*6*6);
	ld	hl,#0x0480
	push	hl
	ld	hl,#0x0100
	push	hl
	ld	hl,#_spritetiles_down_psgcompr
	push	hl
	call	_SMS_loadTiles
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
00104$:
;Players/players.h:60: player1_direction = DOWN;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x01
;Players/players.h:61: player1_y++;
	ld	hl, #_player1_y+0
	inc	(hl)
00109$:
;Players/players.h:64: if(SMS_getKeysStatus() & PORT_A_KEY_LEFT)
	call	_SMS_getKeysStatus
	bit	2, l
	jr	Z,00119$
;Players/players.h:66: if(player1_direction != LEFT && player1_direction != RIGHT)
	ld	iy,#_player1_direction
	ld	a,0 (iy)
	sub	a, #0x02
	jr	Z,00111$
	ld	a,0 (iy)
	sub	a, #0x03
	jr	Z,00111$
;Players/players.h:68: SMS_loadTiles(spritetiles_lr_psgcompr, PLAYER1_SPRITE_POSITION, 32*6*12);
	ld	hl,#0x0900
	push	hl
	ld	h, #0x01
	push	hl
	ld	hl,#_spritetiles_lr_psgcompr
	push	hl
	call	_SMS_loadTiles
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
00111$:
;Players/players.h:70: player1_direction = LEFT;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x02
;Players/players.h:71: player1_x--;
	ld	hl, #_player1_x+0
	dec	(hl)
	ret
00119$:
;Players/players.h:73: else if(SMS_getKeysStatus() & PORT_A_KEY_RIGHT)
	call	_SMS_getKeysStatus
	bit	3, l
	ret	Z
;Players/players.h:75: if(player1_direction != LEFT && player1_direction != RIGHT)
	ld	iy,#_player1_direction
	ld	a,0 (iy)
	sub	a, #0x02
	jr	Z,00114$
	ld	a,0 (iy)
	sub	a, #0x03
	jr	Z,00114$
;Players/players.h:77: SMS_loadTiles(spritetiles_lr_psgcompr, PLAYER1_SPRITE_POSITION, 32*6*12);
	ld	hl,#0x0900
	push	hl
	ld	h, #0x01
	push	hl
	ld	hl,#_spritetiles_lr_psgcompr
	push	hl
	call	_SMS_loadTiles
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
00114$:
;Players/players.h:79: player1_direction = RIGHT;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x03
;Players/players.h:80: player1_x++;
	ld	hl, #_player1_x+0
	inc	(hl)
	ret
;Players/players.h:84: void Player1UpdateDraw(unsigned char time)
;	---------------------------------
; Function Player1UpdateDraw
; ---------------------------------
_Player1UpdateDraw::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	dec	sp
;Players/players.h:87: unsigned char direction_offset = 0;
	ld	c,#0x00
;Players/players.h:89: if(player1_direction == LEFT)
	ld	a,(#_player1_direction + 0)
	sub	a, #0x02
	jr	NZ,00264$
	ld	a,#0x01
	jr	00265$
00264$:
	xor	a,a
00265$:
	ld	b,a
	or	a, a
	jr	Z,00110$
;Players/players.h:91: direction_offset = PLAYER1_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS >> 1;
	ld	c,#0x0c
	jr	00111$
00110$:
;Players/players.h:93: else if(player1_direction == RIGHT)
	ld	a,(#_player1_direction + 0)
;Players/players.h:95: direction_offset = 0;
	sub	a,#0x03
	jr	NZ,00107$
	ld	c,a
	jr	00111$
00107$:
;Players/players.h:97: else if(player1_direction == DOWN)
	ld	a,(#_player1_direction + 0)
;Players/players.h:99: direction_offset = 0;
	dec	a
	jr	NZ,00104$
	ld	c,a
	jr	00111$
00104$:
;Players/players.h:101: else if(player1_direction == UP)
	ld	a,(#_player1_direction + 0)
;Players/players.h:103: direction_offset = 0;
	or	a,a
	jr	NZ,00111$
	ld	c,a
00111$:
;Players/players.h:107: if(player1_direction == UP)
	ld	a,(#_player1_direction + 0)
	or	a, a
	jr	NZ,00125$
;Players/players.h:109: for(j=0; j<3; j++)
	ld	-5 (ix),#0x00
	ld	-1 (ix),#0x00
;Players/players.h:111: for(i=0; i<2; i++) {
00163$:
	ld	a,-5 (ix)
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	-2 (ix),a
	ld	e,#0x00
00144$:
;Players/players.h:112: SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_UP_NUMBER_TILES_BY_FRAME + PLAYER1_UP_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a,(#_player1_current_frame + 0)
	add	a, a
	ld	l,a
	add	hl, bc
	ld	a,l
	add	a, -1 (ix)
	add	a, e
	ld	-3 (ix),a
	ld	a,(#_player1_y + 0)
	add	a, -2 (ix)
	ld	d,a
	ld	a,e
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	l,a
	ld	a,(#_player1_x + 0)
	add	a, l
	ld	b,a
	push	bc
	push	de
	ld	a,-3 (ix)
	push	af
	inc	sp
	push	de
	inc	sp
	push	bc
	inc	sp
	call	_SMS_addSprite
	pop	af
	inc	sp
	pop	de
	pop	bc
;Players/players.h:111: for(i=0; i<2; i++) {
	inc	e
	ld	a,e
	sub	a, #0x02
	jr	C,00144$
;Players/players.h:109: for(j=0; j<3; j++)
	ld	a,-1 (ix)
	add	a, #0x0c
	ld	-1 (ix),a
	inc	-5 (ix)
	ld	a,-5 (ix)
	sub	a, #0x03
	jr	C,00163$
	jp	00126$
00125$:
;Players/players.h:116: else if(player1_direction == DOWN)
	ld	a,(#_player1_direction + 0)
	dec	a
	jr	NZ,00122$
;Players/players.h:118: for(j=0; j<3; j++)
	ld	-5 (ix),#0x00
	ld	e,#0x00
;Players/players.h:120: for(i=0; i<2; i++) {
00168$:
	ld	a,-5 (ix)
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	-3 (ix),a
	ld	b,#0x00
00148$:
;Players/players.h:121: SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_DOWN_NUMBER_TILES_BY_FRAME + PLAYER1_DOWN_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a,(#_player1_current_frame + 0)
	add	a, a
	ld	l,a
	add	hl, bc
	add	hl, de
	ld	a,l
	add	a, b
	ld	-2 (ix),a
	ld	a,(#_player1_y + 0)
	add	a, -3 (ix)
	ld	d,a
	ld	a,b
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	l,a
	ld	a,(#_player1_x + 0)
	add	a, l
	ld	-1 (ix),a
	push	bc
	push	de
	ld	a,-2 (ix)
	push	af
	inc	sp
	push	de
	inc	sp
	ld	a,-1 (ix)
	push	af
	inc	sp
	call	_SMS_addSprite
	pop	af
	inc	sp
	pop	de
	pop	bc
;Players/players.h:120: for(i=0; i<2; i++) {
	inc	b
	ld	a,b
	sub	a, #0x02
	jr	C,00148$
;Players/players.h:118: for(j=0; j<3; j++)
	ld	a,e
	add	a, #0x0c
	ld	e,a
	inc	-5 (ix)
	ld	a,-5 (ix)
	sub	a, #0x03
	jr	C,00168$
	jr	00126$
00122$:
;Players/players.h:125: else if(player1_direction == LEFT || player1_direction == RIGHT)
	ld	a,b
	or	a, a
	jr	NZ,00175$
	ld	a,(#_player1_direction + 0)
	sub	a, #0x03
	jr	NZ,00126$
;Players/players.h:127: for(j=0; j<3; j++)
00175$:
	ld	-5 (ix),#0x00
	ld	e,#0x00
;Players/players.h:129: for(i=0; i<2; i++) {
00173$:
	ld	a,-5 (ix)
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	-3 (ix),a
	ld	-4 (ix),#0x00
00152$:
;Players/players.h:130: SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_LR_NUMBER_TILES_BY_FRAME + PLAYER1_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a,(#_player1_current_frame + 0)
	add	a, a
	ld	l,a
	add	hl, bc
	add	hl, de
	ld	a,l
	add	a, -4 (ix)
	ld	b,a
	ld	a,(#_player1_y + 0)
	add	a, -3 (ix)
	ld	d,a
	ld	a,-4 (ix)
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	l,a
	ld	a,(#_player1_x + 0)
	add	a, l
	push	bc
	push	de
	ld	c, d
	push	bc
	push	af
	inc	sp
	call	_SMS_addSprite
	pop	af
	inc	sp
	pop	de
	pop	bc
;Players/players.h:129: for(i=0; i<2; i++) {
	inc	-4 (ix)
	ld	a,-4 (ix)
	sub	a, #0x02
	jr	C,00152$
;Players/players.h:127: for(j=0; j<3; j++)
	ld	a,e
	add	a, #0x18
	ld	e,a
	inc	-5 (ix)
	ld	a,-5 (ix)
	sub	a, #0x03
	jr	C,00173$
00126$:
;Players/players.h:135: if((time%8) == 0) {
	ld	a,4 (ix)
	and	a, #0x07
	jr	NZ,00156$
;Players/players.h:136: player1_current_frame++;
	ld	hl, #_player1_current_frame+0
	inc	(hl)
;Players/players.h:138: if(player1_direction == UP)
	ld	a,(#_player1_direction + 0)
	or	a, a
	jr	NZ,00140$
;Players/players.h:140: if(player1_current_frame == PLAYER1_UP_NUMBER_FRAMES) {
	ld	iy,#_player1_current_frame
	ld	a,0 (iy)
	sub	a, #0x06
	jr	NZ,00156$
;Players/players.h:141: player1_current_frame = 0;
	ld	0 (iy),#0x00
	jr	00156$
00140$:
;Players/players.h:144: else if(player1_direction == DOWN)
	ld	a,(#_player1_direction + 0)
	dec	a
	jr	NZ,00137$
;Players/players.h:146: if(player1_current_frame == PLAYER1_DOWN_NUMBER_FRAMES) {
	ld	iy,#_player1_current_frame
	ld	a,0 (iy)
	sub	a, #0x06
	jr	NZ,00156$
;Players/players.h:147: player1_current_frame = 0;
	ld	0 (iy),#0x00
	jr	00156$
00137$:
;Players/players.h:150: else if(player1_direction == LEFT || player1_direction == RIGHT)
	ld	iy,#_player1_direction
	ld	a,0 (iy)
	sub	a, #0x02
	jr	Z,00133$
	ld	a,0 (iy)
	sub	a, #0x03
	jr	NZ,00156$
00133$:
;Players/players.h:152: if(player1_current_frame == PLAYER1_LR_NUMBER_FRAMES) {
	ld	iy,#_player1_current_frame
	ld	a,0 (iy)
	sub	a, #0x06
	jr	NZ,00156$
;Players/players.h:153: player1_current_frame = 0;
	ld	0 (iy),#0x00
00156$:
	ld	sp, ix
	pop	ix
	ret
;main.c:7: void loadGraphics2vram(void)
;	---------------------------------
; Function loadGraphics2vram
; ---------------------------------
_loadGraphics2vram::
;main.c:10: SMS_VRAMmemsetW(0, 0x0000, 0x4000);
	ld	hl,#0x4000
	push	hl
	ld	h, #0x00
	push	hl
	ld	l, #0x00
	push	hl
	call	_SMS_VRAMmemsetW
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;main.c:12: SMS_loadBGPalette(backgroundpalette_bin);
	ld	hl,#_backgroundpalette_bin
	call	_SMS_loadBGPalette
;main.c:13: SMS_loadPSGaidencompressedTiles(backgroundtiles_psgcompr, 0);
	ld	hl,#0x0000
	push	hl
	ld	hl,#_backgroundtiles_psgcompr
	push	hl
	call	_SMS_loadPSGaidencompressedTiles
	pop	af
;main.c:14: SMS_loadTileMap(0,0, backgroundtilemap_bin, backgroundtilemap_bin_size);
	ld	hl, #0x0600
	ex	(sp),hl
	ld	hl,#_backgroundtilemap_bin
	push	hl
	ld	hl,#0x7800
	push	hl
	call	_SMS_VRAMmemcpy
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;main.c:16: SMS_loadSpritePalette(spritepalette_bin);
	ld	hl,#_spritepalette_bin
	call	_SMS_loadSpritePalette
;main.c:17: SMS_loadTiles(spritetiles_down_psgcompr, PLAYER1_SPRITE_POSITION, 32*6*6); 
	ld	hl,#0x0480
	push	hl
	ld	hl,#0x0100
	push	hl
	ld	hl,#_spritetiles_down_psgcompr
	push	hl
	call	_SMS_loadTiles
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;main.c:19: SMS_setSpritePaletteColor(0, RGB(0, 0, 0));
	ld	hl,#0x0000
	push	hl
	call	_SMS_setSpritePaletteColor
;main.c:20: SMS_setBGPaletteColor(0, RGB(0, 2, 3));
	ld	hl, #0x3800
	ex	(sp),hl
	call	_SMS_setBGPaletteColor
	pop	af
	ret
;main.c:23: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:25: frame_counter = 0;
	ld	hl,#_frame_counter + 0
	ld	(hl), #0x00
;main.c:27: Player1Init();
	call	_Player1Init
;main.c:28: InitConsole();
	call	_InitConsole
;main.c:30: loadGraphics2vram();
	call	_loadGraphics2vram
;main.c:31: SMS_displayOn();
	ld	hl,#0x0140
	call	_SMS_VDPturnOnFeature
;main.c:33: PSGPlay(music_psg);
	ld	hl,#_music_psg
	push	hl
	call	_PSGPlay
	pop	af
;main.c:36: while(1)
00111$:
;main.c:39: checkgamepause();
	call	_checkgamepause
;main.c:41: if(gamepause==0)
	ld	a,(#_gamepause + 0)
	or	a, a
	jr	NZ,00108$
;main.c:43: frame_counter++;
	ld	iy,#_frame_counter
	inc	0 (iy)
;main.c:45: if((frame_counter%64) == 0)
	ld	a,0 (iy)
	and	a, #0x3f
	jr	NZ,00104$
;main.c:47: volume_atenuation++;
	ld	iy,#_volume_atenuation
	inc	0 (iy)
;main.c:48: if(volume_atenuation > 15)
	ld	a,#0x0f
	sub	a, 0 (iy)
	jr	NC,00104$
;main.c:50: volume_atenuation = 0;
	ld	0 (iy),#0x00
00104$:
;main.c:54: SMS_initSprites();
	call	_SMS_initSprites
;main.c:56: Player1Update(frame_counter);
	ld	a,(_frame_counter)
	push	af
	inc	sp
	call	_Player1Update
	inc	sp
;main.c:63: SMS_finalizeSprites();
	call	_SMS_finalizeSprites
;main.c:64: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:66: PSGFrame();
	call	_PSGFrame
;main.c:67: PSGSFXFrame();
	call	_PSGSFXFrame
;main.c:69: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
	jr	00111$
00108$:
;main.c:76: PSGFrame();
	call	_PSGFrame
;main.c:78: if(PSGSFXGetStatus())
	call	_PSGSFXGetStatus
	ld	a,l
	or	a, a
	jr	Z,00106$
;main.c:80: PSGSFXFrame();
	call	_PSGSFXFrame
00106$:
;main.c:84: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:87: numinterrupts=0;
	ld	hl,#_numinterrupts + 0
	ld	(hl), #0x00
	jr	00111$
	.area _CODE
__str_0:
	.ascii "Gary Paluk"
	.db 0x00
__str_1:
	.ascii "Master Blaster"
	.db 0x00
__str_2:
	.ascii "Grab a friend and jump into endless bombastic fun!"
	.db 0x00
	.area _INITIALIZER
	.area _CABS (ABS)
	.org 0x7FF0
___SMS__SEGA_signature:
	.db #0x54	; 84	'T'
	.db #0x4d	; 77	'M'
	.db #0x52	; 82	'R'
	.db #0x20	; 32
	.db #0x53	; 83	'S'
	.db #0x45	; 69	'E'
	.db #0x47	; 71	'G'
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x4c	; 76	'L'
	.org 0x7FD5
___SMS__SDSC_author:
	.ascii "Gary Paluk"
	.db 0x00
	.org 0x7FC6
___SMS__SDSC_name:
	.ascii "Master Blaster"
	.db 0x00
	.org 0x7F93
___SMS__SDSC_descr:
	.ascii "Grab a friend and jump into endless bombastic fun!"
	.db 0x00
	.org 0x7FE0
___SMS__SDSC_signature:
	.db #0x53	; 83	'S'
	.db #0x44	; 68	'D'
	.db #0x53	; 83	'S'
	.db #0x43	; 67	'C'
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x07	; 7
	.db #0x22	; 34
	.db #0x20	; 32
	.db #0xd5	; 213
	.db #0x7f	; 127
	.db #0xc6	; 198
	.db #0x7f	; 127
	.db #0x93	; 147
	.db #0x7f	; 127
