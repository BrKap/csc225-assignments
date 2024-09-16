; Performs stack-based arithmetic
; CSC 225, Assignment 4
; Given code, Winter '24

        .ORIG x3000

MAIN    LEA R1, STACK   ; Initialize R1, the stack pointer.
        
        JSR GETI
        HALT            ; Halt.


; Space for a stack with capacity 16:
        .BLKW #16
STACK   .FILL x00

; Shared constants:
PROMPT  .STRINGZ "Enter a command (#N/a/s/n/q): "
RESSTR  .STRINGZ "Value on top of the stack: "
ENDSTR  .STRINGZ "\n"
ASCIIA  .FILL x-61
ASCIIS  .FILL x-73
ASCIIN  .FILL x-6E
ASCIIQ  .FILL x-71

; NOTE: Do not alter the following lines. They allow the subroutines in other
;       files to be called without manually calculating their offsets.

PUSH    ST  R7, PSHR7
        ST  R5, PSHR5
        LDI R5, PSHADDR
        JSRR R5
        LD  R5, PSHR5
        LD  R7, PSHR7
        RET
PSHR5   .FILL x0000
PSHR7   .FILL x0000
PSHADDR .FILL x4000

POP     ST  R7, POPR7
        ST  R5, POPR5
        LDI R5, POPADDR
        JSRR R5
        LD  R5, POPR5
        LD  R7, POPR7
        RET
POPR5   .FILL x0000
POPR7   .FILL x0000
POPADDR .FILL x4001

GETI    ST  R7, GETR7
        ST  R5, GETR5
        LDI R5, GETADDR
        JSRR R5
        LD  R5, GETR5
        LD  R7, GETR7
        RET
GETR5   .FILL x0000
GETR7   .FILL x0000
GETADDR .FILL x5000

OUTI    ST  R7, OUTR7
        ST  R5, OUTR5
        LDI R5, OUTADDR
        JSRR R5
        LD  R5, OUTR5
        LD  R7, OUTR7
        RET
OUTR5   .FILL x0000
OUTR7   .FILL x0000
OUTADDR .FILL x5001

        .END
