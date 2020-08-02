; Programa que soma os 100 primeiros n�meros inteiros positivos.
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

.code
start:

    mov eax, 0  ; registrador de resultados
    mov ebx, 0  ; registrador de operandos

    Somador:
        inc ebx      ; incrementa o registrador de operandos
        add eax, ebx ; soma ao registrador de resultados o valor do registrador de operandos
        cmp ebx, 100 ; compara o valor do registrador de operandos com 100
        JE Resultado ; se a compara��o resultar em dois n�meros iguais (100 = 100), desvia o programa para Resultado
        jmp Somador  ; se o programa n�o for desviado, desvia o programa para o in�cio do la�o
    Resultado:
        printf("EAX: %d\n", eax) ; imprime o resultado
        invoke ExitProcess, 0    ; encerra o programa

end start