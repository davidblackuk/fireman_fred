
;---------------------------------------------------V--------------------

level_02:
	.byte blue 							; tv border color
	.byte pBlue | white  				; default attributes	
	.byte sp_sid_02, sp_sid_02			; Left, right Side graphic
	.byte sp_bot_02						; Bottom graphic
	.byte magenta						; side and bottom colors

	; plat x, y, dir, sprite, length, attrs
	.byte  1,  8, horizontal, sp_plt_02,  8, pBlue | green, plt_normal
	.byte  8, 10, horizontal, sp_plt_02,  3, pBlue | cyan, plt_normal
	.byte 12, 12, horizontal, sp_plt_02,  2, pBlue | magenta, plt_normal
	.byte 24, 12, horizontal, sp_plt_02,  5, pBlue | yellow, plt_normal
	.byte 11, 14, horizontal, sp_plt_02, 10, pBlue | red, plt_normal
	.byte 21, 16, horizontal, sp_plt_02, 10, pBlue | magenta, plt_normal
	.byte 14, 18, horizontal, sp_plt_02, 4,  pBlue | green, plt_normal

	.byte 13, 15, vertical, 	 sp_ladder,  6, pBlue | white, plt_ladder
	.byte 16, 12, vertical, 	 sp_ladder,  6, pBlue | white, plt_ladder
	.byte 29, 10, vertical, 	 sp_ladder,  7, pBlue | white, plt_ladder

	.byte last_definition

	; -------------------------------------------------------------------------------------------------------------------------
	; sprite definitions (upto 8) 
	; start addr, low addr, end addr, sprite no, start frame, path, length, dir, speed, attributes

	 .word scan_line_112 + 22							; scr address
	 .word scan_line_112 + 21							; lowest scr address
	 .word scan_line_112 + 24							; highest scr address
	 .word alien_invader1 + sprite_bytes * 0			; frame 0
	 .word alien_invader1 + sprite_bytes * 1			; frame 1
	 .word alien_invader1 + sprite_bytes * 2			; frame 2
	 .word alien_invader1 + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlue | yellow								; attributes
	.byte horizontal									; type
	.byte right										; direction
    .byte 0                                          ; frame skip
    .byte 0                                          ; velocity (vertical)

	 .word scan_line_112 + 27							; scr address
	 .word scan_line_112 + 28							; lowest scr address
	 .word scan_line_112 + 29							; highest scr address
	 .word alien_invader1 + sprite_bytes * 0			; frame 0
	 .word alien_invader1 + sprite_bytes * 1			; frame 1
	 .word alien_invader1 + sprite_bytes * 2			; frame 2
	 .word alien_invader1 + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte horizontal									; type
	.byte right										; direction
    .byte 0                                          ; frame skip
    .byte 0                                          ; velocity (vertical)

	 .word scan_line_152 + 4							; scr address
	 .word scan_line_152 + 3							; lowest scr address
	 .word scan_line_152 + 10							; highest scr address
	 .word alien_invader1 + sprite_bytes * 0			; frame 0
	 .word alien_invader1 + sprite_bytes * 1			; frame 1
	 .word alien_invader1 + sprite_bytes * 2			; frame 2
	 .word alien_invader1 + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte horizontal									; type
	.byte right										; direction
    .byte 0                                          ; frame skip
    .byte 0                                          ; velocity (vertical)


	 ; -------------------------------------------------------------------------------------------------------------------------
	 ; first victim

	 .word scan_line_112 + 26							; scr address
	 .word scan_line_112 + 26							; lowest scr address
	 .word scan_line_112 + 26							; highest scr address
	 .word victim_2 + sprite_bytes * 0			    ; frame 0
	 .word victim_2 + sprite_bytes * 1    		    ; frame 1
	 .word victim_2 + sprite_bytes * 2    		    ; frame 2
	 .word victim_2 + sprite_bytes * 3    		    ; frame 3
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte none										; type
	.byte none										; direction
    .byte 2                                          ; frame skip
    .byte 0                                          ; velocity (vertical)
		
	 .word scan_line_152 + 5							; scr address
	 .word scan_line_152 + 5							; lowest scr address
	 .word scan_line_152 + 5							; highest scr address
	 .word victim_3 + sprite_bytes * 0			    ; frame 0
	 .word victim_3 + sprite_bytes * 1    		    ; frame 1
	 .word victim_3 + sprite_bytes * 2    		    ; frame 2
	 .word victim_3 + sprite_bytes * 3    		    ; frame 3
	.byte 0											; start frame 
	.byte pBlue | magenta							; attributes
	.byte none										; type
	.byte none										; direction
    .byte 2                                          ; frame skip
    .byte 0                                          ; velocity (vertical)
		
     .word scan_line_080 + 26							; scr address
	 .word scan_line_080 + 26							; lowest scr address
	 .word scan_line_080 + 26							; highest scr address
	 .word victim_1 + sprite_bytes * 0			    ; frame 0
	 .word victim_1 + sprite_bytes * 1    		    ; frame 1
	 .word victim_1 + sprite_bytes * 2    		    ; frame 2
	 .word victim_1 + sprite_bytes * 3    		    ; frame 3
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte none										; type
	.byte none										; direction
    .byte 2                                          ; frame skip
    .byte 0                                          ; velocity (vertical)
		

    .byte last_definition	; mark last sprite









