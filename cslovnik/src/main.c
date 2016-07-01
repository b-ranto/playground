/*
 * This program is licensed under GNU/GPLv3.
 * See http://www.gnu.org/licenses/gpl.html for details
 *
 */

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/mman.h>
#include <string.h>
#include <fcntl.h>
#include <sys/uio.h>
#include <limits.h>

#define ABS(x) (x)<0?-1*(x):x

struct logload{
	unsigned int tsize, isize;
	int *ids;
	char *text;
};

struct _list{
	struct _list *next;
	int i;
};
typedef struct _list list;

int create_db(const char *out);
int load_db(const char *tinf, const char *dinf);
char *get_text_filename();
int translate(char *find);
int options(char opt);
void usage();
int qcmp(const void *a, const void *b);

struct logload lf = {0, 0, NULL, NULL};
char prefix[1000];
int mode;
int wlength;

int create_db(const char *out){
	int i, ofd = open(out, O_WRONLY|O_CREAT, 0640);
	if(ofd < 0){
		perror("ofd");
		return 0;
	}
	int idc = 64;
	int *db = malloc(sizeof(int) * idc);
	char cr;
	if(mode/2 %2){
		lf.isize = 0;
		cr = '\t';
	}
	else{
		lf.isize = 1;
		db[0] = 0;
		cr = '\n';
	}
	for(i = 0;i < lf.tsize - 2;i++){
		if(lf.text[i] == cr){
			if(lf.isize == idc){
				idc *= 2;
				db = realloc(db, sizeof(int) * idc);
			}
			db[lf.isize] = i + 1;
			lf.isize++;
		}
	}
	db = realloc(db, sizeof(int)*lf.isize);
	lf.ids = db;
	qsort(lf.ids, lf.isize, sizeof(int), qcmp);
	if(write(ofd, lf.ids, sizeof(int)*lf.isize) != sizeof(int)*lf.isize){
		perror("create_db write");
		close(ofd);
		return 0;
	}
	close(ofd);
	return 1;
}


int load_db(const char *tinf, const char *dinf){
	int tfd = open(tinf, O_RDONLY);
	if(tfd < 0){
		perror("tfd");
		return 0;
	}
	int fsize = lseek(tfd, 0, SEEK_END);
	void *buf;
	lseek(tfd, 0, SEEK_SET);
	if((buf = mmap(0, fsize, PROT_READ, MAP_PRIVATE, tfd, 0)) == NULL){
		perror("load_db read");
		close(tfd);
		return 0;
	}
	close(tfd);
	lf.tsize = fsize;
	lf.text = (char *)(buf);
	int dfd = open(dinf, O_RDONLY);
	if(dfd < 0){
		printf("Rebuilding db...\n");
		if(create_db(dinf))
			return 1;
		perror("dfd");
		return 0;
	}
	fsize = lseek(dfd, 0, SEEK_END);
	if((buf = mmap(0, fsize, PROT_READ, MAP_PRIVATE, dfd, 0)) == NULL){
		perror("load_db read");
		close(dfd);
		return 0;
	}
	lf.isize = 1 + fsize/(sizeof(int));
	lf.ids = (int *)(buf);
	close(dfd);

	return 1;
}


inline char *get_db_filename(){
	char *home = getenv("HOME");
	char *ret = malloc((strlen(home)+15)*sizeof(char));
	if(mode/2 % 2)
		sprintf(ret, "%s/.slovnikdb_b", home);
	else
		sprintf(ret, "%s/.slovnikdb_a", home);
	return ret;
}



inline char *get_text_filename(){
	char *ret = malloc((strlen(prefix)+32)*sizeof(char));
	if(mode/2 % 2)
		sprintf(ret, "%s../share/slovnik/slovnik.txt", prefix);
	else
		sprintf(ret, "%s../share/slovnik/slovnik.txt", prefix);
	return ret;
}


inline int cmp(char *a, char *b){
	register int i = 0;
	// wlength is global variable
	while(i < wlength && a[i] == b[i])
		i++;
	return a[i] - b[i];
}


int scmp(char *a, char *b){
	int i;
	for(i=0;a[i] != '\n' && b[i] != '\n';i++){
		if(a[i] < b[i]){
			return -1;
		}
		if(a[i] > b[i]){
			return 1;
		}
	}
	if(a[i] != '\n')
		return 1;
	if(b[i] != '\n')
		return -1;
	return 0;
}


int qcmp(const void *a, const void *b){
	return scmp(lf.text + (*(const int*)a), lf.text + (*(const int*)b));;
}


inline int length(char *s){
	int ln = 0;
	while(s[ln] != '\n')
		ln++;
	return ln + 1;
}


inline int get_move(char *s){
	int m = 0;
	if(mode/2 %2){
		while(s[m] != '\n')
			m--;
		m++;
	}
	return m;
}


inline int find_dbound(int j, char *find, int b){
	int bd = b;
	int df = 1;
	int bu = j;
	int i = j;
	int c1, c2;
	while(i >= bd && !cmp(find, lf.text + lf.ids[i])){
		i -= df;
		df *= 2;
	}
	bd = bd>i?bd:i;
	bu = i + df/2;
	while(ABS(bu - bd) > 1){
		i = (bu+bd)/2;
		c1 = cmp(find, lf.text + lf.ids[i]);
		if(c1 == 0)
			bu = i;
		else
			bd = i;
	}
	return cmp(find, lf.text + lf.ids[bd]) == 0?bd:bu;
}


