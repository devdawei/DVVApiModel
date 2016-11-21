//
//  DVVApiModelConst.h
//  DVVApiModel
//
//  Created by 大威 on 2016/9/14.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DVVNetworkRequestType)
{
    /** 刷新数据 */
    DVVNetworkRequestTypeRefresh = 0,
    /** 加载更多数据 */
    DVVNetworkRequestTypeLoadMore
};

/** 调用成功的回调 */
#define DVNetworkSuccess [self dvv_networkSuccess:self];
/** 调用失败的回调 */
#define DVVNetworkFailure [self dvv_networkFailure:self];

/** 根据请求类型调用刷新成功或加载成功的回调 */
#define DVVNetworkSuccessWithRequestType \
if (DVVNetworkRequestTypeRefresh == requestType)\
{\
    [self dvv_networkRefreshSuccess:self];\
}\
else if (DVVNetworkRequestTypeLoadMore == requestType)\
{\
    [self dvv_networkLoadMoreSuccess:self];\
}

/** 根据请求类型调用刷新失败或加载失败的回调 */
#define DVVNetworkFailureWithRequestType \
if (DVVNetworkRequestTypeRefresh == requestType)\
{\
    [self dvv_networkRefreshFailure:self];\
}\
else if (DVVNetworkRequestTypeLoadMore == requestType)\
{\
    [self dvv_networkLoadMoreFailure:self];\
}

/** 调用刷新成功的回调 */
#define DVVNetworkRefreshSuccess [self dvv_networkRefreshSuccess:self];
/** 调用刷新失败的回调 */
#define DVVNetworkRefreshFailure [self dvv_networkRefreshFailure:self];

/** 调用加载成功的回调 */
#define DVVNetworkLoadMoreSuccess [self dvv_networkLoadMoreSuccess:self];
/** 调用加载失败的回调 */
#define DVVNetworkLoadMoreFailure [self dvv_networkLoadMoreFailure:self];

/** 调用成功或失败都调用的回调 */
#define DVVNetworkCallBack [self dvv_networkCallBack:self];

/** 调用服务器返回的数据为空时的回调 */
#define DVVNetworkNilData [self dvv_networkNilData:self];

/** 调用上拉加载没有更多数据的回调 */
#define DVVNetworkNoMoreData [self dvv_networkNoMoreData:self];


// NSLog
#ifdef DEBUG

#define DVVAMLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

#define DVVAMLog( s, ... )

#endif

@interface DVVApiModelConst : NSObject

@end
