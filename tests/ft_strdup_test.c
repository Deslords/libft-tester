#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *ft_strdup(const char *s1);

int main(void) {
    const char *src = "duplicate me";
    char *d = ft_strdup(src);
    if (!d) {
        printf("FAIL ft_strdup: returned NULL\n");
        return 1;
    }
    if (strcmp(d, src) != 0) {
        printf("FAIL ft_strdup: content mismatch (got: %s)\n", d);
        free(d);
        return 1;
    }
    if (d == src) {
        printf("FAIL ft_strdup: returned same pointer\n");
        free(d);
        return 1;
    }
    free(d);
    printf("PASS ft_strdup\n");
    return 0;
}
