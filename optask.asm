%include "io.inc"
SECTION .data
msg1:   db    'Please enter x and y: ', 0Ah      ; message string asking user for input
input:  times 100 db 0
str1:   times 50  db 0
str2:   times 50  db 0
op1:    times 50  db 0
op2:    times 50  db 0
length1: db 0
lenght2: db 0
longerLength: db 0
result: times 100 db 0

section .text
global CMAIN
CMAIN:
    mov     eax, msg1
    call    Sprint
    mov     edx, 255        
    mov     ecx, input      
    mov     ebx, 0          
    mov     eax, 3          
    int     80h
    call    Split
    mov eax,str1
    call Sprint
    mov eax,str2
    call Sprint
    
    mov edi,str1
    add edi,30
    mov esi,op1
    mov edx,str1
    call reverse
    
    mov edi,str2
    add edi,30
    mov esi,op2
    mov edx,str2
    call reverse
    
    mov eax,op1
    call Sprint
    mov eax,op2
    call Sprint
    call    LongerLength
    call    Add_
    ret
    
;将输入的两个string分开，并且将长的那个长度储存在longerLength中
Split:
    mov edx,input
    mov esi,str1
    mov edi,str2
InputStr1:
    cmp byte[edx],32
    je IgnoreSpace
    mov byte[esi],byte[edx]
    inc esi
    inc edx    
    jmp InpurStr1
IgnoreSpace:
    inc edx
InputStr2:
    cmp byte[edx],10
    je FinishInput
    mov byte[edi],byte[edx]
    inc edi
    inc edx
    jmp InputStr2
FinishInput:
    sub esi,str1
    sub edi,str2
    mov eax,esi
    mov ebx,edi
    mov edx,longerLength
    cmp al,bl
    ja 1Longer
    mov byte[edx],bl
    ret
1Longer:
    mov byte[edx],al
    ret
    
Reverse:
    cmp byte[edi],0
    jne Transport
    sub edi,1
    jmp Reverse
Transport:
    mov byte[esi],byte[edi]
    sub edi,1
    add esi,1
    cmp edi,edx
    jb Return
Return:
    ret    

;工具函数
slen:
    push    ebx
    mov     ebx, eax
 
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
 
finished:
    sub     eax, ebx
    pop     ebx
    ret

Sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
    mov     edx, eax
    mov     ecx, [esp]
    mov     ebx, 1
    mov     eax, 4
    int     80h
    pop     eax
    pop     ebx
    pop     ecx
    pop     edx
    ret


    