//
//  DVVApiModelNetworkHandler.m
//  DVVApiModel
//
//  Created by 大威 on 2016/9/14.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVApiModelNetworkHandler.h"
#import "DVVApiModelConst.h"
#import "DVVApiModel.h"
#import "DVVLoading.h"
#import <MJRefresh/MJRefresh.h>

@implementation NSObject (DVVApiModelNetworkHandler)

/**
 *  网络开始请求调用
 */
- (void)dvv_handleNetworkBeginRequest
{
    // 移除错误提示视图
    if (self.dvv_showFailureView)
    {
        [self dvv_removeFailureView:self.dvv_showFailureView];
    }
    else if (self.dvv_showLoadingView && self.dvv_failureViewCanAddToLoadingView)
    {
        [self dvv_removeFailureView:self.dvv_showLoadingView];
    }
    
    if (self.dvv_isShowLoading && self.dvv_showLoadingView)
    {
        void (^showLoading)() = ^{
            // 加载Loading
            [DVVLoading showFromView:self.dvv_showLoadingView];
        };
        
        if (self.dvv_onlyShowOnceLoading)
        {
            if (!self.dvv_didShowLoading) showLoading(); // 加载Loading
        }
        else
        {
            showLoading(); // 加载Loading
        }
    }
}

/**
 *  成功或失败都调用
 */
- (void)dvv_handleNetworkCallBack
{
    DVVNetworkCallBack
    
    if (self.dvv_isShowLoading && self.dvv_showLoadingView)
    {
        /* 移除Loading */
        void (^hideLoading)() = ^{
            [DVVLoading hideFromView:self.dvv_showLoadingView];
        };
        
        if (self.dvv_onlyShowOnceLoading)
        {
            if (!self.dvv_didShowLoading)
            {
                self.dvv_didShowLoading = YES; // 标记已经显示过 Loading
                hideLoading(); // 移除Loading
            }
        }
        else
        {
            hideLoading(); // 移除Loading
        }
        
    }
}

/**
 *  网络出错
 *
 *  @param error error
 */
- (void)dvv_handleNetworkFailure:(NSError *)error
{
    // 显示错误提示视图
    if (self.dvv_showFailureView)
    {
        [self dvv_addFailureView:self.dvv_showFailureView];
    }
    else if (self.dvv_showLoadingView && self.dvv_failureViewCanAddToLoadingView)
    {
        [self dvv_addFailureView:self.dvv_showLoadingView];
    }
    
    [self dvv_handleNetworkCallBack];
    DVVNetworkFailure
}

/**
 *  添加错误提示视图
 *
 *  @param view 将错误提示视图添加到这个 view 上面
 */
- (void)dvv_addFailureView:(UIView *)view
{
    DVVEmptyView *emptyView = [[DVVEmptyView alloc] initWithType:self.dvv_emptyViewType];
    emptyView.buttonTitle = @"点击重试";
    [emptyView addButtonClickTarget:self action:@selector(emptyButtonClickAction:)];
    [emptyView showFrom:view];
}

- (void)dvv_removeFailureView:(UIView *)view
{
    for (UIView *itemView in view.subviews)
    {
        if ([itemView isKindOfClass:[DVVEmptyView class]])
        {
            [itemView removeFromSuperview];
            return;
        }
    }
}

- (void)emptyButtonClickAction:(UIButton *)sender
{
    [self dvv_networkRequestRefresh];
}

/**
 *  配置刷新控件
 */
- (void)dvv_configRefresh
{
    __weak typeof(self) weakSelf = self;
    /* 刷新数据 */
    self.dvv_refreshTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf dvv_networkRequestRefresh];
        /* 每次刷新的时候，如果footer的状态显示的是没有更多数据，将 footer 的状态置为正常 */
        MJRefreshState state = weakSelf.dvv_refreshTableView.mj_footer.state;
        if (MJRefreshStateNoMoreData == state)
        {
            weakSelf.dvv_refreshTableView.mj_footer.state = MJRefreshStateIdle;
        }
    }];
    
    /* 加载数据 */
    self.dvv_refreshTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf dvv_networkRequestLoadMore];
    }];
}

/**
 *  header 结束刷新
 */
- (void)dvv_headerEndRefreshing
{
    [self.dvv_refreshTableView.mj_header endRefreshing];
}

/**
 *  footer 结束刷新
 */
- (void)dvv_footerEndRefreshing
{
    [self.dvv_refreshTableView.mj_footer endRefreshing];
}

/**
 *  数据已经加载完了，显示没有更多数据
 */
- (void)dvv_handleNoMoreData
{
    self.dvv_refreshTableView.mj_footer.state = MJRefreshStateNoMoreData;
}

@end
