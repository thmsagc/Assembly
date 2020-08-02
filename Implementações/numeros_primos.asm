; Programa que verifica se um número de entrada do usuário
; é primo ou não, imprime uma mensagem informando se é ou não
; e muda o valor de eax para 1, se for primo, ou 0, se não for primo
; Thomás Augusto Gouveia Chavds
; 01/08/2020

.686 ; Modo de Execução seguro
.model flat, stdcall ; Memória Flat (instruções e dados) e Chamadas de Funções do Masm (stdcall)
option casemap :none ; case sensitive

; BIBLIOTECAS
include \masm32\include\windows.inc ; windows
include \masm32\include\kernel32.inc ; kernel windows
include \masm32\include\masm32.inc ; kernel windows
include \masm32\include\msvcrt.inc ; console
includelib \masm32\lib\kernel32.lib ; kernel windows
includelib \masm32\lib\msvcrt.lib ; console
includelib \masm32\lib\masm32.lib ; console
include \masm32\macros\macros.asm ; macro printf
; --

.data
;STRINGS
request db "Digite um numero natural: ", 0H
primo db "O numero digitado e primo!", 0AH, 0H
nprimo db "O numero digitado nao e primo!", 0AH, 0H
novaOperacao db "> Voce deseja verificar outro numero? 0/1 ", 0H
encerrado db "Programa encerrado!", 0H
;--------
;VARIÁVEIS
numCaracteres dd 0
outputHandle dd 0
inputHandle dd 0
inputString db 10 dup(0)
operando dd 0
;--------

.code
start:
;CONSTANTES DE ENTRADA E SAIDA (windows.lib)
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov outputHandle, eax
invoke GetStdHandle, STD_INPUT_HANDLE
mov inputHandle, eax
;--------

;rotulo (INICIO)
inicio:

    invoke WriteConsole, outputHandle, addr request, sizeof request, addr numCaracteres, NULL      
    invoke ReadConsole, inputHandle, addr inputString, sizeof inputString, addr numCaracteres, NULL

    call arrumaEntrada

    cmp eax, 1  ; COMPARA EAX (OPERANDO) COM 1
    JE nnPrimo  ; SE EAX É 1, NAO É PRIMO

    ;INICIALIZA REGISTRADORES
    mov operando, eax
    mov edx, 0
    xor ecx, ecx
    xor ebx, ebx
    ;--------
  
    push operando         ; EMPILHA O OPERANDO
    call encontraDivisor  ; CHAMADA DE FUNÇÃO

    pop ecx               ; DESEMPILHA O OPERANDO PARA O REGISTRADOR ECX

    cmp ebx, ecx          ; COMPARA EBX (divisor) COM ECX (OPERANDO)
    JE eePrimo            ; SE FOREM IGUAIS, DESVIA PARA eePrimo
    jmp nnPrimo           ; SE NÃO, DESVIA PARA nnPrimo
;endrotulo 

;rotulo (ENCERRA O PROGRAMA)
encerra:
    printf("Programa encerrado.")
    invoke ExitProcess, 0
;endrotulo

;function
encontraDivisor:
    push ebp
    mov ebp, esp
    sub esp, 4

    mov eax, [ebp+8]    
    mov DWORD PTR [ebp-4], eax  ; COLOCANDO OPERANDO NA PILHA
    mov ebx, 1                  ; REGISTRADOR QUE ARMAZENA O DIVISOR            

    ;rotulo (LOOP1)
    loop1:
         mov eax, DWORD PTR [ebp-4] ; MOVE O OPERANDO DA PILHA PARA EAX
         inc ebx                    ; INCREMENTA O DIVISOR
         xor edx, edx               ; ZERA O REGISTRADOR EDX
         div ebx                    ; DIVIDE EDX:EAX POR EBX
         cmp edx, 0                 ; COMPARA O RESTO COM 0
         JE breakLoop               ; SE O RESTO É 0, QUEBRA O LOOP1
         jmp loop1                  ; SE NÃO, REPETE O LAÇO
    ;endrotulo
    
    ;rotulo (ENCERRA A FUNÇÃO)    
    breakLoop:  
         mov esp, ebp
         pop ebp
         ret
    ;endrotulo
;endfunction
    

;function (REMOVE CARACTERES INDESEJADOS DA inputString)
arrumaEntrada:
    mov esi, offset inputString
    proximo:
    mov al, [esi]
    inc esi
    cmp al, 48
    jl terminar
    cmp al, 58
    jl proximo
    terminar:
    dec esi
    xor al, al
    mov [esi], al
    invoke atodw, addr inputString
    ret
;endfunction


;rotulo (IMPRIME A STRING primo E DEFINE EAX COMO 1)
eePrimo:
    invoke WriteConsole, outputHandle, addr primo, sizeof primo, addr numCaracteres, NULL 
    mov eax, 1 
    jmp nOperacao
;endrotulo

;rotulo (IMPRIME A STRING Nprimo E DEFINE EAX COMO 0)
nnPrimo:
    invoke WriteConsole, outputHandle, addr nprimo, sizeof nprimo, addr numCaracteres, NULL
    mov eax, 0
    jmp nOperacao
;endrotulo

;rotulo (PERGUNTA SE O USUÁRIO QUER REALIZAR UMA NOVA OPERAÇÃO)
nOperacao:
    invoke WriteConsole, outputHandle, addr novaOperacao, sizeof novaOperacao, addr numCaracteres, NULL
    invoke ReadConsole, inputHandle, addr inputString, sizeof inputString, addr numCaracteres, NULL
    call arrumaEntrada
    cmp eax, 1
    JE inicio
    jmp encerra
;endrotulo

end start









