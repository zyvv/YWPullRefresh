//
//  UIScrollView+YWPullRefresh.h
//  YWPullRefresh
//
//  Created by 张洋威 on 16/2/18.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWPullRefreshView.h"

@interface UIScrollView (YWPullRefresh)

#pragma mark - 访问下拉刷新控件
/** 下拉刷新控件 */
@property (strong, nonatomic, readonly) YWPullRefreshView *pullRefreshView;

#pragma mark - 添加下拉刷新控件
/**
 * 添加一个传统的下拉刷新控件
 *
 * @param block 进入刷新状态就会自动调用这个block
 */
- (YWPullRefreshView *)pullRefreshingBlock:(void (^)())block;
@end

@interface UIView (YWExtension)
@property (assign, nonatomic) CGFloat yw_x;
@property (assign, nonatomic) CGFloat yw_y;
@property (assign, nonatomic) CGFloat yw_w;
@property (assign, nonatomic) CGFloat yw_h;
@property (assign, nonatomic) CGSize yw_size;
@property (assign, nonatomic) CGPoint yw_origin;
@end

@interface UIScrollView (YWExtension)
@property (assign, nonatomic) CGFloat yw_insetT;
@property (assign, nonatomic) CGFloat yw_insetB;
@property (assign, nonatomic) CGFloat yw_insetL;
@property (assign, nonatomic) CGFloat yw_insetR;

@property (assign, nonatomic) CGFloat yw_offsetX;
@property (assign, nonatomic) CGFloat yw_offsetY;

@property (assign, nonatomic) CGFloat yw_contentSizeW;
@property (assign, nonatomic) CGFloat yw_contentSizeH;
@end