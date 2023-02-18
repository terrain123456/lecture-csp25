TITLE Smallest Number	    (HO3A.asm)

; Author: Sutinder S. Saini
; Date: 2/17/23

INCLUDE Irvine32.inc

.data
num1		BYTE	?
num2		BYTE	?
num1Msg		BYTE	"Enter first number: ", 0
num2Msg		BYTE	"Enter second number: ", 0
SmallMsg	BYTE	"Smaller = ", 0

; Start 
; Print "Enter first number: " 
; Input num1 
; Print "Enter second number: " 
; Input num2 
; IF num1 < num2 
;   Print "Smaller = ", num1 
; ELSE 
;   Print "Smaller = ", num2 
; ENDIF 
; Stop 

.code
main	    PROC 
    ; start                     
    mov	    edx, OFFSET num1Msg ; "Print "Enter first number""
    call    WriteString         ;

    call    ReadDec             ; Input num1
    mov	    num1, AL            ;


    mov	    edx, OFFSET num2Msg ; "Print "Enter second number: " "
    call    WriteString         ;

    call    ReadDec
    mov	    num2, AL		; Input num2



    mov	    AL, num1		; IF num1 > num2
    cmp	    AL, num2
    jng	    ELSE_LABEL

    mov	    edx, OFFSET SmallMsg ; Smallest = 
    call    WriteString
    mov	    AL, num2
    call    WriteDec

    ret				; so we continue no further, since no jmp was made

ELSE_LABEL:
    mov	    edx, OFFSET SmallMsg ; Smallest = 
    call    WriteString
    mov	    AL, num1
    call    WriteDec

    invoke  ExitProcess,0 ; stop

main	    ENDP
END main