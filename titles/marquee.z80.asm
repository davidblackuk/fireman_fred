﻿;---------------------------------------------------V--------------------

; the marquee is stored as bytes in the forst row of pixels in screen memory and scrolled there
; we attribute the pixels to black on black to hide them. The marquee
; is then rended to screen as characters

;use the screen to store this too
position_in_string: .word 0
last_char_in_buffer: .equ char_line_00 + 32 + 3

marquee_length .equ 32

; we store the data in the first screen row. There are 32 characters and a prefix of
; an x,y and color, so the line overflows into the nextscan line . (though not out of character row 0)
;
init_marquee:
	ld hl, char_line_00 + 3							; clear to all spaces, this will overflow 
	ld de, char_line_00 + 4							; onto scan line two because of the three byte
	ld bc, marquee_length-1							; header for print_message
	ld (hl), ' '
	ldir											; char_line_00 + 3 + 32 is 0 terminator

	xor a											; zero terminator
	ld (de), a			

	ld ix, char_line_00								; store the prefix data
	ld (ix+0), 0									; x coord of marquee
	ld (ix+1), 22									; y coord of marquee
	ld (ix+2), pBlack | white						; colors

	ld hl, marquee
	ld (position_in_string), hl

	; We use the first row of screen data as a buffer to scroll
	; the text. we hide that fact by setting the attributes to 
	; black text on a black background

	ld hl, attr_line_000							; the attributes in the back buffer
	ld de, attr_line_000 + 1				
	ld bc, attributes_length-1						; we copy len - 1 as the first one is already set
	xor a											; dark as a goths bedroom
	ld (hl), a
	ldir
	ret

; scroll the buffer, add the next character and print the line
; We wrap the text at the end so it loops
step_marquee:
	call scroll_message
	call get_next_character
	call print_marquee
	ret

scroll_message:
	ld hl, char_line_00 + 4							; one char in
	ld de, char_line_00 + 3							; position of first char
	ld b, marquee_length-1							; move 31 characters and leav  the last
scroll_loop:			
	ld a, (hl)			
	ld (de), a			
	inc hl			
	inc de			
	djnz scroll_loop				
	ret				
			
get_next_character:			
	ld hl, (position_in_string)						; get next character
	ld a, (hl)			
	or a			
	jr nz, no_overflow								; if it's not the terminator copy the char
	ld hl, marquee									; otherwise initialize back to head of string
	ld a, (marquee)			
no_overflow:			
	inc hl											; point to char for next loop
	ld (position_in_string), hl						; save the pointer
	ld (char_line_00+3+31), a						; store the char at the end of the buffer
	ret

print_marquee:
	ld ix, char_line_00
	call print_message
	ret

	
marquee:
	.byte "FIREMAN FRED RETURNS IN THIS NEW IMPLEMENTATION OF THE ORIGINAL TITLE. KEYS: W-A-S-D TO MOVE FRED, SPACE TO JUMP.         ", 0 

