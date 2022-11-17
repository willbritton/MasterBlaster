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
	.globl _PSGSFXPlay
	.globl _PSGPlayNoRepeat
	.globl _PSGPlay
	.globl _SMS_VRAMmemsetW
	.globl _SMS_setLineCounter
	.globl _SMS_setLineInterruptHandler
	.globl _SMS_resetPauseRequest
	.globl _SMS_queryPauseRequested
	.globl _SMS_getKeysStatus
	.globl _SMS_loadSpritePalette
	.globl _SMS_setSpritePaletteColor
	.globl _SMS_setBGPaletteColor
	.globl _SMS_copySpritestoSAT
	.globl _SMS_finalizeSprites
	.globl _SMS_addSprite
	.globl _SMS_initSprites
	.globl _SMS_loadPSGaidencompressedTiles
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
;Players/players.h:69: for(j=0; j<3; j++)
	ld	-2 (ix),#0x00
	ld	c,#0x00
;Players/players.h:71: for(i=0; i<2; i++) {
00120$:
	ld	a,-2 (ix)
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	-1 (ix),a
	ld	e,#0x00
00112$:
;Players/players.h:72: SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_TILES_POSITION + player1_direction + player1_current_frame * PLAYER1_NUMBER_FRAMES + PLAYER1_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a,(#_player1_current_frame + 0)
	rlca
	rlca
	rlca
	and	a,#0xf8
	ld	b,a
	ld	a,(#_player1_direction + 0)
	add	a, b
	ld	l,a
	add	hl, bc
	ld	a,l
	add	a, e
	ld	b,a
	ld	a,(#_player1_y + 0)
	add	a, -1 (ix)
	ld	d,a
	ld	a,e
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
	inc	e
	ld	a,e
	sub	a, #0x02
	jr	C,00112$
;Players/players.h:69: for(j=0; j<3; j++)
	ld	a,c
	add	a, #0x0c
	ld	c,a
	inc	-2 (ix)
	ld	a,-2 (ix)
	sub	a, #0x03
	jr	C,00120$
;Players/players.h:76: if((time%8) == 0) {
	ld	a,4 (ix)
	and	a, #0x07
	jr	NZ,00116$
;Players/players.h:77: player1_current_frame++;
	ld	iy,#_player1_current_frame
	inc	0 (iy)
;Players/players.h:78: if(player1_current_frame == PLAYER1_NUMBER_FRAMES) {
	ld	a,0 (iy)
	sub	a, #0x08
	jr	NZ,00116$
;Players/players.h:79: player1_current_frame = 0;
	ld	0 (iy),#0x00
00116$:
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
;main.c:16: SMS_loadSpritePalette(spritepalette_bin);
	ld	hl,#_spritepalette_bin
	call	_SMS_loadSpritePalette
;main.c:17: SMS_loadPSGaidencompressedTiles(spritetiles_psgcompr, PLAYER1_SPRITE_TILES_POSITION); // Bomberman - move to player?
	ld	hl,#0x0100
	push	hl
	ld	hl,#_spritetiles_psgcompr
	push	hl
	call	_SMS_loadPSGaidencompressedTiles
	pop	af
;main.c:19: SMS_setSpritePaletteColor(0, RGB(0, 0, 0));
	ld	hl, #0x0000
	ex	(sp),hl
	call	_SMS_setSpritePaletteColor
;main.c:20: SMS_setBGPaletteColor(0, RGB(0, 0, 0));
	ld	hl, #0x0000
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
00113$:
;main.c:39: checkgamepause();
	call	_checkgamepause
;main.c:41: if(gamepause==0)
	ld	a,(#_gamepause + 0)
	or	a, a
	jr	NZ,00110$
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
;main.c:58: if(SMS_getKeysStatus() & PORT_A_KEY_1)
	call	_SMS_getKeysStatus
	bit	4, l
	jr	Z,00106$
;main.c:60: PSGSFXPlay(enemybomb_psg, 0x00);
	xor	a, a
	push	af
	inc	sp
	ld	hl,#_enemybomb_psg
	push	hl
	call	_PSGSFXPlay
	pop	af
	inc	sp
00106$:
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
	jr	00113$
00110$:
;main.c:76: PSGFrame();
	call	_PSGFrame
;main.c:78: if(PSGSFXGetStatus())
	call	_PSGSFXGetStatus
	ld	a,l
	or	a, a
	jr	Z,00108$
;main.c:80: PSGSFXFrame();
	call	_PSGSFXFrame
00108$:
;main.c:84: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:87: numinterrupts=0;
	ld	hl,#_numinterrupts + 0
	ld	(hl), #0x00
	jr	00113$
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
