#include <stdio.h>
void f(){
    long x = 5;
}
void g(){
    long y;
    printf("%ld", y);
}
int main(){
    f();
    g();
    return 0;
}