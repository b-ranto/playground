#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <errno.h>

struct _person{
	char name[256];
	char event[256];
	int day;
	int month;
	int per;
};
typedef struct _person person;

person *read_entry(FILE *f){
	person *ret = malloc(sizeof(person));
	int i = fscanf(f, "%s %s %d %d %d", ret->name, ret->event, &(ret->day), &(ret->month), &(ret->per));

	if(i != 5)
		return NULL;
	return ret;
}

int main(){
	char *home = getenv("HOME");
	person *got;
	time_t rawtm;
	struct tm *ti;
	char *file = malloc((strlen(home) + 10)*sizeof(char));
	sprintf(file, "%s/.vyrocia", home);
	time(&rawtm);
	ti = localtime(&rawtm);

	FILE *f = fopen(file, "r");
	if(!f){
		perror(file);
		return 1;
	}
	got = read_entry(f);
	while(got != NULL){
		if(got->day == ti->tm_mday && got->month - 1 == ti->tm_mon){
			printf("MATCH FOUND\nName: %s\nEvent: %s\n", got->name, got->event);
		}
		free(got);
		got = read_entry(f);
	}

	fclose(f);
	return 0;
}
