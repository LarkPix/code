run : main.o func.o pub.o fprintf.o lua_func.o wrap.o
	#gcc -Wl,--wrap,malloc -Wl,--wrap,free -fPIC -o run main.o  pub.o lua_func.o  libfunc.so -llua -lm -ldl
	gcc -Wl,-alias,__Z3malloc,__Z8wrap_malloc -fPIC -o run main.o  pub.o lua_func.o  libfunc.so -llua -lm -ldl

main.o : main.c func.h pub.h
	gcc -Wall -fPIC -c main.c

func.o : func.c func.h
	gcc -Wall -fPIC -c func.c

pub.o : pub.c pub.h
	gcc -Wall -fPIC -c pub.c

#fprintf.o : fprintf.c
#	cc -Wall -fPIC -c fprintf.c

lua_func.o : lua_func.c lua_func.h test.lua
	gcc -Wall -fPIC -c  lua_func.c

libfunc.so : fprintf.c func.c func.h pub.h wrap.c
	#gcc -Wl,--wrap,malloc -Wl,--wrap,free -shared func.c fprintf.c -o libfunc.so
	gcc -Wl,-alias,__Z3malloc,__Z8wrap_malloc -shared -fPIC func.c fprintf.c -o libfunc.so    

wrap.o : wrap.c
	gcc -Wall -fPIC -c wrap.c
clean :
	rm run main.o func.o pub.o
