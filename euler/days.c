#include <stdio.h>
#include <stdlib.h>

int main(void){
	int month[] = {31,28,31,30,31,30,31,31,30,31,30,31};
	int counter = 2;
	int i = 0, res = 0;
	int year = 1901;
	while(year < 2001){
		counter += month[i];
		if(year % 4 == 0 && i == 1)
		       counter++;
		if(counter % 7 == 0)
			res++;
		i++;
		if(i == 12){
			year++;
			i = 0;
		}
	}
	printf("%d\n", res);
	return 0;
}
