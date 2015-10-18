//
//  BBLayout.h
//  BracketApp
//
//  Created by Anders Frank on 07/10/15.
//  Copyright © 2015 Pakten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BBLayout : NSObject

@property (nonatomic, readonly) CGRect frame;
@property (nonatomic, readonly) NSArray *children;

- (instancetype)initWithFrame:(CGRect)frame children:(NSArray *)children;

- (void)apply:(UIView *)view;

@end
