#include <stdio.h>
void f3(){
	int a = 3;
	int b = a + 5;
	printf("f3 is called b=%d\n", b);
}
void f4(){
	printf("f4 is called\n");
}
void f1(){
	printf("f1 is called\n");
	f3();
}
void f2(){
	printf("f2 is called\n");
	f4();
}

int main(int argc, const char** argv) {	
	printf("main  is called\n");
	f1();
	f2();
	return 0;
}






