# Vérifie si la variable $COMMON est bien définie
$(if ${COMMON},,$(error COMMON doit être défini))


# Chemins et options pour les outils
CMDBASE= riscv64-unknown-elf
AS = $(CMDBASE)-gcc
ASFLAGS = -march=rv64ima_zicsr -mabi=lp64 -mcmodel=medany -Wno-main -Wformat-truncation=0 -pipe -nostdinc -Wall -Wextra -std=c11 -mabi=lp64 -ffunction-sections -fdata-sections -O0 -ggdb3  -D verb=$(VERB) -c -I. -I../lib
CC = $(AS)
CFLAGS = $(ASFLAGS)
LD = $(AS)
LDFLAGS = -nostdlib -nostartfiles -static -lgcc -Wl,--nmagic -Wl,--gc-sections -Wl,--no-warn-rwx-segments
LDOPTS += -e entry -T$(COMMON)/ilm.lds -L../lib -lilm
LDOPTSBAREMETAL += -e entry -T$(COMMON)/ilm.lds
AR = $(CMDBASE)-ar
ARFLAGS = rcs
OBJCOPY = $(CMDBASE)-objcopy


# Ajoute le contenu de BADGES_TARGET à BINS, excepté un préfixe terminant par __. Exemple : niv1__foo_bar devient foo_bar
# /!\ Pas de __ autorisé dans la suite car on découpe à chaque __
BADGE_NAMES ?= $(foreach f, $(BADGES_TARGET),$(word 2, $(subst __, ,$f)))
BINS += $(BADGE_NAMES)

.PHONY: all clean
all: $(BINS)

%.baremetal: fct_%.o
	$(LD) $(LDFLAGS) $(LDOPTSBAREMETAL) -o $@ $^
%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<
%: %.o
	$(LD) $(LDFLAGS) -o $@ $^ $(LDOPTS)
# Extrait le contexte d'un fichier .s
%.ctxt: fct_%.s
	@sed -n "/DEBUT DU CONTEXTE/,/FIN DU CONTEXTE/p" $< | sed '1,1d; $$d' > $@

# Extrait le corps de la fonction d'un fichier .s
%.fun: fct_%.s
	sed -e "s/#.*$$//g" $< | cpp | sed -e "s/#.*$$//g" -e "/^$$/d" | sed -nE "/$*:/,/^[[:space:]]*([[:alnum:]]+:)?\<ret\>/p" > $@

# Vérification des étiquettes d'une fonction
%.stxetd: %.fun fct_%.s
	fonction=$*; awk -f $(COMMON)/ordre_etiquettes.awk -v fonction=$$fonction $< > $@; cat $@

BAREMETAL  = $(foreach f, $(BADGE_NAMES), $(addsuffix .baremetal, $f))
STXETDOUTS = $(foreach f, $(BADGE_NAMES), $(addsuffix .stxetd, $f))
SORTIES    = $(foreach f, $(BADGE_NAMES), $(addsuffix .sortie, $f))
CONTEXTS  += $(foreach f, $(BADGE_NAMES), $(addsuffix .ctxt, $f))
FUNCTIONS  = $(foreach f, $(BADGE_NAMES), $(addsuffix .fun, $f))
OBJS       = $(foreach f, $(BINS), $(addsuffix .o, $f)) \
             $(foreach f, $(BINS), $(addprefix fct_, $(addsuffix .o, $f)))

clean:
	$(RM) $(BINS) $(BAREMETAL) $(OBJS) $(TMPOBJS) $(CONTEXTS) $(FUNCTIONS) $(STXETDOUTS) $(SORTIES)

