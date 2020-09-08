// +build !noasm

package simd

import "unsafe"

//go:noescape
func _validate_ascii_fast(buf, len, res unsafe.Pointer)

func ValidateAscii(v []byte) bool {
	if len(v) == 0 {
		return true
	}

	var res uint64

	_validate_ascii_fast(unsafe.Pointer(&v[0]), unsafe.Pointer(uintptr(len(v))), unsafe.Pointer(&res))
	return res != 0
}