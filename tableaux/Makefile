BADGES_TARGET = niv1__taille_chaine niv1__inverse_chaine niv1__tri_min niv3__tri_nain niv3__tri_nain_opt niv3__tri_nain_superopt
BINS = comparer_nains

COMMON := ../common
include $(COMMON)/rules.mk


taille_chaine: taille_chaine.o fct_taille_chaine.o

inverse_chaine: inverse_chaine.o fct_inverse_chaine.o

tri_min: tri_min.o fct_tri_min.o

tri_nain: tri_nain.o fct_tri_nain.o

tri_nain_opt: tri_nain_opt.o fct_tri_nain_opt.o

tri_nain_superopt: tri_nain_superopt.o fct_tri_nain_superopt.o

comparer_nains: comparer_nains.o fct_tri_nain.o fct_tri_nain_opt.o fct_tri_nain_superopt.o
