/*
void hello(void)
{
	affiche_HelloWorld();
}
*/

    .text
    .globl hello
    /* void hello(void) */
/*
  Pas de paramètre, Pas de variable locale.
  ra doit être sauvegardé dans la pile pour ne pas être écrasé lors de l'appel de fonction.

DEBUT DU CONTEXTE
  Fonction :
    hello : non feuille
  Contexte :
    ra  : pile *(sp+0)
FIN DU CONTEXTE */
hello:
  addi sp, sp, -8
  sd ra, 0(sp)
hello_fin_prologue:
  call affiche_HelloWorld
hello_debut_epilogue:
  ld ra, 0(sp)
  addi sp, sp, 8
  ret
