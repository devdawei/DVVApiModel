//
//  DVVApiModel.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/11.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVApiModel.h"
#import <objc/runtime.h>
#import "DVVApiModelNetworkHandler.h"

static char dvv_kIndex;
static char dvv_kNumber;
static char dvv_kIsShowLoading;
static char dvv_kShowLoadingView;
static char dvv_kShowFailureView;
static char dvv_kEmptyViewType;
static char dvv_kFailureViewCanAddToLoadingView;
static char dvv_kRefreshTableView;
static char dvv_kOnlyShowOnceLoading;
static char dvv_kDidShowLoading;

static char dvv_kSuccess;
static char dvv_kFailure;

static char dvv_kRefreshSuccess;
static char dvv_kRefreshFailure;

static char dvv_kLoadMoreSuccess;
static char dvv_kLoadMoreFailure;

static char dvv_kCallBack;
static char dvv_kNilData;
static char dvv_kNoMoreData;

@implementation NSObject (DVVApiModel)

@dynamic dvv_index;
@dynamic dvv_number;
@dynamic dvv_isShowLoading;
@dynamic dvv_showLoadingView;
@dynamic dvv_showFailureView;
@dynamic dvv_emptyViewType;
@dynamic dvv_failureViewCanAddToLoadingView;
@dynamic dvv_refreshTableView;

#pragma mark - 接口

/**
 *  刷新时的网络请求
 */
- (void)dvv_networkRequestRefresh
{
    
}

/**
 *  加载时的网络请求
 */
- (void)dvv_networkRequestLoadMore
{
    
}

/**
 *  根据第几页和是否是刷新状态来处理数据
 *
 *  @param index          第几页
 *  @param requestType    请求的类型 (刷新、加载更多)
 */
- (void)dvv_networkRequestWithIndex:(NSInteger)index
                        requestType:(DVVNetworkRequestType)requestType
{
    
}

#pragma mark - 设置回调

