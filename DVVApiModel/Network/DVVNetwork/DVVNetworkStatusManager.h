//
//  DVVNetworkStatusManager.h
//  DVVApiModel
//
//  Created by 大威 on 16/9/10.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

typedef NS_ENUM(NSUInteger, DVVNetworkStatus)
{
    /** 未识别 */
    DVVNetworkStatusUnknown = AFNetworkReachabilityStatusUnknown,
    /** 未连接 */
    DVVNetworkStatusNotReachable = AFNetworkReachabilityStatusNotReachable,
    /** 3G */
    DVVNetworkStatusWWAN = AFNetworkReachabilityStatusReachableViaWWAN,
    /** WiFi */
    DVVNetworkStatusWiFi = AFNetworkReachabilityStatusReachableViaWiFi
};

@interface DVVNetworkStatusManager : NSObject

/** 网络状态 */
@property (nonatomic, assign) NSInteger networkStatus;

/**
 *  开始监测网络状态
 */
+ (instancetype)startMonitoring;

- (instancetype)init __attribute__((unavailable("请使用 + (instancetype)startMonitoring; 方法初始化")));

@end
