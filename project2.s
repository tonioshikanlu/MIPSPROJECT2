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
# This will remove the spaces in the beginning of the string.
initial_space_deletion:

   li $t8, 32 	# Initializes the space characeter.

   lb $t7, 0($a0) 

   beq $t8, $t7, initial_char_deletion #Removes initial space characters.

   move $t7, $a0  # Stores characters in t7 register if they are not spaces.
   j delete_after_spaces #Jumps to conditional.
