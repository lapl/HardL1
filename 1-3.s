#include <Iregdef.h>
.data
	str: .asciiz "PALAV=RA"
	
.text
.global start
.ent start	
start:
	addi v1, $0, 0 # nao tem erro
	lw a0, 0 # a0 vai conter o tamanho da string
	la t5, str
	conta_caractere:
		add t0, t5, a0 				# pega o endereco dessa posicao
		lb t0, 0(t0) 				# pega o caracter dessa posicao pra poder comparar com o nulo
		addi a0, a0, 1 				# incrementa o tamanho
		bne t0, $0, conta_caractere # ve se chegou no caracter nulo
		
	sub a0, a0, 1 # por causa do caracter nulo
	
	#verifica se todos os caracteres sao letras, e ja coloca as maiusculas em minusculas
	lw a1, 0
	addi a2, $0, 122 #pra ajudar na verificacao, vai guardar o caracter 'z'
	verifica:
		add t0, t5, a1
		lb t0, 0(t0)
		
		slti t1, t0, 65 	 #eh menor que 'A' , nao eh letra
		bne t1, $0, fim_erro
		
		slt t1, a2, t0 	 	 #eh maior que 'z', nao eh letra
		bne t1, $0, fim_erro
	
		slti t1, t0, 91		 #eh letra maiuscula, pois é maior que 'A' e < '{' (ou seja 'A' <= x <= 'Z')
		beq t1, $0, minuscula
		
		#ta maiscula, bota pra minuscula
		addi t0, t0, 32		 #transforma em minuscula
		add t4, t5, a1		 #pega endereco dessa posicao
		sb t0, 0(t4)		 #guarda o caracter
		
		j minuscula		
		
		slti t1, t0, 97		 #eh menor que 'a', nao eh letra
		bne t1, $0, fim_erro
		
		minuscula:
		
		addi a1, a1, 1
		bne a1, a0, verifica
	
	#ordena
	lw t0, 0 # t0 = 0
	for_1:
		la t2, str # t2 = str
		add t2, t2, t0 # t2 = str + t0
		
		addi t1, t0, 1 # t1 = t0 + 1
		for_2:
			beq t1, a0, fim_for_2 # t1 < len
			
			la t4, str # t4 = str
			add t4, t4, t1 # t4 = str+t1
			lb t5, 0(t4) # t5 = str[t1]
			
			lb t3, 0(t2) # t3 = str[t0]
			
			slt t6, t5, t3 # t6 = (str[t1] < str[t0])
			beq t6, $0, certo #esses caracteres ja estao ordenados
			
			#str[t1] tem que vim antes de str[t0], vamos trocar eles de posicao
			#t3 = str[t0], t5 = str[t1]
			sb t3, 0(t4) #str[t1] = str[t0]
			sb t5, 0(t2) #str[t0] = str[t1]
			
			certo:
			addi t1, t1, 1 # ++t1
			j for_2
			fim_for_2:
			
			
		addi t0, t0, 1 # ++t0
		bne t0, a0, for_1 # t0 < len
		
		j fim_ok # chegou aqui ja ta ordenado, e eh tudo letra
		
	fim_erro:
		addi v1, $0, 1
		
	fim_ok:
	break		
.end start