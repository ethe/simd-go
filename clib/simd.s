	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15	sdk_version 10, 15, 6
	.intel_syntax noprefix
	.globl	_validate_ascii_fast    ## -- Begin function validate_ascii_fast
	.p2align	4, 0x90
_validate_ascii_fast:                   ## @validate_ascii_fast
## %bb.0:
	push	rbp
	mov	rbp, rsp
	push	r14
	push	rbx
	and	rsp, -8
	xor	ecx, ecx
	cmp	rsi, 32
	jb	LBB0_1
## %bb.2:
	lea	rbx, [rsi - 32]
	vpxor	xmm0, xmm0, xmm0
	xor	eax, eax
	.p2align	4, 0x90
LBB0_3:                                 ## =>This Inner Loop Header: Depth=1
	vpor	ymm0, ymm0, ymmword ptr [rdi + rax]
	add	rax, 32
	cmp	rax, rbx
	jbe	LBB0_3
## %bb.4:
	vpmovmskb	r8d, ymm0
	cmp	rax, rsi
	jb	LBB0_6
	jmp	LBB0_17
LBB0_1:
	xor	r8d, r8d
	xor	eax, eax
	cmp	rax, rsi
	jae	LBB0_17
LBB0_6:
	mov	r10, rsi
	sub	r10, rax
	xor	ecx, ecx
	cmp	r10, 32
	jb	LBB0_15
## %bb.7:
	mov	r9, r10
	and	r9, -32
	lea	rbx, [r9 - 32]
	mov	rcx, rbx
	shr	rcx, 5
	inc	rcx
	mov	r11d, ecx
	and	r11d, 1
	test	rbx, rbx
	je	LBB0_8
## %bb.9:
	lea	rbx, [rax + rdi + 56]
	mov	r14, r11
	sub	r14, rcx
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	vpxor	xmm1, xmm1, xmm1
	vpxor	xmm2, xmm2, xmm2
	vpxor	xmm3, xmm3, xmm3
	.p2align	4, 0x90
LBB0_10:                                ## =>This Inner Loop Header: Depth=1
	vpmovsxbd	ymm4, qword ptr [rbx + rcx - 56]
	vpor	ymm0, ymm0, ymm4
	vpmovsxbd	ymm4, qword ptr [rbx + rcx - 48]
	vpor	ymm1, ymm1, ymm4
	vpmovsxbd	ymm4, qword ptr [rbx + rcx - 40]
	vpmovsxbd	ymm5, qword ptr [rbx + rcx - 32]
	vpor	ymm2, ymm2, ymm4
	vpor	ymm3, ymm3, ymm5
	vpmovsxbd	ymm4, qword ptr [rbx + rcx - 24]
	vpor	ymm0, ymm0, ymm4
	vpmovsxbd	ymm4, qword ptr [rbx + rcx - 16]
	vpor	ymm1, ymm1, ymm4
	vpmovsxbd	ymm4, qword ptr [rbx + rcx - 8]
	vpmovsxbd	ymm5, qword ptr [rbx + rcx]
	vpor	ymm2, ymm2, ymm4
	vpor	ymm3, ymm3, ymm5
	add	rcx, 64
	add	r14, 2
	jne	LBB0_10
## %bb.11:
	test	r11, r11
	je	LBB0_13
LBB0_12:
	add	rcx, rax
	vpmovsxbd	ymm4, qword ptr [rdi + rcx + 24]
	vpmovsxbd	ymm5, qword ptr [rdi + rcx + 16]
	vpor	ymm3, ymm3, ymm4
	vpor	ymm2, ymm2, ymm5
	vpmovsxbd	ymm4, qword ptr [rdi + rcx + 8]
	vpor	ymm1, ymm1, ymm4
	vpmovsxbd	ymm4, qword ptr [rdi + rcx]
	vpor	ymm0, ymm0, ymm4
LBB0_13:
	vpor	ymm1, ymm1, ymm3
	vpor	ymm0, ymm0, ymm2
	vpor	ymm0, ymm0, ymm1
	vextracti128	xmm1, ymm0, 1
	vpor	xmm0, xmm0, xmm1
	vpshufd	xmm1, xmm0, 78          ## xmm1 = xmm0[2,3,0,1]
	vpor	xmm0, xmm0, xmm1
	vpshufd	xmm1, xmm0, 229         ## xmm1 = xmm0[1,1,2,3]
	vpor	xmm0, xmm0, xmm1
	vmovd	ecx, xmm0
	cmp	r10, r9
	je	LBB0_16
## %bb.14:
	add	rax, r9
	.p2align	4, 0x90
LBB0_15:                                ## =>This Inner Loop Header: Depth=1
	movsx	ebx, byte ptr [rdi + rax]
	or	ecx, ebx
	inc	rax
	cmp	rsi, rax
	jne	LBB0_15
LBB0_16:
	and	ecx, 128
LBB0_17:
	xor	eax, eax
	or	ecx, r8d
	sete	al
	mov	qword ptr [rdx], rax
	lea	rsp, [rbp - 16]
	pop	rbx
	pop	r14
	pop	rbp
	vzeroupper
	ret
LBB0_8:
	vpxor	xmm0, xmm0, xmm0
	xor	ecx, ecx
	vpxor	xmm1, xmm1, xmm1
	vpxor	xmm2, xmm2, xmm2
	vpxor	xmm3, xmm3, xmm3
	test	r11, r11
	jne	LBB0_12
	jmp	LBB0_13
                                        ## -- End function

.subsections_via_symbols
