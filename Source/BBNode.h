//
//  BBNode.h
//  BracketApp
//
//  Created by Anders Frank on 07/10/15.
//  Copyright © 2015 Pakten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct BBEdges {
    CGFloat top, left, bottom, right;
} BBEdges;

UIKIT_STATIC_INLINE BBEdges BBEdgesMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    BBEdges edges = {top, left, bottom, right};
    return edges;
}

UIKIT_STATIC_INLINE BBEdges BBEdgesMakeUniform(CGFloat value) {
    BBEdges edges = {value, value, value, value};
    return edges;
}

typedef NS_ENUM(NSInteger, BBFlexDirection) {
    BBFlexDirectionColumn,
    BBFlexDirectionColumnReverse,
    BBFlexDirectionRow,
    BBFlexDirectionRowReverse,
};

typedef NS_ENUM(NSInteger, BBJustification) {
    BBJustificationFlexStart,
    BBJustificationCenter,
    BBJustificationFlexEnd,
    BBJustificationSpaceBetween,
    BBJustificationSpaceAround,
};

typedef NS_ENUM(NSInteger, BBChildAlignment) {
    BBChildAlignmentFlexStart = 1,
    BBChildAlignmentCenter,
    BBChildAlignmentFlexEnd,
    BBChildAlignmentStretch,
};

typedef NS_ENUM(NSInteger, BBSelfAlignment) {
    BBSelfAlignmentAuto,
    BBSelfAlignmentFlexStart,
    BBSelfAlignmentCenter,
    BBSelfAlignmentFlexEnd,
    BBSelfAlignmentStretch,
};

@class BBLayout;

@interface BBNode : NSObject

@property (nonatomic) BOOL wrap;
@property (nonatomic) CGFloat flex;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) BBFlexDirection flexDirection;
@property (nonatomic) BBEdges margin;
@property (nonatomic) CGFloat leftMargin;
@property (nonatomic) CGFloat rightMargin;
@property (nonatomic) CGFloat topMargin;
@property (nonatomic) CGFloat bottomMargin;
@property (nonatomic) BBEdges padding;
@property (nonatomic) CGFloat leftPadding;
@property (nonatomic) CGFloat rightPadding;
@property (nonatomic) CGFloat topPadding;
@property (nonatomic) CGFloat bottomPadding;
@property (nonatomic) BBJustification justification;
@property (nonatomic) BBSelfAlignment selfAlignment;
@property (nonatomic) BBChildAlignment childAlignment;
@property (nonatomic) NSArray *children;

@property (nonatomic, copy) CGSize (^measure)(CGFloat width);

- (BBLayout *)layoutWithMaxWidth:(CGFloat)maxWidth;

@end

