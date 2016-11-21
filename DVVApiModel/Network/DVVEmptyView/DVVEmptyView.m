//
//  DVVEmptyView.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/12.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVEmptyView.h"
#import <objc/runtime.h>

CGFloat const kTitleLabelFontSize = 16;
CGFloat const kButtonFontSize = 16;

static char *kButtonTitle;

@interface DVVEmptyView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation DVVEmptyView

@dynamic buttonTitle;

#pragma mark - Init

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        [self initSelf];
        _imageView.image = image;
        _titleLabel.text = title;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                  buttonTitle:(NSString *)buttonTitle
                       target:(id)target
                       action:(SEL)action
{
    self = [super init];
    if (self)
    {
        [self initSelf];
        _imageView.image = image;
        _titleLabel.text = title;
        self.buttonTitle = buttonTitle;
        
        [self addButtonClickTarget:target action:action];
    }
    return self;
}

- (void)addButtonClickTarget:(id)target
                      action:(SEL)action
{
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)initSelf
{
    self.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    [self addSubview:self.contentView];
    [_contentView addSubview:self.imageView];
    [_contentView addSubview:self.titleLabel];
    [_contentView addSubview:self.button];
}

- (instancetype)initWithType:(DVVEmptyViewType)type
{
    switch (type)
    {
        case DVVEmptyViewTypeNoData:
        {
            self = [self initWithTitle:@"暂无数据" image:[UIImage imageNamed:@"ic_empty_test"]];
        }
            break;
            
        default:
        {
            self = [self initWithTitle:@"加载失败" image:[UIImage imageNamed:@"ic_empty_test"]];
        }
            break;
    }
    
    return self;
}

#pragma mark -

- (void)showFrom:(UIView *)superView
{
    // 如果已经有了，就直接return
    if ([DVVEmptyView checkSameFor:superView]) return;
    
    [superView addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *t = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *l = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *b = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *r = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [superView addConstraints:@[ t, l, b, r ]];
}

+ (BOOL)checkSameFor:(UIView *)superView
{
    for (UIView *item in superView.subviews)
    {
        if ([item isKindOfClass:[DVVEmptyView class]])
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark -

- (void)setButtonTitle:(NSString *)buttonTitle
{
    [_button setTitle:buttonTitle forState:UIControlStateNormal];
    objc_setAssociatedObject(self, &kButtonTitle, buttonTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (NSString *)buttonTitle
{
    return objc_getAssociatedObject(self, &kButtonTitle);
}

#pragma mark - UI

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = self.superview.bounds;
    
    CGSize size = self.bounds.size;
    CGFloat contentWidth = size.width;
    // 图片的高
    CGFloat imageHeight = 100.0f;
    CGFloat imageWidth = 100.0f;
    
    CGFloat titleTopMargin = 24.0f;
    // 标题的高
    CGFloat titleHeight = 0;
    if (_titleLabel.text && _titleLabel.text.length)
    {
        titleHeight = kTitleLabelFontSize;
    }
    
    CGFloat buttonTopMargin = 24.0f;
    // 按钮的高
    CGFloat buttonHeight = 0;
    CGFloat buttonWidth = 0;
    if (self.buttonTitle && self.buttonTitle.length)
    {
        buttonHeight = 44;
        buttonWidth = [DVVEmptyView widthWithString:self.buttonTitle font:[UIFont systemFontOfSize:kButtonFontSize]] + kButtonFontSize*2;
        if (buttonWidth < 170)
        {
            buttonWidth = 170;
        }
    }
    
    CGFloat contentHeight = imageHeight + titleTopMargin + titleHeight + buttonTopMargin + buttonHeight;
    
    _contentView.bounds = CGRectMake(0, 0, contentWidth, contentHeight);
    _contentView.center = CGPointMake(size.width / 2.0f, size.height / 2.0f);
    _imageView.frame = CGRectMake((contentWidth - imageWidth) / 2.0f, 0, imageWidth, imageHeight);
    _titleLabel.frame = CGRectMake(0, imageHeight + titleTopMargin, contentWidth, titleHeight);
    _button.frame = CGRectMake((contentWidth - buttonWidth) / 2.0f, imageHeight + titleTopMargin + titleHeight + buttonTopMargin, buttonWidth, buttonHeight);
}

#pragma mark -
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

#pragma mark - lazy load

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [UIView new];
    }
    return _contentView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:kTitleLabelFontSize];
    }
    return _titleLabel;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.titleLabel.font = [UIFont systemFontOfSize:kButtonFontSize];
        [_button.layer setMasksToBounds:YES];
        [_button.layer setCornerRadius:8];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor colorWithRed:51/255.0 green:162/255.0 blue:226/255.0 alpha:1];
    }
    return _button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
