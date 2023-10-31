;Author: Gabrielius Gintalas
;Date: 08/30/23
;File Function: Assembly code to calculate total average speed and total time 
;Program name: Assignment 01 - Las Vegas

section .data
    ;Initialized data
    enterSpeed db "Please enter the speed for the initial segment of the trip (mph): ", 10, 0
    howMiles db "For how many miles will you maintain this average speed?", 10, 0
    finalSpeed db "What will be your speed during the final segment of the trip (mph)? ", 10, 0
    averageSpeed db "Your average speed will be ", 0
    totalTime db "The total travel time will be ", 0

    miles db " mph.", 10, 0                 ;This will be used to print the mph at the end of the string
    hours db " hours.", 10, 0               ;This will be used to print hours at the end of the string

    totalDistance dq 253.5                  ;This will used to reference total speed
    floatFormat db "%lf", 0                 ;This will be used to create a newline for user input
    
    ;Error message data
    invalidInput db "An invalid speed was entered. Please run the program again and enter correct data.", 10, 0
    space db "", 10 ,0
    avgSpeedNotCalculated db "Your average speed was not calculated.", 10, 0
    totalTimeNotCaculated db "The total travel time was not calculated.", 10, 0

section .bss
    ;Uninitialized data
    extern printf, scanf                    ;Get the data to be able to print and scan
    global lasvegas                         ;Make the function global so it can be accessed

    ;User input
    firstSpeed resq 1                       ;Initial speed float
    firstMiles resq 1                       ;How many miles initially?
    secondSpeed resq 1                      ;What will the speed be during the final portion of the trip

    ;First time - Distance / Speed
    firstTime resq 1                        ;This is how long the first part of the trip took 

    ;Second Distance - Total distance - first distance
    secondMiles resq 1                   ;This will be used to calculate the second distance of the trip
    secondTime resq 1                       ;This will used to calculate how long the first part of the trip is 
    totalAvgSpeed resq 1                    ;Total average speed var
    finalTime resq 1                        ;Total travel times var

