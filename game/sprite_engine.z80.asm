﻿;---------------------------------------------------V--------------------



;
; excluding fred and the ambulance we have max 8 sprites on the screen at once
;



;
; loop for all sprites, 
;
draw_sprites

	ld b, sprite_max 								; loop for all sprites
	ld hl, sprt_0									; hl points to first sprite
sp_loop:
	push hl											
	push bc
	call draw_sprite								; this is always called even if there are only 3
	pop bc											; sprites defined as fred and the bulance are at 
	pop hl											; the end of the 8 level ddesigend sprintes
	ld de, sprt_buff_len
	add hl, de
	djnz sp_loop
	ret	
;
;  copies 16 rows of two characters from the sprite pix maps into 
;  to the screen background buffer
; IN: hl points to the sprite buffer
; 
draw_sprite:
	push hl
	pop ix
	ld a, (hl)										; test if sprite is in use
	cp 0
	ret z											; return if not
	inc hl											; this is the back buffer location

	ld e, (hl)										; ld de, (hl)
	inc hl
	ld d, (hl)
	dec hl											; put hl back this implements ld de, (hl)

	push de											; we need this later to set attrs 
	ld bc, 6
	add hl, bc										; address of first frame address

	ld a, (ix + i_sb_anim_fr)						; get current frame
	add a, a                                        ; frame 0, 1, 2, 3 => 0, 2, 4 , 6

	ld c, a
	ld b, 0
	add hl, bc										; hl = first_frame address + 2 * frameNo


	ld c, (hl)										; get (hl) into bc
	inc hl
	ld b, (hl)
	dec hl											; put hl back this implements ld bc, (hl)

	push bc
	pop hl

	ld bc, sprite_bytes							    ; loop for 15 lines * 2 bytes
str_bg3:	

	ld a, (de)										; get back buffer pixels
	or (hl)											; or ours on top
	ld (de), a										; save back
	inc hl											; next pixmap pixel
	inc de											; next buffer pixel
	dec bc											; record move

	ld a, (de)										; get back buffer pixels
	or (hl)											; or ours on top
	ld (de), a										; save back
	inc hl											; next pixmap pixel
	inc de											; next buffer pixel
	dec bc											; record move


	push bc											; save count (dec by 2)
	ld bc, 30										; next line offset
	ex de, hl
	add hl, bc										
	ex de, hl										; de = de + 30
	pop bc											; retrieve the count
	ld a, b											; test b against c
	or c
	jr nz, str_bg3									; loop unless both are 0
set_attr:											; set the attribute bytes for our sprite

; var offset = screenAddress - screenBufferStart;
	pop hl											; retrieve the back buffer address
	
	ld a, (ix + i_sb_flags)							; lets check if we are rendering attributes
	and sprite_no_attrs								; fred inherits his attributes from the environment
	ret nz											; stop if not rendering attributes
	
	
	ld de, char_line_00                            	; hl = offset of sprt relative to screen top
	sbc hl, de										

    push hl                                         ; save hl

; calculate a value indicating if the sprite starts exactly on a character cell top
; if it does we render 2x2 attributes, otherwise it is 2x3: Psuedocode:
; 	 isFirstCharCellLine = (offset / 32 & 0b0111) == 0;

	DivideHlBy32()
    
    ld a, l
    and %111										; mask lower 3 bits
    pop hl                                          ; get the offset back
    push af                                         ; we need this later


; var x = offset % 32;

	ld a, l
	and %00011111									; a = addr & 32 => x coord
	ld c, a											; bc =  x coord
    ld b, 0

; var rowStart = offset - x;

    sbc hl, bc

; var charY = rowStart / 256; (ie h in the hl pair)

    ld l, h
    ld h, 0

;  var attrOffset = (charY * 32) + x;

    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl
    add hl, hl

    add hl, bc

; var attrAddress =  attributeStart + attrPos;

	ld bc, attr_line_000							
	add hl, bc

; render the attributes

	ld a, (ix + i_sb_attrs)							; get the attrs
	ld (hl), a										; set first attr
	inc hl		
	ld (hl), a										; set second attr
	ld bc, 31										; off set to second row
	add hl, bc	
	ld (hl), a										; set third attr
	inc hl
	ld (hl), a										; set 4th attr

    pop af                                          ; restore the flag that indicates extra attributes need rendering
    or a
    ret z                                           ; return if zero

    ld a, (ix + i_sb_attrs)
	add hl, bc	
	ld (hl), a										
	inc hl
	ld (hl), a										


	ret

div_hl_d:										; hl = hl ÷ d, a = remainder
	xor	a		 								; clear upper eight bits of ahl
	ld	 b, 16	 								; sixteen bits in dividend
_loopd:
	add	hl, hl									; do a sla hl. if the upper bit was 1, the c flag is set
	rla			  								; this moves the upper bits of the dividend into a
	jr	 c, _overflow
	cp	 d		 								; check if we can subtract the divisor
	jr	 c, _skip  								; carry means d > a
_overflow:
	sub	d		 								; do subtraction for real this time
	inc	l		 								; set the next bit of the quotient (currently bit 0)
_skip:
	djnz   _loopd
	ret


