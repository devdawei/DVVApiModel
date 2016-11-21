//
//  DVVNetwork.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/11.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVNetwork.h"
#import "DVVNetworkManager.h"
#import "DVVNetworkConst.h"

@implementation DVVNetwork

#pragma mark - Data handle
#pragma mark Success
+ (void)networkSuccessWithPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                       success:(DVVNetworkSuccessBlock)success
                       failure:(DVVNetworkFailureBlock)failure
                      callBack:(DVVNetworkCallBackBlock)callBack
                          task:(NSURLSessionDataTask * _Nonnull)task
                responseObject:(id _Nullable)responseObject
{
    DVVResponseHandler *handler = [DVVResponseHandler handleResponse:responseObject api:path];
    if (handler.isSuccess)
    {
        if (success) success(responseObject, handler);
    }
    else
    {
        if (failure) failure(handler.error, handler);
    }
    
    if (callBack) callBack();
}

#pragma mark Failure
+ (void)networkFailureWithPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                       success:(DVVNetworkSuccessBlock)success
                       failure:(DVVNetworkFailureBlock)failure
                      callBack:(DVVNetworkCallBackBlock)callBack
                          task:(NSURLSessionDataTask * _Nonnull)task
                         error:(NSError * _Nonnull)error
{
    [DVVResponseHandler handleFailureWithError:error msg:nil api:path];
    if (failure) failure(error, [DVVResponseHandler new]);
    
    if (callBack) callBack();
}

#pragma mark -
#pragma mark 开始请求时要调用这个方法
+ (void)beginRequest
{
    
}

#pragma mark -
#pragma mark GET
+ (NSURLSessionDataTask *)getWithPath:(NSString *)path
                           parameters:(NSDictionary *)parameters
                              success:(DVVNetworkSuccessBlock)success
                              failure:(DVVNetworkFailureBlock)failure
                             callBack:(DVVNetworkCallBackBlock)callBack
{
    [DVVNetwork beginRequest];
    
    DVVNWLog(@"origin parmas:\n %@", parameters);
    
    DVVNetworkManager *manager = [DVVNetworkManager sharedManager];
    return [manager GET:path
             parameters:parameters
               progress:^(NSProgress * _Nonnull downloadProgress) {
                   
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   [DVVNetwork networkSuccessWithPath:path
                                           parameters:parameters
                                              success:success
                                              failure:failure
                                             callBack:callBack
                                                 task:task
                                       responseObject:responseObject];
                   
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   
                   [DVVNetwork networkFailureWithPath:path
                                           parameters:parameters
                                              success:success
                                              failure:failure
                                             callBack:callBack
                                                 task:task
                                                error:error];
               }];
}

#pragma mark POST
+ (NSURLSessionDataTask *)postWithPath:(NSString *)path
                            parameters:(NSDictionary *)parameters
                               success:(DVVNetworkSuccessBlock)success
                               failure:(DVVNetworkFailureBlock)failure
                              callBack:(DVVNetworkCallBackBlock)callBack
{
    [DVVNetwork beginRequest];
    
    DVVNWLog(@"origin parmas:\n %@", parameters);
    
    DVVNetworkManager *manager = [DVVNetworkManager sharedManager];
    return [manager POST:path
              parameters:parameters
                progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    [DVVNetwork networkSuccessWithPath:path
                                            parameters:parameters
                                               success:success
                                               failure:failure
                                              callBack:callBack
                                                  task:task
                                        responseObject:responseObject];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    [DVVNetwork networkFailureWithPath:path
                                            parameters:parameters
                                               success:success
                                               failure:failure
                                              callBack:callBack
                                                  task:task
                                                 error:error];
                    
                }];
}

#pragma mark Upload image
+ (NSURLSessionDataTask *)uploadImageWithPath:(NSString *)path
                                   parameters:(NSDictionary *)parameters
                                        image:(UIImage *)image
                                imageFileName:(NSString *)imageFileName
                                         name:(NSString *)name
                                     progress:(DVVNetworkProgressBlock)progress
                                      success:(DVVNetworkSuccessBlock)success
                                      failure:(DVVNetworkFailureBlock)failure
                                     callBack:(DVVNetworkCallBackBlock)callBack
{
    [DVVNetwork beginRequest];
    
    DVVNWLog(@"origin parmas:\n %@", parameters);
    
    DVVNetworkManager *manager = [DVVNetworkManager sharedManager];
    return [manager POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *fileName = imageFileName;
        if (!fileName.length)
        {
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
            NSString *dateStr = [formatter stringFromDate:[NSDate date]];
            fileName = [NSString stringWithFormat:@"%@.jpeg", dateStr];
        }
        
        // 将image转换为data
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress)
        {
            NSString *percentageStr = [NSString stringWithFormat:@"%.2lld", uploadProgress.completedUnitCount / uploadProgress.totalUnitCount];
            progress(uploadProgress, uploadProgress.completedUnitCount, uploadProgress.totalUnitCount, [percentageStr floatValue]);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [DVVNetwork networkSuccessWithPath:path
                                parameters:parameters
                                   success:success
                                   failure:failure
                                  callBack:callBack
                                      task:task
                            responseObject:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [DVVNetwork networkFailureWithPath:path
                                parameters:parameters
                                   success:success
                                   failure:failure
                                  callBack:callBack
                                      task:task
                                     error:error];
        
    }];
}

@end
