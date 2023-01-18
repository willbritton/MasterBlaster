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
	.globl _UpdateAnimation
	.globl _CreateAnimation
	.globl _InitAnimation
	.globl _DeleteAnimation
	.globl _free
	.globl _malloc
	.globl _SMS_VRAMmemsetW
	.globl _SMS_VRAMmemcpy
	.globl _SMS_loadSpritePalette
	.globl _SMS_loadBGPalette
	.globl _SMS_setSpritePaletteColor
	.globl _SMS_setBGPaletteColor
	.globl _SMS_copySpritestoSAT
	.globl _SMS_finalizeSprites
	.globl _SMS_initSprites
	.globl _SMS_loadPSGaidencompressedTilesatAddr
	.globl _SMS_crt0_RST18
	.globl _SMS_crt0_RST08
	.globl _SMS_waitForVBlank
	.globl _SMS_VDPturnOnFeature
	.globl _Player1Init
	.globl _checkgamepause
	.globl _InitConsole
	.globl _InterruptHandler
	.globl _PSGSFXFrame
	.globl _PSGFrame
	.globl _PSGSFXGetStatus
	.globl _PSGPlayNoRepeat
	.globl _PSGPlay
	.globl _MAX_FRAMES
	.globl _anim
	.globl _volume_atenuation
	.globl _frame_counter
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot0
	.globl _ROM_bank_to_be_mapped_on_slot1
	.globl _ROM_bank_to_be_mapped_on_slot2
	.globl _player_direction_offset
	.globl _player_direction
	.globl _player_current_frame
	.globl _player_y
	.globl _player_x
	.globl _sprite_size
	.globl _gamepause
	.globl _numinterrupts
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
_numinterrupts::
	.ds 1
_gamepause::
	.ds 1
_sprite_size::
	.ds 2
_player_x::
	.ds 1
_player_y::
	.ds 1
_player_current_frame::
	.ds 1
_player_direction::
	.ds 1
_player_direction_offset::
	.ds 1
_ROM_bank_to_be_mapped_on_slot2	=	0xffff
_ROM_bank_to_be_mapped_on_slot1	=	0xfffe
_ROM_bank_to_be_mapped_on_slot0	=	0xfffd
_SRAM_bank_to_be_mapped_on_slot2	=	0xfffc
_SMS_SRAM	=	0x8000
_frame_counter::
	.ds 1
_volume_atenuation::
	.ds 1
_anim::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_MAX_FRAMES::
	.ds 1
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
;Players/players.h:26: void Player1Init()
;	---------------------------------
; Function Player1Init
; ---------------------------------
_Player1Init::
;Players/players.h:28: sprite_size = 32*6*12;
	ld	hl, #0x0900
	ld	(_sprite_size), hl
;Players/players.h:29: player_x = 128-8;
	ld	hl, #_player_x
	ld	(hl), #0x78
;Players/players.h:30: player_y = 96-12;
	ld	hl, #_player_y
	ld	(hl), #0x54
;Players/players.h:31: player_direction = DOWN;
	ld	hl, #_player_direction
	ld	(hl), #0x01
;Players/players.h:32: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:33: player_direction_offset = 0;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x00
;Players/players.h:34: }
	ret
;Players/players.h:36: void Player1Update(unsigned char time)
;	---------------------------------
; Function Player1Update
; ---------------------------------
_Player1Update::
	ld	c, a
;Players/players.h:38: Player1UpdatePosition();
	push	bc
	call	_Player1UpdatePosition
	pop	bc
;Players/players.h:39: Player1UpdateDraw(time);
	ld	a, c
;Players/players.h:40: }
	jp	_Player1UpdateDraw
;Players/players.h:42: void Player1UpdatePosition()
;	---------------------------------
; Function Player1UpdatePosition
; ---------------------------------
_Player1UpdatePosition::
;Players/players.h:44: if(SMS_getKeysStatus() & PORT_A_KEY_UP)
	call	_SMS_getKeysStatus
	bit	0, e
	jr	Z, 00122$
;Players/players.h:46: if(player_direction != UP)
	ld	a, (_player_direction+0)
	or	a, a
	jr	Z, 00102$
