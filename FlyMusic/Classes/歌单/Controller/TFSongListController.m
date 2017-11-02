//
//  TFSongListController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSongListController.h"
#import "TFTopScrollView.h"
#import "TFScrollViewModel.h"
#import "TFSongListCell.h"
#import "TFCommentDetailController.h"
#import "TFSongListReusableView.h"

@interface TFSongListController ()
/*** Top 滚动视图 ***/
@property (nonatomic ,strong) TFTopScrollView *topScrollView;
/*** 歌单 ***/
@property (nonatomic, strong) NSMutableArray<TFSong *> *song;
@end

@implementation TFSongListController
/** cell的重用标识 */
static NSString * const songListID = @"songListCell";
static NSString * const songListHeadID = @"songListHeadView";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupCollectionView];
    [self setTopScrollView];
    [self loadSongListContent];
}

- (void)setupCollectionView
{
    self.collectionView.backgroundColor = TFCommonBgColor;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TFSongListCell" bundle:nil] forCellWithReuseIdentifier:songListID];
    /*** 分区头部 ***/
    [self.collectionView registerNib:[UINib nibWithNibName:@"TFSongListReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:songListHeadID];
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
//    _topScrollView.delegate = self;
    [self.collectionView addSubview:_topScrollView];
}

- (void)loadSongListContent
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"isRetrying"] = @"0";
    params[@"needAll"] = @"0";
    params[@"ua"] = @"Ios_migu";
    params[@"version"] = @"5.0.6";
    
    [TFNetworkTools getResultWithUrl:@"indexmusiclist.do" params:params success:^(id responseObject) {
        
        NSDictionary *dic = [responseObject objectForKey:@"columnInfo"];
        NSArray *contents = [dic objectForKey:@"contents"];
        NSDictionary *topDic = [contents objectAtIndex:0];
        
        /*** 轮播 ***/
        [self loadTopScrollViewContent:topDic];
        
        /*** 歌单列表 ***/
        NSDictionary *recommendDic = [contents objectAtIndex:2];
        NSDictionary *recommendInfo = [recommendDic objectForKey:@"objectInfo"];
        weakSelf.song = [TFSong mj_objectArrayWithKeyValuesArray:recommendInfo[@"contents"]];

        [weakSelf.collectionView reloadData];
        
    } failure:^(NSError *error) { }];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(TFMainScreen_Width, ScrollViewHeight + 60);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(TFMainScreen_Width/2, (TFMainScreen_Width)/2 + 20);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.song.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TFSongListReusableView *homeHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:songListHeadID forIndexPath:indexPath];
    homeHeadView.frame = CGRectMake(0, ScrollViewHeight + 9.5, TFMainScreen_Width, 50);
    
    return homeHeadView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFSongListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:songListID forIndexPath:indexPath];
    cell.song = self.song[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFCommentDetailController *commentDetailVC = [[TFCommentDetailController alloc] init];
    commentDetailVC.information = self.song[indexPath.row].objectInfo;
    
    [self.navigationController pushViewController:commentDetailVC animated:YES];
}
@end
