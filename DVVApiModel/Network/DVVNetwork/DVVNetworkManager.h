//
//  DVVNetworkManager.h
//  DVVApiModel
//
//  Created by 大威 on 16/9/10.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface DVVNetworkManager : AFHTTPSessionManager

NS_ASSUME_NONNULL_BEGIN

/**
 *  单例管理者类
 *
 *  @return instancetype
 */
+ (instancetype)sharedManager;

/**
 *  BaseURL
 *
 *  @return Host URL
 */
+ (NSString *)baseURL;

/**
 *  设置请求头
 *
 *  @param value       value
 *  @param headerField headerField
 */
+ (void)setHeaderFieldWithValue:(NSString * _Nullable)value
                    headerField:(NSString *)headerField;

NS_ASSUME_NONNULL_END

@end
