;---------------------------------------------------V--------------------

level_01:   
	.byte black 									; tv border color
	.byte pBlack | white  							; default attributes	
	.byte sp_sid_01, sp_sid_01						; Left, right Side graphic
	.byte sp_bot_01									; Bottom graphic
	.byte red										; side and bottom colors

	BufferAddress(5, 19)							; ambulance start position
	BufferAddress(27, 19)							; ambulance end position
	PositionFred(11, 16)							; freds start position in the back buffer  and other variables	

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
first_spd:  .word char_line_11 + 6					; scr address
	        .word char_line_11 + 4					; lowest scr address
	        .word char_line_11 + 9					; highest scr address
	        SpriteGraphicAddresses(alien_bulb)		; set the sprite gfx
	        .byte 0									; start frame 
	        .byte green								; attributes
	        .byte horizontal						; type
	        .byte right								; direction
            .byte 4                                 ; frame skip
            .byte 1                                 ; velocity (vertical)

sprite_definition_len: .equ  * - first_spd			

	        .word char_line_11 + 22					; scr address
	        .word char_line_11 + 22					; lowest scr address
	        .word char_line_11 + 26					; highest scr address
	        SpriteGraphicAddresses(alien_bulb)		; set the sprite gfx
	        .byte 0									; start frame 
	        .byte cyan								; attributes
	        .byte horizontal						; type
	        .byte right								; direction
            .byte 0                                 ; frame skip
            .byte 1                                 ; velocity (vertical)

	       
	        .word char_line_11 + 11					; scr address
	        .word char_line_11 + 11					; lowest scr address
	        .word char_line_11 + 11					; highest scr address
	        SpriteGraphicAddresses(victim_1)		; set the sprite gfx
	        .byte 0									; start frame 
	        .byte white								; attributes
	        .byte none								; type
	        .byte none								; direction
	        .byte 2                                 ; frame skip
            .byte 0                                 ; velocity (vertical)
		
			
	         .word char_line_11 + 28				; scr address
	         .word char_line_11 + 28				; lowest scr address
	         .word char_line_11 + 28				; highest scr address
	         SpriteGraphicAddresses(victim_2)		; set the sprite gfx
	        .byte 0									; start frame 
	        .byte magenta 							; attributes
	        .byte none								; type
	        .byte none								; direction
            .byte 2                                 ; frame skip
            .byte 0                                 ; velocity (vertical)



	        .byte last_definition					; mark last sprite








