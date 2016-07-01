#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PERM_LEV 7

int prime(int a){
	if(a == 1)
		return 0;
	int b = (int)sqrt(a);
	for(int m = 2;m <= b;m++){
		if(a % m == 0)
			return 0;
	}
	return 1;
}

void permute(char res[PERM_LEV+1], int full[PERM_LEV], int level){
	if(level == PERM_LEV){
		res[PERM_LEV] = '\0';
		if(prime(strtol(res, NULL, 10)))
			printf("%s\n",res);
		return;
	}
	for(int i = 0;i < PERM_LEV;i++){
		if(full[i] != 1){
			res[level] = 49 + i;
			full[i] = 1;
			permute(res, full, level + 1);
			full[i] = 0;
		}
	}
}

int main(){
	char r[PERM_LEV+1];
	int full[9] = {0,0,0,0,0,0,0,0,0};
	permute(r, &full[9-PERM_LEV], 0);
	return 0;
}
