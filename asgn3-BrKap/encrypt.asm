; Encrypts a string using a Caesar cipher.
; CSC 225, Assignment 3
; Given code, Winter '24

; TODO: Complete this program.

.ORIG x3000

        LEA R0, Key     ; Load address of Key String
        LEA R1 KeyS     ; Load into R1 the address where the encryption key is stored
        PUTS            ; Print
        
        NumStart
        GETC            ; Get Encryption Key
        LD R2 NumC      ; Load -48 into R2
        ADD R2 R0 R2    
        BRn NumStart    ; If the value is less than ASCII for 0, Loop to NumStart
        ADD R2 R2 #-10  
        BRp NumStart    ; If the value is greater than ASCII for 9, Loop to NumStart
        
        OUT             ; Output the Encryption Key into Console
        LD R2 NumC      
        ADD R0 R0 R2    ; Turn ASCII value of 0-9 to integer 0-9
        STR R0 R1 #0    ; Store Encryption Key
        
        EnterP
        GETC            ; Get Enter Key
        LD R3 BackS     ; Load ASCII for BackSpace
        ADD R3 R0 R3    ; Test if it's a BackSpace
        BRnp Skip1      ; If it is BackSpace, send back to NumStart
        OUT             ; BackSpace
        BRz NumStart    ; Go back to NumStart since BackSpace was pressed
        
        Skip1
        LD R3 Enter     ; Load Enter Value at R3
        ADD R3 R0 R3    ; If value is 0, it means enter was input
        BRnp EnterP     ; If Enter not pressed, run again
        OUT             ; Enter
        
        LEA R0, Input   ; Load address of Input string
        LEA R1 Store    ; Load into R1 the address where the characters get stored
        LD R2 Counter   ; Load the #32 into R2

        PUTS            ; Print
        
        LOOP            ; Start of Loop
        GETC            ; Get a character from user
        
        LD R3 Enter     ; Load the value of #-10
        ADD R3 R0 R3    ; Add the value of #-10 to character, if its 0 then that means the character was "Enter"
        BRz Exit        ; Exit the loop since we are done typing
        
        LD R3 BackS     
        ADD R3 R0 R3    ; Test if Backspace was pressed
        BRnp Skip2      ; If Backspace pressed, go back to beginning, increase counter by 1, decrease PC by 1
        LD R3 ICounter  ; Check if counter is at 32
        ADD R3 R2 R3    ; If counter is at 32, then no need to change counters or clear addresses
        BRp LOOP
        
        OUT             ; Output backspace
        AND R0 R0 #0    ; Clear R0
        STR R0 R1 #0    ; Clear Address value
        ADD R2 R2 #1    ; Increase counter by 1
        ADD R1 R1 #-1   ; Decrease PC of address value
        BRnzp LOOP
        
        Skip2
        OUT             ; Output the character that was just typed into Console
        LD R3 KeyS
        ADD R0 R0 R3    ; Encrypt
        
        LD R4 SpC1      ; Load -32 into R4
        ADD R3 R0 R4    ; Check if its 32 or below
        BRn QstS       
        LD R4 SpC2      ; Else Load -95 into R4
        ADD R3 R3 R4    ; Check if its 95 or more
        BRn Skip3
        QstS
        LD R0 Qstion    ; If special character load ? char
        STR R0 R1 #0    ; Store ? char
        BRnzp Skip4
        
        Skip3
        STR R0 R1 #0    ; Store character at Store Address + Counter offset
        
        Skip4
        ADD R1 R1 #1    ; Increase the PC for the address of Store
        ADD R2 R2 #-1   ; Decrease the counter for amount of characters left to type
        BRnp LOOP       ; Loop if counter isn't at 0
        
        EnterP2
        GETC            ; Get Enter Key
        LD R3 Enter     ; Load Enter Value at R3
        ADD R3 R0 R3    ; If value is 0, it means enter was input
        BRnp EnterP2     ; If Enter not pressed, run again
        OUT
        
        Exit            ; Exit Loop here
        OUT             ; Output the character that was just typed into Console
        
        AND R0 R0 #0    ; Clear R0
        STR R0 R1 #0    ; Store R0 at the next Address

        LEA R0, Output  ; Load address of Output message
        PUTS            ; Print
        LEA R0, Store   ; Load the Store of characters address
        PUTS            ; Print
        
        HALT            ; Stop Running
        
Store   .BLKW #33       ; Store the 32 characters
KeyS    .BLKW #2        ; Store the Encryption Key
Key     .STRINGZ "Encryption key (0-9): "
Input   .STRINGZ "Unencrypted string: "
Output  .STRINGZ "Encrypted string: "
NumC    .FILL #-48
Counter .FILL #32
ICounter .FILL #-31
Enter   .Fill #-10
BackS   .Fill #-8
SpC1    .Fill #-32
SpC2    .Fill #-95
Qstion  .Fill #63

.END
