//
//  TFSingerHeadView.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/22.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSingerHeadView.h"
#import "TFSingerLayout.h"
#import "TFSingerHeadCell.h"

@interface TFSingerHeadView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) TFSingerLayout *singerLayout;
@property (nonatomic ,strong) NSMutableArray<TFHotSinger *> *hotSinger;
@end

@implementation TFSingerHeadView
/** cell的重用标识 */
static NSString * const singerHeadID = @"singerHeadCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = CGRectMake(0, 0, TFMainScreen_Width, 140);
        
        [self setupCollectionView];
    }
    return self;
}

- (void)setupCollectionView
{
    _singerLayout = [[TFSingerLayout alloc] init];
    _singerLayout.itemSize = CGSizeMake(90, 140);
    
    CGFloat collectionW = self.xtf_width;
    CGFloat collectionH = 140;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, collectionW, collectionH) collectionViewLayout:_singerLayout];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TFSingerHeadCell class]) bundle:nil] forCellWithReuseIdentifier:singerHeadID];
}

- (void)setTopSinger:(NSArray *)topSinger
{
    self.hotSinger = [TFHotSinger mj_objectArrayWithKeyValuesArray:topSinger];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.hotSinger.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFSingerHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:singerHeadID forIndexPath:indexPath];
    cell.hotSinger = self.hotSinger[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击的item---%zd",indexPath.item);
}

@end
