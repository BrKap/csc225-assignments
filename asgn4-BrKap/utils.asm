; Implements integer I/O utilities
; CSC 225, Assignment 4
; Given code, Winter '24

        .ORIG x5000     ; NOTE: Do not alter these addresses. They are
        .FILL GETI      ;       hardcoded within "calculator.asm", since the
        .FILL OUTI      ;       assembler cannot resolve cross-file labels.

; Reads one integer in the range {-9, ..., 9}.
;  Takes no arguments.
;  Returns the read integer in R0.
;  This subroutine WILL NOT PRINT ANYTHING to the console, including the negative sign
;  Printing the negative or positive integer will be handled by OUTI
;  TODO: Implement this subroutine.
GETI
        ST R6 STRR6
        ST R3 STRR3
        ST R4 STRR4

        GETC                    ; Get Int (-9 to 9) or -
        LD R3, ASCII-
        ADD R4, R3, R0          ; Test if it is negative sign or not
        BRnp POS                ; If is negative

        GETC                    ; Get Num
        LD R3 ASCIINM           ; Load ASCII Num value
        ADD R0 R0 R3            ; Turn ASCII Num into Integer
        NOT R0 R0               ; Turn to negative int
        ADD R0 R0 #1            ; Turn to negative int


        LD R3 STRR3
        LD R4 STRR4
        LD R6 STRR6
        
        RET
   
        POS                     ; Else is positive
        LD R3 ASCIINM           ; Load ASCII Num value
        ADD R0 R0 R3            ; Turn ASCII Num into Integer

        LD R3 STRR3
        LD R4 STRR4
        LD R6 STRR6

        RET


; Prints one integer in the range {-9, ..., 9}.
;  Takes the integer in R0.
;  Returns no values.
;  TODO: Implement this subroutine.
OUTI
        ST R0 STRR0
        ST R3 STRR3
        ST R4 STRR4

        AND R4 R0 #-1            ; Copy R0 to R4         
        BRzp POS2                ; If Negative
        LD R0 ASCII-2           ; Load negative sign ASCII
        OUT                     ; Output negative sign
        ADD R4 R4 #-1
        NOT R0 R4


        POS2                    ; Then
        LD R3 ASCIIN
        ADD R0 R3 R0            ; Turn integer into ASCII

        OUT                     ; Output ASCII num 

        LD R3 STRR3
        LD R4 STRR4
        LD R0 STRR0

        RET                     ; Return



ASCII-  .FILL x-2D
ASCII-2 .FILL x2D
ASCIINM .FILL x-30
ASCIIN  .FILL x30
STRR6   .FILL x0
STRR3   .FILL x0
STRR4   .FILL x0
STRR0   .Fill x0

        .END
