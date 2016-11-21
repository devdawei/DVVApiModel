//
//  DVVApiModel.h
//  DVVApiModel
//
//  Created by 大威 on 16/9/11.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVEmptyView.h"
#import "DVVApiModelConst.h"
#import "DVVApiModelNetwork.h"

typedef void (^DVVApiModelHandlerBlock)(id obj);

@interface NSObject (DVVApiModel)

#pragma mark - 扩展的属性

/**  用于加载第几页的页数标示 */
@property (nonatomic, assign) NSInteger dvv_index;
/**  每一页的请求数量 */
@property (nonatomic, assign) NSInteger dvv_number;

/** 是否显示Loading (默认值: YES) */
@property (nonatomic, assign) BOOL dvv_isShowLoading;
/** 当加载网络时，在这个View上显示Loading */
@property (nonatomic, weak) UIView *dvv_showLoadingView;

/** 当网络错误时，在这个View上显示网络错误提示页面 */
@property (nonatomic, weak) UIView *dvv_showFailureView;
/** 当网络错误时，根据这个类型加载错误提示页面 */
@property (nonatomic, assign) DVVEmptyViewType dvv_emptyViewType;
/** 不设置 showFailureView 时，错误提示页面是否可以显示到 showLoadingView 上 (默认值: NO) */
@property (nonatomic, assign) BOOL dvv_failureViewCanAddToLoadingView;

/** 刷新或加载数据的TableView (当网络成功或失败后结束刷新或加载状态) */
@property (nonatomic, weak) UITableView *dvv_refreshTableView;

/** 如果是在 TableView 上显示 Loading 当用户手动刷新或加载的时候，一般不需要再显示 Loading
 * 配置这个值用来确保只显示一次 Loading (默认值: NO) */
@property (nonatomic, assign) BOOL dvv_onlyShowOnceLoading;
/** 是否已经显示过 Loading (这个值只在设置了 dvv_onlyShowOnceLoading 的时候才有效) */
@property (nonatomic, assign) BOOL dvv_didShowLoading;

#pragma mark - 接口

/**
 *  刷新时的网络请求
 */
- (void)dvv_networkRequestRefresh;

/**
 *  加载时的网络请求
 */
- (void)dvv_networkRequestLoadMore;

/**
 *  根据第几页和是否是刷新状态来处理数据
 *
 *  @param index          第几页
 *  @param requestType    请求的类型 (刷新、加载更多)
 */
- (void)dvv_networkRequestWithIndex:(NSInteger)index
                        requestType:(DVVNetworkRequestType)requestType;

#pragma mark - 设置回调

/**
 *  设置成功的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkSuccessHandler:(DVVApiModelHandlerBlock)handler;

/**
 *  设置失败的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkFailureHandler:(DVVApiModelHandlerBlock)handler;

/**
 *  设置刷新成功的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkRefreshSuccessHandler:(DVVApiModelHandlerBlock)handler;

/**
 *  设置刷新失败的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkRefreshFailureHandler:(DVVApiModelHandlerBlock)handler;

/**
 *  设置加载成功的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkLoadMoreSuccessHandler:(DVVApiModelHandlerBlock)handler;

/**
 *  设置加载失败的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkLoadMoreFailureHandler:(DVVApiModelHandlerBlock)handler;

/**
 *  设置成功或失败都调用的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkCallBackHandler:(DVVApiModelHandlerBlock)handler;

/**
 *  设置服务器返回的数据为空时的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkNilDataHandler:(DVVApiModelHandlerBlock)handler;

/**
 *  设置上拉加载没有更多数据的回调
 *
 *  @param handlerBlock DVVApiModelHandlerBlock
 */
- (void)dvv_setNetworkNoMoreDataHandler:(DVVApiModelHandlerBlock)handler;

#pragma mark - 调用回调

/**
 *  调用成功的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkSuccess:(id)obj;

/**
 *   调用失败的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkFailure:(id)obj;

/**
 *   调用刷新成功的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkRefreshSuccess:(id)obj;

/**
 *   调用刷新失败的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkRefreshFailure:(id)obj;

/**
 *   调用加载成功的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkLoadMoreSuccess:(id)obj;

/**
 *   调用加载失败的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkLoadMoreFailure:(id)obj;

/**
 *   成功或失败都调用的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkCallBack:(id)obj;

/**
 *   服务器返回的数据为空时的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkNilData:(id)obj;

/**
 *   上拉加载没有更多数据的回调
 *
 *  @param obj 如果 obj 为空，则默认传 self
 */
- (void)dvv_networkNoMoreData:(id)obj;

@end
