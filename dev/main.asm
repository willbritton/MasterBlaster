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
	.globl _init_console
	.globl _Player1Init
	.globl _InitConsole
	.globl _InterruptHandler
	.globl _PSGFrame
	.globl _PSGPlay
	.globl _SMS_setLineCounter
	.globl _SMS_setLineInterruptHandler
	.globl _SMS_getKeysStatus
	.globl _SMS_zeroBGPalette
	.globl _SMS_loadSpritePalette
	.globl _SMS_loadBGPalette
	.globl _SMS_setSpritePaletteColor
	.globl _SMS_copySpritestoSAT
	.globl _SMS_finalizeSprites
	.globl _SMS_addSprite
	.globl _SMS_initSprites
	.globl _SMS_loadPSGaidencompressedTiles
	.globl _SMS_waitForVBlank
	.globl _SMS_setSpriteMode
	.globl _SMS_VDPturnOffFeature
	.globl _SMS_VDPturnOnFeature
	.globl _SMS_init
	.globl _volume_atenuation
	.globl _frame_counter
	.globl _player1_direction
	.globl _player1_current_frame
	.globl _player1_y
	.globl _player1_x
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
;Core\funcs.h:7: void InterruptHandler(void)
;	---------------------------------
; Function InterruptHandler
; ---------------------------------
_InterruptHandler::
;Core\funcs.h:10: }
	ret
;Core\funcs.h:12: void InitConsole(void)
;	---------------------------------
; Function InitConsole
; ---------------------------------
_InitConsole::
;Core\funcs.h:15: SMS_init();
	call	_SMS_init
;Core\funcs.h:18: SMS_getKeysStatus();
	call	_SMS_getKeysStatus
;Core\funcs.h:21: SMS_setLineInterruptHandler(&InterruptHandler);
	ld	hl,#_InterruptHandler
	push	hl
	call	_SMS_setLineInterruptHandler
;Core\funcs.h:22: SMS_setLineCounter (192);
	ld	h,#0xc0
	ex	(sp),hl
	inc	sp
	call	_SMS_setLineCounter
	inc	sp
;Core\funcs.h:23: SMS_enableLineInterrupt();
	ld	hl,#0x0010
	call	_SMS_VDPturnOnFeature
;Core\funcs.h:26: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl,#0x0020
	jp  _SMS_VDPturnOnFeature
;Players/players.h:16: void Player1Init()
;	---------------------------------
; Function Player1Init
; ---------------------------------
_Player1Init::
;Players/players.h:18: player1_direction = LEFT;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x02
;Players/players.h:19: player1_x = 50;
	ld	hl,#_player1_x + 0
	ld	(hl), #0x32
;Players/players.h:20: player1_y = 134;
	ld	hl,#_player1_y + 0
	ld	(hl), #0x86
;Players/players.h:21: player1_current_frame = 0;
	ld	hl,#_player1_current_frame + 0
	ld	(hl), #0x00
	ret
;Players/players.h:24: void Player1Update(unsigned char time)
;	---------------------------------
; Function Player1Update
; ---------------------------------
_Player1Update::
;Players/players.h:26: Player1UpdatePosition();
	call	_Player1UpdatePosition
;Players/players.h:27: Player1UpdateDraw(time);
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_Player1UpdateDraw
	inc	sp
	ret
;Players/players.h:30: void Player1UpdatePosition()
;	---------------------------------
; Function Player1UpdatePosition
; ---------------------------------
_Player1UpdatePosition::
;Players/players.h:32: if(SMS_getKeysStatus() & PORT_A_KEY_UP)
	call	_SMS_getKeysStatus
	bit	0, l
	jr	Z,00104$
;Players/players.h:34: player1_direction = UP;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x00
;Players/players.h:35: player1_y--;
	ld	hl, #_player1_y+0
	dec	(hl)
	jr	00105$
00104$:
;Players/players.h:37: else if(SMS_getKeysStatus() & PORT_A_KEY_DOWN)
	call	_SMS_getKeysStatus
	bit	1, l
	jr	Z,00105$
;Players/players.h:39: player1_direction = DOWN;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x01
;Players/players.h:40: player1_y++;
	ld	hl, #_player1_y+0
	inc	(hl)
00105$:
;Players/players.h:43: if(SMS_getKeysStatus() & PORT_A_KEY_LEFT)
	call	_SMS_getKeysStatus
	bit	2, l
	jr	Z,00109$
;Players/players.h:45: player1_direction = LEFT;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x02
;Players/players.h:46: player1_x--;
	ld	hl, #_player1_x+0
	dec	(hl)
	ret
00109$:
;Players/players.h:48: else if(SMS_getKeysStatus() & PORT_A_KEY_RIGHT)
	call	_SMS_getKeysStatus
	bit	3, l
	ret	Z
;Players/players.h:50: player1_direction = RIGHT;
	ld	hl,#_player1_direction + 0
	ld	(hl), #0x03
;Players/players.h:51: player1_x++;
	ld	hl, #_player1_x+0
	inc	(hl)
	ret
;Players/players.h:55: void Player1UpdateDraw(unsigned char time)
;	---------------------------------
; Function Player1UpdateDraw
; ---------------------------------
_Player1UpdateDraw::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	dec	sp
;Players/players.h:58: unsigned char direction_offset = 0;
	ld	c,#0x00
