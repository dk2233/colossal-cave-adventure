#ifdef AMIGA
#define _TIME_
#include "exec/types.h"
#include "intuition/intuition.h"



#define INTUITIONREV 1

struct IntuitionBase *IntuitionBase = NULL;

fDATIME(X,Y)int *X, *Y; {
static int GOTX = 0, GOTY;
	if(GOTX == 0) {
		IntuitionBase = (struct IntuitionBase *)
			OpenLibrary("intuition.library", INTUITIONREV);
		if (IntuitionBase == NULL) {
			printf("Can't open library.\n");
			exit(FALSE);
			}
		CurrentTime(&GOTX, &GOTY);
		CloseLibrary(IntuitionBase);
		}
	GOTY += 654321;
	if(GOTY >= 1000000) {GOTX += 1; GOTY -= 1000000;}
	*X = GOTX;
	*Y = GOTY;
}
#endif



#ifndef _TIME_
#include "sys/time.h"
#include "misc.h"
#import <Foundation/Foundation.h>
#include <stdio.h>

void fGetDateTime(long *X, long  *Y) {
	struct timeval now;
	gettimeofday(&now, 0);
	*X = now.tv_sec;
	*Y = now.tv_usec;
    printf(" sec %ld usec %ld ",*X,*Y);
}
#endif