section .text
    ;Code execution here
    showError:
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        mov rdi, invalidInput               ;Prepare string for print
        call printf                         ;Print invalidInput string
        pop rax                             ;Pop rax since we don't need it anymore

        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        mov rdi, space                      ;Prepare string for print
        call printf                         ;Print space string
        pop rax                             ;Pop rax since we don't need it anymore

        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        mov rdi, avgSpeedNotCalculated      ;Prepare string for print
        call printf                         ;Print avgSpeedNotCalculated string
        pop rax                             ;Pop rax since we don't need it anymore
        
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        mov rdi, totalTimeNotCaculated      ;Prepare string for print
        call printf                         ;Print totalTimeNotCalculated string
        pop rax                             ;Pop rax since we don't need it anymore

        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        mov rdi, space                      ;Prepare string for print
        call printf                         ;Print space string
        pop rax                             ;Pop rax since we don't need it anymore

        movsd xmm0, qword [totalDistance]   ;Set xmm0 to print the totalDistance as the last thing
        ret                                 ;Return this assembly function so it doesn't do anything else

    lasvegas:
        ;output "enter speed"
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        mov rdi, enterSpeed                 ;Load the message string into rdi.
        call printf                         ;Print enterSpeed string
        pop rax                             ;Re-align the stack after returning from printf.

        ;input initial speed
        mov rdi, floatFormat                ;Set rdi so we can input a double-float
        mov rsi, firstSpeed                 ;Get the address of firstSpeed
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        call scanf                          ;Get user input
        pop rax                             ;Pop rax since we don't need it anymore
        movsd xmm8, qword [firstSpeed]      ;Moving the data of firstSpeed into the register

        ;check to see if the input was valid
        xorpd xmm13, xmm13                  ;Clean xmm13
        ucomisd xmm8, xmm13                 ;Check if xmm8 >= 0
        jbe showError                       ;jump to showError

        ;output "how many miles?"
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        mov rdi, howMiles                   ;Set the string to rdi
        call printf                         ;Print the howMiles String
        pop rax                             ;Pop rax since we don't need it anymore

        ;input miles
        mov rdi, floatFormat                ;Set rdi so we can input a double-float
        mov rsi, firstMiles                 ;Prepare the variable for the data
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        call scanf                          ;Get user input
        pop rax                             ;Pop rax since we don't need it anymore
        movsd xmm9, qword [firstMiles]      ;Moving date from firstMiles into the register

        ;check to see if firstMiles input was valid
        xorpd xmm13, xmm13                  ;Clean xmm13
        ucomisd xmm9, xmm13                 ;Check if xmm9 <= 0
        jbe showError                       ;Jump to showError

        ;check to see if firstMiles input was valid
        movsd xmm13, qword[totalDistance]   ;Set xmm13 to 253.5
        ucomisd xmm13, xmm9                 ;Check if xmm9 >= 253.5
        jbe showError                       ;Jump to showError

        ;ouput "speed during second part of the trip"
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        mov rdi, finalSpeed                 ;Getting the string ready to print
        call printf                         ;Print the string
        pop rax                             ;Pop rax since we don't need it anymore

        ;input second speed 
        mov rdi, floatFormat                ;Set rdi so we can input a double-float
        mov rsi, secondSpeed                ;Prepare the variable for the data
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        call scanf                          ;Get user input
        pop rax                             ;Pop rax since we don't need it anymore
        movsd xmm10, qword [secondSpeed]    ;Moving date from secondSpeed into the register

        ;check if input for secondSpeed was valid
        xorpd xmm13, xmm13                  ;Clean xmm13
        ucomisd xmm10, xmm13                ;Compare if xmm10 is < 0
        jbe showError                       ;Jump to showError if thats the case

        ;Calculate average speed
        ;Distance / Speed = Time - do this twice for both speeds
        ;Calculate first average
        divsd xmm9, xmm8                    ;Divide these two registers to get the first time xmm9 = distance, xmm8 = speed
        movsd qword [firstTime], xmm9       ;Moving the xmm9 value into firstTime

        ;Calculate second average
        movsd xmm11, [totalDistance]        ;Move the totalDistance value into xmm11
        movsd xmm12, qword [firstMiles]     ;Move the firstMiles value into xmm12
        subsd xmm11, xmm12                  ;Subtract totalDistance - firstMiles to get secondMiles
        movsd qword [secondMiles], xmm11 ;Move xmm11 data into the secondMiles
        
        divsd xmm11, xmm10                  ;Divide these two registers to get the first time xmm11 = distance, xmm10 = speed
        movsd qword [secondTime], xmm11     ;Moving the xmm11 value into secondTime

        ;Average = Total Distance / Total Time
        ;Calculate total average
        movsd xmm8, qword [firstSpeed]      ;Store xmm8 into the first speed
        movsd xmm9, qword [firstTime]       ;Store xmm9 into the first time
        movsd xmm10, qword [secondSpeed]    ;Store xmm10 into the first time
        movsd xmm11, qword [secondTime]     ;Store xmm11 into the first time

        ;Total Time
        addsd xmm9, xmm11                   ;Adding the two times together, xmm9 = firstTime, xmm11 = secondTime
        movsd qword [finalTime], xmm9       ;Moving xmm9 value into the finalTime

        ;Total Average
        movsd xmm12, [totalDistance]        ;Moving totalDistance value into xmm12
        divsd xmm12, xmm9                   ;Divide these two registers to get total average speed xmm12 = totalDistance, xmm9 = finalTime
        movsd qword [totalAvgSpeed], xmm12  ;Move the xmm12 value, to get the totalAvgSpeed

        ;Output your average speed string
        mov rdi, averageSpeed               ;Getting ready to print the average speed string
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack
        call printf                         ;Print the averageSpeed string
        pop rax                             ;Pop rax since we don't need it anymore

        ;Output average speed value
        mov rdi, floatFormat                ;Getting ready to output a double-float value
        movsd xmm0, qword [totalAvgSpeed]   ;Moving the total average speed value into xmm0 since it is the one that prints
        mov qword rax, 1                    ;Getting the rax ready for push, but we are allocating more memory for the double-float
        push rax                            ;Pushing rax to stack                            
        call printf                         ;Print totalAvgSpeed value
        pop rax                             ;Pop rax since we don't need it anymore

        ;Output mph string
        mov qword rax, 0                    ;Getting the rax ready for push
        mov rdi, miles                      ;Getting ready to output the string
        push rax                            ;Getting the rax ready for push
        call printf                         ;Print mph string
        pop rax                             ;Pop rax since we don't need it anymore

        ;output "Your total time"
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack  
        mov rdi, totalTime                  ;Getting ready to output the string
        call printf                         ;Print totalTime string
        pop rax                             ;Pop rax since we don't need it anymore

        ;Output finalTime
        mov rdi, floatFormat                ;Getting ready to output a double-float value
        movsd xmm0, qword [finalTime]       ;Moving the total average speed value into xmm0 since it is the one that prints
        mov qword rax, 1                    ;Getting the rax ready for push, but we are allocating more memory for the double-float
        push rax                            ;Getting the rax ready for push
        call printf                         ;Print the double-float value
        pop rax                             ;Pop rax since we don't need it anymore

        ;Output hours string
        mov rdi, hours                      ;Preparing the string to be printed
        mov qword rax, 0                    ;Getting the rax ready for push
        push rax                            ;Pushing rax to stack                       
        call printf                         ;Print the string to attach to the end of the first string
        pop rax                             ;Pop rax since we don't need it anymore

        movsd xmm0, qword [finalTime] ;Get the final value of xmm0 to be the final time

        ret