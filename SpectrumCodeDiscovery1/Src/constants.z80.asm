﻿;---------------------------------------------------V--------------------
;
; File: constants.z80.asm
; Desc: Constants used across the application
;

PR_STRING:			.equ $203C
CHAN_OPEN:			.equ $1601	
UPPER_CHAN:			.equ $2
BORDER:				.equ $229b
PRINT_SET_PAPER:	.equ 17
PRINT_SET_INK:		.equ 16
PRINT_AT:			.equ 22
	
LASTK:				.equ 23560

screen_width_pixels: 	.equ 256
screen_height_pixels: 	.equ 192
screen_width_chars: 	.equ 32
screen_height_chars: 	.equ 24

screen_start: 			.equ $4000
screen_size: 			.equ screen_width_chars * screen_height_pixels
attr_start:				.equ $5800
attributes_length: 		.equ screen_width_chars * screen_height_chars



; platform / sprite direction
horizontal:			.equ 0
vertical:			.equ 1
none:				.equ 2

left:				.equ 01
right:				.equ 2
up:					.equ 1
down:				.equ 2


; game level IX offsets
i_lvl_border:		.equ 0
i_lvl_attr:			.equ 1
i_lvl_l_bord_chr:	.equ 2
i_lvl_r_bord_chr:	.equ 3
i_lvl_b_bord_chr:	.equ 4
i_lvl_bord_color:	.equ 5
	
i_lvl_sprt_x: 		.equ 0
i_lvl_sprt_y: 		.equ 1
i_lvl_sprt_no:		.equ 2
i_lvl_sprt_frm: 	.equ 3
i_lvl_sprt_pth:		.equ 4
i_lvl_sprt_len:		.equ 5
i_lvl_sprt_dir:		.equ 6
i_lvl_sprt_spd:		.equ 7
i_lvl_sprt_atr:		.equ 8

;
; Sprite buffer offsets
;
i_sb_flags: 	    .equ 0
i_sb_scr_cur: 	    .equ 1	
i_sb_scr_low: 	    .equ 3
i_sb_scr_hig: 	    .equ 5
i_sb_anim_1: 	    .equ 7
i_sb_anim_2: 	    .equ 9
i_sb_anim_3: 	    .equ 11
i_sb_anim_4: 	    .equ 13
i_sb_anim_fr: 	    .equ 15
i_sb_attrs: 	    .equ 16
i_sb_sp_type: 	    .equ 17
i_sb_sp_dir: 	    .equ 18
i_sb_sp_const_skip: .equ 19
i_sb_sp_velocity:   .equ 20
i_sb_sp_curr_skip:  .equ 21


; Plateform flags
plt_empty:   .equ 0	; no platform at this position
plt_blocker: .equ $01	; this character cell block movement into it from any dir
plt_normal:  .equ $02	; can jump through and walk through, but will land on
plt_ladder:  .equ $04	; it's a ladder

last_definition: .equ $88


// sprite system stuff
sprite_max: .equ 8

sprite_height: .equ 15
sprite_bytes: .equ sprite_height*2


; --------------------------------------
; Constants for keys on the title screen 
; --------------------------------------

key_play:       .equ 0
key_demo:       .equ 1
key_practice:   .equ 2

; --------------------------------------
; Game constants 
; --------------------------------------

max_level:      .equ 4