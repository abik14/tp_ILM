/*
bool abr_est_present(uint64_t val, struct noeud_t *abr)
{
   if (abr == NULL) {
       return false;
   } else if (val == abr->val) {
       return true;
   } else if (val < abr->val) {
       return abr_est_present(val, abr->fg);
   } else {
       return abr_est_present(val, abr->fd);
   }
}
*/

    .text
    .globl abr_est_present
/* DEBUT DU CONTEXTE
Fonction :
    abr_est_present : non feuille
Contexte :
    val : registre a0
    abr : registre a1
FIN DU CONTEXTE */
abr_est_present:
    addi sp, sp, -16
    sd ra, 0(sp)
    
abr_est_present_fin_prologue:
    beqz a1, return_false       # if (abr == NULL)
    
    ld t0, 0(a1)                # t0 = abr->val
    
    beq a0, t0, return_true 
    
    bltu a0, t0, gauche
    
    ld a1, 16(a1)               # a1 = abr->fd (offset 16)
    call abr_est_present
    j epilogue
    
gauche:
    ld a1, 8(a1)                # a1 = abr->fg (offset 8)
    call abr_est_present
    j epilogue
    
return_false:
    li a0, 0
    j epilogue
    
return_true:
    li a0, 1
    
epilogue:
abr_est_present_debut_epilogue:
    ld ra, 0(sp)
    addi sp, sp, 16
    ret
