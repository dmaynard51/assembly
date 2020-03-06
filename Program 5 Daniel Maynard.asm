; Name: Daniel Maynard
; Date: 11/19/17
; Email: maynarda@oregonstate.edu
; Project ID: 932-701-800
; Description: This program will take an input from the user and validate it (10-200)
;it will then print out the random numbers between 100 and 999
;after random numbers are generated it will be sorted, but not printed. After sorted it will
;print out the median number, and than print out the sorted array. Also I used demo4 to
;start this project to get a better understanding of the stack frame.


INCLUDE Irvine32.inc

MAX = 200
MIN = 10
HI = 999
LO = 100

.data
totalCount	DWORD	?
sizeMinusOne		DWORD	?		;counter used for resort
sizeOfArray		DWORD	?		;counter used for inner loop

intro1	BYTE		"Sorting Random Integers Programmed by Daniel Maynard", 0
intro2	BYTE		"This program generates random numbers in the range [100 .. 999], ", 0
intro3	BYTE		"displays the original list, sorts the list, and calculates the median value. Finally, it displays the list sorted in descending order.", 0

rules1	BYTE		"How many numbers should be generated? [10 .. 200]:",0
rules2	BYTE		"the summation of integers from lower to upper.",0

requestData BYTE	"How many numbers should be generated?", 0
errorOutput BYTE			"Invalid input ", 0
unsortedString	BYTE	"The unsorted random numbers:", 0
medianString	BYTE	"The median is ", 0
randomArray		DWORD	MAX	DUP(?)
tempEAX 	DWORD	?
tempEBX DWORD ?
tempECX DWORD ?
fourBits DWORD 4
outerCount DWORD ?
innerCount DWORD ?
unsortedCount DWORD 0


.code
main PROC
	call	intro		;introduce the program
	push	OFFSET totalCount
	push	OFFSET requestData
	push	OFFSET errorOutput
	call	getData		;get values for a and b

	;create random number and add to array
	call	randomize
	push	OFFSET unsortedString	;pass sum by reference
	push	totalCount ;this is the user input
	push	OFFSET randomArray
	call	generateUnsorted ;create unsorted random numbers
	
	; print out unsorted array
	push OFFSET randomArray
	push	totalCount
	call	displayArray	;display the result

	;sort random integers
	push OFFSET randomArray
	push totalCount
	call sortArray

	;print median
	push	OFFSET medianString
	push	totalCount
	push	OFFSET randomArray
	call	showMedian
	
	; print out sorted array
	push OFFSET randomArray
	push	totalCount
	call	displayArray	;display the result
	
	exit				;exit to operating system
	main ENDP


	;display the introduction

intro	PROC
  ;Display instructions line 1
  	mov		edx,OFFSET intro1
	call	WriteString
	call	Crlf
	 mov		edx,OFFSET intro2
	call	WriteString
	call	Crlf
	mov		edx,OFFSET intro3
	call	WriteString
	call	Crlf
	mov		edx,OFFSET rules1
	call	WriteString
	call	Crlf
	call	Crlf
	ret
intro	ENDP


;retriever user input, and make sure its between 10 and 200

getData	PROC ;get data

	push	ebp
	mov		ebp, esp
	jmp userInput

	
invalid:
	mov edx, [ebp + 8]
	call	WriteString
	call	CrLf
	jmp		userInput

userInput:

	mov		edi, [ebp + 16] ;user input on the stack
	call	ReadInt
	cmp		eax, MAX
	jg		invalid ;if greater than max jump to invalid
	cmp		eax, MIN
	jl		invalid ; if less than min then jump to error
	mov		[edi], eax ; if between 10 to 200 ;
	pop		ebp
	ret		8


getData	ENDP


;create unsorted array

generateUnsorted	PROC
	push	ebp			;Set up stack frame
	mov		ebp,esp
	mov edx, [ebp + 12] ;user input
	mov esi, [ebp + 8] ;holds the array
	call Randomize
	mov ebx, unsortedCount ;will hold the array count of how many random integers to generate

	;get random numbers
	getRandom:
	cmp ebx, edx ;compares current count to userInput
	je doneUnsorted ;if count equals the userinput we're done
	mov eax, HI ;sets eax to hi
	sub eax, LO ; subtracts 10
	inc eax ; increases by 1
	call RandomRange ;calls randomrange on eax
	add eax, LO

	; add random number to array
	mov [esi], eax ;
	add esi, 4 ;moves to next array +4 in memory
	inc ebx
	loop getRandom

	;pushes stack back
	doneUnsorted:
	pop ebp
	ret 8

	
