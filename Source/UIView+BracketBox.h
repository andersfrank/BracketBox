//
//  UIView+BracketBox.h
//  BracketApp
//
//  Created by Anders Frank on 09/10/15.
//  Copyright © 2015 Pakten. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBNode;

@interface UIView (BracketBox)

@property (nonatomic) BBNode *bb_node;

- (void)bb_flexLayout;

@end
