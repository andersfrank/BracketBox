//
//  BBLayout.m
//  BracketApp
//
//  Created by Anders Frank on 07/10/15.
//  Copyright © 2015 Pakten. All rights reserved.
//

#import "BBLayout.h"
#import "NSArray+BracketBox.h"
#import "UIView+BracketBox.h"

@implementation BBLayout

- (instancetype)initWithFrame:(CGRect)frame children:(NSArray *)children {
    self = [super init];
    if (self) {
        _frame = frame;
        _children = children;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString new];
    [string appendString:NSStringFromCGRect(self.frame)];
    [self.children enumerateObjectsUsingBlock:^(BBLayout *layout, NSUInteger idx, BOOL *stop) {
        [string appendString:[NSString stringWithFormat:@"\n  %@", [layout description]]];
    }];
    return [NSString stringWithString:string];
}

- (void)apply:(UIView *)view {
    [self apply:view offset:view.frame.origin];
}

- (void)apply:(UIView *)view offset:(CGPoint)offset {
    CGRect frame = CGRectIntegral(CGRectOffset(self.frame, offset.x, offset.y));
    if (!isnan(frame.origin.x) && !isnan(frame.origin.y) && !isnan(frame.size.width) && !isnan(frame.size.height)) {
        view.frame = frame;
    }

    // Filter out hidden subviews and views missing nodes.
    NSArray *subviews = [view.subviews bb_filter:^BOOL(UIView *subview) {
        return !subview.hidden && subview.bb_node;
    }];
    [self.children enumerateObjectsUsingBlock:^(BBLayout *layout, NSUInteger idx, BOOL *stop) {
        UIView *subview = subviews[idx];
        [layout apply:subview offset:CGPointZero];
    }];
}

@end
