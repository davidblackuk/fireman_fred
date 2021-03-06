﻿;---------------------------------------------------V--------------------

level_04:
	.byte black 							        ; tv border color
	.byte pBlack | white  				            ; default attributes	
	.byte sp_lsid_04, sp_rsid_04					; Left, right Side graphic
	.byte sp_bot_04						            ; Bottom graphic
	.byte cyan						            	; side and bottom colors
	
	BufferAddress(9, 5)								; ambulance start position
	BufferAddress(27, 5)							; ambulance end position
	PositionFred(5, 5)								; freds start position in the back buffer  and other variables	

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


  
	.word char_line_11 + 6							; scr address
	.word char_line_09 + 6							; lowest scr address
	.word char_line_15 + 6							; highest scr address
	SpriteGraphicAddresses(alien_smoke)				; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlack | yellow							; attributes
	.byte vertical									; type
	.byte down										; direction
    .byte 0                                         ; frame skip
    .byte 1                                         ; velocity (vertical)

	.word char_line_11 + 12							; scr address
	.word char_line_09 + 12							; lowest scr address
	.word char_line_15 + 12							; highest scr address
	SpriteGraphicAddresses(alien_smoke)				; set the sprite gfx
	.byte 2											; start frame 
	.byte pBlack | yellow							; attributes
	.byte vertical									; type
	.byte up										; direction
    .byte 1                                         ; frame skip
    .byte 1                                         ; velocity (vertical)

    .word char_line_09 + 20							; scr address
	.word char_line_09 + 20							; lowest scr address
	.word char_line_15 + 20							; highest scr address
	SpriteGraphicAddresses(alien_smoke)				; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlack | yellow							; attributes
	.byte vertical									; type
	.byte down										; direction
    .byte 1                                         ; frame skip
    .byte 1                                         ; velocity (vertical)

    .word char_line_11 + 24							; scr address
	.word char_line_11 + 22							; lowest scr address
	.word char_line_11 + 29							; highest scr address
	SpriteGraphicAddresses(alien_bounce_ball)		; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlack | cyan								; attributes
	.byte horizontal								; type
	.byte up 										; direction
    .byte 0                                         ; frame skip
    .byte 1                                         ; velocity (vertical)


    ; -------------------------------------------------------------------------------------------------------------------------
	; first victim

    .word char_line_16 + 2							; scr address
	.word char_line_16 + 2							; lowest scr address
	.word char_line_16 + 2							; highest scr address
	SpriteGraphicAddresses(victim_cat1)				; set the sprite gfx
	.byte 0											; start frame 
	.byte pBlack | white							; attributes
	.byte none  									; type
	.byte none										; direction
    .byte 2                                         ; frame skip
    .byte 0                                         ; velocity (vertical)

		
	.byte last_definition							; mark last sprite
			












