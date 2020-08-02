; Programa que soma o valor de duas vari�veis de nomes b e d
; com 100 e armazena em outra vari�vel de nome a
; Thom�s Augusto Gouveia Chavds
; 29/07/2020

.686                 ; Modo de Execu��o seguro
.model flat, stdcall ; Mem�ria Flat (instru��es e dados) e Chamadas de Fun��es do Masm (stdcall)
option casemap :none ; case sensitive

; BIBLIOTECAS
include \masm32\include\kernel32.inc ; kernel windows
include \masm32\include\msvcrt.inc   ; console
includelib \masm32\lib\kernel32.lib  ; kernel windows
includelib \masm32\lib\msvcrt.lib    ; console
include \masm32\macros\macros.asm    ; macro printf
; --

.data

    a DD 0
    b DD 15
    d DD 35

.code
start:

    mov eax, a            ; move a ao registrador eax
    add eax, b            ; soma b ao registrador eax
    add eax, d            ; soma d ao registrador eax
    add eax, 100          ; soma 100 ao registrador eax
    add a, eax            ; soma a vari�vel a o valor do registrador eax eax
    printf("a: %d\n", a)  ; imprime o resultado
    invoke ExitProcess, 0 ; encerra o programa

end start