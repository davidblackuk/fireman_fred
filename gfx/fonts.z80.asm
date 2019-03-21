;
; Font used in the menu, the score hud etc
;
; Ordered in asci stylee
; -----------------------------------
; Space ! " # $ % & ' ( ) * + , - . /
; 0 1 2 3 4 5 6 7 8 9 
; : ; < = > ? @
; A - Z
; -----------------------------------

system_font_space:
	; Space
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000

system_font_full_stop:
	; Period
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00010000

system_font_colon:
	; a colon (:)
	.byte %00000000
	.byte %00100000
	.byte %00100000
	.byte %00000000
	.byte %00000000
	.byte %00100000
	.byte %00100000
	.byte %00000000

system_font_minus:
	; A minus (-)
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %01111110
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000

system_font_comma:
	; A comma (,)
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00100000
	.byte %00100000
	.byte %01000000

system_font_09:
	; 0
	.byte %11111110
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %11111110
	.byte %00000000

	; 1
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00000000

	; 2
	.byte %11111110
	.byte %00000010
	.byte %00000010
	.byte %11111110
	.byte %10000000
	.byte %10000000
	.byte %11111110
	.byte %00000000

	; 3
	.byte %11111110
	.byte %00000010
	.byte %00000010
	.byte %11111110
	.byte %00000010
	.byte %00000010
	.byte %11111110
	.byte %00000000

	; 4
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %11111110
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000000

	; 5
	.byte %11111110
	.byte %10000000
	.byte %10000000
	.byte %11111110
	.byte %00000010
	.byte %00000010
	.byte %11111110	
	.byte %00000000

	; 6
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %11111110
	.byte %10000010
	.byte %10000010
	.byte %11111110
	.byte %00000000

	; 7
	.byte %11111110
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000000

	; 8
	.byte %11111110
	.byte %10000010
	.byte %10000010
	.byte %11111110
	.byte %10000010
	.byte %10000010
	.byte %11111110
	.byte %00000000

	; 9
	.byte %11111110
	.byte %10000010
	.byte %10000010
	.byte %11111110
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000000



system_font_az

	; A
	.byte %01111100
	.byte %10000010
	.byte %10000010
	.byte %11111110
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %00000000
	; B
	.byte %11111100
	.byte %10000010
	.byte %10000010
	.byte %10000100
	.byte %10000010
	.byte %10000010
	.byte %11111100
	.byte %00000000
	; c
	.byte %01111100
	.byte %10000010
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000010
	.byte %01111100
	.byte %00000000
	; D
	.byte %11111100
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %11111100
	.byte %00000000
	; E
	.byte %11111110
	.byte %10000000
	.byte %10000000
	.byte %11111110
	.byte %10000000
	.byte %10000000
	.byte %11111110
	.byte %00000000
	; F
	.byte %11111110
	.byte %10000000
	.byte %10000000
	.byte %11111110
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %00000000
	; G
	.byte %01111100
	.byte %10000010
	.byte %10000000
	.byte %10111100
	.byte %10000010
	.byte %10000010
	.byte %01111100
	.byte %00000000
	; h
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %11111110
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %00000000
	; i
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00000000
	; j
	.byte %01111110
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %10010000
	.byte %01100000
	.byte %00000000
	; k
	.byte %10000010
	.byte %10000100
	.byte %10001000
	.byte %11110000
	.byte %10001000
	.byte %10000100
	.byte %10000010
	.byte %00000000
	; l
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %11111110
	.byte %00000000
	; m
	.byte %10000010
	.byte %11000110
	.byte %10101010
	.byte %10010010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %00000000
	; n
	.byte %10000010
	.byte %11000010
	.byte %10100010
	.byte %10010010
	.byte %10001010
	.byte %10000110
	.byte %10000010
	.byte %00000000
	; o
	.byte %01111100
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %01111100
	.byte %00000000
	; p
	.byte %11111100
	.byte %10000010
	.byte %10000010
	.byte %11111100
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %00000000
	; q
	.byte %01111100
	.byte %10000010
	.byte %10000010
	.byte %10010010
	.byte %10001010
	.byte %10000100
	.byte %01111010
	.byte %00000000
	; r
	.byte %11111100
	.byte %10000010
	.byte %10000010
	.byte %11111100
	.byte %10001000
	.byte %10000100
	.byte %10000010
	.byte %00000000
	; s
	.byte %01111100
	.byte %10000010
	.byte %10000000
	.byte %01111100
	.byte %00000010
	.byte %10000010
	.byte %01111100
	.byte %00000000
	; t
	.byte %01111110
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00000000
	; u
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %01111100
	.byte %00000000
	; v
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %01000100
	.byte %00101000
	.byte %00010000
	.byte %00000000
	;W
	.byte %10000010
	.byte %10000010
	.byte %10000010
	.byte %10010010
	.byte %10101010
	.byte %11000110
	.byte %10000010
	.byte %00000000
	;X
	.byte %10000010
	.byte %01000100
	.byte %00101000
	.byte %00010000
	.byte %00101000
	.byte %01000100
	.byte %10000010
	.byte %00000000
	;y
	.byte %10000010
	.byte %01000100
	.byte %00101000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00010000
	.byte %00000000
	; z
	.byte %11111110
	.byte %00000100
	.byte %00001000
	.byte %00010000
	.byte %00100000
	.byte %01000000
	.byte %11111110
	.byte %00000000
