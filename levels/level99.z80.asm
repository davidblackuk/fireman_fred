;
; Test level for playing with features. 
;



level_99:   
	.byte black 									; tv border color
	.byte pBlack | white  							; default attributes	
	.byte sp_sid_06, sp_sid_06						; Left, right Side graphic
	.byte sp_bot_06									; Bottom graphic
	.byte pBlack | blue	| bright					; side and bottom colors

	BufferAddress(6, 19)							; ambulance start position
	BufferAddress(27, 19)							; ambulance end position
	PositionFred(15, 15)							; freds start position in the back buffer  and other variables	

	        ; plat x, y, dir, sprite, length, attrs

	.byte 12,  7, horizontal, sp_plt_06, 8, pBlack | magenta,  plt_normal
	.byte  1,  9, horizontal, sp_plt_06, 6, pBlack | blue,	 plt_normal
	.byte 25,  9, horizontal, sp_plt_06, 6, pBlack | blue,   plt_normal
	.byte  7, 11, horizontal, sp_plt_06, 5, pBlack | red,	 plt_normal
	.byte 20, 11, horizontal, sp_plt_06, 5, pBlack | red,    plt_normal
	.byte 13, 13, horizontal, sp_plt_06, 6, pBlack | cyan,	 plt_normal
	.byte 22, 16, horizontal, sp_plt_06, 9, pBlack | green,  plt_normal
	.byte 13, 17, horizontal, sp_plt_06, 3, pBlack | yellow, plt_normal
	.byte  4, 18, horizontal, sp_plt_06, 8, pBlack | white,  plt_normal

	.byte  3, 16, vertical, sp_ladder,  5, pBlack | white, plt_ladder
	.byte 14, 11, vertical, sp_ladder,  6, pBlack | white, plt_ladder
	.byte 17,  5, vertical, sp_ladder,  8, pBlack | white, plt_ladder
	.byte 28, 7, vertical, sp_ladder,  9, pBlack | white, plt_ladder


	.byte last_definition


	; -------------------------------------------------------------------------------------------------------------------------
	; sprite definitions (upto 8)
	;
	; if we change sprite definition,  change all others including the bulance and fred
	;
	; start addr, low addr, end addr, sprite no, start frame, path, length, dir, speed, attributes
	HorizontalSprite(1, 7, 9, 3)					; sprite start/end/current 
	SpriteGraphicAddresses(alien_bulb)
	.byte 0											; start frame 
	.byte green									; attributes
	.byte horizontal								; type
	.byte right										; direction
	.byte 4                                         ; frame skip
	.byte 1                                         ; velocity (vertical)


	HorizontalSprite(1, 20, 9, 3)					; sprite start/end/current 
	SpriteGraphicAddresses(alien_bulb)
	.byte 0											; start frame 
	.byte yellow									; attributes
	.byte horizontal								; type
	.byte right										; direction
	.byte 0                                         ; frame skip
	.byte 1                                         ; velocity (vertical)

	HorizontalSprite(3, 4, 16, 6)					; sprite start/end/current 
	SpriteGraphicAddresses(alien_bulb)
	.byte 0											; start frame 
	.byte white										; attributes
	.byte horizontal								; type
	.byte right										; direction
	.byte 4                                         ; frame skip
	.byte 1                                         ; velocity (vertical)


	HorizontalSprite(0, 22, 14, 4)					; sprite start/end/current 
	SpriteGraphicAddresses(alien_bulb)
	.byte 0											; start frame 
	.byte cyan										; attributes
	.byte horizontal								; type
	.byte right										; direction
	.byte 0                                         ; frame skip
	.byte 1                                         ; velocity (vertical)

	; -------------------------------------------------------------------------------------------------------------------------
	; first victim

	StationarySprite(15, 5)							; sprite start/end/current 
	SpriteGraphicAddresses(victim_2)
	.byte 0											; start frame 
	.byte yellow 									; attributes
	.byte none										; type
	.byte none										; direction
	.byte 1                                         ; frame skip
	.byte 0                                         ; velocity (vertical)

	
	StationarySprite(4, 7)							; sprite start/end/current 
	SpriteGraphicAddresses(victim_2)
	.byte 0											; start frame 
	.byte white 									; attributes
	.byte none										; type
	.byte none										; direction
	.byte 2                                         ; frame skip
	.byte 0                                         ; velocity (vertical)

	StationarySprite(26, 7)							; sprite start/end/current 
	SpriteGraphicAddresses(victim_2)
	.byte 0											; start frame 
	.byte cyan										; attributes
	.byte none										; type
	.byte none										; direction
	.byte 3                                         ; frame skip
	.byte 0                                         ; velocity (vertical)

	
	StationarySprite(25, 14)							; sprite start/end/current 
	SpriteGraphicAddresses(victim_2)
	.byte 0											; start frame 
	.byte cyan 										; attributes
	.byte none										; type
	.byte none										; direction
	.byte 2                                         ; frame skip
	.byte 0                                         ; velocity (vertical)


	.byte last_definition	; mark last sprite








