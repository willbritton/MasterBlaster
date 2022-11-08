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
	.globl _draw_main_character
	.globl _loadGraphics2vram
	.globl _init_console
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
	.globl _current_frame
	.globl _player_y
	.globl _player_x
	.globl _numinterrupts
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot2
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
_player_x::
	.ds 1
_player_y::
	.ds 1
_current_frame::
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
;.\Core\funcs.h:2: void InterruptHandler(void)
;	---------------------------------
; Function InterruptHandler
; ---------------------------------
_InterruptHandler::
;.\Core\funcs.h:5: }
	ret
;.\Core\funcs.h:7: void InitConsole()
;	---------------------------------
; Function InitConsole
; ---------------------------------
_InitConsole::
;.\Core\funcs.h:10: SMS_init();
	call	_SMS_init
;.\Core\funcs.h:13: SMS_getKeysStatus();
	call	_SMS_getKeysStatus
;.\Core\funcs.h:16: SMS_setLineInterruptHandler(&InterruptHandler);
	ld	hl,#_InterruptHandler
	push	hl
	call	_SMS_setLineInterruptHandler
;.\Core\funcs.h:17: SMS_setLineCounter (192);
	ld	h,#0xc0
	ex	(sp),hl
	inc	sp
	call	_SMS_setLineCounter
	inc	sp
;.\Core\funcs.h:18: SMS_enableLineInterrupt();
	ld	hl,#0x0010
	call	_SMS_VDPturnOnFeature
;.\Core\funcs.h:21: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl,#0x0020
	jp  _SMS_VDPturnOnFeature
;main.c:27: void init_console(void)
;	---------------------------------
; Function init_console
; ---------------------------------
_init_console::
;main.c:29: SMS_init();
	call	_SMS_init
;main.c:30: SMS_displayOff();
	ld	hl,#0x0140
	call	_SMS_VDPturnOffFeature
;main.c:31: SMS_setSpriteMode(SPRITEMODE_NORMAL);
	ld	l,#0x00
	call	_SMS_setSpriteMode
;main.c:32: SMS_zeroBGPalette();
	jp  _SMS_zeroBGPalette
;main.c:35: void loadGraphics2vram(void)
;	---------------------------------
; Function loadGraphics2vram
; ---------------------------------
_loadGraphics2vram::
;main.c:37: SMS_loadBGPalette(backgroundpalette_bin);
	ld	hl,#_backgroundpalette_bin
	call	_SMS_loadBGPalette
;main.c:41: SMS_loadSpritePalette(spritepalette_bin);
	ld	hl,#_spritepalette_bin
	call	_SMS_loadSpritePalette
;main.c:42: SMS_loadPSGaidencompressedTiles (spritetiles_psgcompr,SPRITE_TILES_POSITION);
	ld	hl,#0x0100
	push	hl
	ld	hl,#_spritetiles_psgcompr
	push	hl
	call	_SMS_loadPSGaidencompressedTiles
	pop	af
;main.c:44: SMS_setSpritePaletteColor(0, RGB(0, 0, 0));
	ld	hl, #0x0000
	ex	(sp),hl
	call	_SMS_setSpritePaletteColor
	pop	af
	ret
;main.c:47: void draw_main_character(void)
;	---------------------------------
; Function draw_main_character
; ---------------------------------
_draw_main_character::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;main.c:52: for(j=0; j<3; j++)
	ld	-2 (ix),#0x00
	ld	c,#0x00
;main.c:54: for(i=0; i<2; i++) {
00113$:
	ld	a,-2 (ix)
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	-1 (ix),a
	ld	e,#0x00
00107$:
;main.c:55: SMS_addSprite(player_x+(i<<3), player_y+(j<<3), SPRITE_TILES_POSITION + direction_offset + current_frame * NUMBER_TILES_BY_FRAME + NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a,(#_current_frame + 0)
	add	a, a
	ld	l,a
	add	hl, bc
	ld	a,l
	add	a, e
	ld	b,a
	ld	a,(#_player_y + 0)
	add	a, -1 (ix)
	ld	d,a
	ld	a,e
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	l,a
	ld	a,(#_player_x + 0)
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
;main.c:54: for(i=0; i<2; i++) {
	inc	e
	ld	a,e
	sub	a, #0x02
	jr	C,00107$
;main.c:52: for(j=0; j<3; j++)
	ld	a,c
	add	a, #0x0c
	ld	c,a
	inc	-2 (ix)
	ld	a,-2 (ix)
	sub	a, #0x03
	jr	C,00113$
;main.c:59: if((frame_counter%16) == 0) {
	ld	a,(#_frame_counter + 0)
	and	a, #0x0f
	jr	NZ,00111$
;main.c:60: current_frame++;
	ld	iy,#_current_frame
	inc	0 (iy)
;main.c:61: if(current_frame == NUMBER_FRAMES) {
	ld	a,0 (iy)
	sub	a, #0x03
	jr	NZ,00111$
;main.c:62: current_frame = 0;
	ld	0 (iy),#0x00
00111$:
	ld	sp, ix
	pop	ix
	ret
;main.c:67: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:69: player_x = 0;
	ld	hl,#_player_x + 0
	ld	(hl), #0x00
;main.c:70: player_y = 134;
	ld	hl,#_player_y + 0
	ld	(hl), #0x86
;main.c:71: current_frame = 0;
	ld	hl,#_current_frame + 0
	ld	(hl), #0x00
;main.c:72: frame_counter = 0;
	ld	hl,#_frame_counter + 0
	ld	(hl), #0x00
;main.c:74: init_console();
	call	_init_console
;main.c:75: loadGraphics2vram();
	call	_loadGraphics2vram
;main.c:76: SMS_displayOn();
	ld	hl,#0x0140
	call	_SMS_VDPturnOnFeature
;main.c:78: PSGPlay(music_psg);
	ld	hl,#_music_psg
	push	hl
	call	_PSGPlay
	pop	af
;main.c:83: while (1)
00108$:
;main.c:85: frame_counter++;
	ld	iy,#_frame_counter
	inc	0 (iy)
;main.c:87: if((frame_counter%64) == 0)
	ld	a,0 (iy)
	and	a, #0x3f
	jr	NZ,00104$
;main.c:89: volume_atenuation++;
	ld	iy,#_volume_atenuation
	inc	0 (iy)
;main.c:90: if(volume_atenuation > 15)
	ld	a,#0x0f
	sub	a, 0 (iy)
	jr	NC,00104$
;main.c:92: volume_atenuation = 0;
	ld	0 (iy),#0x00
00104$:
;main.c:96: SMS_initSprites();
	call	_SMS_initSprites
;main.c:97: if(SMS_getKeysStatus() & PORT_A_KEY_1)
	call	_SMS_getKeysStatus
	bit	4, l
	jr	Z,00106$
;main.c:99: draw_main_character();
	call	_draw_main_character
00106$:
;main.c:102: SMS_finalizeSprites();
	call	_SMS_finalizeSprites
;main.c:103: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:105: PSGFrame();
	call	_PSGFrame
;main.c:108: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
	jr	00108$
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
