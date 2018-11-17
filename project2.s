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

initial_char_deletion:

   addi $a0, $a0, 1 #This increments the counter.

   j initial_space_deletion #Jumps to conditional.
delete_after_spaces:

   la $t3, userInput  # Loads the user input.

   sub $t3, $t7, $t3 # This keeps the offset.
   li $t2, 0  #This will initialize the index of the last character in the string.

   li $t8, 0  #This loads the current index.
# This deals with the spaces condition.
space_loop_removal:

   add $t4, $t3, $t8

   addi $t4, $t4, -100

   beqz $t4, terminate_space_loop        # This will terminate if the string buffer exit has been seen.

   add $t4, $t8, $a0        # Obtains current index address.
