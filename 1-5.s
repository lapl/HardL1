.data
	primos: .word 2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97 #todos os primos em [1,100]
	a: .word 2,4,7,17,25 #array de entrada
	b: .space 100 #reserva o espaço para os numeros, que aso no maximo 25
	
.text
.global start
.ent start
start:
	addi $16,$0,100 #25 primos em [1,100]
	addi $17,$0,20 #Tamanho do aay de entrada
	
	lw $18, 0 #indice em a
	lw $19, 0 #indice em primos
	lw $20, 0 #indice em b
	
	#Para cada numero da entrada, vamos tentar encontra-lo no array de primos.
	#Quando encontramos o adicionamos em b
	Loop1:
		beq $18,$17,fim
		lw $21, a($18) #elemento de a
		lw $19,0 #indice em primos
		Loop2:
			beq $19,$16,continua
			lw $22,primos($19)
			beq $21,$22,adiciona
			addi $19,$19,4 #cada posição ocupa 4 bytes
			j Loop2
			
		continua:
		addi $18,$18,4
		j Loop1
		
adiciona:
	sw $22,b($20)
	addi $20,$20,4
	j continua
fim:
	break

.end start