inline int find_ubound(int j, char *find, int b){
	int bu = b;
	int df = 1;
	int bd = j;
	int i = j;
	int c;
	while(i <= bu && !cmp(find, lf.text + lf.ids[i])){
		i += df;
		df += 2;
	}
	bu = i;
	while(ABS(bu - bd) > 1){
		i = (bu+bd)/2;
		c = cmp(find, lf.text + lf.ids[i]);
		if(c == 0)
			bd = i;
		else
			bu = i;
	}
	return cmp(find, lf.text + lf.ids[bu]) == 0?bu:bd;
}


inline void print(char *buf){
	if(mode/2 %2){
		while(*buf != '\n')
			buf--;
		buf++;
	}
	while(*buf != '\t'){
		printf("%c", *buf);
		buf++;
	}
	buf++;
	printf(" - ");
	while(*buf != '\n'){
		printf("%c", *buf);
		buf++;
	}
	printf("\n");
}


inline void neighbour_lookup(int j, char *find, int bd, int bu){
	// Logarithmic searches for lower and upper bounds for search
	int d = find_dbound(j, find, bd);
	int u = find_ubound(j, find, bu) + 1;
/*	Older linear (but more stable) method to find the bounds for search
	while(d >= bd && !cmp(find, lf.text + lf.ids[d])){
		d--;
	}
	d++;
	while(u <= bu && !cmp(find, lf.text + lf.ids[u])){
		u++;
	}*/
	int i, ln, iovcnt = u - d;
	int fback = iovcnt > IOV_MAX;
	if(!fback){
		struct iovec *iov = malloc(sizeof(struct iovec)*iovcnt);

		for(i = 0;i < iovcnt;i++){
				iov[i].iov_base = lf.text + lf.ids[d+i];
			ln = get_move(iov[i].iov_base);
			iov[i].iov_base += ln;
			iov[i].iov_len = length(lf.text + lf.ids[d+i]) - ln;
		}
		if(writev(1, iov, iovcnt) == -1)
			fback = 1;
	}
	if(fback){
		fprintf(stderr, "WARNING: using slower fallback output method.\n");
		for(i = 0;i < iovcnt;i++)
			print(lf.text + lf.ids[d + i]);
	}
}


int translate(char *find){
	wlength = strlen(find);
	find[wlength] = (mode/2 % 2)?'\n':'\t';
	register int bu, bd, j;

	if(mode % 2 == 0) //Exact match
		wlength--;

	j = lf.isize / 2;
	bd = 0;
	bu = lf.isize - 1;
	while(1){
		int t = cmp(find, lf.text + lf.ids[j]);
		if(t == 0){
			// Look up and output all the neighbours
			neighbour_lookup(j, find, bd, bu);
			break;
		}
		if(j == bu || j == bd){
			// No match
			break;
		}
		if(t < 0){
			bu = j;
			j = (bu + bd) / 2;
		}
		if(t > 0){
			bd = j;
			j = ((bu + bd) / 2);
		}
	}
	return 0;
}


inline int options(char opt){
	if(opt == 'e' && mode % 2 == 0)
		return 1;
	if(opt == 'r' && mode/2 % 2 == 0)
		return 2;
	return 0;
}


inline void usage(){
	fprintf(stderr, "Usage: slovnik [switch1 switch2 ...] word1 word2 ...\n");
	fprintf(stderr, "  -e        exact match\n");
	fprintf(stderr, "  -r        reverse translation\n");
}


int main(int argc, char *argv[]){
	int i, tmp;
	mode = 0;
	tmp = readlink("/proc/self/exe", prefix, 1000);
	if(tmp == -1){
		fprintf(stderr, "Can't find prefix.\n");
		perror("readlink");
		return 1;
	}
	while(prefix[tmp] != '/')
		tmp--;
	prefix[tmp+1] = '\0';
	if(argc<2){
		usage();
		return 1;
	}
	for(i=1;i < argc;i++){
		if(argv[i][0] == '-' && argv[i][2] == '\0'){
			tmp = options(argv[i][1]);
			if(tmp == 0){
				fprintf(stderr, "Wrong usage.\n\n");
				usage();
				return 3;
			}
			mode += tmp;
		}
	}

	char *tx_name = get_text_filename();
	char *db_name = get_db_filename();
	if(!load_db(tx_name, db_name))
		return 4;
#ifdef FORK
	if(fork()){
		i = 1;
		argc /= 2;
	}
	else
		i = argc / 2;
#else
	i = 1;
#endif
	for(;i < argc;i++){
		if(argv[i][0] != '-' || argv[i][2] != '\0'){
			printf("----- %s -----\n", argv[i]);
			translate(argv[i]);
		}
	}
	free(tx_name);
	free(db_name);
	munmap(lf.text, lf.tsize);
	munmap(lf.ids, lf.isize);
	return 0;
}
