//
//  DVVToast.h
//  DVVToast <https://github.com/devdawei/DVVToast.git>
//
//  Created by 大威 on 2016/10/31.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVToast : UIView

/**
 *  显示一条短暂停留的提示消息
 *
 *  @param message 提示消息
 */
+ (void)showMessage:(NSString *)message;

/**
 *  显示一条短暂停留的提示消息（指定显示时长）
 */
+ (void)showMessage:(NSString *)message
           duration:(CGFloat)duration;

/**
 *  显示一条短暂停留的提示消息（可指定显示到的View）
 *
 *  @param message   提示消息
 *  @param superView 在这个View上显示
 */
+ (void)showMessage:(NSString *)message
           fromView:(UIView *)superView;

/**
 *  显示一条短暂停留的提示消息（可指定显示到的View，指定显示时长）
 */
+ (void)showMessage:(NSString *)message
           fromView:(UIView *)superView
           duration:(CGFloat)duration;


/** 在这个 Label 上显示提示消息 */
@property (nonatomic, strong) UILabel *messageLabel;
/** 背景图片 */
@property (nonatomic, strong) UIImageView *coverImageView;
/** Toast 的容器视图 */
@property (nonatomic, strong) UIView *containerView;

@end
