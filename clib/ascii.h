#include <stdbool.h>   // c99 bool
#include <stddef.h>    // size_t
#include <x86intrin.h>

static bool validate_ascii_fast_avx(const char *src, size_t len) {
  size_t i = 0;
  __m256i has_error = _mm256_setzero_si256();
  if (len >= 32) {
    for (; i <= len - 32; i += 32) {
      __m256i current_bytes = _mm256_loadu_si256((const __m256i *)(src + i));
      has_error = _mm256_or_si256(has_error, current_bytes);
    }
  }
  int error_mask = _mm256_movemask_epi8(has_error);

  char tail_has_error = 0;
  for (; i < len; i++) {
    tail_has_error |= src[i];
  }
  error_mask |= (tail_has_error & 0x80);

  return !error_mask;
}
