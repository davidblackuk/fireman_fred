;
; File: Main.z80.asm
; Desc: Main entry point for the application, bootstraps the game
;

 //Setup for ZX Spectrum (Z80 CPU mode)
    .target "z80"

    .setting "OutputFileType", "tap"    //TAP output format for ZX Spectrum 48KB
    .setting "TapStart", Start          //The start address of the program.
    .setting "TapClear", $5fff          //The CLEAR VAL address in the BASIC
                                        //loader which clears up the RAM
                                        //before the binary code loads.
    .org $8000


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

.include "./src/constants.z80.asm"


.include "./src/back_buffer.z80.asm"

.include "./src/levels/level01.z80.asm"
.include "./src/levels/level02.z80.asm"
.include "./src/levels/level03.z80.asm"
.include "./src/gfx/fonts.z80.asm"

.include "./src/gfx/fred.z80.asm"
.include "./src/gfx/victims.z80.asm"
.include "./src/gfx/aliens.z80.asm"
.include "./src/gfx/platforms.z80.asm"

.include "./src/game/sprite_storage.z80.asm"

;
; Includes for logic
;

.include "./src/titles/print.z80.asm"
.include "./src/game/keyboard.z80.asm"
.include "./src/titles/title_screen.z80.asm"
.include "./src/titles/marquee.z80.asm"
.include "./src/game/game_loop.z80.asm"
.include "./src/game/game_borders.z80.asm"
.include "./src/game/game_platforms.z80.asm"
.include "./src/game/platform_renderer.z80.asm"
.include "./src/game/sprite_engine.z80.asm"
.include "./src/game/sprite_move.z80.asm"





z_total_bytes: .equ *-start