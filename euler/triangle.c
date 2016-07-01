#include <stdio.h>
#include <stdlib.h>

typedef struct _node{
	int value;
	struct _node *left;
	struct _node *right;
} node;

void find_it(node *n){
	if(n->left == NULL || n->right == NULL)
		return;
	find_it(n->left);
	find_it(n->right);
	if(n->left->value > n->right->value)
		n->value += n->left->value;
	else
		n->value += n->right->value;
	free(n->left);
	n->left = NULL;
	free(n->right);
	n->right = NULL;
}

int main(){
	node *root = malloc(sizeof(node));

	root->left = NULL;
	root->right = NULL;

	int loaded = 0, i;
	int count = 1,runner = 0; // root
	node **ins = malloc(sizeof(node *)*count);
	node **new;
	ins[0] = root;
	while(scanf("%d", &loaded) == 1){
		if(runner == count){
			new = malloc(sizeof(node *) * (count+1));
			ins[0]->left = malloc(sizeof(node));
			ins[0]->right = malloc(sizeof(node));
			new[0] = ins[0]->left;
			new[0]->left = NULL;
			new[0]->right = NULL;
			new[1] = ins[0]->right;
			new[1]->left = NULL;
			new[1]->right = NULL;
			for(i = 1;i < count;i++){
				ins[i]->left = ins[i-1]->right;
				ins[i]->right = malloc(sizeof(node));
				new[i+1] = ins[i]->right;
				new[i+1]->left = NULL;
				new[i+1]->right = NULL;
			}
			free(ins);
			ins = new;
			runner = 0;
			count++;
		}
		ins[runner]->value = loaded;
		runner++;
	}
	find_it(root);
	printf("%d\n", root->value);
	free(root);
	root = NULL;
	free(ins);
	new = NULL;
	ins = NULL;
	return 0;
}
