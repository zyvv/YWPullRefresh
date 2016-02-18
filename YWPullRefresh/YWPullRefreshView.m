//
//  YWPullRefreshView.m
//  YWPullRefresh
//
//  Created by 张洋威 on 16/2/18.
//  Copyright © 2016年 太阳花互动. All rights reserved.
//

#import "YWPullRefreshView.h"
#import "UIScrollView+YWPullRefresh.h"
@interface YWPullRefreshView()
/** 记录scrollView刚开始的inset */
@property (assign, nonatomic) UIEdgeInsets scrollViewOriginalInset;
/** 父控件 */
@property (weak, nonatomic) UIScrollView *scrollView;
@end

@implementation YWPullRefreshView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 基本属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        // 设置为默认状态
        self.state = YWPullRefreshStateIdle;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:YWPullRefreshContentOffset context:nil];
    
    if (newSuperview) { // 新的父控件
        [newSuperview addObserver:self forKeyPath:YWPullRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        
        // 设置宽度
        self.yw_w = newSuperview.yw_w;
        // 设置位置
        self.yw_x = 0;
        
        // 记录UIScrollView
        self.scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        self.scrollView.alwaysBounceVertical = YES;
        // 记录UIScrollView最开始的contentInset
        self.scrollViewOriginalInset = self.scrollView.contentInset;
        
        self.yw_h = YWPullRefreshHeight;
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.state == YWPullRefreshStateWillRefresh) {
        self.state = YWPullRefreshStateRefreshing;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置自己的位置
    self.yw_y = - self.yw_h;

}

#pragma mark KVO属性监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == YWPullRefreshStateRefreshing) return;
    
    // 根据contentOffset调整state
    if ([keyPath isEqualToString:YWPullRefreshContentOffset]) {
        [self adjustStateWithContentOffset];
    }
}

#pragma mark 根据contentOffset调整state
- (void)adjustStateWithContentOffset
{
    if (self.state != YWPullRefreshStateRefreshing) {
        // 在刷新过程中，跳转到下一个控制器时，contentInset可能会变
        _scrollViewOriginalInset = _scrollView.contentInset;
    }
    
    // 当前的contentOffset
    CGFloat offsetY = _scrollView.yw_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - _scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    if (offsetY >= happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.yw_h;
    if (_scrollView.isDragging) {
        self.pullingPercent = (happenOffsetY - offsetY) / self.yw_h;
        
        if (self.state == YWPullRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = YWPullRefreshStatePulling;
        } else if (self.state == YWPullRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = YWPullRefreshStateIdle;
        }
    } else if (self.state == YWPullRefreshStatePulling) {// 即将刷新 && 手松开
        self.pullingPercent = 1.0;
        // 开始刷新
        self.state = YWPullRefreshStateRefreshing;
    } else {
        self.pullingPercent = (happenOffsetY - offsetY) / self.yw_h;
    }
}

#pragma mark - 公共方法
- (void)beginRefreshing
{
    if (self.window) {
        self.state = YWPullRefreshStateRefreshing;
    } else {
        self.state = YWPullRefreshStateWillRefresh;
    }
}

- (void)endRefreshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = YWPullRefreshStateIdle;
    });
}

- (BOOL)isRefreshing {
    return self.state == YWPullRefreshStateRefreshing;
}

- (void)setState:(YWPullRefreshState)state
{
    if (_state == state) return;
    
    // 旧状态
    YWPullRefreshState oldState = _state;
    
    // 赋值
    _state = state;
    
    
    switch (state) {
        case YWPullRefreshStateIdle: {
            if (oldState == YWPullRefreshStateRefreshing) {
                
                // 恢复inset和offset
                [UIView animateWithDuration:YWPullRefreshSlowAnimationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                    // 修复top值不断累加
                    _scrollView.yw_insetT -= self.yw_h;
                } completion:nil];
            }
            break;
        }
            
        case YWPullRefreshStateRefreshing: {
            [UIView animateWithDuration:YWPullRefreshFastAnimationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                // 增加滚动区域
                CGFloat top = _scrollViewOriginalInset.top + self.yw_h;
                _scrollView.yw_insetT = top;
                
                // 设置滚动位置
                _scrollView.yw_offsetY = - top;
            } completion:^(BOOL finished) {
                // 回调
                if (self.refreshingBlock) {
                    self.refreshingBlock();
                }
                
            }];
            break;
        }
            
        default:
            break;
    }
}
@end
