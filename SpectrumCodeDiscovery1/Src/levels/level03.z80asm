
;---------------------------------------------------V--------------------

level_03:
	.byte blue 							            ; tv border color
	.byte pBlue | white  				            ; default attributes	
	.byte sp_sid_03, sp_sid_03			            ; Left, right Side graphic
	.byte sp_sid_03						            ; Bottom graphic
	.byte magenta						            ; side and bottom colors

	; plat x, y, dir, sprite, length, attrs
	.byte  1,  12, horizontal, sp_plt_03,  4, pBlue | cyan, plt_normal
	.byte  4,  13, vertical, sp_plt_04,  3, pBlue | cyan, plt_normal
	.byte  4,  16, horizontal, sp_plt_04,  4, pBlue | cyan, plt_normal
	.byte  7,  13, vertical, sp_plt_04,  3, pBlue | cyan, plt_normal
	
    .byte  7,  12, horizontal, sp_plt_03,  5, pBlue | cyan, plt_normal
	.byte  11,  13, vertical, sp_plt_04,  3, pBlue | cyan, plt_normal
	.byte  11,  16, horizontal, sp_plt_04,  4, pBlue | cyan, plt_normal
	.byte  14,  13, vertical, sp_plt_04,  3, pBlue | cyan, plt_normal
	

    .byte  14,  12, horizontal, sp_plt_03,  5, pBlue | cyan, plt_normal
	.byte  18,  13, vertical, sp_plt_04,  3, pBlue | cyan, plt_normal
	.byte  18,  16, horizontal, sp_plt_04,  4, pBlue | cyan, plt_normal
	.byte  21,  13, vertical, sp_plt_04,  3, pBlue | cyan, plt_normal
	
    .byte  21,  12, horizontal, sp_plt_03,  5, pBlue | cyan, plt_normal
    .byte  25,  13, vertical, sp_plt_04,  3, pBlue | cyan, plt_normal
    .byte  25,  16, horizontal, sp_plt_04,  4, pBlue | cyan, plt_normal
	.byte  28,  13, vertical, sp_plt_04,  3, pBlue | cyan, plt_normal


    .byte  28,  12, horizontal, sp_plt_03,  3, pBlue | cyan, plt_normal

    .byte 16, 10, vertical, 	 sp_ladder,  11, pBlue | white,   plt_ladder


	.byte last_definition

	; -------------------------------------------------------------------------------------------------------------------------
	; sprite definitions (upto 8) 
	; start addr, low addr, end addr, sprite no, start frame, path, length, dir, speed, attributes


  
	 .word scan_line_068 + 5							; scr address
	 .word scan_line_068 + 5							; lowest scr address
	 .word scan_line_106 + 5							; highest scr address
	 .word alien_bottle + sprite_bytes * 0			; frame 0
	 .word alien_bottle + sprite_bytes * 1			; frame 1
	 .word alien_bottle + sprite_bytes * 2			; frame 2
	 .word alien_bottle + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlue | green								; attributes
	.byte vertical									; type
	.byte down										; direction
    .byte 0                                          ; frame skip
    .byte 2                                          ; velocity (vertical)

	 .word scan_line_106 + 12							; scr address
	 .word scan_line_068 + 12							; lowest scr address
	 .word scan_line_106 + 12							; highest scr address
	 .word alien_bottle + sprite_bytes * 0			; frame 0
	 .word alien_bottle + sprite_bytes * 1			; frame 1
	 .word alien_bottle + sprite_bytes * 2			; frame 2
	 .word alien_bottle + sprite_bytes * 3			; frame 3
	.byte 2											; start frame 
	.byte pBlue | cyan								; attributes
	.byte vertical									; type
	.byte up										    ; direction
    .byte 1                                          ; frame skip
    .byte 1                                          ; velocity (vertical)

     .word scan_line_070 + 19							; scr address
	 .word scan_line_068 + 19							; lowest scr address
	 .word scan_line_106 + 19							; highest scr address
	 .word alien_bottle + sprite_bytes * 0			; frame 0
	 .word alien_bottle + sprite_bytes * 1			; frame 1
	 .word alien_bottle + sprite_bytes * 2			; frame 2
	 .word alien_bottle + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlue | yellow								; attributes
	.byte vertical									; type
	.byte down										; direction
    .byte 1                                          ; frame skip
    .byte 1                                          ; velocity (vertical)

     .word scan_line_104 + 26							; scr address
	 .word scan_line_068 + 26							; lowest scr address
	 .word scan_line_106 + 26							; highest scr address
	 .word alien_bottle + sprite_bytes * 0			; frame 0
	 .word alien_bottle + sprite_bytes * 1			; frame 1
	 .word alien_bottle + sprite_bytes * 2			; frame 2
	 .word alien_bottle + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte vertical									; type
	.byte up 										; direction
    .byte 0                                          ; frame skip
    .byte 2                                          ; velocity (vertical)


    ; -------------------------------------------------------------------------------------------------------------------------
	; first victim

     .word scan_line_080 + 1							; scr address
	 .word scan_line_080 + 1							; lowest scr address
	 .word scan_line_080 + 1							; highest scr address
	 .word victim_3 + sprite_bytes * 0		    	; frame 0
	 .word victim_3 + sprite_bytes * 1		    	; frame 1
	 .word victim_3 + sprite_bytes * 2		    	; frame 2
	 .word victim_3 + sprite_bytes * 3		    	; frame 3
	.byte 0											; start frame 
	.byte pBlue | magenta							; attributes
	.byte none  									    ; type
	.byte none										; direction
    .byte 2                                          ; frame skip
    .byte 0                                          ; velocity (vertical)

     .word scan_line_080 + 29							; scr address
	 .word scan_line_080 + 29							; lowest scr address
	 .word scan_line_080 + 29							; highest scr address
	 .word victim_2 + sprite_bytes * 0		    	; frame 0
	 .word victim_2 + sprite_bytes * 1		    	; frame 1
	 .word victim_2 + sprite_bytes * 2		    	; frame 2
	 .word victim_2 + sprite_bytes * 3		    	; frame 3
	.byte 0											; start frame 
	.byte pBlue | magenta							; attributes
	.byte none									    ; type
	.byte none										; direction
	.byte 3                                         ; frame skip
    .byte 0                                          ; velocity (vertical)
		
	.byte last_definition							; mark last sprite
			












