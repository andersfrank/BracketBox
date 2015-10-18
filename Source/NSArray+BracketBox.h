//
//  NSArray+BracketBox.h
//  BracketApp
//
//  Created by Anders Frank on 09/10/15.
//  Copyright © 2015 Pakten. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BracketBox)

- (NSArray *)bb_map:(id (^)(id))block;
- (NSArray *)bb_filter:(BOOL (^)(id))block;

@end
