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
   
   lb $t4, 0($t4)           # Loads current index.

   beq $t4, $zero, terminate_space_loop  # This will exit the loop to length of the string check, if string has been terminated.

   addi $t4, $t4, -10		# Continues the code.
   beqz $t4, terminate_space_loop        # This will exit the loop if an exitline character has been reached.

   addi $t4, $t4, -22

   bnez $t4, last_index_change # This will update last charcter not a space.
space_loop_removal_increment:

   addi $t8, $t8, 1              #This will Increment the character's current index .

   j space_loop_removal		# Jumps to space_loop_removal after code is run.

last_index_change:

   move $t2, $t8 # Moves current index into last index on basis of some considerations.

   j space_loop_removal_increment
terminate_space_loop:

   add $t4, $zero, $a0 

   add $t4, $t4, $t2 

   addi $t4, $t4, 1  
   
   # This section of code regained the address of the registers.

   j Length_Counter
   # This will check the Length of the user's Input.
Length_Counter:

   li $t5, -1

   add $a0, $t7, $zero
   
   Loop:
   lb $t3, 0($a0)
   or $t2, $t3, $t5
   beq $t2, $zero, Empty_string_error
   beq $t3, $zero, stringDone
   addi $a0, $a0, 1

   addi $t5, $t5, 1

   j Loop
   #Execute if exit of string has been reached.

stringDone:

   slti $t1, $t5, 5

   beq $t1, $zero, lengthError

   bne $t1, $zero, string_checker
     #Return error message showing an empty string.

Empty_string_error:

   li $v0, 4

   la $a0, empty_string_error

   syscall

   j exit
      
  #This will show an error message indicating string with too many characters.

lengthError:

   li $v0, 4

   la $a0, too_long

   syscall

   j exit    
 #This will check if the string is valid for characters exceeding base-35 representation.

string_checker:

   move $a0, $t7 # This will move the user input address from t7 to a0.