generateUnsorted	ENDP

;prints the current array of integers

displayArray	PROC
	push	ebp				;Set up stack frame
	mov		ebp,esp
	mov edi, [ebp + 12] ;holds the array
	mov ecx, [ebp + 8] ;holds the user input
	mov ebx, 0
	mov edx, 0


	addSpace:
	call CrLf
	jmp printLine


	printLine:

	inc ebx ;holds the space counter
	inc edx ; number counter

	mov eax, [edi] ;holds the integer
	call WriteDec ;writes the integer
	mov al, ' '
	call WriteChar ;space between each number
	add edi, 4 ; increase the address of the array
	cmp ebx, 10 ; checks the space counter

	cmp ecx, 0 ;if the counter gets to 0 then we're done
	je donePrinting 
	je addSpace
	loop printLine
	
	donePrinting:
	call CrLf
	call CrLf
	pop		ebp
	ret		8

displayArray	ENDP



sortArray	PROC
	push	ebp				;Set up stack frame
	mov		ebp,esp
	mov edi, [ebp + 12] ;holds the array first element
	mov outerCount, 0
	jmp setCounters

	
	outerLoop: ; increase lowest integer count

	inc outerCount
	mov ecx, outerCount
	cmp ecx, [ebp + 8]
	je done
	jmp setCounters

	;set counters
	setCounters:
	
	mov eax, outerCount ;holds smallest
	mov ebx, outerCount ;holds search element

	;check current counter to search counter and increase at each iteration
	innerLoop:
	mov innerCount, ebx
	inc innerCount ;increases the search counter
	mov ebx, innerCount
	;make sure first count is less than totalCount
	cmp ebx, [ebp + 8]
	je outerLoop
	;compare smallest to search counter
	mov edx, [4 * ebx + edi] ;move search counter to edx
	cmp edx, [4 * eax + edi] ;compare against first integer
	jg innerLoop ;if next counter is larger than increase search counter
	jmp pushAddresses
	;if eax is larger than ebx we need to swap them

	;push the smallest onto stack
	pushAddresses:
	pushad ; save registers onto stack
	mov edi, [ebp + 12]
	;mov eax, tempEax
	mul fourBits
	add edi, eax ; 4*eax + smallest int
	push edi ;push small integer to be switched to stack

	;push search element to stack
	mov eax, ebx
	mul fourBits
	mov edi, [ebp + 12] ;sets to base array (1st element)
	add edi, eax ; 4*(search counter) + search address
	push edi ;push search integer to stack to be swapped
	call swapNumbers
	popad ;restore old registers
	jmp innerLoop ;continue to cycle through rest of the integers

done:
	pop	ebp
	ret 8

sortArray	ENDP


swapNumbers	PROC
	push	ebp
	mov		ebp, esp

	mov edi, [ebp + 12] ;holds the address of old smallest element
	mov esi, [ebp + 8] ; holds the address of the search element

	mov eax, [edi] ; old small element
	mov ebx, [esi] ; search element

	mov [edi], ebx ;old small is now new
	mov [esi], eax ; new small is now old

	pop ebp
	ret 8

swapNumbers	ENDP

showMedian	PROC
	;check if array is even or odd
	push	ebp				;Set up stack frame
	mov		ebp,esp

	mov edx, OFFSET medianString
	call WriteString

	mov edi, [ebp + 8] ;moves array to edi
	;mov eax, [edi]
	;call WriteDec

	;check if array is even or odd
	mov ecx, 2
	mov eax, [ebp + 12] ;user input
	cdq
	div ecx
	cmp	edx, 0
	
	je		notOdd
	jne		isOdd

	;if not odd we need to divide the userinput by 2, and add the middle integer plus the one right about it
	notOdd:
	dec eax
	mov ecx, 2
	mov edx, [edi + 4*eax] 
	inc eax
	mov ebx, [edi + 4*eax]
	add edx, ebx
	mov eax, edx
	cdq
	div ecx
	call WriteDec
	jmp doneWithMedian

	;if the integer is odd than the median is just the middle integer
	isOdd:
	
	mov ecx, 2
	mov eax, [ebp +12]
	cdq ;conversion
	div ecx ;divide user input by 2
	mov ebx, [edi + 4*eax] ;holds the middle integer
	mov eax, ebx ;moves median to eax and prints
	call WriteDec
	jmp doneWithMedian


	doneWithMedian:
	call CrLf
	pop  ebp
	ret 12 ;pops array and userinput

showMedian ENDP

END main