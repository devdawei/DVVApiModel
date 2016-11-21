//
//  EmptyApiModel.m
//  DVVApiModel
//
//  Created by 大威 on 2016/9/17.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "EmptyApiModel.h"

@implementation EmptyApiModel

- (void)dvv_networkRequestRefresh
{
    NSDictionary *paramsDict = @{
//                                 @"latitude": @(_latitude),
//                                 @"longitude": @(_longitude),
//                                 @"radius":  [NSString stringWithFormat:@"%zi", _radius],
//                                 @"cityname": _cityName,
//                                 @"licensetype": @"",
//                                 @"schoolname": _searchName,
//                                 @"ordertype":  [NSString stringWithFormat:@"%zi", _sortType],
//                                 @"index":  [NSString stringWithFormat:@"%zi", self.dvv_index],
//                                 @"count":  [NSString stringWithFormat:@"%zi", self.dvv_number]
                                 };
    
    [self dvv_getWithPath:@"api/v1/searchschool" parameters:paramsDict success:^(id  _Nullable responseObject, DVVResponseHandler * _Nonnull handler) {
        
//        if (isNilData)
//        {
//            if (_dataArray.count)
//            {
//                DVVNetworkNoMoreData
//            }
//            else
//            {
//                DVVNetworkNilResponseObject
//            }
//            return ;
//        }
//        
//        NSAssert(nil != responseObject, @"数据不能为空");
//        
//        NSArray *array = responseObject[@"data"];
//        if (DVVNetworkRequestTypeRefresh == requestType)
//        {
//            _dataArray = array.mutableCopy;
//        }
//        else if (DVVNetworkRequestTypeLoadMore == requestType)
//        {
//            [_dataArray addObjectsFromArray:array];
//        }
//        
//        DVVNetworkSuccessWithRequestType
        
    } failure:^(NSError * _Nonnull error,  DVVResponseHandler * _Nonnull handler) {
        
        DVVNetworkFailure
        
    } callBack:^{
        
        DVVNetworkCallBack
        
    }];
}

@end
