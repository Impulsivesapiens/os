org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main
    ; BIOS loads the boot sector at 0x7C00
    ; Set up the stack

puts:
    push si
    push ax

puts_loop:
    lodsb ; Load the next byte from the string into AL
    or al, al ; Check for null terminator
    jz puts_done ; If null terminator, jump to done

    mov ah, 0x0E ; BIOS teletype function
    mov bh, 0 ; Page number

    int 0x10 ; Call BIOS interrupt to print character
    jmp puts_loop ; Repeat for next character

puts_done:
    pop ax
    pop si 
    ret

main:
    ; Set up the stack pointer
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; Set up the stack segment
    ; The stack segment is usually set to the same as the data segment
    mov ss, ax
    mov sp, 0x7C00
    ; Set up the data segment

    mov si, msg_hello
    call puts ; Call the puts function to print the message

    hlt

.halt:
    jmp .halt

    ; Print a message to the screen
msg_hello: db 'Hello, World!', ENDL, 0


    ; Boot sector code must be exactly 512 bytes
    ; Fill the rest of the boot sector with zeros
times 510 - ($ - $$) db 0
    ; Boot sector signature
dw 0xAA55