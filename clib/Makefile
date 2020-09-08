# this converts rotate instructions from "ro[lr] <reg>" -> "ro[lr] <reg>, 1" for yasm compatibility
PERL_FIXUP_ROTATE=perl -i -pe 's/(ro[rl]\s+\w{2,3})$$/\1, 1/'

CC=clang
C_FLAGS=-target x86_64-apple-darwin -masm=intel -mno-red-zone -mstackrealign -mllvm -inline-threshold=1000 -fno-asynchronous-unwind-tables \
	-fno-exceptions -fno-rtti -O3 -fno-builtin -ffast-math -fno-jump-tables -I_lib \
	-mavx2 -mfma -mllvm -force-vector-width=8

simd.s: simd.c
	$(CC) -S $(C_FLAGS) $^ -o $@ ; $(PERL_FIXUP_ROTATE) $@