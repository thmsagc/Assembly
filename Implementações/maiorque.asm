; Programa que compara os valores das variaveis de nome a e b
; e imprime o maior deles
; Thom�s Augusto Gouveia Chavds
; 29/07/2020

.686 ; Modo de Execu��o seguro
.model flat, stdcall ; Mem�ria Flat (instru��es e dados) e Chamadas de Fun��es do Masm (stdcall)
option casemap :none ; case sensitive

; BIBLIOTECAS
include \masm32\include\kernel32.inc ; kernel windows
include \masm32\include\msvcrt.inc ; console
includelib \masm32\lib\kernel32.lib ; kernel windows
includelib \masm32\lib\msvcrt.lib ; console
include \masm32\macros\macros.asm ; macro printf
; --

.data

    a SDWORD 5 ; vari�vel (signed int)
    b SDWORD 7 ; vari�vel (signed int)

.code
start:

    mov eax, a              ; move o valor da vari�vel a para o registrador eax
    cmp eax, b              ; compara o valor registrador eax com o valor da vari�vel b
    JGE Resultado           ; se o valor da v�ri�vel b � >= ao valor do registrador eax, desvia o programa para para Resultado
    mov eax, b              ; move o valor da vari�vel b para o registrador eax
    Resultado:          
    printf("%d\n", eax)     ; imprime o resultado
    invoke ExitProcess, 0
        

end start