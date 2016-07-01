#include <stdio.h>
#include <ctype.h>

//#define COND(x) (isalnum(x) || isspace(x) || x ==',' || x == '-' || x == ':' || x == '(' || x == ')' || x == '.' || x == '!' || x == '?')
#define COND(x) (isprint(x))
#define R 2

int main(){
	int inp, a = 0, data[1500];
	while(scanf("%d", &inp) != EOF){
		data[a] = inp;
		a++;
	}
	int i, cnt[129], max = 0;
	for(i=0;i<128;i++)
		cnt[i] = 0;
	for(i=R;i<a;i+=3)
		cnt[data[i]]++;
	printf("huh\n");
	for(i=0;i<128;i++){
		printf("%d\n", i);
		if(cnt[i] > cnt[max])
			max = i;
	}
	printf("%d - %f\n", max, cnt[max]/(float)a*3);
	int k, r, good;
	for(i=0;i<128;i++){
		good = 1;
		for(k=R;k < a;k+=3){
			r = data[k]^i;
			if(!COND(r))
				good = 0;
		}
		if(good)
			printf("%d - (%c, %d, %c)\n", i, i, 68 ^ i, 68 ^ i);
	}
	char *pass = "god";
	int sum = 0;
	for(i=0;i<a;i++){
		sum += data[i] ^ pass[i % 3];
		printf("%c", data[i] ^ pass[i % 3]);
	}
	printf("\n%d\n", sum);
	return 0;
}
