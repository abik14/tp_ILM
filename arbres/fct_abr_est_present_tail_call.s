/*
bool abr_est_present_tail_call(uint64_t val, struct noeud_t *abr)
{
   if (abr == NULL) {
       return false;
   } else if (val == abr->val) {
       return true;
   } else if (val < abr->val) {
       return abr_est_present_tail_call(val, abr->fg);
   } else {
       return abr_est_present_tail_call(val, abr->fd);
   }
}
*/
    .text
    .globl abr_est_present_tail_call
/* DEBUT DU CONTEXTE
Fonction :
    abr_est_present_tail_call : feuille
Contexte :
    val : registre a0
    abr : registre a1
FIN DU CONTEXTE */
abr_est_present_tail_call:
abr_est_present_tail_call_fin_prologue:
debut:
    beqz a1, return_false       
    
    ld t0, 0(a1)                # t0 = abr->val
    
    beq a0, t0, return_true     
    
    bltu a0, t0, gauche    
    
    ld a1, 16(a1)               # a1 = abr->fd (offset 16)
    j debut
    
gauche:
    ld a1, 8(a1)                # a1 = abr->fg
    j debut
return_false:
    li a0, 0                    # return false = 0
    j end
return_true:
    li a0, 1                    # return true = 1
end:
abr_est_present_tail_call_debut_epilogue:
    ret
