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
ambulance_1_current_address: .word 0                ; currennt screeen address
ambulance_1_lowest_address:  .word 0             	; lowest screen address
ambulance_1_highest_address: .word 0                ; highest screen address
ambulance_1_sprite_address1: .word 0     			; frame 0
ambulance_1_sprite_address2: .word 0     			; frame 1
ambulance_1_sprite_address3: .word 0     			; frame 2
ambulance_1_sprite_address4: .word 0     			; frame 3
ambulance_1_current_frame:    .byte 0				; current frame 
ambulance_1_sprite_attrs: .byte white				; attributes
ambulance_1_type: .byte horizontal                  ; type always horizontal
ambulance_1_direction: .byte right                  ; direction 
    .byte 0                                         ; frame skip
    .byte 1                                         ; velocity 
	.byte 0											; current frame skip
	.storage sprite_bytes							; copy of background


ambulance_sprite_data_2:
	.byte 1											; flags: 0 = off 1 = in use
ambulance_2_current_address: .word 0                ; currennt screeen address
ambulance_2_lowest_address:  .word 0             	; lowest screen address
ambulance_2_highest_address: .word 0                ; highest screen address
ambulance_2_sprite_address1: .word 0     			; frame 0
ambulance_2_sprite_address2: .word 0     			; frame 1
ambulance_2_sprite_address3: .word 0     			; frame 2
ambulance_2_sprite_address4: .word 0     			; frame 3
ambulance_2_current_frame:    .byte 0				; current frame 
ambulance_2_sprite_attrs: .byte white				; attributes
ambulance_2_type: .byte none                        ; type
ambulance_2_direction: .byte right                  ; direction
    .byte 0                                         ; frame skip
    .byte 1                                         ; velocity (horizontal)

	.byte 0											; current frame skip
	.storage sprite_bytes							; copy of background



fred_sprite:
	.byte 1											; flags: 0 = off 1 = in use
fred_current_address: .word scan_line_100           ; current screen address
fred_lowest_address:  .word scan_line_100           ; lowest screen address
fred_highest_address: .word scan_line_100           ; highest screen address
fred_sprite_address1: .word fred_right_1            ; frame 0
fred_sprite_address2: .word fred_right_1            ; frame 1
fred_sprite_address3: .word fred_right_1            ; frame 2
fred_sprite_address4: .word fred_right_1            ; frame 3
fred_current_frame:    .byte 0				        ; current frame 
fred_sprite_attrs: .byte white				        ; attributes
fred_type: .byte none                               ; type none, we control all movement
fred_direction: .byte right                         ; direction 
    .byte 0                                         ; frame skip
    .byte 1                                         ; velocity 
	.byte 0											; current frame skip
	.storage sprite_bytes							; copy of background
