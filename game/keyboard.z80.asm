;---------------------------------------------------V--------------------
; maintains a map of pressed keys once per call. Will
; allow multiple key presses to be detected (chording)
;
; we support wasd and space for movement and shift space for break out

;
; The speccy maps the keys to ports as follows (only 5 bits per row)
;
;   Port    Keys
;   32766   B, N, M, Symbol Shift, Space
;   49150   H, J, K, L, Enter
;   57342   Y, U, I, O, P
;   61438   6, 7, 8, 9, 0
;   63486   5, 4, 3, 2, 1
;   64510   T, R, E, W, Q
;   65022   G, F, D, S, A
;   65278   V, C, X, Z, Caps Shift

jump_pressed:     .equ 0
left_pressed:     .equ 1
right_pressed:    .equ 2
up_pressed:       .equ 3
down_pressed:     .equ 4
n_pressed:        .equ 5
m_pressed:        .equ 6

read_keys:
    ld e, 0                                         ; build up ytthe mask in e
    ld hl, key_map
    ld (hl), e                                      ; reset map to 0


    ld bc, 65022
    in a, (c)
test_a:
    bit 0, a                                        ; test if a pressed
    jp nz, test_s
    set left_pressed, e
test_s:
    bit 1, a                                        ; test if s pressed
    jp nz, test_d
    set down_pressed, e
test_d:
    bit 2, a                                        ; test if d pressed
    jp nz, test_w
    set right_pressed, e

test_w:
    ld bc, 64510
    in a, (c)
    bit 1, a                                        ; test if w pressed
    jp nz, test_n
    set up_pressed, e

test_n:
    ld bc, 32766
    in a, (c)
    bit 2, a                                        ; test if n pressed
    jp nz, test_m
    set n_pressed, e
test_m:
    bit 3, a                                        ; test if m pressed
    jp nz, test_space                               ; m is back to menu (testing)
    set m_pressed, e
test_space:
    bit 0, a                                        ; test if space pressed
    jp nz, test_complete                               
    set jump_pressed, e

test_complete:
     ld (hl), e
    ret

key_map: .byte 0

