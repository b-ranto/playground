#include <stdio.h>
#include <math.h>

int isprime(int n){
	if(n < 1)
		return 0;
	int max = (int)sqrt(n);
	for(int i = 2;i <= max;i++)
		if(n % i == 0)
			return 0;
	return 1;
}

int main(void){
	int a = 0, b = 0, mc = 0, mca = 0, mcb = 0, n;
	for(a = -999;a < 1000;a++){
		for(b = -999;b < 1000;b++){
			n = 0;
//			printf("%d, %d\n", a, b);
			while(isprime(n*n + a*n + b))
			       n++;
			if(n > mc){
				mc = n;
				mca = a;
				mcb = b;
			}
		}
	}
	printf("n^2 + %d*n + %d\n", mca, mcb);
	return 0;
}
