; Supports interrupt-driven keyboard input
; CSC 225, Assignment 5
; Given code, Winter '24

        .ORIG x500

; Reads one character, executing a second program while waiting for input:
;  0. Save state of Program 1
;  1. Saves the keyboard entry in the IVT.
;  2. Sets the keyboard entry in the IVT to ISR180.
;  3. Enables keyboard interrupts.
;  4. Returns to the second program.
;  5. Load state of Program 2
TRAP26                  ; TODO: Implement this service routine.

        ST R1 P1R1      ; Store Registers
        ST R2 P1R2
        ST R3 P1R3
        ST R4 P1R4
        ST R5 P1R5
        ST R7 P1R7
        LDR R0 R6 #0    ; Load PC into R0
        ST R0 P1PC      ; Store PC
        LDR R0 R6 #1    ; Load PSR into R0
        ST R0 P1PSR     ; Store PSR

        LDI R0 KBIV     ; Load value of KBIV
        ST R0 SAVEIV    ; Store into SAVEIV

        LD R1 KBIV      ; Load Address of KBIV
        LEA R0 ISR180   ; Load Address of ISR180
        STR R0 R1 #0    ; Store Address of ISR180 at address of KBIV
        
        LD R0 KBIMASK   ; Load KBIMASK
        LD R1 KBSR      ; Load Address of KBSR
        STR R0 R1 #0    ; Store new KBSR at address of KBSR


        LD R1 P2PC      ; Load P2PC into R1
        STR R1 R6 #0    ; Store P2PC at R6
        LD R1 P2PSR     ; Load P2PSR
        STR R1 R6 #1    ; Store P2PSR at R6 with offset of 1

        LD R0 P2R0
        LD R1 P2R1      ; Load P2 Registers
        LD R2 P2R2
        LD R3 P2R3
        LD R4 P2R4
        LD R5 P2R5
        LD R7 P2R7


        RTI             ; Return from Trap

; Responds to a keyboard interrupt:
;  0. Save state of Program 2
;  1. Disables keyboard interrupts.
;  2. Restores the original keyboard entry in the IVT.
;  3. Places the typed character in R0.
;  4. Returns to the caller of TRAP26.
;  5. Load state of Program 1
ISR180                  ; TODO: Implement this service routine.

        ST R0 P2R0
        ST R1 P2R1
        ST R2 P2R2
        ST R3 P2R3
        ST R4 P2R4
        ST R5 P2R5
        ST R7 P2R7
        LDR R0 R6 #0
        ST R0 P2PC
        LDR R0 R6 #1
        ST R0 P2PSR
        
        LDI R1 KBSR
        AND R1 R1 #0
        STI R1 KBSR
        
        LD R0 SAVEIV
        STI R0 KBIV
        
        LDI R0 KBDR


        LD R1 P1PC
        STR R1 R6 #0
        LD R1 P1PSR
        STR R1 R6 #1

        LD R1 P1R1
        LD R2 P1R2
        LD R3 P1R3
        LD R4 P1R4
        LD R5 P1R5
        LD R7 P1R7

        RTI


; Program 1's data:
P1R1    .FILL x0000     ; TODO: Use these memory locations to save and restore
P1R2    .FILL x0000     ;       the first program's state.
P1R3    .FILL x0000
P1R4    .FILL x0000
P1R5    .FILL x0000
P1R7    .FILL x0000
P1PC    .FILL x0000
P1PSR   .FILL x0000

; Program 2's data:
P2R0    .FILL x0000     ; TODO: Use these memory locations to save and restore
P2R1    .FILL x0000     ;       the second program's state.
P2R2    .FILL x0000
P2R3    .FILL x0000
P2R4    .FILL x0000
P2R5    .FILL x0000
P2R7    .FILL x0000
P2PC    .FILL x4000     ; Initially, Program 2's PC is 0x4000.
P2PSR   .FILL x8002     ; Initially, Program 2 is unprivileged.

; Shared data:
SAVEIV  .FILL x0000     ; TODO: Use this memory location to save and restore
                        ;       the keyboard's IVT entry.

; Shared constants:
KBIV    .FILL x0180     ; The keyboard's interrupt vector
KBSR    .FILL xFE00     ; The Keyboard Status Register
KBDR    .FILL xFE02     ; The Keyboard Data Register
KBIMASK .FILL x4000     ; The keyboard interrupt bit's mask

        .END
