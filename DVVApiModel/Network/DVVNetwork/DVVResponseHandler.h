//
//  DVVResponseHandler.h
//  DVVApiModel
//
//  Created by 大威 on 16/9/11.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVVResponseHandler : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, assign) BOOL isNilData;

@property (nonatomic, strong) NSError *error;

@property (nonatomic, copy) NSString *msg;

/**
 *  处理 responseObject 对象
 *
 *  @param responseObject responseObject
 *  @param api            api
 *
 *  @return DVVResponseHandler
 */
+ (DVVResponseHandler *)handleResponse:(id)responseObject
                                   api:(NSString *)api;

/**
 *  处理 failure
 *
 *  @param error error
 *  @param msg   toast msg
 *  @param api   api
 */
+ (void)handleFailureWithError:(NSError *)error
                           msg:(NSString *)msg
                           api:(NSString *)api;

@end
