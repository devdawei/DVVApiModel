//
//  SearchApiModel.m
//  DVVApiModel
//
//  Created by 大威 on 2016/9/14.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "SearchApiModel.h"

@implementation SearchApiModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _dataArray = [NSMutableArray array];
        _sortType = SearchSchoolSortTypeDefault;
        _latitude = 40.096263;
        _longitude = 116.1270;
        
        _radius = 10000.0;
        _cityName = [NSString string];
        _searchName = [NSString string];
        
        self.dvv_index = 1;
        self.dvv_number = 10;
    }
    return self;
}

- (void)dvv_networkRequestRefresh
{
    [self dvv_networkRequestWithIndex:self.dvv_index = 1 requestType:DVVNetworkRequestTypeRefresh];
}

- (void)dvv_networkRequestLoadMore
{
    [self dvv_networkRequestWithIndex:++self.dvv_index requestType:DVVNetworkRequestTypeLoadMore];
}

- (void)dvv_networkRequestWithIndex:(NSInteger)index requestType:(DVVNetworkRequestType)requestType
{
    NSDictionary *paramsDict = @{
                                 @"latitude": @(_latitude),
                                 @"longitude": @(_longitude),
                                 @"radius":  [NSString stringWithFormat:@"%zi", _radius],
                                 @"cityname": _cityName,
                                 @"licensetype": @"",
                                 @"schoolname": _searchName,
                                 @"ordertype":  [NSString stringWithFormat:@"%zi", _sortType],
                                 @"index":  [NSString stringWithFormat:@"%zi", self.dvv_index],
                                 @"count":  [NSString stringWithFormat:@"%zi", self.dvv_number]
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
        
        NSArray *array = responseObject[@"data"];
        if (DVVNetworkRequestTypeRefresh == requestType)
        {
            _dataArray = array.mutableCopy;
        }
        else if (DVVNetworkRequestTypeLoadMore == requestType)
        {
            [_dataArray addObjectsFromArray:array];
        }
        
        DVVNetworkSuccessWithRequestType
        
    } failure:^(NSError * _Nonnull error, DVVResponseHandler * _Nonnull handler) {
        
        DVVNetworkFailureWithRequestType
        
    } callBack:^{
        
        DVVNetworkCallBack
        
    }];
}

@end
