org 0x7C00
bits 16

main:
    hlt

.halt:
    jmp .halt


    ; Boot sector code must be exactly 512 bytes
    ; Fill the rest of the boot sector with zeros
times 510 - ($ - $$) db 0
    ; Boot sector signature
dw 0xAA55