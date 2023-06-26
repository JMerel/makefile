#include "stdio.h" //printf

#include "foo/foo.h"
#include "bar/bar.h"
#include "macros.h"

int main(){
	foo();
	bar();

	printf(MACRO);
	printf(ABC);
	printf("\n");

	return 0;
}
