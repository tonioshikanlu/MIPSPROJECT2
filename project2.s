.data
	string1: .asciiz "Enter four characters"
.text 				# Assembly instructions
main:				# Start of main code
	la $a0, string1		# Load String asking for characters
	li $v0, 4
	syscall 		# prints output