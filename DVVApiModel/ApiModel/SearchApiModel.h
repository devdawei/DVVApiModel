//
//  SearchApiModel.h
//  DVVApiModel
//
//  Created by 大威 on 2016/9/14.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVVApiModel.h"

/** 搜索驾校的排序类型 */
typedef NS_ENUM(NSUInteger, SearchSchoolSortType)
{
    /** 默认 */
    SearchSchoolSortTypeDefault = 0,
    /** 距离 */
    SearchSchoolSortTypeDistance,
    /** 评分 */
    SearchSchoolSortTypeScore,
    /** 价格 */
    SearchSchoolSortTypePrice
};

@interface SearchApiModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

// 搜索参数
/** 车型选择(服务器返回类型) */
@property (nonatomic, assign) NSInteger licenseType;
/** 排序类型 */
@property (nonatomic, assign) SearchSchoolSortType sortType;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

// 可选
/** 范围 */
@property (nonatomic, assign) NSInteger radius;
/** 城市名称 */
@property (nonatomic, copy) NSString *cityName;
/** 搜索名字 */
@property (nonatomic, copy) NSString *searchName;


@end
