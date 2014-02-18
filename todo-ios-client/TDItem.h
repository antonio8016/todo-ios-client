//
//  Item.h
//  todo-ios-client
//
//  Created by Antonio Rodriguez on 2/17/14.
//  Copyright (c) 2014 TD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDItem : NSObject

@property (strong, nonatomic) NSString *name;

+ (void)all:(void(^)(NSArray *items, NSError *error))allItemsBlock;

@end
