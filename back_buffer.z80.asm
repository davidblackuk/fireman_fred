;
; Store the attributes in a backup are for later restoration
;
store_attributes:
    push hl
    
    ld hl, attr_line_000
    ld de, attributes_restore_point
    ld bc, attributes_length
    ldir
    
    pop hl
    ret

;
; once the back buffer is blitted to the screen then we restore
; attributres for the platforms and ladders etc and remove the sprite 
; attributes from the map
;
restore_attributes:
    push hl

    ld hl, attributes_restore_point
    ld de, attr_line_000
    ld bc, attributes_length
    ldir
    
    pop hl
    ret


;
; Fill size back buffer implementation not space efficient
;

transfer:
	HALT					    ; Wait for Top Of Scanline, in reality would set up IM2 or something
	DI			  		        ; Disable Interrupts
	LD (stack_pointer_copy),SP 	; Store Stack Pointer
	LD SP,screen_map 		    ; Point SP to our table of source and destination (display) addresses

	; Wait for scan line
	LD BC, $0320 ; 800
@loop_beam:
	DEC BC
	LD A,B
	OR C
	JR NZ,@loop_beam

	LD A,192 		; iterate over all screen lines
@line_loop:
	POP DE   		; Get screen address
	POP HL   		; Get buffer address
	
	LDI				; copy 32 bytes from the backbuffer to the screen
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI		
	LDI			


	DEC A			; Move to next row
	JR NZ,@line_loop 	; repeat until all done

	LD SP,(stack_pointer_copy) 	; restore Stack Pointer

	ld hl, attr_line_000		; hack blit of the attributes
	ld de, attr_start
	ld bc, attributes_length
	ldir

	EI ; enable interrupts
	ret

cls_backbuffer:
	ld hl, char_line_00
	ld de, char_line_00 + 1
	ld bc, screen_size-1 
	ld (hl), 0
	ldir

	ld hl, attr_line_000
	ld de, attr_line_000 + 1
	ld bc, attributes_length-1 
	ld (hl), a
	ldir
	ret

;
; add attribute checkers to the screen to aid placement
;
checkerboard:
    push hl
    
    ld hl, attr_line_000
    ld de, %0011100000000000
    ld b, screen_height_chars 
@yloop:    
    ld c, b
    ld b, screen_width_chars
@xloop:
    ld a, (hl)
    bit 0, l
    jr nz, @hitattr
    and %111
    or d
    jr @doneattr
@hitattr:
    and %111
    or e
@doneattr:
    ld (hl), a
    inc hl
    djnz @xloop
    ld a, d
    ld d, e
    ld e, a

    ld b, c
    djnz @yloop

    
    pop hl
    ret

stack_pointer_copy:
	.word 0

; We only expost the character sart addresses now because we always align sprites on them anyway.
; THe previous line by line approach poluted the symbol table
backbuffer:
char_line_00: 	.storage 32 * 8
char_line_01: 	.storage 32 * 8
char_line_02:	.storage 32 * 8
char_line_03:	.storage 32 * 8
char_line_04:	.storage 32 * 8
char_line_05:	.storage 32 * 8
char_line_06:	.storage 32 * 8
char_line_07:	.storage 32 * 8
char_line_08:	.storage 32 * 8
char_line_09:	.storage 32 * 8
char_line_10:	.storage 32 * 8
char_line_11:	.storage 32 * 8
char_line_12:	.storage 32 * 8
char_line_13:	.storage 32 * 8
char_line_14:	.storage 32 * 8
char_line_15:	.storage 32 * 8
char_line_16:	.storage 32 * 8
char_line_17:	.storage 32 * 8
char_line_18:	.storage 32 * 8
char_line_19:	.storage 32 * 8
char_line_20:	.storage 32 * 8
char_line_21:	.storage 32 * 8
char_line_22:	.storage 32 * 8
char_line_23:	.storage 32 * 8


attr_line_000: 	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

;
; Once the platforms are rendered we copy the attribute map  here, it
; is restored every frame befor the sprites are rendered. Easier than 
; having possibly a per sprite and fred attribute store
;
attributes_restore_point: 
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
               .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

