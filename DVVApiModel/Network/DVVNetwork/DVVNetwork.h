//
//  DVVNetwork.h
//  DVVApiModel
//
//  Created by 大威 on 16/9/11.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVResponseHandler.h"

NS_ASSUME_NONNULL_BEGIN

/** 成功的回调 */
typedef void (^DVVNetworkSuccessBlock) (id _Nullable responseObject,
                                        DVVResponseHandler *responseHandler);
/** 错误的回调 */
typedef void (^DVVNetworkFailureBlock) (NSError *error,
                                        DVVResponseHandler *responseHandler);
/** 成功或失败都调用的回调 */
typedef void (^DVVNetworkCallBackBlock) (void);

/** 进度 */
typedef void(^DVVNetworkProgressBlock)(NSProgress * _Nonnull uploadProgress,
                                       int64_t completedUnitCount,
                                       int64_t totalUnitCount,
                                       CGFloat percentage);

@interface DVVNetwork : NSObject

/**
 *  GET请求方式
 *
 *  @param path  接口
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *  @param callBack   成功或失败都调用
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)getWithPath:(NSString *)path
                           parameters:(NSDictionary * _Nullable)parameters
                              success:(DVVNetworkSuccessBlock)success
                              failure:(DVVNetworkFailureBlock)failure
                             callBack:(DVVNetworkCallBackBlock)callBack;

/**
 *  POST请求方式
 *
 *  @param path  接口
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 *  @param callBack   成功或失败都调用
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)postWithPath:(NSString *)path
                            parameters:(NSDictionary * _Nullable)parameters
                               success:(DVVNetworkSuccessBlock)success
                               failure:(DVVNetworkFailureBlock)failure
                              callBack:(DVVNetworkCallBackBlock)callBack;

/**
 *  上传图片
 *
 *  @param path          路径
 *  @param parameters    参数
 *  @param image         要上传的图片
 *  @param imageFileName 图片的名字
 *  @param name          后台要根据这个key来取图片
 *  @param progress      进度
 *  @param success       成功回调
 *  @param failure       失败回调
 *  @param callBack      成功或失败都调用
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)uploadImageWithPath:(NSString *)path
                                   parameters:(NSDictionary * _Nullable)parameters
                                        image:(UIImage *)image
                                imageFileName:(NSString * _Nullable)imageFileName
                                         name:(NSString * _Nullable)name
                                     progress:(DVVNetworkProgressBlock)progress
                                      success:(DVVNetworkSuccessBlock)success
                                      failure:(DVVNetworkFailureBlock)failure
                                     callBack:(DVVNetworkCallBackBlock)callBack;

NS_ASSUME_NONNULL_END

@end
