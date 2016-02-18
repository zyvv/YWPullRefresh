//
//  YWPullRefreshView.h
//  YWPullRefresh
//
//  Created by 张洋威 on 16/2/18.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN const CGFloat YWPullRefreshHeight;
UIKIT_EXTERN const CGFloat YWPullRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat YWPullRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const YWPullRefreshUpdatedTimeKey;
UIKIT_EXTERN NSString *const YWPullRefreshContentOffset;
UIKIT_EXTERN NSString *const YWPullRefreshContentSize;
UIKIT_EXTERN NSString *const YWPullRefreshPanState;

UIKIT_EXTERN NSString *const YWPullRefreshStateIdleText;
UIKIT_EXTERN NSString *const YWPullRefreshStatePullingText;
UIKIT_EXTERN NSString *const YWPullRefreshStateRefreshingText;

// 下拉刷新控件的状态
typedef enum {
    /** 普通闲置状态 */
    YWPullRefreshStateIdle = 1,
    /** 松开就可以进行刷新的状态 */
    YWPullRefreshStatePulling,
    /** 正在刷新中的状态 */
    YWPullRefreshStateRefreshing,
    /** 即将刷新的状态 */
    YWPullRefreshStateWillRefresh
} YWPullRefreshState;

@interface YWPullRefreshView : UIView
{
    UIEdgeInsets _scrollViewOriginalInset;
    __weak UIScrollView *_scrollView;
}

/** 正在刷新的回调 */
@property (copy, nonatomic) void (^refreshingBlock)();
/** 设置回调对象和回调方法 */
//- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
//@property (weak, nonatomic) id refreshingTarget;
//@property (assign, nonatomic) SEL refreshingAction;

/** 刷新控件的状态 */
@property (assign, nonatomic) YWPullRefreshState state;

/** 下拉的百分比(交给子类重写) */
@property (assign, nonatomic) CGFloat pullingPercent;

/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 是否正在刷新 */
- (BOOL)isRefreshing;
@end
