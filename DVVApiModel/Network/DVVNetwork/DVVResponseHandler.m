//
//  DVVResponseHandler.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/11.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVResponseHandler.h"
#import "DVVNetworkConst.h"
#import "DVVToast.h"

@implementation DVVResponseHandler

/**
 *  处理 responseObject 对象
 *
 *  @param responseObject responseObject
 *  @param api            api
 *
 *  @return DVVResponseHandler
 */
+ (DVVResponseHandler *)handleResponse:(id)responseObject
                                   api:(NSString *)api
{
    DVVResponseHandler *handlerModel = [DVVResponseHandler new];
    
    // 提取状态
    NSNumber *statusNumber = responseObject[@"type"];
    handlerModel.code = [statusNumber integerValue];
    
    // 判断状态值
    if (statusNumber &&
        1 == [statusNumber integerValue])
    {
        handlerModel.isSuccess = YES;
    }
    
    // 提取数据判断是否有数据
    NSDictionary *data = responseObject[@"data"];
    if ([data isKindOfClass:[NSDictionary class]])
    {
        // 字典里没有数据
        if (!((NSDictionary *)data).count) handlerModel.isNilData = YES;
    }
    else if ([data isKindOfClass:[NSArray class]])
    {
        // 数组里没有数据
        if (!((NSArray *)data).count) handlerModel.isNilData = YES;
    }
    
    // 提取消息
    handlerModel.msg = responseObject[@"msg"];
    
    if (!handlerModel.isSuccess)
    {
        [DVVResponseHandler handleFailureWithError:handlerModel.error
                                               msg:handlerModel.msg
                                               api:api];
    }
    
    // 在这里统一打印数据
    DVVNWLog(@"responseObject: \n%@\n", responseObject);
    DVVNWLog(@"\nisSuccess: %zi  isNilData: %zi  msg: %@\n", handlerModel.isSuccess, handlerModel.isNilData, handlerModel.msg);
    DVVNWLog(@"\napi: %@\n", api);
    
    return handlerModel;
}

/**
 *  处理 failure
 *
 *  @param error error
 *  @param msg   message
 *  @param api   api
 */
+ (void)handleFailureWithError:(NSError *)error
                           msg:(NSString *)msg
                           api:(NSString *)api
{
    DVVNWLog(@"%@", api);
    // 这里过滤不弹Toast的Api
    if (![api isEqualToString:@"这里填写不弹Toast的Api"] &&
        ![api isEqualToString:@"这里填写不弹Toast的Api"])
    {
        // 显示错误消息
        if (msg && msg.length)
        {
            [DVVToast showMessage:msg];
        }
        else
        {
            [DVVToast showMessage:@"请求失败"];
        }
    }
}

@end
