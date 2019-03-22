;
; Utility macros 
;

;
; Convert a character x,y into a backbuffer position
;
.macro BufferAddress(characterX = 0, CharacterY = 0)

    .word backbuffer + (CharacterY * (8 * screen_width_chars)) + characterX

.endmacro

;
; Position fred
;
; takes an x, y coordinate (character columns)
; outputs the starting back buffer address as a word
; and the column x and the PIXEL y as bytes
.macro PositionFred(characterX = 0, CharacterY = 0)

    ; start X in characters stored for later
    .byte CharacterX

    ; start Y in PIXELS stored for later
    .word CharacterY * 8

    // freds start address in tha back buffer
    BufferAddress(CharacterX, CharacterY)


.endmacro
