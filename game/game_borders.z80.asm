﻿;---------------------------------------------------V--------------------

draw_borders:
	ld a, (ix + i_lvl_l_bord_chr)					; use this character
	ld (left_char), a
	ld a, (ix + i_lvl_r_bord_chr)					; use this character
	ld (right_char), a
	ld a, (ix + i_lvl_b_bord_chr)					; use this character
	ld (bot_char), a
	ld a, (ix + i_lvl_bord_color)					; use this character
	ld (left_back), a
	ld (right_back), a
	ld (bot_back), a


	push ix											; Save the level definition 
	ld ix, left_border								; grab the platform definition
	call draw_platform								; render the left border

	ld ix, right_border								; grab the platform definition
	call draw_platform								; render the right border

	ld ix, bottom_border							; grab the platform definition
	call draw_platform								; render the bottom, shorter border
	pop ix
	ret

;
; we store a draw platform commands for the edges
; X, Y, direction (horizontal or vertical), sprite character, length, char attrs,flags 
;
left_border:	.byte 0, 0, vertical
left_char:		.byte 0, screen_height_chars-2 
left_back:		.byte	pBlack | red, plt_blocker

right_border:	.byte screen_width_chars-1, 0, vertical
right_char:		.byte 0, screen_height_chars-2 
right_back:		.byte pBlack | red, plt_blocker

bottom_border:	.byte 1, screen_height_chars-3, horizontal
bot_char:		.byte 0,  screen_width_chars-2
bot_back:		.byte pBlack | red, plt_blocker

