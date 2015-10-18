//
//  BBNode.m
//  BracketApp
//
//  Created by Anders Frank on 07/10/15.
//  Copyright © 2015 Pakten. All rights reserved.
//

#import "BBNode.h"
#import "BBLayout.h"
#import "NSArray+BracketBox.h"
#import "Layout.h"

@interface BBNode ()

@property (nonatomic, readonly, assign) css_node_t *node;
@property (nonatomic, readonly, assign) CGRect frame;

@end

static bool alwaysDirty(void *context) {
    return true;
}

static css_node_t * getChild(void *context, int i) {
    BBNode *self = (__bridge BBNode *)context;
    BBNode *child = self.children[i];
    return child.node;
}

static css_dim_t measureNode(void *context, float width) {
    BBNode *self = (__bridge BBNode *)context;
    CGSize size = self.measure(width);
    return (css_dim_t){ size.width, size.height };
}

@implementation BBNode

- (void)dealloc {
    free_css_node(_node);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _node = new_css_node();
        _node->context = (__bridge void *)self;
        _node->is_dirty = alwaysDirty;
        _node->get_child = getChild;
        
        self.width = CSS_UNDEFINED;
        self.height = CSS_UNDEFINED;
        self.children = @[];
        self.flexDirection = BBFlexDirectionColumn;
        self.margin = BBEdgesMakeUniform(0);
        self.padding = BBEdgesMakeUniform(0);
        self.justification = BBJustificationFlexStart;
        self.selfAlignment = BBSelfAlignmentAuto;
        self.childAlignment = BBChildAlignmentStretch;
        
    }
    return self;
}

- (BBLayout *)layoutWithMaxWidth:(CGFloat)maxWidth {
    [self prepareForLayout];
    layoutNode(self.node, maxWidth, self.node->style.direction);
    NSArray *children = [self createLayoutsFromChildren:self];
    return [[BBLayout alloc] initWithFrame:self.frame children:children];
}

- (NSArray *)createLayoutsFromChildren:(BBNode *)node {
    return [node.children bb_map:^id(BBNode *child) {
        NSArray *childLayouts = [self createLayoutsFromChildren:child];
        return [[BBLayout alloc] initWithFrame:child.frame children:childLayouts];
    }];
}

- (void)prepareForLayout {
    for (BBNode *child in self.children) {
        [child prepareForLayout];
    }
    
    // Apparently we need to reset these before laying out, otherwise the layout
    // has some weird additive effect.
    self.node->layout.position[CSS_LEFT] = 0;
    self.node->layout.position[CSS_TOP] = 0;
    self.node->layout.dimensions[CSS_WIDTH] = CSS_UNDEFINED;
    self.node->layout.dimensions[CSS_HEIGHT] = CSS_UNDEFINED;
}

- (void)setChildren:(NSArray *)children {
    _children = [children copy];
    _node->children_count = (int)children.count;
}

- (CGRect)frame {
    return CGRectMake(self.node->layout.position[CSS_LEFT], self.node->layout.position[CSS_TOP], self.node->layout.dimensions[CSS_WIDTH], self.node->layout.dimensions[CSS_HEIGHT]);
}

- (void)setMeasure:(CGSize (^)(CGFloat))measure {
    _measure = [measure copy];
    _node->measure = (_measure != nil ? measureNode : NULL);
}

- (void)setFlex:(CGFloat)flex {
    self.node->style.flex = flex;
}

- (CGFloat)flex {
    return self.node->style.flex;
}

- (void)setFlexDirection:(BBFlexDirection)direction {
    self.node->style.flex_direction = (int)direction;
}

- (BBFlexDirection)flexDirection {
    return (BBFlexDirection)self.node->style.flex_direction;
}

- (void)setWrap:(BOOL)wrap {
    self.node->style.flex_wrap = wrap;
}

- (BOOL)wrap {
    return self.node->style.flex_wrap;
}

- (void)setJustification:(BBJustification)justification {
    self.node->style.justify_content = (int)justification;
}

- (BBJustification)justification {
    return (BBJustification)self.node->style.justify_content;
}

- (void)setSelfAlignment:(BBSelfAlignment)selfAlignment {
    self.node->style.align_self = (int)selfAlignment;
}

- (BBSelfAlignment)selfAlignment {
    return (BBSelfAlignment)self.node->style.align_self;
}

- (void)setChildAlignment:(BBChildAlignment)childAlignment {
    self.node->style.align_items = (int)childAlignment;
}

- (BBChildAlignment)childAlignment {
    return (BBChildAlignment)self.node->style.align_items;
}

- (void)setSize:(CGSize)size {
    self.width = size.width;
    self.height = size.height;
}

- (CGSize)size {
    return CGSizeMake(self.width, self.height);
}

- (void)setWidth:(CGFloat)width {
    self.node->style.dimensions[CSS_WIDTH] = width;
}

- (CGFloat)width {
    return self.node->style.dimensions[CSS_WIDTH];
}

- (void)setHeight:(CGFloat)height {
    self.node->style.dimensions[CSS_HEIGHT] = height;
}

- (CGFloat)height {
    return self.node->style.dimensions[CSS_HEIGHT];
}

- (void)setMargin:(BBEdges)margin {
    self.leftMargin = margin.left;
    self.rightMargin = margin.right;
    self.bottomMargin = margin.bottom;
    self.topMargin = margin.top;
}

- (BBEdges)margin {
    return BBEdgesMake(self.topMargin, self.leftMargin, self.bottomMargin, self.rightMargin);
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    self.node->style.margin[CSS_LEFT] = leftMargin;
}

- (CGFloat)leftMargin {
    return self.node->style.margin[CSS_LEFT];
}

- (void)setRightMargin:(CGFloat)rightMargin {
    self.node->style.margin[CSS_RIGHT] = rightMargin;
}

- (CGFloat)rightMargin {
    return self.node->style.margin[CSS_RIGHT];
}

- (void)setTopMargin:(CGFloat)topMargin {
    self.node->style.margin[CSS_TOP] = topMargin;
}

- (CGFloat)topMargin {
    return self.node->style.margin[CSS_TOP];
}

- (void)setBottomMargin:(CGFloat)bottomMargin {
    self.node->style.margin[CSS_BOTTOM] = bottomMargin;
}

- (CGFloat)bottomMargin {
    return self.node->style.margin[CSS_BOTTOM];
}

- (void)setPadding:(BBEdges)padding {
    self.leftPadding = padding.left;
    self.rightPadding = padding.right;
    self.bottomPadding = padding.bottom;
    self.topPadding = padding.top;
}

- (BBEdges)padding {
    return BBEdgesMake(self.topPadding, self.leftPadding, self.bottomPadding, self.rightPadding);
}

- (void)setLeftPadding:(CGFloat)leftPadding {
    self.node->style.padding[CSS_LEFT] = leftPadding;
}

- (CGFloat)leftPadding {
    return self.node->style.padding[CSS_LEFT];
}

- (void)setRightPadding:(CGFloat)rightPadding {
    self.node->style.padding[CSS_RIGHT] = rightPadding;
}

- (CGFloat)rightPadding {
    return self.node->style.padding[CSS_RIGHT];
}

- (void)setTopPadding:(CGFloat)topPadding {
    self.node->style.padding[CSS_TOP] = topPadding;
}

- (CGFloat)topPadding {
    return self.node->style.padding[CSS_TOP];
}

- (void)setBottomPadding:(CGFloat)bottomPadding {
    self.node->style.padding[CSS_BOTTOM] = bottomPadding;
}

- (CGFloat)bottomPadding {
    return self.node->style.padding[CSS_BOTTOM];
}

@end
