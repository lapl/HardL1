.data
a:	.word 2
b:	.word 1
m: 	.word 0
	.text
	.global start
	.ent start
start:  lw  $8, a
		lw	$9, b
	    lw	$10, a #registrador $10 representa variável m
	    slt $11, $9, $10
	    beq $11, $0, Else
	    	add $10, $9, $0
	    	j Exit
	    Else:
	    	add $10, $0, $0
	    Exit:
.end start