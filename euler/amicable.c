#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int divisor_sum(int n){
	int d = 1;
	int max = (int)sqrt(n);
	for(int i = 2;i <= max;i++){
		if(n % i == 0){
			if(n/i != i)
				d += (i+(n/i));
			else
				d += i;
		}
	}
	return d;
}

int nat_main(void){
	int div_sum[51000], i;
//	for(i = 0;i < 10000;i++)
//		wasnt_there[i] = 1;
	for(i = 1;i < 51000;i++){
		div_sum[i] = divisor_sum(i);
	}
	printf("%d - %d\nstill fine\n", div_sum[220], div_sum[div_sum[220]]);
	int result = 0;
	for(i = 2;i < 10000;i++){
		if(i == div_sum[div_sum[i]] && div_sum[i] != i)
			result += i;
	}
	printf("%d\n", result);
	return 0;
}

int main(void){
	int abund[28124], abu_siz = 0, is_build[28124];
	for(int i = 1;i < 28124;i++){
		if(i < divisor_sum(i)){
			abund[abu_siz] = i;
			abu_siz++;
		}
		is_build[i] = 0;
	}
	for(int i = 0;i < abu_siz;i++){
		for(int j = 0;j < abu_siz;j++){
			if(abund[i]+abund[j] < 28124)
				is_build[abund[i]+abund[j]] = 1;
		}
	}
	int ret = 0;
	for(int i = 1;i < 28124;i++){
		if(!is_build[i])
			ret += i;
	}
	printf("%d\n", ret);
	return 0;
}
