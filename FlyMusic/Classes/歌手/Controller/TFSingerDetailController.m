//
//  TFSingerDetailController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/22.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSingerDetailController.h"
#import "TFSingerDetailCell.h"
#import "TFCommentDetailController.h"

@interface TFSingerDetailController ()
/*** 歌手列表 ***/
@property (nonatomic ,strong) NSMutableArray<TFSingerDetail *> *singerDetail;
@end

@implementation TFSingerDetailController
/** cell的重用标识 */
static NSString * const singerDetailID = @"singerDetailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.objectInfo.columnTitle;
    
    [self setupTabelView];
    [self loadSingerDetailContent];
}

- (void)loadSingerDetailContent
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"columnId"] = self.objectInfo.columnId;
    params[@"count"] = @"100";
    params[@"isRetrying"] = @"0";
    params[@"needAll"] = @"0";
    params[@"needSimple"] = @"0";
    params[@"needStatus"] = @"1";
    params[@"start"] = @"1";
    params[@"ua"] = @"Ios_migu";
    params[@"version"] = @"5.0.6";
    
    [TFNetworkTools getResultWithUrl:@"querycontentbyId.do" params:params success:^(id responseObject) {
        
        NSDictionary *dic = [responseObject objectForKey:@"columnInfo"];
        weakSelf.singerDetail = [TFSingerDetail mj_objectArrayWithKeyValuesArray:dic[@"contents"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (void)setupTabelView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFSingerDetailCell class]) bundle:nil] forCellReuseIdentifier:singerDetailID];
    
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.singerDetail.count - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFSingerDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:singerDetailID];
    cell.singerDetail = self.singerDetail[indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TFCommentDetailController *commentDetailVC = [[TFCommentDetailController alloc] init];
    
    [self.navigationController pushViewController:commentDetailVC animated:YES];
}
@end
