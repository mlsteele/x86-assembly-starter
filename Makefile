.PHONY: all build clean

all: build

build:
	gcc -m32 -c foobar.S
	gcc -m32 -o foobar foobar.o -nostartfiles -nostdlib -nodefaultlibs
	objdump -S foobar.o > foobar.asm

clean:
	rm -f foobar.o
	rm -f foobar
