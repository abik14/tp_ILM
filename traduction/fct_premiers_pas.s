/* DEBUT DU CONTEXTE
  Fonction :
    premiers_pas : feuille
Contexte :
    taille  : registre a1
    i       : registre t0
FIN DU CONTEXTE */
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	tab
	.section	.data.tab,"aw"
	.align	3
	.type	tab, @object
	.size	tab, 84
tab:
	.word	17
	.word	-7
	.word	9
	.word	-14
	.word	5
	.word	17
	.word	1
	.word	10
	.word	14
	.word	16
	.word	-8
	.word	-8
	.word	7
	.word	8
	.word	6
	.word	5
	.word	11
	.word	8
	.word	15
	.word	-11
	.word	15
	.section	.rodata
	.align	3
.LC0:
	.string	"%d "
	.section	.text.LLf,"ax",@progbits
	.align	2
	.type	LLf, @function
LLf:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lwu	a5,-20(s0)
	slli	a5,a5,2
	ld	a4,-40(s0)
	add	a5,a4,a5
	lw	a5,0(a5)
	mv	a1,a5
	lla	a0,.LC0
	jal ra,	printf
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bltu	a4,a5,.L3
	li	a0,10
	jal ra,	putchar
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	LLf, .-LLf
    .globl premiers_pas
premiers_pas:
premiers_pas_fin_prologue:
    mv   t0, zero
/*  ===> Premier extrait à traduire : boucle while */
/*  while(i < taille - 1) { */
premiere_traduction:
    /* ===> DEBUT DU CORPS DE LA BOUCLE WHILE */
boucle_while:
	addi t6, a1, -1
	bge t0, t6, premiers_pas_debut_epilogue
    slli t2, t0, 2
    add  t2, a0, t2
    lw   t3, 0(t2)
    lw   t4, 4(t2)
    slt  t5, t4,t3
    beqz t5, fie
    slli t2, t0, 2
    add  t2, a0, t2
    lw   t1, 0(t2)
    slli t2, t0, 2
    add  t2, a0, t2
    lw   t3, 4(t2)
    sw   t3, 0(t2)
    slli  t2, t0, 2
    add  t2, a0, t2
    sw   t1, 4(t2)
/*  ===> Deuxième extrait à traduire : test */
/*      if (i > 0) { */
/*          i = i - 1; */
/*      } */
deuxieme_traduction:
    slt t6, x0, t0
	sub t0, t0, t6
	j    ifefi
fie:
    addi t0, t0, 1
ifefi:
    /* ===> FIN DU CORPS DE LA BOUCLE WHILE */
	j boucle_while
premiers_pas_debut_epilogue:
    ret
	.section	.rodata
	.align	3
.LC1:
	.string	"Test d'un tri "
	.align	3
.LC2:
	.string	"Tableau initial : "
	.align	3
.LC3:
	.string	"Tableau trie : "
	.section	.text.main,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-16
	sd	ra,8(sp)
	sd	s0,0(sp)
	addi	s0,sp,16
	lla	a0,.LC1
	jal ra,	puts
	lla	a0,.LC2
	jal ra,	printf
	li	a1,21
	lla	a0,tab
	jal ra,	LLf
	li	a1,21
	lla	a0,tab
	jal ra,	premiers_pas
	lla	a0,.LC3
	jal ra,	printf
	li	a1,21
	lla	a0,tab
	jal ra,	LLf
	li	a5,0
	mv	a0,a5
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	main, .-main
