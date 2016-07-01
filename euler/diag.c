#include <stdio.h>

int main(void){
	int sum = 1, n = 1;
	for(int i = 2;i < 1002;i += 2){
		for(int j = 0;j < 4;j++){
			printf("%d\n", n);
			n += i;
			sum += n;
		}
	}
	printf("%d\n", sum);
}
