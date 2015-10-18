//
//  NSArray+BracketBox.m
//  BracketApp
//
//  Created by Anders Frank on 09/10/15.
//  Copyright © 2015 Pakten. All rights reserved.
//

#import "NSArray+BracketBox.h"

@implementation NSArray (BracketBox)

- (NSArray *)bb_map:(id (^)(id))block {
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity: [self count]];
    
    for (id value in self) {
        id o = block(value);
        if (o)
            [ret addObject:o];
    }
    
    return [NSArray arrayWithArray: ret];
}

- (NSArray *)bb_filter:(BOOL (^)(id))block {
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity: [self count]];
    
    for (id value in self)
        if (block(value))
            [ret addObject: value];
    
    return [NSArray arrayWithArray: ret];
}

@end
