name "code3"   ; output file name (max 8 chars for DOS compatibility)

org  100h	; set location counter to 100h

.data
    array dw 3,1,2,7,4,9,-3,2,20,0  ;assign array here
    n dw 10 ;assign array length here
    ;these are temporary helping memory units
    address dw 0
    templimit dw 0
    tempn dw 0
    temp dw 0
.code   

lea ax , array              
push ax
push n
call qsort

.Exit
qsort proc near
    pop cx
    pop ax ; ax = n
    pop bx ; bx = array
    ;mov address , bx
    cmp ax , 0
    je return
    cmp ax , 1
    je return
    cmp ax , 2
    jne recursive
    mov dx , <bx>
    mov ax , <bx + 2>
    cmp dx , ax
    jng return
    mov <bx> , ax
    mov <bx + 2> , dx
    jmp return
    
    
    recursive:
    push cx
    mov templimit , ax
    mov tempn , ax
    sub templimit , 1
    ; indice
    mov cx , 0 ; j
    mov dx , -1 ; i
    checkLoop:
        cmp cx , templimit
        je exitCheckLoop
        push bx;
        ;lea bx , address
        add bx , cx
        add bx , cx
        mov ax , <bx>
        pop bx;
        push bx;
        ;lea bx , address
        add bx , templimit
        add bx , templimit
        cmp ax , <bx> ; compare vs pivot
        pop bx;
        jnl noAct
        add dx , 1
        ;swap
        push dx
        push bx;
        ;lea bx , address
        add bx , dx
        add bx , dx
        mov dx , <bx>
        mov <bx> , ax
        pop bx;
        push bx;
        ;lea bx , address
        add bx , cx
        add bx , cx
        mov <bx> , dx 
        pop bx;
        pop dx
        noAct:
        add cx , 1
        jmp checkLoop
    exitCheckLoop:
    ; place pivot
    add dx , 1
    push bx;
    ;lea bx , address
    add bx , dx
    add bx , dx
    mov cx , <bx>
    pop bx;
    push bx;
    ;lea bx , address
    add bx , templimit
    add bx , templimit
    mov ax , <bx>
    mov <bx> , cx
    pop bx;
    push bx;
    ;lea bx , address
    add bx , dx
    add bx , dx
    mov <bx> , ax
    pop bx;    
    pop cx
    mov ax , tempn 
    

    
    push bx
    push ax 
    push dx
    push cx
    ;lea bx , address
    push bx
    push dx
    call qsort
    pop cx
    pop dx
    pop ax
    pop bx
    
    push cx
    
    ;lea bx , address
    add bx , dx
    add bx , dx
    add bx , 2
    push bx
    sub ax , dx
    sub ax , 1
    push ax
    call qsort
    pop cx
    
    return:
    push cx      
    ret 0
    

