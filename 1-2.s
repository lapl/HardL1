.data
 
.text
.global start
.ent start
start:
 
        # registrador 'a'
        addi $8, $0, -1
       
        # registrador 'b'
        addi $9, $0, 1
       
        # registrador 'x'
        addi $13, $0, 0
       
        # registrador com o valor 1
        addi $15, $0, 1
       
        slt $10, $8, $0                 #confere se a<0, armazena em $10
        slt $11, $8, $9                 #confere se a<b, armazena em $11
       
        bne $10, $0, Elseif             #confere se a>=0, se não for ele jump pra Elseif
        slt $10, $8, $9                 #confere se a<b
        bne $11, $15, Elseif    #se a>=b,  
        addi $13, $0, 1
        j Exit
        Elseif:
                slt $10,$8,$9
                beq $10,$15,Else  #confere se a<b
                beq $8, $9, Else  #confere se a==b
                addi $13, $0, 2
                j Exit
        Else:
                addi $13, $0, 3        
        Exit:
.end start