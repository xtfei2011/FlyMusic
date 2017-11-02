//
//  TFClassifyDetailController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/21.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFClassifyDetailController.h"
#import "TFClassifyDetailTopView.h"
#import "TFCommentDetailCell.h"
#import "TFAudioPlayerController.h"

@interface TFClassifyDetailController ()
/*** 顶部头视图 ***/
@property (nonatomic ,strong) TFClassifyDetailTopView *topView;
/*** 榜单 ***/
@property (nonatomic ,strong) NSMutableArray<TFClassifyDetail *> *classifyDetail;
@end

@implementation TFClassifyDetailController

/** cell的重用标识 */
static NSString * const commentDetailID = @"commentDetailCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavigationItem];
    
    [self setupTabelView];
    [self setupTopView];
    [self loadDetailContent];
}

- (void)setupNavigationItem
{
    self.navigationItem.title = self.classify.objectInfo.columnTitle;
    [self xtf_setNavBarBackgroundImage:[UIImage imageNamed:@"navMessageBg"]];
    [self xtf_setNavBarBackgroundAlpha:0];
}

- (TFClassifyDetailTopView *)topView
{
    if (!_topView) {
        _topView = [[TFClassifyDetailTopView alloc] initWithFrame:CGRectMake(0, -TopViewHeight, TFMainScreen_Width, TopViewHeight)];
        _topView.contentMode = UIViewContentModeScaleAspectFill;
        _topView.clipsToBounds = YES;
    }
    return _topView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > Color_Variation_Point) {
        
        CGFloat alpha = (offsetY - Color_Variation_Point) / NavHeight;
        
        [self xtf_setNavBarBackgroundAlpha:alpha];
    } else {
        [self xtf_setNavBarBackgroundAlpha:0];
    }
    
    //限制下拉的距离
    if(offsetY < Limit_Offset_Y) {
        [scrollView setContentOffset:CGPointMake(0, Limit_Offset_Y)];
    }
    
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if (newOffsetY < -TopViewHeight) {
        self.topView.frame = CGRectMake(0, newOffsetY, TFMainScreen_Width, -newOffsetY);
    }
}

- (void)setupTopView
{
    [self.tableView addSubview:self.topView];
}

- (void)setupTabelView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFCommentDetailCell class]) bundle:nil] forCellReuseIdentifier:commentDetailID];
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

/*** 获取歌曲列表数据 ***/
- (void)loadDetailContent
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"columnId"] = self.classify.contentId;
    params[@"count"] = @"100";
    params[@"isRetrying"] = @"0";
    params[@"needAll"] = @"0";
    params[@"needSimple"] = @"0";
    params[@"needStatus"] = @"1";
    params[@"start"] = @"1";
    params[@"ua"] = @"Ios_migu";
    params[@"version"] = @"5.0.6";
    
    [TFNetworkTools getResultWithUrl:@"querycontentbyId.do" params:params success:^(id responseObject) {
        TFLog(@"--->%@",responseObject);
        NSDictionary *dic = [responseObject objectForKey:@"columnInfo"];
        weakSelf.classifyDetail = [TFClassifyDetail mj_objectArrayWithKeyValuesArray:dic[@"contents"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classifyDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:commentDetailID];
    cell.classifyDetail = self.classifyDetail[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFAudioPlayerController *playVC = [TFAudioPlayerController sharePlayerViewController];
    
    [playVC initWithArray:self.classifyDetail index:indexPath.row type:1];
    [self presentViewController:playVC animated:YES completion:nil];
}
@end
