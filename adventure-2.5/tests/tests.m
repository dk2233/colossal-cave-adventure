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
    LNPOSN = 0;
    LineLength = 8;
    strcpy(INLINE,"abc723");
    ret = fGETNUM(K);
    NSLog(@"\n \n ret %ld \n Line %s \n",ret,INLINE );
    XCTAssertEqual(ret, 0);
    
    
}


-(void)testIsGetnum723{
    // test what if letter not digit
    long K = 0;
    long ret;
    LNPOSN = 3;
    LineLength = 8;
    strcpy(INLINE,"abc723");
    ret = fGETNUM(K);
    NSLog(@"\n \n ret %ld \n Line %s \n",ret,INLINE );
    XCTAssertEqual(ret, 723);
    
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
