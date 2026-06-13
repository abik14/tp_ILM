BADGES_TARGET = niv1__hash_hash niv3__hash_insert niv2__hash_lookup niv3__hash_delete

COMMON := ../common
include $(COMMON)/rules.mk
CFLAGS += -Wno-parentheses

hash_hash : hash_hash.o fct_hash_hash.o
hash_insert : hash_insert.o fct_hash_insert.o
hash_lookup : hash_lookup.o fct_hash_lookup.o
hash_delete : hash_delete.o fct_hash_delete.o
