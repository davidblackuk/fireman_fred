;
; This is the real meet of the game. the movement code for fred.
;
move_fred:
    call test_keys                                  ; respond to key presses and change state

    ld a, (fred_state)                              ; load updated state
    cp fred_is_jumping                              ; process the jump (y coordinate change) 
    jp z, jump_fred                                 ; jump fred will chain walk fred to animate x after y
    cp fred_is_walking                               
    jp z, walk_fred                                 ; animate fred if he is walkin
    cp fred_is_falling
    jp z, drop_fred                                 ; drop him if he is dropping
    ret

test_keys:
    ld a, (fred_state)                              ; if we are jumping then don't change
    cp fred_is_jumping                              ; state until the jump is finished
    ret z
    cp fred_is_falling                              ; are we falling?
    ret z                                           ; no change if falling either

    ld a, (key_map)                                 ; pick up current keys
    bit left_pressed, a                             ; test if left pressed
    jp z, @try_right                                ; if not check right
    ld a, walk_left                                 ; otherwise move left
    ld (fred_walk_direction), a                     ; set the man to the left
    call check_if_jump_pressed                      ; set state to jumping if necessary and remember the walk direction
    ret
@try_right:  
    bit right_pressed, a                            ; test if right was pressed
    jp z, @no_direction                              
    ld a, walk_right                                ; otherwise move right
    ld (fred_walk_direction), a                     ; set the man off to the right
    call check_if_jump_pressed                      ; set state to jumping if necessary and remember the walk direction
    ret
@no_direction:
    ld a, walk_none                                 ; we're going nowhere, fast
    ld (fred_walk_direction), a                     ; set the boi off to the left
    call check_if_jump_pressed                      ; set state to jumping if necessary and remember the walk direction
    ret

check_if_jump_pressed:
    ld a, (key_map) 
    bit jump_pressed, a                             ; are we starting a jump (we never call this method is a jump is in progress)
    ret z                                           ; if not check right
    ld a, fred_is_jumping                           ; the state flag for jumping
    ld (fred_state), a                              ; BOING!!
    ret

jump_fred:
    call process_jump_step
    call fred_pixel_address_to_charY                
    
    ; TODO
    ; JUMP gets caught on the middle of blocks!
    ; JUMP NOT TESTING ABOVE FOR BLOCKERS
    ; jump still very 45 degrees
    call walk_fred
    ret

walk_fred:
    call test_fred_is_supported                     ; are we about to fall?
    ld a, (fred_state)                              ; pick up tyhe potential new state
    cp fred_is_falling                              ; are we infact falling?
    jp z, drop_fred                                 ; if so, go off and do the fall

    ld a, (fred_walk_direction)                     ; pick up what keys are pressed
    cp walk_left                                    ; test if walking left pressed
    jp z, move_fred_left                            ; if so branch to that path
    cp walk_right                                   ; test if walking left pressed
    jp z, move_fred_right                           ; if so branch to that path
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

    ld a, (fred_state)                              ; get fred's state
    cp fred_is_jumping                              ; are we jumping
    jp nz, @continue                                ; if not check if there is a platform underneath and act accordingly
    ld a, (fred_jump_dir)                           ; now check if we are jumping up 
    cp up                                           ; if we are skip the check otherwise 
    ret z                                           ; we are jumping down and need to check for a platform
@continue
    ld a, (fred_char_y)                             ; pick up character y
    ld l, a                                         ; put in l
    inc l
    inc l
    ld a, (fred_char_x)                             ; get the character x
    ld h, a                                         ; HL = new X,Y    
    call check_if_supports_fred                     ; check the map
    jp z, set_falling                               ; not supported keep falling
    call reset_to_walking                           ; just in case we were in mid jump
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
    ld a, (fred_state)                              ; get fred's state
    cp fred_is_jumping                              ; are we jumping
    ret z                                           ; don't set falling mid jump
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

;
; Jumping
;

process_jump_step: 

    ld hl, fred_jump_table                          ; jump table for steps in the animation
    ld a, (fred_jump_step)                          ; current step number
    ld e, a
    ld d, 0                                         ; de = step number
    add hl, de                                      ; hl points to byte for this step
    inc a                                           ; inc counter for next time
    ld (fred_jump_step), a                          ; store the step counter

    ld a, (hl)                                      ; read the direction for this step
    ld hl, (fred_current_address)                   ; hl is address of fred
    ld de, screen_width_chars * 2                   ; de is step offset up or down

    cp up                                           ; test direction
    jp z, @jump_up                                  ; process up
    cp down             
    jp z, @jump_down                                ; preoces down
    cp $ff
    jp z, reset_to_walking                          ; process end of animation
    ret                                             ; process skipped step

@jump_down:                                         ; greater than 11 we are going down
    ld (fred_jump_dir), a                           ; store direction
	add hl, de										; hl = offset into the attribute map of original bc positio
    ld (fred_current_address), hl                   ; store new address
    ret

@jump_up:
    ld (fred_jump_dir), a
    or a											; reset the carry flag
	sbc hl, de										; hl = offset into the attribute map of original bc positio
    ld (fred_current_address), hl
    ret
reset_to_walking:
    ld a, fred_is_walking
    ld (fred_state), a
    xor a
    ld (fred_jump_step), a
    ret

fred_pixel_address_to_charY
    ld hl, (fred_current_address)                   ; get address in the back buffer for fred
    ld de, char_line_00                             ; start address of the buffer
    or a
    sbc hl, de                                      ; HL = offset in the buffer of the start of fred
    ld a, (fred_char_x)
    ld e, a
    ld d, 0
    or a
    sbc hl, de                                      ; subtract x coordinate to bet line start

    srl h                                           ; HL = HL / 32 * 8
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l                                            ; hl = hl / 32 = pixel y

    srl h
    rr l
    srl h
    rr l
    srl h
    rr l                                            ; hl = hl / 8 = char y


    ld a, l
    LD (fred_char_y), a                             ; store the y coordinate
    ret

; --------------------------------------------------
; variables for fred's move ment
; --------------------------------------------------

; These variables are used to locate fred in the world
fred_char_x: .byte 0                                ; current character x
fred_char_y: .byte 0                                ; current character y
fred_jump_dir: .byte 0
; freds current state walking, falling or jumping
fred_state: .byte 0
fred_drop_steps: .byte 0

fred_jump_step: .byte 0                             ; how far through the total jump are we
fred_walk_direction: .byte 0

fred_jump_table: .byte up, up, up, up, up, up, up, up, up, up,
                .byte 0
                .byte down, down, down, down, down, down, down, down, down, down    
                .byte $ff