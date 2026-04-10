.model small
.stack 100h

.data
msg1 db 'Full Name: Fajar Khalil $'
msg2 db 0Dh,0Ah,'SAP ID: 68935 $'
msg3 db 0Dh,0Ah,'Batch: 2025 $'
msg4 db 0Dh,0Ah,'Program + Semester: BSSE - 3rd Semester $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display Full Name
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Display SAP ID
    mov ah, 09h
    lea dx, msg2
    int 21h

    ; Display Batch
    mov ah, 09h
    lea dx, msg3
    int 21h

    ; Display Program + Semester
    mov ah, 09h
    lea dx, msg4
    int 21h

    mov ah, 4Ch
    int 21h
main endp
end main




