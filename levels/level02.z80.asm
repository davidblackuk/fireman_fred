

level_02:
	.byte blue 										; tv border color
	.byte pBlue | white  							; default attributes	
	.byte sp_sid_02, sp_sid_02						; Left, right Side graphic
	.byte sp_bot_02									; Bottom graphic
	.byte magenta									; side and bottom colors
	
	BufferAddress(15, 19)							; ambulance start position
	BufferAddress(27, 19)							; ambulance end position
	PositionFred(8, 6)								; freds start position in the back buffer and other variables	

	; plat x, y, dir, sprite, length, attrs
	.byte  1,  8, horizontal, sp_plt_02,  8, pBlue | green, plt_normal
	.byte  8, 10, horizontal, sp_plt_02,  3, pBlue | cyan, plt_normal
	.byte 12, 12, horizontal, sp_plt_02,  2, pBlue | magenta, plt_normal
	.byte 24, 12, horizontal, sp_plt_02,  5, pBlue | yellow, plt_normal
	.byte 11, 14, horizontal, sp_plt_02, 10, pBlue | red, plt_normal
	.byte 21, 16, horizontal, sp_plt_02, 10, pBlue | magenta, plt_normal
	.byte 14, 17, horizontal, sp_plt_02, 4,  pBlue | green, plt_normal

	.byte 13, 15, vertical, 	 sp_ladder,  6, pBlue | white, plt_ladder
	.byte 16, 12, vertical, 	 sp_ladder,  5, pBlue | white, plt_ladder
	.byte 29, 10, vertical, 	 sp_ladder,  7, pBlue | white, plt_ladder

	.byte last_definition

	; -------------------------------------------------------------------------------------------------------------------------
	; sprite definitions (upto 8) 
	; start addr, low addr, end addr, sprite no, start frame, path, length, dir, speed, attributes

	.word char_line_14 + 22							; scr address
	.word char_line_14 + 21							; lowest scr address
	.word char_line_14 + 24							; highest scr address
	SpriteGraphicAddresses(alien_invader1)			; frame 0
	.byte 0											; start frame 
	.byte pBlue | yellow							; attributes
	.byte horizontal								; type
	.byte right										; direction
    .byte 0                                         ; frame skip
    .byte 0                                         ; velocity (vertical)

	.word char_line_14 + 27							; scr address
	.word char_line_14 + 28							; lowest scr address
	.word char_line_14 + 29							; highest scr address
	SpriteGraphicAddresses(alien_invader1)			; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte horizontal								; type
	.byte right										; direction
    .byte 0                                         ; frame skip
    .byte 0                                         ; velocity (vertical)

	.word char_line_19 + 4							; scr address
	.word char_line_19 + 3							; lowest scr address
	.word char_line_19 + 10							; highest scr address
	SpriteGraphicAddresses(alien_invader1)			; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte horizontal								; type
	.byte right										; direction
    .byte 0                                         ; frame skip
    .byte 0                                         ; velocity (vertical)


	 ; -------------------------------------------------------------------------------------------------------------------------
	 ; first victim

	.word char_line_14 + 26							; scr address
	.word char_line_14 + 26							; lowest scr address
	.word char_line_14 + 26							; highest scr address
	SpriteGraphicAddresses(victim_2)				; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte none										; type
	.byte none										; direction
    .byte 2                                         ; frame skip
    .byte 0                                         ; velocity (vertical)
		
	.word char_line_19 + 5							; scr address
	.word char_line_19 + 5							; lowest scr address
	.word char_line_19 + 5							; highest scr address
	SpriteGraphicAddresses(victim_3)				; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | magenta							; attributes
	.byte none										; type
	.byte none										; direction
    .byte 2                                         ; frame skip
    .byte 0                                         ; velocity (vertical)
		
    .word char_line_10 + 26							; scr address
	.word char_line_10 + 26							; lowest scr address
	.word char_line_10 + 26							; highest scr address
	SpriteGraphicAddresses(victim_1)				; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlue | white								; attributes
	.byte none										; type
	.byte none										; direction
    .byte 2                                         ; frame skip
    .byte 0                                         ; velocity (vertical)
		

    .byte last_definition	; mark last sprite









