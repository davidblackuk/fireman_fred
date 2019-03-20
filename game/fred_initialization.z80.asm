;
; Initialization code for fred on a per level basis. Sets up
; the initial graphics and values, positions fred.
;


initialize_fred:
    push hl

    ld a, 1
    ld (fred_sprite), a                         ; sprite enabled

    ; set low and current address to the definiton
    ld l, (IX + i_lvl_fred_start)
    ld h, (IX + i_lvl_fred_start + 1)
    ld (fred_current_address), hl
    ld (fred_lowest_address), hl
    ld (fred_highest_address), hl


    ; copy the background color of the level into our ambulance
    ; may need to mask bg and add white fg?
    ld a, (ix + i_lvl_attr);
    ld (fred_sprite_attrs), a

    ; make sure to reset to start at frame 0
    ; could be set from previous level
    xor a
    ld (fred_current_frame), a

    ; always starts facing right
    ld a, right 
    ld (fred_direction), a

    pop hl
    ret
t
