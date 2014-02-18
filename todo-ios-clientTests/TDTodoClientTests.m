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

@interface TDTodoClientTests : XCTestCase

@end

@implementation TDTodoClientTests

- (void)setUp
{
    [super setUp];
    [NSRConfig defaultConfig].appURL = @"http://todo-rest-api.herokuapp.com";
    [NSRConfig defaultConfig].usesWrappersInSerialization = NO;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReturnAll
{
    TRVSMonitor *monitor = [TRVSMonitor monitor];
    [TDItem remoteAllAsync:^(NSArray *allItems, NSError *error) {
        for (TDItem *item in allItems) {
            NSLog(@"Item name: %@", item.name);
            NSLog(@"Item id: %@", item.remoteID);
        }
        [monitor signal];
    }];
    [monitor wait];
}

- (void)testReturnOne
{
    TRVSMonitor *monitor = [TRVSMonitor monitor];
    [TDItem remoteObjectWithID:@"5302add7c20c3c0200441889"
                         async:^(TDItem *item, NSError *error) {
        NSLog(@"Item name: %@", item.name);
        NSLog(@"Item id: %@", item.remoteID);
        [monitor signal];
    }];
    [monitor wait];
}

- (void)testAddAndRemoveOne
{
    TRVSMonitor *monitor = [TRVSMonitor monitor];
    TDItem *item = [[TDItem alloc] init];
    item.name = [NSString stringWithFormat:@"note at %@", [NSDate date]];
    [item remoteCreateAsync:^(NSError *error) {
        if (!error) {
            [item remoteDestroyAsync:^(NSError *error) {
                NSLog(@"Destroy error: %@", error);
                [monitor signal];
            }];
        }
    }];
    [monitor wait];
}

- (void)testEdit
{
    TRVSMonitor *monitor = [TRVSMonitor monitor];
    TDItem *item = [[TDItem alloc] init];
    item.name = [NSString stringWithFormat:@"note at %@", [NSDate date]];
    [item remoteCreateAsync:^(NSError *error) {
        if (!error) {
            item.name = [NSString stringWithFormat:@"note at %@", [NSDate date]];
            [item remoteUpdateAsync:^(NSError *error) {
                NSLog(@"Destroy error: %@", error);
            }];
        }
        [monitor signal];
    }];
    [monitor wait];
}

@end
