//
//  OnlyRefreshApiModel.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/15.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "OnlyRefreshApiModel.h"

@implementation OnlyRefreshApiModel

- (void)dvv_networkRequestRefresh
{
    NSDictionary *paramsDict = @{
                                 @"latitude": @"40.096263",
                                 @"longitude": @"116.1270",
                                 @"radius":  @"10000.0",
                                 @"cityname": @"",
                                 @"licensetype": @"",
                                 @"schoolname": @"",
                                 @"ordertype":  @"2",
                                 @"index":  @"1",
                                 @"count":  @"10"
                                 };
    
    [self dvv_getWithPath:@"api/v1/searchschool" parameters:paramsDict success:^(id  _Nullable responseObject, DVVResponseHandler * _Nonnull handler) {
        
        if (handler.isNilData)
        {
            if (_dataArray.count)
            {
                DVVNetworkNoMoreData
            }
            else
            {
                DVVNetworkNilData
            }
            return ;
        }

        NSAssert(nil != responseObject, @"数据不能为空");

        _dataArray = responseObject[@"data"];
        
        DVNetworkSuccess
        
    } failure:^(NSError * _Nonnull error, DVVResponseHandler * _Nonnull handler) {
        
        DVVNetworkFailure
        
    } callBack:^{
        
        DVVNetworkCallBack
        
    }];
}

@end
