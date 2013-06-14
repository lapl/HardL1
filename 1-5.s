.data
	primos: .word 2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97
	arr: .word 2,4,7,17,25
	resp: .space 100
	
.text
.global start
.ent start
start:
	addi $16,$0,100 #25 primos em [0,100]
	addi $17,$0,20 #Tamanho do array de entrada
	
	lw $18, 0 #indice em arr
	lw $19, 0 #indice em primos
	lw $20, 0 #indice em resp
	
	Loop1:
		beq $18,$17,fim
		lw $21, arr($18) #elemento de arr
		lw $19,0 #indice em primos
		Loop2:
			beq $19,$16,continua
			lw $22,primos($19)
			beq $21,$22,adiciona
			addi $19,$19,4
			j Loop2
			
		continua:
		addi $18,$18,4
		j Loop1
		
adiciona:
	sw $22,resp($20)
	addi $20,$20,4
	j continua
fim:
	break

.end start
