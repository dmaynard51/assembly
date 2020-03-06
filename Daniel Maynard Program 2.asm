; Name: Daniel Maynard
; Date: 10/15/17
; Email: maynarda@oregonstate.edu
; Project ID: 932-701-800
; Description: This program will first ask for the user's name and then a number of fibonacci numbers to output
;after each number, it will output 5 numbers per line.


INCLUDE Irvine32.inc


MAX EQU 46
MIN EQU 1

.data


programTitle BYTE "Fibonacci Numbers", 0
author BYTE "Programmed by Daniel Maynard", 0
requestName BYTE "What's your name?", 0
helloName BYTE "Hello, ", 0
requestQuantity BYTE "Enter the number of Fibonacci terms to be displayed", 0
requestNumbers BYTE "Give the number as an integer in the range [1 .. 46].", 0
errorOutput BYTE "Out of range. Enter a number in [1 .. 46]", 0
goodBye1 BYTE "Results certified by Daniel Maynard.", 0
goodBye2 BYTE "GoodBye, ", 0


inputName BYTE 30 DUP (0)
inputQuantity DWORD ?
previousInt DWORD ?
currentInt DWORD ?
lineCount DWORD ?
space BYTE " ", 0
count DWORD ?

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
call CrLf


mov edx, OFFSET inputName ; name to be inputted
mov ecx, 30 ; holds the size of the name
call readString
call CrLf
mov edx, OFFSET helloName ;says hello,
call WriteString
mov edx, OFFSET inputName ; name user inputted
call WriteString
call CrLf

;getUserData
QUANTITY:
; request the number of numbers fibonacci numbers to be displayed
mov edx, OFFSET requestQuantity ;request string
call WriteString
call CrLf

call readInt ; takes an int from user
mov inputQuantity, eax ; assigns int to inputQuantity variable
mov eax, 0

;input validation 1-46
mov eax, inputQuantity
cmp eax, MIN
jl error ;if statement above is lower than min move to error
cmp eax, MAX
jg error ;if statement above is greater than max move to error
mov currentInt, eax
jmp FIBNUMBER ;if between 1-46 move to input fib number

ERROR:
mov edx, OFFSET errorOutput ; display input error
call WriteString
call CrLf
jmp QUANTITY


SKIPLINE:
call CrLf
mov lineCount, 0
jmp CHECKQUANTITY


;displayFibs
FIBNUMBER:


mov ebx, 0
mov previousInt, ebx
mov eax, 1
mov currentInt, eax
call WriteDec ;writes 1
cmp inputQuantity, 2 ;checks if user inputted 1
jl GOODBYE
mov ecx, 1
mov count, ecx
mov ecx, 1
mov lineCount, ecx


mov edx, OFFSET space
call WriteString


PRINT:
; print 5 numbers per line

mov eax, currentInt
mov ebx, previousInt

add eax, ebx ;adds previous to current
call WriteDec
mov ebx, currentInt ;ebx should now hold previous
mov currentInt, eax ;  current should now be eax + ebx
mov previousInt, ebx

mov edx, OFFSET space
call WriteString
inc count
inc lineCount

mov ecx, lineCount
cmp ecx, 4
jg SKIPLINE

CHECKQUANTITY:
mov ecx, count
cmp ecx, inputQuantity ;checks if currentInt is > inputQuantity
jg GOODBYE
cmp ecx, inputQuantity
jl PRINT



GOODBYE:
mov edx, OFFSET goodBye1
call WriteString
call CrLf
mov edx, OFFSET goodBye2
call WriteString
mov edx, OFFSET inputName
call WriteString
call CrLf


exit
main ENDP
end main