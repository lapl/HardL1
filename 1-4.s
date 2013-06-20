.data

	a: .word 1
	b: .word 3
	
.text
.global start
.ent start
start:
	lw $16, a 		#guarda valor do parametro 'a'
	lw $4, b 		#guarda valor do parametro 'b'
	
	slt $5, $4, $16
	beq $5, $0, intervalo_bom #verifica se a < b
	
	addi $3, $0, 1 #coloca 1 no registrador v1
	j fim	
	
	intervalo_bom:
	
	jal intervalo
	
	j fim
	
#começamos de b e descemos na recursao ate chegarmos em 'a', onde "inicializamos" o retorno com a
#depois disso, cada parametro de chamada é somado ao retorno, obtendo a+a+1+a+2+...+b-1+b
intervalo:
	addi $29, $29, -8	#ajusta a pilha para dois numeros
	sw $31, 4($29)		#salva o endereço de retorno
	sw $4, 0($29)		#primeiro numero em a0
	beq $4, $16, L1 	#checa se o numero atual eh igual ao parametro 'a'
	addi $4, $4, -1		#decrementa a0
	jal intervalo		#recursao
	lw $31, 4($29)		#carrega o endereco de retorno
	lw $4, 0($29)		#carrega o numero no topo da pilha
	addi $29, $29, 8	#ajusta o topo da pilha
	add $2, $2, $4		#soma v0 com a0, guarda em v0
	jr $31				#retorno
	
L1: #caso base
	add $2, $0, $16		#carrega s0 (salvo na memória) em v0, o primeiro número do intervalo
	addi $29, $29, 8	#ajusta a pilha para dois números
	jr $31				#retorno
	
fim:
	break

.end start
