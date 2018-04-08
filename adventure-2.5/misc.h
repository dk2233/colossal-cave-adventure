
#ifndef _MISC_H
#define _MISC_H

#define READ_MODE "r"
#define WRITE_MODE "w"

extern int carry(void );
extern int discard(long);
extern int attack(void);
extern int throw(void);
extern int feed(void);
extern int fill(void);

extern void initialise(void );
extern void score(long );
extern int action(long);


extern void fSPEAK(long);
#define SPEAK(N) fSPEAK(N)
extern void fPSPEAK(long,long);
#define PSPEAK(MSG,SKIP) fPSPEAK(MSG,SKIP)
extern void RandomMessageSpeakFromSect6(long);

extern void fSETPRM(long,long,long);
#define SETPRM(FIRST,P1,P2) fSETPRM(FIRST,P1,P2)
extern void fGETIN(long*,long*,long*,long*);
#define GETIN(WORD1,WORD1X,WORD2,WORD2X) fGETIN(&WORD1,&WORD1X,&WORD2,&WORD2X)
extern long fYES(long,long,long);
#define YES_ADV(X,Y,Z) fYES(X,Y,Z)
extern long fGETNUM(long);
#define GETNUM(K) fGETNUM(K)
extern long fGETTXT(long,long,long,long);
#define GETTXT(SKIP,ONEWRD,UPPER,HASH) fGETTXT(SKIP,ONEWRD,UPPER,HASH)
extern long funcMakeWorD(long);

extern void fPUTTXT(long,long*,long,long);
#define PUTTXT(WORD,STATE,CASE,HASH) fPUTTXT(WORD,&STATE,CASE,HASH)
extern void fSHFTXT(long,long);
#define SHFTXT(FROM,DELTA) fSHFTXT(FROM,DELTA)
extern void fTYPE0(void);
#define TYPE0() fTYPE0()
extern void fSAVWDS(long*,long*,long*,long*,long*,long*,long*);
#define SAVWDS(W1,W2,W3,W4,W5,W6,W7) fSAVWDS(&W1,&W2,&W3,&W4,&W5,&W6,&W7)
extern void fSAVARR(long*,long);
#define SAVARR(ARR,N) fSAVARR(ARR,N)
extern void fSAVWRD(long,long*);
#define SAVWRD(OP,WORD) fSAVWRD(OP,&WORD)
extern long fVOCAB(long,long);
#define VOCAB(ID,INIT) fVOCAB(ID,INIT)
extern void fDSTROY(long);
#define DSTROY(OBJECT) fDSTROY(OBJECT)
extern void fJUGGLE(long);
#define JUGGLE(OBJECT) fJUGGLE(OBJECT)
extern void fMOVE(long,long);
#define MOVE(OBJECT,WHERE) fMOVE(OBJECT,WHERE)
extern long fPUT(long,long,long);
#define PUT(OBJECT,WHERE,PVAL) fPUT(OBJECT,WHERE,PVAL)
extern void fCARRY(long,long);
#define CARRY(OBJECT,WHERE) fCARRY(OBJECT,WHERE)
extern void fDROP(long,long);
#define DROP(OBJECT,WHERE) fDROP(OBJECT,WHERE)
extern long fATDWRF(long);
#define ATDWRF(WHERE) fATDWRF(WHERE)
extern long fSETBIT(long);
#define SETBIT(BIT) fSETBIT(BIT)
extern long fTSTBIT(long,long);
#define TSTBIT(MASK,BIT) fTSTBIT(MASK,BIT)
extern long fRAN(long);
#define RAN(RANGE) fRAN(RANGE)
extern long fRNDVOC(long,long);
#define RNDVOC(CHAR,FORCE) fRNDVOC(CHAR,FORCE)
extern void fBUG(long);
#define BUG(NUM) fBUG(NUM)
extern void fMapLine(long);

extern void fTYPE(void);
#define TYPE() fTYPE()
extern void fMapInit(void);

extern void fSAVEIO(long,long,long*);
#define SAVEIO(OP,IN,ARR) fSAVEIO(OP,IN,ARR)
extern void fGetDateTime(long*,long*);
extern long fIABS(long);
#define IABS(N) fIABS(N)
extern long fMOD(long,long);
#define MOD(N,M) fMOD(N,M)


#endif
