//
//  DVVEmptyView.h
//  DVVApiModel
//
//  Created by 大威 on 16/9/12.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 空页面类型

 - DVVEmptyViewTypeUnknown: 未知
 - DVVEmptyViewTypeNoData: 没有数据
 - DVVEmptyViewTypeError: 加载失败
 */
typedef NS_ENUM(NSUInteger, DVVEmptyViewType)
{
    DVVEmptyViewTypeUnknown,
    DVVEmptyViewTypeNoData,
    DVVEmptyViewTypeError
};

@interface DVVEmptyView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, strong) UIButton *button;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image;

- (instancetype)initWithType:(DVVEmptyViewType)type;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                  buttonTitle:(NSString *)buttonTitle
                       target:(id)target
                       action:(SEL)action;

- (void)addButtonClickTarget:(id)target action:(SEL)action;

- (void)showFrom:(UIView *)superView;

+ (BOOL)checkSameFor:(UIView *)superView;

@end
