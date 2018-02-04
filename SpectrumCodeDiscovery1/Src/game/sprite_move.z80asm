;---------------------------------------------------V--------------------

move_sprites:
	ld b, sprite_max								; loop for all sprites
	ld hl, sprt_0									; hl points to first sprite
mv_loop:
	push hl
	push bc
	call move_sprite
	pop bc
	pop hl
	ld de, sprt_buff_len
	add hl, de
	djnz mv_loop
	ret

move_sprite:
	ld a, (hl)										; is this sprite active
	cp 0											; bail if not
	ret z		
	push ix
	push hl
	pop ix											; ix points to sprite buffer

	ld a, (ix + i_sb_sp_type)						; animation type
	
	cp none											; if no move type (static sprite) then done
	jr z, move_none
	
	cp vertical										; if it's not vertical
	jr nz, move_h
	
	call move_vertical
	jr move_comp

move_h:	call move_horizontal						; it's horizontal
	jp move_comp
move_none:											; no movement just inc the frame
	call animate_frame
move_comp:
	pop ix
	ret


; IN HL and IX point to the sprite buffer
;
move_horizontal:
	ld a, (ix + i_sb_sp_dir)
	cp left
	jr z, move_left
move_right:
	ld a, (ix + i_sb_anim_fr)						; retrieve frame counter
	inc a											; inc frame counter
	and 3											; mask significant bits
	ld (ix + i_sb_anim_fr), a						; store frame counter
	cp 0											; we move every 4th frame
	ret nz											; ignore 1,2,3
	inc hl
	
	ld e, (hl)										; Get current screen address into de
	inc hl
	ld d, (hl)
	dec hl											; put hl back this implements ld de, (hl)

	inc de											; move right
	push hl
	ld bc, 4
	add hl, bc										; move hl to last screen address

	
	ld c, (hl)										; ld bc, (hl)
	inc hl
	ld b, (hl)										; we won't bother dec hl as the value is poped below
	
	inc bc											; path includes the two end points so inc

	push de
	pop hl

	sbc hl, bc										; test if we are at the end
	jp nz, store_pos								; have we hit the right?
	ld (ix + i_sb_sp_dir), left						; flip to move left
	ld (ix + i_sb_anim_fr), 3						; start on the third frame
	dec de
	jp store_pos

move_left:	
	ld a, (ix + i_sb_anim_fr)						; retrieve frame counter
	dec a											; inc frame counter
	and 3
	ld (ix + i_sb_anim_fr), a						; store frame counter
	cp 3											; we move every 4th frame
	ret nz											; ignore 1,2,3
	inc hl

	ld e, (hl)										; get current screen address into de
	inc hl
	ld d, (hl)
	dec hl											; put hl back this implements ld de, (hl)

	dec de											; move left
	push hl
	ld bc, 2
	add hl, bc										; move hl to first screen address

	ld c, (hl)										; ld bc, (hl)
	inc hl
	ld b, (hl)

	dec bc											; path includes the two end points so dec

	push de
	pop hl

	sbc hl, bc										; test if we are at the end
	jp nz, store_pos								; have we hit the right?
	ld (ix + i_sb_sp_dir), right					; flip to move left
	ld (ix + i_sb_anim_fr), 1						; start on the third frame
	inc de
store_pos
	pop hl
	ld (hl), e
	inc hl
	ld (hl), d
	dec hl

;	ld (hl), de
	ret

;
; IN HL and IX point to the sprite buffer
;
move_vertical:
    call animate_frame

    inc hl                                          ; point to screen address	
	ld e, (hl)										; Get current screen address into de
	inc hl
	ld d, (hl)                                      ; de = screen_address
	dec hl			                                ; hl = screen_address storage

    ld b, (ix + i_sb_sp_velocity)                   ; get velocity in to b
    xor a                                           ; zero a

add_next:
    add a, 32                                       ; calc a * 32, note that menas max velocity is 7 or overflow happens
    djnz add_next                               

    ld c, a                                         ; bc = screen offset to next point                        
    ld b, 0

    ld a, (ix + i_sb_sp_dir)
	cp down
	jr z, move_down
move_up:
    ex de, hl                                        ; hl = screen_address, de = screen_address store
    or a                                             ; reset the carry flag
    sbc hl, bc                                       ; next line down

    ex de, hl                                        ; hl = screen_address_store, de = screen_address 
    ld (hl), e                                       ; store new position
    inc hl
    ld (hl), d
   
    inc hl                                           ; screen low adress store

    ld c, (hl)
    inc hl
    ld b, (hl)                                      ; bc = screen low address
    ex de, hl                                       ; hl = screen address

    or a                                            ; do a 16 bit compare                   
    sbc hl,bc
    add hl,bc

    ret nc                                          ; if the new screen address is above the end point flip direction

    ld a, down                                     ; down we go
    ld (ix + i_sb_sp_dir), a

    ret

move_down:

    ex de, hl                                        ; hl = screen_address, de = screen_address store
    add hl, bc                                       ; next line down

    ex de, hl                                        ; hl = screen_address_store, de = screen_address 
    ld (hl), e                                       ; store new position
    inc hl
    ld (hl), d
   
    inc hl                                           ; screen low adress store
    inc hl
    inc hl                                           ; screen high address store

    ld c, (hl)
    inc hl
    ld b, (hl)                                      ; bc = screen high address
    ex de, hl                                       ; hl = screen address

    or a                                            ; do a 16 bit compare                   
    sbc hl,bc
    add hl,bc

    ret c                                           ; if the new screen address is below the end point flip direction

    ld a, up                                        ; the only way is up
    ld (ix + i_sb_sp_dir), a

    ret

;
;  Animate to the next frame there are factoirs in play here
;   - Current frame number (ix + i_sb_anim_fr)
;   - frame skip (ix+i_sb_sp_const_skip)  const value for the number of frame renders 
;       to skip before incrementing the animation frame
;   - current frame skip (ix + i_sb_sp_curr_skip) decremented until the value is 0 
;       then the next frame is triggered and the value of curr skip is reset to const skip
;
;   IN - HL = sprite buffer
;        DE = current screen position
animate_frame:
    ld a, (ix + i_sb_sp_curr_skip)                  ; if the frame skip is 0 
    cp 0
    jr z, next_frame                                ; calc next frame
    dec a                                           ; otherwise decrement the frame skip
    ld (ix + i_sb_sp_curr_skip), a                  ; and just move the sprite if necessary
    ret

next_frame:
    ld a, (ix+i_sb_sp_const_skip)                   ; reset the frame skip
    ld (ix + i_sb_sp_curr_skip), a                  ; store for next time

    ld a, (ix + i_sb_anim_fr)						; retrieve frame counter
	inc a											; inc frame counter
	and 3											; mask significant bits
	ld (ix + i_sb_anim_fr), a						; store frame counter
    ret