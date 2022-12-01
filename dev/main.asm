;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (MINGW64)
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
	.globl _SMS_addSprite_f
	.globl _SMS_initSprites
	.globl _SMS_loadPSGaidencompressedTilesatAddr
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
	.globl _ROM_bank_to_be_mapped_on_slot0
	.globl _ROM_bank_to_be_mapped_on_slot1
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
_ROM_bank_to_be_mapped_on_slot1	=	0xfffe
_ROM_bank_to_be_mapped_on_slot0	=	0xfffd
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
	ld	hl, #_InterruptHandler
	call	_SMS_setLineInterruptHandler
;Core\funcs.h:21: SMS_setLineCounter (192);
	ld	l, #0xc0
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setLineCounter
;Core\funcs.h:22: SMS_enableLineInterrupt();
	ld	hl, #0x0010
	call	_SMS_VDPturnOnFeature
;Core\funcs.h:25: SMS_VDPturnOnFeature(VDPFEATURE_LEFTCOLBLANK);
	ld	hl, #0x0020
;Core\funcs.h:26: }
	jp	_SMS_VDPturnOnFeature
;Core\funcs.h:28: void checkgamepause()
;	---------------------------------
; Function checkgamepause
; ---------------------------------
_checkgamepause::
;Core\funcs.h:30: if(SMS_queryPauseRequested())
	call	_SMS_queryPauseRequested
	bit	0,a
	ret	Z
;Core\funcs.h:32: SMS_resetPauseRequest();
	call	_SMS_resetPauseRequest
;Core\funcs.h:33: gamepause=1-gamepause;
	ld	a, (_gamepause+0)
	ld	c, a
	ld	hl, #_gamepause
	ld	a, #0x01
	sub	a, c
	ld	(hl), a
;Core\funcs.h:34: if(gamepause==1)
	ld	a, (_gamepause+0)
	dec	a
	jr	NZ, 00102$
;Core\funcs.h:35: PSGPlayNoRepeat(pause_psg);
	ld	hl, #_pause_psg
	jp	_PSGPlayNoRepeat
00102$:
;Core\funcs.h:37: PSGPlay(music_psg);
	ld	hl, #_music_psg
;Core\funcs.h:39: }
	jp	_PSGPlay
;Players/players.h:29: void Player1Init()
;	---------------------------------
; Function Player1Init
; ---------------------------------
_Player1Init::
;Players/players.h:31: player1_direction = DOWN;
	ld	hl, #_player1_direction
	ld	(hl), #0x01
;Players/players.h:32: player1_x = 128-8;
	ld	hl, #_player1_x
	ld	(hl), #0x78
;Players/players.h:33: player1_y = 96-12;
	ld	hl, #_player1_y
	ld	(hl), #0x54
;Players/players.h:34: player1_current_frame = 0;
	ld	hl, #_player1_current_frame
	ld	(hl), #0x00
;Players/players.h:35: }
	ret
;Players/players.h:37: void Player1Update(unsigned char time)
;	---------------------------------
; Function Player1Update
; ---------------------------------
_Player1Update::
	ld	c, a
;Players/players.h:39: Player1UpdatePosition();
	push	bc
	call	_Player1UpdatePosition
	pop	bc
;Players/players.h:40: Player1UpdateDraw(time);
	ld	a, c
;Players/players.h:41: }
	jp	_Player1UpdateDraw
;Players/players.h:43: void Player1UpdatePosition()
;	---------------------------------
; Function Player1UpdatePosition
; ---------------------------------
_Player1UpdatePosition::
;Players/players.h:45: if(SMS_getKeysStatus() & PORT_A_KEY_UP)
	call	_SMS_getKeysStatus
	bit	0, e
	jr	Z, 00108$
;Players/players.h:47: if(player1_direction != UP)
	ld	a, (_player1_direction+0)
	or	a, a
	jr	Z, 00102$
;Players/players.h:49: SMS_loadTiles(spritetiles_up_bin, PLAYER1_SPRITE_POSITION, 32*6*6);
	ld	hl, #0x0480
	push	hl
	ld	de, #_spritetiles_up_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
