name "code6"   ; output file name (max 8 chars for DOS compatibility)

org  100h	; set location counter to 100h

.data


.code   

; A's address -> BX

; 1:A.array[2] = *(A.pointer)
mov ax , <bx>
mov cx , bx
mov bx , ax
mov dx , <bx> ;dx = *(A.pointer)
mov bx , cx
add bx , 2 ; bx addressing A.array
add bx , 4 ; bx addressing &array[2]
mov <bx> , dx ; A.array[2] = *(A.pointer)

; 2:*(A.pointer) = A.f->array[1]  
mov cx , bx
add bx , 2 ; bx addressing array
add bx , 12 ; bx addressing f
mov bx , <bx> ; bx addressing *f
add bx , 2 ; bx addressing array in *f
add bx , 2 ; bx addressing &array[1] in *f
mov dx , <bx> ; dx = A.f->array[1]
mov bx , cx
mov bx , <bx> ; bx = A.pointer
mov <bx> , dx ; *(A.pointer) = A.f->array[1] 

; 3:A.f->array[2] = A.array[4]
mov cx , bx
add bx , 2 ; bx addressing A.array
add bx , 8 ; bx addressing &array[4]
mov dx , <bx> ; dx = A.array[4]
mov bx , cx
add bx , 2 ; bx addressing array
add bx , 12 ; bx addressing f
mov bx , <bx> ; bx addressing *f
add bx , 2 ; bx addressing array in *f
add bx , 4 ; bx addressing &array[2] in *f
mov <bx> , dx ; A.f->array[2] = A.array[4]

