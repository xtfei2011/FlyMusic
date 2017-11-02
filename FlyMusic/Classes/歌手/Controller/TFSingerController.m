//
//  TFSingerController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSingerController.h"
#import "TFSingerListCell.h"
#import "TFSingerHeadView.h"
#import "TFHotSinger.h"
#import "TFSingerDetailController.h"

@interface TFSingerController ()
/*** 小编推荐 ***/
@property (nonatomic ,strong) NSMutableArray<TFSinger *> *singer;
@property (nonatomic ,strong) NSMutableArray *hotSinger;
@property (nonatomic ,strong) TFSingerHeadView *singHeadView;
@end

@implementation TFSingerController
/** cell的重用标识 */
static NSString * const singerListID = @"singerListCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTabelView];
    [self setSingerHeadView];
    [self loadSingerListContent];
}

- (void)setupTabelView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFSingerListCell class]) bundle:nil] forCellReuseIdentifier:singerListID];
    
    self.tableView.rowHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setSingerHeadView
{
    _singHeadView = [[TFSingerHeadView alloc] init];
    self.tableView.tableHeaderView = _singHeadView;
}

- (void)loadSingerListContent
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"columnId"] = @"15044676";
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
        NSArray *contents = [dic objectForKey:@"contents"];
        NSDictionary *topDic = [contents objectAtIndex:0];
        NSDictionary *dict = [topDic objectForKey:@"objectInfo"];
        weakSelf.hotSinger = [NSMutableArray mj_objectArrayWithKeyValuesArray:dict[@"contents"]];
        _singHeadView.topSinger = _hotSinger;
        
        weakSelf.singer = [TFSinger mj_objectArrayWithKeyValuesArray:dic[@"contents"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 2 ? 1 : 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFSingerListCell *cell = [tableView dequeueReusableCellWithIdentifier:singerListID];
    
    if (indexPath.section == 0) {
        cell.singer = self.singer[indexPath.row + 1];
    } else if (indexPath.section == 1) {
        cell.singer = self.singer[indexPath.row + 4];
    } else {
        cell.singer = self.singer[indexPath.row + 7];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TFSingerDetailController *singerDetail = [[TFSingerDetailController alloc] init];
    
    if (indexPath.section == 0) {
        singerDetail.objectInfo = self.singer[indexPath.row + 1].objectInfo;
    } else if (indexPath.section == 1) {
        singerDetail.objectInfo = self.singer[indexPath.row + 4].objectInfo;
    } else {
        singerDetail.objectInfo = self.singer[indexPath.row + 7].objectInfo;
    }
    [self.navigationController pushViewController:singerDetail animated:YES];
}
@end
