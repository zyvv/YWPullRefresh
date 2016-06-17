//
//  UIScrollView+YWPullRefresh.m
//  YWPullRefresh
//
//  Created by 张洋威 on 16/2/18.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import "UIScrollView+YWPullRefresh.h"
#import <objc/runtime.h>

@implementation UIScrollView (YWExtension)

- (void)setYw_insetT:(CGFloat)yw_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = yw_insetT;
    self.contentInset = inset;
}

- (CGFloat)yw_insetT
{
    return self.contentInset.top;
}

- (void)setYw_insetB:(CGFloat)yw_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = yw_insetB;
    self.contentInset = inset;
}

- (CGFloat)yw_insetB
{
    return self.contentInset.bottom;
}

- (void)setYw_insetL:(CGFloat)yw_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = yw_insetL;
    self.contentInset = inset;
}

- (CGFloat)yw_insetL
{
    return self.contentInset.left;
}

- (void)setYw_insetR:(CGFloat)yw_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = yw_insetR;
    self.contentInset = inset;
}

- (CGFloat)yw_insetR
{
    return self.contentInset.right;
}

- (void)setYw_offsetX:(CGFloat)yw_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = yw_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)yw_offsetX
{
    return self.contentOffset.x;
}

- (void)setYw_offsetY:(CGFloat)yw_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = yw_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)yw_offsetY
{
    return self.contentOffset.y;
}

- (void)setYw_contentSizeW:(CGFloat)yw_contentSizeW
{
    CGSize size = self.contentSize;
    size.width = yw_contentSizeW;
    self.contentSize = size;
}

- (CGFloat)yw_contentSizeW
{
    return self.contentSize.width;
}

- (void)setYw_contentSizeH:(CGFloat)yw_contentSizeH
{
    CGSize size = self.contentSize;
    size.height = yw_contentSizeH;
    self.contentSize = size;
}

- (CGFloat)yw_contentSizeH
{
    return self.contentSize.height;
}
@end

@implementation UIView (YWExtension)
- (void)setYw_x:(CGFloat)yw_x
{
    CGRect frame = self.frame;
    frame.origin.x = yw_x;
    self.frame = frame;
}

- (CGFloat)yw_x
{
    return self.frame.origin.x;
}

- (void)setYw_y:(CGFloat)yw_y
{
    CGRect frame = self.frame;
    frame.origin.y = yw_y;
    self.frame = frame;
}

- (CGFloat)yw_y
{
    return self.frame.origin.y;
}

- (void)setYw_w:(CGFloat)yw_w
{
    CGRect frame = self.frame;
    frame.size.width = yw_w;
    self.frame = frame;
}

- (CGFloat)yw_w
{
    return self.frame.size.width;
}

- (void)setYw_h:(CGFloat)yw_h
{
    CGRect frame = self.frame;
    frame.size.height = yw_h;
    self.frame = frame;
}

- (CGFloat)yw_h
{
    return self.frame.size.height;
}

- (void)setYw_size:(CGSize)yw_size
{
    CGRect frame = self.frame;
    frame.size = yw_size;
    self.frame = frame;
}

- (CGSize)yw_size
{
    return self.frame.size;
}

- (void)setYw_origin:(CGPoint)yw_origin
{
    CGRect frame = self.frame;
    frame.origin = yw_origin;
    self.frame = frame;
}

- (CGPoint)yw_origin
{
    return self.frame.origin;
}

@end


@implementation UIScrollView (YWPullRefresh)

- (YWPullRefreshView *)pullRefreshingBlock:(void (^)())block;
{
    YWPullRefreshView *pullRefreshView = [self addPullRefreshView];
    pullRefreshView.refreshingBlock = block;
    return pullRefreshView;
}

- (YWPullRefreshView *)addPullRefreshView
{
    YWPullRefreshView *pullRefreshView = [[YWPullRefreshView alloc] init];
    self.pullRefreshView = pullRefreshView;
    
    return pullRefreshView;
}

#pragma mark header
static char YWPullRefreshViewKey;

- (void)setPullRefreshView:(YWPullRefreshView *)pullRefreshView
{
    if (pullRefreshView != self.pullRefreshView) {
        [self.pullRefreshView removeFromSuperview];
        
        [self willChangeValueForKey:@"pullRefreshView"];
        objc_setAssociatedObject(self, &YWPullRefreshViewKey,
                                 pullRefreshView,
                                 OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"pullRefreshView"];
        
        [self addSubview:pullRefreshView];
    }
}

- (YWPullRefreshView *)pullRefreshView
{
    return objc_getAssociatedObject(self, &YWPullRefreshViewKey);
}

@end
