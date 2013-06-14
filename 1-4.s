.data

	a: .word 1
	b: .word 100
	
.text
.global start
.ent start
start:
	lw $16, a #guarda valor do parametro 'a'
	lw $4, b #guarda valor do parametro 'b'
	jal intervalo
	
	j fim
	

intervalo:
	addi $29, $29, -8
	sw $31, 4($29)
	sw $4, 0($29)
	beq $4, $16, L1 #checa se o numero atual eh igual ao parametro 'a'
	addi $4, $4, -1
	jal intervalo
	lw $31, 4($29)
	lw $4, 0($29)
	addi $29, $29, 8
	add $2, $2, $4
	jr $31
	
L1: #caso base
	add $2, $0, $16
	addi $29, $29, 8
	jr $31
	
fim:
	break

.end start
