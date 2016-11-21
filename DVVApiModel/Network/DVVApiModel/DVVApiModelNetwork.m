//
//  DVVApiModelNetwork.m
//  DVVApiModel
//
//  Created by 大威 on 2016/9/14.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVApiModelNetwork.h"
#import "DVVApiModelNetworkHandler.h"

@implementation NSObject (DVVApiModelNetwork)

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
- (NSURLSessionDataTask *)dvv_getWithPath:(NSString *)path
                               parameters:(NSDictionary * _Nullable)parameters
                                  success:(DVVNetworkSuccessBlock)success
                                  failure:(DVVNetworkFailureBlock)failure
                                 callBack:(DVVNetworkCallBackBlock)callBack
{
    [self dvv_handleNetworkBeginRequest]; // 处理开始请求
    
    return [DVVNetwork getWithPath:path parameters:parameters success:^(id  _Nullable responseObject,  DVVResponseHandler * _Nonnull handler) {
        
        if (success) success(responseObject, handler);
        
    } failure:^(NSError * _Nonnull error,  DVVResponseHandler * _Nonnull handler) {
        
        [self dvv_handleNetworkFailure:error]; // 处理请求失败
        if (failure) failure(error, handler);
        
    } callBack:^{
        
        [self dvv_handleNetworkCallBack]; // 处理成功或失败都调用的回调
        if (callBack) callBack();
        
    }];
}

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
- (NSURLSessionDataTask *)dvv_postWithPath:(NSString *)path
                                parameters:(NSDictionary * _Nullable)parameters
                                   success:(DVVNetworkSuccessBlock)success
                                   failure:(DVVNetworkFailureBlock)failure
                                  callBack:(DVVNetworkCallBackBlock)callBack
{
    [self dvv_handleNetworkBeginRequest]; // 处理开始请求
    
    return [DVVNetwork postWithPath:path parameters:parameters success:^(id  _Nullable responseObject, DVVResponseHandler * _Nonnull handler) {
        
        if (success) success(responseObject, handler);
        
    } failure:^(NSError * _Nonnull error, DVVResponseHandler * _Nonnull handler) {
        
        [self dvv_handleNetworkFailure:error]; // 处理请求失败
        if (failure) failure(error, handler);
        
    } callBack:^{
        
        [self dvv_handleNetworkCallBack]; // 处理成功或失败都调用的回调
        if (callBack) callBack();
        
    }];
}

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
- (NSURLSessionDataTask *)dvv_uploadImageWithPath:(NSString *)path
                                       parameters:(NSDictionary * _Nullable)parameters
                                            image:(UIImage *)image
                                    imageFileName:(NSString * _Nullable)imageFileName
                                             name:(NSString * _Nullable)name
                                         progress:(DVVNetworkProgressBlock)progress
                                          success:(DVVNetworkSuccessBlock)success
                                          failure:(DVVNetworkFailureBlock)failure
                                         callBack:(DVVNetworkCallBackBlock)callBack
{
    [self dvv_handleNetworkBeginRequest]; // 处理开始请求
    
    return [DVVNetwork uploadImageWithPath:path parameters:parameters image:image imageFileName:imageFileName name:name progress:^(NSProgress * _Nonnull uploadProgress, int64_t completedUnitCount, int64_t totalUnitCount, CGFloat percentage) {
        
        if (progress) progress(uploadProgress, completedUnitCount, totalUnitCount, percentage);
        
    } success:^(id  _Nullable responseObject, DVVResponseHandler * _Nonnull handler) {
        
        if (success) success(responseObject, handler);
        
    } failure:^(NSError * _Nonnull error, DVVResponseHandler * _Nonnull handler) {
        
        [self dvv_handleNetworkFailure:error]; // 处理请求失败
        if (failure) failure(error, handler);
        
    } callBack:^{
        
        [self dvv_handleNetworkCallBack]; // 处理成功或失败都调用的回调
        if (callBack) callBack();
        
    }];
}

@end
