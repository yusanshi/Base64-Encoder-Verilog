.text

addi $30, $0, 0
start: 
# $1: input_loc
# $2: output_loc
	addi $18, $0, 0
		sw $18, 1032($0)
	addi $1,$0,0
	addi $2,$0,0
	
# temp: $12 $13 $14 $15 $22 $23 $24 $25
	process_three:
		add $12, $1, 2
lw $21, 1044($0)
slt $13, $12, $21

		beq $13, $0, check_remainder

		# $3 $4 $5: a, b, c
		addi $16, $1, 0
		sw $16, 1024($0)
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		lw $3, 1028($0)

		addi $16, $1, 1
		sw $16, 1024($0)
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		lw $4, 1028($0)
addi $16, $1, 2
		sw $16, 1024($0)
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		lw $5, 1028($0)

	
		# temp: $12 $13 $14 $15 $22 $23 $24 $25
		# first
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 2
		srlv $13, $3, $12 # $13: a[7:2]
		addi $20, $13, 0
		sw $20, 1040($0)
		
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1
	
		slt $23, $30, $2
		beq $23, $0, skip_1
		addi $30, $2, 0
		skip_1:
		# second
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 30
		sllv $13, $3, $12
		addi $14, $0, 26
		srlv $13, $13, $14 # $13: {a[1:0],0000}
		addi $15, $0, 4
		srlv $22, $4, $15 # $22: b[7:4]
		add $20, $13, $22
		sw $20, 1040($0)
		
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1
		
		slt $23, $30, $2
		beq $23, $0, skip_2
		addi $30, $2, 0
		skip_2:
# third
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 28
		sllv $13, $4, $12
		addi $14, $0, 26
		srlv $13, $13, $14 # $13: {b[3:0],00}
		addi $15, $0, 6
		srlv $22, $5, $15 # $22: c[7:6]
		add $20, $13, $22
		sw $20, 1040($0)
		
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_3
		addi $30, $2, 0
		skip_3:
# forth
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 26
		sllv $13, $5, $12 
		srlv $13, $13, $12 
		addi $20, $13, 0
		sw $20, 1040($0)
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_4
		addi $30, $2, 0
		skip_4:
		addi $1, $1, 3
		j process_three
	check_remainder:
		
		# $1: input_loc
		# $2: output_loc
		
		# if (input_loc + 1) = total_num
		add $12, $1, 1
lw $21, 1044($0)
bne $12, $21, continue_check
addi $16, $1, 0
		sw $16, 1024($0)
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		lw $3, 1028($0)

		# first
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 2
		srlv $13, $3, $12 # $13: a[7:2]
		addi $20, $13, 0
		sw $20, 1040($0)
		
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_5
		addi $30, $2, 0
		skip_5:
		
		# second
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 30
		sllv $13, $3, $12
		addi $14, $0, 26
		srlv $13, $13, $14 # $13: {a[1:0],0000}
		addi $20, $13, 0
		sw $20, 1040($0)
		
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_6
		addi $30, $2, 0
		skip_6:
		
		# third 
		addi $19, $2, 0
		sw $19, 1036($0)
		addi $20, $0, 64
		sw $20, 1040($0)
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_7
		addi $30, $2, 0
		skip_7:
		
		# fourth
		addi $19, $2, 0
		sw $19, 1036($0)
		addi $20, $0, 64
		sw $20, 1040($0)
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_8
		addi $30, $2, 0
		skip_8:
	continue_check:	
		# if (input_loc + 2) = total_num
		add $12, $1, 2
lw $21, 1044($0)
bne $12, $21, check_output_num

		# $3: a  $4: b
		addi $16, $1, 0
		sw $16, 1024($0)
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		lw $3, 1028($0)

		addi $16, $1, 1
		sw $16, 1024($0)
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
		add $0, $0, $0
lw $4, 1028($0)
# first
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 2
		srlv $13, $3, $12 # $13: a[7:2]
		addi $20, $13, 0
		sw $20, 1040($0)
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_9
		addi $30, $2, 0
		skip_9:
		
		# second
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 30
		sllv $13, $3, $12
		addi $14, $0, 26
		srlv $13, $13, $14 # $13: {a[1:0],0000}
		addi $15, $0, 4
		srlv $22, $4, $15 # $22: b[7:4]
		add $20, $13, $22
		sw $20, 1040($0)
		
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1
		slt $23, $30, $2
		beq $23, $0, skip_10
		addi $30, $2, 0
		skip_10:
		
		# third 
		addi $19, $2, 0
		sw $19, 1036($0)
		
		addi $12, $0, 28
		sllv $13, $4, $12
		addi $14, $0, 26
		srlv $13, $13, $14 # $13: {b[3:0],00}
		addi $20, $13, 0
		sw $20, 1040($0)
		
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_11
		addi $30, $2, 0
		skip_11:
		
		# fourth
		addi $19, $2, 0
		sw $19, 1036($0)
		addi $20, $0, 64
		sw $20, 1040($0)
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		addi $2, $2, 1		
		slt $23, $30, $2
		beq $23, $0, skip_12
		addi $30, $2, 0
		skip_12:
	
	check_output_num:
		slt $13, $2, $30
		beq $13, $0, finish_check_output_num
		addi $19, $2, 0
		sw $19, 1036($0)
		addi $20, $0, 65
		sw $20, 1040($0)
		addi $18, $0, 1
		sw $18, 1032($0)
		addi $18, $0, 0
		sw $18, 1032($0)
		
addi $2, $2, 1
		j check_output_num
	finish_check_output_num:
	j start