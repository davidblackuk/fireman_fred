;
; Code and storage for the ambulance. A little different from your standard sprite as it is rendered but 
; not animated until the game is over and only ever moves horizontally
;
; The ambulance is formed of two sprites one next to the other. Initialization sets the sprite buffer up with
; coorinates from the level definition and initializes the other sprite flags up to default values.


;
; IN: IX points to the level definition
;
; IX: Preserved
;
initialize_ambulance:
    push hl
    ; i_lvl_amb_start:
    ; i_lvl_amb_end:  

    ld IY, ambulance_sprite_data_1

    ld a, 1
    ld (IY + i_sb_flags), a                         ; sprite enabled

    ; sprite the first
    ; set low and current address to the definiton
    ld l, (IX + i_lvl_amb_start)
    ld h, (IX + i_lvl_amb_start + 1)
    ld (ambulance_1_current_address), hl
    ld (ambulance_1_lowest_address), hl

    ; sprite 2 goes right 16 pixels
    inc hl 
    inc hl
    ld (ambulance_2_current_address), hl
    ld (ambulance_2_lowest_address), hl

    ; set the end addresses
    ld l, (IX + i_lvl_amb_end)
    ld h, (IX + i_lvl_amb_end + 1)
    ld (ambulance_1_highest_address), hl
    inc hl 
    inc hl
    ld (ambulance_2_highest_address), hl

    ; set sprite 1 to use the same frame all the time
    ld hl, ambulance_1 
    ld (ambulance_1_sprite_addrress1), hl
    ld (ambulance_1_sprite_addrress2), hl
    ld (ambulance_1_sprite_addrress3), hl
    ld (ambulance_1_sprite_addrress4), hl

    ; set sprite 2 to use the same frame all the time
    ld hl, ambulance_2 
    ld (ambulance_2_sprite_addrress1), hl
    ld (ambulance_2_sprite_addrress2), hl
    ld (ambulance_2_sprite_addrress3), hl
    ld (ambulance_2_sprite_addrress4), hl

    ; set type is non to disable movement
    ld a, none
    call set_ambulance_state

    pop hl
    ret


start_ambulance:
    ; get it to move right from none
    ld a, horizontal
    call set_ambulance_state

    ; set the animation frames to the real 4
    ld hl, ambulance_1 + sprite_bytes * 0
    ld (ambulance_1_sprite_addrress1), hl

    ld hl, ambulance_1 + sprite_bytes * 1
    ld (ambulance_1_sprite_addrress2), hl
    ld hl, ambulance_1 + sprite_bytes * 2
    ld (ambulance_1_sprite_addrress3), hl
    ld hl, ambulance_1 + sprite_bytes * 3
    ld (ambulance_1_sprite_addrress4), hl

    ld hl, ambulance_2 + sprite_bytes * 0
    ld (ambulance_2_sprite_addrress1), hl
    ld hl, ambulance_2 + sprite_bytes * 1
    ld (ambulance_2_sprite_addrress2), hl
    ld hl, ambulance_2 + sprite_bytes * 2
    ld (ambulance_2_sprite_addrress3), hl
    ld hl, ambulance_2 + sprite_bytes * 3
    ld (ambulance_2_sprite_addrress4), hl
ret

set_ambulance_state 
    ld (ambulance_1_type), a
    ld (ambulance_2_type), a
ret
