//
//  UIView+BracketBox.m
//  BracketApp
//
//  Created by Anders Frank on 09/10/15.
//  Copyright © 2015 Pakten. All rights reserved.
//



#import <objc/runtime.h>
#import "BBNode.h"
#import "BBLayout.h"
#import "UIView+BracketBox.h"
#import "NSArray+BracketBox.h"

const void *BBNodeKey;

@implementation UIView (BracketBox)

- (BBNode *)bb_node {
    return objc_getAssociatedObject(self, &BBNodeKey);
}

- (void)setBb_node:(BBNode *)bb_node {
    objc_setAssociatedObject(self, &BBNodeKey, bb_node, OBJC_ASSOCIATION_RETAIN);
}

- (void)bb_flexLayout {
    BBNode *parent = [self bb_nodeTree];
    BBLayout *layout = [parent layoutWithMaxWidth:CGRectGetWidth(self.bounds)];
    [layout apply:self];
}

- (BBNode *)bb_nodeTree {
    if (self.hidden || !self.bb_node) {
        return nil;
    }
    BBNode *node = [self bb_node];
    __weak __typeof(self) weakSelf = self;
    if ([self isKindOfClass:[UILabel class]] || [self isKindOfClass:[UIButton class]]) {
        node.measure = ^CGSize(CGFloat width) {
            return [weakSelf sizeThatFits:CGSizeMake(width, NAN)];
        };
    }
    node.children = [self.subviews bb_map:^id(UIView *subview) {
        return [subview bb_nodeTree];
    }];
    return node;
}

@end
