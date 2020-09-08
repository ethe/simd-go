CC=clang
C_FLAGS=-target x86_64-apple-darwin -masm=intel -mno-red-zone -mstackrealign -mllvm -inline-threshold=1000 -fno-asynchronous-unwind-tables \
	-fno-exceptions -fno-rtti -O3 -fno-builtin -ffast-math -fno-jump-tables -I_lib \
	-mavx2 -mfma -mllvm -force-vector-width=8

all: simd.s

simd.s: simd.c
	$(CC) -S $(C_FLAGS) $^ -o $@

clean:
	rm -rf simd.s