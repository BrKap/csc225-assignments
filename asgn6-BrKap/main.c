/*
 * Recursively computes Fibonacci numbers.
 * CSC 225, Assignment 6
 * Given code, Winter '24.
 * TODO: Complete this file.
 */
#include "fib.h"
#include <stdio.h>

int main(void) {
    int x, y;
    printf("Enter an integer: ");
    scanf("%d", &x);
    y = fib(x);
    printf("f(%d) = %d", x, y);
    return 0;
}
