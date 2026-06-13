BADGES_TARGET = niv2__inverse_liste niv2__decoupe_liste niv3__palin
BINS = struct
CONTEXTS := ${BINS:=.ctxt}

COMMON := ../common
include $(COMMON)/rules.mk
CFLAGS += -O3


struct: struct.o fct_struct.o

inverse_liste: inverse_liste.o fct_inverse_liste.o

decoupe_liste: decoupe_liste.o fct_decoupe_liste.o

palin: palin.o fct_palin.o

