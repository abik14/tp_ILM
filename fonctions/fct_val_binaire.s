/*
uint16_t val_binaire(uint8_t b15, uint8_t b14, uint8_t b13, uint8_t b12,
                     uint8_t b11, uint8_t b10, uint8_t b9, uint8_t b8,
                     uint8_t b7, uint8_t b6, uint8_t b5, uint8_t b4,
                     uint8_t b3, uint8_t b2, uint8_t b1, uint8_t b0)
{
    return
      (b15 << 15) | (b14 << 14) | (b13 << 13) | (b12 << 12) | (b11 << 11) | (b10 << 10) | (b9 << 9) | (b8 << 8)
      | (b7 << 7) | (b6 << 6) | (b5 << 5) | (b4 << 4) | (b3 << 3) | (b2 << 2) | (b1 << 1) | b0;
}
*/

    .text
    .globl val_binaire
/*
uint16_t val_binaire(uint8_t b15, uint8_t b14, uint8_t b13, uint8_t b12,
                     uint8_t b11, uint8_t b10, uint8_t b9, uint8_t b8,
                     uint8_t b7, uint8_t b6, uint8_t b5, uint8_t b4,
                     uint8_t b3, uint8_t b2, uint8_t b1, uint8_t b0); */
/* DEBUT DU CONTEXTE
Fonction :
    val_binaire : feuille
    
Contexte :
    b15 : registre a0
    b14 : registre a1
    b13 : registre a2
    b12 : registre a3
    b11 : registre a4
    b10 : registre a5
    b9 : registre a6
    b8 : registre a7
    b7 : pile *(sp+0)
    b6 : pile *(sp+8)
    b5 : pile *(sp+16)
    b4 : pile *(sp+24)    
    b3 : pile *(sp+32)    
    b2 : pile *(sp+40)
    b1 : pile *(sp+48)
    b0 : pile *(sp+56)

FIN DU CONTEXTE */
val_binaire:
val_binaire_fin_prologue:
    slli t0, a0, 15    /* Ajouter b15 << 15 */
    slli t1, a1, 14     /* Ajouter b14 << 14 */
    or   t0, t0, t1
    slli t1, a2, 13     /* Ajouter b13 << 13 */
    or   t0, t0, t1
    slli t1, a3, 12     /* Ajouter b12 << 12 */
    or   t0, t0, t1
    slli t1, a4, 11     /* Ajouter b11 << 11 */
    or   t0, t0, t1
    slli t1, a5, 10     /* Ajouter b10 << 10 */
    or   t0, t0, t1
    slli t1, a6, 9      /* Ajouter b9 << 9 */
    or   t0, t0, t1
    slli t1, a7, 8      /* Ajouter b8 << 8 */
    or   t0, t0, t1

    ld   t1, 0(sp)     /* Charger b7 */
    slli t1, t1, 7
    or   t0, t0, t1

    ld   t1, 8(sp)     /* Charger b6 */
    slli t1, t1, 6
    or   t0, t0, t1

    ld   t1, 16(sp)    /* Charger b5 */
    slli t1, t1, 5
    or   t0, t0, t1

    ld   t1, 24(sp)    /* Charger b4 */
    slli t1, t1, 4
    or   t0, t0, t1

    ld   t1, 32(sp)    /* Charger b3 */
    slli t1, t1, 3
    or   t0, t0, t1

    ld   t1, 40(sp)    /* Charger b2 */
    slli t1, t1, 2
    or   t0, t0, t1

    ld   t1, 48(sp)    /* Charger b1 */
    slli t1, t1, 1
    or   t0, t0, t1

    ld   t1, 56(sp)    /* Charger b0 */
    or   t0, t0, t1    /* Ajouter b0 */

    /* Retourner le résultat */
    mv  a0, t0

val_binaire_debut_epilogue:
    ret