;Players/players.h:48: SMS_loadTiles(spritetiles_up_bin, PLAYER1_SPRITE_POSITION, sprite_size);
	ld	hl, (_sprite_size)
	push	hl
	ld	de, #_spritetiles_up_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
;Players/players.h:49: player_direction = UP;
	ld	hl, #_player_direction
	ld	(hl), #0x00
;Players/players.h:50: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:51: player_direction_offset = 0;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x00
00102$:
;Players/players.h:53: player_y--;
	ld	hl, #_player_y
	dec	(hl)
	ret
00122$:
;Players/players.h:55: else if(SMS_getKeysStatus() & PORT_A_KEY_DOWN)
	call	_SMS_getKeysStatus
	bit	1, e
	jr	Z, 00119$
;Players/players.h:57: if(player_direction != DOWN)
	ld	a, (_player_direction+0)
	dec	a
	jr	Z, 00104$
;Players/players.h:59: SMS_loadTiles(spritetiles_down_bin, PLAYER1_SPRITE_POSITION, sprite_size);
	ld	hl, (_sprite_size)
	push	hl
	ld	de, #_spritetiles_down_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
;Players/players.h:60: player_direction = DOWN;
	ld	hl, #_player_direction
	ld	(hl), #0x01
;Players/players.h:61: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:62: player_direction_offset = 0;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x00
00104$:
;Players/players.h:64: player_y++;
	ld	hl, #_player_y
	inc	(hl)
	ret
00119$:
;Players/players.h:66: else if(SMS_getKeysStatus() & PORT_A_KEY_LEFT)
	call	_SMS_getKeysStatus
	bit	2, e
	jr	Z, 00116$
;Players/players.h:68: if(player_direction != LEFT)
;Players/players.h:70: if(player_direction != RIGHT)
	ld	a,(_player_direction+0)
	cp	a,#0x02
	jr	Z, 00108$
	sub	a, #0x03
	jr	Z, 00106$
;Players/players.h:72: SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, sprite_size);
	ld	hl, (_sprite_size)
	push	hl
	ld	de, #_spritetiles_lr_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
00106$:
;Players/players.h:74: player_direction = LEFT;
	ld	hl, #_player_direction
	ld	(hl), #0x02
;Players/players.h:75: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:76: player_direction_offset = PLAYER_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS >> 1;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x0c
00108$:
;Players/players.h:78: player_x--;
	ld	hl, #_player_x
	dec	(hl)
	ret
00116$:
;Players/players.h:80: else if(SMS_getKeysStatus() & PORT_A_KEY_RIGHT)
	call	_SMS_getKeysStatus
	bit	3, e
	ret	Z
;Players/players.h:82: if(player_direction != RIGHT)
;Players/players.h:84: if(player_direction != LEFT)
	ld	a,(_player_direction+0)
	cp	a,#0x03
	jr	Z, 00112$
	sub	a, #0x02
	jr	Z, 00110$
;Players/players.h:86: SMS_loadTiles(spritetiles_lr_bin, PLAYER1_SPRITE_POSITION, sprite_size);
	ld	hl, (_sprite_size)
	push	hl
	ld	de, #_spritetiles_lr_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
00110$:
;Players/players.h:88: player_direction = RIGHT;
	ld	hl, #_player_direction
	ld	(hl), #0x03
;Players/players.h:89: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
;Players/players.h:90: player_direction_offset = 0;
	ld	hl, #_player_direction_offset
	ld	(hl), #0x00
00112$:
;Players/players.h:92: player_x++;
	ld	hl, #_player_x
	inc	(hl)
;Players/players.h:94: }
	ret
;Players/players.h:96: void Player1UpdateDraw(unsigned char time)
;	---------------------------------
; Function Player1UpdateDraw
; ---------------------------------
_Player1UpdateDraw::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-6
	add	hl, sp
	ld	sp, hl
