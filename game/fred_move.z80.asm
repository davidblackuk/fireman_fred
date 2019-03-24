;
; This is the real meet of the game. the movement code for fred.
;
move_fred:
    ld a, (fred_state)
    cp fred_is_walking
    jp z, walk_fred    
    cp fred_is_falling
    jp z, drop_fred
    ret

walk_fred:
    call test_fred_is_supported                     ; are we about to fall?
    ld a, (fred_state)
    cp fred_is_falling
    jp z, drop_fred

    ld a, (key_map)                                 ; pick up what keys are pressed
    bit left_pressed, a                             ; test if left pressed
    jp z, try_right                                 ; if not check right
    call move_fred_left                             ; otherwise move left
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

    ld a, (fred_char_y)                             ; pick up character y
    ld l, a                                         ; put in l
    ld a, (fred_char_x)                             ; get the character x
    inc a                                           ; calc next position
    ld h, a                                         ; HL = new X,Y
    inc h                                           ; the test is passed our 2 character sprite

    push af
    call check_if_blocked_walking                   ; can we enter that cell?
    jp z, not_blocked_right                         ; yes we can, so process it
    pop af                                          ; we cant move so return
    ret                                             

not_blocked_right:
    pop af
    ld (fred_char_x), a   
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
    
    ld a, (fred_char_y)                             ; pick up character y
    ld l, a                                         ; put in l
    ld a, (fred_char_x)                             ; get the character x
    dec a                                           ; calc next position
    ld h, a                                         ; HL = new X,Y
    
    push af
    call check_if_blocked_walking                   ; can we enter that cell?
    jp z, not_blocked_left                         ; yes we can, so process it
    pop af                                          ; we cant move so return
    ret                                             

not_blocked_left:
    pop af
    ld (fred_char_x), a                             ; store for next time

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


test_fred_is_supported:     
    ld a, (fred_char_y)                             ; pick up character y
    ld l, a                                         ; put in l
    inc l
    inc l
    ld a, (fred_char_x)                             ; get the character x
    ld h, a                                         ; HL = new X,Y    
call check_if_supports_fred                         ; check the map
    jp z, set_falling                               ; not supported keep falling
    ld a, fred_is_walking                           ; set state to walking BUT
    ld (fred_state), a  

    ld a, (fred_drop_steps)                         ; check the drop steps to see if we died
    and %11110000                                   ; more than 32*2 pixels ?
    jp z, live_another_day                          ; No keep on trucking
    ld a, fred_is_dead                              ; we dieed a terrible death
    ld (fred_state), a                              ; that's this level over
    ret
    
live_another_day:
    xor a                                           ; reset the drop steps for next time
    ld (fred_drop_steps), a                         ; store it
    ret

set_falling:
    ld a, fred_is_falling                           ; set the state to falling
    ld (fred_state), a
    ret

;
; Dropping
;

drop_fred:
    call test_fred_is_supported                     ; are we still falling?
    ld a, (fred_state)
    cp fred_is_falling
    ret nz                                          ; keep falling    

    ld a, (fred_drop_steps)                         ; next drop
    inc a                                           ; position is pixels * 2                                           
    ld (fred_drop_steps), a                         ; store it

    And %0011                                       ; if lowest 4 bits are zero
    jp nz, mid_fall                                 ; we are enterin a new char row
    ld a, (fred_char_y)                             ; set the variables to that new row
    inc a                                           ;
    ld (fred_char_y), a                             ; fred_char_y += 1

mid_fall:
    ld de, screen_width_chars * 2                   ; two pixel y jump
    ld hl, (fred_current_address)                   ; Get the current screen address
    add hl, de                                      ; drop in 2 pixel steps
    ld (fred_current_address), hl                   ; and store in the sprite buffer.
  
    ret

; --------------------------------------------------
; variables for fred's move ment
; --------------------------------------------------

; These variables are used to locate fred in the world
fred_char_x: .byte 0                                ; current character x
fred_char_y .byte 0                                ; current character y

; freds current state walking, falling or jumping
fred_state: .byte 0
fred_drop_steps: .byte 0