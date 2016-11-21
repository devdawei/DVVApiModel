//
//  DVVLoading.m
//  DVVLoading <https://github.com/devdawei/DVVLoading.git>
//
//  Created by 大威 on 2016/10/31.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVLoading.h"

/** 动画的时间 */
#define DVV_LOADING_ANIMATE_DURATION 0.2
/** 大小 */
#define DVV_LOADING_SIZE 72
/** 圆角的度数 */
#define DVV_LOADING_CORNER_RADIUS 12
/** 背景透明度 */
#define DVV_LOADING_BACKGROUND_ALPHA 1

@interface DVVLoading ()

#ifdef __IPHONE_8_0
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
#endif
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation DVVLoading

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.coverImageView];
        [self addSubview:self.containerView];
        
//        _coverImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return self;
}

#pragma mark -

+ (void)show
{
    [self showFromView:[UIApplication sharedApplication].keyWindow];
}

+ (void)hide
{
    [self hideAllFromView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showFromView:(UIView *)superView
{
    [self showFromView:superView offsetY:0];
}

+ (void)showFromView:(UIView *)superView offsetY:(CGFloat)offsetY
{
    DVVLoading *loadingView = [DVVLoading new];
    loadingView.offsetY = offsetY;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        loadingView.containerView.backgroundColor = [UIColor clearColor];
        [loadingView.containerView addSubview:loadingView.blurEffectView];
    }
    
    [loadingView.containerView addSubview:loadingView.activityView];
    [loadingView.activityView startAnimating];
    
    loadingView.alpha = 0;
    [superView addSubview:loadingView];
    [UIView animateWithDuration:DVV_LOADING_ANIMATE_DURATION animations:^{
        loadingView.alpha = 1;
    }];
    
    /* 遇到过加载到一个xib视图上，横屏的时候没有调用 - (void)layoutSubviews 方法，通过添加 constraints 解决了 */
    loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *t = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *l = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *b = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *r = [NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [superView addConstraints:@[ t, l, b, r ]];
}

+ (void)hideFromView:(UIView *)superView
{
    [self hideFromView:superView isAll:NO];
}

+ (void)hideAllFromView:(UIView *)superView
{
    [self hideFromView:superView isAll:YES];
}

+ (void)hideFromView:(UIView *)superView isAll:(BOOL)isAll
{
    for (UIView *itemView in superView.subviews)
    {
        if ([itemView isKindOfClass:[DVVLoading class]])
        {
            [UIView animateWithDuration:DVV_LOADING_ANIMATE_DURATION animations:^{
                itemView.alpha = 0;
            } completion:^(BOOL finished) {
                [itemView removeFromSuperview];
            }];
            if (!isAll) return;
        }
    }
}

#pragma mark - UI

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    _coverImageView.frame = CGRectMake(0, 0, size.width, size.height);
    self.containerView.center = CGPointMake(size.width / 2.0f, size.height / 2.0f + _offsetY);
}

#pragma mark - Lazy load

- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        _coverImageView.userInteractionEnabled = YES;
    }
    return _coverImageView;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.bounds = CGRectMake(0, 0, DVV_LOADING_SIZE, DVV_LOADING_SIZE);
        [_containerView.layer setMasksToBounds:YES];
        [_containerView.layer setCornerRadius:DVV_LOADING_CORNER_RADIUS];
        _containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:DVV_LOADING_BACKGROUND_ALPHA];
    }
    return _containerView;
}

- (UIVisualEffectView *)blurEffectView
{
    if (!_blurEffectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _blurEffectView.userInteractionEnabled = NO;
        _blurEffectView.frame = self.containerView.bounds;
    }
    return _blurEffectView;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [UIActivityIndicatorView new];
        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _activityView.center = CGPointMake(DVV_LOADING_SIZE / 2.f, DVV_LOADING_SIZE / 2.f);
    }
    return _activityView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
