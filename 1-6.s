.data 
	n: .word 8
.text
.global start
.ent start
start: 
	lw $4, n			
	jal fibonacci
	lw $16, 0($29)
	j fim

#fib(n) chama fib(n-1), quando chegamos em n < 2, colocamos 1,1 na pilha, q representam fib(0) e fib(1).
#Para fib(n), temos fib(n-1) e fib(n-2) na pilha. Colocamos fib(n)=fib(n-1)+fib(n-2) e fib(n-1) na pilha e continuamos.
fibonacci:
	addi $29, $29, -4 	# pilha $sp = $29
	sw $31, 0($29) 		# endereco de retorno # $ra = $31
	addi $8, $0, 2  	# tres linhas para comparacao (checar caso base)
	slt $9, $4, $8		# se a0 for menor que t0, t1 recebe 1
 	bne $9, $0, L1		# se o valor em t1 != 0, branch L1
 	addi $4, $4, -1		# decrementa a0
 	jal fibonacci		
 	lw $10, 0($29)		#push t2 na pilha
 	lw $11, 4($29)		#push t3 na pilha
 	lw $31, 8($29)		#push ra (endereco de retorno) na pilha
 	addi $29, $29, 4	#ajusta o ponteiro do topo da pilha
 	add $11, $11, $10	#soma t2 com t3, carrega em t2
 	sw $10, 4($29)		#carrega 
 	sw $11, 0($29)
 	jr $31
 L1:
	addi $12, $0, 1		#salva 1 em t4
	addi $29, $29, -4	#ajusta pilha pra um numero
	sw $12, 4($29)		#push t4 na pilha
	sw $12, 0($29)		#push t4 na pilha
	jr $31			#retorna para endereco em ra ($31)
fim:
	break
	
.end start

