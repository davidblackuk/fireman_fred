﻿;---------------------------------------------------V--------------------

;
; Sub routines forprinting text to the backbuffer
;


;
; Attributes for colors are
;
; %0-0-000-000
; flash-bright-paper-ink where:

black   .equ %000000
blue	.equ %000001
red	 	.equ %000010
magenta .equ %000011
green   .equ %000100
cyan	.equ %000101
yellow  .equ %000110
white   .equ %000111

pBlack 		.equ black << 3
pBlue		.equ blue  << 3
pRed		.equ red  << 3
pMagenta 	.equ magenta  << 3
pGreen   	.equ green  << 3
pCyan		.equ cyan  << 3
pYellow  	.equ yellow  << 3
pWhite   	.equ white  << 3

bright   	.equ %01000000
flash   	.equ %10000000

;
; Clears the physical screen
;
cls_physical:	ld hl, screen_start
				ld de, screen_start + 1
				ld bc, screen_size -1
				ld (hl), 0
				ldir
				ld hl, attr_start
				ld de, attr_start + 1
				ld bc, attributes_length - 1
				ld (hl), a
				ldir
				ret

;
; Print a message to the screen
; In: IX + 0: Screen X 
;	 IX + 1: Screen Y
;	 IX + 2: Attributes
;	 IX + 3: message (zero terminated)
;
print_message:	call get_char_addr					; get the screen address back
													; iterate the string and print each character
				push IX				 				; get ix into de
				pop de			
				inc de				  				; move to start of message
				inc de
				inc de

				
print_loop:		ld a, (de)			  				; get next character to print  
				or a								; cp 0 in a way more efficient manner
				ret z								; return if finished. we could save a byte by marking the last char with a set upper bit?
			
				push hl				 				; save required registers
				push de
				push bc
				call print_char
				pop bc
				pop de
				pop hl

				ld a, (IX + 2)		  				; get the attributes for the character
				ld (bc), a							; store the attributes in the back buffer attribute map

				inc de				 				; Next character
				inc hl				  				; next screen address
				inc bc				  				; next attribute
				jr print_loop

				
				
;
; Given: IX points to x,y
; returns: hl => back buffer address of character
;		  bc => attribute address of character in backbuffer
get_char_addr:	ld h, 0				 				; calculate screenLoc = char_line_00 + ((y*8) * 32)
				ld l, (IX + 1)		  				; get the y coordinate

				add hl, hl			  				; multiply it by 32*8 to get the row start
				add hl, hl
				add hl, hl
				add hl, hl
				add hl, hl
				add hl, hl
				add hl, hl
				add hl, hl

				ld bc, char_line_00					; top of screen
				add hl, bc			  				; char_line_00 + (y * 8 * with)
				ld b, 0			
				ld c, (IX + 0)			
				add hl, bc			  				; char_line_00 + (y * with) + x

				;
				; calculate attribute location = attributes start +x + (y*8)
				;
				push hl								 ; Calculate the first attribute position
				ld h, 0								 
				ld l, (IX + 1)						 ; get the y coordinate
												
				add hl, hl							 ; hl = y * 32 (chars wide)
				add hl, hl			  
				add hl, hl			  
				add hl, hl			  
				add hl, hl			  
						
			 
				
				ld b,0
				ld c, (ix+0)
				add hl, bc			  				; hl = x + (y * 32)
				ld bc, attr_line_000
				add hl, bc			  				; add the offset to the start of the attribute block

				push hl				 				; swap HL and BC
				pop bc
				pop hl	 
				

				
				ret

;
; print a character on the screen
; IN:   HL -> Screen address of the character
;	   A  -> Character to pront (ascii)
print_char:		push hl								; save screen address
				
				; do the special cases first as they are all over the map ascii wise

@tryColon:		cp ':'
				jp nz, @tryMinus					; try matching a colon (:)
				ld hl, system_font_colon
				jr @print_from_hl

@tryMinus:		cp '-'
				jp nz, @tryComma					; try matching a minus (-)
				ld hl, system_font_minus
				jr @print_from_hl

@tryComma:		cp ','
				jp nz, @tryPeriod					; try matching a comma (,)
				ld hl, system_font_comma
				jr @print_from_hl


@tryPeriod:		cp '.'
				jp nz, @processRanges				; last chance is it a period, quit otherwise
				ld hl, system_font_full_stop
				jr @print_from_hl

				; now do the range checks

@processRanges:	cp 'A'								; greater than or equal to A?
				jp nc, @isAlpha						; jump to print a..z

				cp '0'								; Greater than or equal to 0
				jp nc, @isDigit			

				cp ' '								; Is it a space?
				jp nz, @tryColon			  
				ld hl, system_font_space
				jr @print_from_hl


@isDigit:		ld bc, system_font_09
				ld hl, 0
				sub '0'								; gets offset from '0'
				jp @offset_char

@isAlpha:		ld bc, system_font_az				; address of first char in the a-z set
				ld hl, 0			
				sub 'A'								; get offset from A = 0
			
@offset_char:	ld l, a			
				add hl, hl							; multiply offset by 8
				add hl, hl			
				add hl, hl			
				add hl, bc							; hl now points to first char in the character pix map
			
@print_from_hl:	push hl								; swap hl and de as hl is better at math
				pop  de								; de => font address
				pop  hl								; hl => screen address passed in
			
print_raw:		ld b, 8								; hl = screen address of char, de = font address, copy 8 lines of the character

@loop:			ld a, (de)
				ld (hl), a	
				inc de
				push bc
				ld bc, screen_width_chars
				add hl, bc
				pop bc
   
				djnz @loop		 
				ret

