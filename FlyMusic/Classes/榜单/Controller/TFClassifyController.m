//
//  TFClassifyController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFClassifyController.h"
#import "TFClassifyCell.h"
#import "TFClassifyDetailController.h"

@interface TFClassifyController ()
/*** 榜单 ***/
@property (nonatomic ,strong) NSMutableArray<TFClassify *> *classify;
@end

@implementation TFClassifyController
/** cell的重用标识 */
static NSString * const classifyID = @"classifyCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadClassifyContent];
    [self setupTabelView];
}

- (void)setupTabelView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFClassifyCell class]) bundle:nil] forCellReuseIdentifier:classifyID];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)loadClassifyContent
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"isRetrying"] = @"0";
    params[@"needAll"] = @"0";
    params[@"ua"] = @"Ios_migu";
    params[@"version"] = @"5.0.6";
    
    [TFNetworkTools getResultWithUrl:@"indexrank.do" params:params success:^(id responseObject) {
        
        NSDictionary *data = responseObject[@"columnInfo"];
        weakSelf.classify = [TFClassify mj_objectArrayWithKeyValuesArray:data[@"contents"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classify.count - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:classifyID];
    cell.classify = self.classify[indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TFClassifyDetailController *classifyDetailVC = [[TFClassifyDetailController alloc] init];
    classifyDetailVC.classify = self.classify[indexPath.row + 1];
    [self.navigationController pushViewController:classifyDetailVC animated:YES];
}
@end
