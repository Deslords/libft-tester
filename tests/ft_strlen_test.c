#include <stdio.h>
#include <stddef.h>

size_t ft_strlen(const char *s);

int main(void) {
    struct { const char *s; size_t expected; } cases[] = {
        {"", 0},
        {"hello", 5},
        {"abc\0def", 3},
    };
    for (size_t i = 0; i < sizeof(cases)/sizeof(cases[0]); ++i) {
        size_t r = ft_strlen(cases[i].s);
        if (r != cases[i].expected) {
            printf("FAIL ft_strlen: input=\"%s\" expected=%zu got=%zu\n", cases[i].s, cases[i].expected, r);
            return 1;
        }
    }
    printf("PASS ft_strlen\n");
    return 0;
}
