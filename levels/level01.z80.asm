;---------------------------------------------------V--------------------

level_01:   
	.byte black 							; tv border color
	.byte pBlack | white  					; default attributes	
	.byte sp_sid_01, sp_sid_01				; Left, right Side graphic
	.byte sp_bot_01							; Bottom graphic
	.byte red								; side and bottom colors

	.word char_line_19 + 5					; ambulance start position
	.word char_line_19 + 27					; ambulance end position
	.word char_line_16 + 11					; Fred's starting position
			

first_platform_defn_gap: .equ * - level_01			; defines the offset used by the patform renderer
	        ; plat x, y, dir, sprite, length, attrs

first_ever_platform:
	.byte 19,  8, horizontal, sp_plt_01, 11, magenta, plt_normal

platform_defn_len: .equ * - first_ever_platform
	.byte  1,  9, horizontal, sp_plt_01,  9, green,	 plt_normal
	.byte  4, 13, horizontal, sp_plt_01,  9, magenta, plt_normal
	.byte 19, 13, horizontal, sp_plt_01, 11, cyan,	 plt_normal
	.byte  1, 18, horizontal, sp_plt_01, 30, yellow,  plt_normal

	.byte  3,  6, vertical, 	 sp_ladder, 15, white,	 plt_ladder

	.byte 21,  6, vertical, 	 sp_ladder,  7, white,   plt_ladder
	.byte 27,  6, vertical, 	 sp_ladder,  7, white,   plt_ladder
	.byte 24, 11, vertical, 	 sp_ladder,  7, white,   plt_ladder

	.byte last_definition


	        ; -------------------------------------------------------------------------------------------------------------------------
	        ; sprite definitions (upto 8)
	        ;
			; if we change sprite definition,  change all others including the bulance and fred
			;
	        ; start addr, low addr, end addr, sprite no, start frame, path, length, dir, speed, attributes
first_spd:   .word char_line_11 + 6							; scr address
	         .word char_line_11 + 4							; lowest scr address
	         .word char_line_11 + 9							; highest scr address
	         .word alien_bulb + sprite_bytes * 0  			; frame 0
	         .word alien_bulb + sprite_bytes * 1      		; frame 1
	         .word alien_bulb + sprite_bytes * 2      		; frame 2
	         .word alien_bulb + sprite_bytes * 3      		; frame 3
	        .byte 0											; start frame 
	        .byte green										; attributes
	        .byte horizontal									; type
	        .byte right										; direction
            .byte 4                                          ; frame skip
            .byte 1                                          ; velocity (vertical)

sprite_definition_len: .equ  * - first_spd			

	         .word char_line_11 + 22							; scr address
	         .word char_line_11 + 22							; lowest scr address
	         .word char_line_11 + 26							; highest scr address
	         .word alien_bulb + sprite_bytes * 0  			; frame 0
	         .word alien_bulb + sprite_bytes * 1      		; frame 1
	         .word alien_bulb + sprite_bytes * 2      		; frame 2
	         .word alien_bulb + sprite_bytes * 3      		; frame 3
	        .byte 0											; start frame 
	        .byte cyan										; attributes
	        .byte horizontal									; type
	        .byte right										; direction
            .byte 0                                          ; frame skip
            .byte 1                                          ; velocity (vertical)

	        ; -------------------------------------------------------------------------------------------------------------------------
	        ; first victim

	         .word char_line_11 + 11							; scr address
	         .word char_line_11 + 11							; lowest scr address
	         .word char_line_11 + 11							; highest scr address
	         .word victim_1 + sprite_bytes * 0			    ; frame 0
	         .word victim_1 + sprite_bytes * 1    		    ; frame 1
	         .word victim_1 + sprite_bytes * 2    		    ; frame 2
	         .word victim_1 + sprite_bytes * 3    		    ; frame 3
	        .byte 0											; start frame 
	        .byte white										; attributes
	        .byte none										; type
	        .byte none										; direction
	        .byte 2                                          ; frame skip
            .byte 0                                          ; velocity (vertical)
		
			
	         .word char_line_11 + 28							; scr address
	         .word char_line_11 + 28							; lowest scr address
	         .word char_line_11 + 28							; highest scr address
	         .word victim_2 + sprite_bytes * 0			    ; frame 0
	         .word victim_2 + sprite_bytes * 1    		    ; frame 1
	         .word victim_2 + sprite_bytes * 2    		    ; frame 2
	         .word victim_2 + sprite_bytes * 3    		    ; frame 3
	        .byte 0											; start frame 
	        .byte magenta 									; attributes
	        .byte none										; type
	        .byte none										; direction
            .byte 2                                          ; frame skip
            .byte 0                                          ; velocity (vertical)



	        .byte last_definition	; mark last sprite








