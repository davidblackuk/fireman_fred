﻿;---------------------------------------------------V--------------------
;
; Platform operations. Renders platforms and maintains the platform map.
; The platform map contains flags describing the behaviour of each platform 
; cell. Cells can block movement, be conveyers, ladders etc.
;

i_plt_x:	.equ 0
i_plt_y:	.equ 1
i_plt_dir:	.equ 2
i_plt_chr:	.equ 3
i_plt_len:	.equ 4
i_plt_att:	.equ 5
i_plt_flg:	.equ 6

;
; Renders a single platform and manages the platform map.
; 
; IN: IX points to a structure that has the following data
;	+ 0	X
;	+ 1	Y
;	+ 2	direction (horizontal or vertical)
;	+ 3	sprite character
;	+ 4	length
;	+ 5 char attrs
;	+ 6	flags ()
;
;
draw_platform:
	call get_pixmap_addr
	call get_char_addr								; hl points to back buffer, bc to attr
	ld (attributes_addr), bc
	ld b, (ix + i_plt_len)

	ld a, (IX + i_plt_dir)
	cp vertical
	jp z, draw_vert

horiz_loop:
	ld de, (pixmap_addr)
	push hl
	push bc
	call print_raw									; hl = screen , de = pixmap
	ld bc, 1	
	call set_attribute
	pop bc
	pop hl
	inc hl
	djnz horiz_loop
	ret
draw_vert:	
	ld de, (pixmap_addr)
	push hl
	push bc
	call print_raw									; hl = screen , de = pixmap
	ld bc, 32
	call set_attribute
	pop bc
	pop hl
	ld de, screen_width_chars * 8
	add hl, de
	djnz draw_vert
	ret

;
; Set the attribute for a platform
; IN: bc contains the offset to add to get to the next attribute (1 or 32 = h or v) 
; OUT: Trashes HL, A
set_attribute: 
	ld hl, (attributes_addr)
	ld a, (ix + i_plt_att)
	ld (hl), a
	add hl, bc
	ld (attributes_addr), hl
	ret


get_pixmap_addr: 
	ld de, first_plt_sprite							; pixmap of first platform sprite
	ld h, 0
	ld l, (IX + i_plt_chr)							; calc platform char code * 8
	add hl, hl										; * 2
	add hl, hl										; * 4
	add hl, hl										; * 8
	add hl, de										; de = first_plt_sprite + (chr * 8)
	ld (pixmap_addr), hl
	ret



;
; clears the platform map.
; IN: None
; OUT: Trashes HL, BC, DE
cls_platform_map:
	ld hl, platform_map
	ld de, platform_map+1
	ld bc, screen_width_chars*screen_height_chars - 1
	ld (hl), plt_empty
	ldir
	ret

	pixmap_addr:  .word 0
attributes_addr:  .word 0


; TODO: Move me into upper memory
platform_map: .storage screen_width_chars * screen_height_chars