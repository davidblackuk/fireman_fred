;---------------------------------------------------V--------------------

;
; IN: hl contains the level number
;
start_game:
    add hl, hl                                      ; hl contains the level number * 2
    ld de, levels                                   ; level list table start address
    add hl, de                                      ; move hl to point to the table entry for the current level
    
    ld e, (hl)
    inc hl
    ld d, (hl)
    ex de, hl                                       ; hl contains a pointer to the level defintion for the current level

	ld (currentLevel), hl                           ; save the address of the current level
	call initialize_level                           ; draw borders and other non sprite graphics

    ;call checkerboard                               ; debug call

    call store_attributes                           ; store the non sprite attributes once per leve

	call initialize_fred							; get the check chappy in place and ready to rock

	call initialize_sprites                         ; set up the sprites in their initial positions


game_loop:
    call read_keys
	call restore_backgrounds
	
	call move_fred
	call move_sprites
	call store_backgrounds
	
	call draw_sprites	
	    
    call transfer

    call restore_attributes                         ; remove the effects of the sprite render to the initial attribute map
   
	ld a, (fred_state)								; get freds state
    cp fred_is_dead									; did we die?
	jp z, @failed    								; we get to do the level over again	

    ; fake sucess / failure through key presses
    ld a, (key_map)
    bit n_pressed, a
	jp nz, @sucess			


	bit down_pressed, a		
	call nz, start_ambulance

	jp game_loop

@sucess:
    ld a, level_complete_sucess
    ret
@failed:
    ld a, level_complete_fail
    ret



initialize_level:

	ld ix, (currentLevel)
	call initialize_screen
	call cls_platform_map
	call draw_borders
	call draw_platforms
	call initialize_ambulance
	ret

initialize_screen:
	ld a, (ix + i_lvl_attr)							; clear the screen to the required color
	call cls_physical								; and clear the physical screen
	call cls_backbuffer
	ld a, (ix + i_lvl_border)						; set the border color from the level definition
	call BORDER
	ret

; address of the current level defn	
currentLevel:  .word 0