/**
 *  设置成功的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkSuccessHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kSuccess handler:handler];
}

/**
 *  设置失败的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkFailureHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kFailure handler:handler];
}

/**
 *  设置刷新成功的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkRefreshSuccessHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kRefreshSuccess handler:handler];
}

/**
 *  设置刷新失败的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkRefreshFailureHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kRefreshFailure handler:handler];
}

/**
 *  设置加载成功的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkLoadMoreSuccessHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kLoadMoreSuccess handler:handler];
}

/**
 *  设置加载失败的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkLoadMoreFailureHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kLoadMoreFailure handler:handler];
}

/**
 *  设置成功或失败都调用的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkCallBackHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kCallBack handler:handler];
}

/**
 *  设置服务器返回的数据为空时的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkNilDataHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kNilData handler:handler];
}

/**
 *  设置上拉加载没有更多数据的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkNoMoreDataHandler:(DVVApiModelHandlerBlock)handler
{
    [self dvv_configNetworkHandlerWithKey:&dvv_kNoMoreData handler:handler];
}

- (void)dvv_configNetworkHandlerWithKey:(char *)key
                                handler:(DVVApiModelHandlerBlock)handler
{
    objc_setAssociatedObject(self, key, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - 调用回调

/**
 *  调用成功的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkSuccess:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kSuccess obj:obj];
}

/**
 *   调用失败的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkFailure:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kFailure obj:obj];
}

/**
 *   调用刷新成功的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkRefreshSuccess:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kRefreshSuccess obj:obj];
    
    [self dvv_headerEndRefreshing]; // header 结束刷新
}

/**
 *   调用刷新失败的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkRefreshFailure:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kRefreshFailure obj:obj];
    
    [self dvv_headerEndRefreshing]; // header 结束刷新
}

/**
 *   调用加载成功的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkLoadMoreSuccess:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kLoadMoreSuccess obj:obj];
    
    [self dvv_footerEndRefreshing]; // footer 结束刷新
}

/**
 *   调用加载失败的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkLoadMoreFailure:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kLoadMoreFailure obj:obj];
    
    [self dvv_footerEndRefreshing]; // footer 结束刷新
}

/**
 *   成功或失败都调用的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkCallBack:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kCallBack obj:obj];
}

/**
 *   服务器返回的数据为空时的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkNilData:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kNilData obj:obj];
}

/**
 *   上拉加载没有更多数据的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkNoMoreData:(id)obj
{
    [self dvv_callNetworkHandlerWithKey:&dvv_kNoMoreData obj:obj];
    
    [self dvv_handleNoMoreData]; // 数据已经加载完了，显示没有更多数据
}

- (void)dvv_callNetworkHandlerWithKey:(char *)key
                                  obj:(id)obj
{
    id associatedObj = objc_getAssociatedObject(self, key);
    if (associatedObj)
    {
        if (obj) ((DVVApiModelHandlerBlock)associatedObj)(obj);
        else ((DVVApiModelHandlerBlock)associatedObj)(self);
    }
}

#pragma mark - 扩展的属性

- (void)setDvv_index:(NSInteger)dvv_index
{
    objc_setAssociatedObject(self, &dvv_kIndex, @(dvv_index), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)dvv_index
{
    return [objc_getAssociatedObject(self, &dvv_kIndex) integerValue];
}

- (void)setDvv_number:(NSInteger)dvv_number
{
    objc_setAssociatedObject(self, &dvv_kNumber, @(dvv_number), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)dvv_number
{
    return [objc_getAssociatedObject(self, &dvv_kNumber) integerValue];
}

- (void)setDvv_isShowLoading:(BOOL)dvv_isShowLoading
{
    objc_setAssociatedObject(self, &dvv_kIsShowLoading, @(dvv_isShowLoading), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)dvv_isShowLoading
{
    id obj = objc_getAssociatedObject(self, &dvv_kIsShowLoading);
    if (obj) return [obj boolValue];
    
    return YES; // 默认值
}

- (void)setDvv_showLoadingView:(UIView *)dvv_showLoadingView
{
    objc_setAssociatedObject(self, &dvv_kShowLoadingView, dvv_showLoadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dvv_showLoadingView
{
    return objc_getAssociatedObject(self, &dvv_kShowLoadingView);
}

- (void)setDvv_showFailureView:(UIView *)dvv_showFailureView
{
    objc_setAssociatedObject(self, &dvv_kShowFailureView, dvv_showFailureView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dvv_showFailureView
{
    return objc_getAssociatedObject(self, &dvv_kShowFailureView);
}

- (void)setDvv_emptyViewType:(DVVEmptyViewType)dvv_emptyViewType
{
    objc_setAssociatedObject(self, &dvv_kEmptyViewType, @(dvv_emptyViewType), OBJC_ASSOCIATION_ASSIGN);
}

- (DVVEmptyViewType)dvv_emptyViewType
{
    id obj = objc_getAssociatedObject(self, &dvv_kEmptyViewType);
    if (obj) return [obj integerValue];
    
    return DVVEmptyViewTypeUnknown; // 默认值
}

- (void)setDvv_failureViewCanAddToLoadingView:(BOOL)dvv_failureViewCanAddToLoadingView
{
    objc_setAssociatedObject(self, &dvv_kFailureViewCanAddToLoadingView, @(dvv_failureViewCanAddToLoadingView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)dvv_failureViewCanAddToLoadingView
{
    id obj = objc_getAssociatedObject(self, &dvv_kFailureViewCanAddToLoadingView);
    if (obj) return [obj boolValue];
    
    return NO; // 默认值
}

- (void)setDvv_refreshTableView:(UITableView *)dvv_refreshTableView
{
    objc_setAssociatedObject(self, &dvv_kRefreshTableView, dvv_refreshTableView, OBJC_ASSOCIATION_ASSIGN);
    
    [self dvv_configRefresh]; // 配置刷新控件
}

- (UITableView *)dvv_refreshTableView
{
    return objc_getAssociatedObject(self, &dvv_kRefreshTableView);
}

- (void)setDvv_onlyShowOnceLoading:(BOOL)dvv_onlyShowOnceLoading
{
    objc_setAssociatedObject(self, &dvv_kOnlyShowOnceLoading, @(dvv_onlyShowOnceLoading), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)dvv_onlyShowOnceLoading
{
    id obj = objc_getAssociatedObject(self, &dvv_kOnlyShowOnceLoading);
    if (obj) return [obj boolValue];
    
    return NO; // 默认值
}

- (void)setDvv_didShowLoading:(BOOL)dvv_didShowLoading
{
    objc_setAssociatedObject(self, &dvv_kDidShowLoading, @(dvv_didShowLoading), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)dvv_didShowLoading
{
    id obj = objc_getAssociatedObject(self, &dvv_kDidShowLoading);
    if (obj) return [obj boolValue];
    
    return NO; // 默认值
}

@end
