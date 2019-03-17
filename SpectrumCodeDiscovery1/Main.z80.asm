﻿;
; File: Main.z80.asm
; Desc: Main entry point for the application, bootstraps the game
;
 .org #8000


start:
	call title_screen		; returns key pressed in a 	
	cp 0
	jp nz, start
    
    ld hl, 0

next_level:    
    push hl
	call start_game
    pop hl
    inc l
    or a
    jp nz, next_level
    jp start

;
; Includes for logic
;
.include "./src/constants.z80asm"
.include "./src/titles/print.z80asm"
.include "./src/game/keyboard.z80asm"
.include "./src/titles/title_screen.z80asm"
.include "./src/titles/marquee.z80asm"
.include "./src/game/game_loop.z80asm"
.include "./src/game/game_borders.z80asm"
.include "./src/game/game_platforms.z80asm"
.include "./src/game/platform_renderer.z80asm"
.include "./src/game/sprite_engine.z80asm"
.include "./src/game/sprite_move.z80asm"


;
; Includes for level and gfx definitions
;
.include "./src/levels/level01.z80asm"
.include "./src/levels/level02.z80asm"
.include "./src/levels/level03.z80asm"
.include "./src/gfx/fonts.z80asm"

.include "./src/gfx/fred.z80asm"
.include "./src/gfx/victims.z80asm"
.include "./src/gfx/aliens.z80asm"
.include "./src/gfx/platforms.z80asm"

;
; Includes for mutable memory regions
;
.include "./src/game/sprite_storage.z80asm"
.include "./src/back_buffer.z80asm"

z_total_bytes: .equ $-start