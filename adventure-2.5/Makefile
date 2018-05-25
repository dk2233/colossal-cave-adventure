# NOTE: This version of Adventure was developed by the author on private
# equipment, and has been ported to Sun for entertainment purposes only.
# The author (Don Woods) retains full rights to the work.

GNUSTEP = `gnustep-config --objc-flags` 
SOURCES=main.m init.m actions1.m actions2.m score.m misc.m datime.m
LIBRARIES:=  -lgnustep-base
CFLAGS=-Wall -Werror $(SOURCES)
LDFLAGS= `gnustep-config --objc-libs` $(LIBRARIES)
OUT=adv
OBJS=main.o \
init.o \
actions1.o \
actions2.o \
score.o \
misc.o \
datime.o



all: $(SOURCES) $(OUT)

clean: 
	rm -f *.o
	rm -f *.d
	rm -f $(OUT)


$(OUT): $(OBJS)
	gcc $^ $(LDFLAGS) -o $@

%.o : %.m 
	gcc $< -c  $(GNUSTEP) -std=c99 -o $@



main.o:		misc.h funcs.h main.h

init.o:		misc.h main.h share.h funcs.h

actions1.o:	misc.h main.h share.h funcs.h

actions2.o:	misc.h main.h share.h funcs.h

score.o:	misc.h main.h share.h

misc.o:		misc.h main.h
