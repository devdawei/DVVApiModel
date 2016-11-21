//
//  OnlyRefreshController.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/15.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "OnlyRefreshController.h"
#import "OnlyRefreshApiModel.h"

@interface OnlyRefreshController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) OnlyRefreshApiModel *onlyRefreshApiModel;

@end

@implementation OnlyRefreshController

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
    _onlyRefreshApiModel = [OnlyRefreshApiModel new];
    /* 显示 Loading 的 View */
    _onlyRefreshApiModel.dvv_showLoadingView = self.view;
    /** 当网络错误时，在这个View上显示网络错误提示页面 */
    _onlyRefreshApiModel.dvv_showFailureView = self.view;
    /* 当网络错误时，根据这个类型加载错误提示页面 */
    _onlyRefreshApiModel.dvv_emptyViewType = DVVEmptyViewTypeNoData;
    
    __weak typeof(self) weakSelf = self;
    /* 成功 */
    [_onlyRefreshApiModel dvv_setNetworkSuccessHandler:^(id obj) {
        
        [weakSelf.tableView reloadData];
    }];
    
    /* 失败 */
    [_onlyRefreshApiModel dvv_setNetworkFailureHandler:^(id obj) {
        
    }];
    
    /* 成功或失败都调用 */
    [_onlyRefreshApiModel dvv_setNetworkCallBackHandler:^(id obj) {
        
    }];
    
    /* 数据为空 */
    [_onlyRefreshApiModel dvv_setNetworkNilDataHandler:^(id obj) {
        
    }];
    
    /* 没有更多数据 */
    [_onlyRefreshApiModel dvv_setNetworkNoMoreDataHandler:^(id obj) {
        
    }];
    
    /* 开始请求数据 */
    [_onlyRefreshApiModel dvv_networkRequestRefresh];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _onlyRefreshApiModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"tttttttt";
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
