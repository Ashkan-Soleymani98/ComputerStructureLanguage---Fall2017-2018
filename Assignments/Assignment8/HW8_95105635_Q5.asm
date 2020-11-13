name "code5"   ; output file name (max 8 chars for DOS compatibility)

org  100h	; set location counter to 100h

.data
    x db 100 dup<?> 
    n dw 0h
.code   
num DW 0
printInteger Macro
    push ax
    push bx
    push cx
    push dx
    mov bx , 0
    mov cx , 0
    mov ax , 0
    mov dx , 0 
    decimal: 
    mov dx, 0
    cmp num, 0
    je exit2
    
    mov ax, num
    mov cl, 0Ah
    div cx 
    push dx
    add bx, 1
    mov num, ax
    jmp decimal
    
    
    exit2: 
    mov cx, 0
    print: 
    
    pop dx 
    add dx, 30h
    mov ah, 2
    int 21h  
    
    inc cx
    cmp cx, bx
    jne print
    pop dx
    pop cx
    pop bx
    pop ax
endM

printEnter Macro
push ax
push bx
push cx
push dx
mov ah, 0Eh
mov al, 0dh
int 10h
Mov al, 0Ah
int 10h
pop dx
pop cx 
pop bx
pop ax
endM

call readInteger
mov ax , dx
call readInteger
mov bx , dx
push bx
push ax
;push 444
call comb
pop num
printInteger
.Exit

comb proc near
    pop cx ; return address
    pop ax ;n
    pop bx ;r
    cmp ax , bx
    je isOne
    cmp bx , 0
    je isOne
    
    recursive:
    push cx
    push bx
    push ax
    
    sub ax , 1
    push bx
    push ax
    call comb
    pop dx    
           
    pop ax
    pop bx
    pop cx
    
   
    push dx
    push cx
    
    sub ax , 1
    sub bx , 1
    push bx
    push ax
    call comb
    pop ax
    
    pop cx
    pop dx
    
    add ax , dx
    push ax
    
    push cx
    ret 0
    isOne:
    push 1
    push cx  
    ret 0
    
readInteger proc near
push ax
push bx
push cx
mov ax , 0
mov bx , 0
mov cx , 0
mov dx , 0
enterNum:
mov ah,1
int 21h
mov ah, 0
cmp ax, 39h
jg next
cmp ax, 30h
jl next
sub al, 30h
mov bl, al
mov ax, dx
mov cx, 0xa
mul cx
add ax, bx
mov dx, ax
jmp enterNum
next:
printEnter
; popping
pop cx
pop bx
pop ax
ret 0  ;in dx!

