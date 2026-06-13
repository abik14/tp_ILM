BADGES_TARGET = niv1__pgcd niv1__somme niv1__sommeMem niv1__premiers_pas niv1__mult_simple niv2__mult_egypt niv3__mult_native niv2__somme8

COMMON := ../common
include $(COMMON)/rules.mk

pgcd: pgcd.baremetal
	cp pgcd.baremetal pgcd

somme: somme.baremetal
	cp somme.baremetal somme

sommeMem: sommeMem.baremetal
	cp sommeMem.baremetal sommeMem

somme8: somme8.baremetal
	cp somme8.baremetal somme8

mult_simple: mult_simple.baremetal
	cp mult_simple.baremetal mult_simple

mult_egypt: mult_egypt.baremetal
	cp mult_egypt.baremetal mult_egypt

mult_native: mult_native.baremetal
	cp mult_native.baremetal mult_native

premiers_pas.o: fct_premiers_pas.o
	cp fct_premiers_pas.o premiers_pas.o
premiers_pas: premiers_pas.o

#fct_% : fct_%.s %.c
#	@echo "Il faut utiliser \"make $*\" et non \"make fct_$*\"."
