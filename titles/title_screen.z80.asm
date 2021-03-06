﻿;---------------------------------------------------V--------------------
;
; main title screen consisting of 
; Options menu, scrolling marquee and logo
;

;
; Display the game menu
;

title_screen:	call init_display

				call init_marquee
next_step:			

				call display_text
				
				call step_marquee

				
				call transfer

				ld hl,LASTK		 					; LAST K system variable.
			   	ld a,(hl)		   					; new value of LAST K.
				cp '1' 								; less than '1', continue
				jp c, next_step			
				cp '4'								; greater than 4 continue
				jp nc, next_step			
				sub '1'								; map key relative to 0
				ld (hl), 0
				ret				 


;
; clear the screen and set border and bg color to black 
;

init_display:	ld a, pBlack | white | bright		; initialize the screen to black
				call cls_backbuffer					; clear screen to black
				
				ld a, cyan
				call BORDER
				ret

display_text:	ld IX, title_msg	; FIREMAN FRED
				call print_message
	
				ld IX, menu_msg		; MAIN MENU
				call print_message

				ld ix, start_msg	; 1 PLAY GAME
				call print_message
	
				ld ix, demo_msg		; 2 DEMO MODE
				call print_message

				ld ix, prac_msg		; 3 PRACTICE MODE
				call print_message

				ret


title_msg:		.byte 8, 3,  pBlack | cyan 
				.byte "FIREMAN F.R.E.D\0"

menu_msg: 		.byte 11, 5,  pBlack | cyan 
				.byte "MAIN MENU\0"

start_msg:		.byte 8, 10,  pBlack | green 
				.byte "1 PLAY GAME\0" 

demo_msg: 		.byte 8, 12,  pBlack | green
				.byte "2 DEMO MODE\0"

prac_msg:		.byte 8, 14,  pBlack | green
				.byte "3 PRACTICE MODE\0"
