//
//  SearchController.m
//  DVVApiModel
//
//  Created by 大威 on 16/9/10.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "SearchController.h"
#import "DVVLoading.h"
#import "SearchApiModel.h"

@interface SearchController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SearchApiModel *searchApiModel;

@end

@implementation SearchController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configApiModel];
}

#pragma mark - ApiModel

- (void)configApiModel
{
    _searchApiModel = [SearchApiModel new];
    /* 显示 Loading 的 View */
    _searchApiModel.dvv_showLoadingView = self.view;
    /* 刷新和加载的 TableView */
    _searchApiModel.dvv_refreshTableView = self.tableView;
    /* 当用户手动刷新或加载的时候，一般不需要再显示 Loading, 配置这个值用来确保只显示一次 Loading */
    _searchApiModel.dvv_onlyShowOnceLoading = YES;
    
    __weak typeof(self) weakSelf = self;
    /* 刷新成功 */
    [_searchApiModel dvv_setNetworkRefreshSuccessHandler:^(id obj) {
        
        [weakSelf.tableView reloadData];
    }];
    
    /* 刷新失败 */
    [_searchApiModel dvv_setNetworkRefreshFailureHandler:^(id obj) {
        
    }];
    
    /* 加载成功 */
    [_searchApiModel dvv_setNetworkLoadMoreSuccessHandler:^(id obj) {
        
        [weakSelf.tableView reloadData];
    }];
    
    /* 加载失败 */
    [_searchApiModel dvv_setNetworkLoadMoreFailureHandler:^(id obj) {
        
        
    }];
    
    /* 成功或失败都调用 */
    [_searchApiModel dvv_setNetworkCallBackHandler:^(id obj) {
        
    }];
    
    /* 数据为空 */
    [_searchApiModel dvv_setNetworkNilDataHandler:^(id obj) {
        
    }];
    
    /* 没有更多数据 */
    [_searchApiModel dvv_setNetworkNoMoreDataHandler:^(id obj) {
        
    }];
    
    /* 开始请求数据 */
    [_searchApiModel dvv_networkRequestRefresh];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchApiModel.dataArray.count;
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
