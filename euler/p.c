#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define f(a,b) a##b
#define g(a)   #a
#define h(a) g(a)

int b_main(){
        printf("%s\n",h(f(1,2)));
        printf("%s\n",g(f(1,2)));
        return 0;
}

int a_main(){
  float a = 12.5;
  printf("%d\n", a);
  printf("%d\n", *(int *)&a);
  return 0;
}

int max(int x, int y){
    return (x > y) ? x : y;
}

int main()
{
    int day,month,year;
    printf("Enter the date (dd-mm-yyyy) format including -'s:");
    scanf("%d-%d-%d",&day,&month,&year);
    printf("The date you have entered is %d-%d-%d\n",day,month,year);
    return 0;
}
