;
; 8x8 pixel graphics for black, waals and platforms
;

sp_blank:  .equ  0
sp_ladder: .equ  1

sp_sid_01: .equ  2
sp_bot_01: .equ  3
sp_plt_01: .equ  4

sp_plt_02: .equ  5
sp_bot_02: .equ  6
sp_sid_02: .equ  7

sp_sid_03: .equ  8
sp_plt_03: .equ  9
sp_plt_03_1: .equ 10

sp_lsid_04: .equ 11
sp_rsid_04: .equ 12
sp_bot_04: .equ 13
sp_plt_04: .equ 14

sp_sid_06 .equ 15
sp_bot_06 .equ 16
sp_plt_06: .equ 17
sp_plt_brk: .equ 18


; blank
first_plt_sprite:
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000

; ladder
	.byte %01000010
	.byte %01000010
	.byte %01111110
	.byte %01000010
	.byte %01000010
	.byte %01000010
	.byte %01111110
	.byte %01000010

second_plt_sprite:
	;level1_side
	.byte %11111111
	.byte %11000011
	.byte %10100101
	.byte %10011001
	.byte %10011001
	.byte %10100101
	.byte %11000011
	.byte %11111111

third_plt_sprite:
	;level1_bottom
	.byte %11111111
	.byte %11111111
	.byte %01000010
	.byte %00100100
	.byte %01000010
	.byte %10000001
	.byte %11111111
	.byte %11111111

	;level1_platform
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %00011000
	.byte %00011000
	.byte %00011000
	.byte %00011000
	
	;level2_platform
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %10011001
	.byte %01011010
	.byte %00111100
	.byte %00011000

	; bottom tile level 2
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %10101010
	.byte %01010101
	.byte %10101010
	.byte %01010101
	.byte %10101010

	; side tile level 2
	.byte %10101011
	.byte %11010101
	.byte %10101011
	.byte %11010101
	.byte %10101011
	.byte %11010101
	.byte %10101011
	.byte %11010101

    ; side and bottom tile level 3 (solid)
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111

	; horizontal platform level 3
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %01010101
	.byte %10101010
	.byte %01010101
	.byte %10101010
	.byte %01010101

    ; vertical platform for level 3
	.byte %10101010
	.byte %01010101
	.byte %10101010
	.byte %01010101
	.byte %10101010
	.byte %01010101
	.byte %10101010
	.byte %01010101

	
    ; left vertical side wall for level 4
	.byte %11100111
	.byte %10000111
	.byte %10000111
	.byte %11100111
	.byte %11100111
	.byte %11100001
	.byte %11100001
	.byte %11100111

    ; right vertical side wall for level 4
	.byte %11100111
	.byte %11100001
	.byte %11100001
	.byte %11100111
	.byte %11100111
	.byte %10000111
	.byte %10000111
	.byte %11100111


    ; horizontal bottom wall for level 4
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11100111
	.byte %11100111
	.byte %10000001
	.byte %10000001
	.byte %11111111
	
	; platform for level 4
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %10011001
	.byte %10011001
	.byte %10111101
	.byte %01000010
	.byte %00111110
	
	.byte %00000000
	.byte %00011000
	.byte %00101100
	.byte %01011110
	.byte %01011110
	.byte %00101100
	.byte %00011000
	.byte %00000000

	.byte %11111111
	.byte %00000000
	.byte %00011000
	.byte %00101100
	.byte %01011110
	.byte %01011110
	.byte %00101100
	.byte %00011000

	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %00011000
	.byte %00101100
	.byte %01011110
	.byte %00101100
	.byte %00011000


	.byte %11011101
	.byte %00000000
	.byte %01110111
	.byte %00000000
	.byte %11011101
	.byte %00000000
	.byte %01110111
	.byte %00000000