;
; store sprite backgrounds, these are restored before the next render
;
store_backgrounds
	ld b, sprite_max								; loop for all  sprites
	ld hl, sprt_0									; hl points to first sprite
bg_loop:
	push hl
	push bc
	call store_background
	pop bc
	pop hl
	ld de, sprt_buff_len
	add hl, de
	djnz bg_loop
	ret	



;
;  copies 15 rows of two characters from the screen into 
;  the sprites buffer to allow the background to be restored 
;  prior to moving the sprite.
;
;  This could be optimized for horizontal sprites as the background
;  only changes every 4 frames
;
; IN: hl points to the sprite buffer
; 
store_background
	ld a, (hl)										; test if sprite is in use
	cp 0
	ret z											; return if not
	inc hl											; points to sprite screen address

	ld e, (hl)										; load (hl) into de (screen address)
	inc hl
	ld d, (hl)										; de = screen address of sprite
	dec hl											; put hl back this implements ld de, (hl)

	ld bc, sprt_bg_offset-1							; Point HL to the sprite buffers
	add hl, bc										; hl points to the background cache
	ex de, hl										; swap hl and de, hl = screen address, de = buffer address
	ld bc, sprite_bytes								; loop for 15 lines * 2 bytes
str_bg1:	
	ldi												; copy two bytes
	ldi
	push bc											; save count (dec by 2)
	ld bc, 30										; next line offset
	add hl, bc										; de will already be pointing to next buff
	pop bc											; retrieve the count
	ld a, b											; test b against c
	or c
	jr nz, str_bg1									; loop unless both are 0
	ret

;
; restore store sprite backgrounds, replace the background of the 
; sprite prior to moving
;
restore_backgrounds

	ld b, sprite_max								; loop for all 8 sprites
	ld hl, sprt_0									; hl points to first sprite
bg_loop2:
	push hl
	push bc
	call restore_background
	pop bc
	pop hl
	ld de, sprt_buff_len
	add hl, de
	djnz bg_loop2
	ret	

;
;  copies 16 rows of two characters from the sprite buffer into 
;  to the screen background buffer
; IN: hl points to the sprite buffer
; 
restore_background
	ld a, (hl)										; test if sprite is in use
	cp 0
	ret z											; return if not
	inc hl											; points to sprite screen address
	
	ld e, (hl)										; load (hl) into de (screen address)
	inc hl
	ld d, (hl)
	dec hl											; de = screen address of sprite

	ld bc, sprt_bg_offset-1							; Point HL to the sprite buffers
	add hl, bc										; hl = background cache, de = screen address
	ld bc, sprite_bytes								; loop for 15 lines * 2 bytes
str_bg2:	
	ldi												; copy two bytes
	ldi
	push bc											; save count (dec by 2)
	ld bc, 30										; next line offset
	ex de, hl										; de = de + 30
	add hl, bc										
	ex de, hl										; de = de + 30
	pop bc											; retrieve the count
	ld a,b
	or c
	jp nz , str_bg2
	ret

;
; Wipe all 8 sprite buffers setting them to all zeros, a
; zero in the first byte indicates an unused sprite
;
; IN : None
; Trashes: de, bc
reset_sprites:
	push hl
	ld hl, sprt_0
	ld de, sprt_0 + 1
	ld (hl), 0
	ld bc, sprt_buff_len * 8 -1
	ldir
	pop hl
	ret



;
; Initialize the sprites for the level, this copies data from the level definition 
; into the sprite definitions the max 8 sprite definitions
;
initialize_sprites:
	push ix											; hl already points to the first sprite def
	call reset_sprites								; ix points to the level defintion
	ld b, 0											; initialize bc to the length of a sprite definition
	ld c, sprite_definition_len						; this is calculated from the length of sprite def 0 in level 1
	ld a, -1
init_sprt1:
	inc a
	push hl											; ix = hl
	pop ix	
	push af
	push hl											; save the current platform address
	push bc											; and the offset to the next one
	call initialize_sprite							; set up our sprite
	pop bc											; restore offset
	pop hl											; restore address
	add hl, bc										; next platform start
	ld a, (HL)	
	cp last_definition								; is it the end of plat form marker?
	jr z, done_init									; if so, stop
	pop af
	jp init_sprt1									; rinse and repeat
done_init:
	inc hl			
	pop af
	push hl
	call store_backgrounds
	pop hl
	pop ix											; restore the level definition to ix
	ret	

;
; IN: IX points to sprite definitition
;	 A contains the the sprite buffer number to use 0..7
;
initialize_sprite:
	ld hl, sprt_0									; point to first sprite		
	cp 0
	jp z, cont_sprt									; avoid the loop if this it sprite 0
	ld de, sprt_buff_len							
	ld b, a
add_one	add hl, de									; skip to the next sprite buffer
	djnz add_one									; loop till 0
cont_sprt:
	ld (hl), sprite_enabled							; mark as in use
	inc hl											; point to attr
	push hl	
	push ix
	pop hl											; hl points to level definition
	pop de											; de points to the sprt_buffer
	ld bc, sprite_definition_len
	ldir											; copy the def into the buffer
	ret






