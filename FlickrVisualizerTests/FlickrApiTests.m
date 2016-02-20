//
//  FlickrApiTests.m
//  FlickrVisualizer
//
//  Created by Tamara Bernad on 19/02/16.
//  Copyright © 2016 Tamara Bernad. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBWFlickrService.h"
#import "FlickrKit.h"

@interface FlickrApiTests : XCTestCase

@end

@implementation FlickrApiTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testResponseNotNil {
    XCTestExpectation *expectation =
    [self expectationWithDescription:@"Expecting response from FlickrService"];
    
    TBWFlickrService *sut = [TBWFlickrService new];
    
    [sut getObjectsWithParams:@{} Success:^(id results) {
        
        XCTAssert(results != nil);
        [expectation fulfill];
        
    } failure:^(NSError *failure) {
        XCTFail();
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}
@end
