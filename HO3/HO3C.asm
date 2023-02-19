TITLE Calculate how old you are	    (HO3C.asm)

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

.code
main	    PROC
    
	    mov	    edx, OFFSET	yearMsg
	    call    WriteString

	    call    ReadDec
	    mov	    year, EAX

	    mov	    EAX, year
	    cmp	    EAX, curYear		    ; IF year < curYear
	    je	    IF_CURRENT_YEAR		    ; THEN

	    jg	    PERSON_HAS_NOT_BEEN_BORN_YET    ; IF year > curYear
	    jmp	    IF_ONE			    ; ELSE

IF_ONE:
	    call    subYearFromCurYear
	    mov	    edx, OFFSET monthMsg
	    call    WriteString

	    call    ReadDec
	    mov	    month, eax

	    cmp	    eax, curMonth
    
	    jg	    MONTH_GREATER_THAN_CURRENT_MONTH

	    jl	    MONTH_LESS_THAN_CURRENT_MONTH
    
	    jmp	    INNER_ELSE_3
	    jmp	    _ENDIF			    ; ENDIF

MONTH_GREATER_THAN_CURRENT_MONTH: 
	    mov	    edx, OFFSET youAreMsg
	    call    WriteString
    
	    call    decrementAge
	    call    WriteDec

	    mov	    edx, OFFSET yearsOldMsg
	    call    WriteString
	    jmp	    _ENDIF			    ; ENDIF
    
MONTH_LESS_THAN_CURRENT_MONTH:
	    mov	    edx, OFFSET youAreMsg
	    call    WriteString
    
	    mov	    eax, age
	    call    WriteDec

	    mov	    edx, OFFSET yearsOldMsg
	    call    WriteString

	    jmp	    _ENDIF			    ; ENDIF

INNER_ELSE_3:
	    ; this is a hard jump
	    mov	    edx, OFFSET dayMsg
	    call    WriteString

	    call    ReadDec
	    mov	    day, EAX

	    ;;eax=day
	    cmp	    eax, curDay
	    jg	    DAY_IS_GREATER_THAN_CURRENT_DAY ; IF day < curDay
	    jl	    INNER_ELSE_4		    ; IF day > curDay
	    je	    IS_BIRTHDAY_TODAY		    ; THEN
    

DAY_IS_GREATER_THAN_CURRENT_DAY:
	    call    decrementAge

	    mov	    edx, OFFSET youAreMsg
	    call    WriteString
    
	    mov	    eax, age
	    call    WriteDec

	    mov	    edx, OFFSET yearsOldMsg	    ; Print "you are "; age ; " years old "
	    call    WriteString

	    jmp	    _ENDIF			    ; ENDIF

INNER_ELSE_4:
	    mov	    edx, OFFSET youAreMsg
	    call    WriteString
    
	    mov	    eax, age
	    call    WriteDec

	    mov	    edx, OFFSET yearsOldMsg	    ; Print "you are "; age ; " years old "
	    call    WriteString

	    jmp	    _ENDIF			    ; ENDIF
    

IF_CURRENT_YEAR:
	    mov	    edx, OFFSET lessThanOne
	    call    WriteString
	    jmp	    _ENDIF

IS_BIRTHDAY_TODAY:
	    mov	    edx, OFFSET	youAreMsg
	    call    WriteString

	    mov	    EAX, age
	    call    WriteDec

	    mov	    edx, OFFSET	yearsOldMsg	    ; Print "you are "; age ; " years old "
	    call    WriteString

	    mov	    edx, OFFSET	birthday
	    call    WriteString			   ; "you are "; age ;" years old, Happy Birthday"

	    jmp	    _ENDIF			   ; ENDIF

PERSON_HAS_NOT_BEEN_BORN_YET:
	    mov	    edx, OFFSET notBornYet
	    call    WriteString
	    jmp	    _ENDIF			   ; ENDIF

_ENDIF:	    call    CRLF
    

invoke  ExitProcess,0 ; stop
main	    ENDP

decrementAge	    PROC
		    mov	    eax, age		    ; age=age-1
		    sub	    eax, 1
		    mov	    age, eax
		    ret
decrementAge	    ENDP


incrementAge	    PROC
		    mov	    eax, age		    ; age=age+1
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