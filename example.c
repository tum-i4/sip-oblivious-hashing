#include <stdio.h>
void f3(){
	printf("f3 is called\n");
}
void f4(){
	int a =21;
 	int b =4;
	for(int c=0;c<b;c++){
		a+=c;
	}
	printf("f4 is called %d\n",a);
}
void f1(){
	printf("f1 is called\n");
//	f3();
}
void f2(){
	printf("f2 is called\n");
//	f4();
}

int main(int argc, const char** argv) {	
	int a = 0;
	scanf("%d", &a);
	if (a==0){
		f3();
	} else {
	        f2();
	}
	printf("main  is called\n");
	f1();
	f4();
	return 0;
}






