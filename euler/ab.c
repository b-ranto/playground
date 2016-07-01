#include <stdio.h>
//#include <math.h>

unsigned int pow(int a, int b, int *of){
	unsigned int result = 1;
	*of = 0;
	for(int i = 0;i < a;i++){
		if(result*b < result)
			(*of)++;
		result *= b;
	}
	return result;
}

int main(){
	int count = 0, oflow = 0;
	for(int i = 2;i < 101;i++){
		for(int j = 2;j < 101;j++){
			for(int k = 2;k < 101;k++){
				for(int l = 2;l < 101; l++){
					if(i != k && j != l && pow(i,j) == pow(k,l))
						printf("(%d, %d), %d\n",i, j, (int)pow(i,j));
				}
			}
		}
	}
//	printf("%d\n", count);
	return 0;
}
