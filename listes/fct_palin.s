/*
bool palin(const char *ch)
{
    uint64_t inf, sup;
    inf = 0;
    sup = strlen(ch) - 1;
    while (inf < sup && ch[inf] == ch[sup]) {
        inf++;
        sup--;
    }
    return inf >= sup;
}
*/
    .text
    .globl palin
	.type palin, @function
    /* bool palin(char *ch) */
/* DEBUT DU CONTEXTE
Fonction :
    palin : non feuille
Contexte :
    ch  : registre a0
    inf : registre t0
    sup : registre t1
FIN DU CONTEXTE */
palin:
    addi sp, sp, -16
    sd ra, 8(sp)
    sd s0, 0(sp)
    
palin_fin_prologue:
    mv s0, a0
    call strlen

    li t0, 0
    addi t1, a0, -1             
    mv a0, s0
while_loop:
    bge t0, t1, end_while      
    
    add t2, a0, t0              # t2 = adresse de ch[inf]
    lbu t3, 0(t2)               # t3 = ch[inf]
    
    add t2, a0, t1              # t2 = adresse de ch[sup]
    lbu t4, 0(t2)               # t4 = ch[sup]
    
    bne t3, t4, end_while       
    addi t0, t0, 1
    addi t1, t1, -1
    j while_loop
end_while:
    slt a0, t0, t1
    xori a0, a0, 1
    
palin_debut_epilogue:
    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp, sp, 16
    ret
	.size palin, . - palin
