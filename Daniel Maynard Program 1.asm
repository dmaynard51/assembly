; Name: Daniel Maynard
; Date: 10/8/17
; Email: maynarda@oregonstate.edu
; Project ID: 932-701-800
; Description: This program takes two input integers from the user and does addition, subtraction, multiplation and division
INCLUDE Irvine32.inc

.data


daniel BYTE "Daniel Maynard - Programming Assignment #1  ", 0
instructions BYTE "Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.  ", 0
number1  BYTE "First number: ", 0
number2  BYTE "Second number: ", 0
addition BYTE " + ", 0
equals BYTE " = ", 0
subtract BYTE " - ", 0
multiply BYTE " x ", 0
divide BYTE " / ", 0
goodbye  BYTE "Impressed? Bye! ", 0
playAgain  BYTE "Do you want to play again? Press 1 if yes and 2 if no ", 0
playAgainInput DWORD ?
sumOutput  BYTE "The sum is: ", 0
diffOutput  BYTE "The difference is: ", 0
quotientOutput  BYTE "The quotient is: ", 0
remainderOutput  BYTE " remainder ", 0
input1 DWORD ? ;integer to be entered by user
input2 DWORD ? ;integer to be entered by user
sum DWORD ?
difference DWORD ?
multiplyOutput DWORD ?
quotient DWORD ?
remainder DWORD ?


.code
main PROC

INPUT:

;Get the name of student and program
mov edx, OFFSET daniel
call WriteString
call CrLf


;Get the two integers from the user
mov edx, OFFSET instructions
call WriteString
call CrLf

call readInt
mov input1, eax
mov eax, 0

call readInt
mov input2, eax
mov eax, 0


;show user input1
mov edx, OFFSET number1
call WriteString
mov eax, input1
call WriteDec
call CrLf

;show user input2
mov edx, OFFSET number1
call WriteString
mov eax, input2
call WriteDec
mov eax, 0
call CrLf

;calculate sum

mov ebx, input2
add ebx, input1
mov sum, ebx
mov ebx, 0

;calculate difference
mov ebx, input1
sub ebx, input2
mov difference, ebx
mov ebx, 0


;calculate multiplication
mov eax, input1
mov ebx, input2
mul ebx
mov multiplyOutput, eax
mov eax, 0
mov ebx, 0


;calculate quotient
mov eax, input1
cdq
mov ebx, input2
div ebx
mov quotient, eax 
mov remainder, edx 


;outputs the sum
mov eax, input1
call WriteDec

mov edx, OFFSET addition
call WriteString

mov eax, input2
call WriteDec

mov edx, OFFSET equals
call WriteString

mov eax, sum
call WriteDec
call CrLf


;ouputs the difference

mov eax, input1
call WriteDec

mov edx, OFFSET subtract
call WriteString

mov eax, input2
call WriteDec

mov edx, OFFSET equals
call WriteString

mov eax, difference
call WriteDec

call CrLf


;output multiplication
mov eax, input1
call WriteDec

mov edx, OFFSET multiply
call WriteString

mov eax, input2
call WriteDec

mov edx, OFFSET equals
call WriteString

mov eax, multiplyOutput
call WriteDec
call CrLf


;ouputs the quotient
mov eax, input1
call WriteDec

mov edx, OFFSET divide
call WriteString

mov eax, input2
call WriteDec

mov edx, OFFSET equals
call WriteString

mov eax, quotient
call WriteDec
mov edx, OFFSET remainderOutput
call WriteString

;ouputs the remainder
mov eax, remainder
call WriteDec
call CrLf

mov edx, OFFSET goodbye
call WriteString

call CrLf

;Check if the player wants to play again
mov edx, OFFSET playAgain
call WriteString
call CrLf
call ReadInt
mov playAgainInput, eax
mov eax, 1
cmp eax, playAgainInput
je INPUT



exit
main ENDP
end main