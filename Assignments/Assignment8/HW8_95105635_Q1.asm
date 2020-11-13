name "code1"

org 100h

code segment
readInteger Macro

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
endM

num DW 0h

printInteger Macro
push bx
mov bx , 0
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
pop bx
endM


mov ax , 0
mov bx , 0
mov cx , 0
mov dx , 0
readInteger
mov ax , dx
mov bx , 1
mov cx , 0
mov dx , 0
push 0
; bx as counter
itLoop:
cmp bx , ax
jg exitItLoop
mov cx , ax
div bx
mov ax , cx
cmp dx , 0
jne dontAdd
pop cx
add cx , bx
push cx
dontAdd:
mov dx , 0
add bx , 1
jmp ItLoop
exitItLoop:
pop ax
mov num , ax
printInteger
.Exit

code ends



