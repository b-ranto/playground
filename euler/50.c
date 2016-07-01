#include <stdio.h>
#include <math.h>

int gen_next(int *inp, int count){
	int prime = 0;
	int res = inp[count];
	while(!prime){
		res++;
		int max = sqrt(res);
		prime = 1;
		for(int i = 0;inp[i] <= max && prime == 1;i++){
			if(res % inp[i] == 0)
				prime = 0;
		}
	}
	return res;
}

int prime(int n){
	int max = sqrt(n);
	for(int i = 2;i <= max;i++){
		if(n % i == 0)
			return 0;
	}
	return 1;
}

int main(){
	int primes[99991] = {2};
	primes[0] = 2;
	int count = 0;
	while(primes[count] < 49991){
		primes[++count] = gen_next(primes, count-1);
//		printf("%d\n", primes[count]);
	}
	int sum = 0;
	for(int i = 0;i <count;i++){
		sum += primes[i];
	}
	int max_sum = 0;
	printf("%d, %d, %d\n", primes[count], count, sum);
	return 0;
}