attributes_restore_end: .equ * 

off_by_one: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0



;
; Foreach scan line we store a pair that represent the address of the 
; start of a row in the physical screen and the matching row start in the back buffer
; for Screen address 0 ($4000) maps to char_line_00 contained in here
;
screen_map:		
.word $4000, char_line_00 + 0,    $4100, char_line_00 + 32,   $4200, char_line_00 + 64,  $4300, char_line_00 + 96
.word $4400, char_line_00 + 128,  $4500, char_line_00 + 160,  $4600, char_line_00 + 192,  $4700, char_line_00 + 224
.word $4020, char_line_00 + 256,  $4120, char_line_00 + 288,  $4220, char_line_00 + 320,  $4320, char_line_00 + 352
.word $4420, char_line_00 + 384,  $4520, char_line_00 + 416,  $4620, char_line_00 + 448,  $4720, char_line_00 + 480
.word $4040, char_line_00 + 512,  $4140, char_line_00 + 544,  $4240, char_line_00 + 576,  $4340, char_line_00 + 608
.word $4440, char_line_00 + 640,  $4540, char_line_00 + 672,  $4640, char_line_00 + 704,  $4740, char_line_00 + 736
.word $4060, char_line_00 + 768,  $4160, char_line_00 + 800,  $4260, char_line_00 + 832,  $4360, char_line_00 + 864
.word $4460, char_line_00 + 896,  $4560, char_line_00 + 928,  $4660, char_line_00 + 960,  $4760, char_line_00 + 992
.word $4080, char_line_00 + 1024, $4180, char_line_00 + 1056, $4280, char_line_00 + 1088, $4380, char_line_00 + 1120
.word $4480, char_line_00 + 1152, $4580, char_line_00 + 1184, $4680, char_line_00 + 1216, $4780, char_line_00 + 1248
.word $40A0, char_line_00 + 1280, $41A0, char_line_00 + 1312, $42A0, char_line_00 + 1344, $43A0, char_line_00 + 1376
.word $44A0, char_line_00 + 1408, $45A0, char_line_00 + 1440, $46A0, char_line_00 + 1472, $47A0, char_line_00 + 1504
.word $40C0, char_line_00 + 1536, $41C0, char_line_00 + 1568, $42C0, char_line_00 + 1600, $43C0, char_line_00 + 1632
.word $44C0, char_line_00 + 1664, $45C0, char_line_00 + 1696, $46C0, char_line_00 + 1728, $47C0, char_line_00 + 1760
.word $40E0, char_line_00 + 1792, $41E0, char_line_00 + 1824, $42E0, char_line_00 + 1856, $43E0, char_line_00 + 1888
.word $44E0, char_line_00 + 1920, $45E0, char_line_00 + 1952, $46E0, char_line_00 + 1984, $47E0, char_line_00 + 2016
.word $4800, char_line_00 + 2048, $4900, char_line_00 + 2080, $4A00, char_line_00 + 2112, $4B00, char_line_00 + 2144
.word $4C00, char_line_00 + 2176, $4D00, char_line_00 + 2208, $4E00, char_line_00 + 2240, $4F00, char_line_00 + 2272
.word $4820, char_line_00 + 2304, $4920, char_line_00 + 2336, $4A20, char_line_00 + 2368, $4B20, char_line_00 + 2400
.word $4C20, char_line_00 + 2432, $4D20, char_line_00 + 2464, $4E20, char_line_00 + 2496, $4F20, char_line_00 + 2528
.word $4840, char_line_00 + 2560, $4940, char_line_00 + 2592, $4A40, char_line_00 + 2624, $4B40, char_line_00 + 2656
.word $4C40, char_line_00 + 2688, $4D40, char_line_00 + 2720, $4E40, char_line_00 + 2752, $4F40, char_line_00 + 2784
.word $4860, char_line_00 + 2816, $4960, char_line_00 + 2848, $4A60, char_line_00 + 2880, $4B60, char_line_00 + 2912
.word $4C60, char_line_00 + 2944, $4D60, char_line_00 + 2976, $4E60, char_line_00 + 3008, $4F60, char_line_00 + 3040
.word $4880, char_line_00 + 3072, $4980, char_line_00 + 3104, $4A80, char_line_00 + 3136, $4B80, char_line_00 + 3168
.word $4C80, char_line_00 + 3200, $4D80, char_line_00 + 3232, $4E80, char_line_00 + 3264, $4F80, char_line_00 + 3296
.word $48A0, char_line_00 + 3328, $49A0, char_line_00 + 3360, $4AA0, char_line_00 + 3392, $4BA0, char_line_00 + 3424
.word $4CA0, char_line_00 + 3456, $4DA0, char_line_00 + 3488, $4EA0, char_line_00 + 3520, $4FA0, char_line_00 + 3552
.word $48C0, char_line_00 + 3584, $49C0, char_line_00 + 3616, $4AC0, char_line_00 + 3648, $4BC0, char_line_00 + 3680
.word $4CC0, char_line_00 + 3712, $4DC0, char_line_00 + 3744, $4EC0, char_line_00 + 3776, $4FC0, char_line_00 + 3808
.word $48E0, char_line_00 + 3840, $49E0, char_line_00 + 3872, $4AE0, char_line_00 + 3904, $4BE0, char_line_00 + 3936
.word $4CE0, char_line_00 + 3968, $4DE0, char_line_00 + 4000, $4EE0, char_line_00 + 4032, $4FE0, char_line_00 + 4064
.word $5000, char_line_00 + 4096, $5100, char_line_00 + 4128, $5200, char_line_00 + 4160, $5300, char_line_00 + 4192
.word $5400, char_line_00 + 4224, $5500, char_line_00 + 4256, $5600, char_line_00 + 4288, $5700, char_line_00 + 4320
.word $5020, char_line_00 + 4352, $5120, char_line_00 + 4384, $5220, char_line_00 + 4416, $5320, char_line_00 + 4448
.word $5420, char_line_00 + 4480, $5520, char_line_00 + 4512, $5620, char_line_00 + 4544, $5720, char_line_00 + 4576
.word $5040, char_line_00 + 4608, $5140, char_line_00 + 4640, $5240, char_line_00 + 4672, $5340, char_line_00 + 4704
.word $5440, char_line_00 + 4736, $5540, char_line_00 + 4768, $5640, char_line_00 + 4800, $5740, char_line_00 + 4832
.word $5060, char_line_00 + 4864, $5160, char_line_00 + 4896, $5260, char_line_00 + 4928, $5360, char_line_00 + 4960
.word $5460, char_line_00 + 4992, $5560, char_line_00 + 5024, $5660, char_line_00 + 5056, $5760, char_line_00 + 5088
.word $5080, char_line_00 + 5120, $5180, char_line_00 + 5152, $5280, char_line_00 + 5184, $5380, char_line_00 + 5216
.word $5480, char_line_00 + 5248, $5580, char_line_00 + 5280, $5680, char_line_00 + 5312, $5780, char_line_00 + 5344
.word $50A0, char_line_00 + 5376, $51A0, char_line_00 + 5408, $52A0, char_line_00 + 5440, $53A0, char_line_00 + 5472
.word $54A0, char_line_00 + 5504, $55A0, char_line_00 + 5536, $56A0, char_line_00 + 5568, $57A0, char_line_00 + 5600
.word $50C0, char_line_00 + 5632, $51C0, char_line_00 + 5664, $52C0, char_line_00 + 5696, $53C0, char_line_00 + 5728
.word $54C0, char_line_00 + 5760, $55C0, char_line_00 + 5792, $56C0, char_line_00 + 5824, $57C0, char_line_00 + 5856
.word $50E0, char_line_00 + 5888, $51E0, char_line_00 + 5920, $52E0, char_line_00 + 5952, $53E0, char_line_00 + 5984
.word $54E0, char_line_00 + 6016, $55E0, char_line_00 + 6048, $56E0, char_line_00 + 6080, $57E0, char_line_00 + 6112



