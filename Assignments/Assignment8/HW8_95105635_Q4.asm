name "code4"   ; output file name (max 8 chars for DOS compatibility)

org  100h	; set location counter to 100h

.data
    x db 100 dup(0h) 
    n dw 0h
    select db 0h
    a db 100 dup(0h)
    alength dw 0h
    b db 100 dup(0h)
    blength dw 0h  
    k dw 0h
    outputC dw 0h 
    outputR db 100 dup(0h)
    pointer dw 0h
    counter dw 0h
.code    
    num DW 0h
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

;code Start
; read n 
call readInteger
mov n , dx 
lea bx , x
mov cx , 0 ; cx as counter
xInputLoop:
    cmp cx , dx
    je exitXInputLoop
    mov ah , 1
    int 21h
    mov <bx> , al
    add bx , 1
    add cx , 1
    jmp xInputLoop
exitXInputLoop:

printEnter

; read select
lea bx , select
mov ah , 1
int 21h 
mov <bx> , al
printEnter
cmp <bx> , 'r'
je rSelect
cmp <bx> , 'c'
jne endSelect
; c 
    call readInteger
    mov alength , dx
    lea bx , a
    mov cx , 0 ; cx as counter
    aFirstInputLoop:
        cmp cx , dx
        je exitAFirstInputLoop
        mov ah , 1
        int 21h
        mov <bx> , al
        add bx , 1
        add cx , 1
        jmp aFirstInputLoop
    exitAFirstInputLoop:
    printEnter 
    mov cx , 0 ;as first counter
    mov dx , 0 ;as second counter
    mov ax , n ; k = n - a + 1
    sub ax , alength
    add ax , 1
    mov k , ax 
    checkOutCLoop:
        cmp cx , k
        je ExitCheckOutCLoop
        mov dx , 0
        checkInCLoop:
            cmp dx , alength
            je ExitCheckInCLoop
            lea bx , x
            add bx , cx
            add bx , dx
            mov al , <bx>
            lea bx , a
            add bx , dx
            mov bl , <bx>
            cmp al , bl
            jne NotInC
            add dx , 1
            jmp checkInCLoop
        ExitCheckInCLoop:
        add outputC , 1
        NotInC:
        add cx , 1
        jmp checkOutCLoop
    ExitCheckOutCLoop:
    mov dx , outputC
    mov num , dx
    printInteger   
jmp endSelect
rSelect:
; r 
    call readInteger
    mov alength , dx
    call readInteger
    mov blength , dx
    lea bx , a
    mov cx , 0 ; cx as counter
    aSecondInputLoop:
        cmp cx , alength
        je exitASecondInputLoop
        mov ah , 1
        int 21h
        mov <bx> , al
        add bx , 1
        add cx , 1
        jmp aSecondInputLoop
    exitASecondInputLoop:
    printEnter
    lea bx , b
    mov cx , 0 ; cx as counter
    bInputLoop:
        cmp cx , blength
        je exitBInputLoop
        mov ah , 1
        int 21h
        mov <bx> , al
        add bx , 1
        add cx , 1
        jmp bInputLoop
    exitBInputLoop:
    printEnter
    
    mov cx , 0 ;as first counter
    mov dx , 0 ;as second counter
    mov ax , n ; k = n - a + 1
    sub ax , alength
    add ax , 1
    mov k , ax 
    lea bx , outputR
    mov pointer , bx
    outLoop:
        cmp cx , n
        je ExitOutLoop
        cmp cx , k
        jge NotAlter
        mov dx , 0
        inLoop:
            cmp dx , alength
            je ExitInLoop
            lea bx , x
            add bx , cx
            add bx , dx
            mov al , <bx>
            lea bx , a
            add bx , dx
            mov bl , <bx>
            cmp al , bl
            jne NotAlter
            add dx , 1
            jmp inLoop
        ExitInLoop:
        add cx , alength
        mov dx , 0 ;as counter
        copyLoop:
                cmp dx , blength
                je ExitCopyLoop
                lea bx , b
                add bx , dx
                mov al , <bx>
                mov bx , pointer
                mov <bx> , al
                add pointer , 1
                add counter , 1
                add dx , 1
                jmp copyLoop
        ExitCopyLoop:
        NotAlter:
        lea bx , x
        add bx , cx
        mov al , <bx>
        mov bx , pointer
        mov <bx> , al
        add cx , 1
        add pointer , 1
        add counter , 1
        jmp outLoop
    ExitOutLoop:
    mov cx , 0 ; as counter 
    printLoop:
        cmp cx , counter
        je exitPrintLoop
        lea bx , outputR
        add bx , cx
        mov dx , <bx>
        mov ah , 2
        int 21h
        add cx , 1
        jmp printLoop
    exitPrintLoop:       
endSelect:   
.Exit

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
