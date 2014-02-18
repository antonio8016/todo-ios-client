//
//  todo_ios_clientTests.m
//  todo-ios-clientTests
//
//  Created by Antonio Rodriguez on 2/17/14.
//  Copyright (c) 2014 TD. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TRVSMonitor/TRVSMonitor.h>

#import "TDItem.h"

@interface todo_ios_clientTests : XCTestCase

@end

@implementation todo_ios_clientTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    TRVSMonitor *monitor = [TRVSMonitor monitor];
    [TDItem all:^(NSArray *items, NSError *error) {
        for (TDItem *item in items) {
            NSLog(@"Item: %@", item.name);
        }
        [monitor signal];
        
    }];
    [monitor wait];
}

@end
