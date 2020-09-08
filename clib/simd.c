#include "ascii.h"

void validate_ascii_fast(const char *buf, size_t len, size_t *res) {
    *res = validate_ascii_fast_avx(buf, len);
}
