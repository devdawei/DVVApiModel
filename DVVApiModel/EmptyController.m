//
//  EmptyController.m
//  DVVApiModel
//
//  Created by 大威 on 2016/9/17.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "EmptyController.h"
#import "EmptyApiModel.h"

@interface EmptyController ()

@property (nonatomic, strong) EmptyApiModel *emptyApiModel;

@end

@implementation EmptyController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configApiModel];
}

#pragma mark - ApiModel

- (void)configApiModel
{
    _emptyApiModel = [EmptyApiModel new];
    /* 显示 Loading 的 View */
    _emptyApiModel.dvv_showLoadingView = self.view;
    /** 当网络错误时，在这个View上显示网络错误提示页面 */
    _emptyApiModel.dvv_showFailureView = self.view;
    /* 当网络错误时，根据这个类型加载错误提示页面 */
    _emptyApiModel.dvv_emptyViewType = DVVEmptyViewTypeNoData;
    
    /* 成功 */
    [_emptyApiModel dvv_setNetworkSuccessHandler:^(id obj) {
        
    }];
    
    /* 失败 */
    [_emptyApiModel dvv_setNetworkFailureHandler:^(id obj) {
        
    }];
    
    /* 成功或失败都调用 */
    [_emptyApiModel dvv_setNetworkCallBackHandler:^(id obj) {
        
    }];
    
    /* 数据为空 */
    [_emptyApiModel dvv_setNetworkNilDataHandler:^(id obj) {
        
    }];
    
    /* 没有更多数据 */
    [_emptyApiModel dvv_setNetworkNoMoreDataHandler:^(id obj) {
        
    }];
    
    /* 开始请求数据 */
    [_emptyApiModel dvv_networkRequestRefresh];
}

#pragma mark - Memory warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
