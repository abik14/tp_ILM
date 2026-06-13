/*
uint64_t fibo(uint64_t n);
{
    uint64_t fibo_temp;
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        fibo_temp = fibo(n - 1);
        return fibo_temp + fibo(n - 2);
    }
}
*/
    .text
    /* uint64_t fibo(uint64_t n) */
    .globl fibo
/* DEBUT DU CONTEXTE
Fonction :
    fibo : non feuille
Contexte :
    n : registre a0; pile *(sp+0)
    fibo_temp : pile *(sp+8)
    ra : pile *(sp+16)
FIN DU CONTEXTE */
fibo:
    addi sp, sp, -24       
    sd   ra, 16(sp)        
    sd   a0, 0(sp)     

fibo_fin_prologue:
    beqz a0, n_0  
    li   t0, 1
    beq  a0, t0, n_1 

    addi a0, a0, -1
    call fibo
    sd   a0, 8(sp)         

    ld   a0, 0(sp)         
    addi a0, a0, -2
    call fibo

    ld   t1, 8(sp)         
    add  a0, a0, t1        
    j    end
n_0:
    li   a0, 0            
    j    end
n_1:
    li   a0, 1             
end:
fibo_debut_epilogue:
    ld   ra, 16(sp)        
    addi sp, sp, 24        
    ret
