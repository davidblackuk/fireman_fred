;---------------------------------------------------V--------------------
;
; File: Main.z80.asm
; Desc: Main entry point for the application, bootstraps the game
;

.include "./constants.z80.asm"
.include "./macros.z80.asm"

 //Setup for ZX Spectrum (Z80 CPU mode)
    .target "z80"

    .setting "OutputFileType", "tap"                ;TAP output format for ZX Spectrum 48KB
    .setting "TapStart", Start                      ;The start address of the program.
    .setting "TapClear", $5fff                      ;The CLEAR VAL address in the BASIC
                                                    ;loader which clears up the RAM
                                                    ;before the binary code loads.
    ; my windows box launch settings
    .setting "LaunchCommand", "D:\\emulation\\emulators\\Fuse\\fuse.exe --no {0}"

    ; my linux  box launch settings
    ; .setting "LaunchCommand", "{0}"

     .org $8000


start:
	call title_screen		                        ; returns key pressed in a 	
	
    cp key_play                                     ; play    
	jp z, play
    
    cp key_demo                                     ; pick a random level to show / level order

    cp key_practice                                 ; pick any level

    jp start

play:    
    ld hl, 0    
begin_level:    
    push hl
	call start_game                                 ; status returned in a
    pop hl

    cp level_complete_fail                          ; did we fail?
    jp z, begin_level                               ; if so don't increment the level number

    inc l                                           ; increment the level number
    ld a, l                                         
    cp max_level                                    
    jp nz, begin_level                              ; continue if not passed the last level

    jp start                                        ; go to the title screen




.include "./back_buffer.z80.asm"

.include "./levels/level01.z80.asm"
.include "./levels/level02.z80.asm"
.include "./levels/level03.z80.asm"
.include "./levels/level04.z80.asm"

.include "./levels/level06.z80.asm"

.include "./levels/level99.z80.asm"

;
; add new levels to this, the list of all levels, and
; increment max_level in constants
;
levels:  .word level_99, 
         .word level_01, level_02, level_03, 
         .word level_04,
         .word level_06

.include "functions.z80.asm"
.include "./gfx/fonts.z80.asm"

.include "./gfx/fred.z80.asm"
.include "./gfx/victims.z80.asm"
.include "./gfx/aliens.z80.asm"
.include "./gfx/platforms.z80.asm"

.include "./game/sprite_storage.z80.asm"

.include "./titles/print.z80.asm"
.include "./game/keyboard.z80.asm"
.include "./titles/title_screen.z80.asm"
.include "./titles/marquee.z80.asm"
.include "./game/game_loop.z80.asm"
.include "./game/game_borders.z80.asm"
.include "./game/game_platforms.z80.asm"
.include "./game/platform_renderer.z80.asm"
.include "./game/sprite_engine.z80.asm"
.include "./game/sprite_move.z80.asm"
.include "./game/ambulance.z80.asm"
.include "./game/fred_initialization.z80.asm"
.include "./game/fred_move.z80.asm"





z_total_bytes: .equ *-start
x_remaining_bytes .equ $ffff - *