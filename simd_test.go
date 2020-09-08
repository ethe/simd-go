package simd_test

import (
	"testing"

	"github.com/ethe/simd-go"
	"github.com/stretchr/testify/assert"
)

func TestValidAscii(t *testing.T) {
	assert.True(t, simd.ValidateAscii([]byte("test")))
	assert.False(t, simd.ValidateAscii([]byte{0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x80}))
}

func BenchmarkValidateAscii(b *testing.B) {
	test := []byte("The assembler is based on the input style of the Plan 9 assemblers, which is documented in detail elsewhere. If you plan to write assembly language, you should read that document although much of it is Plan 9-specific. The current document provides a summary of the syntax and the differences with what is explained in that document, and describes the peculiarities that apply when writing assembly code to interact with Go. The most important thing to know about Go's assembler is that it is not a direct representation of the underlying machine. Some of the details map precisely to the machine, but some do not. This is because the compiler suite (see this description) needs no assembler pass in the usual pipeline. Instead, the compiler operates on a kind of semi-abstract instruction set, and instruction selection occurs partly after code generation. The assembler works on the semi-abstract form, so when you see an instruction like MOV what the toolchain actually generates for that operation might not be a move instruction at all, perhaps a clear or load. Or it might correspond exactly to the machine instruction with that name. In general, machine-specific operations tend to appear as themselves, while more general concepts like memory move and subroutine call and return are more abstract. The details vary with architecture, and we apologize for the imprecision; the situation is not well-define.")
	assert.Greater(b, len(test), 1024)
	test = test[:1024]
	b.Run("simd", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			t := simd.ValidateAscii(test)
			if !t {
				panic("error")
			}
		}
	})

	b.Run("raw", func(b *testing.B) {
		for i := 0; i < b.N; i++ {
			t := ValidateAsciiRaw(test)
			if !t {
				panic("error")
			}
		}
	})
}

func ValidateAsciiRaw(s []byte) bool {
	if len(s) == 0 {
		return true
	}
	for _, r := range s {
		if r > 0x7f {
			return false
		}
	}
	return true
}
