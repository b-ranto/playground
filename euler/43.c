#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PERM_LEV 10

int regular(int d[PERM_LEV]){
	if(d[0] == 0)
		return 0;
	if(d[3] % 2 != 0)
		return 0;
	if((d[2] + d[3] + d[4]) % 3 != 0)
		return 0;
	if(d[5] % 5 != 0)
		return 0;
	if((d[4]*100 + d[5]*10 + d[6]) % 7 != 0)
		return 0;
	if((d[5]*100 + d[6]*10 + d[7]) % 11 != 0)
		return 0;
	if((d[6]*100 + d[7]*10 + d[8]) % 13 != 0)
		return 0;
	if((d[7]*100 + d[8]*10 + d[9]) % 17 != 0)
		return 0;
	return 1;
}

void permute(int res[PERM_LEV], int full[PERM_LEV], int level){
	if(level == PERM_LEV){
		if(regular(res)){
			for(int i = 0;i < PERM_LEV;i++)
				printf("%d",res[i]);
			printf("\n");
		}
		return;
	}
	for(int i = 0;i < PERM_LEV;i++){
		if(full[i] != 1){
			res[level] = i;
			full[i] = 1;
			permute(res, full, level + 1);
			full[i] = 0;
		}
	}
}

int main(){
	int r[PERM_LEV];
	int full[10] = {0,0,0,0,0,0,0,0,0,0};
	permute(r, &full[9-PERM_LEV], 0);
	return 0;
}
