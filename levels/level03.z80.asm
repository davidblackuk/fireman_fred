
;---------------------------------------------------V--------------------

level_03:
	.byte blue 							            ; tv border color
	.byte pBlue | white  				            ; default attributes	
	.byte sp_sid_03, sp_sid_03			            ; Left, right Side graphic
	.byte sp_sid_03						            ; Bottom graphic
	.byte magenta						            ; side and bottom colors
	
	BufferAddress(19, 19)							; ambulance start position
	BufferAddress(27, 19)							; ambulance end position
	PositionFred(17, 10)							; freds start position in the back buffer and other variables 	

	; plat x, y, dir, sprite, length, attrs
	.byte  1,  12, horizontal, sp_plt_03,  4, pBlue | cyan, plt_normal
	.byte  4,  13, vertical, sp_plt_03_1,  3, pBlue | cyan, plt_normal
	.byte  4,  16, horizontal, sp_plt_03_1,  4, pBlue | cyan, plt_normal
	.byte  7,  13, vertical, sp_plt_03_1,  3, pBlue | cyan, plt_normal
	
    .byte  7,  12, horizontal, sp_plt_03,  5, pBlue | cyan, plt_normal
	.byte  11,  13, vertical, sp_plt_03_1,  3, pBlue | cyan, plt_normal
	.byte  11,  16, horizontal, sp_plt_03_1,  4, pBlue | cyan, plt_normal
	.byte  14,  13, vertical, sp_plt_03_1,  3, pBlue | cyan, plt_normal
	

    .byte  14,  12, horizontal, sp_plt_03,  5, pBlue | cyan, plt_normal
	.byte  18,  13, vertical, sp_plt_03_1,  3, pBlue | cyan, plt_normal
	.byte  18,  16, horizontal, sp_plt_03_1,  4, pBlue | cyan, plt_normal
	.byte  21,  13, vertical, sp_plt_03_1,  3, pBlue | cyan, plt_normal
	
    .byte  21,  12, horizontal, sp_plt_03,  5, pBlue | cyan, plt_normal
    .byte  25,  13, vertical, sp_plt_03_1,  3, pBlue | cyan, plt_normal
    .byte  25,  16, horizontal, sp_plt_03_1,  4, pBlue | cyan, plt_normal
	.byte  28,  13, vertical, sp_plt_03_1,  3, pBlue | cyan, plt_normal


    .byte  28,  12, horizontal, sp_plt_03,  3, pBlue | cyan, plt_normal

    .byte 16, 10, vertical, 	 sp_ladder,  11, pBlue | white,   plt_ladder


	.byte last_definition

	; -------------------------------------------------------------------------------------------------------------------------
	; sprite definitions (upto 8) 
	; start addr, low addr, end addr, sprite no, start frame, path, length, dir, speed, attributes


  
	.word char_line_08 + 5							; scr address
	.word char_line_08 + 5							; lowest scr address
	.word char_line_14 + 5							; highest scr address
	SpriteGraphicAddresses(alien_bottle)			; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | green								; attributes
	.byte vertical									; type
	.byte down										; direction
    .byte 0                                          ; frame skip
    .byte 2                                          ; velocity (vertical)

	.word char_line_13 + 12							; scr address
	.word char_line_08 + 12							; lowest scr address
	.word char_line_14 + 12							; highest scr address
	SpriteGraphicAddresses(alien_bottle)			; set the sprite gfx
	.byte 2											; start frame 
	.byte pBlue | cyan								; attributes
	.byte vertical									; type
	.byte up										; direction
    .byte 1                                         ; frame skip
    .byte 1                                         ; velocity (vertical)

    .word char_line_09 + 19							; scr address
	.word char_line_08 + 19							; lowest scr address
	.word char_line_14 + 19							; highest scr address
	SpriteGraphicAddresses(alien_bottle)			; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | yellow							; attributes
	.byte vertical									; type
	.byte down										; direction
    .byte 1                                          ; frame skip
    .byte 1                                          ; velocity (vertical)

    .word char_line_13 + 26							; scr address
	.word char_line_08 + 26							; lowest scr address
	.word char_line_14 + 26							; highest scr address
	SpriteGraphicAddresses(alien_bottle)			; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte vertical									; type
	.byte up 										; direction
    .byte 0                                         ; frame skip
    .byte 2                                         ; velocity (vertical)


    ; -------------------------------------------------------------------------------------------------------------------------
	; first victim

    .word char_line_10 + 1							; scr address
	.word char_line_10 + 1							; lowest scr address
	.word char_line_10 + 1							; highest scr address
	SpriteGraphicAddresses(victim_2)				; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | magenta							; attributes
	.byte none  									; type
	.byte none										; direction
    .byte 2                                         ; frame skip
    .byte 0                                         ; velocity (vertical)

    .word char_line_10 + 29							; scr address
	.word char_line_10 + 29							; lowest scr address
	.word char_line_10 + 29							; highest scr address
	SpriteGraphicAddresses(victim_1)				; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | magenta							; attributes
	.byte none									    ; type
	.byte none										; direction
	.byte 3                                         ; frame skip
    .byte 0                                         ; velocity (vertical)
		
	.byte last_definition							; mark last sprite
			












