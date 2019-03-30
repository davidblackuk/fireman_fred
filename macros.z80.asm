;
; Utility macros 
;

;
; Convert a character x,y into a backbuffer position
;
.macro BufferAddress(characterX = 0, characterY = 0)
    .word backbuffer + (characterY * (8 * screen_width_chars)) + characterX
.endmacro

;
; Position fred
;
; takes an x, y coordinate (character columns)
; outputs the starting back buffer address as a word
; and the column x and the PIXEL y as bytes
.macro PositionFred(characterX = 0, characterY = 0)
    ; start X in characters stored for later
    .byte characterX

    ; start Y in characters stored for later
    .byte characterY 

    // freds start address in tha back buffer
    BufferAddress(characterX, characterY)
.endmacro


;
; Inlines the pixel addresses for a sprite 
;
.macro SpriteGraphicAddresses(spriteStartAddress) 
    .word spriteStartAddress + sprite_bytes * 0	    ; frame 0
    .word spriteStartAddress + sprite_bytes * 1    	; frame 1
    .word spriteStartAddress + sprite_bytes * 2    	; frame 2
    .word spriteStartAddress + sprite_bytes * 3    	; frame 3
.endmacro

;
; inlines the back buffer addresses (start, current and end)
; for a horizontal sprite,
;
.macro HorizontalSprite(startOffset, minX, y, length)    
	BufferAddress(minX+startOffset, y)              ; scr address
    BufferAddress(minX, y)						    ; lowest scr address   
	BufferAddress(minX + length, y)				    ; highest scr address
.endmacro

;
; Inline the backbuffer addresses for a stationary sprite
;
.macro StationarySprite(x, y)
    HorizontalSprite(0, x, y, 0)
.endmacro

;
; divides hl by 32
;
.macro DivideHlBy32()

    srl h                                           ; HL = HL / 2
    rr l
    srl h                                           ; HL = HL / 4
    rr l
    srl h                                           ; HL = HL / 8
    rr l
    srl h                                           ; HL = HL / 16
    rr l
    srl h                                           ; HL = HL / 32 
    rr l                                            

.endmacro

.macro DivideHlBy8() 

    srl h
    rr l
    srl h
    rr l
    srl h
    rr l                                            ; hl = hl / 8 = char y

.endmacro
