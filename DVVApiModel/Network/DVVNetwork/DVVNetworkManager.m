//
//  DVVNetworkManager.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/10.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVNetworkManager.h"
#import "DVVNetworkStatusManager.h"

// 测试库地址
#define  HOST_TEST_DAMIAN  @"http://255.255.255.255:8080/"
// 正式库地址
#define  HOST_LINE_DOMAIN  @"http://jzapi.yibuxueche.com/"

//#define QA_TEST // 测试时打开此行注释

@implementation DVVNetworkManager

#pragma mark 单例管理者类
/**
 *  单例管理者类
 *
 *  @return instancetype
 */
+ (instancetype)sharedManager
{
    static DVVNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 请求缓存策略
        config.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        // 超时时间
        config.timeoutIntervalForRequest = 60.0f;
        config.timeoutIntervalForResource = 60.0f;
        // 请求类型
        config.networkServiceType = NSURLNetworkServiceTypeDefault;
        // 是否允许蜂窝网络
        config.allowsCellularAccess = YES;
        // 是否允许后台优化最佳性能 对于后台网络任务进行优化(有WiFi/设备电量情况好的时候)
        config.discretionary = YES;
        // cookies
        config.HTTPShouldSetCookies = YES;
        // 设置缓存
        config.URLCache = [NSURLCache sharedURLCache];
        // pipelining通道
        config.HTTPShouldUsePipelining = YES;
        // 限制每次最多连接数；在 iOS 中默认值为4
        config.HTTPMaximumConnectionsPerHost = 4;
        // 请求头信息
        config.HTTPAdditionalHeaders = [DVVNetworkManager defaultHeadersInfo];
        
        manager = [[DVVNetworkManager alloc] initWithBaseURL:[NSURL URLWithString:[DVVNetworkManager baseURL]]];
        
        // 验证服务器端SSL证书公钥
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        // 是否允许CA不信任的证书通过
        manager.securityPolicy.allowInvalidCertificates = YES;
        // 是否验证服务器主机名
        manager.securityPolicy.validatesDomainName = YES;
        
        // 开始监测网络状态
        [DVVNetworkStatusManager startMonitoring];
        
    });
    
    return manager;
}

#pragma mark BaseURL
/**
 *  BaseURL
 *
 *  @return Host URL
 */
+ (NSString *)baseURL
{
#ifdef QA_TEST
    return HOST_TEST_DAMIAN;
#else
    return HOST_LINE_DOMAIN;
#endif
}

#pragma mark 设置请求头
/**
 *  设置请求头
 *
 *  @param value       value
 *  @param headerField headerField
 */
+ (void)setHeaderFieldWithValue:(NSString * _Nullable)value
                    headerField:(NSString *)headerField
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSMutableDictionary *tempDict = config.HTTPAdditionalHeaders.mutableCopy;
    [tempDict setValue:value forKey:headerField];
    config.HTTPAdditionalHeaders = tempDict;
}

#pragma mark 默认的请求头信息
/**
 *  默认的请求头信息
 *
 *  @return NSDictionary
 */
+ (NSDictionary *)defaultHeadersInfo
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
    return @{
             @"Accept": @"application/json",
             @"Content-Type": @"application/x-www-form-urlencoded",
             @"AppVersion": version, // APP版本号
             @"Channel": @"App Store", // 渠道类型
             @"Platform": @"iOS", // 平台
             };
}

@end
