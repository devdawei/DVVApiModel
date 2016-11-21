//
//  DVVNetworkStatusManager.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/10.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVNetworkStatusManager.h"
#import "DVVNetworkConst.h"

@implementation DVVNetworkStatusManager

+ (instancetype)startMonitoring
{
    static DVVNetworkStatusManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
         {
             switch (status) {
                 case AFNetworkReachabilityStatusUnknown:
                 {
                     // 未识别
                     DVVNWLog(@"%@",@"未识别");
                     _networkStatus = AFNetworkReachabilityStatusUnknown;
                     break;
                 }
                 case AFNetworkReachabilityStatusNotReachable:
                 {
                     // 未连接
                     DVVNWLog(@"%@",@"未连接");
                     _networkStatus = AFNetworkReachabilityStatusNotReachable;
                     break;
                 }
                 case AFNetworkReachabilityStatusReachableViaWWAN:
                 {
                     // 3G
                     DVVNWLog(@"%@",@"3G");
                     _networkStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                     break;
                 }
                 case AFNetworkReachabilityStatusReachableViaWiFi:
                 {
                     // WiFi
                     DVVNWLog(@"%@",@"WiFi");
                     _networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                     break;
                 }
                 default:
                 {
                     break;
                 }
             }
         }];
        
        // 要检测网络连接状态，必须要先调用单例的startMonitoring方法开启监听
        [manager startMonitoring];
    }
    return self;
}

@end
