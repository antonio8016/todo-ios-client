//
//  Item.m
//  todo-ios-client
//
//  Created by Antonio Rodriguez on 2/17/14.
//  Copyright (c) 2014 TD. All rights reserved.
//

#import "TDItem.h"
#import <TRVSMonitor/TRVSMonitor.h>
#import <RestKit.h>

@implementation TDItem

+ (void)all:(void(^)(NSArray *items, NSError *error))allItemsBlock
{
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[TDItem class]];
    [mapping addAttributeMappingsFromArray:@[@"name"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodAny
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:statusCodes];
    
    NSURL *baseUrl = [NSURL URLWithString:@"http://todo-rest-api.herokuapp.com/items"];
    NSURLRequest *request = [NSURLRequest requestWithURL:baseUrl];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        NSArray *items = result.array;
        allItemsBlock(items, nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        allItemsBlock(nil, error);
    }];
    [operation start];
    
}

@end
