//
//  DVVLoading.h
//  DVVLoading <https://github.com/devdawei/DVVLoading.git>
//
//  Created by 大威 on 2016/10/31.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVLoading : UIView

/**  
 显示到Window上 
 */
+ (void)show;

/**
 *  从Window上隐藏
 */
+ (void)hide;


/**
 *  显示到一个View上
 *
 *  @param superView 显示到这个View上
 */
+ (void)showFromView:(UIView *)superView;

/**
 *  显示到一个View上（可设置偏移量）
 *
 *  @param superView 要显示到的View
 *  @param offsetY   偏移量
 */
+ (void)showFromView:(UIView *)superView
             offsetY:(CGFloat)offsetY;

/**
 *  从View上隐藏
 *
 *  @param superView 从这个View上隐藏
 */
+ (void)hideFromView:(UIView *)superView;

/**
 *  隐藏所有的Loading
 */
+ (void)hideAllFromView:(UIView *)superView;


/** 上下偏移量 */
@property (nonatomic, assign) CGFloat offsetY;
/** 背景图片 */
@property (nonatomic, strong) UIImageView *coverImageView;
/** Loading 的容器视图 */
@property (nonatomic, strong) UIView *containerView;

@end
