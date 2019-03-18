;---------------------------------------------------V--------------------

; char x, pixel y, sprite no, start frame, path, length, dir, speed, attributes
sprt_0:
	.byte 0											; flags
	.storage sprite_definition_len                      ; sprite definition (see level001.z8asm)
    .byte 0                                          ; current frameskip value
sprt_bg_offset: .equ * - sprt_0
	.storage sprite_bytes								; sprite background
sprt_buff_len: .equ * - sprt_0

sprite_1: .storage sprt_buff_len
sprite_2: .storage sprt_buff_len
sprite_3: .storage sprt_buff_len
sprite_4: .storage sprt_buff_len
sprite_5: .storage sprt_buff_len
sprite_6: .storage sprt_buff_len
sprite_7: .storage sprt_buff_len


