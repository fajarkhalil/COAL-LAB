
.model small
.stack 100h

.data
menu db 0Dh,0Ah,"1. Add",0Dh,0Ah,"2. Multiply",0Dh,0Ah,"3. Undo",0Dh,0Ah,"4. Redo",0Dh,0Ah,"5. Exit",0Dh,0Ah,"Enter choice: $"

msg1 db 0Dh,0Ah,"Enter first number: $"
msg2 db 0Dh,0Ah,"Enter second number: $"
resultMsg db 0Dh,0Ah,"Result: $"
undoMsg db 0Dh,0Ah,"Undo Result: $"
redoMsg db 0Dh,0Ah,"Redo Result: $"
noUndo db 0Dh,0Ah,"Nothing to undo$"
noRedo db 0Dh,0Ah,"Nothing to redo$"

num1 dw ?
num2 dw ?
result dw 0

undoStack dw 10 dup(0)
redoStack dw 10 dup(0)
uTop dw -1
rTop dw -1

.code
main proc

mov ax, @data
mov ds, ax

start:

; display menu
lea dx, menu
mov ah, 09h
int 21h

; input choice
mov ah, 01h
int 21h
sub al, 30h

cmp al, 1
je add_op
cmp al, 2
je mul_op
cmp al, 3
je undo_op
cmp al, 4
je redo_op
cmp al, 5
je exit

jmp start

; ---------------- ADD ----------------
add_op:
call saveUndo

; input numbers
lea dx, msg1
mov ah, 09h
int 21h
call input

mov num1, ax

lea dx, msg2
mov ah, 09h
int 21h
call input

mov num2, ax

mov ax, num1
add ax, num2
mov result, ax

call printResult
jmp start

; ---------------- MULTIPLY ----------------
mul_op:
call saveUndo

lea dx, msg1
mov ah, 09h
int 21h
call input
mov num1, ax

lea dx, msg2
mov ah, 09h
int 21h
call input
mov num2, ax

mov ax, num1
mul num2
mov result, ax

call printResult
jmp start

; ---------------- UNDO ----------------
undo_op:
cmp uTop, -1
je no_undo

call saveRedo

mov si, uTop
mov ax, undoStack[si]
mov result, ax
dec uTop

lea dx, undoMsg
mov ah, 09h
int 21h

call printNum
jmp start

no_undo:
lea dx, noUndo
mov ah, 09h
int 21h
jmp start

; ---------------- REDO ----------------
redo_op:
cmp rTop, -1
je no_redo

call saveUndo

mov si, rTop
mov ax, redoStack[si]
mov result, ax
dec rTop

lea dx, redoMsg
mov ah, 09h
int 21h

call printNum
jmp start

no_redo:
lea dx, noRedo
mov ah, 09h
int 21h
jmp start

; ---------------- SAVE UNDO ----------------
saveUndo:
inc uTop
mov si, uTop
mov ax, result
mov undoStack[si], ax
ret

; ---------------- SAVE REDO ----------------
saveRedo:
inc rTop
mov si, rTop
mov ax, result
mov redoStack[si], ax
ret

; ---------------- PRINT RESULT ----------------
printResult:
lea dx, resultMsg
mov ah, 09h
int 21h
call printNum
ret

; ---------------- INPUT NUMBER ----------------
input:
mov ah, 01h
int 21h
sub al, 30h
mov ah, 0
ret

; ---------------- PRINT NUMBER ----------------
printNum:
mov ax, result
add ax, 30h
mov dl, al
mov ah, 02h
int 21h
ret

; ---------------- EXIT ----------------
exit:
mov ah, 4Ch
int 21h

main endp
end main