;Players/players.h:100: if((time%8) == 0) {
	and	a, #0x07
	jr	NZ, 00121$
;Players/players.h:101: player_current_frame++;
	ld	iy, #_player_current_frame
	inc	0 (iy)
;Players/players.h:103: if(player_direction == UP)
	ld	a, (_player_direction+0)
	or	a, a
	jr	NZ, 00118$
;Players/players.h:105: if(player_current_frame == PLAYER_UD_NUMBER_FRAMES) {
	ld	a, (_player_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00121$
;Players/players.h:106: player_current_frame = 0;
	ld	0 (iy), #0x00
	jp	00121$
00118$:
;Players/players.h:109: else if(player_direction == DOWN)
	ld	a, (_player_direction+0)
	dec	a
	jr	NZ, 00115$
;Players/players.h:111: if(player_current_frame == PLAYER_UD_NUMBER_FRAMES) {
	ld	a, (_player_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00121$
;Players/players.h:112: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
	jp	00121$
00115$:
;Players/players.h:115: else if(player_direction == LEFT)
	ld	a, (_player_direction+0)
	sub	a, #0x02
	jr	NZ, 00112$
;Players/players.h:117: if(player_current_frame == PLAYER_LR_NUMBER_FRAMES) {
	ld	a, (_player_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00121$
;Players/players.h:118: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
	jp	00121$
00112$:
;Players/players.h:121: else if(player_direction == RIGHT)
	ld	a, (_player_direction+0)
	sub	a, #0x03
	jr	NZ, 00121$
;Players/players.h:123: if(player_current_frame == PLAYER_LR_NUMBER_FRAMES) {
	ld	a, (_player_current_frame+0)
	sub	a, #0x06
	jr	NZ, 00121$
;Players/players.h:124: player_current_frame = 0;
	ld	hl, #_player_current_frame
	ld	(hl), #0x00
00121$:
;Players/players.h:129: if(player_direction == UP || player_direction == DOWN)
	ld	a, (_player_direction+0)
	or	a, a
	jr	Z, 00155$
	ld	a, (_player_direction+0)
	dec	a
	jp	NZ,00130$
;Players/players.h:131: for(j=0; j<3; j++)
00155$:
	ld	-2 (ix), #0x00
;Players/players.h:133: for(i=0; i<2; i++) {
00153$:
	ld	-1 (ix), #0x00
00133$:
;Players/players.h:134: SMS_addSprite(player_x+(i<<3), player_y+(j<<3), PLAYER1_SPRITE_POSITION + player_direction_offset + player_current_frame * PLAYER_UD_NUMBER_TILES_BY_FRAME + PLAYER_UD_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a, (_player_x+0)
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
	ld	-3 (ix), l
	ld	-4 (ix), #0x00
	ld	a, (_player_direction_offset+0)
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
;	spillPairReg hl
	ld	e, a
	xor	a, a
	inc	a
	ld	d, a
	ld	a, (_player_current_frame+0)
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
	ld	a, -4 (ix)
	or	a, l
	ld	c, a
	ld	a, -3 (ix)
	or	a, h
	ld	b, a
	ld	a, (_player_y+0)
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
;Players/players.h:133: for(i=0; i<2; i++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x02
	jr	C, 00133$
;Players/players.h:131: for(j=0; j<3; j++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x03
	jr	C, 00153$
	jp	00141$
00130$:
;Players/players.h:138: else if(player_direction == LEFT || player_direction == RIGHT)
	ld	a,(_player_direction+0)
	cp	a,#0x02
	jr	Z, 00160$
	sub	a, #0x03
	jp	NZ,00141$
;Players/players.h:140: for(j=0; j<3; j++)
00160$:
	ld	-2 (ix), #0x00
;Players/players.h:142: for(i=0; i<2; i++) {
00158$:
	ld	-1 (ix), #0x00
00137$:
;Players/players.h:143: SMS_addSprite(player_x+(i<<3), player_y+(j<<3), PLAYER1_SPRITE_POSITION + player_direction_offset + player_current_frame * PLAYER_LR_NUMBER_TILES_BY_FRAME + PLAYER_LR_NUMBER_TILES_FRAMES_BOTH_DIRECTIONS *j + i);
	ld	a, (_player_x+0)
	ld	c, a
	ld	b, #0x00
	ld	a, -1 (ix)
	ld	-6 (ix), a
	ld	-5 (ix), #0x00
	pop	hl
	push	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
;	spillPairReg hl
;	spillPairReg hl
	ld	b, l
	ld	c, #0x00
	ld	a, (_player_direction_offset+0)
	ld	d, #0x00
	ld	e, a
	inc	d
	ld	a, (_player_current_frame+0)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, hl
	add	hl, de
	ld	-4 (ix), l
	ld	-3 (ix), h
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
	add	a, -4 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -3 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	add	a, -6 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -5 (ix)
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
	ld	a, (_player_y+0)
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
;Players/players.h:142: for(i=0; i<2; i++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x02
	jr	C, 00137$
;Players/players.h:140: for(j=0; j<3; j++)
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x03
	jp	C, 00158$
00141$:
;Players/players.h:147: }
	ld	sp, ix
	pop	ix
	ret
;Tiles/animation.h:16: void DeleteAnimation(Animation *anim)
;	---------------------------------
; Function DeleteAnimation
; ---------------------------------
_DeleteAnimation::
;Tiles/animation.h:18: if(anim != NULL)
	ld	a, h
	or	a, l
;Tiles/animation.h:19: free(anim);
	jp	NZ,_free
;Tiles/animation.h:20: }
	ret
;Tiles/animation.h:22: void InitAnimation(Animation* anim,
;	---------------------------------
; Function InitAnimation
; ---------------------------------
_InitAnimation::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-7
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
	ld	-3 (ix), e
	ld	-2 (ix), d
;Tiles/animation.h:29: anim->mCurrentFrame = 0;
	ld	hl, #0x0043
	add	hl, bc
	ld	(hl), #0x00
;Tiles/animation.h:30: anim->mNumFrames = numFrames;
	ld	hl, #0x0044
	add	hl, bc
	ex	de, hl
	ld	a, 4 (ix)
	ld	(de), a
;Tiles/animation.h:31: anim->mMapPosX = mapPosX;
	ld	hl, #0x0040
	add	hl, bc
	ld	a, 5 (ix)
	ld	(hl), a
;Tiles/animation.h:32: anim->mMapPosY = mapPosY;
	ld	hl, #0x0041
	add	hl, bc
	ld	a, 6 (ix)
	ld	(hl), a
;Tiles/animation.h:33: anim->mAnimationSpeed = animationSpeed;
	ld	hl, #0x0042
	add	hl, bc
	ld	a, 7 (ix)
	ld	(hl), a
;Tiles/animation.h:35: if(anim->mNumFrames > MAX_FRAMES)
	ld	a, (#_MAX_FRAMES)
	sub	a, 4 (ix)
	jr	NC, 00111$
;Tiles/animation.h:37: anim->mNumFrames = MAX_FRAMES;
	ld	a, (_MAX_FRAMES+0)
	ld	(de), a
;Tiles/animation.h:40: for(unsigned char i = 0; i < anim->mNumFrames; i++)
00111$:
	ld	-1 (ix), #0x00
00105$:
	ld	a, (de)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, -1 (ix)
	sub	a, l
	jr	NC, 00107$
;Tiles/animation.h:42: anim->mFrames[i] = frames[i];
	ld	a, -1 (ix)
	add	a, a
	add	a, c
	ld	-7 (ix), a
	ld	a, #0x00
	adc	a, b
	ld	-6 (ix), a
	ld	l, -1 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	a, l
	add	a, -3 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -2 (ix)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (hl)
	ld	-5 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-4 (ix), a
	pop	hl
	push	hl
	ld	a, -5 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -4 (ix)
	ld	(hl), a
;Tiles/animation.h:40: for(unsigned char i = 0; i < anim->mNumFrames; i++)
	inc	-1 (ix)
	jp	00105$
00107$:
;Tiles/animation.h:44: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;Tiles/animation.h:46: Animation* CreateAnimation(
;	---------------------------------
; Function CreateAnimation
; ---------------------------------
_CreateAnimation::
	push	ix
	ld	ix,#0
	add	ix,sp
;Tiles/animation.h:53: struct Animation* anim = malloc(sizeof (struct Animation));
	push	hl
	ld	hl, #0x0045
	call	_malloc
	ex	de, hl
	pop	de
;Tiles/animation.h:55: if (anim == NULL)
	ld	a, h
	or	a, l
	jr	NZ, 00102$
;Tiles/animation.h:56: return NULL;
	ld	de, #0x0000
	jp	00103$
00102$:
;Tiles/animation.h:58: InitAnimation(anim, frames, numFrames, mapPosX, mapPosY, animationSpeed);
	push	hl
	ld	b, 7 (ix)
	ld	c, 6 (ix)
	push	bc
	ld	b, 5 (ix)
	ld	c, 4 (ix)
	push	bc
	call	_InitAnimation
	pop	hl
;Tiles/animation.h:60: return anim;
	ex	de, hl
00103$:
;Tiles/animation.h:61: }
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
;Tiles/animation.h:63: void UpdateAnimation(Animation* animation, unsigned char time)
;	---------------------------------
; Function UpdateAnimation
; ---------------------------------
_UpdateAnimation::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	c, l
	ld	b, h
;Tiles/animation.h:65: if((time % animation->mAnimationSpeed) == 0)
	push	bc
	pop	iy
	ld	l, 66 (iy)
;	spillPairReg hl
	push	bc
	ld	a, 4 (ix)
	call	__moduchar
	pop	bc
	ld	a, e
	or	a, a
	jr	NZ, 00108$
;Tiles/animation.h:67: animation->mCurrentFrame++;
	ld	hl, #0x0043
	add	hl, bc
	ex	de, hl
	ld	a, (de)
	inc	a
	ld	-1 (ix), a
	ld	(de), a
;Tiles/animation.h:69: if(animation->mCurrentFrame > animation->mNumFrames)
	push	bc
	pop	iy
;	spillPairReg hl
	ld	a, 68 (iy)
	sub	a, -1 (ix)
	jr	NC, 00103$
;Tiles/animation.h:71: animation->mCurrentFrame = 0;
	xor	a, a
	ld	(de), a
;Tiles/animation.h:74: SMS_setTileatXY(animation->mMapPosX, animation->mMapPosX, animation->mFrames[animation->mCurrentFrame]);
00103$:
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	ld	bc, #0x0040
	add	hl, bc
	pop	bc
	ld	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ex	(sp), hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	a, -2 (ix)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, h
	adc	a, -1 (ix)
	ld	h, a
	add	hl, hl
	ld	a, h
	or	a, #0x78
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	bc
	rst	#0x08
	pop	bc
	ld	a, (de)
	add	a, a
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
;	spillPairReg hl
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	rst	#0x18
00108$:
;Tiles/animation.h:78: }
	ld	sp, ix
	pop	ix
	pop	hl
	inc	sp
	jp	(hl)
;main.c:10: void loadGraphics2vram(void)
;	---------------------------------
; Function loadGraphics2vram
; ---------------------------------
_loadGraphics2vram::
	ld	hl, #-40
	add	hl, sp
	ld	sp, hl
;main.c:13: SMS_VRAMmemsetW(0, 0x0000, 0x4000);
	ld	hl, #0x4000
	push	hl
	ld	de, #0x0000
	ld	h, l
	call	_SMS_VRAMmemsetW
;main.c:16: SMS_loadBGPalette(backgroundpalette_bin);
	ld	hl, #_backgroundpalette_bin
	call	_SMS_loadBGPalette
;main.c:17: SMS_loadPSGaidencompressedTiles(backgroundtiles_psgcompr, 0);
	ld	de, #0x4000
	ld	hl, #_backgroundtiles_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;main.c:18: SMS_loadTileMap(0,0, backgroundtilemap_bin, backgroundtilemap_bin_size);
	ld	hl, #0x0600
	push	hl
	ld	de, #_backgroundtilemap_bin
	ld	h, #0x78
	call	_SMS_VRAMmemcpy
;main.c:19: SMS_setBGPaletteColor(0, RGB(0, 2, 3));
	ld	l, #0x38
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	call	_SMS_setBGPaletteColor
;main.c:22: SMS_loadSpritePalette(spritepalette_bin);
	ld	hl, #_spritepalette_bin
	call	_SMS_loadSpritePalette
;main.c:23: SMS_loadTiles(spritetiles_down_bin, PLAYER1_SPRITE_POSITION, 32*6*6);
	ld	hl, #0x0480
	push	hl
	ld	de, #_spritetiles_down_bin
	ld	hl, #0x6000
	call	_SMS_VRAMmemcpy
;main.c:24: SMS_setSpritePaletteColor(0, RGB(0, 0, 0));
;	spillPairReg hl
;	spillPairReg hl
	xor	a, a
	ld	l, a
	call	_SMS_setSpritePaletteColor
;main.c:27: int frames[20] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20};
	ld	hl, #0
	add	hl, sp
	ld	e, l
	ld	d, h
	ld	(hl), #0x01
	inc	hl
	ld	(hl), #0x00
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	(hl), #0x02
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), #0x03
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x04
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x05
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x06
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x000c
	add	hl, de
	ld	(hl), #0x07
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x000e
	add	hl, de
	ld	(hl), #0x08
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0010
	add	hl, de
	ld	(hl), #0x09
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0012
	add	hl, de
	ld	(hl), #0x0a
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0014
	add	hl, de
	ld	(hl), #0x0b
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0016
	add	hl, de
	ld	(hl), #0x0c
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0018
	add	hl, de
	ld	(hl), #0x0d
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x001a
	add	hl, de
	ld	(hl), #0x0e
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x001c
	add	hl, de
	ld	(hl), #0x0f
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x001e
	add	hl, de
	ld	(hl), #0x10
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0020
	add	hl, de
	ld	(hl), #0x11
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0022
	add	hl, de
	ld	(hl), #0x12
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0024
	add	hl, de
	ld	(hl), #0x13
	inc	hl
	ld	(hl), #0x00
	ld	hl, #0x0026
	add	hl, de
	ld	(hl), #0x14
	inc	hl
	ld	(hl), #0x00
;main.c:28: anim = CreateAnimation(frames, 20, 2, 2, 32);
	ld	bc, #0x2002
	push	bc
	ld	a, #0x02
	push	af
	inc	sp
	ld	a, #0x14
	push	af
	inc	sp
	ex	de, hl
	call	_CreateAnimation
	ld	(_anim), de
;main.c:29: }
	ld	hl, #40
	add	hl, sp
	ld	sp, hl
	ret
;main.c:31: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:33: frame_counter = 0;
	ld	hl, #_frame_counter
	ld	(hl), #0x00
;main.c:35: Player1Init();
	call	_Player1Init
;main.c:36: InitConsole();
	call	_InitConsole
;main.c:38: loadGraphics2vram();
	call	_loadGraphics2vram
;main.c:39: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
;main.c:41: PSGPlay(music_psg);
	ld	hl, #_music_psg
	call	_PSGPlay
;main.c:44: while(1)
00111$:
;main.c:47: checkgamepause();
	call	_checkgamepause
;main.c:49: if(gamepause==0)
	ld	a, (_gamepause+0)
	or	a, a
	jr	NZ, 00108$
;main.c:51: frame_counter++;
	ld	hl, #_frame_counter
	inc	(hl)
;main.c:53: if((frame_counter%64) == 0)
	ld	a, (_frame_counter+0)
	and	a, #0x3f
	jr	NZ, 00104$
;main.c:55: volume_atenuation++;
	ld	iy, #_volume_atenuation
	inc	0 (iy)
;main.c:56: if(volume_atenuation > 15)
	ld	a, #0x0f
	sub	a, 0 (iy)
	jr	NC, 00104$
;main.c:58: volume_atenuation = 0;
	ld	0 (iy), #0x00
00104$:
;main.c:63: UpdateAnimation(anim, frame_counter);
	ld	a, (_frame_counter+0)
	push	af
	inc	sp
	ld	hl, (_anim)
	call	_UpdateAnimation
;main.c:66: SMS_initSprites();
	call	_SMS_initSprites
;main.c:68: Player1Update(frame_counter);
	ld	a, (_frame_counter+0)
	call	_Player1Update
;main.c:75: SMS_finalizeSprites();
	call	_SMS_finalizeSprites
;main.c:76: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:78: PSGFrame();
	call	_PSGFrame
;main.c:79: PSGSFXFrame();
	call	_PSGSFXFrame
;main.c:81: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
	jp	00111$
00108$:
;main.c:88: PSGFrame();
	call	_PSGFrame
;main.c:90: if(PSGSFXGetStatus())
	call	_PSGSFXGetStatus
	or	a, a
	jr	Z, 00106$
;main.c:92: PSGSFXFrame();
	call	_PSGSFXFrame
00106$:
;main.c:96: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;main.c:99: numinterrupts=0;
	ld	hl, #_numinterrupts
	ld	(hl), #0x00
;main.c:102: }
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
__xinit__MAX_FRAMES:
	.db #0x20	; 32
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
