/*
void abr_vers_tab(struct noeud_t *abr)
{
    struct noeud_t *fd;
    if (abr != NULL) {
        abr_vers_tab(abr->fg);
        *ptr = abr->val;
        ptr++;
        fd = abr->fd;
        free(abr);
        abr_vers_tab(fd);
    }
}
*/

    .data
    .globl ptr
    .align 3
ptr:
    .quad 0                     # Variable globale ptr de type uint64_t*

    .text
    .globl abr_vers_tab
/* DEBUT DU CONTEXTE
Fonction :
    abr_vers_tab : non feuille
Contexte :
    abr : registre a0
    fd : registre s1
FIN DU CONTEXTE */
abr_vers_tab:
    addi sp, sp, -24
    sd ra, 16(sp)
    sd s0, 8(sp)
    sd s1, 0(sp)
    
abr_vers_tab_fin_prologue:
    beqz a0, end    # if (abr == NULL) return
    
    mv s0, a0
    
    ld a0, 8(s0)                # a0 = abr->fg (offset 8)
    call abr_vers_tab
    
    # *ptr = abr->val
    la t0, ptr                  # t0 = adresse de ptr
    ld t1, 0(t0)
    
    ld t2, 0(s0)                # t2 = abr->val
    sd t2, 0(t1)                # *ptr = abr->val
    
    addi t1, t1, 8              # ptr += 8
    sd t1, 0(t0)
    
    ld s1, 16(s0)               # s1 = abr->fd (offset 16)
    
    mv a0, s0                   # a0 = abr
    call free
    
    mv a0, s1                   # a0 = fd
    call abr_vers_tab
end:
abr_vers_tab_debut_epilogue:
    ld ra, 16(sp)
    ld s0, 8(sp)
    ld s1, 0(sp)
    addi sp, sp, 24
    ret


