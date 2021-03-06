﻿;---------------------------------------------------V--------------------
;
; IN IX Points to the level definiton
; OUT HL Points to the start of the sprite definitions
draw_platforms:
	push ix											; save ix for the return
	push ix											; swap ix with hl
	pop hl
	ld b, 0											; initialize bc to the length of a platform definition
	ld c, first_platform_defn_gap					; gap from level definition to first platform   		
	add hl, bc	
													; gap from one platform to another
	ld c, platform_defn_len							; this is calculated from the length of platform 0 in level 1
draw_plat1:
	push hl											; swap hl and ix
	pop ix	
	push hl											; save the current platform address
	push bc											; and the offset to the next one
	call draw_platform								; render our platform
	pop bc											; restore offset
	pop hl											; restore address
	add hl, bc										; next platform start
	ld a, (HL)
	cp last_definition								; is it the end of plat form marker?
	jr nz, draw_plat1								; if no, off we go again
	inc hl											; hl now points to the first sprite definition
	pop ix											; restore the level definition to ix
	ret