;Players/players.h:60: if(player1_direction == LEFT)
	ld	a,(#_player1_direction + 0)
	sub	a, #0x02
	jr	NZ,00104$
;Players/players.h:62: direction_offset = PLAYER1_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS >> 1;
	ld	c,#0x06
	jr	00122$
00104$:
;Players/players.h:64: else if(player1_direction == RIGHT)
	ld	a,(#_player1_direction + 0)
;Players/players.h:66: direction_offset = 0;
	sub	a,#0x03
	jr	NZ,00122$
	ld	c,a
;Players/players.h:69: for(j=0; j<3; j++)
00122$:
	ld	-3 (ix),#0x00
	ld	e,#0x00
;Players/players.h:71: for(i=0; i<2; i++) {
00120$:
	ld	a,-3 (ix)
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	-1 (ix),a
	ld	-2 (ix),#0x00
00112$:
;Players/players.h:72: SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_TILES_POSITION + direction_offset + player1_current_frame * PLAYER1_NUMBER_TILES_BY_FRAME + PLAYER1_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a,(#_player1_current_frame + 0)
	add	a, a
	ld	l,a
	add	hl, bc
	add	hl, de
	ld	a,l
	add	a, -2 (ix)
	ld	b,a
	ld	a,(#_player1_y + 0)
	add	a, -1 (ix)
	ld	d,a
	ld	a,-2 (ix)
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
;Players/players.h:71: for(i=0; i<2; i++) {
	inc	-2 (ix)
	ld	a,-2 (ix)
	sub	a, #0x02
	jr	C,00112$
;Players/players.h:69: for(j=0; j<3; j++)
	ld	a,e
	add	a, #0x0c
	ld	e,a
	inc	-3 (ix)
	ld	a,-3 (ix)
	sub	a, #0x03
	jr	C,00120$
;Players/players.h:76: if((time%16) == 0) {
	ld	a,4 (ix)
	and	a, #0x0f
	jr	NZ,00116$
;Players/players.h:77: player1_current_frame++;
	ld	iy,#_player1_current_frame
	inc	0 (iy)
;Players/players.h:78: if(player1_current_frame == PLAYER1_NUMBER_FRAMES) {
	ld	a,0 (iy)
	sub	a, #0x03
	jr	NZ,00116$
;Players/players.h:79: player1_current_frame = 0;
	ld	0 (iy),#0x00
00116$:
	ld	sp, ix
	pop	ix
	ret
;main.c:19: void init_console(void)
;	---------------------------------
; Function init_console
; ---------------------------------
_init_console::
;main.c:21: SMS_init();
	call	_SMS_init
;main.c:22: SMS_displayOff();
	ld	hl,#0x0140
	call	_SMS_VDPturnOffFeature
;main.c:23: SMS_setSpriteMode(SPRITEMODE_NORMAL);
	ld	l,#0x00
	call	_SMS_setSpriteMode
;main.c:24: SMS_zeroBGPalette();
	jp  _SMS_zeroBGPalette
;main.c:27: void loadGraphics2vram(void)
;	---------------------------------
; Function loadGraphics2vram
; ---------------------------------
_loadGraphics2vram::
;main.c:29: SMS_loadBGPalette(backgroundpalette_bin);
	ld	hl,#_backgroundpalette_bin
	call	_SMS_loadBGPalette
;main.c:33: SMS_loadSpritePalette(spritepalette_bin);
	ld	hl,#_spritepalette_bin
	call	_SMS_loadSpritePalette
;main.c:34: SMS_loadPSGaidencompressedTiles (spritetiles_psgcompr,PLAYER1_SPRITE_TILES_POSITION); // Bomberman - move to player?
	ld	hl,#0x0100
	push	hl
	ld	hl,#_spritetiles_psgcompr
	push	hl
	call	_SMS_loadPSGaidencompressedTiles
	pop	af
;main.c:36: SMS_setSpritePaletteColor(0, RGB(0, 0, 0));
	ld	hl, #0x0000
	ex	(sp),hl
	call	_SMS_setSpritePaletteColor
	pop	af
	ret
;main.c:39: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:41: Player1Init();
	call	_Player1Init
;main.c:43: frame_counter = 0;
	ld	hl,#_frame_counter + 0
	ld	(hl), #0x00
;main.c:45: init_console();
	call	_init_console
;main.c:46: loadGraphics2vram();
	call	_loadGraphics2vram
;main.c:47: SMS_displayOn();
	ld	hl,#0x0140
	call	_SMS_VDPturnOnFeature
;main.c:49: PSGPlay(music_psg);
	ld	hl,#_music_psg
	push	hl
	call	_PSGPlay
	pop	af
;main.c:54: while (1)
00106$:
;main.c:56: frame_counter++;
	ld	iy,#_frame_counter
	inc	0 (iy)
;main.c:58: if((frame_counter%64) == 0)
	ld	a,0 (iy)
	and	a, #0x3f
	jr	NZ,00104$
;main.c:60: volume_atenuation++;
	ld	iy,#_volume_atenuation
	inc	0 (iy)
;main.c:61: if(volume_atenuation > 15)
	ld	a,#0x0f
	sub	a, 0 (iy)
	jr	NC,00104$
;main.c:63: volume_atenuation = 0;
	ld	0 (iy),#0x00
00104$:
;main.c:67: SMS_initSprites();
	call	_SMS_initSprites
;main.c:69: Player1Update(frame_counter);
	ld	a,(_frame_counter)
	push	af
	inc	sp
	call	_Player1Update
	inc	sp
;main.c:71: SMS_finalizeSprites();
	call	_SMS_finalizeSprites
;main.c:72: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:74: PSGFrame();
	call	_PSGFrame
;main.c:77: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
	jr	00106$
	.area _CODE
__str_0:
	.ascii "Gary Paluk"
	.db 0x00
__str_1:
	.ascii "Master Blaster"
	.db 0x00
__str_2:
	.ascii "Grab a friend and jump into endless bombastic fun."
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
	.ascii "Grab a friend and jump into endless bombastic fun."
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
