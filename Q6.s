.data 
	n: .word 30
.text
.global start
.ent start
start: 
	lw $4, n
	jal fibonacci
	lw $16, 0($29)
	j fim
	
fibonacci:
	addi $29, $29, -4 # pilha $sp = $29
	sw $31, 0($29) # endereco de retorno # $ra = $31
	addi $8, $0, 2  # tres linhas para comparacao (checar caso base)
	slt $9, $4, $8
 	bne $9, $0, L1
 	addi $4, $4, -1
 	jal fibonacci
 	lw $10, 0($29)
 	lw $11, 4($29)
 	lw $31, 8($29)
 	addi $29, $29, 4
 	add $11, $11, $10
 	sw $10, 4($29)
 	sw $11, 0($29)
 	jr $31
 L1:
	addi $12, $0, 1
	addi $29, $29, -4
	sw $12, 4($29)
	sw $12, 0($29)
	jr $31
fim:
	break
	
.end start