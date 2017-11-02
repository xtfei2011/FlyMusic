//
//  TFCommentDetailController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentDetailController.h"
#import "TFCommentDetailTopView.h"
#import "TFCommentDetailCell.h"
#import "TFAudioPlayerController.h"

@interface TFCommentDetailController ()
/*** 顶部头视图 ***/
@property (nonatomic ,strong) TFCommentDetailTopView *topView;
/*** 榜单 ***/
@property (nonatomic ,strong) NSMutableArray<TFCommentDetail *> *commentDetail;
@end

@implementation TFCommentDetailController
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
    self.navigationItem.title = self.information.title;
    [self xtf_setNavBarBackgroundImage:[UIImage imageNamed:@"navMessageBg"]];
    [self xtf_setNavBarBackgroundAlpha:0];
}

- (TFCommentDetailTopView *)topView
{
    if (!_topView) {
        _topView = [[TFCommentDetailTopView alloc] initWithFrame:CGRectMake(0, -TopViewHeight, TFMainScreen_Width, TopViewHeight)];
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

- (void)setupTabelView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFCommentDetailCell class]) bundle:nil] forCellReuseIdentifier:commentDetailID];
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(TopViewHeight - 64, 0, 0, 0);
}

- (void)setupTopView
{
    [self.tableView addSubview:self.topView];
}

/*** 获取歌曲列表数据 ***/
- (void)loadDetailContent
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"isRetrying"] = @"0";
    params[@"needSimple"] = @"01";
    params[@"resourceId"] = self.information.musicListId ? self.information.musicListId :self.information.albumId;
    params[@"resourceType"] = self.information.resourceType;
    params[@"ua"] = @"Ios_migu";
    params[@"version"] = @"5.0.6";
    
    [TFNetworkTools getResultWithUrl:@"resourceinfo.do" params:params success:^(id responseObject) {
        [responseObject writeToFile:@"/Users/xietengfei/Desktop/fly_music.plist" atomically:YES];
        weakSelf.commentDetail = [TFCommentDetail mj_objectArrayWithKeyValuesArray:responseObject[@"resource"]];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) { }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentDetail[section].songItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:commentDetailID];
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.songInfo = self.commentDetail[indexPath.section].songItems[indexPath.row];

    self.topView.commentDetail = self.commentDetail[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFAudioPlayerController *playVC = [TFAudioPlayerController sharePlayerViewController];
    
    [playVC initWithArray:self.commentDetail[indexPath.section].songItems index:indexPath.row type:0];
    [self presentViewController:playVC animated:YES completion:nil];
}
@end
