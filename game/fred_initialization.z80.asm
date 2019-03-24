;
; Initialization code for fred on a per level basis. Sets up
; the initial graphics and values, positions fred.
;


initialize_fred:
    push hl

    ld a, sprite_owned | sprite_enabled             ; Enabled for drawing, but we own the
    ld (fred_sprite), a                             ; update process for frames and position

    ; set low and current address to the definiton
    ld l, (IX + i_lvl_fred_start)                   
    ld h, (IX + i_lvl_fred_start + 1)
    ld (fred_current_address), hl                   ; we set hi low and current to same value
    ld (fred_lowest_address), hl                    ; as we control movement ourselves
    ld (fred_highest_address), hl

    ; copy movement state
    ld a, (ix + i_lvl_fred_x)                       ; pick up the column x of the start
    ld (fred_char_x), a                             ; store it in the move module
    ld a, (IX + i_lvl_fred_y)                       ; pick up the pixel row y
    ld (fred_char_y), a                            ; store it in the move module

    ; copy the background color of the level into our man fred
    ; may need to mask bg and add white fg?
    ld a, (ix + i_lvl_attr);
    ld (fred_sprite_attrs), a

    ; make sure to reset to start at frame 0
    ; could be set from previous level
    xor a
    ld (fred_current_frame), a
    ld (fred_drop_steps), a
    ld (fred_jump_step), a
    ld (fred_jump_pixel_offset), a
    
    ; always starts facing right
    ld a, right 
    ld (fred_direction), a

    ld a, fred_is_walking
    ld (fred_state), a

    ; set the sprites to the right facing ones
    call set_fred_facing_right



    pop hl
    ret


set_fred_facing_right:
    ld hl, fred_right_1
    ld (fred_sprite_address1), hl
    ld hl, fred_right_1 + 32
    ld (fred_sprite_address2), hl
    ld hl, fred_right_1 + 64
    ld (fred_sprite_address3), hl
    ld hl, fred_right_1 + 96
    ld (fred_sprite_address4), hl
ret

set_fred_facing_left:
    ld hl, fred_left_1
    ld (fred_sprite_address1), hl
    ld hl, fred_left_1 + 32
    ld (fred_sprite_address2), hl
    ld hl, fred_left_1 + 64
    ld (fred_sprite_address3), hl
    ld hl, fred_left_1 + 96
    ld (fred_sprite_address4), hl
ret