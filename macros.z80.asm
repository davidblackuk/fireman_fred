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

    ; start Y in PIXELS stored for later
    .word characterY * 8

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