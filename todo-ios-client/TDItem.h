//
//  Item.h
//  todo-ios-client
//
//  Created by Antonio Rodriguez on 2/17/14.
//  Copyright (c) 2014 TD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSRails/NSRails.h>

@interface TDItem : NSRRemoteObject

@property (strong, nonatomic) NSString *name;

@end
