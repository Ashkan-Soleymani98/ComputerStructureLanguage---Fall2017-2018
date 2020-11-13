name "code2"   ; output file name (max 8 chars for DOS compatibility)

org  100h    ; set location counter to 100h

.data
input db "You must : ad  replace this one!\0";the arbitrary string must be here!

.code
num DW 0h

printInteger Macro
push bx
push dx
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
pop dx
pop bx
endM

lea bx , input
mov cx , 0
printLoop:
cmp [bx + 1] , 0
je exitPrintLoop
cmp [bx] , 46 ; .
je addOne
cmp [bx] , 44 ; '
je addOne
cmp [bx] , 33 ; !
je addOne
cmp [bx] , 63 ; ?
je addOne
cmp [bx] , 13 ; Enter
je addOne
cmp [bx] , 59 ; ;
je addOne
cmp [bx] , 32 ; Space
je addOne
jmp dontAdd
addOne:
cmp [bx + 1] , 46 ; .
je dontAdd
cmp [bx + 1] , 44 ; '
je dontAdd
cmp [bx + 1] , 33 ; !
je dontAdd
cmp [bx + 1] , 63 ; ?
je dontAdd
cmp [bx + 1] , 13 ; Enter
je dontAdd
cmp [bx + 1] , 59 ; ;
je dontAdd
cmp [bx + 1] , 32 ; Space
je dontAdd
add cx , 1
dontAdd:
add bx , 1
jmp printLoop
exitPrintLoop:
mov num , cx
printInteger
.Exit





