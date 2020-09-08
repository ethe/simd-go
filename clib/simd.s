	.text
	.intel_syntax noprefix
	.file	"simd.c"
	.globl	validate_ascii_fast
	.align	16, 0x90
	.type	validate_ascii_fast,@function
validate_ascii_fast:                    # @validate_ascii_fast
# BB#0:
	push	rbp
	mov	rbp, rsp
	and	rsp, -8
	vpxor	ymm0, ymm0, ymm0
	xor	r10d, r10d
	mov	eax, 0
	cmp	rsi, 32
	jb	.LBB0_3
# BB#1:                                 # %.preheader.i
	lea	rcx, [rsi - 32]
	vpxor	ymm0, ymm0, ymm0
	xor	eax, eax
	.align	16, 0x90
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	vpor	ymm0, ymm0, ymmword ptr [rdi + rax]
	add	rax, 32
	cmp	rax, rcx
	jbe	.LBB0_2
.LBB0_3:                                # %.loopexit.i
	vpmovmskb	r8d, ymm0
	cmp	rax, rsi
	jae	.LBB0_12
# BB#4:                                 # %.lr.ph.i.preheader
	mov	ecx, esi
	sub	ecx, eax
	lea	r9, [rsi - 1]
	sub	r9, rax
	test	cl, 3
	je	.LBB0_5
# BB#6:                                 # %.lr.ph.i.prol.preheader
	mov	r11d, esi
	sub	r11d, eax
	and	r11d, 3
	neg	r11
	xor	r10d, r10d
	.align	16, 0x90
.LBB0_7:                                # %.lr.ph.i.prol
                                        # =>This Inner Loop Header: Depth=1
	movzx	ecx, byte ptr [rdi + rax]
	or	ecx, r10d
	inc	rax
	movsx	r10d, cl
	inc	r11
	jne	.LBB0_7
	jmp	.LBB0_8
.LBB0_5:
	xor	r10d, r10d
.LBB0_8:                                # %.lr.ph.i.preheader.split
	cmp	r9, 3
	jb	.LBB0_11
# BB#9:                                 # %.lr.ph.i.preheader.split.split
	sub	rsi, rax
	lea	rax, [rax + rdi + 3]
	.align	16, 0x90
.LBB0_10:                               # %.lr.ph.i
                                        # =>This Inner Loop Header: Depth=1
	movzx	ecx, byte ptr [rax - 3]
	or	ecx, r10d
	movzx	r9d, byte ptr [rax - 2]
	movzx	edi, byte ptr [rax - 1]
	or	edi, r9d
	or	edi, ecx
	movzx	ecx, byte ptr [rax]
	or	ecx, edi
	movsx	r10d, cl
	add	rax, 4
	add	rsi, -4
	jne	.LBB0_10
.LBB0_11:                               # %._crit_edge.loopexit.i
	and	r10d, 128
.LBB0_12:                               # %validate_ascii_fast_avx.exit
	or	r10d, r8d
	sete	al
	movzx	eax, al
	mov	qword ptr [rdx], rax
	mov	rsp, rbp
	pop	rbp
	vzeroupper
	ret
.Lfunc_end0:
	.size	validate_ascii_fast, .Lfunc_end0-validate_ascii_fast


	.ident	"clang version 3.8.1-24 (tags/RELEASE_381/final)"
	.section	".note.GNU-stack","",@progbits