;---------------------------------------------------V--------------------
;
; Platform operations. Renders platforms and maintains the platform map.
; The platform map contains flags describing the behaviour of each platform 
; cell. Cells can block movement, be conveyers, ladders etc.
;
; This code is common to the game border renderer and the platform renderer
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
	ld (attributes_addr), bc						; store the start address of the platform in the attribute map
	call initialize_platform_map_addr				; store the start address of the platform in the platform map
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
	call set_attribute								; set the attributes for the platform
	call set_platform_map							; store the flags for this platform
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
	call set_attribute								; set the attributes for the platform
	call set_platform_map								; store the flags for this platform
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

;
; Set the platform map flags for a platform
; IN: bc contains the offset to add to get to the next attribute (1 or 32 = h or v) 
; OUT: Trashes HL, A
set_platform_map: 
	ld hl, (platrom_map_addr)
	ld a, (ix + i_plt_flg)
	ld (hl), a
	add hl, bc
	ld (platrom_map_addr), hl
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

;
; Stores the initial offset for the platform flag map ready to allow the creation of the map.
; IN: BC contains the attribute address of the platfor relative to the background attribute map
; OUT: BC is toast
initialize_platform_map_addr:
	push hl											; store used registers
	push de

	ld h, b											; hl = bc
	ld l, c
	ld de, attr_line_000							; de = start of attribute map
	or a											; reset the carry flag
	sbc hl, de										; hl = offset into the attribute map of original bc positio

	ld de, platform_map								; set DE to the platformmap
	add hl, de										; HL = address in the platform_map corresponding to the initial character
	ld (platrom_map_addr), hl						; save it for later
	pop de											; restore registers
	pop hl
ret


	pixmap_addr:  	.word 0
attributes_addr:  	.word 0
platrom_map_addr:  	.word 0


; TODO: Move me into upper memory
platform_map: .storage attributes_length

