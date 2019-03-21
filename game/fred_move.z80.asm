;
; This is the real meet of the game. the movement code for fred.
;
move_fred:
    ld a, (key_map)                                 ; pick up what keys are pressed
    bit left_pressed, a                             ; test if left pressed
    jp z, try_right                                 ; if not check right
call move_fred_left                                 ; otherwise move left
    ret
try_right:  
    bit right_pressed, a                            ; test if right was pressed
    call nz, move_fred_right                        ; if so, move him right
    ret

; --------------------------------------------------
; Rightwards movement
; --------------------------------------------------

move_fred_right:
    ld a, (fred_direction)                          ; get the current direction
    cp right                                        ; check if we were going left
    jp z, @continue_right                           ; we were, carry on lefting
    call about_face                                 ; swap direction and exit
    ret
@continue_right:  
    ld a, (fred_current_frame)                      ; Increment the frame number and that's it if 
    inc a                                           ; the frame is not over flowing.
    cp 4                                            ; If the frame is overflowing we need to move to the next pixel column.
    jp z, @next_pixel_column
    ld (fred_current_frame), a
    ret;    
@next_pixel_column
    xor a                                           ; Reset frame count to 0
    ld (fred_current_frame), a                      ; and store in the sprite buffer.
    ld hl, (fred_current_address)                   ; Get the current screen address
    inc hl                                          ; increment HL to next column
    ld (fred_current_address), hl                   ; and store in the sprite buffer.
    ret


; --------------------------------------------------
; Leftwards movement
; --------------------------------------------------

move_fred_left:
    ld a, (fred_direction)                          ; get the current direction
    cp left                                         ; check if we were going left
    jp z, @continue_left                            ; we were, carry on lefting
    call about_face                                 ; swap direction and exit
    ret
@continue_left:
    ld a, (fred_current_frame)                      ; Increment the frame number and that's it if 
    dec a                                           ; the frame is not over flowing.
    cp $ff                                          ; If the frame is overflowing we need to move to the next pixel column.
    jp z, @prev_pixel_column
    ld (fred_current_frame), a
    ret;
@prev_pixel_column
    ld a, 3                                         ; Reset frame count to 3
    ld (fred_current_frame), a                      ; and store in the sprite buffer.
    ld hl, (fred_current_address)                   ; Get the current screen address
    dec hl                                          ; increment HL to next column
    ld (fred_current_address), hl                   ; and store in the sprite buffer.
    ret

;
; Turn fred around. 
; IN: A = current direction
;
about_face: 
    cp right                                        ; Are we currently going right?
    jp nz, @test_left                               ; If not, process going left
ld a, left                                          ; set the new direction to left
    ld (fred_direction), a                          ; store the new direction
    call set_fred_facing_left                       ; update the fred graphics to the left facing ones
    ret
@test_left:
    cp left                                         ; check we are going left (and not up or down!)
ret nz                                              ; abort if not left
    ld a, right                                     ; set the new direction to right
    ld (fred_direction), a                          ; store the new direction
    call set_fred_facing_right                      ; update the fred graphics to the right facing ones
    ret