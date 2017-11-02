//
//  TFRecommendController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFRecommendController.h"
#import "TFTopScrollView.h"
#import "TFScrollViewModel.h"
#import "TFRecommendAudioCell.h"
#import "TFRecommendVideoCell.h"
#import "TFCommentHeadView.h"
#import "TFCommentDetailController.h"

@interface TFRecommendController ()<ClickPushDelegate>
/*** Top 滚动视图 ***/
@property (nonatomic ,strong) TFTopScrollView *topScrollView;
/*** 歌单推荐 ***/
@property (nonatomic ,strong) NSMutableArray<TFRecommend *> *recommend;
/*** 最新音乐 ***/
@property (nonatomic ,strong) NSMutableArray<TFNewMusic *> *latestMusic;
/*** MV歌单 ***/
@property (nonatomic ,strong) NSMutableArray<TFVideo *> *video;
@end

@implementation TFRecommendController
static NSString * const recommendAudioID = @"recommendAudio";
static NSString * const recommendVideoID = @"recommendVideo";
static NSString * const commentHeadID = @"commentHeadView";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupCollectionView];
    [self loadRecommendContent];
    [self setTopScrollView];
}

- (void)setupCollectionView
{
    self.collectionView.backgroundColor = TFCommonBgColor;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TFRecommendAudioCell" bundle:nil] forCellWithReuseIdentifier:recommendAudioID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TFRecommendVideoCell" bundle:nil] forCellWithReuseIdentifier:recommendVideoID];
    /*** 分区头部 ***/
    [self.collectionView registerNib:[UINib nibWithNibName:@"TFCommentHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:commentHeadID];
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = -1;
    layout.minimumLineSpacing = -1;
    return [self initWithCollectionViewLayout:layout];
}

/*** 轮播视图 ***/
- (void)setTopScrollView
{
    _topScrollView = [[TFTopScrollView alloc] initWithFrame:CGRectMake(0, 0, TFMainScreen_Width,ScrollViewHeight)];
    _topScrollView.delegate = self;
    [self.collectionView addSubview:_topScrollView];
}

- (void)loadRecommendContent
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"isRetrying"] = @"0";
    params[@"needAll"] = @"0";
    params[@"ua"] = @"Ios_migu";
    params[@"version"] = @"5.0.6";
    
    [TFNetworkTools getResultWithUrl:@"indexshow.do" params:params success:^(id responseObject) {
        
        TFLog(@"---->%@",responseObject);
        NSDictionary *dic = [responseObject objectForKey:@"columnInfo"];
        NSArray *contents = [dic objectForKey:@"contents"];
        NSDictionary *topDic = [contents objectAtIndex:0];
        
        /*** 轮播 ***/
        [self loadTopScrollViewContent:topDic];
        
        /*** 推荐歌单 ***/
        NSDictionary *recommendDic = [contents objectAtIndex:6];
        NSDictionary *recommendInfo = [recommendDic objectForKey:@"objectInfo"];
        
        weakSelf.recommend = [TFRecommend mj_objectArrayWithKeyValuesArray:recommendInfo[@"contents"]];

        /*** 最新音乐 ***/
        NSDictionary *latestDic = [contents objectAtIndex:10];
        NSDictionary *latestInfo = [latestDic objectForKey:@"objectInfo"];
        
        weakSelf.latestMusic = [TFNewMusic mj_objectArrayWithKeyValuesArray:latestInfo[@"contents"]];
        
        /*** MV歌单 ***/
        NSDictionary *videoDic = [contents objectAtIndex:12];
        NSDictionary *videoInfo = [videoDic objectForKey:@"objectInfo"];
        weakSelf.video = [TFVideo mj_objectArrayWithKeyValuesArray:videoInfo[@"contents"]];

        [weakSelf.collectionView reloadData];
        
    } failure:^(NSError *error) { TFLog(@"---->%@",error); }];
}

/*** 获取轮播图数据 ***/
- (void)loadTopScrollViewContent:(NSDictionary *)topContent
{
    NSDictionary *info = [topContent objectForKey:@"objectInfo"];
    NSArray *bannersArr = [info objectForKey:@"contents"];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:bannersArr.count];
    
    for (NSDictionary *dict in bannersArr) {
        [array addObject:[[TFScrollViewModel alloc] initWithDict:dict]];
    }
    self.topScrollView.dataSource = array;
    [self.topScrollView startScroll];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) return CGSizeMake(TFMainScreen_Width, ScrollViewHeight + 50);
    
    return CGSizeMake(TFMainScreen_Width, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return CGSizeMake(TFMainScreen_Width/2, (TFMainScreen_Width) * 31/110 + 40);
    }
    return CGSizeMake(TFMainScreen_Width/3, (TFMainScreen_Width)/3 + 35);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.recommend.count;
        
    } else if (section == 1) {
        return self.latestMusic.count - 1;
    } else {
        return self.video.count - 1;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TFCommentHeadView *homeHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:commentHeadID forIndexPath:indexPath];
    homeHeadView.type = indexPath.section;
    return homeHeadView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TFRecommendAudioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendAudioID forIndexPath:indexPath];
        cell.recommend = self.recommend[indexPath.row];
        return cell;
        
    } else if (indexPath.section == 1) {
        TFRecommendAudioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendAudioID forIndexPath:indexPath];
        cell.latestMusic = self.latestMusic[indexPath.row + 1];
        return cell;
        
    } else {
        TFRecommendVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendVideoID forIndexPath:indexPath];
        cell.video = self.video[indexPath.row + 1];
        
        return cell;
    }
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFCommentDetailController *commentDetailVC = [[TFCommentDetailController alloc] init];
    if (indexPath.section == 0) {
        
        commentDetailVC.information = self.recommend[indexPath.row].objectInfo;
    } else if (indexPath.section == 1) {
        
        commentDetailVC.information = self.latestMusic[indexPath.row + 1].objectInfo;
    }
    [self.navigationController pushViewController:commentDetailVC animated:YES];
}
@end
