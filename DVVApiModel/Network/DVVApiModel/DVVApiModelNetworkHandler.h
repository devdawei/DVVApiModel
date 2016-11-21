//
//  DVVApiModelNetworkHandler.h
//  DVVApiModel
//
//  Created by 大威 on 2016/9/14.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DVVApiModelNetworkHandler)

/**
 *  网络开始请求调用
 */
- (void)dvv_handleNetworkBeginRequest;

/**
 *  成功或失败都调用
 */
- (void)dvv_handleNetworkCallBack;

/**
 *  网络出错
 *
 *  @param error error
 */
- (void)dvv_handleNetworkFailure:(NSError *)error;

/**
 *  配置刷新控件
 */
- (void)dvv_configRefresh;

/**
 *  header 结束刷新
 */
- (void)dvv_headerEndRefreshing;

/**
 *  footer 结束刷新
 */
- (void)dvv_footerEndRefreshing;

/**
 *  数据已经加载完了，显示没有更多数据
 */
- (void)dvv_handleNoMoreData;

@end
