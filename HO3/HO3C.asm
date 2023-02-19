TITLE Calculate how old you are	    (HO3B.asm)

; Author: Sutinder S. Saini
; Date: 2/17/23



INCLUDE Irvine32.inc

.data
curYear	    DWORD   2023
curMonth    DWORD   2
curDay	    DWORD   18

yearMsg	    BYTE    "Enter the year of your birth: ", 0
monthMsg    BYTE    "Enter the month of your birth: ", 0
dayMsg	    BYTE    "Enter the day of your birth: ", 0


youAreMsg   BYTE    "You are ", 0
yearsOldMsg BYTE    " years old.", 0

lessThanOne BYTE    "you are less than 1 year old.", 0
birthday    BYTE    " Happy birthday!", 0

notBornYet  BYTE    "you haven't been born yet.", 0

year	    DWORD   ?
month	    DWORD   ?
day	    DWORD   ?
age	    DWORD   ?

; Start 
; curYear = 2019 
; curMonth = 10 
; curDay = 20 
; Print "Enter the year of your birth: " 
; Input year 
; IF year = curYear THEN 
;   Print "you are less than 1 year old" 
; ELSE 
;   IF year < curYear THEN
;     Print "Enter the month of your birth: " ++++
;     Input month 
;     age = curYear - year 
;     IF month > curMonth THEN  
;       age = age - 1 
;       Print "you are "; age; " years old" 
;     ELSE
;       IF month < curMonth THEN 
;         Print "you are "; age; " years old" 
;       ELSE 
;         Print "Enter day of your birth: "
;         Input day 
;         IF day > curDay THEN 
;           age = age - 1 
;           Print "you are "; age; " years old" 
;         ELSE 
;           IF day < curDay THEN 
;             Print "you are "; age; " years old" 
;           ELSE 
;             Print "you are "; age; " years old, Happy Birthday" 
;           ENDIF 
;         ENDIF 
;       ENDIF 
;     ENDIF 
;   ELSE 
;     Print "you haven't been born year" 
;   ENDIF 
; ENDIF 
; Stop 

.code
main	    PROC
    
    mov	    edx, OFFSET	yearMsg
    call    WriteString

    call    ReadDec
    mov	    year, EAX

    mov	    EAX, year
    cmp	    EAX, curYear
    je	    IF_CURRENT_YEAR

    jg	    PERSON_HAS_NOT_BEEN_BORN_YET

    jmp	    IF_ONE

IF_ONE:
    call subYearFromCurYear
    mov edx, OFFSET monthMsg
    call WriteString

    call ReadDec
    mov  month, eax

    cmp eax, curMonth
    
    jg  MONTH_GREATER_THAN_CURRENT_MONTH		;; is x less than y ?

    jl	MONTH_LESS_THAN_CURRENT_MONTH		        ;; is y less than x ?
    
    jmp	INNER_ELSE_3					;; more clarification needed
    ret

MONTH_GREATER_THAN_CURRENT_MONTH: 
    mov	    edx, OFFSET youAreMsg
    call    WriteString
    
    call    decrementAge
    call    WriteDec

    mov	    edx, OFFSET yearsOldMsg
    call    WriteString
    
MONTH_LESS_THAN_CURRENT_MONTH:
    mov	    edx, OFFSET youAreMsg
    call    WriteString
    
    mov	    eax, age
    call    WriteDec

    mov	    edx, OFFSET yearsOldMsg
    call    WriteString

    ret

INNER_ELSE_3:
    ; this is a hard jump
    mov	    edx, OFFSET dayMsg
    call    WriteString

    call    ReadDec
    mov	    day, EAX

    ;;eax=day
    cmp	    eax, curDay
    jg	    DAY_IS_GREATER_THAN_CURRENT_DAY ; day>curDay
    jl	    INNER_ELSE_4		    ; day<curDay
    je	    IS_BIRTHDAY_TODAY
    

DAY_IS_GREATER_THAN_CURRENT_DAY:
    call    decrementAge

    mov	    edx, OFFSET youAreMsg
    call    WriteString
    
    mov	    eax, age
    call    WriteDec

    mov	    edx, OFFSET yearsOldMsg
    call    WriteString

    ret

INNER_ELSE_4:
    mov	    edx, OFFSET youAreMsg
    call    WriteString
    
    mov	    eax, age
    call    WriteDec

    mov	    edx, OFFSET yearsOldMsg
    call    WriteString

    ret
    

IF_CURRENT_YEAR:
    mov	    edx, OFFSET lessThanOne
    call    WriteString
    ret

IS_BIRTHDAY_TODAY:
    mov	    edx, OFFSET	youAreMsg
    call    WriteString

    mov	    EAX, age
    call    WriteDec

    mov	    edx, OFFSET	yearsOldMsg
    call    WriteString

    mov	    edx, OFFSET	birthday
    call    WriteString

    ret

PERSON_HAS_NOT_BEEN_BORN_YET:
    mov	    edx, OFFSET notBornYet
    call    WriteString
    ret
    

invoke  ExitProcess,0 ; stop
main	    ENDP

decrementAge	    PROC
    mov	    eax, age
    sub	    eax, 1
    mov	    age, eax
    ret
decrementAge	    ENDP

incrementAge	    PROC
    mov	    eax, age
    sub	    eax, 1
    mov	    age, eax
    ret
incrementAge	    ENDP

subYearFromCurYear  PROC
    ;age=curYear-year
    mov	    eax, curYear
    sub	    eax, year
    mov	    age, eax
    ret
subYearFromCurYear ENDP

END main