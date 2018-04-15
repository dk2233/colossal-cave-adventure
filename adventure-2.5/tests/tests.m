//
//  tests.m
//  tests
//
//  Created by Daniel Kucharski on 06.04.2018.
//  Copyright © 2018 code masterss. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "misc.h"
#import "main.h"


@interface tests : XCTestCase

@end

@implementation tests

- (void)setUp {
    [super setUp];

    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    int K = 1;
    NSLog(@" test 1 ");
    XCTAssertEqual(K, 1,@"aaa" );
}

-(void)testIsGetnum{
    long K = 0;
    long ret;
    
    strcpy(INLINE," abc");
    ret = fGETNUM(K);
    NSLog(@"\n \n ret %ld \n\n",ret );
    XCTAssertEqual(ret, 0);
    
    
}

-(void)testIsGetnumA{
    // test what if letter not digit
    long K = 0;
    long ret;
    LinePosition = 0;
    LineLength = 8;
    strcpy(INLINE,"abc723");
    ret = fGETNUM(K);
    NSLog(@"\n \n ret %ld \n Line %s \n",ret,INLINE );
    XCTAssertEqual(ret, 0);
    
    
}


-(void)testIsGetnum12{
    // test what if letter not digit
    long K = 0;
    long ret;
    LinePosition = 2;
    LineLength = 8;
    //strcpy(INLINE,"abc723");
    INLINE[0]='a';
    INLINE[1]='b';
    //after coding with Mapline
    INLINE[2]=64;//0
    INLINE[3]=65;//1
    INLINE[4]=66;//2
    ret = fGETNUM(K);
    NSLog(@"\n \n ret %ld \n Line %s \n",ret,INLINE );
    XCTAssertEqual(ret, 12);
}


-(void) testDecodeWordAxe{
    //long input = 113415;
    
    long input = 12405;
    long word;
    //fPUTTXT(word, <#long *#>, <#long#>, <#long#>);
    word = funcMakeWorD(input);
    
    NSLog(@" word %ld ",word);
    
}


-(void)testMapLine{
    INLINE[0]=' ';
    INLINE[1]='A';
    INLINE[2]='X';
    INLINE[3]='E';
    INLINE[4]=' ';
    //INLINE[3]='d';
    //INLINE[4]='e';
    
    fMapLine(0);
    
    NSLog(@" word coded %s ",INLINE);
    for( int8_t i=0; INLINE[i] !=0; i++)
    {
        printf("%d,",INLINE[i]);
    }
    printf("\n\n");
    //int tab[] = {32,11,34,15};
    XCTAssertEqual(INLINE[1],11);
    XCTAssertEqual(INLINE[2],34);
    XCTAssertEqual(INLINE[3],15);
    
}

-(void)testDecodeMapping{
    INLINE[0]=' ';
    INLINE[1]=11;
    INLINE[2]=34;
    INLINE[3]=15;
    INLINE[4]=0;
    INLINE[5]=' ';
    //INLINE[3]='d';
    //INLINE[4]='e';
    LineLength = strlen(INLINE);
    printf(" line length : %ld ",LineLength);
    fTYPE();
    
    NSLog(@" word coded %s ",INLINE);
    for( int8_t i=0; INLINE[i] !=0; i++)
    {
        printf("%d,",INLINE[i]);
    }
    printf("\n\n");
    //int tab[] = {32,11,34,15};
    XCTAssertEqual(INLINE[1],'A');
    XCTAssertEqual(INLINE[2],'X');
    XCTAssertEqual(INLINE[3],'E');
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