00102$:
;Players/players.h:51: player1_direction = UP;
	ld	hl, #_player1_direction
	ld	(hl), #0x00
;Players/players.h:52: player1_y--;
	ld	hl, #_player1_y
	dec	(hl)
	jp	00109$
00108$:
;Players/players.h:54: else if(SMS_getKeysStatus() & PORT_A_KEY_DOWN)
	call	_SMS_getKeysStatus
	bit	1, e
	jr	Z, 00109$
;Players/players.h:56: if(player1_direction != DOWN)
	ld	a, (_player1_direction+0)
	dec	a
	jr	Z, 00104$
;Players/players.h:58: SMS_loadTiles(spritetiles_down_bin, PLAYER1_SPRITE_POSITION, 32*6*6);
	ld	hl, #0x0480
	push	hl
	ld	de, #_spritetiles_down_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
00104$:
;Players/players.h:60: player1_direction = DOWN;
	ld	hl, #_player1_direction
	ld	(hl), #0x01
;Players/players.h:61: player1_y++;
	ld	hl, #_player1_y
	inc	(hl)
00109$:
;Players/players.h:64: if(SMS_getKeysStatus() & PORT_A_KEY_LEFT)
	call	_SMS_getKeysStatus
	bit	2, e
	jr	Z, 00119$
;Players/players.h:66: if(player1_direction != LEFT && player1_direction != RIGHT)
	ld	a,(_player1_direction+0)
	cp	a,#0x02
	jr	Z, 00111$
	sub	a, #0x03
	jr	Z, 00111$
;Players/players.h:68: SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, 32*6*12);
	ld	hl, #0x0900
	push	hl
	ld	de, #_spritetiles_lr_bin
	ld	h, #0x60
	call	_SMS_VRAMmemcpy
00111$:
;Players/players.h:70: player1_direction = LEFT;
	ld	hl, #_player1_direction
	ld	(hl), #0x02
;Players/players.h:71: player1_x--;
	ld	hl, #_player1_x
	dec	(hl)
	ret
00119$:
;Players/players.h:73: else if(SMS_getKeysStatus() & PORT_A_KEY_RIGHT)
	call	_SMS_getKeysStatus
	bit	3, e
	ret	Z
;Players/players.h:75: if(player1_direction != LEFT && player1_direction != RIGHT)
	ld	a,(_player1_direction+0)
	cp	a,#0x02
	jr	Z, 00114$
	sub	a, #0x03
	jr	Z, 00114$
;Players/players.h:77: SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, 32*6*12);
	ld	hl, #0x0900
	push	hl
	ld	de, #_spritetiles_lr_bin
	ld	h, #0x60
	call	_SMS_VRAMmemcpy
00114$:
;Players/players.h:79: player1_direction = RIGHT;
	ld	hl, #_player1_direction
	ld	(hl), #0x03
;Players/players.h:80: player1_x++;
	ld	hl, #_player1_x
	inc	(hl)
;Players/players.h:82: }
	ret
;Players/players.h:84: void Player1UpdateDraw(unsigned char time)
;	---------------------------------
; Function Player1UpdateDraw
; ---------------------------------
_Player1UpdateDraw::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-14
	add	hl, sp
	ld	sp, hl
	ld	-3 (ix), a
;Players/players.h:87: unsigned char direction_offset = 0;
	ld	-14 (ix), #0x00
;Players/players.h:89: if(player1_direction == LEFT)
	ld	a, (_player1_direction+0)
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00290$
	xor	a, a
00290$:
	ld	c, a
	or	a, a
	jr	Z, 00110$
;Players/players.h:91: direction_offset = PLAYER1_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS >> 1;
	ld	-14 (ix), #0x0c
	jp	00111$
00110$:
;Players/players.h:93: else if(player1_direction == RIGHT)
	ld	a, (_player1_direction+0)
	sub	a, #0x03
	jr	NZ, 00107$
;Players/players.h:95: direction_offset = 0;
	ld	-14 (ix), #0x00
	jp	00111$
00107$:
;Players/players.h:97: else if(player1_direction == DOWN)
	ld	a, (_player1_direction+0)
	dec	a
	jr	NZ, 00104$
