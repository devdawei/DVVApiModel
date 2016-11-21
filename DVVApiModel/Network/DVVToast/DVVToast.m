//
//  DVVToast.m
//  DVVToast <https://github.com/devdawei/DVVToast.git>
//
//  Created by 大威 on 2016/10/31.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVToast.h"

/** 默认的高度 */
#define DVV_MESSAGE_DEFAULT_HEIGHT 46
/** 字体大小 */
#define DVV_MESSAGE_FONT [UIFont systemFontOfSize:15]
/** 上边距 */
#define DVV_MESSAGE_TOP_MARGIN 18
/** 左边距 */
#define DVV_MESSAGE_LEFT_MARGIN 18
/** 圆角的度数 */
#define DVV_MESSAGE_CORNER_RADIUS 12
/** 动画的时间 */
#define DVV_MESSAGE_ANIMATE_DURATION 0.2
/** 背景透明度 */
#define DVV_MESSAGE_BACKGROUND_ALPHA 1
/** 消息停留的时间 */
#define DVV_MESSAGE_AFTER_TIME 1.5

@interface DVVToast ()

#ifdef __IPHONE_8_0
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
#endif

@end

@implementation DVVToast

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.coverImageView];
        [self addSubview:self.containerView];
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
        {
            _containerView.backgroundColor = [UIColor clearColor];
            [_containerView addSubview:self.blurEffectView];
        }
        [_containerView addSubview:self.messageLabel];
        
//        _coverImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return self;
}

#pragma mark -

+ (void)showMessage:(NSString *)message
{
    [self showMessage:message
             duration:DVV_MESSAGE_AFTER_TIME];
}

+ (void)showMessage:(NSString *)message
           duration:(CGFloat)duration
{
    [self showMessage:message
             fromView:[UIApplication sharedApplication].keyWindow
             duration:duration];
}

+ (void)showMessage:(NSString *)message
           fromView:(UIView *)superView
{
    [self showMessage:message
             fromView:superView
             duration:DVV_MESSAGE_AFTER_TIME];
}

+ (void)showMessage:(NSString *)message
           fromView:(UIView *)superView
           duration:(CGFloat)duration
{
    DVVToast *messageView = [DVVToast new];
    messageView.messageLabel.text = message;
    
    messageView.alpha = 0;
    [superView addSubview:messageView];
    [UIView animateWithDuration:DVV_MESSAGE_ANIMATE_DURATION animations:^{
        messageView.alpha = 1;
    }];
    
    /* 遇到过加载到一个xib视图上，横屏的时候没有调用 - (void)layoutSubviews 方法，通过添加 constraints 解决了 */
    messageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *t = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *l = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *b = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *r = [NSLayoutConstraint constraintWithItem:messageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [superView addConstraints:@[ t, l, b, r ]];
    
    CGFloat d = 0;
    if (duration > 0) d = duration;
    else d = DVV_MESSAGE_AFTER_TIME;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(d * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:DVV_MESSAGE_ANIMATE_DURATION animations:^{
            messageView.alpha = 0;
        } completion:^(BOOL finished) {
            [messageView removeFromSuperview];
        }];
        
    });
}

#pragma mark - UI

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    _coverImageView.frame = CGRectMake(0, 0, size.width, size.height);
    _containerView.center = CGPointMake(size.width / 2.0f, size.height / 2.0f);
    
    CGFloat testWidth = [DVVToast widthWithString:_messageLabel.text font:DVV_MESSAGE_FONT];
    CGFloat messageViewMaxWidth = size.width - DVV_MESSAGE_LEFT_MARGIN * 2;
    CGFloat labelMaxWidth = messageViewMaxWidth - DVV_MESSAGE_LEFT_MARGIN * 2;
    
    if (testWidth <= messageViewMaxWidth - DVV_MESSAGE_LEFT_MARGIN * 2)
    {
        _containerView.bounds = CGRectMake(0, 0, testWidth + DVV_MESSAGE_LEFT_MARGIN * 2, DVV_MESSAGE_DEFAULT_HEIGHT);
        _messageLabel.bounds = CGRectMake(0, 0, testWidth, DVV_MESSAGE_DEFAULT_HEIGHT);
    }
    else
    {
        CGFloat testHeight = [DVVToast heightWithString:_messageLabel.text width:labelMaxWidth font:DVV_MESSAGE_FONT];
        _containerView.bounds = CGRectMake(0, 0, messageViewMaxWidth, testHeight + DVV_MESSAGE_TOP_MARGIN * 2);
        _messageLabel.bounds = CGRectMake(0, 0, labelMaxWidth, testHeight);
    }
    _containerView.center = CGPointMake(size.width / 2.f, size.height / 2.f);
    _messageLabel.center = CGPointMake(_containerView.bounds.size.width / 2.f, _containerView.bounds.size.height / 2.f);
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        _blurEffectView.frame = _containerView.bounds;
    }
}

#pragma mark -
#pragma mark 一串字符在固定宽度下，正常显示所需要的高度
+ (CGFloat)heightWithString:(NSString *)string
                      width:(CGFloat)width
                       font:(UIFont *)font
{
    if (!string || !string.length || !font) return 0;
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *dict = @{ NSFontAttributeName: font };
    CGFloat height = [string boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:dict context:nil].size.height;
    return height;
}

#pragma mark 一串字符在一行中正常显示所需要的宽度
+ (CGFloat)widthWithString:(NSString *)string
                      font:(UIFont *)font
{
    if (!string || !string.length || !font) return 0;
    
    CGSize size = CGSizeMake(MAXFLOAT, font.lineHeight);
    NSDictionary *dict = @{ NSFontAttributeName: font };
    CGFloat width = [string boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:dict context:nil].size.width;
    return width;
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
        _containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:DVV_MESSAGE_BACKGROUND_ALPHA];
        _containerView.clipsToBounds = YES;
        [_containerView.layer setMasksToBounds:YES];
        [_containerView.layer setCornerRadius:DVV_MESSAGE_CORNER_RADIUS];
    }
    return _containerView;
}

- (UIVisualEffectView *)blurEffectView
{
    if (!_blurEffectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _blurEffectView.userInteractionEnabled = NO;
    }
    return _blurEffectView;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.font = DVV_MESSAGE_FONT;
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = [UIColor whiteColor];
    }
    return _messageLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
