//
//  UIScrollView+YWPullRefresh.h
//  YWPullRefresh
//
//  Created by 张洋威 on 16/2/18.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YWPullRefresh)
@property (assign, nonatomic) CGFloat yw_insetT;
@property (assign, nonatomic) CGFloat yw_insetB;
@property (assign, nonatomic) CGFloat yw_insetL;
@property (assign, nonatomic) CGFloat yw_insetR;

@property (assign, nonatomic) CGFloat yw_offsetX;
@property (assign, nonatomic) CGFloat yw_offsetY;

@property (assign, nonatomic) CGFloat yw_contentSizeW;
@property (assign, nonatomic) CGFloat yw_contentSizeH;
@end

@interface UIView (YWExtension)
@property (assign, nonatomic) CGFloat yw_x;
@property (assign, nonatomic) CGFloat yw_y;
@property (assign, nonatomic) CGFloat yw_w;
@property (assign, nonatomic) CGFloat yw_h;
@property (assign, nonatomic) CGSize yw_size;
@property (assign, nonatomic) CGPoint yw_origin;
@end