;Players/players.h:99: direction_offset = 0;
	ld	-14 (ix), #0x00
	jp	00111$
00104$:
;Players/players.h:101: else if(player1_direction == UP)
	ld	a, (_player1_direction+0)
	or	a, a
	jr	NZ, 00111$
;Players/players.h:103: direction_offset = 0;
	ld	-14 (ix), #0x00
00111$:
;Players/players.h:107: if(player1_direction == UP)
	ld	a, (_player1_direction+0)
	or	a, a
	jp	NZ, 00125$
;Players/players.h:109: for(j=0; j<3; j++)
	ld	-2 (ix), #0x00
;Players/players.h:111: for(i=0; i<2; i++) {
00163$:
	ld	-1 (ix), #0x00
00144$:
;Players/players.h:112: SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_UP_NUMBER_TILES_BY_FRAME + PLAYER1_UP_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a, (_player1_x+0)
	ld	-9 (ix), a
	ld	-8 (ix), #0x00
	ld	a, -1 (ix)
	ld	-13 (ix), a
	ld	-12 (ix), #0x00
	ld	a, -13 (ix)
	ld	-5 (ix), a
	ld	a, -12 (ix)
	ld	-4 (ix), a
	ld	b, #0x03
00295$:
	sla	-5 (ix)
	rl	-4 (ix)
	djnz	00295$
	ld	a, -9 (ix)
	add	a, -5 (ix)
	ld	-7 (ix), a
	ld	a, -8 (ix)
	adc	a, -4 (ix)
	ld	-6 (ix), a
	ld	a, -7 (ix)
	ld	-5 (ix), a
	ld	-4 (ix), #0x00
	ld	a, -5 (ix)
	ld	-10 (ix), a
	ld	-11 (ix), #0x00
	ld	a, -14 (ix)
	ld	-5 (ix), a
	ld	-4 (ix), #0x00
	ld	a, -5 (ix)
	ld	-7 (ix), a
	ld	a, -4 (ix)
	inc	a
	ld	-6 (ix), a
	ld	a, (_player1_current_frame+0)
	ld	-5 (ix), a
	ld	-4 (ix), #0x00
	sla	-5 (ix)
	rl	-4 (ix)
	ld	a, -7 (ix)
	add	a, -5 (ix)
	ld	-9 (ix), a
	ld	a, -6 (ix)
	adc	a, -4 (ix)
	ld	-8 (ix), a
	ld	a, -2 (ix)
	ld	-7 (ix), a
	ld	-6 (ix), #0x00
	ld	c, a
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	-5 (ix), l
	ld	-4 (ix), h
	ld	a, -9 (ix)
	add	a, -5 (ix)
	ld	c, a
	ld	a, -8 (ix)
	adc	a, -4 (ix)
	ld	b, a
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	add	hl, bc
	ld	a, l
	ld	c, #0x00
	or	a, -11 (ix)
	ld	e, a
	ld	a, c
	or	a, -10 (ix)
	ld	d, a
	ld	a, (_player1_y+0)
	ld	b, #0x00
	ld	l, -7 (ix)
	ld	h, -6 (ix)
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, a
	add	hl, bc
	call	_SMS_addSprite_f
;Players/players.h:111: for(i=0; i<2; i++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x02
	jp	C, 00144$
;Players/players.h:109: for(j=0; j<3; j++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x03
	jp	C, 00163$
	jp	00126$
00125$:
;Players/players.h:116: else if(player1_direction == DOWN)
	ld	a, (_player1_direction+0)
	dec	a
	jr	NZ, 00122$
;Players/players.h:118: for(j=0; j<3; j++)
	ld	-2 (ix), #0x00
;Players/players.h:120: for(i=0; i<2; i++) {
00168$:
	ld	-1 (ix), #0x00
00148$:
;Players/players.h:121: SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_DOWN_NUMBER_TILES_BY_FRAME + PLAYER1_DOWN_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a, (_player1_x+0)
	ld	e, a
	ld	d, #0x00
	ld	c, -1 (ix)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
;	spillPairReg hl
;	spillPairReg hl
	ld	-4 (ix), l
	ld	-5 (ix), #0x00
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	e, -14 (ix)
	xor	a, a
	inc	a
	ld	d, a
	ld	a, (_player1_current_frame+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, de
	push	hl
	pop	iy
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	pop	de
	push	bc
	ld	c, l
	ld	b, h
	add	iy, bc
	pop	bc
	push	iy
	pop	hl
	add	hl, bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -5 (ix)
	or	a, l
	ld	c, a
	ld	a, -4 (ix)
	or	a, h
	ld	b, a
	ld	a, (_player1_y+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	add	hl, de
	ld	e, c
	ld	d, b
	call	_SMS_addSprite_f
;Players/players.h:120: for(i=0; i<2; i++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x02
	jr	C, 00148$
;Players/players.h:118: for(j=0; j<3; j++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x03
	jr	C, 00168$
	jp	00126$
00122$:
;Players/players.h:125: else if(player1_direction == LEFT || player1_direction == RIGHT)
	ld	a, c
	or	a, a
	jr	NZ, 00175$
	ld	a, (_player1_direction+0)
	sub	a, #0x03
	jp	NZ,00126$
;Players/players.h:127: for(j=0; j<3; j++)
00175$:
	ld	-2 (ix), #0x00
;Players/players.h:129: for(i=0; i<2; i++) {
00173$:
	ld	-1 (ix), #0x00
00152$:
;Players/players.h:130: SMS_addSprite(player1_x+(i<<3), player1_y+(j<<3), PLAYER1_SPRITE_POSITION + direction_offset + player1_current_frame * PLAYER1_LR_NUMBER_TILES_BY_FRAME + PLAYER1_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a, (_player1_x+0)
	ld	c, a
	ld	b, #0x00
	ld	a, -1 (ix)
	ld	-7 (ix), a
	ld	-6 (ix), #0x00
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
;	spillPairReg hl
;	spillPairReg hl
	ld	b, l
	ld	c, #0x00
	ld	e, -14 (ix)
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	inc	a
	ld	d, a
	ld	a, (_player1_current_frame+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, hl
	add	hl, de
	ld	-5 (ix), l
	ld	-4 (ix), h
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, hl
	pop	de
	ld	a, l
	add	a, -5 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -4 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	add	a, -7 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -6 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	a, c
	or	a, l
	ld	c, a
	ld	a, b
	or	a, h
	ld	b, a
	ld	a, (_player1_y+0)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ex	de, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	add	hl, de
	ld	e, c
	ld	d, b
	call	_SMS_addSprite_f
;Players/players.h:129: for(i=0; i<2; i++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x02
	jr	C, 00152$
;Players/players.h:127: for(j=0; j<3; j++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x03
	jp	C, 00173$
00126$:
;Players/players.h:135: if((time%8) == 0) {
	ld	a, -3 (ix)
	and	a, #0x07
	jr	NZ, 00156$
;Players/players.h:136: player1_current_frame++;
	ld	iy, #_player1_current_frame
	inc	0 (iy)
;Players/players.h:138: if(player1_direction == UP)
	ld	a, (_player1_direction+0)
	or	a, a
	jr	NZ, 00140$
;Players/players.h:140: if(player1_current_frame == PLAYER1_UP_NUMBER_FRAMES) {
	ld	a, (_player1_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00156$
;Players/players.h:141: player1_current_frame = 0;
	ld	0 (iy), #0x00
	jp	00156$
00140$:
;Players/players.h:144: else if(player1_direction == DOWN)
	ld	a, (_player1_direction+0)
	dec	a
	jr	NZ, 00137$
;Players/players.h:146: if(player1_current_frame == PLAYER1_DOWN_NUMBER_FRAMES) {
	ld	a, (_player1_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00156$
;Players/players.h:147: player1_current_frame = 0;
	ld	hl, #_player1_current_frame
	ld	(hl), #0x00
	jp	00156$
00137$:
;Players/players.h:150: else if(player1_direction == LEFT || player1_direction == RIGHT)
	ld	a,(_player1_direction+0)
	cp	a,#0x02
	jr	Z, 00133$
	sub	a, #0x03
	jr	NZ, 00156$
00133$:
;Players/players.h:152: if(player1_current_frame == PLAYER1_LR_NUMBER_FRAMES) {
	ld	a, (_player1_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00156$
;Players/players.h:153: player1_current_frame = 0;
	ld	hl, #_player1_current_frame
	ld	(hl), #0x00
00156$:
;Players/players.h:157: }
	ld	sp, ix
	pop	ix
	ret
;main.c:7: void loadGraphics2vram(void)
;	---------------------------------
; Function loadGraphics2vram
; ---------------------------------
_loadGraphics2vram::
;main.c:10: SMS_VRAMmemsetW(0, 0x0000, 0x4000);
	ld	hl, #0x4000
	push	hl
	ld	de, #0x0000
	ld	h, l
	call	_SMS_VRAMmemsetW
;main.c:12: SMS_loadBGPalette(backgroundpalette_bin);
	ld	hl, #_backgroundpalette_bin
	call	_SMS_loadBGPalette
;main.c:13: SMS_loadPSGaidencompressedTiles(backgroundtiles_psgcompr, 0);
	ld	de, #0x4000
	ld	hl, #_backgroundtiles_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;main.c:14: SMS_loadTileMap(0,0, backgroundtilemap_bin, backgroundtilemap_bin_size);
	ld	hl, #0x0600
	push	hl
	ld	de, #_backgroundtilemap_bin
	ld	h, #0x78
	call	_SMS_VRAMmemcpy
;main.c:16: SMS_loadSpritePalette(spritepalette_bin);
	ld	hl, #_spritepalette_bin
	call	_SMS_loadSpritePalette
;main.c:17: SMS_loadTiles(spritetiles_down_bin, PLAYER1_SPRITE_POSITION, 32*6*6); 
	ld	hl, #0x0480
	push	hl
	ld	de, #_spritetiles_down_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
;main.c:19: SMS_setSpritePaletteColor(0, RGB(0, 0, 0));
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	l, a
	call	_SMS_setSpritePaletteColor
;main.c:20: SMS_setBGPaletteColor(0, RGB(0, 2, 3));
	ld	l, #0x38
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
;main.c:21: }
	jp	_SMS_setBGPaletteColor
;main.c:23: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:25: frame_counter = 0;
	ld	hl, #_frame_counter
	ld	(hl), #0x00
;main.c:27: Player1Init();
	call	_Player1Init
;main.c:28: InitConsole();
	call	_InitConsole
;main.c:30: loadGraphics2vram();
	call	_loadGraphics2vram
;main.c:31: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:33: PSGPlay(music_psg);
	ld	hl, #_music_psg
	call	_PSGPlay
;main.c:36: while(1)
00111$:
;main.c:39: checkgamepause();
	call	_checkgamepause
;main.c:41: if(gamepause==0)
	ld	a, (_gamepause+0)
	or	a, a
	jr	NZ, 00108$
;main.c:43: frame_counter++;
	ld	hl, #_frame_counter
	inc	(hl)
;main.c:45: if((frame_counter%64) == 0)
	ld	a, (_frame_counter+0)
	and	a, #0x3f
	jr	NZ, 00104$
;main.c:47: volume_atenuation++;
	ld	iy, #_volume_atenuation
	inc	0 (iy)
;main.c:48: if(volume_atenuation > 15)
	ld	a, #0x0f
	sub	a, 0 (iy)
	jr	NC, 00104$
;main.c:50: volume_atenuation = 0;
	ld	0 (iy), #0x00
00104$:
;main.c:54: SMS_initSprites();
	call	_SMS_initSprites
;main.c:56: Player1Update(frame_counter);
	ld	a, (_frame_counter+0)
	call	_Player1Update
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
	jp	00111$
00108$:
;main.c:76: PSGFrame();
	call	_PSGFrame
;main.c:78: if(PSGSFXGetStatus())
	call	_PSGSFXGetStatus
	or	a, a
	jr	Z, 00106$
;main.c:80: PSGSFXFrame();
	call	_PSGSFXFrame
00106$:
;main.c:84: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:87: numinterrupts=0;
	ld	hl, #_numinterrupts
	ld	(hl), #0x00
;main.c:90: }
	jp	00111$
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
