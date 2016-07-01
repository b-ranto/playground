#include <stdio.h>

int main(){
	int free[1000000];
	for(int i = 0;i < 1000000;i++)
		free[i] = 1;
	long long int t, count, max = 0, max_val = 0;
	for(long long int i = 2;i < 1000000;i++){
//		printf("%d\n", i);
		if(free[i]){
			count = 0;
			t = i;
			while(t != 1){
				if(t % 2)
					t = 3*t+1;
				else
					t = t/2;
				if(t < 1000000)
					free[t] = 0;
				count++;
			}
			if(count > max){
				max = count;
				max_val = i;
			}
		}
	}
	printf("%ld - %ld\n", max, max_val);
	return 0;
}
