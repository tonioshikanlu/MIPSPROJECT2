.data 
   userInput:   .space 1000
   empty_string_error:   .asciiz "Input is empty."
   too_long:   .asciiz  "Input is too long."
   invalidSpaces:   .asciiz   "Invalid base-35 number."
.text 
main:  # This is the beginning of my main program.
   li $v0, 8  
   la $a0, userInput # This reads the user's string input.
   li $a1, 1000	# This assigns a space of 1000 bytes for the user.
   syscall 
