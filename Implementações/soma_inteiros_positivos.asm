; Programa que soma os 100 primeiros números inteiros positivos.
; Thomás Augusto Gouveia Chavds
; 29/07/2020

.686 ; Modo de Execução seguro
.model flat, stdcall ; Memória Flat (instruções e dados) e Chamadas de Funções do Masm (stdcall)
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
        JE Resultado ; se a comparação resultar em dois números iguais (100 = 100), desvia o programa para Resultado
        jmp Somador  ; se o programa não for desviado, desvia o programa para o início do laço
    Resultado:
        printf("EAX: %d\n", eax) ; imprime o resultado
        invoke ExitProcess, 0    ; encerra o programa

end start