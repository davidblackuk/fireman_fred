;---------------------------------------------------V--------------------

; char x, pixel y, sprite no, start frame, path, length, dir, speed, attributes
sprt_0:
	.byte 0											; flags
	.storage sprite_definition_len                      ; sprite definition (see level001.z8asm)
    .byte 0                                          ; current frameskip value
sprt_bg_offset: .equ * - sprt_0
	.storage sprite_bytes								; sprite background
sprt_buff_len: .equ * - sprt_0

sprite_1: .storage sprt_buff_len
sprite_2: .storage sprt_buff_len
sprite_3: .storage sprt_buff_len
sprite_4: .storage sprt_buff_len
sprite_5: .storage sprt_buff_len
sprite_6: .storage sprt_buff_len
sprite_7: .storage sprt_buff_len

; --------------------------------
; These are the static sprites present on all
; levels (the ambulance (2) and fred (1)
; --------------------------------

ambulance_sprite_data_1:
	.byte 1											; flags: 0 = off 1 = in use

    .word scan_line_088 + 6							; scr address
    .word scan_line_088 + 6							; lowest scr address
    .word scan_line_088 + 6							; highest scr address
    .word ambulance_1 + sprite_bytes * 0  			; frame 0
    .word ambulance_1 + sprite_bytes * 1      		; frame 1
    .word ambulance_1 + sprite_bytes * 0      		; frame 2
    .word ambulance_1 + sprite_bytes * 1      		; frame 3
    .byte 0											; start frame 
    .byte green										; attributes
    .byte none								; type
    .byte none										; direction
    .byte 0                                         ; frame skip
    .byte 1                                         ; velocity (vertical)

	.byte 0											; current frame skip
	.storage sprite_bytes							; copy of background

ambulance_sprite_data_2:
	.byte 1											; flags: 0 = off 1 = in use

    .word scan_line_088 + 8							; scr address
    .word scan_line_088 + 8							; lowest scr address
    .word scan_line_088 + 8							; highest scr address
    .word ambulance_2 + sprite_bytes * 0  			; frame 0
    .word ambulance_2 + sprite_bytes * 1      		; frame 1
    .word ambulance_2 + sprite_bytes * 0      		; frame 2
    .word ambulance_2 + sprite_bytes * 1      		; frame 3
    .byte 0											; start frame 
    .byte green										; attributes
    .byte none	        							; type
    .byte none										; direction
    .byte 0                                         ; frame skip
    .byte 1                                         ; velocity (vertical)

	.byte 0											; current frame skip
	.storage sprite_bytes							; copy of background

fred_sprite_data:
	.byte 1											; flags: 0 = off 1 = in use

    .word scan_line_100 + 8							; scr address
    .word scan_line_100 + 8							; lowest scr address
    .word scan_line_100 + 8							; highest scr address
    .word fred_right_1 + sprite_bytes * 0  			; frame 0
    .word fred_right_1 + sprite_bytes * 1      		; frame 1
    .word fred_right_1 + sprite_bytes * 0      		; frame 2
    .word fred_right_1 + sprite_bytes * 1      		; frame 3
    .byte 0											; start frame 
    .byte green										; attributes
    .byte none	        							; type
    .byte none										; direction
    .byte 4                                         ; frame skip
    .byte 1                                         ; velocity (vertical)

	.byte 0											; current frame skip
	.storage sprite_bytes							; copy of background
