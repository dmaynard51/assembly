; Name: Daniel Maynard
; Date: 10/29/17
; Email: maynarda@oregonstate.edu
; Project ID: 932-701-800
; Description: This program will first ask for the user's name and take numbers between -1 to -100
;it will then display the sum and average after a number is entered outside of -1 to -100


INCLUDE Irvine32.inc


MAX EQU -1
MIN EQU -100

.data


programTitle BYTE "Welcome to the Integer Accumulator by Daniel Maynard", 0
author BYTE "Programmed by Daniel Maynard", 0
requestName BYTE "What's your name? ", 0
helloName BYTE "Hello, ", 0
requestQuantity BYTE "Please enter numbers in [-100, -1]. ", 0
requestQuantity2 BYTE "Enter a non-negative number when you are finished to see results. ", 0
requestNumbers BYTE "Enter number: ", 0
errorOutput BYTE "You entered ", 0
errorOutput2 BYTE " valid numbers.", 0
goodBye1 BYTE "Thank you for playing Integer Accumulator! It's been a pleasure to meet you, ", 0
goodBye2 BYTE ". ", 0
readSum BYTE "The sum of your valid numbers is ", 0
readAve BYTE "The rounded average is ", 0

inputName BYTE 30 DUP (0)
inputQuantity DWORD ?


count DWORD ?

sumOfNumbers DWORD ?
validNumbers DWORD ?
averageNumber DWORD ?

.code
main PROC

;introduction
introduction:
mov edx, OFFSET programTitle
call WriteString
call CrLf

mov edx, OFFSET author
call WriteString
call CrLf
call CrLf

; request user name
mov edx, OFFSET requestName
call WriteString


mov edx, OFFSET inputName ; name to be inputted
mov ecx, 30 ; holds the size of the name
call readString

mov edx, OFFSET helloName ;says hello,
call WriteString
mov edx, OFFSET inputName ; name user inputted
call WriteString
call CrLf
call CrLf

;getUserData

; request the user to enter numbers between -1 and -100
mov edx, OFFSET requestQuantity ;request string
call WriteString
call CrLf
mov edx, OFFSET requestQuantity2 ;request string
call WriteString
call CrLf

;Will loop through taking valid numbers until the user enters a value not valid
QUANTITY:
mov edx, OFFSET requestNumbers ;request string
call WriteString
call readInt ; takes an int from user
mov inputQuantity, eax ; assigns int to inputQuantity variable
mov eax, 0

;input validation (-1) - (-100)
mov eax, inputQuantity
cmp eax, MIN
jl error ;if statement above is lower than min move to error
cmp eax, MAX
jg error ;if statement above is greater than max move to error

;adds the value to the sumOfNumbers, and increments the number count
mov eax, inputQuantity 
add eax, sumOfNumbers ;adds the new number to sum
mov sumOfNumbers, eax ;adds the new number to sum
add validNumbers, 1 ;increments the number count

jmp QUANTITY ;if between 1-46 move to input fib number

;if a number entered outside of -1 to -100, display current sum and average
ERROR:
mov edx, OFFSET errorOutput ; display input error
call WriteString
mov eax, validNumbers
call WriteDec
mov edx, OFFSET errorOutput2 ; display input error
call WriteString
call CrLf

;displays the sum
mov edx, OFFSET readSum 
call WriteString
mov eax, sumOfNumbers
call WriteInt
call CrLf



;display the average
mov edx, OFFSET readAve 
call WriteString

mov eax, sumOfNumbers
cdq
mov ebx, validNumbers
idiv ebx
mov averageNumber, ebx
call WriteInt
call CrLf








GOODBYE:
mov edx, OFFSET goodBye1
call WriteString
mov edx, OFFSET inputName
call WriteString
mov edx, OFFSET goodBye2
call WriteString

call CrLf


exit
main ENDP
end main