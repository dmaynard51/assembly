; Name: Daniel Maynard
; Date: 11/5/17
; Email: maynarda@oregonstate.edu
; Project ID: 932-701-800
; Description: This program will take an input from the user and validate it (1-400)
;it will then print out the composite numbers for the quantity of numbers the user entered
;making sure that only 10 numbers per line are printed


INCLUDE Irvine32.inc


MAX EQU 100
MIN EQU 1

.data


programTitle BYTE "Composite Numbers Programmed by Daniel", 0
enterNumbers BYTE "Enter the number of composite numbers you would like to see.", 0
requestName BYTE "What's your name? ", 0
helloName BYTE "Hello, ", 0
addSpace BYTE " ", 0


requestNumbers BYTE "Enter the number of composites to display [1 .. 400]: ", 0
errorOutput BYTE "Out of range. Try again. ", 0
errorOutput2 BYTE " valid numbers.", 0
goodBye1 BYTE "Results certified by Daniel. Goodbye. ", 0
goodBye2 BYTE ". ", 0
readSum BYTE "The sum of your valid numbers is ", 0
readAve BYTE "The rounded average is ", 0


userEntry DWORD ?

count DWORD 3
compositeNumber DWORD ?
oldComposite DWORD ?
numberCount DWORD ?
spaces DWORD ?
lines DWORD ?



.code

main PROC

	call introduction
	call getUserData
	call showComposites
	call farewell


main ENDP



;introduction

introduction PROC

mov edx, OFFSET programTitle
call WriteString
call CrLf
call CrLf
mov edx, OFFSET enterNumbers
call WriteString
call CrLf
ret
introduction ENDP





;getUserData


getUserData PROC
GETDATA:


mov edx, OFFSET requestNumbers ;request string
call WriteString
call readInt ; takes an int from user
mov userEntry, eax ; assigns int to userEntry variable
mov eax, 0

call dataValidation


valid:
cmp eax, 0
je GETDATA
ret

getUserData ENDP




;input validation (-1) - (-100)
dataValidation PROC

mov eax, userEntry
cmp eax, MIN
jl error ;if statement above is lower than min move to error
cmp eax, MAX
jg error ;if statement above is greater than max move to error
ret ;if between 1-400 move to input

ERROR:
mov edx, OFFSET errorOutput ; display input error
call WriteString
mov eax, 0
call CrLf




exitDataValidation:
ret

dataValidation ENDP




;showComposites

showComposites PROC
;start at 4
;print 4

mov eax, 4
mov compositeNumber, eax ;set count equal to 4
mov numberCount, 1
mov ecx, userEntry ;ecx will hold the user entry
call WriteDec
cmp ecx, 1 ;if user entry is 1 then end function
JE ENDSHOWCOMPOSITES

mov ecx, numberCount ;ecx will hold the number count
mov ebx, 2
inc compositeNumber
inc spaces
mov edx, OFFSET addSpace
call WriteString


OUTERLOOP:
;outer loop starts
;increase counter


call checkComposite


;print current counter
jmp PRINT




moveDownLine:
call CrLf
mov spaces, 0
jmp PRINT






;print out numbers
PRINT:
mov eax, spaces
cmp eax, 10
je moveDownLine

mov eax, compositeNumber
call WriteDec
inc compositeNumber

mov edx, OFFSET addSpace
call WriteString

inc spaces
inc numberCount ;increases current number count
mov eax, numberCount
mov ecx, userEntry
cmp ecx, eax
je ENDSHOWCOMPOSITES
jmp OUTERLOOP


ENDSHOWCOMPOSITES:
ret

showComposites ENDP



checkComposite PROC

mov ebx, 2
mov eax, compositeNumber


check:
cmp ebx, eax ;if these equal each other we need to increase the the composite number
je increaseUpper


cdq
div ebx
cmp edx, 0
je done 
jne increaseLower; if 0 is not equal need to increase the denominator



increaseUpper:
inc compositeNumber
mov eax, compositeNumber
mov ebx, 2
jmp check

increaseLower:
mov eax, compositeNumber
inc ebx
jmp check


done:
ret




checkComposite ENDP




farewell PROC

mov edx, OFFSET goodbye1
call WriteString
call CrLf

farewell ENDP




exit
end main