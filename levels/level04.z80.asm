;---------------------------------------------------V--------------------

level_04:
	.byte black 							        ; tv border color
	.byte pBlack | white  				            ; default attributes	
	.byte sp_lsid_04, sp_rsid_04					; Left, right Side graphic
	.byte sp_bot_04						            ; Bottom graphic
	.byte cyan						            	; side and bottom colors
	
	.word char_line_05 + 9							; ambulance start position
	.word char_line_05 + 27							; ambulance end position
	.word char_line_05 + 5							; Fred's starting position

	; plat x, y, dir, sprite, length, attrs
	.byte  1,  18, horizontal, sp_plt_04,  30, pBlack | cyan, plt_normal

	.byte  1,  13, horizontal, sp_plt_04,  5, pBlack | yellow, plt_normal
	.byte  8,  13, horizontal, sp_plt_04,  4, pBlack | yellow, plt_normal
	.byte  14,  13, horizontal, sp_plt_04,  6, pBlack | yellow, plt_normal
	.byte  22,  13, horizontal, sp_plt_04,  8, pBlack | yellow, plt_normal

	.byte  1,  7, horizontal, sp_plt_04,  30, pBlack | white, plt_normal

    .byte 3, 4, vertical, sp_ladder,  9, pBlack | white,   plt_ladder
    .byte 27, 11, vertical, sp_ladder,  7, pBlack | white,   plt_ladder


	.byte last_definition

	; -------------------------------------------------------------------------------------------------------------------------
	; sprite definitions (upto 8) 
	; start addr, low addr, end addr, sprite no, start frame, path, length, dir, speed, attributes


  
	 .word scan_line_091 + 6							; scr address
	 .word scan_line_068 + 6							; lowest scr address
	 .word scan_line_124 + 6							; highest scr address
	 .word alien_smoke + sprite_bytes * 0			; frame 0
	 .word alien_smoke + sprite_bytes * 1			; frame 1
	 .word alien_smoke + sprite_bytes * 2			; frame 2
	 .word alien_smoke + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlack | yellow								; attributes
	.byte vertical									; type
	.byte down										; direction
    .byte 0                                          ; frame skip
    .byte 1                                          ; velocity (vertical)

	 .word scan_line_091 + 12							; scr address
	 .word scan_line_068 + 12							; lowest scr address
	 .word scan_line_124 + 12							; highest scr address
	 .word alien_smoke + sprite_bytes * 0			; frame 0
	 .word alien_smoke + sprite_bytes * 1			; frame 1
	 .word alien_smoke + sprite_bytes * 2			; frame 2
	 .word alien_smoke + sprite_bytes * 3			; frame 3
	.byte 2											; start frame 
	.byte pBlack | yellow								; attributes
	.byte vertical									; type
	.byte up										    ; direction
    .byte 1                                          ; frame skip
    .byte 1                                          ; velocity (vertical)

     .word scan_line_070 + 20							; scr address
	 .word scan_line_068 + 20							; lowest scr address
	 .word scan_line_124 + 20							; highest scr address
	 .word alien_smoke + sprite_bytes * 0			; frame 0
	 .word alien_smoke + sprite_bytes * 1			; frame 1
	 .word alien_smoke + sprite_bytes * 2			; frame 2
	 .word alien_smoke + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlack | yellow								; attributes
	.byte vertical									; type
	.byte down										; direction
    .byte 1                                          ; frame skip
    .byte 1                                          ; velocity (vertical)

     .word scan_line_088 + 24							; scr address
	 .word scan_line_088 + 22							; lowest scr address
	 .word scan_line_088 + 29							; highest scr address
	 .word alien_bounce_ball + sprite_bytes * 0			; frame 0
	 .word alien_bounce_ball + sprite_bytes * 1			; frame 1
	 .word alien_bounce_ball + sprite_bytes * 2			; frame 2
	 .word alien_bounce_ball + sprite_bytes * 3			; frame 3
	.byte 0											; start frame 
	.byte pBlack | cyan								; attributes
	.byte horizontal									; type
	.byte up 										; direction
    .byte 0                                          ; frame skip
    .byte 1                                          ; velocity (vertical)


    ; -------------------------------------------------------------------------------------------------------------------------
	; first victim

     .word scan_line_128 + 2							; scr address
	 .word scan_line_128 + 2							; lowest scr address
	 .word scan_line_128 + 2							; highest scr address
	 .word victim_cat1 + sprite_bytes * 0		    	; frame 0
	 .word victim_cat1 + sprite_bytes * 1		    	; frame 1
	 .word victim_cat1 + sprite_bytes * 2		    	; frame 2
	 .word victim_cat1 + sprite_bytes * 3		    	; frame 3
	.byte 0											; start frame 
	.byte pBlack | white							; attributes
	.byte none  									    ; type
	.byte none										; direction
    .byte 2                                          ; frame skip
    .byte 0                                          ; velocity (vertical)

		
	.byte last_definition							; mark last sprite
			












