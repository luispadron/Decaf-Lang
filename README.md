# Decaf-Lang

Decaf a "language" developed @ University of Michigan.

## Example Decaf program

```c
int factorial(int n) {
  if (n <=1 ) return 1;
  return n*factorial(n-1);
}

void main() {
   int n;
   for (n = 1; n <= 15; n = n + 1)
      Print("Factorial(", n , ") = ", factorial(n), "\n");
}
```

## Caveats

*If you are a current student at UM and are taking the compiler course in which you need to develop this language, do not break the rules and look at the source code for this. ❤️*
