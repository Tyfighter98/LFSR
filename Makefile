all: lfsr

lfsr: lfsr.o
	gcc -o $@ $+

lfsr.o : lfsr.s
	as -o $@ $<

clean:
	rm -vf lfsr *.o
